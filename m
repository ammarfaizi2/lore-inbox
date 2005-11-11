Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVKKVQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKKVQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVKKVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:16:11 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:2804 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751199AbVKKVQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:16:09 -0500
Message-ID: <43750A1A.4010102@mvista.com>
Date: Fri, 11 Nov 2005 13:16:10 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timespec normalize off by one errors
Content-Type: multipart/mixed;
 boundary="------------030205050706030001080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030205050706030001080807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Found three places were we use ">" instead of ">=".
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------030205050706030001080807
Content-Type: text/plain;
 name="time-spec2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time-spec2.patch"

Source: MontaVista Software, Inc. 
Type: Defect Fix 

It would appear that the timespec normalize code has an off by one error.
Found in three places.

Signed-off-by: George Anzinger<george@mvista.com>

 include/linux/time.h  |    2 +-
 kernel/posix-timers.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6.15-rc/include/linux/time.h
===================================================================
--- linux-2.6.15-rc.orig/include/linux/time.h
+++ linux-2.6.15-rc/include/linux/time.h
@@ -101,7 +101,7 @@ extern struct timespec timespec_trunc(st
 static inline void
 set_normalized_timespec (struct timespec *ts, time_t sec, long nsec)
 {
-	while (nsec > NSEC_PER_SEC) {
+	while (nsec >= NSEC_PER_SEC) {
 		nsec -= NSEC_PER_SEC;
 		++sec;
 	}
Index: linux-2.6.15-rc/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc/kernel/posix-timers.c
@@ -270,7 +270,7 @@ static void tstojiffie(struct timespec *
 	long sec = tp->tv_sec;
 	long nsec = tp->tv_nsec + res - 1;
 
-	if (nsec > NSEC_PER_SEC) {
+	if (nsec >= NSEC_PER_SEC) {
 		sec++;
 		nsec -= NSEC_PER_SEC;
 	}
@@ -1209,13 +1209,9 @@ static int do_posix_clock_monotonic_get(
 
 	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
 
-	tp->tv_sec += wall_to_mono.tv_sec;
-	tp->tv_nsec += wall_to_mono.tv_nsec;
+	set_normalized_timespec(tp, tp->tv_sec += wall_to_mono.tv_sec,
+				tv_nsec += wall_to_mono.tv_nsec);
 
-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
-		tp->tv_nsec -= NSEC_PER_SEC;
-		tp->tv_sec++;
-	}
 	return 0;
 }
 

--------------030205050706030001080807--
