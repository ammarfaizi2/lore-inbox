Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVLKQIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVLKQIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLKQIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:08:31 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:468 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750728AbVLKQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:08:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2: broken resume from disk on x86-64
Date: Sun, 11 Dec 2005 16:52:10 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "Discuss x86-64" <discuss@x86-64.org>
References: <20051211041308.7bb19454.akpm@osdl.org> <200512111647.31202.rjw@sisk.pl>
In-Reply-To: <200512111647.31202.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111652.10906.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is impossible to resume from disk on x86-64 machines due to the changes
introduced by the x86_64-hpet-overflow patch.  The problem is known
(appeared in -mm1), but there's no official fix yet.

The appended patch fixes the issue, although I'm not sure if this is the right
fix.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 arch/x86_64/kernel/time.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/x86_64/kernel/time.c	2005-12-08 22:57:33.000000000 +0100
+++ linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c	2005-12-09 14:37:31.000000000 +0100
@@ -65,6 +65,7 @@ unsigned long hpet_tick;
 static int hpet_use_timer;
 unsigned long vxtime_hz = PIT_TICK_RATE;
 unsigned long long monotonic_base;
+static int vxtime_last_invalid;		/* for the interrupt handler */
 static int report_lost_ticks;			/* command line option */
 
 
@@ -417,6 +418,13 @@ static irqreturn_t timer_interrupt(int i
 
 	rdtscll_sync(&tsc);
 
+	if (vxtime_last_invalid) {
+		if (vxtime.mode == VXTIME_HPET)
+			vxtime.last = offset;
+		vxtime.last_tsc = tsc;
+		vxtime_last_invalid = 0;
+	}
+
 	if (vxtime.mode == VXTIME_HPET) {
 		if (hpet64 > 0) {
 			unsigned long delta = offset - vxtime.last;
@@ -1125,6 +1133,7 @@ static int timer_resume(struct sys_devic
 
 	sec = ctime + clock_cmos_diff;
 	write_seqlock_irqsave(&xtime_lock,flags);
+	vxtime_last_invalid = 1;
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock,flags);
