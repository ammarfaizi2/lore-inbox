Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUDEVUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUDEVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:18:09 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:38272 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263225AbUDEVQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:16:33 -0400
Date: Mon, 5 Apr 2004 23:16:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: davem@redhat.com, kernel list <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, Andrew Morton <akpm@zip.com.au>,
       linux-net@vger.kernel.org
Subject: Support newer revisions of broadcoms in b44.c
Message-ID: <20040405211617.GA3613@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for newer revisions of the chips. The
b44_disable_ints at the beggining actually kills machine with newer
revision, but its removal has no ill effects. Please apply,

								Pavel

Index: linux/drivers/net/b44.c
===================================================================
--- linux.orig/drivers/net/b44.c	2004-04-05 22:47:34.000000000 +0200
+++ linux/drivers/net/b44.c	2004-04-05 16:50:24.000000000 +0200
@@ -2,6 +2,8 @@
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
  * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
+ *
+ * Distribute under GPL.
  */
 
 #include <linux/kernel.h>
@@ -25,8 +27,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.92"
-#define DRV_MODULE_RELDATE	"Nov 4, 2003"
+#define DRV_MODULE_VERSION	"0.93"
+#define DRV_MODULE_RELDATE	"Mar, 2004"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -83,6 +85,10 @@
 static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
 };
 
@@ -1178,7 +1184,6 @@
 {
 	u32 val;
 
-	b44_disable_ints(bp);
 	b44_chip_reset(bp);
 	b44_phy_reset(bp);
 	b44_setup_phy(bp);
Index: linux/drivers/net/b44.h
===================================================================
--- linux.orig/drivers/net/b44.h	2004-04-05 22:47:34.000000000 +0200
+++ linux/drivers/net/b44.h	2004-03-11 22:26:22.000000000 +0100
@@ -1,8 +1,9 @@
 #ifndef _B44_H
 #define _B44_H
 
-/* Register layout. */
+/* Register layout. (These correspond to struct _bcmenettregs in bcm4400.) */
 #define	B44_DEVCTRL	0x0000UL /* Device Control */
+#define  DEVCTRL_MPM		0x00000040 /* Magic Packet PME Enable (B0 only) */
 #define  DEVCTRL_PFE		0x00000080 /* Pattern Filtering Enable */
 #define  DEVCTRL_IPP		0x00000400 /* Internal EPHY Present */
 #define  DEVCTRL_EPR		0x00008000 /* EPHY Reset */
@@ -24,6 +25,7 @@
 #define  WKUP_LEN_P3_SHIFT	24
 #define  WKUP_LEN_D3		0x80000000
 #define B44_ISTAT	0x0020UL /* Interrupt Status */
+#define  ISTAT_LS		0x00000020 /* Link Change (B0 only) */
 #define  ISTAT_PME		0x00000040 /* Power Management Event */
 #define  ISTAT_TO		0x00000080 /* General Purpose Timeout */
 #define  ISTAT_DSCE		0x00000400 /* Descriptor Error */
@@ -41,6 +43,8 @@
 #define B44_IMASK	0x0024UL /* Interrupt Mask */
 #define  IMASK_DEF		(ISTAT_ERRORS | ISTAT_TO | ISTAT_RX | ISTAT_TX)
 #define B44_GPTIMER	0x0028UL /* General Purpose Timer */
+#define B44_ADDR_LO	0x0088UL /* ENET Address Lo (B0 only) */
+#define B44_ADDR_HI	0x008CUL /* ENET Address Hi (B0 only) */
 #define B44_FILT_ADDR	0x0090UL /* ENET Filter Address */
 #define B44_FILT_DATA	0x0094UL /* ENET Filter Data */
 #define B44_TXBURST	0x00A0UL /* TX Max Burst Length */
Index: linux/include/linux/pci_ids.h
===================================================================
--- linux.orig/include/linux/pci_ids.h	2004-04-05 22:47:34.000000000 +0200
+++ linux/include/linux/pci_ids.h	2004-04-05 16:52:43.000000000 +0200
@@ -1837,6 +1837,8 @@
 #define PCI_DEVICE_ID_TIGON3_5901	0x170d
 #define PCI_DEVICE_ID_TIGON3_5901_2	0x170e
 #define PCI_DEVICE_ID_BCM4401		0x4401
+#define PCI_DEVICE_ID_BCM4401B0		0x4402
+#define PCI_DEVICE_ID_BCM4401B1		0x170c
 
 #define PCI_VENDOR_ID_ENE		0x1524
 #define PCI_DEVICE_ID_ENE_1211		0x1211

%diffstat
 Documentation/cpu-freq/user-guide.txt       |    2 
 Documentation/firmware_class/README         |    4 
 Documentation/firmware_class/hotplug-script |    4 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c  | 1031 ++++++++++++++++------------
 arch/i386/kernel/cpu/cpufreq/powernow-k8.h  |  118 ++-
 drivers/acpi/battery.c                      |    7 
 drivers/char/keyboard.c                     |   64 +
 drivers/cpufreq/cpufreq.c                   |    6 
 drivers/ide/Kconfig                         |    3 
 drivers/ieee1394/video1394.c                |    2 
 drivers/net/b44.c                           |   11 
 drivers/net/b44.h                           |    6 
 include/asm-generic/uaccess.h               |   26 
 include/linux/acpi.h                        |   19 
 include/linux/input.h                       |    5 
 include/linux/pci_ids.h                     |    2 
 16 files changed, 833 insertions(+), 477 deletions(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
