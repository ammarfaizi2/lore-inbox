Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSKOMwX>; Fri, 15 Nov 2002 07:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKOMwX>; Fri, 15 Nov 2002 07:52:23 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:53634 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266228AbSKOMwU>; Fri, 15 Nov 2002 07:52:20 -0500
Message-ID: <3DD4EF95.DC549DD@cinet.co.jp>
Date: Fri, 15 Nov 2002 21:59:01 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac4-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: PC-9800 patch for 2.5.47-ac4: not merged yet (11/15) PCI
References: <3DD4E2D5.AEF13F1@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------55A5C7F211F6F57471193833"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55A5C7F211F6F57471193833
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This is rest of PCI support patch.

diffstat:
 arch/i386/pci/irq.c    |   27 +++++++++++++++++++++++++++
 drivers/pci/quirks.c   |    1 +
 drivers/pcmcia/yenta.c |    6 ++++++
 include/asm-i386/pci.h |    4 ++++
 4 files changed, 38 insertions(+)

-- 
Osamu Tomita
tomita@cinet.co.jp
--------------55A5C7F211F6F57471193833
Content-Type: text/plain; charset=iso-2022-jp;
 name="pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.patch"

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
diff -urN linux/drivers/pci/quirks.c linux98/drivers/pci/quirks.c
--- linux/drivers/pci/quirks.c	Fri Nov 15 12:10:12 2002
+++ linux98/drivers/pci/quirks.c	Fri Nov 15 12:19:33 2002
@@ -520,6 +520,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
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

--------------55A5C7F211F6F57471193833--

