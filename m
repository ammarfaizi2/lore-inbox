Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264317AbTCXQ4A>; Mon, 24 Mar 2003 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264261AbTCXQuH>; Mon, 24 Mar 2003 11:50:07 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:35306 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264279AbTCXQay>; Mon, 24 Mar 2003 11:30:54 -0500
Message-Id: <200303241642.h2OGfx35008220@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:47 +0000
To: alan@redhat.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: amd74xx cable detect.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch from a few weeks back, that seemed to not get
any attention. Currently the cable detection is based upon
reads from an uninitialised variable.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/pci/amd74xx.c linux-2.5/drivers/ide/pci/amd74xx.c
--- bk-linus/drivers/ide/pci/amd74xx.c	2003-03-22 12:36:22.000000000 +0000
+++ linux-2.5/drivers/ide/pci/amd74xx.c	2003-03-22 12:41:47.000000000 +0000
@@ -313,7 +313,8 @@ static unsigned int __init init_chipset_
 
 		case AMD_UDMA_100:
 			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
-			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
+			amd_80w = ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
+			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
 					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.\n");
