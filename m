Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTDXL5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDXL5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:57:33 -0400
Received: from mta01.telering.at ([212.95.31.38]:38883 "EHLO smtp.telering.at")
	by vger.kernel.org with ESMTP id S263548AbTDXL52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:57:28 -0400
Date: Thu, 24 Apr 2003 13:12:42 +0200
From: Bernhard Kaindl <kaindl@telering.at>
X-X-Sender: bkaindl@hase.a11.local
To: linux-kernel@vger.kernel.org
Cc: Bernhard Kaindl <bk@suse.de>
Subject: [ptrace] Description of the main part of kmod/ptrace fix
Message-ID: <Pine.LNX.4.53.0304241242410.2190@hase.a11.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   AFAIK(please point me in the right direction if I've missed it) none
of the makers of the kmod/ptrace fix supplied documentation about how the
fix works and what it changes.

I feel the need because it introduced side effects which should be fixed
before 2.4.21 is released.

Below, I'm explaining how the ptrace patch posted by Alan which is also
included in 2.4.21-rc1 works:

You have to think SMP here, the fix for single CPU only(without preempt)
would have been simpler, but a correct fix has to take true symmetric
multiprocessing into account:

SMP is the reason why the task->task_dumpable flag is needed, which plays
the major role in the fix. It is 0 for all kernel threads created by the
new kernel_thread function, otherwise it's 1.

task->ptrace is the other important flag. It is used to indicate wether
task is being traced. It gets a bit set when a tracer attaches to the
task and if task->ptrace is 0, a tracer has to attach to the process
again to be able to trace.

In the ptrace fix, these flags are surrounded by the spinlock for the
task which serializes SMP access to a task's task_struct(which holds
these flags).

This spinlock also serves as a memory barrier between the CPUs, so if
two parts of the kernel surround their code with the task_lock for this
task, the two code parts are serialized for SMP(the other CPU just spins
in place to wait until the other gives it free) and the changes made by
one CPU while it's holding the task_lock are visible in the other place
also if it acquires the task_lock of this task before checking flags.

Ok, that's the basic information what is important for the fix. With these
tools at hand, you can serialize the ptrace_attach(which attachs a tracer
to a not yet traced task, marks it traced and stops it) and the creation
of a kernel_thread(like a fork, but the child is a privilged thread) e.g.
to execute modprobe.

If the functions which do these operations hold the task_lock of the task
they work on, they can serialize the ptrace_attach to the task and the
fork of a kernel thread from the task. This SMP serialisation is the key
to be able to safely check the status of the task and reject the fork
if a kernel thread from the task if the task is being traced and also
reject the ptrace_attach if the task attempted to attach to is a kernel
thread.

This alone is the core of the security fix. If you can't fork a
kernel thread from a traced process and you can't attach to a
kernel thread, you are effectively blocked out from any external
ptrace control to a kernel thread.

Let me show you the relevant code of kernel_thread():

        /* lock out any potential ptracer */
spin>   task_lock(task);
check>  if (task->ptrace) {
                task_unlock(task);
exit>           return -EPERM;
        }

        old_task_dumpable = task->task_dumpable;
flag>   task->task_dumpable = 0;
unlock> task_unlock(task);

I've added tags here so you see:

