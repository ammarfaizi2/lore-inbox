Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271466AbTGRJf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGRJf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:35:58 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:50175 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271466AbTGRJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 4/7][v850]  Add another layer of indirection for irq numbering with v850 `gbus' irqs
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094537.36A0937C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:37 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This allows ports that support the v850 RTE-CB `GBUS' interrupts to use
both them and processor-board-specific interrupts at the same time.

diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_cb.h	2003-06-16 14:53:02.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_cb.h	2003-07-15 19:15:16.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/rte_cb.h -- Midas labs RTE-CB series of evaluation boards
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -20,42 +20,54 @@
 #define MB_A_SRAM_SIZE		0x00200000 /* 2MB */
 
 
+#ifdef CONFIG_RTE_GBUS_INT
 /* GBUS interrupt support.  */
-#define GBUS_INT_BASE_IRQ	NUM_CPU_IRQS
-#define GBUS_INT_BASE_ADDR	(GCS2_ADDR + 0x00006000)
-#include <asm/gbus_int.h>
 
-/* We define NUM_MACH_IRQS to include extra interrupts from the GBUS.  */
-#define NUM_MACH_IRQS		(NUM_CPU_IRQS + IRQ_GBUS_INT_NUM)
+# include <asm/gbus_int.h>
+
+# define GBUS_INT_BASE_IRQ	NUM_RTE_CB_IRQS
+# define GBUS_INT_BASE_ADDR	(GCS2_ADDR + 0x00006000)
 
 /* Some specific interrupts.  */
-#define IRQ_MB_A_LAN		IRQ_GBUS_INT(10)
-#define IRQ_MB_A_PCI1(n)	(IRQ_GBUS_INT(16) + (n))
-#define IRQ_MB_A_PCI1_NUM	4
-#define IRQ_MB_A_PCI2(n)	(IRQ_GBUS_INT(20) + (n))
-#define IRQ_MB_A_PCI2_NUM	4
-#define IRQ_MB_A_EXT(n)		(IRQ_GBUS_INT(24) + (n))
-#define IRQ_MB_A_EXT_NUM	4
-#define IRQ_MB_A_USB_OC(n)	(IRQ_GBUS_INT(28) + (n))
-#define IRQ_MB_A_USB_OC_NUM	2
-#define IRQ_MB_A_PCMCIA_OC	IRQ_GBUS_INT(30)
+# define IRQ_MB_A_LAN		IRQ_GBUS_INT(10)
+# define IRQ_MB_A_PCI1(n)	(IRQ_GBUS_INT(16) + (n))
+# define IRQ_MB_A_PCI1_NUM	4
+# define IRQ_MB_A_PCI2(n)	(IRQ_GBUS_INT(20) + (n))
+# define IRQ_MB_A_PCI2_NUM	4
+# define IRQ_MB_A_EXT(n)	(IRQ_GBUS_INT(24) + (n))
+# define IRQ_MB_A_EXT_NUM	4
+# define IRQ_MB_A_USB_OC(n)	(IRQ_GBUS_INT(28) + (n))
+# define IRQ_MB_A_USB_OC_NUM	2
+# define IRQ_MB_A_PCMCIA_OC	IRQ_GBUS_INT(30)
+
+/* We define NUM_MACH_IRQS to include extra interrupts from the GBUS.  */
+# define NUM_MACH_IRQS		(NUM_RTE_CB_IRQS + IRQ_GBUS_INT_NUM)
 
+#else /* !CONFIG_RTE_GBUS_INT */
 
+# define NUM_MACH_IRQS		NUM_RTE_CB_IRQS
+
+#endif /* CONFIG_RTE_GBUS_INT */
+
+
+#ifdef CONFIG_RTE_MB_A_PCI
 /* Mother-A PCI bus support.  */
-#include <asm/rte_mb_a_pci.h>
+
+# include <asm/rte_mb_a_pci.h>
 
 /* These are the base addresses used for allocating device address
    space.  512K of the motherboard SRAM is in the same space, so we have
    to be careful not to let it be allocated.  */
