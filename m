Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVKIQQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVKIQQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVKIQQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:16:46 -0500
Received: from spirit.analogic.com ([204.178.40.4]:37387 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751443AbVKIQQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:16:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190511090749j3de0e473x@mail.gmail.com>
References: <7d40d7190511090749j3de0e473x@mail.gmail.com>
X-OriginalArrivalTime: 09 Nov 2005 16:16:44.0060 (UTC) FILETIME=[F9C265C0:01C5E548]
Content-class: urn:content-classes:message
Subject: Re: Stopping Kernel Threads at module unload time
Date: Wed, 9 Nov 2005 11:16:43 -0500
Message-ID: <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stopping Kernel Threads at module unload time
Thread-Index: AcXlSPnJ6vLsy69bScqQJ/xnfkd4PA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Aritz Bastida wrote:

> Hello
>
> I've got some questions about kernel threads.I am writing a module
> which spawns some kernel threads, which would be removed when the
> module unloads. For that purpose i call kthread_stop() at module
> unload time. When issuing rmmod on the module, it deadlocks at that
> point (in the call to kthread_stop), and never returns.
>
> In the thread main function the code was something like this (it's of
> course simplified).
>
> thread_main()
> {
>     while( ! kthread_should_stop())
>     {
>           .............
>           wait_event_interruptible(stop_wq, kthread_should_stop() );
>     }
>
>     return 0;
> }
>
> So if kthread_stop() first sets the thread "closing flag", and then
> calls wake_up_process(), the thread should wake up, see he should
> stop, and
> end the loop. That doesnt actually never happen.
>
> I have also tried what it is done in kernel/sched.c to finish:
>
> 	/* wait for kthread_stop */
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	while (!kthread_should_stop()) {
> 		schedule();
> 		set_current_state(TASK_INTERRUPTIBLE);
> 	}
> 	__set_current_state(TASK_RUNNING);
>                return 0;
>
> I have ensured it actually arrives to that point by using printks, but
> when the thread goes to sleep, it does never wake up again, so the
> call to kthread_stop() lasts forever.
>
> I dont know why this happens. Is the module cleanup code in the
> context of a user process just like system calls? Can that code sleep?
> If it can't sleep then the answer would be quite easy: kthread_stop()
> wakes up the processes and then waits for the threads to finish (on
> call wait_for_completion), but doesnt actually let them execute,
> because it cannot sleep, so it deadlocks.
>
> So I would be grateful if anyone can help me in this matter.
> Regards
>
> Aritz


Here is code that actually works. There have been some kernel
API changes that convert some of this stuff to macros. Nevertheless.
This stuff works.


void make_daemon(const char *dev, int32_t prior)
{
#ifdef OLD_DAEMON              // kernel 2.4.x
     exit_files(current);
     daemonize();
     spin_lock_irq(&current->sigmask_lock);
     sigemptyset(&current->blocked);
     sigdelset(&current->blocked, SIGTERM);
     recalc_sigpending(current);
     spin_unlock_irq(&current->sigmask_lock);
     task_lock(current);
     current->nice = prior;
     strcpy(current->comm, dev);
     task_unlock(current);
#else				// kernel 2.6.x
     daemonize("%s", dev);
     allow_signal(SIGTERM);
     set_user_nice(current, prior);
#endif
//
//  Destroy process privs just in case somebody is able to hack this
//  into a shell.
//
     task_lock(current);
     current->uid  = current->gid  = current->sgid = current->fsgid =
     current->euid = current->egid = current->suid = current->fsuid = 666;
     task_unlock(current);
}

Note above that the task is already running inside the kernel and
has access to all your data. You don't need it to be 'root' so that
possible back-door gets closed.


//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//    This is the kernel thread. It handles things that should not
//    be handled in an interrupt. It is awakened from the interrupt
//    service routine.
//
static int32_t local_thread(void *unused)
{
     make_daemon(task_name, PRIOR);
     set_current_state(TASK_INTERRUPTIBLE);	// For the following sleep
     schedule_timeout(1);                        // Let insmod complete
     set_current_state(TASK_RUNNING);		// Remember to restore
     __asm__ __volatile__("thread:\n.global thread\n");
     for(;;)				// Do forever.......
     {
         set_current_state(TASK_INTERRUPTIBLE);
         if(signal_pending(current))
             complete_and_exit(&info->quit, 0);	// This is how you get out
         interruptible_sleep_on(&info->twait);	// Sleep until something to do
         set_current_state(TASK_RUNNING);

         do_stuff(.....);    // Whatever the thread needs to do....

     }
     return 0;
}


  This is how the kernel thread is started.

     info->pid = kernel_thread(local_thread, NULL, CLONE_FS|CLONE_FILES);


This is how the kernel thread is stopped.

     if(info->pid)
     {
         (void)kill_proc(info->pid, SIGTERM, 1);
         wait_for_completion(&info->quit);
     }


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
