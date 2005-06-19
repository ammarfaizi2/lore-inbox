Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVFSKbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVFSKbC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 06:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVFSKbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 06:31:01 -0400
Received: from ip-pub.fastwebnet.it ([83.103.88.29]:41428 "EHLO maruska.ath.cx")
	by vger.kernel.org with ESMTP id S262224AbVFSKal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 06:30:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.12] getmonotonictime system call and patch for evdev to
 use such time
From: mmc@maruska.dyndns.org (Michal =?iso-8859-2?q?Maru=B9ka?=)
Date: Sun, 19 Jun 2005 12:30:40 +0200
Message-ID: <m2ekayaban.fsf@linux11.maruska.tin.it>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Events from the evdev device are timestamped with gettimeofday. If a userland
application wants to see a duration of a key press, all it can do is
look at the 2 timestamps.

If settimeofday is called in between, it will see a false duration, which is not
what it needs. So, for my needs I only want the monotonic (since boot) time.  I
understand, that someone else might want to maintain compatibility, and have the
kind of time selectable (ioctl), but that's above my current kernel knowledge.

If no event arrives I would still like to measure the progressed duration, and thus get the
monotonic time, so a system call getmonotonictime is needed.

I found  do_posix_clock_monotonic_gettime  and made simple wrapper around it.
I do NOT claim i know how to add a new system call! And it's  i386 only.

All i did is testing with simple:

   struct timeval  tp;
   syscall(289, &tv);



Signed-off-by: Michal Maruska <mmc@maruska.dyndns.org> 

--- linux-2.6.12/arch/i386/kernel/syscall_table.S	2005-06-19 11:58:35.000000000 +0200
+++ linux-2.6.12.mmc/arch/i386/kernel/syscall_table.S	2005-06-19 12:08:57.128194816 +0200
@@ -289,3 +289,4 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+        .long sys_getmonotonictime
--- linux-2.6.12/drivers/input/evdev.c	2005-06-19 11:58:35.000000000 +0200
+++ linux-2.6.12.mmc/drivers/input/evdev.c	2005-06-19 12:06:15.354519028 +0200
@@ -52,7 +52,7 @@
 	if (evdev->grab) {
 		list = evdev->grab;
 
-		do_gettimeofday(&list->buffer[list->head].time);
+		do_getmonotonictime(&list->buffer[list->head].time);
 		list->buffer[list->head].type = type;
 		list->buffer[list->head].code = code;
 		list->buffer[list->head].value = value;
@@ -62,7 +62,7 @@
 	} else
 		list_for_each_entry(list, &evdev->list, node) {
 
-			do_gettimeofday(&list->buffer[list->head].time);
+			do_getmonotonictime(&list->buffer[list->head].time);
 			list->buffer[list->head].type = type;
 			list->buffer[list->head].code = code;
 			list->buffer[list->head].value = value;
--- linux-2.6.12/include/linux/time.h	2005-06-19 11:58:35.000000000 +0200
+++ linux-2.6.12.mmc/include/linux/time.h	2005-06-19 12:05:01.816311807 +0200
@@ -92,6 +92,7 @@
 #define CURRENT_TIME (current_kernel_time())
 #define CURRENT_TIME_SEC ((struct timespec) { xtime.tv_sec, 0 })
 
+extern void do_getmonotonictime (struct timeval *tv);
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
--- linux-2.6.12/kernel/time.c	2005-06-19 11:58:35.000000000 +0200
+++ linux-2.6.12.mmc/kernel/time.c	2005-06-19 12:21:30.348997202 +0200
@@ -5,7 +5,7 @@
  *
  *  This file contains the interface functions for the various
  *  time related system calls: time, stime, gettimeofday, settimeofday,
- *			       adjtime
+ *			       adjtime, getmonotonictime
  */
 /*
  * Modification history kernel/time.c
@@ -25,6 +25,9 @@
  * 2004-07-14	 Christoph Lameter
  *	Added getnstimeofday to allow the posix timer functions to return
  *	with nanosecond accuracy
+ * 2005-06-19  Michal Maruska
+ *      Added getmonotonictime to provide time and (input event) timestamps
+ *      independent of time changes (settimeofday)
  */
 
 #include <linux/module.h>
@@ -112,6 +115,33 @@
 	return 0;
 }
 
+asmlinkage long sys_getmonotonictime(struct timeval __user *tv)
+{
+	if (likely(tv != NULL)) {
+		struct timeval ktv;
+		do_getmonotonictime(&ktv);
+		/* indeed it works! */
+		/* printk("%s\n", __FUNCTION__); */
+		if (copy_to_user(tv, &ktv, sizeof(ktv)))
+			return -EFAULT; 
+	}
+	return 0;
+}
+
+
+void do_getmonotonictime (struct timeval *tv)
+{
+	struct timespec kts;
+        if (unlikely(tv == NULL)) return;        /* should not happen */
+           
+	do_posix_clock_monotonic_gettime(&kts);
+	/* transform the "struct timespec" into  "struct timeval" */
+	tv->tv_sec = kts.tv_sec;
+	tv->tv_usec = kts.tv_nsec / NSEC_PER_USEC;
+}
+
+EXPORT_SYMBOL(do_getmonotonictime);
+
 /*
  * Adjust the time obtained from the CMOS to be UTC time instead of
  * local time.
