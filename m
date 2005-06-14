Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFNAWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFNAWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVFNATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:19:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56260 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261650AbVFNAOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:14:37 -0400
Date: Mon, 13 Jun 2005 17:14:31 -0700
From: mporter@kernel.crashing.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] -mm: add error checking to mpc85xx rapidio support
Message-ID: <20050613171431.A7798@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add more error checking to the MPC85xx RIO support. Clean up some
printks.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/ppc/syslib/ppc85xx_rio.c
--- a/arch/ppc/syslib/ppc85xx_rio.c
+++ b/arch/ppc/syslib/ppc85xx_rio.c
@@ -41,6 +41,7 @@
 #define RIO_MSG_ISR_DIQI	0x00000001
 
 #define RIO_MSG_DESC_SIZE	32
+#define RIO_MSG_BUFFER_SIZE	4096
 #define RIO_MIN_TX_RING_SIZE	2
 #define RIO_MAX_TX_RING_SIZE	2048
 #define RIO_MIN_RX_RING_SIZE	2
@@ -301,9 +302,9 @@ rio_hw_add_outb_message(struct rio_mport
 	    (struct rio_tx_desc *)msg_tx_ring.virt + msg_tx_ring.tx_slot;
 	int ret = 0;
 
-	pr_debug(KERN_INFO
-		 "RIO: rio_hw_add_outb_message(): destid %4.4x mbox %d buffer %8.8x len %8.8x\n",
-		 rdev->destid, mbox, (int)buffer, len);
+	pr_debug
+	    ("RIO: rio_hw_add_outb_message(): destid %4.4x mbox %d buffer %8.8x len %8.8x\n",
+	     rdev->destid, mbox, (int)buffer, len);
 
 	if ((len < 8) || (len > RIO_MAX_MSG_SIZE)) {
 		ret = -EINVAL;
@@ -361,13 +362,13 @@ mpc85xx_rio_tx_handler(int irq, void *de
 	osr = in_be32((void *)&msg_regs->osr);
 
 	if (osr & RIO_MSG_OSR_TE) {
-		printk(KERN_INFO "RIO: outbound message transmission error\n");
+		pr_info("RIO: outbound message transmission error\n");
 		out_be32((void *)&msg_regs->osr, RIO_MSG_OSR_TE);
 		goto out;
 	}
 
 	if (osr & RIO_MSG_OSR_QOI) {
-		printk(KERN_INFO "RIO: outbound message queue overflow\n");
+		pr_info("RIO: outbound message queue overflow\n");
 		out_be32((void *)&msg_regs->osr, RIO_MSG_OSR_QOI);
 		goto out;
 	}
@@ -392,12 +393,12 @@ mpc85xx_rio_tx_handler(int irq, void *de
  * @entries: Number of entries in the outbound mailbox ring
  *
  * Initializes buffer ring, request the outbound message interrupt,
- * and enables the outbound message unit. Returns %0 on success or
- * %-EINVAL on failure.
+ * and enables the outbound message unit. Returns %0 on success and
+ * %-EINVAL or %-ENOMEM on failure.
  */
 int rio_open_outb_mbox(struct rio_mport *mport, int mbox, int entries)
 {
-	int i, rc = 0;
+	int i, j, rc = 0;
 
 	if ((entries < RIO_MIN_TX_RING_SIZE) ||
 	    (entries > RIO_MAX_TX_RING_SIZE) || (!is_power_of_2(entries))) {
@@ -409,17 +410,33 @@ int rio_open_outb_mbox(struct rio_mport 
 	msg_tx_ring.size = entries;
 
 	for (i = 0; i < msg_tx_ring.size; i++) {
-		msg_tx_ring.virt_buffer[i] =
-		    (void *)__get_free_page(GFP_KERNEL);
-		msg_tx_ring.phys_buffer[i] =
-		    (dma_addr_t) __pa(msg_tx_ring.virt_buffer[i]);
+		if (!
+		    (msg_tx_ring.virt_buffer[i] =
+		     dma_alloc_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+					&msg_tx_ring.phys_buffer[i],
+					GFP_KERNEL))) {
+			rc = -ENOMEM;
+			for (j = 0; j < msg_tx_ring.size; j++)
+				if (msg_tx_ring.virt_buffer[j])
+					dma_free_coherent(NULL,
+							  RIO_MSG_BUFFER_SIZE,
+							  msg_tx_ring.
+							  virt_buffer[j],
+							  msg_tx_ring.
+							  phys_buffer[j]);
+			goto out;
+		}
 	}
 
 	/* Initialize outbound message descriptor ring */
-	msg_tx_ring.virt = dma_alloc_coherent(NULL,
-					      msg_tx_ring.size *
-					      RIO_MSG_DESC_SIZE,
-					      &msg_tx_ring.phys, GFP_KERNEL);
+	if (!(msg_tx_ring.virt = dma_alloc_coherent(NULL,
+						    msg_tx_ring.size *
+						    RIO_MSG_DESC_SIZE,
+						    &msg_tx_ring.phys,
+						    GFP_KERNEL))) {
+		rc = -ENOMEM;
+		goto out_dma;
+	}
 	memset(msg_tx_ring.virt, 0, msg_tx_ring.size * RIO_MSG_DESC_SIZE);
 	msg_tx_ring.tx_slot = 0;
 
@@ -434,8 +451,10 @@ int rio_open_outb_mbox(struct rio_mport 
 	out_be32((void *)&msg_regs->osr, 0x000000b3);
 
 	/* Hook up outbound message handler */
-	request_irq(MPC85xx_IRQ_RIO_TX, mpc85xx_rio_tx_handler, 0, "msg_tx",
-		    (void *)mport);
+	if ((rc =
+	     request_irq(MPC85xx_IRQ_RIO_TX, mpc85xx_rio_tx_handler, 0,
+			 "msg_tx", (void *)mport)) < 0)
+		goto out_irq;
 
 	/*
 	 * Configure outbound message unit
@@ -456,6 +475,18 @@ int rio_open_outb_mbox(struct rio_mport 
 
       out:
 	return rc;
+
+      out_irq:
+	dma_free_coherent(NULL, msg_tx_ring.size * RIO_MSG_DESC_SIZE,
+			  msg_tx_ring.virt, msg_tx_ring.phys);
+
+      out_dma:
+	for (i = 0; i < msg_tx_ring.size; i++)
+		dma_free_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+				  msg_tx_ring.virt_buffer[i],
+				  msg_tx_ring.phys_buffer[i]);
+
+	return rc;
 }
 
 /**
@@ -497,7 +528,7 @@ mpc85xx_rio_rx_handler(int irq, void *de
 	isr = in_be32((void *)&msg_regs->isr);
 
 	if (isr & RIO_MSG_ISR_TE) {
-		printk(KERN_INFO "RIO: inbound message reception error\n");
+		pr_info("RIO: inbound message reception error\n");
 		out_be32((void *)&msg_regs->isr, RIO_MSG_ISR_TE);
 		goto out;
 	}
@@ -528,7 +559,7 @@ mpc85xx_rio_rx_handler(int irq, void *de
  *
  * Initializes buffer ring, request the inbound message interrupt,
  * and enables the inbound message unit. Returns %0 on success
- * or %-EINVAL on failure.
+ * and %-EINVAL or %-ENOMEM on failure.
  */
 int rio_open_inb_mbox(struct rio_mport *mport, int mbox, int entries)
 {
@@ -547,10 +578,14 @@ int rio_open_inb_mbox(struct rio_mport *
 		msg_rx_ring.virt_buffer[i] = NULL;
 
 	/* Initialize inbound message ring */
-	msg_rx_ring.virt = dma_alloc_coherent(NULL,
-					      msg_rx_ring.size *
-					      RIO_MAX_MSG_SIZE,
-					      &msg_rx_ring.phys, GFP_KERNEL);
+	if (!(msg_rx_ring.virt = dma_alloc_coherent(NULL,
+						    msg_rx_ring.size *
+						    RIO_MAX_MSG_SIZE,
+						    &msg_rx_ring.phys,
+						    GFP_KERNEL))) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	/* Point dequeue/enqueue pointers at first entry in ring */
 	out_be32((void *)&msg_regs->ifqdpar, (u32) msg_rx_ring.phys);
@@ -560,8 +595,14 @@ int rio_open_inb_mbox(struct rio_mport *
 	out_be32((void *)&msg_regs->isr, 0x00000091);
 
 	/* Hook up inbound message handler */
-	request_irq(MPC85xx_IRQ_RIO_RX, mpc85xx_rio_rx_handler, 0, "msg_rx",
-		    (void *)mport);
+	if ((rc =
+	     request_irq(MPC85xx_IRQ_RIO_RX, mpc85xx_rio_rx_handler, 0,
+			 "msg_rx", (void *)mport)) < 0) {
+		dma_free_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+				  msg_tx_ring.virt_buffer[i],
+				  msg_tx_ring.phys_buffer[i]);
+		goto out;
+	}
 
 	/*
 	 * Configure inbound message unit:
@@ -665,8 +706,8 @@ void *rio_hw_get_inb_message(struct rio_
 	buf = msg_rx_ring.virt_buffer[buf_idx];
 
 	if (!buf) {
-		pr_debug(KERN_ERR
-			 "RIO: inbound message copy failed, no buffers\n");
+		printk(KERN_ERR
+		       "RIO: inbound message copy failed, no buffers\n");
 		goto out1;
 	}
 
@@ -704,13 +745,13 @@ mpc85xx_rio_dbell_handler(int irq, void 
 	dsr = in_be32((void *)&msg_regs->dsr);
 
 	if (dsr & DOORBELL_DSR_TE) {
-		printk(KERN_INFO "RIO: doorbell reception error\n");
+		pr_info("RIO: doorbell reception error\n");
 		out_be32((void *)&msg_regs->dsr, DOORBELL_DSR_TE);
 		goto out;
 	}
 
 	if (dsr & DOORBELL_DSR_QFI) {
-		printk(KERN_INFO "RIO: doorbell queue full\n");
+		pr_info("RIO: doorbell queue full\n");
 		out_be32((void *)&msg_regs->dsr, DOORBELL_DSR_QFI);
 		goto out;
 	}
@@ -724,9 +765,9 @@ mpc85xx_rio_dbell_handler(int irq, void 
 		struct rio_dbell *dbell;
 		int found = 0;
 
-		pr_debug(KERN_INFO
-			 "RIO: processing doorbell, sid %2.2x tid %2.2x info %4.4x\n",
-			 DBELL_SID(dmsg), DBELL_TID(dmsg), DBELL_INF(dmsg));
+		pr_debug
+		    ("RIO: processing doorbell, sid %2.2x tid %2.2x info %4.4x\n",
+		     DBELL_SID(dmsg), DBELL_TID(dmsg), DBELL_INF(dmsg));
 
 		list_for_each_entry(dbell, &port->dbells, node) {
 			if ((dbell->res->start <= DBELL_INF(dmsg)) &&
@@ -739,10 +780,9 @@ mpc85xx_rio_dbell_handler(int irq, void 
 			dbell->dinb(port, DBELL_SID(dmsg), DBELL_TID(dmsg),
 				    DBELL_INF(dmsg));
 		} else {
-			pr_debug(KERN_INFO
-				 "RIO: spurious doorbell, sid %2.2x tid %2.2x info %4.4x\n",
-				 DBELL_SID(dmsg), DBELL_TID(dmsg),
-				 DBELL_INF(dmsg));
+			pr_debug
+			    ("RIO: spurious doorbell, sid %2.2x tid %2.2x info %4.4x\n",
+			     DBELL_SID(dmsg), DBELL_TID(dmsg), DBELL_INF(dmsg));
 		}
 		dmr = in_be32((void *)&msg_regs->dmr);
 		out_be32((void *)&msg_regs->dmr, dmr | DOORBELL_DMR_DI);
@@ -758,19 +798,33 @@ mpc85xx_rio_dbell_handler(int irq, void 
  * @mport: Master port implementing the inbound doorbell unit
  *
  * Initializes doorbell unit hardware and inbound DMA buffer
- * ring. Called from mpc85xx_rio_setup().
+ * ring. Called from mpc85xx_rio_setup(). Returns %0 on success
+ * or %-ENOMEM on failure.
  */
-static void mpc85xx_rio_doorbell_init(struct rio_mport *mport)
+static int mpc85xx_rio_doorbell_init(struct rio_mport *mport)
 {
+	int rc = 0;
+
 	/* Map outbound doorbell window immediately after maintenance window */
-	dbell_win =
-	    (u32) ioremap(mport->iores.start + RIO_MAINT_WIN_SIZE,
-			  RIO_DBELL_WIN_SIZE);
+	if (!(dbell_win =
+	      (u32) ioremap(mport->iores.start + RIO_MAINT_WIN_SIZE,
+			    RIO_DBELL_WIN_SIZE))) {
+		printk(KERN_ERR
+		       "RIO: unable to map outbound doorbell window\n");
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	/* Initialize inbound doorbells */
-	dbell_ring.virt = dma_alloc_coherent(NULL,
-					     512 * DOORBELL_MESSAGE_SIZE,
-					     &dbell_ring.phys, GFP_KERNEL);
+	if (!(dbell_ring.virt = dma_alloc_coherent(NULL,
+						   512 * DOORBELL_MESSAGE_SIZE,
+						   &dbell_ring.phys,
+						   GFP_KERNEL))) {
+		printk(KERN_ERR "RIO: unable allocate inbound doorbell ring\n");
+		rc = -ENOMEM;
+		iounmap((void *)dbell_win);
+		goto out;
+	}
 
 	/* Point dequeue/enqueue pointers at first entry in ring */
 	out_be32((void *)&msg_regs->dqdpar, (u32) dbell_ring.phys);
@@ -780,11 +834,22 @@ static void mpc85xx_rio_doorbell_init(st
 	out_be32((void *)&msg_regs->dsr, 0x00000091);
 
 	/* Hook up doorbell handler */
-	request_irq(MPC85xx_IRQ_RIO_BELL, mpc85xx_rio_dbell_handler, 0,
-		    "dbell_rx", (void *)mport);
+	if ((rc =
+	     request_irq(MPC85xx_IRQ_RIO_BELL, mpc85xx_rio_dbell_handler, 0,
+			 "dbell_rx", (void *)mport) < 0)) {
+		iounmap((void *)dbell_win);
+		dma_free_coherent(NULL, 512 * DOORBELL_MESSAGE_SIZE,
+				  dbell_ring.virt, dbell_ring.phys);
+		printk(KERN_ERR
+		       "MPC85xx RIO: unable to request inbound doorbell irq");
+		goto out;
+	}
 
 	/* Configure doorbells for snooping, 512 entries, and enable */
 	out_be32((void *)&msg_regs->dmr, 0x00108161);
+
+      out:
+	return rc;
 }
 
 static char *cmdline = NULL;
