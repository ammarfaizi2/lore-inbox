Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSGTB7y>; Fri, 19 Jul 2002 21:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGTB7y>; Fri, 19 Jul 2002 21:59:54 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:19695 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317308AbSGTB7x>; Fri, 19 Jul 2002 21:59:53 -0400
Date: Fri, 19 Jul 2002 19:02:53 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.26 sys_stime() cleanup
Message-ID: <20020719190253.A10120@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sys_stime() currently sets time directly without using the existing helper
functions.  This patch changes sys_stime() to use these functions which
helps LSM place only one security check in do_sys_settimeofday().

Using the helper functions changes this in two ways.  First,
last_time_offset is no longer zeroed.  This doesn't appear to be an
issue, since last_time_offset is used primarily on IA64, and sys_stime()
is not compiled for IA64.  Second, the gettimeofday offset is now accounted
for by moving to the helper function.  Does anyone see problems with
this change?

I've tested this patch, and it works for me.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== time.c 1.6 vs edited =====
--- 1.6/kernel/time.c	Sun Jun  2 11:44:56 2002
+++ edited/time.c	Fri Jul 19 17:58:57 2002
@@ -41,6 +41,8 @@
 extern rwlock_t xtime_lock;
 extern unsigned long last_time_offset;
 
+int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
+
 #if !defined(__alpha__) && !defined(__ia64__)
 
 /*
@@ -75,21 +77,13 @@
 asmlinkage long sys_stime(int * tptr)
 {
 	int value;
+	struct timeval tv;
 
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
-	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
-	last_time_offset = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
-	return 0;
+	tv.tv_sec = value;
+	tv.tv_usec = 0;
+	return do_sys_settimeofday(&tv, NULL);
 }
 
 #endif
