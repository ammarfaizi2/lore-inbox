Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVFGT7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVFGT7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVFGT7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:59:49 -0400
Received: from serv01.siteground.net ([70.85.91.68]:53990 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261913AbVFGT7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:59:45 -0400
Date: Tue, 7 Jun 2005 12:58:38 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: ak@suse.de
cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These variables cause false sharing in some circumstances. However, they 
are just small pointers and 4 byte ints. So this patch would result in 
some wastage of memory since each of those pointers then would occupy a 
whole cache line.

Do we have any provisions for this situation? Or do we need a new section 
for mostly_readonly?
 
Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/time.c	2005-06-07 11:15:43.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c	2005-06-07 11:27:57.000000000 -0700
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-struct timer_opts *cur_timer = &timer_none;
+struct timer_opts *cur_timer __cacheline_aligned_mostly_readonly = &timer_none;
 
 /*
  * This is a special lock that is owned by the CPU and holds the index
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 11:26:36.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-06-07 11:27:57.000000000 -0700
@@ -18,7 +18,9 @@
 #include "mach_timer.h"
 #include <asm/hpet.h>
 
-static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec */
+static unsigned long hpet_usec_quotient __cacheline_aligned_mostly_readonly;
+			/* convert hpet clks to usec */
+
 static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
 static unsigned long hpet_last; 	/* hpet counter value at last tick*/
 static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
Index: linux-2.6.12-rc6-mm1/drivers/char/random.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/drivers/char/random.c	2005-06-07 11:13:41.000000000 -0700
+++ linux-2.6.12-rc6-mm1/drivers/char/random.c	2005-06-07 11:27:57.000000000 -0700
@@ -271,7 +271,8 @@ static int random_write_wakeup_thresh = 
  * samples to avoid wasting CPU time and reduce lock contention.
  */
 
-static int trickle_thresh = INPUT_POOL_WORDS * 28;
+static int trickle_thresh __cacheline_aligned_mostly_readonly =
+			INPUT_POOL_WORDS * 28;
 
 static DEFINE_PER_CPU(int, trickle_count) = 0;
 
