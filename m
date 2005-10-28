Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVJ1HAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVJ1HAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVJ1HAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:00:48 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:29868 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S965125AbVJ1HAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:00:42 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/timex.h: fix clock frequency on NSLU2
Date: Thu, 27 Oct 2005 23:32:25 -0700
Message-ID: <001101c5db89$5d5b1560$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The basis for this patch has been discussed on l-a-k on a thread
with subject line "IXP4xx timer interupt bug" then later on 
nslu2-developers@nslu2-linux.org on a thread "ixp4xx variable
timer base issue".

The problem is that the NSLU2 deviates from the Intel IXDP425
system by using a cystal with frequency 66MHz as opposed to the
Intel stated (not quite mandated) value of 66.666666MHz.  This
results in serious errors in the RTC (1%).

The patch configs in the correct value for the NSLU2.  The problem
with the patch is that a multi-config kernel which includes NSLU2
support will use the NSLU2 frequency.  However such kernels are
not a requirement as generic kernels are never flashed into NSLU2
systems (so there is no need to build NSLU2 support into a generic
kernel).

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.13.1/include/asm-arm/arch-ixp4xx/timex.h	2005-09-17 12:42:45.000000000 +0200
+++ nslu2-2.6.13.1/include/asm-arm/arch-ixp4xx/timex.h	2005-09-17 12:15:31.000000000 +0200
@@ -9,7 +9,12 @@
  * We use IXP425 General purpose timer for our timer needs, it runs at 
  * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
  * timer register ignores the bottom 2 bits of the LATCH value.
+ * The NSLU2 has a 33.00MHz crystal, so a different FREQ is required.
  */
+#ifdef CONFIG_MACH_NSLU2
+#define FREQ 66000000
+#else
 #define FREQ 66666666
+#endif
 #define CLOCK_TICK_RATE (((FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
 

