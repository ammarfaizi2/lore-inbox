Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTEODTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTEODTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:19:17 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:14316 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263786AbTEODSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:21 -0400
Date: Thu, 15 May 2003 04:31:06 +0100
Message-Id: <200305150331.h4F3V6or000601@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 3c505 printk levels.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/3c505.c linux-2.5/drivers/net/3c505.c
--- bk-linus/drivers/net/3c505.c	2003-04-22 00:40:42.000000000 +0100
+++ linux-2.5/drivers/net/3c505.c	2003-04-23 06:02:35.000000000 +0100
@@ -312,7 +312,7 @@ inline static void adapter_reset(struct 
 
 	outb_control(orig_hcr, dev);
 	if (!start_receive(dev, &adapter->tx_pcb))
-		printk("%s: start receive command failed \n", dev->name);
+		printk(KERN_ERR "%s: start receive command failed \n", dev->name);
 }
 
 /* Check to make sure that a DMA transfer hasn't timed out.  This should
@@ -324,7 +324,7 @@ static inline void check_3c505_dma(struc
 	elp_device *adapter = dev->priv;
 	if (adapter->dmaing && time_after(jiffies, adapter->current_dma.start_time + 10)) {
 		unsigned long flags, f;
-		printk("%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
+		printk(KERN_ERR "%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
 		spin_lock_irqsave(&adapter->lock, flags);
 		adapter->dmaing = 0;
 		adapter->busy = 0;
@@ -460,7 +460,7 @@ static int send_pcb(struct net_device *d
 	}
 
 	if (elp_debug >= 1)
-		printk("%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
+		printk(KERN_DEBUG "%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
 
       sti_abort:
 	spin_unlock_irqrestore(&adapter->lock, flags);
@@ -509,7 +509,7 @@ static int receive_pcb(struct net_device
 	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 && time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout)) {
 		TIMEOUT_MSG(__LINE__);
-		printk("%s: status %02x\n", dev->name, stat);
+		printk(KERN_INFO "%s: status %02x\n", dev->name, stat);
 		return FALSE;
 	}
 	pcb->length = inb_command(dev->base_addr);
@@ -540,7 +540,7 @@ static int receive_pcb(struct net_device
 	/* safety check total length vs data length */
 	if (total_length != (pcb->length + 2)) {
 		if (elp_debug >= 2)
-			printk("%s: mangled PCB received\n", dev->name);
+			printk(KERN_WARNING "%s: mangled PCB received\n", dev->name);
 		set_hsf(dev, HSF_PCB_NAK);
 		return FALSE;
 	}
