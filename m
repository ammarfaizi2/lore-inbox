Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVAGB2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVAGB2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVAGBH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:07:57 -0500
Received: from mail.dif.dk ([193.138.115.101]:58815 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261248AbVAGBHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:07:21 -0500
Date: Fri, 7 Jan 2005 02:18:44 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][3/4] let's kill verify_area - convert kernel/compat.c to
 access_ok()
Message-ID: <Pine.LNX.4.61.0501070155050.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch to convert verify_area to access_ok in kernel/compat.c

diff -up linux-2.6.10-bk9-orig/kernel/compat.c linux-2.6.10-bk9/kernel/compat.c
--- linux-2.6.10-bk9-orig/kernel/compat.c	2005-01-06 22:19:13.000000000 +0100
+++ linux-2.6.10-bk9/kernel/compat.c	2005-01-07 02:06:00.000000000 +0100
@@ -26,16 +26,16 @@
 
 int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
-	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
+	return (access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
-			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? 0 : -EFAULT;
 }
 
 int put_compat_timespec(const struct timespec *ts, struct compat_timespec __user *cts)
 {
-	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
+	return (access_ok(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
-			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? 0 : EFAULT;
 }
 
 static long compat_nanosleep_restart(struct restart_block *restart)
@@ -612,7 +612,7 @@ long compat_get_bitmap(unsigned long *ma
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 
-	if (verify_area(VERIFY_READ, umask, bitmap_size / 8))
+	if (!access_ok(VERIFY_READ, umask, bitmap_size / 8) != 0)
 		return -EFAULT;
 
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
@@ -653,7 +653,7 @@ long compat_put_bitmap(compat_ulong_t __
 	/* align bitmap up to nearest compat_long_t boundary */
 	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
 
-	if (verify_area(VERIFY_WRITE, umask, bitmap_size / 8))
+	if (!access_ok(VERIFY_WRITE, umask, bitmap_size / 8) != 0)
 		return -EFAULT;
 
 	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);



