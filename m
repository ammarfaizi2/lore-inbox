Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265611AbSKACLI>; Thu, 31 Oct 2002 21:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSKACLH>; Thu, 31 Oct 2002 21:11:07 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:21996 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S265611AbSKACLC>;
	Thu, 31 Oct 2002 21:11:02 -0500
Date: Thu, 31 Oct 2002 02:15:58 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@redhat.com, alan@redhat.com, Philip.Blundell@pobox.com
Subject: [PATCH] Make 3c505.c use spinlocks instead of cli/sti
Message-Id: <20021031021558.38763ed7.fscked@netvisao.pt>
Organization: Tool Enterprises
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 02:17:23.0364 (UTC) FILETIME=[D0660640:01C2814C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch does some cleanup on the 3c505.c driver by making use of
spinlocks instead of the deprecated cli()/sti() scheme. Note that even
though it compiles fine, I don't have the specific hardware to test
this.

Patch is against 2.5.45.

	-- Paulo Andre'

PS - This is my first patch ever. I'm scared. I'm shaking. Take that
into account, please.



--- drivers/net/3c505.c.orig	2002-10-31 00:33:46.000000000 +0000
+++ drivers/net/3c505.c	2002-10-31 00:55:35.000000000 +0000
@@ -274,9 +274,12 @@
 
 static inline void set_hsf(struct net_device *dev, int hsf)
 {
-	cli();
+	elp_device *adapter = dev->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->lock, flags);
 	outb_control((HCR_VAL(dev) & ~HSF_PCB_MASK) | hsf, dev);
-	sti();
+	spin_unlock_irqrestore(&adapter->lock, flags);
 }
 
 static int start_receive(struct net_device *, pcb_struct *);
@@ -325,8 +328,7 @@
 	if (adapter->dmaing && time_after(jiffies, adapter->current_dma.start_time + 10)) {
 		unsigned long flags, f;
 		printk("%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&adapter->lock, flags);
 		adapter->dmaing = 0;
 		adapter->busy = 0;
 		
@@ -337,7 +339,7 @@
 		if (adapter->rx_active)
 			adapter->rx_active--;
 		outb_control(adapter->hcr_val & ~(DMAE | TCEN | DIR), dev);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&adapter->lock, flags);
 	}
 }
 
@@ -405,6 +407,7 @@
 	int i;
 	int timeout;
 	elp_device *adapter = dev->priv;
+	unsigned long flags;
 
 	check_3c505_dma(dev);
 
@@ -428,7 +431,7 @@
 	if (send_pcb_slow(dev->base_addr, pcb->command))
 		goto abort;
 
-	cli();
+	spin_lock_irqsave(&adapter->lock, flags);
 
 	if (send_pcb_fast(dev->base_addr, pcb->length))
 		goto sti_abort;
@@ -442,7 +445,7 @@
 	outb_command(2 + pcb->length, dev->base_addr);
 
 	/* now wait for the acknowledgement */
-	sti();
+	spin_unlock_irqrestore(&adapter->lock, flags);
 
 	for (timeout = jiffies + 5*HZ/100; time_before(jiffies, timeout);) {
 		switch (GET_ASF(dev->base_addr)) {
@@ -463,7 +466,7 @@
 		printk("%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
 
       sti_abort:
-	sti();
+	spin_unlock_irqrestore(&adapter->lock, flags);
       abort:
 	adapter->send_pcb_semaphore = 0;
 	return FALSE;
@@ -489,6 +492,7 @@
 	int total_length;
 	int stat;
 	int timeout;
+	unsigned long flags;
 
 	elp_device *adapter = dev->priv;
 
@@ -519,7 +523,7 @@
 		return FALSE;
 	}
 	/* read the data */
-	cli();
+	spin_lock_irqsave(&adapter->lock, flags);
 	i = 0;
 	do {
 		j = 0;
@@ -528,7 +532,7 @@
 		if (i > MAX_PCB_DATA)
 			INVALID_PCB_MSG(i);
 	} while ((stat & ASF_PCB_MASK) != ASF_PCB_END && j < 20000);
-	sti();
+	spin_unlock_irqrestore(&adapter->lock, flags);
 	if (j >= 20000) {
 		TIMEOUT_MSG(__LINE__);
 		return FALSE;
