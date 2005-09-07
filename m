Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVIGUIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVIGUIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIGUIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:08:31 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:56333 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751296AbVIGUIb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:08:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1126122068.2744.20.camel@syd.mkgnu.net>
References: <1126122068.2744.20.camel@syd.mkgnu.net>
X-OriginalArrivalTime: 07 Sep 2005 20:08:17.0228 (UTC) FILETIME=[E2B558C0:01C5B3E7]
Content-class: urn:content-classes:message
Subject: Re: Gracefully killing kswapd, or any kernel thread
Date: Wed, 7 Sep 2005 16:08:17 -0400
Message-ID: <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Gracefully killing kswapd, or any kernel thread
Thread-Index: AcWz5+K8tuTOkkN4SPmzwdbN8++JQA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kristis Makris" <kristis.makris@asu.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Sep 2005, Kristis Makris wrote:

> Hello,
>
> I'm trying to kill a kernel thread gracefully, in particular kswapd,
> without any success.
>
> The goal is to start another kernel thread that contains updated kswapd
> functionality, through a loadable module; no kernel recompilation.
>
> I noticed that kernel threads block SIGKILL. Hence, on module load I'm
> running:
>
> task = find_task_by_name("kswapd");
> if (task != NULL) {
>    spin_lock_irq(&task->sigmask_lock);
>    sigdelset(&task->blocked, SIGKILL);
>    recalc_sigpending(task);
>    spin_unlock_irq(&task->sigmask_lock);
>    // Also tried issuing here a: kill_proc(task->pid, SIGKILL, 1);
> }
>
> Then from userspace I issue:
>
> # ps aux |grep -i swap
> root         4  0.0  0.0     0    0 ?        SW   18:36   0:00 [kswapd]
> $ kill -9 4
>
> After the kill is issued, kswapd is taking up 99.9% of CPU time and
> remains at a runnable state:
> # ps aux |grep -i swap
> root         4  0.2  0.0     0    0 ?        RW   18:36   0:02 [kswapd]
>
>
> Can anyone explain why this is happening ? I've tried this with linux
> kernels 2.2.19 and 2.4.27 (with patch kdb-4.3). What is the proper way
> of gracefully killing a kernel thread launched from the original kernel
> image (not a module) in kernels < 2.6 (ie. without the new kernel thread
> API that contains the stop_kthread call documented in
> http://www.scs.ch/~frey/linux/kernelthreads.html)
>
> I've also tried the same with kflushd, kupdate, and keventd in 2.2.19.
> When I do issue a "kill -9" for them I see:
>
> # ps aux
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root         2  0.0  0.0     0    0 ?        SW   12:18   0:00 [kflushd]
> root         3  1.5  0.0     0    0 ?        RW   12:18   0:16 [kupdate]
> root         5  0.0  0.0     0    0 ?        SW   12:18   0:00 [keventd]
>
> All 3 kernel threads remain in the process list. kupdate also appears to
> be in a running state consuming 99.9% of the CPU when killed. What's so
> special about kupdate and kswapd that makes them stay at a running
> state, and why do all kernel threads seem unkillable?
>
> Thanks,
> Kristis

To kill a kernel thread, you need to make __it__ call exit(). It must be
CODED to do that! You can't do it externally although you can send
it a signal, after which it will spin forever....

// Main loop of the thread

     for(;;)
     {
         set_current_state(TASK_INTERRUPTIBLE);
         if(signal_pending(current))
             complete_and_exit(&info->quit, 0);  // <--- HERE!!!
         interruptible_sleep_on(&info->twait);
         do_work();
     }

// Start a thread

     info->pid = kernel_thread(local_thread, NULL, CLONE_FS|CLONE_FILES);



// Stop a thread

     if(info->pid)
     {
         (void)kill_proc(info->pid, SIGTERM, 1);
         wait_for_completion(&info->quit);   // MUST wait!
     }

With newer kernels, we use the allow_signal(SIGNAME) macro as one
of the first things executed to allow the kernel thread to respond
to a signal.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