-#define PCIBIOS_MIN_MEM		(MB_A_PCI_MEM_ADDR + 0x80000)
-#define PCIBIOS_MIN_IO		MB_A_PCI_IO_ADDR
+# define PCIBIOS_MIN_MEM	(MB_A_PCI_MEM_ADDR + 0x80000)
+# define PCIBIOS_MIN_IO		MB_A_PCI_IO_ADDR
 
 /* As we don't really support PCI DMA to cpu memory, and use bounce-buffers
    instead, perversely enough, this becomes always true! */
-#define pci_dma_supported(dev, mask)		1
-#define pci_dac_dma_supported(dev, mask)	0
-#define pcibios_assign_all_busses()		1
+# define pci_dma_supported(dev, mask)		1
+# define pci_dac_dma_supported(dev, mask)	0
+# define pcibios_assign_all_busses()		1
 
+#endif /* CONFIG_RTE_MB_A_PCI */
 
 
 /* For <asm/param.h> */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/rte_ma1_cb.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_ma1_cb.h
--- linux-2.6.0-test1-moo/include/asm-v850/rte_ma1_cb.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/rte_ma1_cb.h	2003-07-15 19:06:37.000000000 +0900
@@ -17,25 +17,6 @@
 #include <asm/rte_cb.h>		/* Common defs for Midas RTE-CB boards.  */
 
 
-/* CPU addresses of GBUS memory spaces.  */
-#define GCS0_ADDR		0x05000000 /* GCS0 - Common SRAM (2MB) */
-#define GCS0_SIZE		0x00200000 /*   2MB */
-#define GCS1_ADDR		0x06000000 /* GCS1 - Flash ROM (8MB) */
-#define GCS1_SIZE		0x00800000 /*   8MB */
-#define GCS2_ADDR		0x07900000 /* GCS2 - I/O registers */
-#define GCS2_SIZE		0x00400000 /*   4MB */
-#define GCS5_ADDR		0x04000000 /* GCS5 - PCI bus space */
-#define GCS5_SIZE		0x01000000 /*   16MB */
-#define GCS6_ADDR		0x07980000 /* GCS6 - PCI control registers */
-#define GCS6_SIZE		0x00000200 /*   512B */
-
-
-/* The GBUS GINT0 - GINT4 interrupts are connected to the INTP000 - INTP011
-   pins on the CPU.  These are shared among the GBUS interrupts.  */
-#define IRQ_GINT(n)		IRQ_INTP(n)
-#define IRQ_GINT_NUM		4
-
-
 #define PLATFORM		"rte-v850e/ma1-cb"
 #define PLATFORM_LONG		"Midas lab RTE-V850E/MA1-CB"
 
@@ -53,10 +34,32 @@
 #define SDRAM_SIZE		0x02000000 /* 32MB */
 
 
+/* CPU addresses of GBUS memory spaces.  */
+#define GCS0_ADDR		0x05000000 /* GCS0 - Common SRAM (2MB) */
+#define GCS0_SIZE		0x00200000 /*   2MB */
+#define GCS1_ADDR		0x06000000 /* GCS1 - Flash ROM (8MB) */
+#define GCS1_SIZE		0x00800000 /*   8MB */
+#define GCS2_ADDR		0x07900000 /* GCS2 - I/O registers */
+#define GCS2_SIZE		0x00400000 /*   4MB */
+#define GCS5_ADDR		0x04000000 /* GCS5 - PCI bus space */
+#define GCS5_SIZE		0x01000000 /*   16MB */
+#define GCS6_ADDR		0x07980000 /* GCS6 - PCI control registers */
+#define GCS6_SIZE		0x00000200 /*   512B */
+
+
 /* For <asm/page.h> */
 #define PAGE_OFFSET 		SRAM_ADDR
 
 
+/* The GBUS GINT0 - GINT3 interrupts are connected to the INTP000 - INTP011
+   pins on the CPU.  These are shared among the GBUS interrupts.  */
+#define IRQ_GINT(n)		IRQ_INTP(n)
+#define IRQ_GINT_NUM		4
+
+/* Used by <asm/rte_cb.h> to derive NUM_MACH_IRQS.  */
+#define NUM_RTE_CB_IRQS		NUM_CPU_IRQS
+
+
 #ifdef CONFIG_ROM_KERNEL
 /* Kernel is in ROM, starting at address 0.  */
 
