Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTFRHnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFRHnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:43:23 -0400
Received: from smtp4.pacifier.net ([64.255.237.174]:40397 "EHLO
	smtp4.pacifier.net") by vger.kernel.org with ESMTP id S265082AbTFRHnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:43:18 -0400
Date: Wed, 18 Jun 2003 00:57:12 -0700
From: "B. D. Elliott" <bde@nwlink.com>
To: linux-kernel@vger.kernel.org
Subject: Sparc64-2.5.72: A Serious Time Problem
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Message-Id: <20030618073556.94E966A4FC@smtp4.pacifier.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a serious bug in setting time on 64-bit sparcs (and probably other
64-bit systems).  The symptom is that ntpdate or date set the time back to
1969 or 1970.  The underlying problems are that stime is broken, and any
settimeofday call fails with a bad fractional value.  Ntpdate falls back to
stime when settimeofday fails.

The settimeofday problem is that the timeval and timespec structures are not
the same size.  In particular, the fractional part is an int in timeval, and
a long in timespec.  The stime problem is that the argument is not an int,
but a time_t, which is long on at least some 64-bit systems.

The following patch appears to fix this on my sparc64.

===================================================================
--- ./kernel/time.c.orig	2003-06-16 22:36:04.000000000 -0700
+++ ./kernel/time.c	2003-06-18 00:00:43.000000000 -0700
@@ -66,7 +66,7 @@
  * architectures that need it).
  */
  
-asmlinkage long sys_stime(int * tptr)
+asmlinkage long sys_stime(time_t * tptr)
 {
 	struct timespec tv;
 
@@ -162,13 +162,15 @@
 
 asmlinkage long sys_settimeofday(struct timeval __user *tv, struct timezone __user *tz)
 {
+	struct timeval user_tv;
 	struct timespec	new_tv;
 	struct timezone new_tz;
 
 	if (tv) {
-		if (copy_from_user(&new_tv, tv, sizeof(*tv)))
+		if (copy_from_user(&user_tv, tv, sizeof(*tv)))
 			return -EFAULT;
-		new_tv.tv_nsec *= NSEC_PER_USEC;
+		new_tv.tv_sec = user_tv.tv_sec;
+		new_tv.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
 	}
 	if (tz) {
 		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
===================================================================

-- 
B. D. Elliott   bde@nwlink.com
