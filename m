Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWIKXVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWIKXVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWIKXUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:20:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:44816 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S964966AbWIKXUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:20:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869912:sNHT491145683"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 17/19] iop3xx: define IOP3XX_REG_ADDR[32|16|8] and clean up DMA/AAU defs
Date: Mon, 11 Sep 2006 16:19:05 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231905.4737.15667.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Also brings the iop3xx registers in line with the format of the iop13xx
register definitions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 include/asm-arm/arch-iop32x/entry-macro.S |    2 
 include/asm-arm/arch-iop32x/iop32x.h      |   14 +
 include/asm-arm/arch-iop33x/entry-macro.S |    2 
 include/asm-arm/arch-iop33x/iop33x.h      |   38 ++-
 include/asm-arm/hardware/iop3xx.h         |  347 +++++++++++++----------------
 5 files changed, 188 insertions(+), 215 deletions(-)

diff --git a/include/asm-arm/arch-iop32x/entry-macro.S b/include/asm-arm/arch-iop32x/entry-macro.S
index 1500cbb..f357be4 100644
--- a/include/asm-arm/arch-iop32x/entry-macro.S
+++ b/include/asm-arm/arch-iop32x/entry-macro.S
@@ -13,7 +13,7 @@ #include <asm/arch/iop32x.h>
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =IOP3XX_REG_ADDR(0x07D8)
+		ldr	\base, =0xfeffe7d8
 		ldr	\irqstat, [\base]		@ Read IINTSRC
 		cmp	\irqstat, #0
 		clzne	\irqnr, \irqstat
diff --git a/include/asm-arm/arch-iop32x/iop32x.h b/include/asm-arm/arch-iop32x/iop32x.h
index 15b4d6a..904a14d 100644
--- a/include/asm-arm/arch-iop32x/iop32x.h
+++ b/include/asm-arm/arch-iop32x/iop32x.h
@@ -19,16 +19,18 @@ #define __IOP32X_H
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07c0 + (reg))
-#define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07e0 + (reg))
+#define IOP3XX_GPIO_REG32(reg)	 (volatile u32 *)(IOP3XX_PERIPHERAL_VIRT_BASE +\
+						  0x07c0 + (reg))
+#define IOP3XX_TIMER_REG32(reg) (volatile u32 *)(IOP3XX_PERIPHERAL_VIRT_BASE +\
+						  0x07e0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
 
 /* Interrupt Controller  */
-#define IOP32X_INTCTL		(volatile u32 *)IOP3XX_REG_ADDR(0x07d0)
-#define IOP32X_INTSTR		(volatile u32 *)IOP3XX_REG_ADDR(0x07d4)
-#define IOP32X_IINTSRC		(volatile u32 *)IOP3XX_REG_ADDR(0x07d8)
-#define IOP32X_FINTSRC		(volatile u32 *)IOP3XX_REG_ADDR(0x07dc)
+#define IOP32X_INTCTL		IOP3XX_REG_ADDR32(0x07d0)
+#define IOP32X_INTSTR		IOP3XX_REG_ADDR32(0x07d4)
+#define IOP32X_IINTSRC		IOP3XX_REG_ADDR32(0x07d8)
+#define IOP32X_FINTSRC		IOP3XX_REG_ADDR32(0x07dc)
 
 
 #endif
diff --git a/include/asm-arm/arch-iop33x/entry-macro.S b/include/asm-arm/arch-iop33x/entry-macro.S
index 92b7917..eb207d2 100644
--- a/include/asm-arm/arch-iop33x/entry-macro.S
+++ b/include/asm-arm/arch-iop33x/entry-macro.S
@@ -13,7 +13,7 @@ #include <asm/arch/iop33x.h>
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =IOP3XX_REG_ADDR(0x07C8)
+		ldr	\base, =0xfeffe7c8
 		ldr	\irqstat, [\base]		@ Read IINTVEC
 		cmp	\irqstat, #0
 		ldreq	\irqstat, [\base]		@ erratum 63 workaround
diff --git a/include/asm-arm/arch-iop33x/iop33x.h b/include/asm-arm/arch-iop33x/iop33x.h
index 9b38fde..c171383 100644
--- a/include/asm-arm/arch-iop33x/iop33x.h
+++ b/include/asm-arm/arch-iop33x/iop33x.h
@@ -18,28 +18,30 @@ #define __IOP33X_H
  * Peripherals that are shared between the iop32x and iop33x but
  * located at different addresses.
  */
-#define IOP3XX_GPIO_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x1780 + (reg))
-#define IOP3XX_TIMER_REG(reg)	(IOP3XX_PERIPHERAL_VIRT_BASE + 0x07d0 + (reg))
+#define IOP3XX_GPIO_REG32(reg)	 (volatile u32 *)(IOP3XX_PERIPHERAL_VIRT_BASE +\
+						  0x1780 + (reg))
+#define IOP3XX_TIMER_REG32(reg) (volatile u32 *)(IOP3XX_PERIPHERAL_VIRT_BASE +\
+						  0x07d0 + (reg))
 
 #include <asm/hardware/iop3xx.h>
 
 /* Interrupt Controller  */
