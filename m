Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVDHOid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVDHOid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVDHOid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:38:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:50408 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262835AbVDHOia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:38:30 -0400
Date: Fri, 8 Apr 2005 07:38:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Cc: Giovambattista Pulcini <gpulcini@swintel.it>,
       Gabriel Paubert <paubert@iram.es>
Subject: [PATCH 2.6.12-rc2]: ppc32: Fix a problem with NTP on !(chrp||gemini)
Message-ID: <20050408143828.GW3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following problem was found by Giovambattista Pulcini
<gpulcini@swintel.it>, who also provided a partial patch, and this has
been verified by our time guru Gabriel Paubert <paubert@iram.es>.

The problem is that in do_settimeofday() we always set time_state to
TIME_ERROR and except on two platforms, never re-set it.  This meant
that ntp_gettime() and ntp_adjtime() always returned TIME_ERROR,
incorrectly.  Based on Gabriel's analysis, time_state is used for
leap-second processing, and ppc shouldn't be mucking with it.

From: Giovambattista Pulcini <gpulcini@swintel.it>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.37/arch/ppc/kernel/time.c	2005-01-20 22:02:08 -07:00
+++ edited/arch/ppc/kernel/time.c	2005-04-08 07:30:46 -07:00
@@ -272,7 +272,6 @@
 
 	time_adjust = 0;                /* stop active adjtime() */
 	time_status |= STA_UNSYNC;
-	time_state = TIME_ERROR;        /* p. 24, (a) */
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
--- 1.11/arch/ppc/platforms/chrp_time.c	2005-01-25 14:50:14 -07:00
+++ edited/arch/ppc/platforms/chrp_time.c	2005-04-08 07:30:53 -07:00
@@ -115,8 +115,6 @@
 	chrp_cmos_clock_write(save_control, RTC_CONTROL);
 	chrp_cmos_clock_write(save_freq_select, RTC_FREQ_SELECT);
 
-	if ( (time_state == TIME_ERROR) || (time_state == TIME_BAD) )
-		time_state = TIME_OK;
 	spin_unlock(&rtc_lock);
 	return 0;
 }
--- 1.17/arch/ppc/platforms/gemini_setup.c	2005-03-13 16:29:43 -07:00
+++ edited/arch/ppc/platforms/gemini_setup.c	2005-04-08 07:30:56 -07:00
@@ -433,9 +433,6 @@
 	/* done writing */
 	gemini_rtc_write(reg, M48T35_RTC_CONTROL);
 
-	if ((time_state == TIME_ERROR) || (time_state == TIME_BAD))
-		time_state = TIME_OK;
-
 	return 0;
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
