Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUFNAkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUFNAkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFNAkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:40:06 -0400
Received: from holomorphy.com ([207.189.100.168]:28573 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261439AbUFNAgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:36:08 -0400
Date: Sun, 13 Jun 2004 17:36:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040614003605.GR1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003459.GQ1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Removed uses of isa_virt_to_bus
This resolves Debian BTS #218878.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=218878

	From: Paavo Hartikainen <pahartik@sci.fi>
	To: Debian Bug Tracking System <submit@bugs.debian.org>
	Subject: IrDA modules fail to load
	Message-Id: <E1AGYn5-0000LT-00@mufasa.vip.fi>

When trying to "modprobe irda irtty", it fails with following message:
  FATAL: Error inserting irda (/lib/modules/2.6.0-test9/kernel/net/irda/irda.ko): Unknown symbol in module, or unknown parameter (see dmesg)
And in "dmesg" I see these:
  irda: Unknown symbol isa_virt_to_bus
  irda: Unknown symbol isa_virt_to_bus


Index: linux-2.5/drivers/net/irda/ali-ircc.c
===================================================================
--- linux-2.5.orig/drivers/net/irda/ali-ircc.c	2004-06-13 11:57:17.000000000 -0700
+++ linux-2.5/drivers/net/irda/ali-ircc.c	2004-06-13 12:08:55.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/serial_reg.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -304,16 +305,18 @@
 	self->tx_buff.truesize = 14384;
 
 	/* Allocate memory if needed */
-	self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
-					      GFP_KERNEL |GFP_DMA); 
+	self->rx_buff.head =
+		dma_alloc_coherent(NULL, self->rx_buff.truesize,
+				   &self->rx_buff_dma, GFP_KERNEL); 
 	if (self->rx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out2;
 	}
 	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
 	
-	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
-					      GFP_KERNEL|GFP_DMA); 
+	self->tx_buff.head =
+		dma_alloc_coherent(NULL, self->tx_buff.truesize,
+				   &self->tx_buff_dma, GFP_KERNEL); 
 	if (self->tx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out3;
@@ -362,9 +365,11 @@
 	return 0;
 
  err_out4:
-	kfree(self->tx_buff.head);
+	dma_free_coherent(NULL, self->tx_buff.truesize,
+			  self->tx_buff.head, self->tx_buff_dma);
  err_out3:
-	kfree(self->rx_buff.head);
+	dma_free_coherent(NULL, self->rx_buff.truesize,
+			  self->rx_buff.head, self->rx_buff_dma);
  err_out2:
 	release_region(self->io.fir_base, self->io.fir_ext);
  err_out1:
@@ -398,10 +403,12 @@
 	release_region(self->io.fir_base, self->io.fir_ext);
 
 	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+		dma_free_coherent(NULL, self->tx_buff.truesize,
+				  self->tx_buff.head, self->tx_buff_dma);
 	
 	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+		dma_free_coherent(NULL, self->rx_buff.truesize,
+				  self->rx_buff.head, self->rx_buff_dma);
 
 	dev_self[self->index] = NULL;
 	free_netdev(self->netdev);
@@ -1572,7 +1579,8 @@
 	self->io.direction = IO_XMIT;
 	
 	irda_setup_dma(self->io.dma, 
-		       self->tx_fifo.queue[self->tx_fifo.ptr].start, 
+		       ((u8 *)self->tx_fifo.queue[self->tx_fifo.ptr].start -
+			self->tx_buff.head) + self->tx_buff_dma,
 		       self->tx_fifo.queue[self->tx_fifo.ptr].len, 
 		       DMA_TX_MODE);
 		
@@ -1724,8 +1732,8 @@
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
 		
-	irda_setup_dma(self->io.dma, self->rx_buff.data, 
-		       self->rx_buff.truesize, DMA_RX_MODE);	
+	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize, 
+		       DMA_RX_MODE);	
 	 
 	/* Set Receive Mode,Brick Wall */
 	//switch_bank(iobase, BANK0);
Index: linux-2.5/drivers/net/irda/ali-ircc.h
===================================================================
--- linux-2.5.orig/drivers/net/irda/ali-ircc.h	2004-06-13 11:57:17.000000000 -0700
+++ linux-2.5/drivers/net/irda/ali-ircc.h	2004-06-13 12:08:55.000000000 -0700
@@ -26,6 +26,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/types.h>
 #include <asm/io.h>
 
 /* SIR Register */
@@ -198,6 +199,8 @@
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
+	dma_addr_t tx_buff_dma;
+	dma_addr_t rx_buff_dma;
 
 	__u8 ier;                  /* Interrupt enable register */
 	
