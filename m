Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271078AbTGPLji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271079AbTGPLji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:39:38 -0400
Received: from wilsoaa1.miniserver.com ([69.10.141.73]:43525 "HELO
	china.botanicus.net") by vger.kernel.org with SMTP id S271078AbTGPLje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:39:34 -0400
Date: Wed, 16 Jul 2003 12:55:06 +0100
From: "David M. Wilson" <dw_lkml@botanicus.net>
To: linux-kernel@vger.kernel.org
Cc: ollie@sis.com.tw, hfhsu@sis.com.tw, deti@fliegl.de,
       marcelo@conectiva.com.br
Subject: [PATCH] sis900.c Wake-on-LAN support for 2.4.21/2.4.x.
Message-ID: <20030716115506.GA5866@china.botanicus.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
X-Setup: Linux 2.4.20-4um, et:tw=75
X-WWW: http://botanicus.net/dw/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please find attached a tiny patch to enable Wake-on-LAN support for the
sis900.c driver. This is essentially an older patch updated for newer
kernels.

Thanks,

David.

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900_wol-2.4.21.patch"

diff --unified --recursive linux-2.4.21/drivers/net/sis900.c linux-2.4.21sis900_wol/drivers/net/sis900.c
--- linux-2.4.21/drivers/net/sis900.c	2003-06-13 15:51:35.000000000 +0100
+++ linux-2.4.21sis900_wol/drivers/net/sis900.c	2003-07-16 11:55:10.000000000 +0100
@@ -1,6 +1,6 @@
 /* sis900.c: A SiS 900/7016 PCI Fast Ethernet driver for Linux.
    Copyright 1999 Silicon Integrated System Corporation 
-   Revision:	1.08.06 Sep. 24 2002
+   Revision: 1.08.07 Jul. 16 2003
    
    Modified from the driver which is originally written by Donald Becker.
    
@@ -18,6 +18,8 @@
    preliminary Rev. 1.0 Jan. 18, 1998
    http://www.sis.com.tw/support/databook.htm
 
+
+   Rev 1.08.07 Jul. 16 2003 David M. Wilson <dw-sis900@botanicus.net> reintegrate WOL patch.
    Rev 1.08.06 Sep. 24 2002 Mufasa Yang bug fix for Tx timeout & add SiS963 support
    Rev 1.08.05 Jun. 6 2002 Mufasa Yang bug fix for read_eeprom & Tx descriptor over-boundary 
    Rev 1.08.04 Apr. 25 2002 Mufasa Yang <mufasa@sis.com.tw> added SiS962 support
@@ -69,18 +71,20 @@
 #include <asm/processor.h>      /* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>	/* User space memory access functions */
+#include <asm/uaccess.h>        /* User space memory access functions */
 
 #include "sis900.h"
 
 #define SIS900_MODULE_NAME "sis900"
-#define SIS900_DRV_VERSION "v1.08.06 9/24/2002"
+#define SIS900_DRV_VERSION "v1.08.07 7/16/2003"
+#define SIS900_WOL_DEFAULT 0
 
 static char version[] __devinitdata =
 KERN_INFO "sis900.c: " SIS900_DRV_VERSION "\n";
 
 static int max_interrupt_work = 40;
 static int multicast_filter_limit = 128;
+static int enable_wol = SIS900_WOL_DEFAULT;
 
 #define sis900_debug debug
 static int sis900_debug;
@@ -179,9 +183,11 @@
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
+MODULE_PARM(enable_wol, "i");
 MODULE_PARM_DESC(multicast_filter_limit, "SiS 900/7016 maximum number of filtered multicast addresses");
 MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "SiS 900/7016 debug level (2-4)");
+MODULE_PARM_DESC(enable_wol, "Enable Wake-on-LAN support (0/1)");
 
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
@@ -908,6 +914,7 @@
 {
 	struct sis900_private *sis_priv = net_dev->priv;
 	long ioaddr = net_dev->base_addr;
+	u32 cfgpmcsr;
 	u8 revision;
 	int ret;
 
@@ -934,6 +941,15 @@
 	/* Workaround for EDB */
 	sis900_set_mode(ioaddr, HW_SPEED_10_MBPS, FDX_CAPABLE_HALF_SELECTED);
 
+	/* Enable Wake-on-LAN if requested. */
+	if (enable_wol) {
+		pci_read_config_dword(sis_priv->pci_dev, CFGPMCSR, &cfgpmcsr);
+		cfgpmcsr |= PME_EN;
+		pci_write_config_dword(sis_priv->pci_dev, CFGPMCSR, cfgpmcsr);
+		outl(inl(ioaddr + pmctrl) | MAGICPKT | ALGORITHM, ioaddr + pmctrl);
+	} else
+		outl(inl(ioaddr + pmctrl) & ~MAGICPKT, ioaddr + pmctrl);
+
 	/* Enable all known interrupts by setting the interrupt mask. */
 	outl((RxSOVR|RxORN|RxERR|RxOK|TxURN|TxERR|TxIDLE), ioaddr + imr);
 	outl(RxENA | inl(ioaddr + cr), ioaddr + cr);
diff --unified --recursive linux-2.4.21/drivers/net/sis900.h linux-2.4.21sis900_wol/drivers/net/sis900.h
--- linux-2.4.21/drivers/net/sis900.h	2002-11-28 23:53:14.000000000 +0000
+++ linux-2.4.21sis900_wol/drivers/net/sis900.h	2003-07-16 11:18:47.000000000 +0100
@@ -140,6 +140,25 @@
 	EEREQ = 0x00000400, EEDONE = 0x00000200, EEGNT = 0x00000100
 };
 
+/* Wake-on-LAN support. */
+enum sis900_power_management_control_register_bits {
+	LINKLOSS  = 0x00000001,
+	LINKON    = 0x00000002,
+	MAGICPKT  = 0x00000400,
+	ALGORITHM = 0x00000800,
+	FRM1EN    = 0x00100000,
+	FRM2EN    = 0x00200000,
+	FRM3EN    = 0x00400000,
+	FRM1ACS   = 0x01000000,
+	FRM2ACS   = 0x02000000,
+	FRM3ACS   = 0x04000000,
+	WAKEALL   = 0x40000000,
+	GATECLK   = 0x80000000
+};
+
+#define CFGPMCSR 0x44
+#define PME_EN 0x100
+
 /* Manamgement Data I/O (mdio) frame */
 #define MIIread         0x6000
 #define MIIwrite        0x5002

--YiEDa0DAkWCtVeE4--
