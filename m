Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVEYHNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVEYHNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVEYHMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:12:10 -0400
Received: from smtp833.mail.sc5.yahoo.com ([66.163.171.20]:6803 "HELO
	smtp833.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262324AbVEYHHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 03:07:03 -0400
Message-Id: <20050525064006.103112000.dtor_core@ameritech.net>
References: <20050525063738.864916000.dtor_core@ameritech.net>
Date: Wed, 25 May 2005 01:37:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 5/9] smsc-ircc2: dont pass iobase around
Content-Disposition: inline; filename=ircc2-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRDA: smsc-ircc2 - cleanup - do not pass around iobase, it can be
      retrieved from smsc_ircc_cb structure.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 smsc-ircc2.c |   61 +++++++++++++++++++++++++----------------------------------
 1 files changed, 26 insertions(+), 35 deletions(-)

Index: dtor/drivers/net/irda/smsc-ircc2.c
===================================================================
--- dtor.orig/drivers/net/irda/smsc-ircc2.c
+++ dtor/drivers/net/irda/smsc-ircc2.c
@@ -163,13 +163,13 @@ static void smsc_ircc_setup_io(struct sm
 static void smsc_ircc_setup_qos(struct smsc_ircc_cb *self);
 static void smsc_ircc_init_chip(struct smsc_ircc_cb *self);
 static int __exit smsc_ircc_close(struct smsc_ircc_cb *self);
-static int  smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase);
-static void smsc_ircc_dma_receive_complete(struct smsc_ircc_cb *self, int iobase);
+static int  smsc_ircc_dma_receive(struct smsc_ircc_cb *self);
+static void smsc_ircc_dma_receive_complete(struct smsc_ircc_cb *self);
 static void smsc_ircc_sir_receive(struct smsc_ircc_cb *self);
 static int  smsc_ircc_hard_xmit_sir(struct sk_buff *skb, struct net_device *dev);
 static int  smsc_ircc_hard_xmit_fir(struct sk_buff *skb, struct net_device *dev);