-#define IOP33X_INTCTL0		(volatile u32 *)IOP3XX_REG_ADDR(0x0790)
-#define IOP33X_INTCTL1		(volatile u32 *)IOP3XX_REG_ADDR(0x0794)
-#define IOP33X_INTSTR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0798)
-#define IOP33X_INTSTR1		(volatile u32 *)IOP3XX_REG_ADDR(0x079c)
-#define IOP33X_IINTSRC0		(volatile u32 *)IOP3XX_REG_ADDR(0x07a0)
-#define IOP33X_IINTSRC1		(volatile u32 *)IOP3XX_REG_ADDR(0x07a4)
-#define IOP33X_FINTSRC0		(volatile u32 *)IOP3XX_REG_ADDR(0x07a8)
-#define IOP33X_FINTSRC1		(volatile u32 *)IOP3XX_REG_ADDR(0x07ac)
-#define IOP33X_IPR0		(volatile u32 *)IOP3XX_REG_ADDR(0x07b0)
-#define IOP33X_IPR1		(volatile u32 *)IOP3XX_REG_ADDR(0x07b4)
-#define IOP33X_IPR2		(volatile u32 *)IOP3XX_REG_ADDR(0x07b8)
-#define IOP33X_IPR3		(volatile u32 *)IOP3XX_REG_ADDR(0x07bc)
-#define IOP33X_INTBASE		(volatile u32 *)IOP3XX_REG_ADDR(0x07c0)
-#define IOP33X_INTSIZE		(volatile u32 *)IOP3XX_REG_ADDR(0x07c4)
-#define IOP33X_IINTVEC		(volatile u32 *)IOP3XX_REG_ADDR(0x07c8)
-#define IOP33X_FINTVEC		(volatile u32 *)IOP3XX_REG_ADDR(0x07cc)
+#define IOP33X_INTCTL0		IOP3XX_REG_ADDR32(0x0790)
+#define IOP33X_INTCTL1		IOP3XX_REG_ADDR32(0x0794)
+#define IOP33X_INTSTR0		IOP3XX_REG_ADDR32(0x0798)
+#define IOP33X_INTSTR1		IOP3XX_REG_ADDR32(0x079c)
+#define IOP33X_IINTSRC0	IOP3XX_REG_ADDR32(0x07a0)
+#define IOP33X_IINTSRC1	IOP3XX_REG_ADDR32(0x07a4)
+#define IOP33X_FINTSRC0	IOP3XX_REG_ADDR32(0x07a8)
+#define IOP33X_FINTSRC1	IOP3XX_REG_ADDR32(0x07ac)
+#define IOP33X_IPR0		IOP3XX_REG_ADDR32(0x07b0)
+#define IOP33X_IPR1		IOP3XX_REG_ADDR32(0x07b4)
+#define IOP33X_IPR2		IOP3XX_REG_ADDR32(0x07b8)
+#define IOP33X_IPR3		IOP3XX_REG_ADDR32(0x07bc)
+#define IOP33X_INTBASE		IOP3XX_REG_ADDR32(0x07c0)
+#define IOP33X_INTSIZE		IOP3XX_REG_ADDR32(0x07c4)
+#define IOP33X_IINTVEC		IOP3XX_REG_ADDR32(0x07c8)
+#define IOP33X_FINTVEC		IOP3XX_REG_ADDR32(0x07cc)
 
 /* UARTs  */
 #define IOP33X_UART0_PHYS	(IOP3XX_PERIPHERAL_PHYS_BASE + 0x1700)
diff --git a/include/asm-arm/hardware/iop3xx.h b/include/asm-arm/hardware/iop3xx.h
index b5c12ef..295789a 100644
--- a/include/asm-arm/hardware/iop3xx.h
+++ b/include/asm-arm/hardware/iop3xx.h
@@ -34,153 +34,166 @@ #endif
 /*
  * IOP3XX processor registers
  */
-#define IOP3XX_PERIPHERAL_PHYS_BASE	0xffffe000
-#define IOP3XX_PERIPHERAL_VIRT_BASE	0xfeffe000
-#define IOP3XX_PERIPHERAL_SIZE		0x00002000
-#define IOP3XX_REG_ADDR(reg)		(IOP3XX_PERIPHERAL_VIRT_BASE + (reg))
+#define IOP3XX_PERIPHERAL_PHYS_BASE 0xffffe000
+#define IOP3XX_PERIPHERAL_VIRT_BASE 0xfeffe000
+#define IOP3XX_PERIPHERAL_SIZE	     0x00002000
+#define IOP3XX_REG_ADDR32(reg)	     (volatile u32 *)(IOP3XX_PERIPHERAL_VIRT_BASE + (reg))
+#define IOP3XX_REG_ADDR16(reg)	     (volatile u16 *)(IOP3XX_PERIPHERAL_VIRT_BASE + (reg))
+#define IOP3XX_REG_ADDR8(reg)	     (volatile u8 *)(IOP3XX_PERIPHERAL_VIRT_BASE + (reg))
 
 /* Address Translation Unit  */
