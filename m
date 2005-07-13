Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVGMSkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVGMSkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVGMSiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:38:08 -0400
Received: from fmr23.intel.com ([143.183.121.15]:19106 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262239AbVGMSgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:36:32 -0400
Date: Wed, 13 Jul 2005 11:36:24 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use read_timer_tsc only when CPU has TSC
Message-ID: <20050713113624.A18452@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Only use read_timer_tsc only when CPU has TSC. Thanks to Andrea for 
pointing this out. Should not be issue on any platforms as all
recent systems that has HPET also has CPUs that supports TSC. The patch is
still required for correctness.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN  linux-2.6.13-rc1/arch/i386/kernel/timers/timer_hpet.c.org linux-2.6.13-rc1/arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.13-rc1/arch/i386/kernel/timers/timer_hpet.c.org	2005-07-13 08:12:11.846794648 -0700
+++ linux-2.6.13-rc1/arch/i386/kernel/timers/timer_hpet.c	2005-07-13 08:17:25.055179736 -0700
@@ -136,6 +136,8 @@ static void delay_hpet(unsigned long loo
 	} while ((hpet_end - hpet_start) < (loops));
 }
 
+static struct timer_opts timer_hpet;
+
 static int __init init_hpet(char* override)
 {
 	unsigned long result, remain;
@@ -163,6 +165,8 @@ static int __init init_hpet(char* overri
 			}
 			set_cyc2ns_scale(cpu_khz/1000);
 		}
+		/* set this only when cpu_has_tsc */
+		timer_hpet.read_timer = read_timer_tsc;
 	}
 
 	/*
@@ -186,7 +190,6 @@ static struct timer_opts timer_hpet = {
 	.get_offset =		get_offset_hpet,
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
-	.read_timer = 		read_timer_tsc,
 };
 
 struct init_timer_opts __initdata timer_hpet_init = {
