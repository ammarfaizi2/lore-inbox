Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbTCWHGr>; Sun, 23 Mar 2003 02:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbTCWHFi>; Sun, 23 Mar 2003 02:05:38 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:44928 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262914AbTCWHEe>; Sun, 23 Mar 2003 02:04:34 -0500
Date: Sun, 23 Mar 2003 16:14:44 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac3] Additionals for support PC-9800 (8/10) PCI
Message-ID: <20030323071444.GH2951@yuzuki.cinet.co.jp>
References: <20030323065928.GF2851@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323065928.GF2851@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac3. (8/10)

Small changes for PCI support.
Fix for difference of IRQ numbers and IO addresses.

Regards,
Osamu Tomita

diff -Nru linux/arch/i386/pci/irq.c linux98/arch/i386/pci/irq.c
--- linux/arch/i386/pci/irq.c	2002-10-12 13:22:46.000000000 +0900
+++ linux98/arch/i386/pci/irq.c	2002-10-12 14:18:52.000000000 +0900
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/pci_ids.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -25,6 +26,7 @@
 
 static struct irq_routing_table *pirq_table;
 
+#ifndef CONFIG_X86_PC9800
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
 
+#ifdef CONFIG_X86_PC9800
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
diff -Nru linux/drivers/pcmcia/yenta.c linux98/drivers/pcmcia/yenta.c
--- linux/drivers/pcmcia/yenta.c	2002-11-18 13:29:48.000000000 +0900
+++ linux98/drivers/pcmcia/yenta.c	2002-11-19 11:02:09.000000000 +0900
@@ -8,6 +8,7 @@
  * 	Dynamically adjust the size of the bridge resource
  * 	
  */
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
@@ -510,6 +511,7 @@
 	add_timer(&socket->poll_timer);
 }
 
+#ifndef CONFIG_X86_PC9800
 /*
  * Only probe "regular" interrupts, don't
  * touch dangerous spots like the mouse irq,
@@ -520,6 +522,10 @@
  * Default to 11, 10, 9, 7, 6, 5, 4, 3.
  */
 static u32 isa_interrupts = 0x0ef8;
+#else
+/* Default to 12, 10, 6, 5, 3. */
+static u32 isa_interrupts = 0x1468;
+#endif
 
 static unsigned int yenta_probe_irq(pci_socket_t *socket, u32 isa_irq_mask)
 {
diff -Nru linux/include/asm-i386/pci.h linux98/include/asm-i386/pci.h
--- linux/include/asm-i386/pci.h	2002-06-09 14:29:24.000000000 +0900
+++ linux98/include/asm-i386/pci.h	2002-06-10 20:49:15.000000000 +0900
@@ -17,7 +17,11 @@
 #endif
 
 extern unsigned long pci_mem_start;
+#ifdef CONFIG_X86_PC9800
+#define PCIBIOS_MIN_IO		0x4000
+#else
 #define PCIBIOS_MIN_IO		0x1000
+#endif
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
 void pcibios_config_init(void);