-#define IOP3XX_ATUVID		(volatile u16 *)IOP3XX_REG_ADDR(0x0100)
-#define IOP3XX_ATUDID		(volatile u16 *)IOP3XX_REG_ADDR(0x0102)
-#define IOP3XX_ATUCMD		(volatile u16 *)IOP3XX_REG_ADDR(0x0104)
-#define IOP3XX_ATUSR		(volatile u16 *)IOP3XX_REG_ADDR(0x0106)
-#define IOP3XX_ATURID		(volatile u8  *)IOP3XX_REG_ADDR(0x0108)
-#define IOP3XX_ATUCCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0109)
-#define IOP3XX_ATUCLSR		(volatile u8  *)IOP3XX_REG_ADDR(0x010c)
-#define IOP3XX_ATULT		(volatile u8  *)IOP3XX_REG_ADDR(0x010d)
-#define IOP3XX_ATUHTR		(volatile u8  *)IOP3XX_REG_ADDR(0x010e)
-#define IOP3XX_ATUBIST		(volatile u8  *)IOP3XX_REG_ADDR(0x010f)
-#define IOP3XX_IABAR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0110)
-#define IOP3XX_IAUBAR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0114)
-#define IOP3XX_IABAR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0118)
-#define IOP3XX_IAUBAR1		(volatile u32 *)IOP3XX_REG_ADDR(0x011c)
-#define IOP3XX_IABAR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0120)
-#define IOP3XX_IAUBAR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0124)
-#define IOP3XX_ASVIR		(volatile u16 *)IOP3XX_REG_ADDR(0x012c)
-#define IOP3XX_ASIR		(volatile u16 *)IOP3XX_REG_ADDR(0x012e)
-#define IOP3XX_ERBAR		(volatile u32 *)IOP3XX_REG_ADDR(0x0130)
-#define IOP3XX_ATUILR		(volatile u8  *)IOP3XX_REG_ADDR(0x013c)
-#define IOP3XX_ATUIPR		(volatile u8  *)IOP3XX_REG_ADDR(0x013d)
-#define IOP3XX_ATUMGNT		(volatile u8  *)IOP3XX_REG_ADDR(0x013e)
-#define IOP3XX_ATUMLAT		(volatile u8  *)IOP3XX_REG_ADDR(0x013f)
-#define IOP3XX_IALR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0140)
-#define IOP3XX_IATVR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0144)
-#define IOP3XX_ERLR		(volatile u32 *)IOP3XX_REG_ADDR(0x0148)
-#define IOP3XX_ERTVR		(volatile u32 *)IOP3XX_REG_ADDR(0x014c)
-#define IOP3XX_IALR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0150)
-#define IOP3XX_IALR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0154)
-#define IOP3XX_IATVR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0158)
-#define IOP3XX_OIOWTVR		(volatile u32 *)IOP3XX_REG_ADDR(0x015c)
-#define IOP3XX_OMWTVR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0160)
-#define IOP3XX_OUMWTVR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0164)
-#define IOP3XX_OMWTVR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0168)
-#define IOP3XX_OUMWTVR1		(volatile u32 *)IOP3XX_REG_ADDR(0x016c)
-#define IOP3XX_OUDWTVR		(volatile u32 *)IOP3XX_REG_ADDR(0x0178)
-#define IOP3XX_ATUCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0180)
-#define IOP3XX_PCSR		(volatile u32 *)IOP3XX_REG_ADDR(0x0184)
-#define IOP3XX_ATUISR		(volatile u32 *)IOP3XX_REG_ADDR(0x0188)
-#define IOP3XX_ATUIMR		(volatile u32 *)IOP3XX_REG_ADDR(0x018c)
-#define IOP3XX_IABAR3		(volatile u32 *)IOP3XX_REG_ADDR(0x0190)
-#define IOP3XX_IAUBAR3		(volatile u32 *)IOP3XX_REG_ADDR(0x0194)
-#define IOP3XX_IALR3		(volatile u32 *)IOP3XX_REG_ADDR(0x0198)
-#define IOP3XX_IATVR3		(volatile u32 *)IOP3XX_REG_ADDR(0x019c)
-#define IOP3XX_OCCAR		(volatile u32 *)IOP3XX_REG_ADDR(0x01a4)
-#define IOP3XX_OCCDR		(volatile u32 *)IOP3XX_REG_ADDR(0x01ac)
-#define IOP3XX_PDSCR		(volatile u32 *)IOP3XX_REG_ADDR(0x01bc)
-#define IOP3XX_PMCAPID		(volatile u8  *)IOP3XX_REG_ADDR(0x01c0)
-#define IOP3XX_PMNEXT		(volatile u8  *)IOP3XX_REG_ADDR(0x01c1)
-#define IOP3XX_APMCR		(volatile u16 *)IOP3XX_REG_ADDR(0x01c2)
-#define IOP3XX_APMCSR		(volatile u16 *)IOP3XX_REG_ADDR(0x01c4)
-#define IOP3XX_PCIXCAPID	(volatile u8  *)IOP3XX_REG_ADDR(0x01e0)
-#define IOP3XX_PCIXNEXT		(volatile u8  *)IOP3XX_REG_ADDR(0x01e1)
-#define IOP3XX_PCIXCMD		(volatile u16 *)IOP3XX_REG_ADDR(0x01e2)
-#define IOP3XX_PCIXSR		(volatile u32 *)IOP3XX_REG_ADDR(0x01e4)
-#define IOP3XX_PCIIRSR		(volatile u32 *)IOP3XX_REG_ADDR(0x01ec)
+#define IOP3XX_ATUVID		IOP3XX_REG_ADDR16(0x0100)
+#define IOP3XX_ATUDID		IOP3XX_REG_ADDR16(0x0102)
+#define IOP3XX_ATUCMD		IOP3XX_REG_ADDR16(0x0104)
+#define IOP3XX_ATUSR		IOP3XX_REG_ADDR16(0x0106)
+#define IOP3XX_ATURID		IOP3XX_REG_ADDR8(0x0108)
+#define IOP3XX_ATUCCR		IOP3XX_REG_ADDR32(0x0109)
+#define IOP3XX_ATUCLSR		IOP3XX_REG_ADDR8(0x010c)
+#define IOP3XX_ATULT		IOP3XX_REG_ADDR8(0x010d)
+#define IOP3XX_ATUHTR		IOP3XX_REG_ADDR8(0x010e)
+#define IOP3XX_ATUBIST		IOP3XX_REG_ADDR8(0x010f)
+#define IOP3XX_IABAR0		IOP3XX_REG_ADDR32(0x0110)
+#define IOP3XX_IAUBAR0		IOP3XX_REG_ADDR32(0x0114)
+#define IOP3XX_IABAR1		IOP3XX_REG_ADDR32(0x0118)
+#define IOP3XX_IAUBAR1		IOP3XX_REG_ADDR32(0x011c)
+#define IOP3XX_IABAR2		IOP3XX_REG_ADDR32(0x0120)
+#define IOP3XX_IAUBAR2		IOP3XX_REG_ADDR32(0x0124)
+#define IOP3XX_ASVIR		IOP3XX_REG_ADDR16(0x012c)
+#define IOP3XX_ASIR		IOP3XX_REG_ADDR16(0x012e)
+#define IOP3XX_ERBAR		IOP3XX_REG_ADDR32(0x0130)
+#define IOP3XX_ATUILR		IOP3XX_REG_ADDR8(0x013c)
+#define IOP3XX_ATUIPR		IOP3XX_REG_ADDR8(0x013d)
+#define IOP3XX_ATUMGNT		IOP3XX_REG_ADDR8(0x013e)
+#define IOP3XX_ATUMLAT		IOP3XX_REG_ADDR8(0x013f)
+#define IOP3XX_IALR0		IOP3XX_REG_ADDR32(0x0140)
+#define IOP3XX_IATVR0		IOP3XX_REG_ADDR32(0x0144)
+#define IOP3XX_ERLR		IOP3XX_REG_ADDR32(0x0148)
+#define IOP3XX_ERTVR		IOP3XX_REG_ADDR32(0x014c)
+#define IOP3XX_IALR1		IOP3XX_REG_ADDR32(0x0150)
+#define IOP3XX_IALR2		IOP3XX_REG_ADDR32(0x0154)
+#define IOP3XX_IATVR2		IOP3XX_REG_ADDR32(0x0158)
+#define IOP3XX_OIOWTVR		IOP3XX_REG_ADDR32(0x015c)
+#define IOP3XX_OMWTVR0		IOP3XX_REG_ADDR32(0x0160)
+#define IOP3XX_OUMWTVR0	IOP3XX_REG_ADDR32(0x0164)
+#define IOP3XX_OMWTVR1		IOP3XX_REG_ADDR32(0x0168)
+#define IOP3XX_OUMWTVR1	IOP3XX_REG_ADDR32(0x016c)
+#define IOP3XX_OUDWTVR		IOP3XX_REG_ADDR32(0x0178)
+#define IOP3XX_ATUCR		IOP3XX_REG_ADDR32(0x0180)
+#define IOP3XX_PCSR		IOP3XX_REG_ADDR32(0x0184)
+#define IOP3XX_ATUISR		IOP3XX_REG_ADDR32(0x0188)
+#define IOP3XX_ATUIMR		IOP3XX_REG_ADDR32(0x018c)
+#define IOP3XX_IABAR3		IOP3XX_REG_ADDR32(0x0190)
+#define IOP3XX_IAUBAR3		IOP3XX_REG_ADDR32(0x0194)
+#define IOP3XX_IALR3		IOP3XX_REG_ADDR32(0x0198)
+#define IOP3XX_IATVR3		IOP3XX_REG_ADDR32(0x019c)
+#define IOP3XX_OCCAR		IOP3XX_REG_ADDR32(0x01a4)
+#define IOP3XX_OCCDR		IOP3XX_REG_ADDR32(0x01ac)
+#define IOP3XX_PDSCR		IOP3XX_REG_ADDR32(0x01bc)
+#define IOP3XX_PMCAPID		IOP3XX_REG_ADDR8(0x01c0)
+#define IOP3XX_PMNEXT		IOP3XX_REG_ADDR8(0x01c1)
+#define IOP3XX_APMCR		IOP3XX_REG_ADDR16(0x01c2)
+#define IOP3XX_APMCSR		IOP3XX_REG_ADDR16(0x01c4)
+#define IOP3XX_PCIXCAPID	IOP3XX_REG_ADDR8(0x01e0)
+#define IOP3XX_PCIXNEXT	IOP3XX_REG_ADDR8(0x01e1)
+#define IOP3XX_PCIXCMD		IOP3XX_REG_ADDR16(0x01e2)
+#define IOP3XX_PCIXSR		IOP3XX_REG_ADDR32(0x01e4)
+#define IOP3XX_PCIIRSR		IOP3XX_REG_ADDR32(0x01ec)
 
 /* Messaging Unit  */
