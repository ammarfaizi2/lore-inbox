Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUH0VC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUH0VC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUH0VBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:01:48 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:25383 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267696AbUH0U4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:56:39 -0400
Subject: [PATCH] 2.6.9-rc1-bk3 synclinkmp transmit eom fix
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093640193.2640.5.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 15:56:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug Fixes:

* Fix transmit end of message (EOM) processing to
  work correctly with hardware auto CTS feature

* Fix oops in error path if hardware diags fail
  during device initialization

Cosmetic change:

* Use existing macros for address space size
  instead of hardcoded values

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

Please apply.

--
Paul Fulghum
paulkf@microgate.com


--- linux-2.6.9-rc1-bk3/drivers/char/synclinkmp.c	2004-08-27 14:54:10.761161575 -0500
+++ linux-2.6.9-rc1-bk3-mg/drivers/char/synclinkmp.c	2004-08-27 15:54:23.818985480 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.26 2004/08/11 19:30:02 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.29 2004/08/27 20:06:41 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -489,7 +489,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.26 $";
+static char *driver_version = "$Revision: 4.29 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -651,7 +651,7 @@
 static unsigned char tx_negate_fifo_level = 32;	// tx request FIFO negation level in bytes
 
 static u32 misc_ctrl_value = 0x007e4040;
-static u32 lcr1_brdr_value = 0x0080002d;
+static u32 lcr1_brdr_value = 0x00800029;
 
 static u32 read_ahead_count = 8;
 
@@ -2182,16 +2182,15 @@
 {
  	struct tty_struct *tty = info->tty;
  	struct	mgsl_icount *icount = &info->icount;
-	unsigned char status = read_reg(info, SR1);
-	unsigned char status2 = read_reg(info, SR2);
+	unsigned char status = read_reg(info, SR1) & info->ie1_value & (FLGD + IDLD + CDCD + BRKD);
+	unsigned char status2 = read_reg(info, SR2) & info->ie2_value & OVRN;
 
 	/* clear status bits */
-	if ( status & (FLGD + IDLD + CDCD + BRKD) )
-		write_reg(info, SR1, 
-				(unsigned char)(status & (FLGD + IDLD + CDCD + BRKD)));
+	if (status)
+		write_reg(info, SR1, status);
 
-	if ( status2 & OVRN )
-		write_reg(info, SR2, (unsigned char)(status2 & OVRN));
+	if (status2)
+		write_reg(info, SR2, status2);
 	
 	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):%s isr_rxint status=%02X %02x\n",
@@ -2328,15 +2327,22 @@
 		printk("%s(%d):%s isr_txeom status=%02x\n",
 			__FILE__,__LINE__,info->device_name,status);
 
-	/* disable and clear MSCI interrupts */
-	info->ie1_value &= ~(IDLE + UDRN);
-	write_reg(info, IE1, info->ie1_value);
-	write_reg(info, SR1, (unsigned char)(UDRN + IDLE));
-
 	write_reg(info, TXDMA + DIR, 0x00); /* disable Tx DMA IRQs */
 	write_reg(info, TXDMA + DSR, 0xc0); /* clear IRQs and disable DMA */
 	write_reg(info, TXDMA + DCMD, SWABORT);	/* reset/init DMA channel */
 