Index: linux-2.5/drivers/net/irda/nsc-ircc.c
===================================================================
--- linux-2.5.orig/drivers/net/irda/nsc-ircc.c	2004-06-13 11:57:17.000000000 -0700
+++ linux-2.5/drivers/net/irda/nsc-ircc.c	2004-06-13 12:08:55.000000000 -0700
@@ -52,6 +52,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -307,8 +308,9 @@
 	self->tx_buff.truesize = 14384;
 
 	/* Allocate memory if needed */
-	self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
-					      GFP_KERNEL|GFP_DMA);
+	self->rx_buff.head =
+		dma_alloc_coherent(NULL, self->rx_buff.truesize,
+				   &self->rx_buff_dma, GFP_KERNEL);
 	if (self->rx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto out2;
@@ -316,8 +318,9 @@
 	}
 	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
 	
-	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
-					      GFP_KERNEL|GFP_DMA);
+	self->tx_buff.head =
+		dma_alloc_coherent(NULL, self->tx_buff.truesize,
+				   &self->tx_buff_dma, GFP_KERNEL);
 	if (self->tx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto out3;
@@ -368,9 +371,11 @@
 
 	return 0;
  out4:
-	kfree(self->tx_buff.head);
+	dma_free_coherent(NULL, self->tx_buff.truesize,
+			  self->tx_buff.head, self->tx_buff_dma);
  out3:
-	kfree(self->rx_buff.head);
+	dma_free_coherent(NULL, self->rx_buff.truesize,
+			  self->rx_buff.head, self->rx_buff_dma);
  out2:
 	release_region(self->io.fir_base, self->io.fir_ext);
  out1:
@@ -404,10 +409,12 @@
 	release_region(self->io.fir_base, self->io.fir_ext);
 
 	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+		dma_free_coherent(NULL, self->tx_buff.truesize,
+				  self->tx_buff.head, self->tx_buff_dma);
 	
 	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+		dma_free_coherent(NULL, self->rx_buff.truesize,
+				  self->rx_buff.head, self->rx_buff_dma);
 
 	dev_self[self->index] = NULL;
 	free_netdev(self->netdev);
@@ -1409,7 +1416,8 @@
 	outb(ECR1_DMASWP|ECR1_DMANF|ECR1_EXT_SL, iobase+ECR1);
 	
 	irda_setup_dma(self->io.dma, 
-		       self->tx_fifo.queue[self->tx_fifo.ptr].start, 
+		       ((u8 *)self->tx_fifo.queue[self->tx_fifo.ptr].start -
+			self->tx_buff.head) + self->tx_buff_dma,
 		       self->tx_fifo.queue[self->tx_fifo.ptr].len, 
 		       DMA_TX_MODE);
 
@@ -1566,8 +1574,8 @@
 	self->st_fifo.len = self->st_fifo.pending_bytes = 0;
 	self->st_fifo.tail = self->st_fifo.head = 0;
 	
-	irda_setup_dma(self->io.dma, self->rx_buff.data, 
-		       self->rx_buff.truesize, DMA_RX_MODE);
+	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize, 
+		       DMA_RX_MODE);
 
 	/* Enable DMA */
 	switch_bank(iobase, BANK0);
Index: linux-2.5/drivers/net/irda/nsc-ircc.h
===================================================================
--- linux-2.5.orig/drivers/net/irda/nsc-ircc.h	2004-06-13 11:57:17.000000000 -0700
+++ linux-2.5/drivers/net/irda/nsc-ircc.h	2004-06-13 12:08:55.000000000 -0700
@@ -32,6 +32,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/types.h>
 #include <asm/io.h>
 
 /* DMA modes needed */
@@ -255,6 +256,8 @@
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
+	dma_addr_t tx_buff_dma;
+	dma_addr_t rx_buff_dma;
 
 	__u8 ier;                  /* Interrupt enable register */
 
Index: linux-2.5/drivers/net/irda/smsc-ircc2.c
===================================================================
--- linux-2.5.orig/drivers/net/irda/smsc-ircc2.c	2004-06-13 11:57:18.000000000 -0700
+++ linux-2.5/drivers/net/irda/smsc-ircc2.c	2004-06-13 12:08:55.000000000 -0700
@@ -52,6 +52,7 @@
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/serial_reg.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -112,6 +113,8 @@
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
+	dma_addr_t tx_buff_dma;
+	dma_addr_t rx_buff_dma;
 
 	struct qos_info qos;       /* QoS capabilities for this device */
 