-#define IOP3XX_IMR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0310)
-#define IOP3XX_IMR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0314)
-#define IOP3XX_OMR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0318)
-#define IOP3XX_OMR1		(volatile u32 *)IOP3XX_REG_ADDR(0x031c)
-#define IOP3XX_IDR		(volatile u32 *)IOP3XX_REG_ADDR(0x0320)
-#define IOP3XX_IISR		(volatile u32 *)IOP3XX_REG_ADDR(0x0324)
-#define IOP3XX_IIMR		(volatile u32 *)IOP3XX_REG_ADDR(0x0328)
-#define IOP3XX_ODR		(volatile u32 *)IOP3XX_REG_ADDR(0x032c)
-#define IOP3XX_OISR		(volatile u32 *)IOP3XX_REG_ADDR(0x0330)
-#define IOP3XX_OIMR		(volatile u32 *)IOP3XX_REG_ADDR(0x0334)
-#define IOP3XX_MUCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0350)
-#define IOP3XX_QBAR		(volatile u32 *)IOP3XX_REG_ADDR(0x0354)
-#define IOP3XX_IFHPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0360)
-#define IOP3XX_IFTPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0364)
-#define IOP3XX_IPHPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0368)
-#define IOP3XX_IPTPR		(volatile u32 *)IOP3XX_REG_ADDR(0x036c)
-#define IOP3XX_OFHPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0370)
-#define IOP3XX_OFTPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0374)
-#define IOP3XX_OPHPR		(volatile u32 *)IOP3XX_REG_ADDR(0x0378)
-#define IOP3XX_OPTPR		(volatile u32 *)IOP3XX_REG_ADDR(0x037c)
-#define IOP3XX_IAR		(volatile u32 *)IOP3XX_REG_ADDR(0x0380)
+#define IOP3XX_IMR0		IOP3XX_REG_ADDR32(0x0310)
+#define IOP3XX_IMR1		IOP3XX_REG_ADDR32(0x0314)
+#define IOP3XX_OMR0		IOP3XX_REG_ADDR32(0x0318)
+#define IOP3XX_OMR1		IOP3XX_REG_ADDR32(0x031c)
+#define IOP3XX_IDR		IOP3XX_REG_ADDR32(0x0320)
+#define IOP3XX_IISR		IOP3XX_REG_ADDR32(0x0324)
+#define IOP3XX_IIMR		IOP3XX_REG_ADDR32(0x0328)
+#define IOP3XX_ODR		IOP3XX_REG_ADDR32(0x032c)
+#define IOP3XX_OISR		IOP3XX_REG_ADDR32(0x0330)
+#define IOP3XX_OIMR		IOP3XX_REG_ADDR32(0x0334)
+#define IOP3XX_MUCR		IOP3XX_REG_ADDR32(0x0350)
+#define IOP3XX_QBAR		IOP3XX_REG_ADDR32(0x0354)
+#define IOP3XX_IFHPR		IOP3XX_REG_ADDR32(0x0360)
+#define IOP3XX_IFTPR		IOP3XX_REG_ADDR32(0x0364)
+#define IOP3XX_IPHPR		IOP3XX_REG_ADDR32(0x0368)
+#define IOP3XX_IPTPR		IOP3XX_REG_ADDR32(0x036c)
+#define IOP3XX_OFHPR		IOP3XX_REG_ADDR32(0x0370)
+#define IOP3XX_OFTPR		IOP3XX_REG_ADDR32(0x0374)
+#define IOP3XX_OPHPR		IOP3XX_REG_ADDR32(0x0378)
+#define IOP3XX_OPTPR		IOP3XX_REG_ADDR32(0x037c)
+#define IOP3XX_IAR		IOP3XX_REG_ADDR32(0x0380)
 