-static void smsc_ircc_dma_xmit(struct smsc_ircc_cb *self, int iobase, int bofs);
-static void smsc_ircc_dma_xmit_complete(struct smsc_ircc_cb *self, int iobase);
+static void smsc_ircc_dma_xmit(struct smsc_ircc_cb *self, int bofs);
+static void smsc_ircc_dma_xmit_complete(struct smsc_ircc_cb *self);
 static void smsc_ircc_change_speed(void *priv, u32 speed);
 static void smsc_ircc_set_sir_speed(void *priv, u32 speed);
 static irqreturn_t smsc_ircc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -760,7 +760,6 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 {
 	struct smsc_ircc_cb *self;
 	unsigned long flags;
-	int iobase;
 	s32 speed;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
@@ -770,8 +769,6 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
-	iobase = self->io.sir_base;
-
 	netif_stop_queue(dev);
 
 	/* Make sure test of self->io.speed & speed change are atomic */
@@ -810,7 +807,7 @@ int smsc_ircc_hard_xmit_sir(struct sk_bu
 	self->stats.tx_bytes += self->tx_buff.len;
 
 	/* Turn on transmit finished interrupt. Will fire immediately!  */
-	outb(UART_IER_THRI, iobase + UART_IER);
+	outb(UART_IER_THRI, self->io.sir_base + UART_IER);
 
 	spin_unlock_irqrestore(&self->lock, flags);
 
@@ -953,14 +950,12 @@ static void smsc_ircc_change_speed(void 
 {
 	struct smsc_ircc_cb *self = (struct smsc_ircc_cb *) priv;
 	struct net_device *dev;
-	int iobase;
 	int last_speed_was_sir;
 
 	IRDA_DEBUG(0, "%s() changing speed to: %d\n", __FUNCTION__, speed);
 
 	IRDA_ASSERT(self != NULL, return;);
 	dev = self->netdev;
-	iobase = self->io.fir_base;
 
 	last_speed_was_sir = self->io.speed <= SMSC_IRCC2_MAX_SIR_SPEED;
 
@@ -1003,10 +998,10 @@ static void smsc_ircc_change_speed(void 
 		self->tx_buff.len = 10;
 		self->tx_buff.data = self->tx_buff.head;
 
-		smsc_ircc_dma_xmit(self, iobase, 4000);
+		smsc_ircc_dma_xmit(self, 4000);
 		#endif
 		/* Be ready for incoming frames */
-		smsc_ircc_dma_receive(self, iobase);
+		smsc_ircc_dma_receive(self);
 	}
 
 	netif_wake_queue(dev);
@@ -1076,15 +1071,12 @@ static int smsc_ircc_hard_xmit_fir(struc
 	struct smsc_ircc_cb *self;
 	unsigned long flags;
 	s32 speed;
-	int iobase;
 	int mtt;
 
 	IRDA_ASSERT(dev != NULL, return 0;);
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
-	iobase = self->io.fir_base;
-
 	netif_stop_queue(dev);
 
 	/* Make sure test of self->io.speed & speed change are atomic */
@@ -1124,10 +1116,10 @@ static int smsc_ircc_hard_xmit_fir(struc
 		if (bofs > 4095)
 			bofs = 4095;
 
-		smsc_ircc_dma_xmit(self, iobase, bofs);
+		smsc_ircc_dma_xmit(self, bofs);
 	} else {
 		/* Transmit frame */
-		smsc_ircc_dma_xmit(self, iobase, 0);
+		smsc_ircc_dma_xmit(self, 0);
 	}
 
 	spin_unlock_irqrestore(&self->lock, flags);
@@ -1137,13 +1129,14 @@ static int smsc_ircc_hard_xmit_fir(struc
 }
 
 /*
- * Function smsc_ircc_dma_xmit (self, iobase)
+ * Function smsc_ircc_dma_xmit (self, bofs)
  *
  *    Transmit data using DMA
  *
  */
-static void smsc_ircc_dma_xmit(struct smsc_ircc_cb *self, int iobase, int bofs)
+static void smsc_ircc_dma_xmit(struct smsc_ircc_cb *self, int bofs)
 {
+	int iobase = self->io.fir_base;
 	u8 ctrl;
 
 	IRDA_DEBUG(3, "%s\n", __FUNCTION__);
@@ -1196,17 +1189,19 @@ static void smsc_ircc_dma_xmit(struct sm
  *    by the interrupt handler
  *
  */
-static void smsc_ircc_dma_xmit_complete(struct smsc_ircc_cb *self, int iobase)
+static void smsc_ircc_dma_xmit_complete(struct smsc_ircc_cb *self)
 {
+	int iobase = self->io.fir_base;
+
 	IRDA_DEBUG(3, "%s\n", __FUNCTION__);
 #if 0
 	/* Disable Tx */
 	register_bank(iobase, 0);
 	outb(0x00, iobase + IRCC_LCR_B);
 #endif
-	register_bank(self->io.fir_base, 1);
-	outb(inb(self->io.fir_base + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
-	     self->io.fir_base + IRCC_SCE_CFGB);
+	register_bank(iobase, 1);
+	outb(inb(iobase + IRCC_SCE_CFGB) & ~IRCC_CFGB_DMA_ENABLE,
+	     iobase + IRCC_SCE_CFGB);
 
 	/* Check for underrun! */
 	register_bank(iobase, 0);
@@ -1239,8 +1234,9 @@ static void smsc_ircc_dma_xmit_complete(
  *    if it starts to receive a frame.
  *
  */
-static int smsc_ircc_dma_receive(struct smsc_ircc_cb *self, int iobase)
+static int smsc_ircc_dma_receive(struct smsc_ircc_cb *self)
 {
+	int iobase = self->io.fir_base;
 #if 0
 	/* Turn off chip DMA */
 	register_bank(iobase, 1);
@@ -1288,15 +1284,16 @@ static int smsc_ircc_dma_receive(struct 
 }
 
 /*
- * Function smsc_ircc_dma_receive_complete(self, iobase)
+ * Function smsc_ircc_dma_receive_complete(self)
  *
  *    Finished with receiving frames
  *
  */
-static void smsc_ircc_dma_receive_complete(struct smsc_ircc_cb *self, int iobase)
+static void smsc_ircc_dma_receive_complete(struct smsc_ircc_cb *self)
 {
 	struct sk_buff *skb;
 	int len, msgcnt, lsr;
+	int iobase = self->io.fir_base;
 
 	register_bank(iobase, 0);
 
@@ -1437,11 +1434,11 @@ static irqreturn_t smsc_ircc_interrupt(i
 
 	if (iir & IRCC_IIR_EOM) {
 		if (self->io.direction == IO_RECV)
-			smsc_ircc_dma_receive_complete(self, iobase);
+			smsc_ircc_dma_receive_complete(self);
 		else
-			smsc_ircc_dma_xmit_complete(self, iobase);
+			smsc_ircc_dma_xmit_complete(self);
 
-		smsc_ircc_dma_receive(self, iobase);
+		smsc_ircc_dma_receive(self);
 	}
 
 	if (iir & IRCC_IIR_ACTIVE_FRAME) {
@@ -1551,7 +1548,6 @@ static int ircc_is_receiving(struct smsc
 static int smsc_ircc_net_open(struct net_device *dev)
 {
 	struct smsc_ircc_cb *self;
-	int iobase;
 	char hwname[16];
 	unsigned long flags;
 
@@ -1561,8 +1557,6 @@ static int smsc_ircc_net_open(struct net
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
-	iobase = self->io.fir_base;
-
 	if (request_irq(self->io.irq, smsc_ircc_interrupt, 0, dev->name,
 			(void *) dev)) {
 		IRDA_DEBUG(0, "%s(), unable to allocate irq=%d\n",
@@ -1612,7 +1606,6 @@ static int smsc_ircc_net_open(struct net
 static int smsc_ircc_net_close(struct net_device *dev)
 {
 	struct smsc_ircc_cb *self;
-	int iobase;
 
 	IRDA_DEBUG(1, "%s\n", __FUNCTION__);
 
@@ -1620,8 +1613,6 @@ static int smsc_ircc_net_close(struct ne
 	self = (struct smsc_ircc_cb *) dev->priv;
 	IRDA_ASSERT(self != NULL, return 0;);
 
-	iobase = self->io.fir_base;
-
 	/* Stop device */
 	netif_stop_queue(dev);
 

