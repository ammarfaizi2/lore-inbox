Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTEODTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTEODSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:40 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:6380 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263781AbTEODSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:17 -0400
Date: Thu, 15 May 2003 04:31:05 +0100
Message-Id: <200305150331.h4F3V5KB000583@deviant.impure.org.uk>
To: alan@redhat.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Incorrect AMD74xx UDMA100 test.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do 80wire comparisons based on an uninitialised var.
Shouldn't we also be doing the 80wire check on the UDMA66 case ?

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/pci/amd74xx.c linux-2.5/drivers/ide/pci/amd74xx.c
--- bk-linus/drivers/ide/pci/amd74xx.c	2003-04-10 06:01:18.000000000 +0100
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