-/* DMA Controller  */
-#define IOP3XX_DMA0_CCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0400)
-#define IOP3XX_DMA0_CSR		(volatile u32 *)IOP3XX_REG_ADDR(0x0404)
-#define IOP3XX_DMA0_DAR		(volatile u32 *)IOP3XX_REG_ADDR(0x040c)
-#define IOP3XX_DMA0_NDAR	(volatile u32 *)IOP3XX_REG_ADDR(0x0410)
-#define IOP3XX_DMA0_PADR	(volatile u32 *)IOP3XX_REG_ADDR(0x0414)
-#define IOP3XX_DMA0_PUADR	(volatile u32 *)IOP3XX_REG_ADDR(0x0418)
-#define IOP3XX_DMA0_LADR	(volatile u32 *)IOP3XX_REG_ADDR(0x041c)
-#define IOP3XX_DMA0_BCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0420)
-#define IOP3XX_DMA0_DCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0424)
-#define IOP3XX_DMA1_CCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0440)
-#define IOP3XX_DMA1_CSR		(volatile u32 *)IOP3XX_REG_ADDR(0x0444)
-#define IOP3XX_DMA1_DAR		(volatile u32 *)IOP3XX_REG_ADDR(0x044c)
-#define IOP3XX_DMA1_NDAR	(volatile u32 *)IOP3XX_REG_ADDR(0x0450)
-#define IOP3XX_DMA1_PADR	(volatile u32 *)IOP3XX_REG_ADDR(0x0454)
-#define IOP3XX_DMA1_PUADR	(volatile u32 *)IOP3XX_REG_ADDR(0x0458)
-#define IOP3XX_DMA1_LADR	(volatile u32 *)IOP3XX_REG_ADDR(0x045c)
-#define IOP3XX_DMA1_BCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0460)
-#define IOP3XX_DMA1_DCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0464)
+/* DMA Controllers  */
+#define IOP3XX_DMA_OFFSET(chan, ofs) 	IOP3XX_REG_ADDR32((chan << 6) + (ofs))
+
+#define IOP3XX_DMA_CCR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0400)
+#define IOP3XX_DMA_CSR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0404)
+#define IOP3XX_DMA_DAR(chan)		IOP3XX_DMA_OFFSET(chan, 0x040c)
+#define IOP3XX_DMA_NDAR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0410)
+#define IOP3XX_DMA_PADR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0414)
+#define IOP3XX_DMA_PUADR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0418)
+#define IOP3XX_DMA_LADR(chan)		IOP3XX_DMA_OFFSET(chan, 0x041c)
+#define IOP3XX_DMA_BCR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0420)
+#define IOP3XX_DMA_DCR(chan)		IOP3XX_DMA_OFFSET(chan, 0x0424)
+
+/* Application accelerator unit  */
+#define IOP3XX_AAU_ACR		IOP3XX_REG_ADDR32(0x0800)
+#define IOP3XX_AAU_ASR		IOP3XX_REG_ADDR32(0x0804)
+#define IOP3XX_AAU_ADAR	IOP3XX_REG_ADDR32(0x0808)
+#define IOP3XX_AAU_ANDAR	IOP3XX_REG_ADDR32(0x080c)
+#define IOP3XX_AAU_SAR(src)	IOP3XX_REG_ADDR32(0x0810 + ((src) << 2))
+#define IOP3XX_AAU_DAR		IOP3XX_REG_ADDR32(0x0820)
+#define IOP3XX_AAU_ABCR	IOP3XX_REG_ADDR32(0x0824)
+#define IOP3XX_AAU_ADCR	IOP3XX_REG_ADDR32(0x0828)
+#define IOP3XX_AAU_SAR_EDCR(src_edc) IOP3XX_REG_ADDR32(0x082c + ((src_edc - 4) << 2))
+#define IOP3XX_AAU_EDCR0_IDX	8
+#define IOP3XX_AAU_EDCR1_IDX	17
+#define IOP3XX_AAU_EDCR2_IDX	26
+
+#define IOP3XX_DMA0_ID 0
+#define IOP3XX_DMA1_ID 1
+#define IOP3XX_AAU_ID 2
 
 /* Peripheral bus interface  */
