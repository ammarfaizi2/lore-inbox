Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJ1RkD>; Mon, 28 Oct 2002 12:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJ1Rid>; Mon, 28 Oct 2002 12:38:33 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:62991 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261406AbSJ1RXv>; Mon, 28 Oct 2002 12:23:51 -0500
Date: Tue, 29 Oct 2002 02:30:12 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 14/23] add support for PC-9800 architecture (PCI)
Message-ID: <20021029023012.A2301@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 14/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 PCI related modules
 - adapted to IRQ number differences.
 - adapted to PCI BIOS function number differences.
 - add some entry to PCI name database.
 - add quirks for legacy bus.
 - IO address limitation change.

diffstat:
 arch/i386/pci/irq.c     |   27 +++++++++++++++++++++++++++
 arch/i386/pci/pcbios.c  |   17 +++++++++++++++++
 drivers/pci/pci.ids     |   16 ++++++++++------
 drivers/pci/quirks.c    |    7 +++++++
 drivers/pcmcia/yenta.c  |    6 ++++++
 include/asm-i386/pci.h  |    4 ++++
 include/linux/pci_ids.h |   20 +++++++++++++++++++-
 7 files changed, 90 insertions(+), 7 deletions(-)

patch:
diff -urN linux/arch/i386/pci/irq.c linux98/arch/i386/pci/irq.c
--- linux/arch/i386/pci/irq.c	Sat Oct 12 13:22:46 2002
+++ linux98/arch/i386/pci/irq.c	Sat Oct 12 14:18:52 2002
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/pci_ids.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -25,6 +26,7 @@
 
 static struct irq_routing_table *pirq_table;
 
+#ifndef CONFIG_PC9800
 /*
  * Never use: 0, 1, 2 (timer, keyboard, and cascade)
  * Avoid using: 13, 14 and 15 (FP error and IDE).
@@ -36,6 +38,20 @@
 	1000000, 1000000, 1000000, 1000, 1000, 0, 1000, 1000,
 	0, 0, 0, 0, 1000, 100000, 100000, 100000
 };
+#else
+/*
+ * Never use: 0, 1, 2, 7 (timer, keyboard, CRT VSYNC and cascade)
+ * Avoid using: 8, 9 and 15 (FP error and IDE).
+ * Penalize: 4, 5, 11, 12, 13, 14 (known ISA uses: serial, floppy, sound, mouse
+ *                                 and parallel)
+ */
+unsigned int pcibios_irq_mask = 0xff78;
+
+static int pirq_penalty[16] = {
+	1000000, 1000000, 1000000, 0, 1000, 1000, 0, 1000000,
+	100000, 100000, 0, 1000, 1000, 1000, 1000, 100000
+};
+#endif
 
 struct irq_router {
 	char *name;
@@ -612,6 +628,17 @@
 		r->set(pirq_router_dev, dev, pirq, 11);
 	}
 
+#ifdef CONFIG_PC9800
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
+		if (pci_find_device(PCI_VENDOR_ID_INTEL,
+				PCI_DEVICE_ID_INTEL_82439TX, NULL) != NULL) {
+			if (mask & 0x0040) {
+				mask &= 0x0040;	/* assign IRQ 6 only */
+				printk("pci-irq: Use IRQ6 for CardBus controller\n");
+			}
+		}
+	}
+#endif
 	/*
 	 * Find the best IRQ to assign: use the one
 	 * reported by the device if possible.
diff -urN linux/arch/i386/pci/pcbios.c linux98/arch/i386/pci/pcbios.c
--- linux/arch/i386/pci/pcbios.c	Sun Jun  9 14:27:00 2002
+++ linux98/arch/i386/pci/pcbios.c	Mon Jun 10 20:49:14 2002
@@ -7,6 +7,7 @@
 #include "pci.h"
 
 
+#ifndef CONFIG_PC9800
 #define PCIBIOS_PCI_FUNCTION_ID 	0xb1XX
 #define PCIBIOS_PCI_BIOS_PRESENT 	0xb101
 #define PCIBIOS_FIND_PCI_DEVICE		0xb102
@@ -20,6 +21,22 @@
 #define PCIBIOS_WRITE_CONFIG_DWORD	0xb10d
 #define PCIBIOS_GET_ROUTING_OPTIONS	0xb10e
 #define PCIBIOS_SET_PCI_HW_INT		0xb10f
+#else /* CONFIG_PC9800 */
+#define PCIBIOS_PCI_FUNCTION_ID 	0xccXX
+#define PCIBIOS_PCI_BIOS_PRESENT 	0xcc81
+#define PCIBIOS_FIND_PCI_DEVICE		0xcc82
+#define PCIBIOS_FIND_PCI_CLASS_CODE	0xcc83
+/*      PCIBIOS_GENERATE_SPECIAL_CYCLE	0xcc86	(not supported by bios) */
+#define PCIBIOS_READ_CONFIG_BYTE	0xcc88
+#define PCIBIOS_READ_CONFIG_WORD	0xcc89
+#define PCIBIOS_READ_CONFIG_DWORD	0xcc8a
+#define PCIBIOS_WRITE_CONFIG_BYTE	0xcc8b
+#define PCIBIOS_WRITE_CONFIG_WORD	0xcc8c
+#define PCIBIOS_WRITE_CONFIG_DWORD	0xcc8d
+#define PCIBIOS_GET_ROUTING_OPTIONS	0xcc8e	/* PCI 2.1 only */
+#define PCIBIOS_SET_PCI_HW_INT		0xcc8f	/* PCI 2.1 only */
+/* Note: PC-9800 confirms PCI 2.1 on only few models */
+#endif /* CONFIG_PC9800 */
 
 /* BIOS32 signature: "_32_" */
 #define BIOS32_SIGNATURE	(('_' << 0) + ('3' << 8) + ('2' << 16) + ('_' << 24))
