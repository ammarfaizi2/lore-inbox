Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTIDO3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTIDO3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:29:32 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:43831 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265034AbTIDO2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:28:40 -0400
Subject: [PATCH] synclink.c 2.4.23-pre3
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062685678.2183.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Sep 2003 09:27:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Add support for version 2 of synclink PCI adapter
* Fix arbitration between net open and tty open
* Use time_after() macro
* Use mod_timer() macro
* Fix RCC underrun handling

Please apply.


-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.4.23-pre3/drivers/char/synclink.c	2002-11-28 17:53:12.000000000 -0600
+++ linux-2.4.23-pre3-mg/drivers/char/synclink.c	2003-09-04 08:22:25.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 3.12 2001/07/18 19:14:21 paulkf Exp $
+ * $Id: synclink.c,v 3.20 2003/07/16 19:51:07 paulkf Exp $
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
 	
@@ -270,6 +271,7 @@
 
 	int rx_enabled;
 	int rx_overflow;
+	int rx_rcc_underrun;
 
 	int tx_enabled;
 	int tx_active;
@@ -922,7 +924,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 3.12 $";
+static char *driver_version = "$Revision: 3.20 $";
 
 static int __init synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -930,17 +932,20 @@
 
 static struct pci_device_id synclink_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_MICROGATE, PCI_DEVICE_ID_MICROGATE_USC, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_MICROGATE, 0x0210, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }, /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, synclink_pci_tbl);
 
+#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
+#endif
 
 static struct pci_driver synclink_pci_driver = {
 	name:		"synclink",
 	id_table:	synclink_pci_tbl,
 	probe:		synclink_init_one,
-	remove:		__devexit_p(synclink_remove_one),
+	remove:		synclink_remove_one,
 };
 
 static struct tty_driver serial_driver, callout_driver;
@@ -1140,8 +1145,16 @@
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_receive(%s)\n",
 			__FILE__,__LINE__,info->device_name);
-	
-	while( (get_rx_frame)(info) );
+	do
+	{
+		if (info->rx_rcc_underrun) {
+			unsigned long flags;
+			spin_lock_irqsave(&info->irq_spinlock,flags);
+			usc_start_receiver(info);
+			spin_unlock_irqrestore(&info->irq_spinlock,flags);
+			return;
+		}
+	} while(get_rx_frame(info));
 }
 
 void mgsl_bh_transmit(struct mgsl_struct *info)
@@ -1583,6 +1596,21 @@
 	if ( debug_level >= DEBUG_LEVEL_ISR )	
 		printk("%s(%d):mgsl_isr_misc status=%04X\n",
 			__FILE__,__LINE__,status);
+
+	if ((status & MISCSTATUS_RCC_UNDERRUN) &&
+	    (info->params.mode == MGSL_MODE_HDLC)) {
+
+		/* turn off receiver and rx DMA */
+		usc_EnableReceiver(info,DISABLE_UNCONDITIONAL);
+		usc_DmaCmd(info, DmaCmd_ResetRxChannel);
+		usc_UnlatchRxstatusBits(info, RXSTATUS_ALL);
+		usc_ClearIrqPendingBits(info, RECEIVE_DATA + RECEIVE_STATUS);
+		usc_DisableInterrupts(info, RECEIVE_DATA + RECEIVE_STATUS);
+
+		/* schedule BH handler to restart receiver */
+		info->pending_bh |= BH_RECEIVE;
+		info->rx_rcc_underrun = 1;
+	}
 			
 	usc_ClearIrqPendingBits( info, MISC );
 	usc_UnlatchMiscstatusBits( info, status );
@@ -3251,14 +3279,17 @@
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
@@ -3393,7 +3424,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	} else {
@@ -3403,7 +3434,7 @@
 			schedule_timeout(char_time);
 			if (signal_pending(current))
 				break;
-			if (timeout && ((orig_jiffies + timeout) < jiffies))
+			if (timeout && time_after(jiffies, orig_jiffies + timeout))
 				break;
 		}
 	}
@@ -3612,16 +3643,11 @@
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
@@ -3695,6 +3721,8 @@
 	
 cleanup:			
 	if (retval) {
+		if (tty->count == 1)
+			info->tty = 0; /* tty layer will release tty struct */
 		if(MOD_IN_USE)
 			MOD_DEC_USE_COUNT;
 		if(info->count)
@@ -3760,7 +3788,7 @@
 		if (info->icount.rxover)
 			ret += sprintf(buf+ret, " rxover:%d", info->icount.rxover);
 		if (info->icount.rxcrc)
-			ret += sprintf(buf+ret, " rxlong:%d", info->icount.rxcrc);
+			ret += sprintf(buf+ret, " rxcrc:%d", info->icount.rxcrc);
 	} else {
 		ret += sprintf(buf+ret, " ASYNC tx:%d rx:%d",
 			      info->icount.tx, info->icount.rx);
@@ -4291,9 +4319,7 @@
 				info->get_tx_holding_index=0;
 
 			/* restart transmit timer */
-			del_timer(&info->tx_timer);
-			info->tx_timer.expires = jiffies + jiffies_from_ms(5000);
-			add_timer(&info->tx_timer);
+			mod_timer(&info->tx_timer, jiffies + jiffies_from_ms(5000));
 
 			ret = 1;
 		}
@@ -4511,12 +4537,12 @@
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
@@ -5367,7 +5393,11 @@
 	usc_EnableMasterIrqBit( info );
 
 	usc_ClearIrqPendingBits( info, RECEIVE_STATUS + RECEIVE_DATA +
-				TRANSMIT_STATUS + TRANSMIT_DATA );
+				TRANSMIT_STATUS + TRANSMIT_DATA + MISC);
+
+	/* arm RCC underflow interrupt */
+	usc_OutReg(info, SICR, (u16)(usc_InReg(info,SICR) | BIT3));
+	usc_EnableInterrupts(info, MISC);
 
 	info->mbre_bit = 0;
 	outw( 0, info->io_base ); 			/* clear Master Bus Enable (DCAR) */
@@ -5375,10 +5405,11 @@
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
@@ -5804,6 +5835,7 @@
 
 	info->rx_enabled = 0;
 	info->rx_overflow = 0;
+	info->rx_rcc_underrun = 0;
 	
 }	/* end of stop_receiver() */
 
@@ -6355,10 +6387,11 @@
 
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
 
@@ -6449,10 +6482,11 @@
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
 
@@ -7496,7 +7530,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7552,7 +7586,7 @@
 	EndTime = jiffies + jiffies_from_ms(100);
 
 	for(;;) {
-		if ( jiffies > EndTime ) {
+		if (time_after(jiffies, EndTime)) {
 			rc = FALSE;
 			break;
 		}
@@ -7600,7 +7634,7 @@
 		spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
 		while ( !(status & (BIT6+BIT5+BIT4+BIT2+BIT1)) ) {
-			if ( jiffies > EndTime ) {
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}
@@ -7627,8 +7661,7 @@
 		/* Wait for 16C32 to write receive status to buffer entry. */
 		status=info->rx_buffer_list[0].status;
 		while ( status == 0 ) {
-			if ( jiffies > EndTime ) {
-			printk(KERN_ERR"mark 4\n");
+			if (time_after(jiffies, EndTime)) {
 				rc = FALSE;
 				break;
 			}
@@ -8202,17 +8235,20 @@
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
 