-#define IOP3XX_PBCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0680)
-#define IOP3XX_PBISR		(volatile u32 *)IOP3XX_REG_ADDR(0x0684)
-#define IOP3XX_PBBAR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0688)
-#define IOP3XX_PBLR0		(volatile u32 *)IOP3XX_REG_ADDR(0x068c)
-#define IOP3XX_PBBAR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0690)
-#define IOP3XX_PBLR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0694)
-#define IOP3XX_PBBAR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0698)
-#define IOP3XX_PBLR2		(volatile u32 *)IOP3XX_REG_ADDR(0x069c)
-#define IOP3XX_PBBAR3		(volatile u32 *)IOP3XX_REG_ADDR(0x06a0)
-#define IOP3XX_PBLR3		(volatile u32 *)IOP3XX_REG_ADDR(0x06a4)
-#define IOP3XX_PBBAR4		(volatile u32 *)IOP3XX_REG_ADDR(0x06a8)
-#define IOP3XX_PBLR4		(volatile u32 *)IOP3XX_REG_ADDR(0x06ac)
-#define IOP3XX_PBBAR5		(volatile u32 *)IOP3XX_REG_ADDR(0x06b0)
-#define IOP3XX_PBLR5		(volatile u32 *)IOP3XX_REG_ADDR(0x06b4)
-#define IOP3XX_PMBR0		(volatile u32 *)IOP3XX_REG_ADDR(0x06c0)
-#define IOP3XX_PMBR1		(volatile u32 *)IOP3XX_REG_ADDR(0x06e0)
-#define IOP3XX_PMBR2		(volatile u32 *)IOP3XX_REG_ADDR(0x06e4)
+#define IOP3XX_PBCR		IOP3XX_REG_ADDR32(0x0680)
+#define IOP3XX_PBISR		IOP3XX_REG_ADDR32(0x0684)
+#define IOP3XX_PBBAR0		IOP3XX_REG_ADDR32(0x0688)
+#define IOP3XX_PBLR0		IOP3XX_REG_ADDR32(0x068c)
+#define IOP3XX_PBBAR1		IOP3XX_REG_ADDR32(0x0690)
+#define IOP3XX_PBLR1		IOP3XX_REG_ADDR32(0x0694)
+#define IOP3XX_PBBAR2		IOP3XX_REG_ADDR32(0x0698)
+#define IOP3XX_PBLR2		IOP3XX_REG_ADDR32(0x069c)
+#define IOP3XX_PBBAR3		IOP3XX_REG_ADDR32(0x06a0)
+#define IOP3XX_PBLR3		IOP3XX_REG_ADDR32(0x06a4)
+#define IOP3XX_PBBAR4		IOP3XX_REG_ADDR32(0x06a8)
+#define IOP3XX_PBLR4		IOP3XX_REG_ADDR32(0x06ac)
+#define IOP3XX_PBBAR5		IOP3XX_REG_ADDR32(0x06b0)
+#define IOP3XX_PBLR5		IOP3XX_REG_ADDR32(0x06b4)
+#define IOP3XX_PMBR0		IOP3XX_REG_ADDR32(0x06c0)
+#define IOP3XX_PMBR1		IOP3XX_REG_ADDR32(0x06e0)
+#define IOP3XX_PMBR2		IOP3XX_REG_ADDR32(0x06e4)
 
 /* Peripheral performance monitoring unit  */
-#define IOP3XX_GTMR		(volatile u32 *)IOP3XX_REG_ADDR(0x0700)
-#define IOP3XX_ESR		(volatile u32 *)IOP3XX_REG_ADDR(0x0704)
-#define IOP3XX_EMISR		(volatile u32 *)IOP3XX_REG_ADDR(0x0708)
-#define IOP3XX_GTSR		(volatile u32 *)IOP3XX_REG_ADDR(0x0710)
+#define IOP3XX_GTMR		IOP3XX_REG_ADDR32(0x0700)
+#define IOP3XX_ESR		IOP3XX_REG_ADDR32(0x0704)
+#define IOP3XX_EMISR		IOP3XX_REG_ADDR32(0x0708)
+#define IOP3XX_GTSR		IOP3XX_REG_ADDR32(0x0710)
 /* PERCR0 DOESN'T EXIST - index from 1! */