diff -urN linux/drivers/pcmcia/yenta.c linux98/drivers/pcmcia/yenta.c
--- linux/drivers/pcmcia/yenta.c	Sat Oct 12 13:22:10 2002
+++ linux98/drivers/pcmcia/yenta.c	Sun Oct 13 17:29:24 2002
@@ -3,6 +3,7 @@
  *
  * (C) Copyright 1999, 2000 Linus Torvalds
  */
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
@@ -505,6 +506,7 @@
 	add_timer(&socket->poll_timer);
 }
 
+#ifndef CONFIG_PC9800
 /*
  * Only probe "regular" interrupts, don't
  * touch dangerous spots like the mouse irq,
@@ -515,6 +517,10 @@
  * Default to 11, 10, 9, 7, 6, 5, 4, 3.
  */
 static u32 isa_interrupts = 0x0ef8;
+#else
+/* Default to 12, 10, 6, 5, 3. */
+static u32 isa_interrupts = 0x1468;
+#endif
 
 static unsigned int yenta_probe_irq(pci_socket_t *socket, u32 isa_irq_mask)
 {
diff -urN linux/drivers/pci/pci.ids linux98/drivers/pci/pci.ids
--- linux/drivers/pci/pci.ids	Tue Oct  8 10:56:11 2002
+++ linux98/drivers/pci/pci.ids	Tue Oct  8 11:01:40 2002
@@ -497,8 +497,8 @@
 		1011 500b  DE500B Fast Ethernet
 		1014 0001  10/100 EtherJet Cardbus
 		1025 0315  ALN315 Fast Ethernet
-		1033 800c  PC-9821-CS01
-		1033 800d  PC-9821NR-B06
+		1033 800c  PC-9821-CS01 100BASE-TX Interface Card
+		1033 800d  PC-9821NR-B06 100BASE-TX Interface Card
 		108d 0016  Rapidfire 2327 10/100 Ethernet
 		108d 0017  GoCard 2250 Ethernet 10/100 Cardbus
 		10b8 2005  SMC8032DT Extreme Ethernet 10/100
@@ -1049,17 +1049,21 @@
 	0003  ATM Controller
 	0004  R4000 PCI Bridge
 	0005  PCI to 486-like bus Bridge
-	0006  GUI Accelerator
+	0006  PC-9800 Graphic Accelerator
 	0007  PCI to UX-Bus Bridge
-	0008  GUI Accelerator
-	0009  GUI Accelerator for W98
+	0008  PC-9800 Graphic Accelerator
+	0009  PCI to PC9800 Core-Graph Bridge
+	0016  PCI to VL Bridge
 	001a  [Nile II]
 	0021  Vrc4373 [Nile I]
 	0029  PowerVR PCX1
 	002a  PowerVR 3D
+	002c  Star Alpha 2
+	002d  PCI to C-bus Bridge
 	0035  USB
 		1179 0001  USB
 		12ee 7000  Root Hub
+	003b  PCI to C-bus Bridge
 	003e  NAPCCARD Cardbus Controller
 	0046  PowerVR PCX2 [midas]
 	005a  Vrc5074 [Nile 4]
@@ -3485,7 +3489,7 @@
 	5811  FW323
 		dead 0800  FireWire Host Bus Adapter
 11c2  Sand Microelectronics
-11c3  NEC Corp
+11c3  NEC Corporation
 11c4  Document Technologies, Inc
 11c5  Shiva Corporation
 11c6  Dainippon Screen Mfg. Co. Ltd
diff -urN linux/drivers/pci/quirks.c linux98/drivers/pci/quirks.c
--- linux/drivers/pci/quirks.c	Tue Sep 10 02:35:00 2002
+++ linux98/drivers/pci/quirks.c	Tue Sep 10 09:07:50 2002
@@ -54,7 +54,11 @@
 {
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy=1;
+#ifndef CONFIG_PC9800
 		printk(KERN_INFO "Activating ISA DMA hang workarounds.\n");
+#else
+		printk(KERN_INFO "Activating C-bus DMA hang workarounds.\n");
+#endif
 	}
 }
 
