Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVDMAaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVDMAaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVDLUTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:19:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:22728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262133AbVDLKb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:28 -0400
Message-Id: <200504121031.j3CAVFOq005272@shell0.pdx.osdl.net>
Subject: [patch 037/198] ppc32: Fix a problem with NTP on !(chrp||gemini)
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, gpulcini@swintel.it,
       paubert@iram.es, trini@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Giovambattista Pulcini <gpulcini@swintel.it>

The following problem was found by Giovambattista Pulcini
<gpulcini@swintel.it>, who also provided a partial patch, and this has been
verified by our time guru Gabriel Paubert <paubert@iram.es>.

The problem is that in do_settimeofday() we always set time_state to
TIME_ERROR and except on two platforms, never re-set it.  This meant that
ntp_gettime() and ntp_adjtime() always returned TIME_ERROR, incorrectly. 
Based on Gabriel's analysis, time_state is used for leap-second processing,
and ppc shouldn't be mucking with it.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/time.c            |    1 -
 25-akpm/arch/ppc/platforms/chrp_time.c    |    2 --
 25-akpm/arch/ppc/platforms/gemini_setup.c |    3 ---
 3 files changed, 6 deletions(-)

diff -puN arch/ppc/kernel/time.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini arch/ppc/kernel/time.c
--- 25/arch/ppc/kernel/time.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini	2005-04-12 03:21:12.263272600 -0700
+++ 25-akpm/arch/ppc/kernel/time.c	2005-04-12 03:21:12.268271840 -0700
@@ -272,7 +272,6 @@ int do_settimeofday(struct timespec *tv)
 
 	time_adjust = 0;                /* stop active adjtime() */
 	time_status |= STA_UNSYNC;
-	time_state = TIME_ERROR;        /* p. 24, (a) */
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
diff -puN arch/ppc/platforms/chrp_time.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini arch/ppc/platforms/chrp_time.c
--- 25/arch/ppc/platforms/chrp_time.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini	2005-04-12 03:21:12.264272448 -0700
+++ 25-akpm/arch/ppc/platforms/chrp_time.c	2005-04-12 03:21:12.269271688 -0700
@@ -115,8 +115,6 @@ int __chrp chrp_set_rtc_time(unsigned lo
 	chrp_cmos_clock_write(save_control, RTC_CONTROL);
 	chrp_cmos_clock_write(save_freq_select, RTC_FREQ_SELECT);
 
-	if ( (time_state == TIME_ERROR) || (time_state == TIME_BAD) )
-		time_state = TIME_OK;
 	spin_unlock(&rtc_lock);
 	return 0;
 }
diff -puN arch/ppc/platforms/gemini_setup.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini arch/ppc/platforms/gemini_setup.c
--- 25/arch/ppc/platforms/gemini_setup.c~ppc32-fix-a-problem-with-ntp-on-chrpgemini	2005-04-12 03:21:12.265272296 -0700
+++ 25-akpm/arch/ppc/platforms/gemini_setup.c	2005-04-12 03:21:12.269271688 -0700
@@ -433,9 +433,6 @@ gemini_set_rtc_time( unsigned long now )
 	/* done writing */
 	gemini_rtc_write(reg, M48T35_RTC_CONTROL);
 
-	if ((time_state == TIME_ERROR) || (time_state == TIME_BAD))
-		time_state = TIME_OK;
-
 	return 0;
 }
 
_