-#define IOP3XX_PERCR0		(volatile u32 *)IOP3XX_REG_ADDR(0x0710)
+#define IOP3XX_PERCR0		IOP3XX_REG_ADDR32(0x0710)
 
 /* General Purpose I/O  */
-#define IOP3XX_GPOE		(volatile u32 *)IOP3XX_GPIO_REG(0x0004)
-#define IOP3XX_GPID		(volatile u32 *)IOP3XX_GPIO_REG(0x0008)
-#define IOP3XX_GPOD		(volatile u32 *)IOP3XX_GPIO_REG(0x000c)
+#define IOP3XX_GPOE		IOP3XX_GPIO_REG32(0x0004)
+#define IOP3XX_GPID		IOP3XX_GPIO_REG32(0x0008)
+#define IOP3XX_GPOD		IOP3XX_GPIO_REG32(0x000c)
 
 /* Timers  */
-#define IOP3XX_TU_TMR0		(volatile u32 *)IOP3XX_TIMER_REG(0x0000)
-#define IOP3XX_TU_TMR1		(volatile u32 *)IOP3XX_TIMER_REG(0x0004)
-#define IOP3XX_TU_TCR0		(volatile u32 *)IOP3XX_TIMER_REG(0x0008)
-#define IOP3XX_TU_TCR1		(volatile u32 *)IOP3XX_TIMER_REG(0x000c)
-#define IOP3XX_TU_TRR0		(volatile u32 *)IOP3XX_TIMER_REG(0x0010)
-#define IOP3XX_TU_TRR1		(volatile u32 *)IOP3XX_TIMER_REG(0x0014)
-#define IOP3XX_TU_TISR		(volatile u32 *)IOP3XX_TIMER_REG(0x0018)
-#define IOP3XX_TU_WDTCR		(volatile u32 *)IOP3XX_TIMER_REG(0x001c)
+#define IOP3XX_TU_TMR0		IOP3XX_TIMER_REG32(0x0000)
+#define IOP3XX_TU_TMR1		IOP3XX_TIMER_REG32(0x0004)
+#define IOP3XX_TU_TCR0		IOP3XX_TIMER_REG32(0x0008)
+#define IOP3XX_TU_TCR1		IOP3XX_TIMER_REG32(0x000c)
+#define IOP3XX_TU_TRR0		IOP3XX_TIMER_REG32(0x0010)
+#define IOP3XX_TU_TRR1		IOP3XX_TIMER_REG32(0x0014)
+#define IOP3XX_TU_TISR		IOP3XX_TIMER_REG32(0x0018)
+#define IOP3XX_TU_WDTCR		IOP3XX_TIMER_REG32(0x001c)
 #define IOP3XX_TMR_TC		0x01
 #define IOP3XX_TMR_EN		0x02
 #define IOP3XX_TMR_RELOAD	0x04
@@ -190,69 +203,25 @@ #define IOP3XX_TMR_RATIO_4_1	0x10
 #define IOP3XX_TMR_RATIO_8_1	0x20
 #define IOP3XX_TMR_RATIO_16_1	0x30
 
