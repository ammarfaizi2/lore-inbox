Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTDYJCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTDYJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:02:36 -0400
Received: from mta01.telering.at ([212.95.31.38]:37827 "EHLO smtp.telering.at")
	by vger.kernel.org with ESMTP id S263511AbTDYJCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:02:34 -0400
Date: Fri, 25 Apr 2003 10:17:57 +0200
From: Bernhard Kaindl <kaindl@telering.at>
X-X-Sender: bkaindl@hase.a11.local
To: linux-kernel@vger.kernel.org
Subject: [2.4] more side effects of the kmod/ptrace secfix
Message-ID: <Pine.LNX.4.53.0304251016090.2049@hase.a11.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   another side effect is caused by the patch Alan posted is fixed by
the patch to use task_dumpable in ptrace_check_attach:

>   mb();
> - if (!is_dumpable(child))
> + if (!child->task_dumpable)
>  		return -EPERM;

There is a system call called prctl() which can be used set mm->dumpable
of the current task to 0 using the flag PR_SET_DUMPABLE and the arg 0.

Together with the use of is_dumpable() in ptrace_check_attach(), this
can lead to hanging processes in stopped state and not even root can
trace a process which has called prtcl(PR_SET_DUMPABLE, 0).

This is the scenario where it happens:

Task A                              Task B

sys_ptrace(PTRACE_ATTACH, Task B)
				    prctl(PR_SET_DUMPABLE, 0)
sys_ptrace(any action) = -EPERM     Now, Task B is out of control from
				    Task A, but is kept in trace mode.
				    It is left in stopped state if the
				    mode was single stepping or
				    stop on system call.

An other side effect is that prctl(PR_SET_DUMPABLE, 1) is ignored
by Alan's patch. Like RH people, I initiallly thought this is neccesary
but after more close auditing, I think the change which does this
is not neccesary.

It is debatable if prctl(PR_SET_DUMPABLE, 1) should be honored or not,
but it would be nice to have for certain debug scearios where you would
like to be able to get a core file dumped by the kernel of off-site
analysis if the process to be debugged is a setuid program.

Below some documentation about ptrace functions with regard to the kmod fix:

==================================
ptrace_check_attach Documentation:
==================================

After the initial ptrace_attach to mark an other task traced by the current
task, each ptrace system call consults ptrace_check_attach() to check if
the task which is calling it is properly attached to the pid he wants to
trace with this call of sys_ptrace():

sys_trace looks up the task_struct for the pid and passes this task_struct
as struct task_struct *child to ptrace_check_attach():

int ptrace_check_attach(struct task_struct *child, int kill)
{
	// Check if child has the trace flag set and abort if not:
        if (!(child->ptrace & PT_PTRACED))
                return -ESRCH;

	// Check if current is the tracer of child and abort if not:
        if (child->p_pptr != current)
                return -ESRCH;

I've added the comments inline, they are not found in the real code.

This means:

ptrace_check_attach() never returns true if the tracer is not
attached to the "child" task, which causes sys_ptrace() to reject
the desire with -EPERM.

It is just there to verify the tracer attach status, nothing more.

======================================
Minimum ptrace security Documentation:
======================================

All other security permission checks are done in:

- ptrace_attach() -> which does the checks *before* attaching to a task
- kernel_thread() -> which does the check to reject the creation of
                     a privileged task if the thread forker is traced
- exec()          -> which ignores suid/sgid if the process is traced.

The checks in detail(only a little detail, not much and assuming the
tracer is not root):

- ptrace_attach():
  with kernel_lock() and task_lock() hold:
  - checks if pid is not a kernel thread like kmod
    (indicated by task->task_dumpable == 1)
  - checks if pid was not created with suid/sguid bits honored
    (indicated by task->mm->dumpable == 1)
  - indicates that pid is being traced
    (executes: task->ptrace |= PT_PTRACE)

- kernel_tread():
  with task_lock() hold:
  - checks if task is not being traced (aborts if it is traced)
    (indicated by task->ptrace == 0)
  - indicates that the new task is a kernel thread
    (executes: task->task_dumpable = 0)

- exec()
  with kernel_lock() hold:
  - checks if task is not being traced (ignores suid/sgid if it is traced)
    (indicated by task->ptrace == 0)

This means:

- No process with setuid honored
     can be traced by a task which does not have CAP_SYS_PTRACE.
- No task created by kernel_thread()
     can be traced by a task which does not have CAP_SYS_PTRACE.

In addition:

- ptrace_check_attach() is completely unrelated to these checks because
  privilege extension thru kernel_thread and setuid is ignored if the
  task is traced.

- To trace, a tracer must call ptrace_attach, which is rejects the
  attach if pid is a suid-honored program or a kernel thread.

- ptrace_check_attach's duty is to only check if ptrace_attach() has
  acknowleged the attach and that's all it has to check.

That's the explanation why ptrace_check_attach as in vanilla 2.4.19/20
is just right and no change is needed there in order to fix kmod.

At least this is my conclusion.
Bernhard
