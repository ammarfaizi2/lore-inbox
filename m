Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVKKWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVKKWZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKKWZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:25:34 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:4342 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751253AbVKKWZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:25:34 -0500
Message-ID: <43751A59.2060604@mvista.com>
Date: Fri, 11 Nov 2005 14:25:29 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org, joe@perches.com
Subject: Re: [PATCH] Timespec normalize off by one errors
References: <43750A1A.4010102@mvista.com>
In-Reply-To: <43750A1A.4010102@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020906080305040306050303"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020906080305040306050303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

George Anzinger wrote:
> Found three places were we use ">" instead of ">=".
> 
Lets just try this again.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------020906080305040306050303
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
+	set_normalized_timespec(tp, tp->tv_sec + wall_to_mono.tv_sec,
+				tp->tv_nsec + wall_to_mono.tv_nsec);
 
-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
-		tp->tv_nsec -= NSEC_PER_SEC;
-		tp->tv_sec++;
-	}
 	return 0;
 }
 

--------------020906080305040306050303--
