Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVLOAgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVLOAgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVLOAfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:35:39 -0500
Received: from [64.71.148.162] ([64.71.148.162]:42646 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S965131AbVLOAf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:35:29 -0500
Message-ID: <43A0BBC4.7050300@linuxmachines.com>
Date: Wed, 14 Dec 2005 16:41:40 -0800
From: Jeff Carr <jcarr@linuxmachines.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution patches
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
In-Reply-To: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090402060107000302090404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402060107000302090404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/12/05 03:02, Thomas Gleixner wrote:
> The rebased version of the high resolution patches on top of the
> hrtimers base patch is available from the new project home:
> 
> http://www.tglx.de/projetcs/hrtimers
> 
> The current patch is available here:
> 
> http://www.tglx.de/projects/hrtimers/2.6.15-rc5/patch-2.6.15-rc5-hrt2.patch

This is a simple module to start a hrtimer about 20k times a second. I
don't see a way to correctly restart a hrtimer or set one to be periodic
so this is inefficiently bouncing between two timers. Calling
restart_hrtimer() from within the hrtimer.function causes a panic. I was
wondering what the correct method would be.

I had to export some symbols from hrtimer.c so I could build this as a
module.



/*
 *
 * A simple module that starts a hrtimer ~20k/sec
 *
 * This software is available to you under the terms of the GNU
 * General Public License (GPL) Version 2, available from the file
 * COPYING in the main directory of this source tree.
 *
 */

#include <asm/semaphore.h>
#include <linux/device.h>
#include <linux/err.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/pci.h>
#include <linux/time.h>
#include <linux/workqueue.h>
#include <asm/uaccess.h>
#include <linux/delay.h>
#include <linux/proc_fs.h>
#include <linux/hrtimer.h>

MODULE_AUTHOR("Jeff Carr");
MODULE_DESCRIPTION("simple hrtimer test");
MODULE_LICENSE("GPL");

static struct workqueue_struct *testwq;
static struct work_struct testwork;

static struct hrtimer restart_hrtimer;
static struct hrtimer trigger_hrtimer;

static int done = 0;
static int hrtimer_count = 0;

#define HT_TEST_PERIOD 20000; // In nanoseconds

static void do_test_work(void *data)
{
	restart_hrtimer.expires.tv64 = (u64) HT_TEST_PERIOD;
	hrtimer_start(&restart_hrtimer, restart_hrtimer.expires, HRTIMER_REL);

	return;
}

static int do_restart_hrtimer(void *data)
{
	if (!done) {
		trigger_hrtimer.expires.tv64 = (u64) HT_TEST_PERIOD;
		hrtimer_start(&trigger_hrtimer, trigger_hrtimer.expires,
			      HRTIMER_REL);
	}
	return 0;
}

static int do_trigger_hrtimer(void *data)
{
	static struct timeval now;

	++hrtimer_count;
	do_gettimeofday(&now);
	if (printk_ratelimit())
		printk(KERN_DEBUG
		       "do_trigger_hrtimer() ran %d times (%li.%li)\n",
		       hrtimer_count, now.tv_sec, now.tv_usec);

	if (!done) {
		restart_hrtimer.expires.tv64 = (u64) HT_TEST_PERIOD;
		hrtimer_start(&restart_hrtimer, restart_hrtimer.expires,
			      HRTIMER_REL);
	}
	return 0;
}

static int __init hrtimer_test_init(void)
{
	testwq = create_singlethread_workqueue("simple_hrtimer_test");
	if (!testwq)
		return -1;

	INIT_WORK(&testwork, do_test_work, NULL);

	hrtimer_init(&restart_hrtimer, (const clockid_t)CLOCK_REALTIME);
	restart_hrtimer.data = (unsigned long)NULL;
	restart_hrtimer.function = do_restart_hrtimer;

	hrtimer_init(&trigger_hrtimer, (const clockid_t)CLOCK_REALTIME);
	trigger_hrtimer.data = (unsigned long)NULL;
	trigger_hrtimer.function = do_trigger_hrtimer;

	queue_work(testwq, &testwork);

	return 0;
}

static void __exit hrtimer_test_cleanup(void)
{
	done = 1;

	flush_workqueue(testwq);
	destroy_workqueue(testwq);

	// not sure how to destroy this correctly
	hrtimer_cancel(&restart_hrtimer);
	remove_hrtimer(&restart_hrtimer);

	// not sure how to destroy this correctly
	hrtimer_cancel(&trigger_hrtimer);
	remove_hrtimer(&trigger_hrtimer);
}

module_init(hrtimer_test_init);
module_exit(hrtimer_test_cleanup);

--------------090402060107000302090404
Content-Type: text/x-patch;
 name="export_symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_symbols.patch"

--- linux-2.6.15-rc5-hrt3/kernel/hrtimer.c	2005-12-14 19:03:20.000000000 -0800
+++ linux-2.6.15-rc5-hrt2/kernel/hrtimer.c	2005-12-13 03:29:57.000000000 -0800
@@ -498,6 +495,7 @@
 
 	return orun;
 }
+EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
@@ -591,6 +589,7 @@
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(remove_hrtimer);
 
 /**
  * hrtimer_start - (re)start an relative timer on the current CPU
@@ -628,6 +627,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hrtimer_start);
 
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
@@ -675,6 +675,7 @@
 			return ret;
 	}
 }
+EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
  * hrtimer_get_remaining - get remaining time for the timer
@@ -719,6 +720,7 @@
 	memset(timer, 0, sizeof(struct hrtimer));
 	hrtimer_rebase(timer, clock_id);
 }
+EXPORT_SYMBOL_GPL(hrtimer_init);
 
 /**
  * hrtimer_get_res - get the timer resolution for a clock
@@ -992,6 +995,7 @@
 	else
 		return (ktime_t) {.tv64 = 0 };
 }
+EXPORT_SYMBOL_GPL(schedule_hrtimer);
 
 static inline ktime_t __sched
 schedule_hrtimer_interruptible(struct hrtimer *timer,
@@ -1001,6 +1005,7 @@
 
 	return schedule_hrtimer(timer, mode);
 }
+EXPORT_SYMBOL_GPL(schedule_hrtimer_interruptible);
 
 static long __sched
 nanosleep_restart(struct restart_block *restart, clockid_t clockid)
@@ -1031,6 +1036,7 @@
 	/* The other values in restart are already filled in */
 	return -ERESTART_RESTARTBLOCK;
 }
+EXPORT_SYMBOL_GPL(nanosleep_restart);
 
 static long __sched nanosleep_restart_mono(struct restart_block *restart)
 {
@@ -1076,6 +1082,7 @@
 
 	return -ERESTART_RESTARTBLOCK;
 }
+EXPORT_SYMBOL_GPL(hrtimer_nanosleep);
 
 asmlinkage long
 sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
@@ -1090,6 +1097,7 @@
 
 	return hrtimer_nanosleep(&tu, rmtp, HRTIMER_REL, CLOCK_MONOTONIC);
 }
+EXPORT_SYMBOL_GPL(sys_nanosleep);
 
 /*
  * Functions related to boot-time initialization:

--------------090402060107000302090404--