+	if (status & UDRN) {
+		write_reg(info, CMD, TXRESET);
+		write_reg(info, CMD, TXENABLE);
+	} else
+		write_reg(info, CMD, TXBUFCLR);
+
+	/* disable and clear tx interrupts */
+	info->ie0_value &= ~TXRDYE;
+	info->ie1_value &= ~(IDLE + UDRN);
+	write_reg16(info, IE0, (unsigned short)((info->ie1_value << 8) + info->ie0_value));
+	write_reg(info, SR1, (unsigned char)(UDRN + IDLE));
+
 	if ( info->tx_active ) {
 		if (info->params.mode != MGSL_MODE_ASYNC) {
 			if (status & UDRN)
@@ -2377,10 +2383,10 @@
  */
 void isr_txint(SLMP_INFO * info)
 {
-	unsigned char status = read_reg(info, SR1);
+	unsigned char status = read_reg(info, SR1) & info->ie1_value & (UDRN + IDLE + CCTS);
 
 	/* clear status bits */
-	write_reg(info, SR1, (unsigned char)(status & (UDRN + IDLE + CCTS)));
+	write_reg(info, SR1, status);
 
 	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):%s isr_txint status=%02x\n",
@@ -2409,6 +2415,14 @@
 		printk("%s(%d):%s isr_txrdy() tx_count=%d\n",
 			__FILE__,__LINE__,info->device_name,info->tx_count);
 
+	if (info->params.mode != MGSL_MODE_ASYNC) {
+		/* disable TXRDY IRQ, enable IDLE IRQ */
+		info->ie0_value &= ~TXRDYE;
+		info->ie1_value |= IDLE;
+		write_reg16(info, IE0, (unsigned short)((info->ie1_value << 8) + info->ie0_value));
+		return;
+	}
+
 	if (info->tty && (info->tty->stopped || info->tty->hw_stopped)) {
 		tx_stop(info);
 		return;
@@ -2463,13 +2477,6 @@
 
 void isr_txdmaok(SLMP_INFO * info)
 {
-	/* BIT7 = EOT (end of transfer, used for async mode)
-	 * BIT6 = EOM (end of message/frame, used for sync mode)
-	 *
-	 * We don't look at DMA status because only EOT is enabled
-	 * and we always clear and disable all tx DMA IRQs.
-	 */
-//	unsigned char dma_status = read_reg(info,TXDMA + DSR) & 0xc0;
 	unsigned char status_reg1 = read_reg(info, SR1);
 
 	write_reg(info, TXDMA + DIR, 0x00);	/* disable Tx DMA IRQs */
@@ -2480,19 +2487,10 @@
 		printk("%s(%d):%s isr_txdmaok(), status=%02x\n",
 			__FILE__,__LINE__,info->device_name,status_reg1);
 
-	/* If transmitter already idle, do end of frame processing,
-	 * otherwise enable interrupt for tx IDLE.
-	 */
-	if (status_reg1 & IDLE)
-		isr_txeom(info, IDLE);
-	else {
-		/* disable and clear underrun IRQ, enable IDLE interrupt */
-		info->ie1_value |= IDLE;
-		info->ie1_value &= ~UDRN;
-		write_reg(info, IE1, info->ie1_value);
-
-		write_reg(info, SR1, UDRN);
-	}
+	/* program TXRDY as FIFO empty flag, enable TXRDY IRQ */
+	write_reg16(info, TRC0, 0);
+	info->ie0_value |= TXRDYE;
+	write_reg(info, IE0, info->ie0_value);
 }
 
 void isr_txdmaerror(SLMP_INFO * info)
@@ -3176,7 +3174,7 @@
 		unsigned char oldval = info->ie1_value;
 		unsigned char newval = oldval +
 			 (mask & MgslEvent_ExitHuntMode ? FLGD:0) +
-			 (mask & MgslEvent_IdleReceived ? IDLE:0);
+			 (mask & MgslEvent_IdleReceived ? IDLD:0);
 		if ( oldval != newval ) {
 			info->ie1_value = newval;
 			write_reg(info, IE1, info->ie1_value);
@@ -3243,7 +3241,7 @@
 		spin_lock_irqsave(&info->lock,flags);
 		if (!waitqueue_active(&info->event_wait_q)) {
 			/* disable enable exit hunt mode/idle rcvd IRQs */
-			info->ie1_value &= ~(FLGD|IDLE);
+			info->ie1_value &= ~(FLGD|IDLD);
 			write_reg(info, IE1, info->ie1_value);
 		}
 		spin_unlock_irqrestore(&info->lock,flags);
@@ -3637,9 +3635,10 @@
 
 int claim_resources(SLMP_INFO *info)
 {
-	if (request_mem_region(info->phys_memory_base,0x40000,"synclinkmp") == NULL) {
+	if (request_mem_region(info->phys_memory_base,SCA_MEM_SIZE,"synclinkmp") == NULL) {
 		printk( "%s(%d):%s mem addr conflict, Addr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_memory_base);
+		info->init_error = DiagStatus_AddressConflict;
 		goto errout;
 	}
 	else
@@ -3648,22 +3647,25 @@
 	if (request_mem_region(info->phys_lcr_base + info->lcr_offset,128,"synclinkmp") == NULL) {
 		printk( "%s(%d):%s lcr mem addr conflict, Addr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_lcr_base);
+		info->init_error = DiagStatus_AddressConflict;
 		goto errout;
 	}
 	else
 		info->lcr_mem_requested = 1;
 
-	if (request_mem_region(info->phys_sca_base + info->sca_offset,512,"synclinkmp") == NULL) {
+	if (request_mem_region(info->phys_sca_base + info->sca_offset,SCA_BASE_SIZE,"synclinkmp") == NULL) {
 		printk( "%s(%d):%s sca mem addr conflict, Addr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_sca_base);
+		info->init_error = DiagStatus_AddressConflict;
 		goto errout;
 	}
 	else
 		info->sca_base_requested = 1;
 
-	if (request_mem_region(info->phys_statctrl_base + info->statctrl_offset,16,"synclinkmp") == NULL) {
+	if (request_mem_region(info->phys_statctrl_base + info->statctrl_offset,SCA_REG_SIZE,"synclinkmp") == NULL) {
 		printk( "%s(%d):%s stat/ctrl mem addr conflict, Addr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_statctrl_base);
+		info->init_error = DiagStatus_AddressConflict;
 		goto errout;
 	}
 	else
@@ -3673,33 +3675,41 @@
 	if (!info->memory_base) {
 		printk( "%s(%d):%s Cant map shared memory, MemAddr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
+		info->init_error = DiagStatus_CantAssignPciResources;
 		goto errout;
 	}
 
-	if ( !memory_test(info) ) {
-		printk( "%s(%d):Shared Memory Test failed for device %s MemAddr=%08X\n",
-			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
-		goto errout;
-	}
-
-	info->lcr_base = ioremap(info->phys_lcr_base,PAGE_SIZE) + info->lcr_offset;
+	info->lcr_base = ioremap(info->phys_lcr_base,PAGE_SIZE);
 	if (!info->lcr_base) {
 		printk( "%s(%d):%s Cant map LCR memory, MemAddr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_lcr_base );
+		info->init_error = DiagStatus_CantAssignPciResources;
 		goto errout;
 	}
+	info->lcr_base += info->lcr_offset;
 
-	info->sca_base = ioremap(info->phys_sca_base,PAGE_SIZE) + info->sca_offset;
+	info->sca_base = ioremap(info->phys_sca_base,PAGE_SIZE);
 	if (!info->sca_base) {
 		printk( "%s(%d):%s Cant map SCA memory, MemAddr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_sca_base );
+		info->init_error = DiagStatus_CantAssignPciResources;
 		goto errout;
 	}
+	info->sca_base += info->sca_offset;
 
-	info->statctrl_base = ioremap(info->phys_statctrl_base,PAGE_SIZE) + info->statctrl_offset;
+	info->statctrl_base = ioremap(info->phys_statctrl_base,PAGE_SIZE);
 	if (!info->statctrl_base) {
 		printk( "%s(%d):%s Cant map SCA Status/Control memory, MemAddr=%08X\n",
 			__FILE__,__LINE__,info->device_name, info->phys_statctrl_base );
+		info->init_error = DiagStatus_CantAssignPciResources;
+		goto errout;
+	}
+	info->statctrl_base += info->statctrl_offset;
+
+	if ( !memory_test(info) ) {
+		printk( "%s(%d):Shared Memory Test failed for device %s MemAddr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
+		info->init_error = DiagStatus_MemoryError;
 		goto errout;
 	}
 
@@ -3722,7 +3732,7 @@
 	}
 
 	if ( info->shared_mem_requested ) {
-		release_mem_region(info->phys_memory_base,0x40000);
+		release_mem_region(info->phys_memory_base,SCA_MEM_SIZE);
 		info->shared_mem_requested = 0;
 	}
 	if ( info->lcr_mem_requested ) {
@@ -3730,11 +3740,11 @@
 		info->lcr_mem_requested = 0;
 	}
 	if ( info->sca_base_requested ) {
-		release_mem_region(info->phys_sca_base + info->sca_offset,512);
+		release_mem_region(info->phys_sca_base + info->sca_offset,SCA_BASE_SIZE);
 		info->sca_base_requested = 0;
 	}
 	if ( info->sca_statctrl_requested ) {
-		release_mem_region(info->phys_statctrl_base + info->statctrl_offset,16);
+		release_mem_region(info->phys_statctrl_base + info->statctrl_offset,SCA_REG_SIZE);
 		info->sca_statctrl_requested = 0;
 	}
 
@@ -3975,7 +3985,6 @@
 
 static void synclinkmp_cleanup(void)
 {
-	unsigned long flags;
 	int rc;
 	SLMP_INFO *info;
 	SLMP_INFO *tmp;
@@ -3989,33 +3998,24 @@
 		put_tty_driver(serial_driver);
 	}
 
+	/* reset devices */
 	info = synclinkmp_device_list;
 	while(info) {
-#ifdef CONFIG_HDLC
-		hdlcdev_exit(info);
-#endif
 		reset_port(info);
-		if ( info->port_num == 0 ) {
-			if ( info->irq_requested ) {
-				free_irq(info->irq_level, info);
-				info->irq_requested = 0;
-			}
-		}
 		info = info->next_device;
 	}
 
-	/* port 0 of each adapter originally claimed
-	 * all resources, release those now
-	 */
+	/* release devices */
 	info = synclinkmp_device_list;
 	while(info) {
+#ifdef CONFIG_HDLC
+		hdlcdev_exit(info);
+#endif
 		free_dma_bufs(info);
 		free_tmp_rx_buf(info);
 		if ( info->port_num == 0 ) {
-			spin_lock_irqsave(&info->lock,flags);
-			reset_adapter(info);
-			write_reg(info, LPR, 1);		/* set low power mode */
-			spin_unlock_irqrestore(&info->lock,flags);
+			if (info->sca_base)
+				write_reg(info, LPR, 1); /* set low power mode */
 			release_resources(info);
 		}
 		tmp = info;
@@ -4298,6 +4298,9 @@
 				}
 			}
 
+			write_reg16(info, TRC0,
+				(unsigned short)(((tx_negate_fifo_level-1)<<8) + tx_active_fifo_level));
+
 			write_reg(info, TXDMA + DSR, 0); 		/* disable DMA channel */
 			write_reg(info, TXDMA + DCMD, SWABORT);	/* reset/init DMA channel */
 	
@@ -4309,11 +4312,10 @@
 			write_reg16(info, TXDMA + EDA,
 				info->tx_buf_list_ex[info->last_tx_buf].phys_entry);
 	
-			/* clear IDLE and UDRN status bit */
-			info->ie1_value &= ~(IDLE + UDRN);
-			if (info->params.mode != MGSL_MODE_ASYNC)
-				info->ie1_value |= UDRN;     		/* HDLC, IRQ on underrun */
-			write_reg(info, IE1, info->ie1_value);	/* enable MSCI interrupts */
+			/* enable underrun IRQ */
+			info->ie1_value &= ~IDLE;
+			info->ie1_value |= UDRN;
+			write_reg(info, IE1, info->ie1_value);
 			write_reg(info, SR1, (unsigned char)(IDLE + UDRN));
 	
 			write_reg(info, TXDMA + DIR, 0x40);		/* enable Tx DMA interrupts (EOM) */



