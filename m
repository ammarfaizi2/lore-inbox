Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVFNWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVFNWzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVFNWzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:55:51 -0400
Received: from serv01.siteground.net ([70.85.91.68]:25243 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261395AbVFNWz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:55:29 -0400
Date: Tue, 14 Jun 2005 15:54:24 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050608131839.GP23831@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005, Andi Kleen wrote:

> However this means __cacheline_aligned_mostly_readonly doesnt make much
> sense since there is no need for alignment in read only. How about
> replacing it with a __mostly_readonly that doesnt align and remove
> __cacheline_aligned_mostly_readonly? 

Hmm. No. The bigger cpu maps may benefit from cacheline alignment for 
even for read access. Here is a patch that introduces __mostly_readonly in 
addition to __cacheline_aligned_mostly_readonly:

---

Create a new __mostly_readonly attribute.

Turns out that some smaller entities would also benefit from placement
with other variables that are mostly readonly. The following patch
introduces the __mostly_readonly attribute. This is simply the
__cacheline_aligned_most_readonly attribute without the cacheline
alignment.

The patch places cur_timer, hpet_usec_quotient and trickle_thresh
into that section.
 
Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>

Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/time.c	2005-06-14 15:43:18.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c	2005-06-14 15:43:19.000000000 -0700
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-struct timer_opts *cur_timer = &timer_none;
+struct timer_opts *cur_timer __mostly_readonly = &timer_none;
 
 /*
  * This is a special lock that is owned by the CPU and holds the index
Index: linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/i386/kernel/timers/timer_hpet.c	2005-06-14 15:43:18.000000000 -0700
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-06-14 15:43:19.000000000 -0700
@@ -18,7 +18,9 @@
 #include "mach_timer.h"
 #include <asm/hpet.h>
 
-static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec */
+static unsigned long hpet_usec_quotient __mostly_readonly;
+			/* convert hpet clks to usec */
+
 static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
 static unsigned long hpet_last; 	/* hpet counter value at last tick*/
 static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
Index: linux-2.6.12-rc6-mm1/drivers/char/random.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/drivers/char/random.c	2005-06-14 15:43:18.000000000 -0700
+++ linux-2.6.12-rc6-mm1/drivers/char/random.c	2005-06-14 15:43:19.000000000 -0700
@@ -271,7 +271,8 @@ static int random_write_wakeup_thresh = 
  * samples to avoid wasting CPU time and reduce lock contention.
  */
 
-static int trickle_thresh = INPUT_POOL_WORDS * 28;
+static int trickle_thresh __mostly_readonly =
+			INPUT_POOL_WORDS * 28;
 
 static DEFINE_PER_CPU(int, trickle_count) = 0;
 
Index: linux-2.6.12-rc6-mm1/include/linux/cache.h
===================================================================
--- linux-2.6.12-rc6-mm1.orig/include/linux/cache.h	2005-06-14 15:43:18.000000000 -0700
+++ linux-2.6.12-rc6-mm1/include/linux/cache.h	2005-06-14 15:46:58.000000000 -0700
@@ -26,9 +26,13 @@
 #endif
 
 #if defined(CONFIG_X86)
+
+#define __mostly_readonly __attribute__((__section__(".data.mostly_readonly")))
+
 #define __cacheline_aligned_mostly_readonly		\
   __attribute__((__aligned__(SMP_CACHE_BYTES),		\
 		 __section__(".data.mostly_readonly")))
+
 #else
 #define __cacheline_aligned_mostly_readonly __cacheline_aligned
 #endif
