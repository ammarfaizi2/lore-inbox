Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSJ0UGa>; Sun, 27 Oct 2002 15:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbSJ0UGa>; Sun, 27 Oct 2002 15:06:30 -0500
Received: from [203.199.93.15] ([203.199.93.15]:51977 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S262580AbSJ0UGX>; Sun, 27 Oct 2002 15:06:23 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200210271945.BAA18166@WS0005.indiatimes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: scheduler flow
Date: Mon, 28 Oct 2002 01:28:35 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I tried to understand how linux scheduler works. This is what I got/understood from the book and net. Please do correct me, if there's any potential mis-understanding.


CPU can execute one of the following at any given instance
--------------------------------------------------------------------------------
·	Interrupts
 
·	Task queues, Bottom Halves, etc.
 
·	Kernel thread running in behalf of process, invoked by system calls user process. - Non preemptive (except for interrupts) it has to yield for the scheduling of other process.
 
·	User process in user mode. Pre-emptive



 Scheduler is invoked when
------------------------------------
 
·	Current process is blocked, waiting for a resource i.e. in kernel mode. Kernel thread yields for another process to be scheduled.
 
·	More priority process has to be run. Checked by timer interrupt. It set the need-reschedule flag. This flag is checked after return from system call or from an interrupt/exception that occurred while in user mode.

·	Time slice of the current process is expired. Checked by timer interrupt. It set the need-reschedule flag. This flag is checked after return from system call or from an interrupt/exception that occurred while in user mode.

·	Scheduler is also called during, return from exceptions and interrupts.


The scheduler is called at return from a system call /*only*/ if the need_resched flag in the process's task structure is set (you find the assembly code implementing this logic in arch/i386/kernel/entry.S - after the ret_from_sys_call label).

The reason is to ensure fairness among the processes, while keeping the kernel non-preemptive. I.e. A process will never be preempted while running in kernel mode, and the need_resched flag is maintained and set (by the timer interrupt), when the process's time slice expires while it is running in kernel mode.

At return from system call the flag is checked, in order to preempt a process at the earliest moment, after it's time slice expired (while respecting the non-preemptive ness of the Linux kernel).

When the scheduler is called during return from system call, it does the same as when it is called from elsewhere - it chooses the most suitable process to run next on the CPU, and does the process switch.

For a process that doesn't call any system calls, the scheduler is invoked during return from interrupt, if the process's need_resched flag is set.
There will be at least the timer interrupt every 1/HZ seconds (HZ is 100 on i386, 1024 on Alpha...).
Usually we will have a lot more interrupts (e.g. from network cards, disk drives, etc.), we can call 'vmstat 1' to periodically display the number of interrupts that occurred in the last second.
Again we can find the assembly code implementing that logic in 
arch/i386/kernel/entry.S, looking at the labels ret_from_intr and ret_with_reschedule.


Work of Scheduler 
-------------------------
 
 
·	Run pending tasks in scheduler task queue
 
·	Run bottom halves
 
·	Schedule next process to run. If No process then run idle thread.



When bottom halves are run?
---------------------------------------
 
·	Return from system call (fast interrupts doesn’t not check bottom halves. Bottom halves set by fast interrupts)- done by scheduler
 
·	Return from slow interrupts.


Flow
------

I've sequenced the flow of events below.

User Process
|
SysCall/Exception/Interrupt
|
Kernel Thread
|
Timer Interrupt

When the timer interrupts the CPU, the kernel invokes "do_IRQ ()" function to handle the hardware interrupt. Just before do_IRQ returns and after it completed all timer relevant functionalities, it INVOKES do_bottom_half () ONLY IF there are any ACTIVE UNMASKED
Bottom Halves. 

Hence,
Timer Interrupt
|
do_bottom_half () if any BH is ACTIVE
|
ret_from_intr ()

Then, after do_bottom_half () returns, ret_from_intr () is called. (Still in the context of the timer interrupt).

This ret_from_intr () function pops up CS and EFLAGS registers from the STACK and determines whether the interrupted process was in USER mode or KERNEL mode. In our case, a kernel thread was interrupted by the timer interrupt. Hence ret_from_intr () executes the assemble instruction "RESTORE_ALL" to switch back to the original kernel thread that was previously interrupted. schedule() will not be invoked because the interrupted process was not in USER MODE.

To put things together, Bottom Halves and task queues will be executed BEFORE ret_from_intr() is called. Bottom Halves will get another chance to run within ret_from_intr() ONLY IF the interrupted process was in USER MODE. In this case, ret_from_intr () will call the schedule (), which in turn runs scheduler task queue (tq_scheduler) and bottom half one after another before doing context switch. 

*Also only scheduler task queue will be run directly from within the scheduler (). Immediate (tq_immediate) and Timer (tq_timer) task queues will be run from within the respective bottom halves. That is, from immediate_bh() and tqueue_bh() functions.

Warm Regards
Arun


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

