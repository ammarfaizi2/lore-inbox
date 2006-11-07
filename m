Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753877AbWKGAVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbWKGAVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbWKGAVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:21:53 -0500
Received: from deeprooted.net ([216.254.16.51]:27581 "EHLO paris.hilman.org")
	by vger.kernel.org with ESMTP id S1753877AbWKGAVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:21:52 -0500
Message-Id: <20061107002140.662370000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 06 Nov 2006 16:21:40 -0800
From: Kevin Hilman <khilman@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rt7 1/1] ARM: add latency timing support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add latency-timing support for IXP4xx.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: linux-2.6.18/include/asm-arm/arch-ixp4xx/timex.h
===================================================================
--- linux-2.6.18.orig/include/asm-arm/arch-ixp4xx/timex.h
+++ linux-2.6.18/include/asm-arm/arch-ixp4xx/timex.h
@@ -13,3 +13,11 @@
 #define FREQ 66666666
 #define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
 
+extern u64 ixp4xx_get_cycles(void);
+#define mach_read_cycles() ixp4xx_get_cycles()
+
+#ifdef CONFIG_LATENCY_TIMING
+#define mach_cycles_to_usecs(d) (((d) * ((1000000LL << 32) / CLOCK_TICK_RATE)) >> 32)
+#define mach_usecs_to_cycles(d) (((d) * (((long long)CLOCK_TICK_RATE << 32) / 1000000)) >> 32)
+#endif
+
Index: linux-2.6.18/include/asm-arm/timex.h
===================================================================
--- linux-2.6.18.orig/include/asm-arm/timex.h
+++ linux-2.6.18/include/asm-arm/timex.h
@@ -19,8 +19,12 @@ typedef unsigned long cycles_t;
 #ifndef mach_read_cycles
  #define mach_read_cycles() (0)
 #ifdef CONFIG_LATENCY_TIMING
- #define mach_cycles_to_usecs(d) (d)
- #define mach_usecs_to_cycles(d) (d)
+ #ifndef mach_cycles_to_usecs
+  #define mach_cycles_to_usecs(d) (d)
+ #endif
+ #ifndef mach_usecs_to_cycles
+  #define mach_usecs_to_cycles(d) (d)
+ #endif
 #endif
 #endif
 
--