@@ -413,16 +416,18 @@
 	self->rx_buff.truesize = SMSC_IRCC2_RX_BUFF_TRUESIZE; 
 	self->tx_buff.truesize = SMSC_IRCC2_TX_BUFF_TRUESIZE;
 
-	self->rx_buff.head = (u8 *) kmalloc(self->rx_buff.truesize,
-					      GFP_KERNEL|GFP_DMA);
+	self->rx_buff.head =
+		dma_alloc_coherent(NULL, self->rx_buff.truesize, 
+				   &self->rx_buff_dma, GFP_KERNEL);
 	if (self->rx_buff.head == NULL) {
 		ERROR("%s, Can't allocate memory for receive buffer!\n",
                       driver_name);
 		goto err_out2;
 	}
 
-	self->tx_buff.head = (u8 *) kmalloc(self->tx_buff.truesize, 
-					      GFP_KERNEL|GFP_DMA);
+	self->tx_buff.head =
+		dma_alloc_coherent(NULL, self->tx_buff.truesize, 
+				   &self->tx_buff_dma, GFP_KERNEL);
 	if (self->tx_buff.head == NULL) {
 		ERROR("%s, Can't allocate memory for transmit buffer!\n",
                       driver_name);
@@ -464,9 +469,11 @@
 
 	return 0;
  err_out4:
-	kfree(self->tx_buff.head);
+	dma_free_coherent(NULL, self->tx_buff.truesize,
+			  self->tx_buff.head, self->tx_buff_dma);
  err_out3:
-	kfree(self->rx_buff.head);
+	dma_free_coherent(NULL, self->rx_buff.truesize,
+			  self->rx_buff.head, self->rx_buff_dma);
  err_out2:
 	free_netdev(self->netdev);
 	dev_self[--dev_count] = NULL;
@@ -1159,7 +1166,7 @@
 	     IRCC_CFGB_DMA_BURST, iobase+IRCC_SCE_CFGB);
 
 	/* Setup DMA controller (must be done after enabling chip DMA) */
-	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
+	irda_setup_dma(self->io.dma, self->tx_buff_dma, self->tx_buff.len,
 		       DMA_TX_MODE);
 
 	/* Enable interrupt */
@@ -1249,8 +1256,8 @@
 	outb(2050 & 0xff, iobase+IRCC_RX_SIZE_LO);
 
 	/* Setup DMA controller */
-	irda_setup_dma(self->io.dma, self->rx_buff.data,
-		       self->rx_buff.truesize, DMA_RX_MODE);
+	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize, 
+		       DMA_RX_MODE);
 
 	/* Enable burst mode chip Rx DMA */
 	register_bank(iobase, 1);
@@ -1717,10 +1724,12 @@
 	release_region(self->io.sir_base, self->io.sir_ext);
 
 	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+		dma_free_coherent(NULL, self->tx_buff.truesize,
+				  self->tx_buff.head, self->tx_buff_dma);
 	
 	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+		dma_free_coherent(NULL, self->rx_buff.truesize,
+				  self->rx_buff.head, self->rx_buff_dma);
 
 	free_netdev(self->netdev);
 
Index: linux-2.5/drivers/net/irda/via-ircc.c
===================================================================
--- linux-2.5.orig/drivers/net/irda/via-ircc.c	2004-06-13 11:57:18.000000000 -0700
+++ linux-2.5/drivers/net/irda/via-ircc.c	2004-06-13 12:08:55.000000000 -0700
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -383,7 +384,8 @@
 
 	/* Allocate memory if needed */
 	self->rx_buff.head =