-/* Application accelerator unit  */
-#define IOP3XX_AAU_ACR		(volatile u32 *)IOP3XX_REG_ADDR(0x0800)
-#define IOP3XX_AAU_ASR		(volatile u32 *)IOP3XX_REG_ADDR(0x0804)
-#define IOP3XX_AAU_ADAR		(volatile u32 *)IOP3XX_REG_ADDR(0x0808)
-#define IOP3XX_AAU_ANDAR	(volatile u32 *)IOP3XX_REG_ADDR(0x080c)
-#define IOP3XX_AAU_SAR1		(volatile u32 *)IOP3XX_REG_ADDR(0x0810)
-#define IOP3XX_AAU_SAR2		(volatile u32 *)IOP3XX_REG_ADDR(0x0814)
-#define IOP3XX_AAU_SAR3		(volatile u32 *)IOP3XX_REG_ADDR(0x0818)
-#define IOP3XX_AAU_SAR4		(volatile u32 *)IOP3XX_REG_ADDR(0x081c)
-#define IOP3XX_AAU_DAR		(volatile u32 *)IOP3XX_REG_ADDR(0x0820)
-#define IOP3XX_AAU_ABCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0824)
-#define IOP3XX_AAU_ADCR		(volatile u32 *)IOP3XX_REG_ADDR(0x0828)
-#define IOP3XX_AAU_SAR5		(volatile u32 *)IOP3XX_REG_ADDR(0x082c)
-#define IOP3XX_AAU_SAR6		(volatile u32 *)IOP3XX_REG_ADDR(0x0830)
-#define IOP3XX_AAU_SAR7		(volatile u32 *)IOP3XX_REG_ADDR(0x0834)
-#define IOP3XX_AAU_SAR8		(volatile u32 *)IOP3XX_REG_ADDR(0x0838)
-#define IOP3XX_AAU_EDCR0	(volatile u32 *)IOP3XX_REG_ADDR(0x083c)
-#define IOP3XX_AAU_SAR9		(volatile u32 *)IOP3XX_REG_ADDR(0x0840)
-#define IOP3XX_AAU_SAR10	(volatile u32 *)IOP3XX_REG_ADDR(0x0844)
-#define IOP3XX_AAU_SAR11	(volatile u32 *)IOP3XX_REG_ADDR(0x0848)
-#define IOP3XX_AAU_SAR12	(volatile u32 *)IOP3XX_REG_ADDR(0x084c)
-#define IOP3XX_AAU_SAR13	(volatile u32 *)IOP3XX_REG_ADDR(0x0850)
-#define IOP3XX_AAU_SAR14	(volatile u32 *)IOP3XX_REG_ADDR(0x0854)
-#define IOP3XX_AAU_SAR15	(volatile u32 *)IOP3XX_REG_ADDR(0x0858)
-#define IOP3XX_AAU_SAR16	(volatile u32 *)IOP3XX_REG_ADDR(0x085c)
-#define IOP3XX_AAU_EDCR1	(volatile u32 *)IOP3XX_REG_ADDR(0x0860)
-#define IOP3XX_AAU_SAR17	(volatile u32 *)IOP3XX_REG_ADDR(0x0864)
-#define IOP3XX_AAU_SAR18	(volatile u32 *)IOP3XX_REG_ADDR(0x0868)
-#define IOP3XX_AAU_SAR19	(volatile u32 *)IOP3XX_REG_ADDR(0x086c)
-#define IOP3XX_AAU_SAR20	(volatile u32 *)IOP3XX_REG_ADDR(0x0870)
-#define IOP3XX_AAU_SAR21	(volatile u32 *)IOP3XX_REG_ADDR(0x0874)
-#define IOP3XX_AAU_SAR22	(volatile u32 *)IOP3XX_REG_ADDR(0x0878)
-#define IOP3XX_AAU_SAR23	(volatile u32 *)IOP3XX_REG_ADDR(0x087c)
-#define IOP3XX_AAU_SAR24	(volatile u32 *)IOP3XX_REG_ADDR(0x0880)
-#define IOP3XX_AAU_EDCR2	(volatile u32 *)IOP3XX_REG_ADDR(0x0884)
-#define IOP3XX_AAU_SAR25	(volatile u32 *)IOP3XX_REG_ADDR(0x0888)
-#define IOP3XX_AAU_SAR26	(volatile u32 *)IOP3XX_REG_ADDR(0x088c)
-#define IOP3XX_AAU_SAR27	(volatile u32 *)IOP3XX_REG_ADDR(0x0890)
-#define IOP3XX_AAU_SAR28	(volatile u32 *)IOP3XX_REG_ADDR(0x0894)
-#define IOP3XX_AAU_SAR29	(volatile u32 *)IOP3XX_REG_ADDR(0x0898)
-#define IOP3XX_AAU_SAR30	(volatile u32 *)IOP3XX_REG_ADDR(0x089c)
-#define IOP3XX_AAU_SAR31	(volatile u32 *)IOP3XX_REG_ADDR(0x08a0)
-#define IOP3XX_AAU_SAR32	(volatile u32 *)IOP3XX_REG_ADDR(0x08a4)
-
 /* I2C bus interface unit  */
-#define IOP3XX_ICR0		(volatile u32 *)IOP3XX_REG_ADDR(0x1680)
-#define IOP3XX_ISR0		(volatile u32 *)IOP3XX_REG_ADDR(0x1684)
-#define IOP3XX_ISAR0		(volatile u32 *)IOP3XX_REG_ADDR(0x1688)
-#define IOP3XX_IDBR0		(volatile u32 *)IOP3XX_REG_ADDR(0x168c)
-#define IOP3XX_IBMR0		(volatile u32 *)IOP3XX_REG_ADDR(0x1694)
-#define IOP3XX_ICR1		(volatile u32 *)IOP3XX_REG_ADDR(0x16a0)
-#define IOP3XX_ISR1		(volatile u32 *)IOP3XX_REG_ADDR(0x16a4)
-#define IOP3XX_ISAR1		(volatile u32 *)IOP3XX_REG_ADDR(0x16a8)
-#define IOP3XX_IDBR1		(volatile u32 *)IOP3XX_REG_ADDR(0x16ac)
-#define IOP3XX_IBMR1		(volatile u32 *)IOP3XX_REG_ADDR(0x16b4)
+#define IOP3XX_ICR0		IOP3XX_REG_ADDR32(0x1680)
+#define IOP3XX_ISR0		IOP3XX_REG_ADDR32(0x1684)
+#define IOP3XX_ISAR0		IOP3XX_REG_ADDR32(0x1688)
+#define IOP3XX_IDBR0		IOP3XX_REG_ADDR32(0x168c)
+#define IOP3XX_IBMR0		IOP3XX_REG_ADDR32(0x1694)
+#define IOP3XX_ICR1		IOP3XX_REG_ADDR32(0x16a0)
+#define IOP3XX_ISR1		IOP3XX_REG_ADDR32(0x16a4)
+#define IOP3XX_ISAR1		IOP3XX_REG_ADDR32(0x16a8)
+#define IOP3XX_IDBR1		IOP3XX_REG_ADDR32(0x16ac)
+#define IOP3XX_IBMR1		IOP3XX_REG_ADDR32(0x16b4)
 
 
 /*
  * IOP3XX I/O and Mem space regions for PCI autoconfiguration
  */
 #define IOP3XX_PCI_MEM_WINDOW_SIZE	0x04000000
-#define IOP3XX_PCI_LOWER_MEM_PA		0x80000000
-#define IOP3XX_PCI_LOWER_MEM_BA		(*IOP3XX_OMWTVR0)
+#define IOP3XX_PCI_LOWER_MEM_PA	0x80000000
+#define IOP3XX_PCI_LOWER_MEM_BA	(*IOP3XX_OMWTVR0)
 
 #define IOP3XX_PCI_IO_WINDOW_SIZE	0x00010000
 #define IOP3XX_PCI_LOWER_IO_PA		0x90000000
