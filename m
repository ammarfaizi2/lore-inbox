Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTEFVXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTEFVXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:23:34 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:842 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261876AbTEFVXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:23:31 -0400
Subject: [PATCH] 2.5.69 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052256969.2497.3.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 16:36:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Add support for hardware version 2 (universal PCI) of synclink adapter
* Use mod_timer() function

Please apply.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.5.69/drivers/char/synclink.c	2003-05-06 14:16:19.000000000 -0500
+++ linux-2.5.69-mg/drivers/char/synclink.c	2003-05-06 16:29:47.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.6 2003/04/21 17:46:54 paulkf Exp $
+ * $Id: synclink.c,v 4.9 2003/05/06 21:18:51 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -193,6 +193,7 @@
 	int			flags;
 	int			count;		/* count of opens */
 	int			line;
+	int                     hw_version;
 	unsigned short		close_delay;
 	unsigned short		closing_wait;	/* time to wait before closing */
 	
@@ -917,7 +918,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.6 $";
+static char *driver_version = "$Revision: 4.9 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -925,6 +926,7 @@
 
 static struct pci_device_id synclink_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_MICROGATE, 0x0210, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, synclink_pci_tbl);
@@ -4216,9 +4218,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			del_timer(&info->tx_timer);
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);
+			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
 
 			ret = 1;
 		}
@@ -4436,12 +4436,12 @@
 		info->max_frame_size = 65535;
 	
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		printk( "SyncLink device %s added:PCI bus IO=%04X IRQ=%d Mem=%08X LCR=%08X MaxFrameSize=%u\n",
-			info->device_name, info->io_base, info->irq_level,
+		printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
+			info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
 			info->phys_memory_base, info->phys_lcr_base,
 		     	info->max_frame_size );
 	} else {
-		printk( "SyncLink device %s added:ISA bus IO=%04X IRQ=%d DMA=%d MaxFrameSize=%u\n",
+		printk( "SyncLink ISA %s: IO=%04X IRQ=%d DMA=%d MaxFrameSize=%u\n",
 			info->device_name, info->io_base, info->irq_level, info->dma_level,
 		     	info->max_frame_size );
 	}
@@ -5296,10 +5296,11 @@
 	info->mbre_bit = BIT8;
 	outw( BIT8, info->io_base );			/* set Master Bus Enable (DCAR) */
 
-	/* Enable DMAEN (Port 7, Bit 14) */
-	/* This connects the DMA request signal to the ISA bus */
-	/* on the ISA adapter. This has no effect for the PCI adapter */
-	usc_OutReg( info, PCR, (u16)((usc_InReg(info, PCR) | BIT15) & ~BIT14) );
+	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
+		/* Enable DMAEN (Port 7, Bit 14) */
+		/* This connects the DMA request signal to the ISA bus */
+		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT15) & ~BIT14));
+	}
 
 	/* DMA Control Register (DCR)
 	 *
@@ -6276,10 +6277,11 @@
 
 	usc_EnableMasterIrqBit( info );
 
-	/* Enable INTEN (Port 6, Bit12) */
-	/* This connects the IRQ request signal to the ISA bus */
-	/* on the ISA adapter. This has no effect for the PCI adapter */
-	usc_OutReg( info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12) );
+	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
+		/* Enable INTEN (Port 6, Bit12) */
+		/* This connects the IRQ request signal to the ISA bus */
+		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
+	}
 
 }	/* end of usc_set_async_mode() */
 
@@ -6370,10 +6372,11 @@
 	usc_loopback_frame( info );
 	usc_set_sdlc_mode( info );
 
-	/* Enable INTEN (Port 6, Bit12) */
-	/* This connects the IRQ request signal to the ISA bus */
-	/* on the ISA adapter. This has no effect for the PCI adapter */
-	usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
+	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
+		/* Enable INTEN (Port 6, Bit12) */
+		/* This connects the IRQ request signal to the ISA bus */
+		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
+	}
 
 	usc_enable_aux_clock(info, info->params.clock_speed);
 
@@ -8115,17 +8118,20 @@
 	info->bus_type = MGSL_BUS_TYPE_PCI;
 	info->io_addr_size = 8;
 	info->irq_flags = SA_SHIRQ;
-		
-	/* Store the PCI9050 misc control register value because a flaw
-	 * in the PCI9050 prevents LCR registers from being read if 
-	 * BIOS assigns an LCR base address with bit 7 set.
-	 *  
-	 * Only the misc control register is accessed for which only 
-	 * write access is needed, so set an initial value and change 
-	 * bits to the device instance data as we write the value
-	 * to the actual misc control register.
-	 */
-	info->misc_ctrl_value = 0x087e4546;
+
+	if (dev->device == 0x0210) {
+		/* Version 1 PCI9030 based universal PCI adapter */
+		info->misc_ctrl_value = 0x007c4080;
+		info->hw_version = 1;
+	} else {
+		/* Version 0 PCI9050 based 5V PCI adapter
+		 * A PCI9050 bug prevents reading LCR registers if 
+		 * LCR base address bit 7 is set. Maintain shadow
+		 * value so we can write to LCR misc control reg.
+		 */
+		info->misc_ctrl_value = 0x087e4546;
+		info->hw_version = 0;
+	}
 				
 	mgsl_add_device(info);
 



