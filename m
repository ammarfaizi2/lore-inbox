Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQKHKLj>; Wed, 8 Nov 2000 05:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbQKHKLa>; Wed, 8 Nov 2000 05:11:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130147AbQKHKLQ>; Wed, 8 Nov 2000 05:11:16 -0500
Subject: Re: When I use kernel-2.4.0-test10,I got this problem on my server.
To: asdf2970@netease.com
Date: Wed, 8 Nov 2000 10:07:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20001108092403.0E0351C404EAA@mx1.netease.com> from "cnchun" at Nov 08, 2000 05:17:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tS8R-0008QN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel-2.2.18 can run on my server very well.My server is DELL 6450/550 with 4G MEM and 4 CPU,I also have 2 Raid-5(DELL
> Powervault 210s) with 1.6 TG storage.

My fault. 2.4test contains a forward port of some 2.2 experimenting that
was backed out

Try


--- drivers/scsi/megaraid.c~	Tue Oct 31 20:32:01 2000
+++ drivers/scsi/megaraid.c	Wed Nov  8 09:26:17 2000
@@ -1491,21 +1491,6 @@
 	    pciDev,
 	    pdev->slot_name);
 
-    /*
-     *	Dont crash on boot with AMI cards configured for I2O. 
-     *  (our I2O code will find them then they will fail oddly until
-     *   we figure why they upset our I2O code). This driver will die
-     *   if it tries to boot an I2O mode board and we dont stop it now.
-     *     - Alan Cox , Red Hat Software, Jan 2000
-     */
-     	    
-    if((pdev->class >> 8) == PCI_CLASS_INTELLIGENT_I2O)
-    {
-    	printk( KERN_INFO "megaraid: Board configured for I2O, ignoring this card. Reconfigure the card\n"
-		KERN_INFO "megaraid: in the BIOS for \"mass storage\" to use it with this driver.\n");
-	continue;
-    }		
-
     /* Read the base port and IRQ from PCI */
     megaBase = pci_resource_start (pdev, 0);
     megaIrq  = pdev->irq;
@@ -1545,12 +1530,11 @@
     megaCtlrs[numCtlrs++] = megaCfg; 
     if (flag != BOARD_QUARTZ) {
       /* Request our IO Range */
-      if (check_region (megaBase, 16)) {
+      if (request_region (megaBase, 16, "megaraid")) {
 	printk (KERN_WARNING "megaraid: Couldn't register I/O range!" CRLFSTR);
 	scsi_unregister (host);
 	continue;
       }
-      request_region (megaBase, 16, "megaraid");
     }
 
     /* Request our IRQ */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