@@ -549,7 +549,7 @@ static int receive_pcb(struct net_device
 		if (test_and_set_bit(0, (void *) &adapter->busy)) {
 			if (backlog_next(adapter->rx_backlog.in) == adapter->rx_backlog.out) {
 				set_hsf(dev, HSF_PCB_NAK);
-				printk("%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
+				printk(KERN_WARNING "%s: PCB rejected, transfer in progress and backlog full\n", dev->name);
 				pcb->command = 0;
 				return TRUE;
 			} else {
@@ -574,7 +574,7 @@ static int start_receive(struct net_devi
 	elp_device *adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: restarting receiver\n", dev->name);
+		printk(KERN_DEBUG "%s: restarting receiver\n", dev->name);
 	tx_pcb->command = CMD_RECEIVE_PACKET;
 	tx_pcb->length = sizeof(struct Rcv_pkt);
 	tx_pcb->data.rcv_pkt.buf_seg
@@ -626,7 +626,7 @@ static void receive_packet(struct net_de
 
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_ERR "%s: rx blocked, DMA in progress, dir %d\n", dev->name, adapter->current_dma.direction);
 
 	skb->dev = dev;
 	adapter->current_dma.direction = 0;
@@ -646,7 +646,7 @@ static void receive_packet(struct net_de
 	release_dma_lock(flags);
 
 	if (elp_debug >= 3) {
-		printk("%s: rx DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: rx DMA transfer started\n", dev->name);
 	}
 
 	if (adapter->rx_active)
@@ -682,10 +682,10 @@ static irqreturn_t elp_interrupt(int irq
 		 */
 		if (inb_status(dev->base_addr) & DONE) {
 			if (!adapter->dmaing) {
-				printk("%s: phantom DMA completed\n", dev->name);
+				printk(KERN_WARNING "%s: phantom DMA completed\n", dev->name);
 			}
 			if (elp_debug >= 3) {
-				printk("%s: %s DMA complete, status %02x\n", dev->name, adapter->current_dma.direction ? "tx" : "rx", inb_status(dev->base_addr));
+				printk(KERN_DEBUG "%s: %s DMA complete, status %02x\n", dev->name, adapter->current_dma.direction ? "tx" : "rx", inb_status(dev->base_addr));
 			}
 
 			outb_control(adapter->hcr_val & ~(DMAE | TCEN | DIR), dev);
@@ -709,7 +709,7 @@ static irqreturn_t elp_interrupt(int irq
 				int t = adapter->rx_backlog.length[adapter->rx_backlog.out];
 				adapter->rx_backlog.out = backlog_next(adapter->rx_backlog.out);
 				if (elp_debug >= 2)
-					printk("%s: receiving backlogged packet (%d)\n", dev->name, t);
+					printk(KERN_DEBUG "%s: receiving backlogged packet (%d)\n", dev->name, t);
 				receive_packet(dev, t);
 			} else {
 				adapter->busy = 0;
@@ -743,18 +743,18 @@ static irqreturn_t elp_interrupt(int irq
 						printk(KERN_ERR "%s: interrupt - packet not received correctly\n", dev->name);
 					} else {
 						if (elp_debug >= 3) {
-							printk("%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
+							printk(KERN_DEBUG "%s: interrupt - packet received of length %i (%i)\n", dev->name, len, dlen);
 						}
 						if (adapter->irx_pcb.command == 0xff) {
 							if (elp_debug >= 2)
-								printk("%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
+								printk(KERN_DEBUG "%s: adding packet to backlog (len = %d)\n", dev->name, dlen);
 							adapter->rx_backlog.length[adapter->rx_backlog.in] = dlen;
 							adapter->rx_backlog.in = backlog_next(adapter->rx_backlog.in);
 						} else {
 							receive_packet(dev, dlen);
 						}
 						if (elp_debug >= 3)
-							printk("%s: packet received\n", dev->name);
+							printk(KERN_DEBUG "%s: packet received\n", dev->name);
 					}
 					break;
 
@@ -764,7 +764,7 @@ static irqreturn_t elp_interrupt(int irq
 				case CMD_CONFIGURE_82586_RESPONSE:
 					adapter->got[CMD_CONFIGURE_82586] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - configure response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - configure response received\n", dev->name);
 					break;
 
 					/*
@@ -773,7 +773,7 @@ static irqreturn_t elp_interrupt(int irq
 				case CMD_CONFIGURE_ADAPTER_RESPONSE:
 					adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Adapter memory configuration %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Adapter memory configuration %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -783,7 +783,7 @@ static irqreturn_t elp_interrupt(int irq
 				case CMD_LOAD_MULTICAST_RESPONSE:
 					adapter->got[CMD_LOAD_MULTICAST_LIST] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Multicast address list loading %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Multicast address list loading %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -793,7 +793,7 @@ static irqreturn_t elp_interrupt(int irq
 				case CMD_SET_ADDRESS_RESPONSE:
 					adapter->got[CMD_SET_STATION_ADDRESS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: Ethernet address setting %s.\n", dev->name,
+						printk(KERN_DEBUG "%s: Ethernet address setting %s.\n", dev->name,
 						       adapter->irx_pcb.data.failed ? "failed" : "succeeded");
 					break;
 
@@ -810,7 +810,7 @@ static irqreturn_t elp_interrupt(int irq
 					adapter->stats.rx_over_errors += adapter->irx_pcb.data.netstat.err_res;
 					adapter->got[CMD_NETWORK_STATISTICS] = 1;
 					if (elp_debug >= 3)
-						printk("%s: interrupt - statistics response received\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - statistics response received\n", dev->name);
 					break;
 
 					/*
@@ -818,7 +818,7 @@ static irqreturn_t elp_interrupt(int irq
 					 */
 				case CMD_TRANSMIT_PACKET_COMPLETE:
 					if (elp_debug >= 3)
-						printk("%s: interrupt - packet sent\n", dev->name);
+						printk(KERN_DEBUG "%s: interrupt - packet sent\n", dev->name);
 					if (!netif_running(dev))
 						break;
 					switch (adapter->irx_pcb.data.xmit_resp.c_stat) {
@@ -842,7 +842,7 @@ static irqreturn_t elp_interrupt(int irq
 					break;
 				}
 			} else {
-				printk("%s: failed to read PCB on interrupt\n", dev->name);
+				printk(KERN_WARNING "%s: failed to read PCB on interrupt\n", dev->name);
 				adapter_reset(dev);
 			}
 		}
@@ -873,7 +873,7 @@ static int elp_open(struct net_device *d
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to open device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to open device\n", dev->name);
 
 	/*
 	 * make sure we actually found the device
@@ -946,7 +946,7 @@ static int elp_open(struct net_device *d
 	adapter->tx_pcb.length = sizeof(struct Memconf);
 	adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send memory configuration command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send memory configuration command\n", dev->name);
 	else {
 		unsigned long timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] == 0 && time_before(jiffies, timeout));
@@ -959,13 +959,13 @@ static int elp_open(struct net_device *d
 	 * configure adapter to receive broadcast messages and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.data.configure = NO_LOOPBACK | RECV_BROAD;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	else {
 		unsigned long timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_CONFIGURE_82586] == 0 && time_before(jiffies, timeout));
@@ -981,7 +981,7 @@ static int elp_open(struct net_device *d
 	 */
 	prime_rx(dev);
 	if (elp_debug >= 3)
-		printk("%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
+		printk(KERN_DEBUG "%s: %d receive PCBs active\n", dev->name, adapter->rx_active);
 
 	/*
 	 * device is now officially open!
@@ -1011,7 +1011,7 @@ static int send_packet(struct net_device
 
 	if (test_and_set_bit(0, (void *) &adapter->busy)) {
 		if (elp_debug >= 2)
-			printk("%s: transmit blocked\n", dev->name);
+			printk(KERN_DEBUG "%s: transmit blocked\n", dev->name);
 		return FALSE;
 	}
 
@@ -1033,7 +1033,7 @@ static int send_packet(struct net_device
 	}
 	/* if this happens, we die */
 	if (test_and_set_bit(0, (void *) &adapter->dmaing))
-		printk("%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
+		printk(KERN_DEBUG "%s: tx: DMA %d in progress\n", dev->name, adapter->current_dma.direction);
 
 	adapter->current_dma.direction = 1;
 	adapter->current_dma.start_time = jiffies;
@@ -1059,7 +1059,7 @@ static int send_packet(struct net_device
 	release_dma_lock(flags);
 	
 	if (elp_debug >= 3)
-		printk("%s: DMA transfer started\n", dev->name);
+		printk(KERN_DEBUG "%s: DMA transfer started\n", dev->name);
 
 	return TRUE;
 }
@@ -1076,7 +1076,7 @@ static void elp_timeout(struct net_devic
 	stat = inb_status(dev->base_addr);
 	printk(KERN_WARNING "%s: transmit timed out, lost %s?\n", dev->name, (stat & ACRF) ? "interrupt" : "command");
 	if (elp_debug >= 1)
-		printk("%s: status %#02x\n", dev->name, stat);
+		printk(KERN_DEBUG "%s: status %#02x\n", dev->name, stat);
 	dev->trans_start = jiffies;
 	adapter->stats.tx_dropped++;
 	netif_wake_queue(dev);
@@ -1098,7 +1098,7 @@ static int elp_start_xmit(struct sk_buff
 	check_3c505_dma(dev);
 
 	if (elp_debug >= 3)
-		printk("%s: request to send packet of length %d\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: request to send packet of length %d\n", dev->name, (int) skb->len);
 
 	netif_stop_queue(dev);
 	
@@ -1107,13 +1107,13 @@ static int elp_start_xmit(struct sk_buff
 	 */
 	if (!send_packet(dev, skb)) {
 		if (elp_debug >= 2) {
-			printk("%s: failed to transmit packet\n", dev->name);
+			printk(KERN_DEBUG "%s: failed to transmit packet\n", dev->name);
 		}
 		spin_unlock_irqrestore(&adapter->lock, flags);
 		return 1;
 	}
 	if (elp_debug >= 3)
-		printk("%s: packet of length %d sent\n", dev->name, (int) skb->len);
+		printk(KERN_DEBUG "%s: packet of length %d sent\n", dev->name, (int) skb->len);
 
 	/*
 	 * start the transmit timeout
@@ -1137,7 +1137,7 @@ static struct net_device_stats *elp_get_
 	elp_device *adapter = (elp_device *) dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request for stats\n", dev->name);
+		printk(KERN_DEBUG "%s: request for stats\n", dev->name);
 
 	/* If the device is closed, just return the latest stats we have,
 	   - we cannot ask from the adapter without interrupts */
@@ -1149,7 +1149,7 @@ static struct net_device_stats *elp_get_
 	adapter->tx_pcb.length = 0;
 	adapter->got[CMD_NETWORK_STATISTICS] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
-		printk("%s: couldn't send get statistics command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send get statistics command\n", dev->name);
 	else {
 		unsigned long timeout = jiffies + TIMEOUT;
 		while (adapter->got[CMD_NETWORK_STATISTICS] == 0 && time_before(jiffies, timeout));
@@ -1257,7 +1257,7 @@ static int elp_close(struct net_device *
 	adapter = dev->priv;
 
 	if (elp_debug >= 3)
-		printk("%s: request to close device\n", dev->name);
+		printk(KERN_DEBUG "%s: request to close device\n", dev->name);
 
 	netif_stop_queue(dev);
 
@@ -1301,7 +1301,7 @@ static void elp_set_mc_list(struct net_d
 	unsigned long flags;
 
 	if (elp_debug >= 3)
-		printk("%s: request to set multicast list\n", dev->name);
+		printk(KERN_DEBUG "%s: request to set multicast list\n", dev->name);
 
 	spin_lock_irqsave(&adapter->lock, flags);
 	
@@ -1316,7 +1316,7 @@ static void elp_set_mc_list(struct net_d
 		}
 		adapter->got[CMD_LOAD_MULTICAST_LIST] = 0;
 		if (!send_pcb(dev, &adapter->tx_pcb))
-			printk("%s: couldn't send set_multicast command\n", dev->name);
+			printk(KERN_ERR "%s: couldn't send set_multicast command\n", dev->name);
 		else {
 			unsigned long timeout = jiffies + TIMEOUT;
 			while (adapter->got[CMD_LOAD_MULTICAST_LIST] == 0 && time_before(jiffies, timeout));
@@ -1335,14 +1335,14 @@ static void elp_set_mc_list(struct net_d
 	 * and wait for response
 	 */
 	if (elp_debug >= 3)
-		printk("%s: sending 82586 configure command\n", dev->name);
+		printk(KERN_DEBUG "%s: sending 82586 configure command\n", dev->name);
 	adapter->tx_pcb.command = CMD_CONFIGURE_82586;
 	adapter->tx_pcb.length = 2;
 	adapter->got[CMD_CONFIGURE_82586] = 0;
 	if (!send_pcb(dev, &adapter->tx_pcb))
 	{
 		spin_unlock_irqrestore(&adapter->lock, flags);
-		printk("%s: couldn't send 82586 configure command\n", dev->name);
+		printk(KERN_ERR "%s: couldn't send 82586 configure command\n", dev->name);
 	}
 	else {
 		unsigned long timeout = jiffies + TIMEOUT;
@@ -1524,9 +1524,9 @@ int __init elplus_probe(struct net_devic
 	 */
 	adapter = (elp_device *) (dev->priv = kmalloc(sizeof(elp_device), GFP_KERNEL));
 	if (adapter == NULL) {
-		printk("%s: out of memory\n", dev->name);
+		printk(KERN_ERR "%s: out of memory\n", dev->name);
 		return -ENODEV;
-        }
+	}
 
 	adapter->send_pcb_semaphore = 0;
 
@@ -1549,7 +1549,7 @@ int __init elplus_probe(struct net_devic
 			/* Nope, it's ignoring the command register.  This means that
 			 * either it's still booting up, or it's died.
 			 */
-			printk("%s: command register wouldn't drain, ", dev->name);
+			printk(KERN_ERR "%s: command register wouldn't drain, ", dev->name);
 			if ((inb_status(dev->base_addr) & 7) == 3) {
 				/* If the adapter status is 3, it *could* still be booting.
 				 * Give it the benefit of the doubt for 10 seconds.
@@ -1558,7 +1558,7 @@ int __init elplus_probe(struct net_devic
 				timeout = jiffies + 10*HZ;
 				while (time_before(jiffies, timeout) && (inb_status(dev->base_addr) & 7));
 				if (inb_status(dev->base_addr) & 7) {
-					printk("%s: 3c505 failed to start\n", dev->name);
+					printk(KERN_ERR "%s: 3c505 failed to start\n", dev->name);
 				} else {
 					okay = 1;  /* It started */
 				}
@@ -1579,18 +1579,18 @@ int __init elplus_probe(struct net_devic
 			adapter->tx_pcb.length = 0;
 			cookie = probe_irq_on();
 			if (!send_pcb(dev, &adapter->tx_pcb)) {
-				printk("%s: could not send first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not send first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if (!receive_pcb(dev, &adapter->rx_pcb)) {
-				printk("%s: could not read first PCB\n", dev->name);
+				printk(KERN_ERR "%s: could not read first PCB\n", dev->name);
 				probe_irq_off(cookie);
 				continue;
 			}
 			if ((adapter->rx_pcb.command != CMD_ADDRESS_RESPONSE) ||
 			    (adapter->rx_pcb.length != 6)) {
-				printk("%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
+				printk(KERN_ERR "%s: first PCB wrong (%d, %d)\n", dev->name, adapter->rx_pcb.command, adapter->rx_pcb.length);
 				probe_irq_off(cookie);
 				continue;
 			}
@@ -1603,7 +1603,7 @@ int __init elplus_probe(struct net_devic
 		outb_control(adapter->hcr_val | FLSH | ATTN, dev);
 		outb_control(adapter->hcr_val & ~(FLSH | ATTN), dev);
 	}
-	printk("%s: failed to initialise 3c505\n", dev->name);
+	printk(KERN_ERR "%s: failed to initialise 3c505\n", dev->name);
 	release_region(dev->base_addr, ELP_IO_EXTENT);
 	return -ENODEV;
 
@@ -1611,21 +1611,21 @@ int __init elplus_probe(struct net_devic
 	if (dev->irq) {		/* Is there a preset IRQ? */
 		int rpt = probe_irq_off(cookie);
 		if (dev->irq != rpt) {
-			printk("%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
+			printk(KERN_WARNING "%s: warning, irq %d configured but %d detected\n", dev->name, dev->irq, rpt);
 		}
 		/* if dev->irq == probe_irq_off(cookie), all is well */
 	} else		       /* No preset IRQ; just use what we can detect */
 		dev->irq = probe_irq_off(cookie);
 	switch (dev->irq) {    /* Legal, sane? */
 	case 0:
-		printk("%s: IRQ probe failed: check 3c505 jumpers.\n",
+		printk(KERN_ERR "%s: IRQ probe failed: check 3c505 jumpers.\n",
 		       dev->name);
 		return -ENODEV;
 	case 1:
 	case 6:
 	case 8:
 	case 13:
-		printk("%s: Impossible IRQ %d reported by probe_irq_off().\n",
+		printk(KERN_ERR "%s: Impossible IRQ %d reported by probe_irq_off().\n",
 		       dev->name, dev->irq);
 		return -ENODEV;
 	}
@@ -1655,7 +1655,7 @@ int __init elplus_probe(struct net_devic
 	/*
 	 * print remainder of startup message
 	 */
-	printk("%s: 3c505 at %#lx, irq %d, dma %d, ",
+	printk(KERN_INFO "%s: 3c505 at %#lx, irq %d, dma %d, ",
 	       dev->name, dev->base_addr, dev->irq, dev->dma);
 	printk("addr %02x:%02x:%02x:%02x:%02x:%02x, ",
 	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
@@ -1690,10 +1690,10 @@ int __init elplus_probe(struct net_devic
 	    !receive_pcb(dev, &adapter->rx_pcb) ||
 	    (adapter->rx_pcb.command != CMD_CONFIGURE_ADAPTER_RESPONSE) ||
 	    (adapter->rx_pcb.length != 2)) {
-		printk("%s: could not configure adapter memory\n", dev->name);
+		printk(KERN_ERR "%s: could not configure adapter memory\n", dev->name);
 	}
 	if (adapter->rx_pcb.data.configure) {
-		printk("%s: adapter configuration failed\n", dev->name);
+		printk(KERN_ERR "%s: adapter configuration failed\n", dev->name);
 	}
 
 	/*
