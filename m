Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWIMIAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIMIAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWIMIAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:00:47 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:57309 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750711AbWIMIAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:00:46 -0400
Date: Wed, 13 Sep 2006 10:01:56 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] AVR32: Don't leave DBE set when resetting CPU
Message-ID: <20060913100156.0181b1f5@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reset the CPU by setting the RES bit in the DC (Development
Control) register, we must ensure that DBE (Debug Enable) is set as
well, or the CPU will just ignore the reset request.

However, if we set both at the same time, DBE will stay set after
reset, and the performance will degrade significantly because
important optimizations like branch prediction will be disabled.

Setting DBE first, and then RES, will reset the CPU without keeping
DBE set after reset.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/process.c |    3 ++-
 include/asm-avr32/ocd.h     |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm3/arch/avr32/kernel/process.c
===================================================================
--- linux-2.6.18-rc4-mm3.orig/arch/avr32/kernel/process.c	2006-08-28 10:26:33.000000000 +0200
+++ linux-2.6.18-rc4-mm3/arch/avr32/kernel/process.c	2006-08-29 14:42:27.000000000 +0200
@@ -46,7 +46,8 @@ void machine_power_off(void)
 
 void machine_restart(char *cmd)
 {
-	__mtdr(DBGREG_DC, 0x40002000);
+	__mtdr(DBGREG_DC, DC_DBE);
+	__mtdr(DBGREG_DC, DC_RES);
 	while (1) ;
 }
 
Index: linux-2.6.18-rc4-mm3/include/asm-avr32/ocd.h
===================================================================
--- linux-2.6.18-rc4-mm3.orig/include/asm-avr32/ocd.h	2006-08-29 15:06:41.000000000 +0200
+++ linux-2.6.18-rc4-mm3/include/asm-avr32/ocd.h	2006-08-29 15:10:08.000000000 +0200
@@ -57,6 +57,7 @@
 #define DC_RID			(1 << 27)
 #define DC_ORP			(1 << 28)
 #define DC_MM			(1 << 29)
+#define DC_RES			(1 << 30)
 
 /* Fields in the Development Status register */
 #define DS_SSS			(1 <<  0)
