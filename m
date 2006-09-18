Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWIRNsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWIRNsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWIRNsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:48:07 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:33990 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751653AbWIRNsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:48:06 -0400
Date: Mon, 18 Sep 2006 15:49:50 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] AVR32: Fix __const_udelay overflow bug
Message-ID: <20060918154950.5ee9509e@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During testing it was discovered that mdelay() didn't provide as long
delay as it should. The reason is that __const_udelay() should have
stored the result of (loops_per_jiffy * HZ * xloops) in a 64-bit
register pair but didn't.

Fix the problem by doing a 32 x 32 => 64 bit multiplication in inline
assembly. This could probably have been solved by some casting, but IMO
the inline asm makes the intention more clear. As an added bonus, the
new code looks more like the i386 code.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/lib/delay.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.18-avr32/arch/avr32/lib/delay.c
===================================================================
--- linux-2.6.18-avr32.orig/arch/avr32/lib/delay.c	2006-09-15 10:27:02.000000000 +0200
+++ linux-2.6.18-avr32/arch/avr32/lib/delay.c	2006-09-15 10:33:08.000000000 +0200
@@ -37,7 +37,9 @@ inline void __const_udelay(unsigned long
 {
 	unsigned long long loops;
 
-	loops = (current_cpu_data.loops_per_jiffy * HZ) * xloops;
+	asm("mulu.d %0, %1, %2"
+	    : "=r"(loops)
+	    : "r"(current_cpu_data.loops_per_jiffy * HZ), "r"(xloops));
 	__delay(loops >> 32);
 }
 
