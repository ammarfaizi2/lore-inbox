Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUJAUKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUJAUKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUJAUIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:08:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27310 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266344AbUJAUEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:04:37 -0400
Date: Fri, 1 Oct 2004 13:02:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant cpu clocks V6 [3/3]: mmtimer provides CLOCK_SGI_CYCLE
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0410011301420.18738@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
	* Add CLOCK_SGI_CYCLE provided by drivers/char/mmtimer

Index: linux-2.6.9-rc3/include/linux/time.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/time.h	2004-10-01 08:40:30.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/time.h	2004-10-01 09:09:28.000000000 -0700
@@ -416,7 +416,7 @@
 /*
  * The IDs of various hardware clocks
  */
-
+#define CLOCK_SGI_CYCLE 10

 #define MAX_CLOCKS 16
 #define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
Index: linux-2.6.9-rc3/drivers/char/mmtimer.c
===================================================================
--- linux-2.6.9-rc3.orig/drivers/char/mmtimer.c	2004-09-29 20:05:19.000000000 -0700
+++ linux-2.6.9-rc3/drivers/char/mmtimer.c	2004-10-01 10:07:11.000000000 -0700
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/clksupport.h>
+#include <linux/posix-timers.h>

 MODULE_AUTHOR("Jesse Barnes <jbarnes@sgi.com>");
 MODULE_DESCRIPTION("Multimedia timer support");
@@ -177,6 +178,45 @@
 	&mmtimer_fops
 };

+static struct timespec sgi_clock_offset;
+static int sgi_clock_period;
+
+static int sgi_clock_get(struct timespec *tp) {
+	u64 nsec;
+
+	nsec = readq(RTC_COUNTER_ADDR) * sgi_clock_period
+			+ sgi_clock_offset.tv_nsec;
+	tp->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &tp->tv_nsec)
+			+ sgi_clock_offset.tv_sec;
+	return 0;
+};
+
+static int sgi_clock_set(struct timespec *tp) {
+
+	u64 nsec;
+	u64 rem;
+
+	nsec = readq(RTC_COUNTER_ADDR) * sgi_clock_period;
+
+	sgi_clock_offset.tv_sec = tp->tv_sec - div_long_long_rem(nsec, NSEC_PER_SEC, &rem);
+
+	if (rem <= tp->tv_nsec)
+		sgi_clock_offset.tv_nsec = tp->tv_sec - rem;
+	else {
+		sgi_clock_offset.tv_nsec = tp->tv_sec + NSEC_PER_SEC - rem;
+		sgi_clock_offset.tv_sec--;
+	}
+	return 0;
+}
+
+static struct k_clock sgi_clock = {
+	.res = 0,
+	.clock_set = sgi_clock_set,
+	.clock_get = sgi_clock_get,
+	.timer_create = do_posix_clock_notimer_create,
+	.nsleep = do_posix_clock_nonanosleep
+};
+
 /**
  * mmtimer_init - device initialization routine
  *
@@ -206,6 +246,9 @@
 		return -1;
 	}

+	sgi_clock_period = sgi_clock.res = NSEC_PER_SEC / sn_rtc_cycles_per_second;
+	register_posix_clock(CLOCK_SGI_CYCLE, &sgi_clock);
+
 	printk(KERN_INFO "%s: v%s, %ld MHz\n", MMTIMER_DESC, MMTIMER_VERSION,
 	       sn_rtc_cycles_per_second/(unsigned long)1E6);

