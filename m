Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTKRXFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTKRXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:05:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:53161 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263816AbTKRXFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:05:13 -0500
Subject: linux-2.6.0-test9-mm3_acpi-pm-monotonic-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <200311180046.14787.thomas.schlichter@web.de>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <1069109719.11424.1994.camel@cog.beaverton.ibm.com>
	 <1069110272.11438.2000.camel@cog.beaverton.ibm.com>
	 <200311180046.14787.thomas.schlichter@web.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069196353.11424.2179.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Nov 2003 14:59:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 15:46, Thomas Schlichter wrote:

> Well, but the sched_clock() -> monotonic_clock() patch seems to have a 
> problem...
> First, everything works smoothly if the PIT or the TSC clock are selected. (It 
> seems I cannot test the HPET timer due to missing hardware support)
> 
> But when booting with the PMTMR clock selected, my Interactivity test fails 
> again. :-( Maybe there is a problem in the PMTMR's monotonic clock part...?!

Good call! I was mis-adding in conversion to nanoseconds. The patch
below should fix it (Andrew, feel free to ignore this, I'll sync up all
the acpi-pm changes with you later). 

Although I'm finding that the sched_clock->monotonic_clock patch doesn't
look like a win. With that patch sched_clock takes ~400-700 cycles using
clock=pmtmr. With your "fix-sched_clock.diff" patch its less then 40
cycles. 

While better accuracy is nice, I can't imagine the 10-20x cost of
sched_clock is worth it. So I think your fix is the best solution.

thanks
-john


diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	Tue Nov 18 14:17:27 2003
+++ b/arch/i386/kernel/timers/timer_pm.c	Tue Nov 18 14:17:27 2003
@@ -149,8 +149,8 @@
 	
 
 	/* convert to nanoseconds */
-	ret = base + ((this_offset - last_offset) & ACPI_PM_MASK);
-	ret = cyc2us(ret)*1000;
+	ret = ((this_offset - last_offset) & ACPI_PM_MASK);
+	ret = base + (cyc2us(ret)*1000);
 	return ret;
 }
 





