Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTIEPdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTIEPdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:33:50 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:7000 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262683AbTIEPdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:33:46 -0400
Subject: [PATCH] 2.6.0-test4 synclink.c
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@osdl.org" <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062776000.2675.1.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Sep 2003 10:33:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* add RCC underrun handling
* fix stats output typo
* replace previously removed NULL context check
  (causes oops when opening non existent device)

Please apply

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com

--- linux-2.6.0-test4/drivers/char/synclink.c	2003-09-05 10:25:15.000000000 -0500
+++ linux-2.6.0-test4-mg/drivers/char/synclink.c	2003-09-05 10:26:56.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.12 2003/06/18 15:29:32 paulkf Exp $
+ * $Id: synclink.c,v 4.16 2003/09/05 15:26:02 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -261,6 +261,7 @@
 
 	int rx_enabled;
 	int rx_overflow;
+	int rx_rcc_underrun;
 
 	int tx_enabled;
 	int tx_active;
@@ -910,7 +911,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.12 $";
+static char *driver_version = "$Revision: 4.16 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -983,6 +984,9 @@
 		printk(badmagic, name, routine);
 		return 1;
 	}
+#else
+	if (!info)
+		return 1;
 #endif
 	return 0;
 }
@@ -1125,7 +1129,16 @@
 		printk( "%s(%d):mgsl_bh_receive(%s)\n",
 			__FILE__,__LINE__,info->device_name);
 	
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
@@ -1567,6 +1580,21 @@
 		printk("%s(%d):mgsl_isr_misc status=%04X\n",
 			__FILE__,__LINE__,status);
 			
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
+
 	usc_ClearIrqPendingBits( info, MISC );
 	usc_UnlatchMiscstatusBits( info, status );
 
@@ -3625,7 +3653,7 @@
 		if (info->icount.rxover)
 			ret += sprintf(buf+ret, " rxover:%d", info->icount.rxover);
 		if (info->icount.rxcrc)
-			ret += sprintf(buf+ret, " rxlong:%d", info->icount.rxcrc);
+			ret += sprintf(buf+ret, " rxcrc:%d", info->icount.rxcrc);
 	} else {
 		ret += sprintf(buf+ret, " ASYNC tx:%d rx:%d",
 			      info->icount.tx, info->icount.rx);
@@ -5190,7 +5218,11 @@
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
@@ -5628,6 +5660,7 @@
 
 	info->rx_enabled = 0;
 	info->rx_overflow = 0;
+	info->rx_rcc_underrun = 0;
 	
 }	/* end of stop_receiver() */
 