- the take of the task lock:		task_lock(task);
- the check of the task->ptrace flag:   if (task->ptrace) {
  - the exit if task is being traced:         return -EPERM;

Then you see the only place where task_dumpable is set to 0 which
is inherited by the new kernel thread to flag the kernel thread.

And finally you see the unlock of the task's spinlock which blocked
other code, possibly running on antoher CPU, waiting in busy loop
until this task_unlock is executed if it was trying to accesss the
same task.

This corresponding code are these lines in ptrace_check_attach():

spin>   task_lock(task);
        if (task->pid <= 1)
                goto bad;
        if (task == current)
                goto bad;
        if (!task->mm)
                goto bad;
        if(((current->uid != task->euid) ||
            (current->uid != task->suid) ||
            (current->uid != task->uid) ||
            (current->gid != task->egid) ||
            (current->gid != task->sgid) ||
            (!cap_issubset(task->cap_permitted, current->cap_permitted)) ||
            (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
                goto bad;
        rmb();
check>  if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
exit>           goto bad;
        /* the same process cannot be attached many times */
        if (task->ptrace & PT_PTRACED)
                goto bad;

        /* Go */
flag>   task->ptrace |= PT_PTRACED;
        if (capable(CAP_SYS_PTRACE))
                task->ptrace |= PT_PTRACE_CAP;
unlock> task_unlock(task);

Unlike in the code snippnet from kernel_thread(), the variable 'task'
refers to the task to which the tracer (current) wants to attach.

You see the take of the task lock, you see the use of is_dumpable(task)
which checks task->task_dumpable and task->mm->dumpable, and if the tracer
does not have CAP_SYS_PTRACE(root normally only), the ptrace_attach()
is refused and nothing is done.

Thus, if the task which the ptrace_attach is being tried has been created
by kernel_tread, it has task->task_dumpable set to 0 and if the tracer does
not have CAP_SYS_PTRACE(which only root should have), the tracer is refused
from the attach.

Now, ptrace_attach sets the PT_TRACED bit in task->ptrace to to mark
the task being traced and then it releases the task_lock.

The task_lock around the the code parts makes the execution of them
atomic to the other.

Thus, if the above code snippnet from ptrace_attach() runs before the
above code snippnet from kernel_thread() the task->ptrace flag is set
and in this case, kernel_thread bails out.

And as task_lock is a spinlock, any other CPUs which are directed to
run these codes has to spin for the lock before it can enter either
code and the spinlock also acts as a memory barrier for the task_lock,
so
above always see the information which has been updated by the other
so this is even SMP safe and preempt-safe in case you applied the
preempt-Patch for 2.4(the preempt patch must ensure atomic execution
of spinlock-protected code to prevent chaos with preempt).

If the two important flags, task->task_dumpable and task->ptrace
cannot be manipulated by other functions, the code quoted above
is safe and does not need any other code in order to prevent that
an unprivileged user traces a kernel thread and gain privileges
or manipulate kernel behaviour this way.

Now you can say: And if I give a user CAP_SYS_PTRACE? Then he
can do what he wants if I do not more checking!

I say: Yes. If you give a user which you don't trust the capabilty
CAP_SYS_PTRACE, you have just lost your system. Why? Let me tell you:

The documented capability of CAP_SYS_PTRACE is the ability to trace
exec()s of setuid programs, no matter what privilges the traced
process gains from this exec(). As a tracer can do anything he
wants with the process it traces, it can use the privileges of
the traced process at will.

Thus, if you have any setuid-root program in the system which
a user with CAP_SYS_PTRACE can execute, you just gave this user
root, all capabities; the power of god on your system.

There is no security improvement in adding checks to other capabilies,
because a user with CAP_SYS_PTRACE can get all capabilies it want's to
have, it can even modify the kernel if it has the desire then. ;-)

This means that CAP_SYS_PTRACE can be seen equivalent to a
all capabilies capability from a general security view.

This is nothing unusual for capabilies, let me quote what a
security expert said about this:

> ... On the other hand, CAP_SYS_PTRACE is just a very obvious
> example of one capability that can be used to steal additional
> capabilities. Most of the other caps suffer from similar problems
> (CAP_SYS_RAW, CAP_SYS_MODULE, CAP_SYS_ADMIN ...)
>
> POSIX capabilities are mostly decorative (okay, this is an
> over-generalization)

Now you can discuss if we should make CAP_SYS_PTRACE safer in
a way that you cannot gain capabilies from it.

I agree, but I have to tell you that's this would be a separate
discussion, in which we would have to discuss how CAP_SYS_PTRACE
should be reimplemented.

I'll send additional information about this in a separate mail,
we drifted already too far away from the subject of this mail.

Understanding the code I quoted above is the base to know how
the ptrace security fix can be cleaned up in order to fix the
side effects without compromising the kmod/ptrace security.

After some more thinking about it, it became logical to me
that the checks in ptrace_check_attach and access_process_vm
are not needed to fix the ptrace/kmod issue because if
ptrace_attach and kernel_thread block out everything,
a not dumpable thread can never reach ptrace_check_attach
or access_process_vm.

Best Regards,
Bernhard Kaindl
