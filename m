Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUIWF1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUIWF1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUIWF1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:27:43 -0400
Received: from holomorphy.com ([207.189.100.168]:23508 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268282AbUIWF1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:27:39 -0400
Date: Wed, 22 Sep 2004 22:27:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-ID: <20040923052735.GA9106@holomorphy.com>
References: <20040922131210.6c08b94c.akpm@osdl.org> <20040923050740.GZ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923050740.GZ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 01:12:10PM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
>> - Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, aka
>>   the "zaphod" cpu scheduler.
>>   It has a number of tunables and lots of documentation - see the changelog
>>   entry in zaphod-scheduler.patch for details.

On Wed, Sep 22, 2004 at 10:07:40PM -0700, William Lee Irwin III wrote:
> Something's a tad off here. Should be easy enough to fix up.
[...]
> TPC: <sched_clock+0xc/0x40>

And easy it was indeed.


Index: mm2-2.6.9-rc2/arch/sparc64/kernel/time.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/sparc64/kernel/time.c	2004-09-22 21:33:03.000000000 -0700
+++ mm2-2.6.9-rc2/arch/sparc64/kernel/time.c	2004-09-22 22:16:00.647460690 -0700
@@ -1052,12 +1052,14 @@
 #endif
 }
 
+/* would be nice if we weren't called before time_init() */
 unsigned long long sched_clock(void)
 {
-	unsigned long ticks = tick_ops->get_tick();
-
-	return (ticks * timer_ticks_per_nsec_quotient)
-		>> SPARC64_NSEC_PER_CYC_SHIFT;
+	if (likely(tick_ops))
+		return (tick_ops->get_tick() * timer_ticks_per_nsec_quotient)
+			>> SPARC64_NSEC_PER_CYC_SHIFT;
+	else
+		return 0;
 }
 
 static int set_rtc_mmss(unsigned long nowtime)