-	    (__u8 *) kmalloc(self->rx_buff.truesize, GFP_KERNEL | GFP_DMA);
+		dma_alloc_coherent(NULL, self->rx_buff.truesize,
+				   &self->rx_buff_dma, GFP_KERNEL);
 	if (self->rx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out2;
@@ -391,7 +393,8 @@
 	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
 
 	self->tx_buff.head =
-	    (__u8 *) kmalloc(self->tx_buff.truesize, GFP_KERNEL | GFP_DMA);
+		dma_alloc_coherent(NULL, self->tx_buff.truesize,
+				   &self->tx_buff_dma, GFP_KERNEL);
 	if (self->tx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out3;
@@ -432,9 +435,11 @@
 
 	return 0;
  err_out4:
-	kfree(self->tx_buff.head);
+	dma_free_coherent(NULL, self->tx_buff.truesize,
+			  self->tx_buff.head, self->tx_buff_dma);
  err_out3:
-	kfree(self->rx_buff.head);
+	dma_free_coherent(NULL, self->rx_buff.truesize,
+			  self->rx_buff.head, self->rx_buff_dma);
  err_out2:
 	release_region(self->io.fir_base, self->io.fir_ext);
  err_out1:
@@ -468,9 +473,11 @@
 		   __FUNCTION__, self->io.fir_base);
 	release_region(self->io.fir_base, self->io.fir_ext);
 	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+		dma_free_coherent(NULL, self->tx_buff.truesize,
+				  self->tx_buff.head, self->tx_buff_dma);
 	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+		dma_free_coherent(NULL, self->rx_buff.truesize,
+				  self->rx_buff.head, self->rx_buff_dma);
 	dev_self[self->index] = NULL;
 
 	free_netdev(self->netdev);
@@ -816,7 +823,7 @@
 	EnTXDMA(iobase, ON);
 	EnRXDMA(iobase, OFF);
 
-	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len,
+	irda_setup_dma(self->io.dma, self->tx_buff_dma, self->tx_buff.len,
 		       DMA_TX_MODE);
 
 	SetSendByte(iobase, self->tx_buff.len);
@@ -897,7 +904,8 @@
 	EnTXDMA(iobase, ON);
 	EnRXDMA(iobase, OFF);
 	irda_setup_dma(self->io.dma,
-		       self->tx_fifo.queue[self->tx_fifo.ptr].start,
+		       ((u8 *)self->tx_fifo.queue[self->tx_fifo.ptr].start -
+			self->tx_buff.head) + self->tx_buff_dma,
 		       self->tx_fifo.queue[self->tx_fifo.ptr].len, DMA_TX_MODE);
 #ifdef	DBGMSG
 	DBG(printk
@@ -1022,8 +1030,8 @@
 	EnAllInt(iobase, ON);
 	EnTXDMA(iobase, OFF);
 	EnRXDMA(iobase, ON);
-	irda_setup_dma(self->io.dma2, self->rx_buff.data,
-		       self->rx_buff.truesize, DMA_RX_MODE);
+	irda_setup_dma(self->io.dma2, self->rx_buff_dma,
+		  self->rx_buff.truesize, DMA_RX_MODE);
 	TXStart(iobase, OFF);
 	RXStart(iobase, ON);
 
Index: linux-2.5/drivers/net/irda/via-ircc.h
===================================================================
--- linux-2.5.orig/drivers/net/irda/via-ircc.h	2004-06-13 11:57:18.000000000 -0700
+++ linux-2.5/drivers/net/irda/via-ircc.h	2004-06-13 12:08:55.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/time.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/types.h>
 #include <asm/io.h>
 
 #define MAX_TX_WINDOW 7
@@ -102,6 +103,8 @@
 	chipio_t io;		/* IrDA controller information */
 	iobuff_t tx_buff;	/* Transmit buffer */
 	iobuff_t rx_buff;	/* Receive buffer */
+	dma_addr_t tx_buff_dma;
+	dma_addr_t rx_buff_dma;
 
 	__u8 ier;		/* Interrupt enable register */
 
Index: linux-2.5/drivers/net/irda/w83977af_ir.c
===================================================================
--- linux-2.5.orig/drivers/net/irda/w83977af_ir.c	2004-06-13 11:57:18.000000000 -0700
+++ linux-2.5/drivers/net/irda/w83977af_ir.c	2004-06-13 12:08:55.000000000 -0700
@@ -50,6 +50,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -207,8 +208,9 @@
 	self->tx_buff.truesize = 4000;
 	
 	/* Allocate memory if needed */
-	self->rx_buff.head = (__u8 *) kmalloc(self->rx_buff.truesize,
-					      GFP_KERNEL|GFP_DMA);
+	self->rx_buff.head =
+		dma_alloc_coherent(NULL, self->rx_buff.truesize,
+				   &self->rx_buff_dma, GFP_KERNEL);
 	if (self->rx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out1;
@@ -216,8 +218,9 @@
 
 	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
 	
-	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize, 
-					      GFP_KERNEL|GFP_DMA);
+	self->tx_buff.head =
+		dma_alloc_coherent(NULL, self->tx_buff.truesize,
+				   &self->tx_buff_dma, GFP_KERNEL);
 	if (self->tx_buff.head == NULL) {
 		err = -ENOMEM;
 		goto err_out2;
@@ -252,9 +255,11 @@
 	
 	return 0;
 err_out3:
-	kfree(self->tx_buff.head);
+	dma_free_coherent(NULL, self->tx_buff.truesize,
+			  self->tx_buff.head, self->tx_buff_dma);
 err_out2:	
-	kfree(self->rx_buff.head);
+	dma_free_coherent(NULL, self->rx_buff.truesize,
+			  self->rx_buff.head, self->rx_buff_dma);
 err_out1:
 	free_netdev(dev);
 err_out:
@@ -297,10 +302,12 @@
 	release_region(self->io.fir_base, self->io.fir_ext);
 
 	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+		dma_free_coherent(NULL, self->tx_buff.truesize,
+				  self->tx_buff.head, self->tx_buff_dma);
 	
 	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
+		dma_free_coherent(NULL, self->rx_buff.truesize,
+				  self->rx_buff.head, self->rx_buff_dma);
 
 	free_netdev(self->netdev);
 
@@ -606,10 +613,10 @@
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
 	set_dma_mode(self->io.dma, DMA_MODE_READ);
-	set_dma_addr(self->io.dma, isa_virt_to_bus(self->tx_buff.data));
+	set_dma_addr(self->io.dma, self->tx_buff_dma);
 	set_dma_count(self->io.dma, self->tx_buff.len);
 #else
-	irda_setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
+	irda_setup_dma(self->io.dma, self->tx_buff_dma, self->tx_buff.len, 
 		       DMA_MODE_WRITE);	
 #endif
 	self->io.direction = IO_XMIT;
@@ -763,10 +770,10 @@
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
 	set_dma_mode(self->io.dma, DMA_MODE_READ);
-	set_dma_addr(self->io.dma, isa_virt_to_bus(self->rx_buff.data));
+	set_dma_addr(self->io.dma, self->rx_buff_dma);
 	set_dma_count(self->io.dma, self->rx_buff.truesize);
 #else
-	irda_setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
+	irda_setup_dma(self->io.dma, self->rx_buff_dma, self->rx_buff.truesize, 
 		       DMA_MODE_READ);
 #endif
 	/* 
Index: linux-2.5/drivers/net/irda/w83977af_ir.h
===================================================================
--- linux-2.5.orig/drivers/net/irda/w83977af_ir.h	2004-06-13 11:57:18.000000000 -0700
+++ linux-2.5/drivers/net/irda/w83977af_ir.h	2004-06-13 12:08:55.000000000 -0700
@@ -26,6 +26,7 @@
 #define W83977AF_IR_H
 
 #include <asm/io.h>
+#include <linux/types.h>
 
 /* Flags for configuration register CRF0 */
 #define ENBNKSEL	0x01
@@ -179,6 +180,8 @@
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
+	dma_addr_t tx_buff_dma;
+	dma_addr_t rx_buff_dma;
 
 	/* Note : currently locking is *very* incomplete, but this
 	 * will get you started. Check in nsc-ircc.c for a proper
Index: linux-2.5/include/net/irda/irda_device.h
===================================================================
--- linux-2.5.orig/include/net/irda/irda_device.h	2004-06-13 11:57:46.000000000 -0700
+++ linux-2.5/include/net/irda/irda_device.h	2004-06-13 12:08:55.000000000 -0700
@@ -39,11 +39,13 @@
 #ifndef IRDA_DEVICE_H
 #define IRDA_DEVICE_H
 
+#include <linux/config.h>
 #include <linux/tty.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>		/* struct sk_buff */
 #include <linux/irda.h>
+#include <linux/types.h>
 
 #include <net/pkt_sched.h>
 #include <net/irda/irda.h>
@@ -236,7 +238,7 @@
 int irda_device_dongle_cleanup(dongle_t *dongle);
 
 #ifdef CONFIG_ISA
-void irda_setup_dma(int channel, char *buffer, int count, int mode);
+void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode);
 #endif
 
 void irda_task_delete(struct irda_task *task);
Index: linux-2.5/net/irda/irda_device.c
===================================================================
--- linux-2.5.orig/net/irda/irda_device.c	2004-06-13 11:57:48.000000000 -0700
+++ linux-2.5/net/irda/irda_device.c	2004-06-13 12:08:55.000000000 -0700
@@ -536,7 +536,7 @@
  *    Setup the DMA channel. Commonly used by ISA FIR drivers
  *
  */
-void irda_setup_dma(int channel, char *buffer, int count, int mode)
+void irda_setup_dma(int channel, dma_addr_t buffer, int count, int mode)
 {
 	unsigned long flags;
 
@@ -545,7 +545,7 @@
 	disable_dma(channel);
 	clear_dma_ff(channel);
 	set_dma_mode(channel, mode);
-	set_dma_addr(channel, isa_virt_to_bus(buffer));
+	set_dma_addr(channel, buffer);
 	set_dma_count(channel, count);
 	enable_dma(channel);
 