@@ -491,6 +495,9 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
+#ifdef CONFIG_PC9800
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
+#endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
diff -urN linux/include/asm-i386/pci.h linux98/include/asm-i386/pci.h
--- linux/include/asm-i386/pci.h	Sun Jun  9 14:29:24 2002
+++ linux98/include/asm-i386/pci.h	Mon Jun 10 20:49:15 2002
@@ -17,7 +17,11 @@
 #endif
 
 extern unsigned long pci_mem_start;
+#ifndef CONFIG_PC9800
 #define PCIBIOS_MIN_IO		0x1000
+#else
+#define PCIBIOS_MIN_IO		0x4000
+#endif
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
 void pcibios_config_init(void);
  *	Status Register Bits
diff -urN linux/include/linux/pci_ids.h linux98/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	Sat Oct 12 13:21:42 2002
+++ linux98/include/linux/pci_ids.h	Sat Oct 12 19:56:04 2002
@@ -456,10 +456,26 @@
 #define PCI_DEVICE_ID_MIRO_36050	0x5601
 
 #define PCI_VENDOR_ID_NEC		0x1033
-#define PCI_DEVICE_ID_NEC_PCX2		0x0046
+#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
+#define PCI_DEVICE_ID_NEC_LOCAL		0x0002 /* Local Bridge */
+#define PCI_DEVICE_ID_NEC_ATM		0x0003 /* ATM LAN Controller */
+#define PCI_DEVICE_ID_NEC_R4000		0x0004 /* R4000 Bridge */
+#define PCI_DEVICE_ID_NEC_486		0x0005 /* 486 Like Peripheral Bus Bridge */
+#define PCI_DEVICE_ID_NEC_ACCEL_1	0x0006 /* Graphic Accelerator */
+#define PCI_DEVICE_ID_NEC_UXBUS		0x0007 /* UX-Bus Bridge */
+#define PCI_DEVICE_ID_NEC_ACCEL_2	0x0006 /* Graphic Accelerator */
+#define PCI_DEVICE_ID_NEC_GRAPH		0x0009 /* PCI-CoreGraph Bridge */
+#define PCI_DEVICE_ID_NEC_VL		0x0016 /* PCI-VL Bridge */
+#define PCI_DEVICE_ID_NEC_STARALPHA2	0x002c /* STAR ALPHA2 */
+#define PCI_DEVICE_ID_NEC_CBUS_2	0x002d /* PCI-Cbus Bridge */
+#define PCI_DEVICE_ID_NEC_USB		0x0035 /* PCI-USB Host */
+#define PCI_DEVICE_ID_NEC_CBUS_3	0x003b
+#define PCI_DEVICE_ID_NEC_PCX2		0x0046 /* PowerVR */
 #define PCI_DEVICE_ID_NEC_NILE4		0x005a
 #define PCI_DEVICE_ID_NEC_VRC5476       0x009b
 #define PCI_DEVICE_ID_NEC_VRC5477_AC97  0x00a6
+#define PCI_DEVICE_ID_NEC_PC9821CS01    0x800c /* PC-9821-CS01 */
+#define PCI_DEVICE_ID_NEC_PC9821NRB06   0x800d /* PC-9821NR-B06 */
 
 #define PCI_VENDOR_ID_FD		0x1036
 #define PCI_DEVICE_ID_FD_36C70		0x0000
@@ -1232,6 +1248,8 @@
 #define PCI_DEVICE_ID_ATT_L56XMF	0x0440
 #define PCI_DEVICE_ID_ATT_VENUS_MODEM	0x480
 
+#define PCI_VENDOR_ID_NEC2		0x11c3 /* NEC (2nd) */
+
 #define PCI_VENDOR_ID_SPECIALIX		0x11cb
 #define PCI_DEVICE_ID_SPECIALIX_IO8	0x2000
 #define PCI_DEVICE_ID_SPECIALIX_XIO	0x4000
