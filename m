Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbRGCUSJ>; Tue, 3 Jul 2001 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbRGCUR7>; Tue, 3 Jul 2001 16:17:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265995AbRGCURr>; Tue, 3 Jul 2001 16:17:47 -0400
Date: Tue, 3 Jul 2001 16:17:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: wait_event() problems <patch>
Message-ID: <Pine.LNX.3.95.1010703161453.484A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been trying to get the following to work:

atomic_t stop;
struct wait_queue wait_queue_stuff, another_wait_queue;
  /* Initialized before use with init_wait_queue() */

kernel_thread()
{
    for(;;)
    {
        if(atomic_read(stop))
            interruptible_sleep_on(&wait_queue_stuff);
        do_regular_stuff();
    }
}

ioctl_start()
{
    if(waitqueue_active(&wait_queue_stuff))
    {
        atomic_set(&stop, 0);
        wake_up_interruptible(&wait_queue_stuff);
    }
}
ioctl_stop()
{
    if(!waitqueue_active(&wait_queue_stuff))
    {
        atomic_set(&stop, 1);
        wait_event(another_wait_queue, waitqueue_active(&wait_queue_stuff));
    }
}

The problem is that when ioctl_stop() is executed, the kernel thread
never gets any CPU time so it remains stuck in "D" state forever.

Maybe I'm doing something wrong, but something seems to be broken.
The following patch 'fixes' it.



--- linux-2.4.1/include/linux/sched.h.orig	Tue Jul  3 15:14:07 2001
+++ linux-2.4.1/include/linux/sched.h	Tue Jul  3 15:16:27 2001
@@ -763,6 +763,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);		\
 		if (condition)						\
 			break;						\
+                current->policy = SCHED_YIELD;                          \
 		schedule();						\
 	}								\
 	current->state = TASK_RUNNING;					\


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


