Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUCDTXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCDTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:23:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21010 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262116AbUCDTXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:23:01 -0500
Date: Thu, 4 Mar 2004 19:22:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] Fix i8042 PS/2 mouse on ARM
Message-ID: <20040304192257.A13227@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

This patch is required on ARM so that we pick up the correct AUX
interrupt number.  Some machines (eg, NetWinders) use IRQ5 instead
of IRQ12 for the PS/2 mouse.

Please comment, and let me know if you're happy to apply it, or
whether you're happy for me to do so.

Thanks.

--- orig/drivers/input/serio/i8042-io.h	Tue Jun 17 12:56:28 2003
+++ linux/drivers/input/serio/i8042-io.h	Thu Mar  4 19:21:28 2004
@@ -25,6 +25,8 @@
 #elif defined(__ia64__)
 # define I8042_KBD_IRQ isa_irq_to_vector(1)
 # define I8042_AUX_IRQ isa_irq_to_vector(12)
+#elif defined(__arm__)
+/* defined in include/asm-arm/arch-*/irqs.h */
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12
--- orig/include/asm-arm/arch-ebsa285/irqs.h	Mon May  5 17:40:03 2003
+++ linux/include/asm-arm/arch-ebsa285/irqs.h	Thu Mar  4 19:20:22 2004
@@ -91,8 +91,8 @@
 
 #undef RTC_IRQ
 #define RTC_IRQ		IRQ_ISA_RTC_ALARM
-#undef AUX_IRQ
-#define AUX_IRQ		(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
+#define I8042_KBD_IRQ	IRQ_ISA_KEYBOARD
+#define I8042_AUX_IRQ	(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
 #define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
 
 #define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
--- orig/include/asm-arm/arch-shark/irqs.h	Thu Nov 28 16:45:28 2002
+++ linux/include/asm-arm/arch-shark/irqs.h	Thu Mar  4 19:21:02 2004
@@ -8,5 +8,6 @@
 
 #define IRQ_ISA_KEYBOARD	 1
 #define RTC_IRQ			 8
-#define AUX_IRQ			12
+#define I8042_KBD_IRQ		 1
+#define I8042_AUX_IRQ		12
 #define IRQ_HARDDISK            14

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
