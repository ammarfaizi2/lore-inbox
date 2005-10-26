Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVJZQVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVJZQVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVJZQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:21:14 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:31106 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S964806AbVJZQVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:21:14 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>, "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-arm-kernel@lists.arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH]: 2.6.14-rc5 arch-ixp4xx/system.h: ensure flash is readable before reboot
Date: Wed, 26 Oct 2005 08:50:13 -0700
Message-ID: <004201c5da44$f4f8e230$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies - I made a mistake when I split up the NSLU2 patch set.
The way the flash reset part is written makes it dependent on the
the NSLU2 header file (which defines the flash base address).

The modified version of the patch which I have attached is
independent of the other (not yet submitted) patches (i.e. it will
compile correctly without the other patches.)

Signed-off-by: John Bowler <jbowler@acm.org>

# On NSLU2 ensure that the flash is readable on system boot.

--- linux-2.6.13/include/asm-arm/arch-ixp4xx/system.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/system.h	2005-10-26 07:43:11.763839457 -0700
@@ -10,6 +10,7 @@
  */
 
 #include <asm/hardware.h>
+#include <asm/mach-types.h>
 
 static inline void arch_idle(void)
 {
@@ -22,6 +23,23 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode)
 {
+#if (defined CONFIG_MACH_NSLU2) && (defined NSLU2_FLASH_BASE)
+	/* On NSLU2 machines the flash is sometimes left in a non-read
+	 * mode, such that attempting a read will cause problems - such as
+	 * a hang.  This will prevent both hard and soft reboot since the
+	 * first thing done is to read the first instruction from the flash!
+	 * Therefore issue a flash reset command here.
+	 */
+	if ( machine_is_nslu2()) {
+		/* Use the physical address here and write the reset command
+		 * to the command address (not technically necessary).  See
+		 * <linux/mtd/cfi.h> for how to calculate this for other
+		 * systems.  The NSLU2 has one bank of 16 bit flash.
+		 */
+		*(__u16*)(NSLU2_FLASH_BASE+0xAA/*command*/) = 0x00ff/*reset*/;
+	}
+#endif
+
 	if ( 1 && mode == 's') {
 		/* Jump into ROM at address 0 */
 		cpu_reset(0);
@@ -39,4 +57,3 @@ static inline void arch_reset(char mode)
 		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
 	}
 }
-

