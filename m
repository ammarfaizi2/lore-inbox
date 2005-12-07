Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVLGFAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVLGFAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 00:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLGFAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 00:00:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:11245 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750996AbVLGFAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 00:00:45 -0500
Subject: [RFC][PATCH] x86_64:  Fix collision between pmtimer and pit/hpet
	timekeeping
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris McDermott <lcm@us.ibm.com>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 21:00:39 -0800
Message-Id: <1133931639.10613.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I thought I had caught all the problems when the no-legacy HPET support
landed close to the time that the ACPI PM timer support landed, but
apparently not. :(

On systems that do not support the HPET legacy functions (basically the
IBM x460, but there could be others), in time_init() we accidentally
fall into a PM timer conditional and set the vxtime_hz value to the PM
timer's frequency. We then use this value with the HPET for timekeeping.

This patch (which mimics the behavior in time_init_gtod) corrects the
collision.

Andi, any objections or suggestions for a better way?

thanks
-john

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index fdaddc4..fb389d2 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -913,7 +913,7 @@ void __init time_init(void)
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
 #ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport) {
+	} else if (pmtmr_ioport && !vxtime.hpet_address) {
 		vxtime_hz = PM_TIMER_FREQUENCY;
 		timename = "PM";
 		pit_init();


