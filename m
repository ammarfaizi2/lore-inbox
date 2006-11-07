Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWKGQnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWKGQnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWKGQnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:43:43 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:25982 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S965230AbWKGQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:43:42 -0500
Message-ID: <4550B7BA.7080906@mvista.com>
Date: Tue, 07 Nov 2006 08:43:38 -0800
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rt7 1/1] ARM: add latency timing support
References: <20061107002140.662370000@mvista.com>
In-Reply-To: <20061107002140.662370000@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080403060004020003030205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080403060004020003030205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote:
> Add latency-timing support for IXP4xx.

On second thought, here's a better patch that will cover all ARM
subarches.  Each sub-arch only has to implement mach_get_cycles()

Signed-off-by: Kevin Hilman <khilman@mvista.com>


--------------080403060004020003030205
Content-Type: text/x-patch;
 name="arm_latency_timing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_latency_timing.patch"

Index: linux-2.6.18/include/asm-arm/arch-ixp4xx/timex.h
===================================================================
--- linux-2.6.18.orig/include/asm-arm/arch-ixp4xx/timex.h
+++ linux-2.6.18/include/asm-arm/arch-ixp4xx/timex.h
@@ -13,3 +13,5 @@
 #define FREQ 66666666
 #define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
 
+extern u64 ixp4xx_get_cycles(void);
+#define mach_read_cycles() ixp4xx_get_cycles()
Index: linux-2.6.18/include/asm-arm/timex.h
===================================================================
--- linux-2.6.18.orig/include/asm-arm/timex.h
+++ linux-2.6.18/include/asm-arm/timex.h
@@ -18,10 +18,13 @@ typedef unsigned long cycles_t;
 
 #ifndef mach_read_cycles
  #define mach_read_cycles() (0)
-#ifdef CONFIG_LATENCY_TIMING
- #define mach_cycles_to_usecs(d) (d)
- #define mach_usecs_to_cycles(d) (d)
 #endif
+
+#ifdef CONFIG_LATENCY_TIMING
+ #define mach_cycles_to_usecs(d) \
+   (((d) * ((1000000LL << 32) / CLOCK_TICK_RATE)) >> 32)
+ #define mach_usecs_to_cycles(d) \
+   (((d) * (((long long)CLOCK_TICK_RATE << 32) / 1000000)) >> 32)
 #endif
 
 static inline cycles_t get_cycles (void)
Index: linux-2.6.18/include/asm-arm/arch-pxa/timex.h
===================================================================
--- linux-2.6.18.orig/include/asm-arm/arch-pxa/timex.h
+++ linux-2.6.18/include/asm-arm/arch-pxa/timex.h
@@ -26,5 +26,3 @@
 #endif
 
 #define mach_read_cycles() OSCR
-#define mach_cycles_to_usecs(d) (((d) * ((1000000LL << 32) / CLOCK_TICK_RATE)) >> 32)
-#define mach_usecs_to_cycles(d) (((d) * (((long long)CLOCK_TICK_RATE << 32) / 1000000)) >> 32)

--------------080403060004020003030205--
