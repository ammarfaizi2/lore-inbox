Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVCOEjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVCOEjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVCOEjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:39:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36014 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262239AbVCOEjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:39:07 -0500
Date: Mon, 14 Mar 2005 20:37:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, roland@redhat.com, sivanich@sgi.com
Subject: Exports to enable clock driver modules
Message-ID: <Pine.LNX.4.58.0503142034190.16107@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following exports are necessary to allow loadable modules to define
new clocks. Without these the mmtimer driver cannot be build
correctly as a module (there is another mmtimer specific fix necessary to
get  it to build properly but that will be a separate patch):

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/kernel/time.c
===================================================================
--- linux-2.6.11.orig/kernel/time.c	2005-03-01 23:37:50.000000000 -0800
+++ linux-2.6.11/kernel/time.c	2005-03-14 20:24:02.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/syscalls.h>
 #include <linux/security.h>
 #include <linux/fs.h>
+#include <linux/module.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -495,6 +496,8 @@ void getnstimeofday (struct timespec *tv
 	tv->tv_nsec = nsec;
 }

+EXPORT_SYMBOL(getnstimeofday);
+
 int do_settimeofday (struct timespec *tv)
 {
 	time_t wtm_sec, sec = tv->tv_sec;
Index: linux-2.6.11/kernel/posix-timers.c
===================================================================
--- linux-2.6.11.orig/kernel/posix-timers.c	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.11/kernel/posix-timers.c	2005-03-14 20:24:02.000000000 -0800
@@ -46,6 +46,7 @@
 #include <linux/syscalls.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/module.h>

 #ifndef div_long_long_rem
 #include <asm/div64.h>
@@ -397,6 +398,8 @@ int posix_timer_event(struct k_itimer *t
 	}
 }

+EXPORT_SYMBOL(posix_timer_event);
+
 /*
  * This function gets called when a POSIX.1b interval timer expires.  It
  * is used as a callback from the kernel internal timer.  The
@@ -491,6 +494,8 @@ void register_posix_clock(int clock_id,
 	posix_clocks[clock_id] = *new_clock;
 }

+EXPORT_SYMBOL(register_posix_clock);
+
 static struct k_itimer * alloc_posix_timer(void)
 {
 	struct k_itimer *tmr;
@@ -1198,11 +1203,15 @@ int do_posix_clock_nosettime(struct time
 	return -EINVAL;
 }

+EXPORT_SYMBOL(do_posix_clock_nosettime);
+
 int do_posix_clock_notimer_create(struct k_itimer *timer)
 {
 	return -EINVAL;
 }

+EXPORT_SYMBOL(do_posix_clock_notimer_create);
+
 int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec *t)
 {
 #ifndef ENOTSUP
@@ -1212,6 +1221,8 @@ int do_posix_clock_nonanosleep(int which
 #endif
 }

+EXPORT_SYMBOL(do_posix_clock_nonanosleep);
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
