Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVJYSNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVJYSNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 14:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVJYSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 14:13:29 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:43684 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S932283AbVJYSN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 14:13:28 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-arm-kernel@lists.arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH]: 2.6.14-rc5 arch-ixp4xx/system.h: ensure flash is readable before reboot
Date: Tue, 25 Oct 2005 11:13:20 -0700
Message-ID: <001901c5d98f$c8ca0280$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200509092252.00361.robin.farine@terminus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was discussed before on l-a-k under the subject "ixp4xx flash:
don't twiddle chip selects?" (that thread starts with discussion of a
*different* patch, this is related, at least stylistically.)  The prior
discussion examined other possible places to do this patch (including within
the MTD driver).

The problem is that a machine reboot hangs because the attempt to read the
flash (the very first instruction fetch after the reset) fails as a result
of the flash being in a non-read (command) mode.

The problem is ARCH specific, I suspect it actually happens on any IXP4XX
system which has onboard flash which is used for a JFFS2 file system and
which does not have a hardware reset on the flash (I am told this applies to
any XScale because the reset line simply doesn't come out of the CPU chip.)
I can only confirm the problem on the NSLU2, it is intermittent (sometimes
very hard to reproduce).  I and other NSLU2/OpenSlug users have been running
with this patch in both LE and BE systems for maybe a month now and have not
seen the hang - so I'm confident of the fix.

The fix is to execute a flash reset command immediately before the reset,
the instruction fetch then works (fetches the instruction at address 0, as
opposed to the results of a flash command.)  The command address (0xAA) is
actually irrelevant - any address works just so long as the write ends up
going to the flash chip - hence the fix works for any endianness and any
flash layout.  It has been tested on LE builds where the address gets
changed to 0xA8 in the hardware.

Signed-off-by: John Bowler <jbowler@acm.org>

---
linux-2.6.13/.pc/25-nslu2-arch-reset.patch/include/asm-arm/arch-ixp4xx/syste
m.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/system.h	2005-09-25
23:34:14.762872391 -0700
@@ -10,6 +10,7 @@
  */

 #include <asm/hardware.h>
+#include <asm/mach-types.h>

 static inline void arch_idle(void)
 {
@@ -22,6 +23,21 @@

 static inline void arch_reset(char mode)
 {
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
+
 	if ( 1 && mode == 's') {
 		/* Jump into ROM at address 0 */
 		cpu_reset(0);
@@ -39,4 +55,3 @@
 		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
 	}
 }
-

