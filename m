Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUFVNut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUFVNut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUFVNus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:50:48 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26330 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263663AbUFVNri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:47:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.14436.344871.168096@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 15:47:16 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
In-Reply-To: <20040622015311.561a73bf.akpm@osdl.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Random points:
 > 
 > 
 > - In __vperfctr_set_cpus_allowed(), is it possible for a process to
 >   generate that printk deliberately, thus spamming the logs?

On a HT P4, yes that's possible. Should I put in a rate limit?
I _must_ detect when this kernel or user error occurs, otherwise
things can break horribly on HT P4s. The only alternative to the
warning is to force a signal on the target process.

 > - perfctr_set_cpus_allowed() does task_lock().  Should that be
 >   vperfctr_task_lock() instead?

vperfctr_task_lock() _is_ task_lock() when HT P4s are possible.
In other cases vperfctr_task_lock() just disables preemption,
and perfctr_set_cpus_allows() is a no-op.

 >   Please update the locking comment over task_lock() to represent this
 >   new usage.

You mean add a comment there to the effect that set_cpus_allowed()
may do a task_lock()?

 > - (What is the thread/process/child inheritance model for perfctr
 >   anyway?)

Currently they're nuked on fork(). That's because it's difficult
to get child results back without changing wait() et al.
There has been some work in that direction, but it's a low-priority
item as long as basic API issues are being discussed.

Perfctrs are 100% tied to tasks. Whether those tasks choose to
combine themselves into POSIX processes or not is irrelevant.

 > - Why does sys_vperfctr_open() call ptrace_check_attach()?  (I suspect
 >   I'd know that if there was API documentation?)

In the remote-control case, we must check that the opening process
has the right to control the target process. I'm using the same
rules as ptrace(ATTACH) does, hence the ptrace_check_attach() call.

 > - cpus_copy_to_user() has the arguments in the wrong order, and should
 >   have sparse annotation added, please.

Agreed.

 > - <canofworms>cannot cpus_copy_to_user() share code with
 >   sys_sched_getaffinity()?</canofworms>

Not without breaking binary compatibility in both the affinity calls
and perfctr. The affinity calls' ABI is known to be broken and I will
not change my working API to theirs just for the sake of code sharing.

 > - Can perfctr_init() and perfctr_exit() have static scope?

I guess so. This is probably a left-over from pre-module_{init,exit}
days (2.2 kernels) when I had to put an init(9 call in drivers/char/misc.c.

 > - This
 > 
 > 	cache = &get_cpu_cache();
 > 
 >   looks cumbersome.  It'd be nice to add the & to get_cpu_cache() itself.

Agreed.

 > - In perfctr_cpu_init():
 > 
 > 	perfctr_cpu_init_one(NULL);
 > 	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);
 > 
 >   use on_each_cpu() here.  Ditto perfctr_cpu_exit(), other places.

This is the PPC32 driver. Yes, they can use on_each_cpu(), although
as you noticed below preemption is already disabled.

 > - Why does perfctr_cpu_init() do preempt_disable()?  Needs a comment. 
 >   Ditto perfctr_cpu_exit().

x86 still needs it in perfctr_cpu_init() since it (a) runs init
tests, and (b) goes through the low-level procedures in order to
backpatch call sites with the detected CPU type's function pointers.
These activities must not be context-switched or migrated from
one CPU to another.

The PPC32 driver inherited the preempt_disable() from the x86 driver.
It only needs it for the init_tests thing. I can move the preemption
manipulation into ppc_tests.c, and use on_each_cpu() in _init() and _exit().

 > - Why does vperfctr_alloc() allocate an entire page?  (Needs comment)

mmap()

 > - Why is that page reserved?

mmap() -- without the reservedness things broke horribly in the past.

 > - stack space.
 > 
 >   struct vperfctr_control is 348 bytes, do_vperfctr_read() uses 500 bytes
 >   of stack and does copy_to_user(), which can cause tremendously deep
 >   callchains (think: it can call into XFS and then into the qlogic driver ;))
 > 
 >   These big structures should be dynamically allocated.

There's room for a temp copy in the perfctr state object, which as
you've noticed is an entire page. That should reduce stack usage.

 >   sizeof(struct perfctr_cpu_state) is 708.

You can thank the P4 for most of that. It really is a complex beast.

 > - why is the filesystem kern_mount()ed?

It's an anonymous fs based on fs/pipe.c.

 > - why are the inodes initialised to state I_DIRTY?

See fs/pipe.c.

 > - In sys_vperfctr_open(), can the `if (!vperfctr_fs_init_done())' test
 >   actually return true?

Yes. Since the conversion to multiple system calls, there is no single
entry point which can check if the HW is supported. So now people can
call sys_vperfctr_open() even if HW detection failed. The test you
quoted protects against that.

 > - Can the presence of thread_struct.perfctr be dependent upon
 >   CONFIG_PERFCTR?

Sure, if that's desirable.

 > - If task A creates itself a node in that new filesystem (what's the
 >   naming schema there?  What facilities does the filesystem offer?  Why was
 >   an fs interface chosen?) and task B opens that node, then task A exits,
 >   what keeps the task_struct at the node's file->f_private_data->owner
 >   valid?

The fs has no directories or files, it's just there to ensure that
one can use a file descriptor as a handle, do fs-related things
(mmap(), send over a local socket), and that things like the fd
going out of scope (at close() or exit()) are detected. A perfctr
object can outlive the task it was attached to, that's part of
of how remote-control and the user-space `perfex' application work.

FS was chosen primarily because of mmap(), and secondarily because
an fd is a convenient handle on a potentially shared or non-own object.

 > - Are functions like p5_write_control() preempt-protected?

At the higher-level, yes. <asm-$ARCH/perfctr.h> documents that the
low-level accessor procedures must be called with preemption disabled.

 > - Is there much point in making CONFIG_PERFCTR_VIRTUAL optional?

It adds sizeof(struct*) bytes in the task_struct, and two
"if (tsk->ptr) do_something();" tests to switch_to(). People
may or may not want that.

The switch_to() overhead could perhaps be reduced if all unusual
cases were tested for in a single "if (tsk->unsual_mask != 0)".
I don't know if the other checks are unusual enough to warrant
such a change.

/Mikael
