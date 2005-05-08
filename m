Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVEHD52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVEHD52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 23:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVEHD52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 23:57:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:12485 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262810AbVEHD5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 23:57:19 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Joel Becker <joel.becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.4.12-rc4] Add skip_hangcheck_timer()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 May 2005 13:56:44 +1000
Message-ID: <1679.1115524604@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least two cases where the existing hangcheck
code falls down :-

(1) Some kernel events such as dumping or debugging will legitimately
    disable interrupts for long periods.  Restarting after these events
    must ignore the hangcheck.

(2) During hotplug cpu changes, the hangcheck timer can move from one
    cpu to another, see migrate_timers().  There is no guarantee that
    the clock on the new cpu is in sync with the old clock so hangcheck
    may trip with a spurious error.

Like the NMI watchdog, hangcheck-timer needs a facility to ignore the
timeout for special cases.  Add touch_hangcheck_timer().

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: linux/include/linux/hangcheck.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/hangcheck.h	2005-05-08 12:50:00.407071808 +1000
@@ -0,0 +1,17 @@
+#ifndef LINUX_HANGCHECK_H
+#define LINUX_HANGCHECK_H
+
+/**
+ * touch_hangcheck_timer - restart HANGCHECK timer timeout.
+ *
+ * If the kernel supports the HANGCHECK code, touch_hangcheck_timer() may be
+ * used to reset the timeout - for code which intentionally disables interrupts
+ * for a long time. This call is stateless.
+ */
+#ifdef CONFIG_HANGCHECK_TIMER
+extern void touch_hangcheck_timer(void);
+#else
+#define touch_hangcheck_timer() do { } while(0)
+#endif
+
+#endif
Index: linux/drivers/char/hangcheck-timer.c
===================================================================
--- linux.orig/drivers/char/hangcheck-timer.c	2005-05-08 12:47:19.785980026 +1000
+++ linux/drivers/char/hangcheck-timer.c	2005-05-08 13:18:44.928535058 +1000
@@ -143,6 +143,14 @@ static inline unsigned long long monoton
 }
 #endif  /* HAVE_MONOTONIC */
 
+/* Allow single shot ignore of the timer check */
+static int skip_hangcheck_timer;
+
+void touch_hangcheck_timer(void)
+{
+	skip_hangcheck_timer = 1;
+}
+EXPORT_SYMBOL(touch_hangcheck_timer);
 
 /* Last time scheduled */
 static unsigned long long hangcheck_tsc, hangcheck_tsc_margin;
@@ -164,6 +172,11 @@ static void hangcheck_fire(unsigned long
 	else
 		tsc_diff = (cur_tsc + (~0ULL - hangcheck_tsc)); /* or something */
 
+	if (skip_hangcheck_timer) {
+		skip_hangcheck_timer = 0;
+		tsc_diff = 0;
+	}
+
 	if (tsc_diff > hangcheck_tsc_margin) {
 		if (hangcheck_dump_tasks) {
 			printk(KERN_CRIT "Hangcheck: Task state:\n");

