Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVLLH5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVLLH5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVLLH5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:57:42 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63842
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751124AbVLLH5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:57:42 -0500
Message-Id: <439D3BAC.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 12 Dec 2005 08:58:20 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Rafael Wysocki" <rjw@sisk.pl>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume
	from disk)
References: <20051204232153.258cd554.akpm@osdl.org>  <200512091220.06060.rjw@sisk.pl>  <439989A7.76F0.0078.0@novell.com> <200512091834.38960.rjw@sisk.pl>
In-Reply-To: <200512091834.38960.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is the appended patch better than the previous one?

It looks better, but still not ideal. While I hinted towards using a
flag, I didn't necessarily mean this in the exact sense (I just didn't
look at how exactly the resume code is structured, nor did I exactly
remember how the init code sets up things). Now having looked at the
code, it'd seem to me that resume should just duplicate part of what
init() does: initialize vxtime.last and/or vxtime.last_tsc. But for
making things accurate, the value stored in vxtime.last_tsc may need
adjustment (so that it matches the value that would have been stored one
timer tick before the first timer tick after resume).

I'm sorry for not immediately coming up with an appropriate patch
myself, but I'm currently hunting down a problem more severe than broken
resume (and Andi indicated he wants some polishing done on the original
patch anyway).

Jan

***************

 arch/x86_64/kernel/time.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c
===================================================================
---
linux-2.6.15-rc5-mm1.orig/arch/x86_64/kernel/time.c	2005-12-08
22:57:33.000000000 +0100
+++ linux-2.6.15-rc5-mm1/arch/x86_64/kernel/time.c	2005-12-09
14:37:31.000000000 +0100
@@ -65,6 +65,7 @@ unsigned long hpet_tick;
 static int hpet_use_timer;
 unsigned long vxtime_hz = PIT_TICK_RATE;
 unsigned long long monotonic_base;
+static int vxtime_last_invalid;		/* for the interrupt
handler */
 static int report_lost_ticks;			/* command line option
*/
 
 
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
