Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVIAVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVIAVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVIAVD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:03:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18873 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030239AbVIAVDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:03:55 -0400
Subject: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec values
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 14:03:47 -0700
Message-Id: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I recently ran into a bug with an older kernel where xtime's tv_nsec
field had accumulated more then 2 seconds worth of time. The timespec's
tv_nsec is a signed long, however gettimeofday() treats it as an
unsigned long. Thus when the failure occured, very strange and difficult
to debug time problems occurred.

The main cause of the problem I was seeing is already fixed in mainline,
however just to be safe, I figured the following patch would be wise.

I only audited i386 and x86_64, however other arches probably could have
similar signed problems as well.

Please let me know if you have any further comments or feedback.

thanks
-john

linux-2.6.13_signed-tv_nsec_A0.patch
====================================
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -156,7 +156,7 @@ void do_gettimeofday(struct timeval *tv)
 			usec += lost * (USEC_PER_SEC / HZ);
 
 		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
+		usec += (unsigned long)xtime.tv_nsec / 1000;
 	} while (read_seqretry(&xtime_lock, seq));
 
 	while (usec >= 1000000) {
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -128,7 +128,7 @@ void do_gettimeofday(struct timeval *tv)
 		seq = read_seqbegin(&xtime_lock);
 
 		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / 1000;
+		usec = (unsigned long)xtime.tv_nsec / 1000;
 
 		/* i386 does some correction here to keep the clock 
 		   monotonous even when ntpd is fixing drift.
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -824,7 +824,7 @@ static void update_wall_time(unsigned lo
 	do {
 		ticks--;
 		update_wall_time_one_tick();
-		if (xtime.tv_nsec >= 1000000000) {
+		if ((unsigned long)xtime.tv_nsec >= 1000000000) {
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
 			second_overflow();


