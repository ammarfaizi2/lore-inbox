Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbTFSPED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbTFSPED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:04:03 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:54116 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265787AbTFSPDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:03:51 -0400
Subject: [PATCH] 2.4.21 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1056035884.2037.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jun 2003 10:18:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Add support for version 2 of synclink PCI adapter
* Fix arbitration between net open and tty open
* Use time_after() macro
* Use mod_timer() macro

Please apply.


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.4.21/drivers/char/synclink.c	2002-11-28 17:53:12.000000000 -0600
+++ linux-2.4.21-mg/drivers/char/synclink.c	2003-06-19 08:25:43.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 3.12 2001/07/18 19:14:21 paulkf Exp $
+ * $Id: synclink.c,v 3.18 2003/06/18 21:02:25 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -198,6 +198,7 @@
 	int			flags;
 	int			count;		/* count of opens */
 	int			line;
+	int                     hw_version;
 	unsigned short		close_delay;
 	unsigned short		closing_wait;	/* time to wait before closing */
 	
@@ -922,7 +923,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 3.12 $";
+static char *driver_version = "$Revision: 3.18 $";
 
 static int __init synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -930,6 +931,7 @@
 
 static struct pci_device_id synclink_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_MICROGATE, 0x0210, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, synclink_pci_tbl);
@@ -3251,14 +3253,17 @@
 {
 	struct mgsl_struct * info = (struct mgsl_struct *)tty->driver_data;
 
-	if (!info || mgsl_paranoia_check(info, tty->device, "mgsl_close"))
+	if (mgsl_paranoia_check(info, tty->device, "mgsl_close"))
 		return;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->count);
 			 
-	if (!info->count || tty_hung_up_p(filp))
+	if (!info->count)
+		return;
+
+	if (tty_hung_up_p(filp))
 		goto cleanup;
 			
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -3393,7 +3398,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -3403,7 +3408,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -3612,16 +3617,11 @@
 	info = mgsl_device_list;
 	while(info && info->line != line)
 		info = info->next_device;
-	if ( !info ){
-		printk("%s(%d):Can't find specified device on open (line=%d)\n",
-			__FILE__,__LINE__,line);
+	if (mgsl_paranoia_check(info, tty->device, "mgsl_open"))
 		return -ENODEV;
-	}
 	
 	tty->driver_data = info;
 	info->tty = tty;
-	if (mgsl_paranoia_check(info, tty->device, "mgsl_open"))
-		return -ENODEV;
 		
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_open(%s), old ref count = %d\n",
@@ -3695,6 +3695,8 @@
 	
 cleanup:			
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(MOD_IN_USE)
 			MOD_DEC_USE_COUNT;
 		if(info->count)
@@ -4291,9 +4293,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			del_timer(&info->tx_timer);
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);
+			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
 
 			ret = 1;
 		}
@@ -4511,12 +4511,12 @@
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
@@ -5375,10 +5375,11 @@
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
@@ -6355,10 +6356,11 @@
 
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
 
@@ -6449,10 +6451,11 @@
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
 
@@ -7496,7 +7499,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7552,7 +7555,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7600,7 +7603,7 @@
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 		while ( !(status & (BIT6+BIT5+BIT4+BIT2+BIT1)) ) {
-			if ( jiffies > EndTime ) {
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}
@@ -7627,8 +7630,7 @@
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;
 		while ( status == 0 ) {
-			if ( jiffies > EndTime ) {
-			printk(KERN_ERR"mark 4\n");
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}
@@ -8202,17 +8204,20 @@
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
 




