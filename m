Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUHQPVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUHQPVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUHQPVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:21:42 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:31454 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268297AbUHQPQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:16:37 -0400
Message-ID: <41222112.6070805@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:15:30 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [6/10]
Content-Type: multipart/mixed;
	boundary="------------030203050403000304060605"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030203050403000304060605
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------030203050403000304060605
Content-Type: text/plain;
	name="gcc34_inline_06.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_06.diff"

--- 28p1/drivers/net/dmfe.c~	2003-11-28 20:26:20.000000000 +0200
+++ 28p1/drivers/net/dmfe.c	2004-08-16 22:40:22.000000000 +0300
@@ -863,6 +863,20 @@
 
 
 /*
+ *	Calculate the CRC valude of the Rx packet
+ *	flag = 	1 : return the reverse CRC (for the received packet CRC)
+ *		0 : return the normal CRC (for Hash Table index)
+ */
+
+static inline u32 cal_CRC(unsigned char * Data, unsigned int Len, u8 flag)
+{
+	u32 crc = ether_crc_le(Len, Data);
+	if (flag) crc = ~crc;
+	return crc;
+}
+
+
+/*
  *	Receive the come packet and pass to upper layer
  */
 
@@ -1753,20 +1767,6 @@
 
 
 /*
- *	Calculate the CRC valude of the Rx packet
- *	flag = 	1 : return the reverse CRC (for the received packet CRC)
- *		0 : return the normal CRC (for Hash Table index)
- */
-
-static inline u32 cal_CRC(unsigned char * Data, unsigned int Len, u8 flag)
-{
-	u32 crc = ether_crc_le(Len, Data);
-	if (flag) crc = ~crc;
-	return crc;
-}
-
-
-/*
  *	Parser SROM and media mode
  */
 
--- 28p1/drivers/net/hamachi.c~	2003-06-13 17:51:34.000000000 +0300
+++ 28p1/drivers/net/hamachi.c	2004-08-16 22:44:45.000000000 +0300
@@ -1369,109 +1369,6 @@
 	return 0;
 }
 
-/* The interrupt handler does all of the Rx thread work and cleans up
-   after the Tx thread. */
-static void hamachi_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
-{
-	struct net_device *dev = dev_instance;
-	struct hamachi_private *hmp;
-	long ioaddr, boguscnt = max_interrupt_work;
-
-#ifndef final_version			/* Can never occur. */
-	if (dev == NULL) {
-		printk (KERN_ERR "hamachi_interrupt(): irq %d for unknown device.\n", irq);
-		return;
-	}
-#endif
-
-	ioaddr = dev->base_addr;
-	hmp = dev->priv;
-	spin_lock(&hmp->lock);
-
-	do {
-		u32 intr_status = readl(ioaddr + InterruptClear);
-
-		if (hamachi_debug > 4)
-			printk(KERN_DEBUG "%s: Hamachi interrupt, status %4.4x.\n",
-				   dev->name, intr_status);
-
-		if (intr_status == 0)
-			break;
-
-		if (intr_status & IntrRxDone)
-			hamachi_rx(dev);
-
-		if (intr_status & IntrTxDone){
-			/* This code should RARELY need to execute. After all, this is
-			 * a gigabit link, it should consume packets as fast as we put
-			 * them in AND we clear the Tx ring in hamachi_start_xmit().
-			 */ 
-			if (hmp->tx_full){
-				for (; hmp->cur_tx - hmp->dirty_tx > 0; hmp->dirty_tx++){
-					int entry = hmp->dirty_tx % TX_RING_SIZE;
-					struct sk_buff *skb;
-
-					if (hmp->tx_ring[entry].status_n_length & cpu_to_le32(DescOwn)) 
-						break;
-					skb = hmp->tx_skbuff[entry];
-					/* Free the original skb. */
-					if (skb){
-						pci_unmap_single(hmp->pci_dev, 
-							hmp->tx_ring[entry].addr, 
-							skb->len,
-							PCI_DMA_TODEVICE);
-						dev_kfree_skb_irq(skb);
-						hmp->tx_skbuff[entry] = 0;
-					}
-					hmp->tx_ring[entry].status_n_length = 0;
-					if (entry >= TX_RING_SIZE-1)  
-						hmp->tx_ring[TX_RING_SIZE-1].status_n_length |= 
-							cpu_to_le32(DescEndRing);
-					hmp->stats.tx_packets++;
-				}
-				if (hmp->cur_tx - hmp->dirty_tx < TX_RING_SIZE - 4){
-					/* The ring is no longer full */
-					hmp->tx_full = 0;
-					netif_wake_queue(dev);
-				}
-			} else {
-				netif_wake_queue(dev);
-			}
-		}
-
-
-		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status &
-			(IntrTxPCIFault | IntrTxPCIErr | IntrRxPCIFault | IntrRxPCIErr |
-			 LinkChange | NegotiationChange | StatsMax))
-			hamachi_error(dev, intr_status);
-
-		if (--boguscnt < 0) {
-			printk(KERN_WARNING "%s: Too much work at interrupt, status=0x%4.4x.\n",
-				   dev->name, intr_status);
-			break;
-		}
-	} while (1);
-
-	if (hamachi_debug > 3)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
-			   dev->name, readl(ioaddr + IntrStatus));
-
-#ifndef final_version
-	/* Code that should never be run!  Perhaps remove after testing.. */
-	{
-		static int stopit = 10;
-		if (dev->start == 0  &&  --stopit < 0) {
-			printk(KERN_ERR "%s: Emergency stop, looping startup interrupt.\n",
-				   dev->name);
-			free_irq(irq, dev);
-		}
-	}
-#endif
-
-	spin_unlock(&hmp->lock);
-}
-
 /* This routine is logically part of the interrupt handler, but seperated
    for clarity and better register allocation. */
 static int hamachi_rx(struct net_device *dev)
@@ -1677,6 +1574,109 @@
 	return 0;
 }
 
+/* The interrupt handler does all of the Rx thread work and cleans up
+   after the Tx thread. */
+static void hamachi_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
+{
+	struct net_device *dev = dev_instance;
+	struct hamachi_private *hmp;
+	long ioaddr, boguscnt = max_interrupt_work;
+
+#ifndef final_version			/* Can never occur. */
+	if (dev == NULL) {
+		printk (KERN_ERR "hamachi_interrupt(): irq %d for unknown device.\n", irq);
+		return;
+	}
+#endif
+
+	ioaddr = dev->base_addr;
+	hmp = dev->priv;
+	spin_lock(&hmp->lock);
+
+	do {
+		u32 intr_status = readl(ioaddr + InterruptClear);
+
+		if (hamachi_debug > 4)
+			printk(KERN_DEBUG "%s: Hamachi interrupt, status %4.4x.\n",
+				   dev->name, intr_status);
+
+		if (intr_status == 0)
+			break;
+
+		if (intr_status & IntrRxDone)
+			hamachi_rx(dev);
+
+		if (intr_status & IntrTxDone){
+			/* This code should RARELY need to execute. After all, this is
+			 * a gigabit link, it should consume packets as fast as we put
+			 * them in AND we clear the Tx ring in hamachi_start_xmit().
+			 */ 
+			if (hmp->tx_full){
+				for (; hmp->cur_tx - hmp->dirty_tx > 0; hmp->dirty_tx++){
+					int entry = hmp->dirty_tx % TX_RING_SIZE;
+					struct sk_buff *skb;
+
+					if (hmp->tx_ring[entry].status_n_length & cpu_to_le32(DescOwn)) 
+						break;
+					skb = hmp->tx_skbuff[entry];
+					/* Free the original skb. */
+					if (skb){
+						pci_unmap_single(hmp->pci_dev, 
+							hmp->tx_ring[entry].addr, 
+							skb->len,
+							PCI_DMA_TODEVICE);
+						dev_kfree_skb_irq(skb);
+						hmp->tx_skbuff[entry] = 0;
+					}
+					hmp->tx_ring[entry].status_n_length = 0;
+					if (entry >= TX_RING_SIZE-1)  
+						hmp->tx_ring[TX_RING_SIZE-1].status_n_length |= 
+							cpu_to_le32(DescEndRing);
+					hmp->stats.tx_packets++;
+				}
+				if (hmp->cur_tx - hmp->dirty_tx < TX_RING_SIZE - 4){
+					/* The ring is no longer full */
+					hmp->tx_full = 0;
+					netif_wake_queue(dev);
+				}
+			} else {
+				netif_wake_queue(dev);
+			}
+		}
+
+
+		/* Abnormal error summary/uncommon events handlers. */
+		if (intr_status &
+			(IntrTxPCIFault | IntrTxPCIErr | IntrRxPCIFault | IntrRxPCIErr |
+			 LinkChange | NegotiationChange | StatsMax))
+			hamachi_error(dev, intr_status);
+
+		if (--boguscnt < 0) {
+			printk(KERN_WARNING "%s: Too much work at interrupt, status=0x%4.4x.\n",
+				   dev->name, intr_status);
+			break;
+		}
+	} while (1);
+
+	if (hamachi_debug > 3)
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
+			   dev->name, readl(ioaddr + IntrStatus));
+
+#ifndef final_version
+	/* Code that should never be run!  Perhaps remove after testing.. */
+	{
+		static int stopit = 10;
+		if (dev->start == 0  &&  --stopit < 0) {
+			printk(KERN_ERR "%s: Emergency stop, looping startup interrupt.\n",
+				   dev->name);
+			free_irq(irq, dev);
+		}
+	}
+#endif
+
+	spin_unlock(&hmp->lock);
+}
+
 /* This is more properly named "uncommon interrupt events", as it covers more
    than just errors. */
 static void hamachi_error(struct net_device *dev, int intr_status)
--- 28p1/drivers/net/smc9194.c~	2003-06-13 17:51:35.000000000 +0300
+++ 28p1/drivers/net/smc9194.c	2004-08-16 22:49:13.000000000 +0300
@@ -1132,131 +1132,6 @@
 	netif_wake_queue(dev);
 }
 
-/*--------------------------------------------------------------------
- .
- . This is the main routine of the driver, to handle the device when
- . it needs some attention.
- .
- . So:
- .   first, save state of the chipset
- .   branch off into routines to handle each case, and acknowledge
- .	    each to the interrupt register
- .   and finally restore state.
- .
- ---------------------------------------------------------------------*/
-
-static void smc_interrupt(int irq, void * dev_id,  struct pt_regs * regs)
-{
-	struct net_device *dev 	= dev_id;
-	int ioaddr 		= dev->base_addr;
-	struct smc_local *lp 	= (struct smc_local *)dev->priv;
-
-	byte	status;
-	word	card_stats;
-	byte	mask;
-	int	timeout;
-	/* state registers */
-	word	saved_bank;
-	word	saved_pointer;
-
-
-
-	PRINTK3((CARDNAME": SMC interrupt started \n"));
-
-	saved_bank = inw( ioaddr + BANK_SELECT );
-
-	SMC_SELECT_BANK(2);
-	saved_pointer = inw( ioaddr + POINTER );
-
-	mask = inb( ioaddr + INT_MASK );
-	/* clear all interrupts */
-	outb( 0, ioaddr + INT_MASK );
-
-
-	/* set a timeout value, so I don't stay here forever */
-	timeout = 4;
-
-	PRINTK2((KERN_WARNING CARDNAME ": MASK IS %x \n", mask ));
-	do {
-		/* read the status flag, and mask it */
-		status = inb( ioaddr + INTERRUPT ) & mask;
-		if (!status )
-			break;
-
-		PRINTK3((KERN_WARNING CARDNAME
-			": Handling interrupt status %x \n", status ));
-
-		if (status & IM_RCV_INT) {
-			/* Got a packet(s). */
-			PRINTK2((KERN_WARNING CARDNAME
-				": Receive Interrupt\n"));
-			smc_rcv(dev);
-		} else if (status & IM_TX_INT ) {
-			PRINTK2((KERN_WARNING CARDNAME
-				": TX ERROR handled\n"));
-			smc_tx(dev);
-			outb(IM_TX_INT, ioaddr + INTERRUPT );
-		} else if (status & IM_TX_EMPTY_INT ) {
-			/* update stats */
-			SMC_SELECT_BANK( 0 );
-			card_stats = inw( ioaddr + COUNTER );
-			/* single collisions */
-			lp->stats.collisions += card_stats & 0xF;
-			card_stats >>= 4;
-			/* multiple collisions */
-			lp->stats.collisions += card_stats & 0xF;
-
-			/* these are for when linux supports these statistics */
-
-			SMC_SELECT_BANK( 2 );
-			PRINTK2((KERN_WARNING CARDNAME
-				": TX_BUFFER_EMPTY handled\n"));
-			outb( IM_TX_EMPTY_INT, ioaddr + INTERRUPT );
-			mask &= ~IM_TX_EMPTY_INT;
-			lp->stats.tx_packets += lp->packets_waiting;
-			lp->packets_waiting = 0;
-
-		} else if (status & IM_ALLOC_INT ) {
-			PRINTK2((KERN_DEBUG CARDNAME
-				": Allocation interrupt \n"));
-			/* clear this interrupt so it doesn't happen again */
-			mask &= ~IM_ALLOC_INT;
-
-			smc_hardware_send_packet( dev );
-
-			/* enable xmit interrupts based on this */
-			mask |= ( IM_TX_EMPTY_INT | IM_TX_INT );
-
-			/* and let the card send more packets to me */
-			netif_wake_queue(dev);
-			
-			PRINTK2((CARDNAME": Handoff done successfully.\n"));
-		} else if (status & IM_RX_OVRN_INT ) {
-			lp->stats.rx_errors++;
-			lp->stats.rx_fifo_errors++;
-			outb( IM_RX_OVRN_INT, ioaddr + INTERRUPT );
-		} else if (status & IM_EPH_INT ) {
-			PRINTK((CARDNAME ": UNSUPPORTED: EPH INTERRUPT \n"));
-		} else if (status & IM_ERCV_INT ) {
-			PRINTK((CARDNAME ": UNSUPPORTED: ERCV INTERRUPT \n"));
-			outb( IM_ERCV_INT, ioaddr + INTERRUPT );
-		}
-	} while ( timeout -- );
-
-
-	/* restore state register */
-	SMC_SELECT_BANK( 2 );
-	outb( mask, ioaddr + INT_MASK );
-
-	PRINTK3(( KERN_WARNING CARDNAME ": MASK is now %x \n", mask ));
-	outw( saved_pointer, ioaddr + POINTER );
-
-	SMC_SELECT_BANK( saved_bank );
-
-	PRINTK3((CARDNAME ": Interrupt done\n"));
-	return;
-}
-
 /*-------------------------------------------------------------
  .
  . smc_rcv -  receive a packet from the card
@@ -1448,6 +1323,131 @@
 	return;
 }
 
+/*--------------------------------------------------------------------
+ .
+ . This is the main routine of the driver, to handle the device when
+ . it needs some attention.
+ .
+ . So:
+ .   first, save state of the chipset
+ .   branch off into routines to handle each case, and acknowledge
+ .	    each to the interrupt register
+ .   and finally restore state.
+ .
+ ---------------------------------------------------------------------*/
+
+static void smc_interrupt(int irq, void * dev_id,  struct pt_regs * regs)
+{
+	struct net_device *dev 	= dev_id;
+	int ioaddr 		= dev->base_addr;
+	struct smc_local *lp 	= (struct smc_local *)dev->priv;
+
+	byte	status;
+	word	card_stats;
+	byte	mask;
+	int	timeout;
+	/* state registers */
+	word	saved_bank;
+	word	saved_pointer;
+
+
+
+	PRINTK3((CARDNAME": SMC interrupt started \n"));
+
+	saved_bank = inw( ioaddr + BANK_SELECT );
+
+	SMC_SELECT_BANK(2);
+	saved_pointer = inw( ioaddr + POINTER );
+
+	mask = inb( ioaddr + INT_MASK );
+	/* clear all interrupts */
+	outb( 0, ioaddr + INT_MASK );
+
+
+	/* set a timeout value, so I don't stay here forever */
+	timeout = 4;
+
+	PRINTK2((KERN_WARNING CARDNAME ": MASK IS %x \n", mask ));
+	do {
+		/* read the status flag, and mask it */
+		status = inb( ioaddr + INTERRUPT ) & mask;
+		if (!status )
+			break;
+
+		PRINTK3((KERN_WARNING CARDNAME
+			": Handling interrupt status %x \n", status ));
+
+		if (status & IM_RCV_INT) {
+			/* Got a packet(s). */
+			PRINTK2((KERN_WARNING CARDNAME
+				": Receive Interrupt\n"));
+			smc_rcv(dev);
+		} else if (status & IM_TX_INT ) {
+			PRINTK2((KERN_WARNING CARDNAME
+				": TX ERROR handled\n"));
+			smc_tx(dev);
+			outb(IM_TX_INT, ioaddr + INTERRUPT );
+		} else if (status & IM_TX_EMPTY_INT ) {
+			/* update stats */
+			SMC_SELECT_BANK( 0 );
+			card_stats = inw( ioaddr + COUNTER );
+			/* single collisions */
+			lp->stats.collisions += card_stats & 0xF;
+			card_stats >>= 4;
+			/* multiple collisions */
+			lp->stats.collisions += card_stats & 0xF;
+
+			/* these are for when linux supports these statistics */
+
+			SMC_SELECT_BANK( 2 );
+			PRINTK2((KERN_WARNING CARDNAME
+				": TX_BUFFER_EMPTY handled\n"));
+			outb( IM_TX_EMPTY_INT, ioaddr + INTERRUPT );
+			mask &= ~IM_TX_EMPTY_INT;
+			lp->stats.tx_packets += lp->packets_waiting;
+			lp->packets_waiting = 0;
+
+		} else if (status & IM_ALLOC_INT ) {
+			PRINTK2((KERN_DEBUG CARDNAME
+				": Allocation interrupt \n"));
+			/* clear this interrupt so it doesn't happen again */
+			mask &= ~IM_ALLOC_INT;
+
+			smc_hardware_send_packet( dev );
+
+			/* enable xmit interrupts based on this */
+			mask |= ( IM_TX_EMPTY_INT | IM_TX_INT );
+
+			/* and let the card send more packets to me */
+			netif_wake_queue(dev);
+			
+			PRINTK2((CARDNAME": Handoff done successfully.\n"));
+		} else if (status & IM_RX_OVRN_INT ) {
+			lp->stats.rx_errors++;
+			lp->stats.rx_fifo_errors++;
+			outb( IM_RX_OVRN_INT, ioaddr + INTERRUPT );
+		} else if (status & IM_EPH_INT ) {
+			PRINTK((CARDNAME ": UNSUPPORTED: EPH INTERRUPT \n"));
+		} else if (status & IM_ERCV_INT ) {
+			PRINTK((CARDNAME ": UNSUPPORTED: ERCV INTERRUPT \n"));
+			outb( IM_ERCV_INT, ioaddr + INTERRUPT );
+		}
+	} while ( timeout -- );
+
+
+	/* restore state register */
+	SMC_SELECT_BANK( 2 );
+	outb( mask, ioaddr + INT_MASK );
+
+	PRINTK3(( KERN_WARNING CARDNAME ": MASK is now %x \n", mask ));
+	outw( saved_pointer, ioaddr + POINTER );
+
+	SMC_SELECT_BANK( saved_bank );
+
+	PRINTK3((CARDNAME ": Interrupt done\n"));
+	return;
+}
+
 /*----------------------------------------------------
  . smc_close
  .
--- 28p1/drivers/net/eql.c~	2004-08-08 02:26:05.000000000 +0300
+++ 28p1/drivers/net/eql.c	2004-08-16 23:15:09.000000000 +0300
@@ -335,6 +335,152 @@
 }
 
 
+static inline int eql_number_slaves(slave_queue_t *queue)
+{
+	return queue->num_slaves;
+}
+
+
+static inline int eql_is_empty(slave_queue_t *queue)
+{
+	if (eql_number_slaves (queue) == 0)
+		return 1;
+	return 0;
+}
+
+static inline int eql_is_full(slave_queue_t *queue)
+{
+	equalizer_t *eql = (equalizer_t *) queue->master_dev->priv;
+
+	if (eql_number_slaves (queue) == eql->max_slaves)
+		return 1;
+	return 0;
+}
+
+static inline slave_t *eql_first_slave(slave_queue_t *queue)
+{
+	return queue->head->next;
+}
+
+
+static inline slave_t *eql_next_slave(slave_queue_t *queue, slave_t *slave)
+{
+	return slave->next;
+}
+
+static inline void eql_set_best_slave(slave_queue_t *queue, slave_t *slave)
+{
+	queue->best_slave = slave;
+}
+
+static inline void eql_schedule_slaves(slave_queue_t *queue)
+{
+	struct net_device *master_dev = queue->master_dev;
+	slave_t *best_slave = 0;
+	slave_t *slave_corpse = 0;
+
+#ifdef EQL_DEBUG
+	if (eql_debug >= 100)
+		printk ("%s: schedule %d slaves\n", 
+			master_dev->name, eql_number_slaves (queue));
+#endif
+	if ( eql_is_empty (queue) )
+	{
+		/*
+		 *	No slaves to play with 
+		 */
+		eql_set_best_slave (queue, (slave_t *) 0);
+		return;
+	}
+	else
+	{		
+		/*
+		 *	Make a pass to set the best slave 
+		 */
+		unsigned long best_load = (unsigned long) ULONG_MAX;
+		slave_t *slave = 0;
+		unsigned long flags;
+		int i;
+
+		save_flags(flags);
+		cli ();
+		for (i = 1, slave = eql_first_slave (queue);
+			i <= eql_number_slaves (queue);
+			i++, slave = eql_next_slave (queue, slave))
+		{
+			/*
+			 *	Go through the slave list once, updating best_slave 
+			 *      whenever a new best_load is found, whenever a dead
+			 *	slave is found, it is marked to be pulled out of the 
+			 *	queue 
+			 */
+		
+			unsigned long slave_load;
+			unsigned long bytes_queued; 
+			unsigned long priority_Bps; 
+	  	
+	  		if (slave != 0)
+			{
+				bytes_queued = slave->bytes_queued;
+				priority_Bps = slave->priority_Bps;    
+				if ( slave->dev != 0)
+				{
+					if ((slave->dev->flags & IFF_UP) == IFF_UP )
+					{
+						slave_load = (ULONG_MAX - (ULONG_MAX / 2)) - 
+							(priority_Bps) + bytes_queued * 8;
+
+		      				if (slave_load < best_load)
+						{
+							best_load = slave_load;
+							best_slave = slave;
+						}
+					}
+					else		/* we found a dead slave */
+					{
+						/* 
+						 *	We only bury one slave at a time, if more than
+						 *	one slave dies, we will bury him on the next 
+						 *	reschedule. slaves don't die all at once that 
+						 *	much anyway 
+						 */
+						slave_corpse = slave;
+					}
+				}
+			}
+		} /* for */
+		restore_flags(flags);
+		eql_set_best_slave (queue, best_slave);
+	} /* else */
+	if (slave_corpse != 0)
+	{
+		printk ("eql: scheduler found dead slave, burying...\n");
+		eql_delete_slave (eql_remove_slave (queue, slave_corpse));
+	}
+	return;
+}
+
+
+static inline struct net_device *eql_best_slave_dev(slave_queue_t *queue)
+{
+	if (queue->best_slave != 0)
+	{
+		if (queue->best_slave->dev != 0)
+			return queue->best_slave->dev;
+		else
+			return 0;
+	}
+	else
+		return 0;
+}
+
+
+static inline slave_t *eql_best_slave(slave_queue_t *queue)
+{
+	return queue->best_slave;
+}
+
+
 static int eql_slave_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	equalizer_t *eql = (equalizer_t *) dev->priv;
@@ -383,6 +529,28 @@
 	return eql->stats;
 }
 
+static inline int eql_is_slave(struct net_device *dev)
+{
+	if (dev)
+	{
+		if ((dev->flags & IFF_SLAVE) == IFF_SLAVE)
+			return 1;
+	}
+	return 0;
+}
+
+
+static inline int eql_is_master(struct net_device *dev)
+{
+	if (dev)
+	{
+		if ((dev->flags & IFF_MASTER) == IFF_MASTER)
+		return 1;
+	}
+	return 0;
+}
+
+
 /*
  *	Private ioctl functions
  */
@@ -597,28 +765,6 @@
  *	Private device support functions
  */
 
-static inline int eql_is_slave(struct net_device *dev)
-{
-	if (dev)
-	{
-		if ((dev->flags & IFF_SLAVE) == IFF_SLAVE)
-			return 1;
-	}
-	return 0;
-}
-
-
-static inline int eql_is_master(struct net_device *dev)
-{
-	if (dev)
-	{
-		if ((dev->flags & IFF_MASTER) == IFF_MASTER)
-		return 1;
-	}
-	return 0;
-}
-
-
 static slave_t *eql_new_slave(void)
 {
 	slave_t *slave;
@@ -650,27 +796,6 @@
 
 #endif
 
-static inline int eql_number_slaves(slave_queue_t *queue)
-{
-	return queue->num_slaves;
-}
-
-static inline int eql_is_empty(slave_queue_t *queue)
-{
-	if (eql_number_slaves (queue) == 0)
-		return 1;
-	return 0;
-}
-
-static inline int eql_is_full(slave_queue_t *queue)
-{
-	equalizer_t *eql = (equalizer_t *) queue->master_dev->priv;
-
-	if (eql_number_slaves (queue) == eql->max_slaves)
-		return 1;
-	return 0;
-}
-
 static slave_queue_t *eql_new_slave_queue(struct net_device *dev)
 {
 	slave_queue_t *queue;
@@ -817,113 +942,6 @@
 }
 
 
-static inline struct net_device *eql_best_slave_dev(slave_queue_t *queue)
-{
-	if (queue->best_slave != 0)
-	{
-		if (queue->best_slave->dev != 0)
-			return queue->best_slave->dev;
-		else
-			return 0;
-	}
-	else
-		return 0;
-}
-
-
-static inline slave_t *eql_best_slave(slave_queue_t *queue)
-{
-	return queue->best_slave;
-}
-
-static inline void eql_schedule_slaves(slave_queue_t *queue)
-{
-	struct net_device *master_dev = queue->master_dev;
-	slave_t *best_slave = 0;
-	slave_t *slave_corpse = 0;
-
-#ifdef EQL_DEBUG
-	if (eql_debug >= 100)
-		printk ("%s: schedule %d slaves\n", 
-			master_dev->name, eql_number_slaves (queue));
-#endif
-	if ( eql_is_empty (queue) )
-	{
-		/*
-		 *	No slaves to play with 
-		 */
-		eql_set_best_slave (queue, (slave_t *) 0);
-		return;
-	}
-	else
-	{		
-		/*
-		 *	Make a pass to set the best slave 
-		 */
-		unsigned long best_load = (unsigned long) ULONG_MAX;
-		slave_t *slave = 0;
-		unsigned long flags;
-		int i;
-
-		save_flags(flags);
-		cli ();
-		for (i = 1, slave = eql_first_slave (queue);
-			i <= eql_number_slaves (queue);
-			i++, slave = eql_next_slave (queue, slave))
-		{
-			/*
-			 *	Go through the slave list once, updating best_slave 
-			 *      whenever a new best_load is found, whenever a dead
-			 *	slave is found, it is marked to be pulled out of the 
-			 *	queue 
-			 */
-		
-			unsigned long slave_load;
-			unsigned long bytes_queued; 
-			unsigned long priority_Bps; 
-	  	
-	  		if (slave != 0)
-			{
-				bytes_queued = slave->bytes_queued;
-				priority_Bps = slave->priority_Bps;    
-				if ( slave->dev != 0)
-				{
-					if ((slave->dev->flags & IFF_UP) == IFF_UP )
-					{
-						slave_load = (ULONG_MAX - (ULONG_MAX / 2)) - 
-							(priority_Bps) + bytes_queued * 8;
-
-		      				if (slave_load < best_load)
-						{
-							best_load = slave_load;
-							best_slave = slave;
-						}
-					}
-					else		/* we found a dead slave */
-					{
-						/* 
-						 *	We only bury one slave at a time, if more than
-						 *	one slave dies, we will bury him on the next 
-						 *	reschedule. slaves don't die all at once that 
-						 *	much anyway 
-						 */
-						slave_corpse = slave;
-					}
-				}
-			}
-		} /* for */
-		restore_flags(flags);
-		eql_set_best_slave (queue, best_slave);
-	} /* else */
-	if (slave_corpse != 0)
-	{
-		printk ("eql: scheduler found dead slave, burying...\n");
-		eql_delete_slave (eql_remove_slave (queue, slave_corpse));
-	}
-	return;
-}
-
-
 static slave_t * eql_find_slave_dev(slave_queue_t *queue, struct net_device *dev)
 {
 	slave_t *slave = 0;
@@ -943,22 +961,6 @@
 }
 
 
-static inline slave_t *eql_first_slave(slave_queue_t *queue)
-{
-	return queue->head->next;
-}
-
-
-static inline slave_t *eql_next_slave(slave_queue_t *queue, slave_t *slave)
-{
-	return slave->next;
-}
-
-static inline void eql_set_best_slave(slave_queue_t *queue, slave_t *slave)
-{
-	queue->best_slave = slave;
-}
-
 static void eql_timer(unsigned long param)
 {
 	equalizer_t *eql = (equalizer_t *) param;
--- 28p1/drivers/net/e100/e100_main.c~	2004-08-08 02:26:05.000000000 +0300
+++ 28p1/drivers/net/e100/e100_main.c	2004-08-16 23:20:02.000000000 +0300
@@ -1073,6 +1073,116 @@
 	return 0;
 }
 
+/**
+ * e100_prepare_xmit_buff - prepare a buffer for transmission
+ * @bdp: atapter's private data struct
+ * @skb: skb to send
+ *
+ * This routine prepare a buffer for transmission. It checks
+ * the message length for the appropiate size. It picks up a
+ * free tcb from the TCB pool and sets up the corresponding
+ * TBD's. If the number of fragments are more than the number
+ * of TBD/TCB it copies all the fragments in a coalesce buffer.
+ * It returns a pointer to the prepared TCB.
+ */
+static inline tcb_t *
+e100_prepare_xmit_buff(struct e100_private *bdp, struct sk_buff *skb)
+{
+	tcb_t *tcb, *prev_tcb;
+
+	tcb = bdp->tcb_pool.data;
+	tcb += TCB_TO_USE(bdp->tcb_pool);
+
+	if (bdp->flags & USE_IPCB) {
+		tcb->tcbu.ipcb.ip_activation_high = IPCB_IP_ACTIVATION_DEFAULT;
+		tcb->tcbu.ipcb.ip_schedule &= ~IPCB_TCP_PACKET;
+		tcb->tcbu.ipcb.ip_schedule &= ~IPCB_TCPUDP_CHECKSUM_ENABLE;
+	}
+
+	if(bdp->vlgrp && vlan_tx_tag_present(skb)) {
+		(tcb->tcbu).ipcb.ip_activation_high |= IPCB_INSERTVLAN_ENABLE;
+		(tcb->tcbu).ipcb.vlan = cpu_to_be16(vlan_tx_tag_get(skb));
+	}
+	
+	tcb->tcb_hdr.cb_status = 0;
+	tcb->tcb_thrshld = bdp->tx_thld;
+	tcb->tcb_hdr.cb_cmd |= __constant_cpu_to_le16(CB_S_BIT);
+
+	/* Set I (Interrupt) bit on every (TX_FRAME_CNT)th packet */
+	if (!(++bdp->tx_count % TX_FRAME_CNT))
+		tcb->tcb_hdr.cb_cmd |= __constant_cpu_to_le16(CB_I_BIT);
+	else
+		/* Clear I bit on other packets */
+		tcb->tcb_hdr.cb_cmd &= ~__constant_cpu_to_le16(CB_I_BIT);
+
+	tcb->tcb_skb = skb;
+
+	if (skb->ip_summed == CHECKSUM_HW) {
+		const struct iphdr *ip = skb->nh.iph;
+
+		if ((ip->protocol == IPPROTO_TCP) ||
+		    (ip->protocol == IPPROTO_UDP)) {
+
+			tcb->tcbu.ipcb.ip_activation_high |=
+				IPCB_HARDWAREPARSING_ENABLE;
+			tcb->tcbu.ipcb.ip_schedule |=
+				IPCB_TCPUDP_CHECKSUM_ENABLE;
+
+			if (ip->protocol == IPPROTO_TCP)
+				tcb->tcbu.ipcb.ip_schedule |= IPCB_TCP_PACKET;
+		}
+	}
+
+	if (!skb_shinfo(skb)->nr_frags) {
+		(tcb->tbd_ptr)->tbd_buf_addr =
+			cpu_to_le32(pci_map_single(bdp->pdev, skb->data,
+						   skb->len, PCI_DMA_TODEVICE));
+		(tcb->tbd_ptr)->tbd_buf_cnt = cpu_to_le16(skb->len);
+		tcb->tcb_tbd_num = 1;
+		tcb->tcb_tbd_ptr = tcb->tcb_tbd_dflt_ptr;
+	} else {
+		int i;
+		void *addr;
+		tbd_t *tbd_arr_ptr = &(tcb->tbd_ptr[1]);
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+
+		(tcb->tbd_ptr)->tbd_buf_addr =
+			cpu_to_le32(pci_map_single(bdp->pdev, skb->data,
+						   skb_headlen(skb),
+						   PCI_DMA_TODEVICE));
+		(tcb->tbd_ptr)->tbd_buf_cnt =
+			cpu_to_le16(skb_headlen(skb));
+
+		for (i = 0; i < skb_shinfo(skb)->nr_frags;
+		     i++, tbd_arr_ptr++, frag++) {
+
+			addr = ((void *) page_address(frag->page) +
+				frag->page_offset);
+
+			tbd_arr_ptr->tbd_buf_addr =
+				cpu_to_le32(pci_map_single(bdp->pdev,
+							   addr, frag->size,
+							   PCI_DMA_TODEVICE));
+			tbd_arr_ptr->tbd_buf_cnt = cpu_to_le16(frag->size);
+		}
+		tcb->tcb_tbd_num = skb_shinfo(skb)->nr_frags + 1;
+		tcb->tcb_tbd_ptr = tcb->tcb_tbd_expand_ptr;
+	}
+
+	/* clear the S-BIT on the previous tcb */
+	prev_tcb = bdp->tcb_pool.data;
+	prev_tcb += PREV_TCB_USED(bdp->tcb_pool);
+	prev_tcb->tcb_hdr.cb_cmd &= __constant_cpu_to_le16((u16) ~CB_S_BIT);
+
+	bdp->tcb_pool.tail = NEXT_TCB_TOUSE(bdp->tcb_pool.tail);
+
+	wmb();
+
+	e100_start_cu(bdp, tcb);
+
+	return tcb;
+}
+
 static int
 e100_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 {
@@ -1605,6 +1715,32 @@
 	return 1;
 }
 
+/**
+ * e100_tx_skb_free - free TX skbs resources
+ * @bdp: atapter's private data struct
+ * @tcb: associated tcb of the freed skb
+ *
+ * This routine frees resources of TX skbs.
+ */
+static inline void
+e100_tx_skb_free(struct e100_private *bdp, tcb_t *tcb)
+{
+	if (tcb->tcb_skb) {
+		int i;
+		tbd_t *tbd_arr = tcb->tbd_ptr;
+		int frags = skb_shinfo(tcb->tcb_skb)->nr_frags;
+
+		for (i = 0; i <= frags; i++, tbd_arr++) {
+			pci_unmap_single(bdp->pdev,
+					 le32_to_cpu(tbd_arr->tbd_buf_addr),
+					 le16_to_cpu(tbd_arr->tbd_buf_cnt),
+					 PCI_DMA_TODEVICE);
+		}
+		dev_kfree_skb_irq(tcb->tcb_skb);
+		tcb->tcb_skb = NULL;
+	}
+}
+
 void
 e100_free_tcb_pool(struct e100_private *bdp)
 {
@@ -1910,32 +2046,6 @@
 }
 
 /**
- * e100_tx_skb_free - free TX skbs resources
- * @bdp: atapter's private data struct
- * @tcb: associated tcb of the freed skb
- *
- * This routine frees resources of TX skbs.
- */
-static inline void
-e100_tx_skb_free(struct e100_private *bdp, tcb_t *tcb)
-{
-	if (tcb->tcb_skb) {
-		int i;
-		tbd_t *tbd_arr = tcb->tbd_ptr;
-		int frags = skb_shinfo(tcb->tcb_skb)->nr_frags;
-
-		for (i = 0; i <= frags; i++, tbd_arr++) {
-			pci_unmap_single(bdp->pdev,
-					 le32_to_cpu(tbd_arr->tbd_buf_addr),
-					 le16_to_cpu(tbd_arr->tbd_buf_cnt),
-					 PCI_DMA_TODEVICE);
-		}
-		dev_kfree_skb_irq(tcb->tcb_skb);
-		tcb->tcb_skb = NULL;
-	}
-}
-
-/**
  * e100_tx_srv - service TX queues
  * @bdp: atapter's private data struct
  *
@@ -2155,116 +2265,6 @@
 	}			/* end underrun check */
 }
 
-/**
- * e100_prepare_xmit_buff - prepare a buffer for transmission
- * @bdp: atapter's private data struct
- * @skb: skb to send
- *
- * This routine prepare a buffer for transmission. It checks
- * the message length for the appropiate size. It picks up a
- * free tcb from the TCB pool and sets up the corresponding
- * TBD's. If the number of fragments are more than the number
- * of TBD/TCB it copies all the fragments in a coalesce buffer.
- * It returns a pointer to the prepared TCB.
- */
-static inline tcb_t *
-e100_prepare_xmit_buff(struct e100_private *bdp, struct sk_buff *skb)
-{
-	tcb_t *tcb, *prev_tcb;
-
-	tcb = bdp->tcb_pool.data;
-	tcb += TCB_TO_USE(bdp->tcb_pool);
-
-	if (bdp->flags & USE_IPCB) {
-		tcb->tcbu.ipcb.ip_activation_high = IPCB_IP_ACTIVATION_DEFAULT;
-		tcb->tcbu.ipcb.ip_schedule &= ~IPCB_TCP_PACKET;
-		tcb->tcbu.ipcb.ip_schedule &= ~IPCB_TCPUDP_CHECKSUM_ENABLE;
-	}
-
-	if(bdp->vlgrp && vlan_tx_tag_present(skb)) {
-		(tcb->tcbu).ipcb.ip_activation_high |= IPCB_INSERTVLAN_ENABLE;
-		(tcb->tcbu).ipcb.vlan = cpu_to_be16(vlan_tx_tag_get(skb));
-	}
-	
-	tcb->tcb_hdr.cb_status = 0;
-	tcb->tcb_thrshld = bdp->tx_thld;
-	tcb->tcb_hdr.cb_cmd |= __constant_cpu_to_le16(CB_S_BIT);
-
-	/* Set I (Interrupt) bit on every (TX_FRAME_CNT)th packet */
-	if (!(++bdp->tx_count % TX_FRAME_CNT))
-		tcb->tcb_hdr.cb_cmd |= __constant_cpu_to_le16(CB_I_BIT);
-	else
-		/* Clear I bit on other packets */
-		tcb->tcb_hdr.cb_cmd &= ~__constant_cpu_to_le16(CB_I_BIT);
-
-	tcb->tcb_skb = skb;
-
-	if (skb->ip_summed == CHECKSUM_HW) {
-		const struct iphdr *ip = skb->nh.iph;
-
-		if ((ip->protocol == IPPROTO_TCP) ||
-		    (ip->protocol == IPPROTO_UDP)) {
-
-			tcb->tcbu.ipcb.ip_activation_high |=
-				IPCB_HARDWAREPARSING_ENABLE;
-			tcb->tcbu.ipcb.ip_schedule |=
-				IPCB_TCPUDP_CHECKSUM_ENABLE;
-
-			if (ip->protocol == IPPROTO_TCP)
-				tcb->tcbu.ipcb.ip_schedule |= IPCB_TCP_PACKET;
-		}
-	}
-
-	if (!skb_shinfo(skb)->nr_frags) {
-		(tcb->tbd_ptr)->tbd_buf_addr =
-			cpu_to_le32(pci_map_single(bdp->pdev, skb->data,
-						   skb->len, PCI_DMA_TODEVICE));
-		(tcb->tbd_ptr)->tbd_buf_cnt = cpu_to_le16(skb->len);
-		tcb->tcb_tbd_num = 1;
-		tcb->tcb_tbd_ptr = tcb->tcb_tbd_dflt_ptr;
-	} else {
-		int i;
-		void *addr;
-		tbd_t *tbd_arr_ptr = &(tcb->tbd_ptr[1]);
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
-
-		(tcb->tbd_ptr)->tbd_buf_addr =
-			cpu_to_le32(pci_map_single(bdp->pdev, skb->data,
-						   skb_headlen(skb),
-						   PCI_DMA_TODEVICE));
-		(tcb->tbd_ptr)->tbd_buf_cnt =
-			cpu_to_le16(skb_headlen(skb));
-
-		for (i = 0; i < skb_shinfo(skb)->nr_frags;
-		     i++, tbd_arr_ptr++, frag++) {
-
-			addr = ((void *) page_address(frag->page) +
-				frag->page_offset);
-
-			tbd_arr_ptr->tbd_buf_addr =
-				cpu_to_le32(pci_map_single(bdp->pdev,
-							   addr, frag->size,
-							   PCI_DMA_TODEVICE));
-			tbd_arr_ptr->tbd_buf_cnt = cpu_to_le16(frag->size);
-		}
-		tcb->tcb_tbd_num = skb_shinfo(skb)->nr_frags + 1;
-		tcb->tcb_tbd_ptr = tcb->tcb_tbd_expand_ptr;
-	}
-
-	/* clear the S-BIT on the previous tcb */
-	prev_tcb = bdp->tcb_pool.data;
-	prev_tcb += PREV_TCB_USED(bdp->tcb_pool);
-	prev_tcb->tcb_hdr.cb_cmd &= __constant_cpu_to_le16((u16) ~CB_S_BIT);
-
-	bdp->tcb_pool.tail = NEXT_TCB_TOUSE(bdp->tcb_pool.tail);
-
-	wmb();
-
-	e100_start_cu(bdp, tcb);
-
-	return tcb;
-}
-
 /* Changed for 82558 enhancement */
 /**
  * e100_start_cu - start the adapter's CU
--- 28p1/drivers/net/e1000/e1000_main.c~	2004-08-08 02:26:05.000000000 +0300
+++ 28p1/drivers/net/e1000/e1000_main.c	2004-08-16 23:27:57.000000000 +0300
@@ -248,6 +248,34 @@
 module_exit(e1000_exit_module);
 
 
+/**
+ * e1000_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ **/
+
+static inline void
+e1000_irq_enable(struct e1000_adapter *adapter)
+{
+	if(atomic_dec_and_test(&adapter->irq_sem)) {
+		E1000_WRITE_REG(&adapter->hw, IMS, IMS_ENABLE_MASK);
+		E1000_WRITE_FLUSH(&adapter->hw);
+	}
+}
+
+/**
+ * e1000_irq_disable - Mask off interrupt generation on the NIC
+ * @adapter: board private structure
+ **/
+
+static inline void
+e1000_irq_disable(struct e1000_adapter *adapter)
+{
+	atomic_inc(&adapter->irq_sem);
+	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
+	E1000_WRITE_FLUSH(&adapter->hw);
+	synchronize_irq();
+}
+
 int
 e1000_up(struct e1000_adapter *adapter)
 {
@@ -2055,34 +2083,6 @@
 }
 
 /**
- * e1000_irq_disable - Mask off interrupt generation on the NIC
- * @adapter: board private structure
- **/
-
-static inline void
-e1000_irq_disable(struct e1000_adapter *adapter)
-{
-	atomic_inc(&adapter->irq_sem);
-	E1000_WRITE_REG(&adapter->hw, IMC, ~0);
-	E1000_WRITE_FLUSH(&adapter->hw);
-	synchronize_irq();
-}
-
-/**
- * e1000_irq_enable - Enable default interrupt generation settings
- * @adapter: board private structure
- **/
-
-static inline void
-e1000_irq_enable(struct e1000_adapter *adapter)
-{
-	if(atomic_dec_and_test(&adapter->irq_sem)) {
-		E1000_WRITE_REG(&adapter->hw, IMS, IMS_ENABLE_MASK);
-		E1000_WRITE_FLUSH(&adapter->hw);
-	}
-}
-
-/**
  * e1000_intr - Interrupt Handler
  * @irq: interrupt number
  * @data: pointer to a network interface device structure
@@ -2227,6 +2227,41 @@
 }
 
 /**
+ * e1000_rx_checksum - Receive Checksum Offload for 82543
+ * @adapter: board private structure
+ * @rx_desc: receive descriptor
+ * @sk_buff: socket buffer with received data
+ **/
+
+static inline void
+e1000_rx_checksum(struct e1000_adapter *adapter,
+                  struct e1000_rx_desc *rx_desc,
+                  struct sk_buff *skb)
+{
+	/* 82543 or newer only */
+	if((adapter->hw.mac_type < e1000_82543) ||
+	/* Ignore Checksum bit is set */
+	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
+	/* TCP Checksum has not been calculated */
+	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	/* At this point we know the hardware did the TCP checksum */
+	/* now look at the TCP checksum error bit */
+	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
+		/* let the stack verify checksum errors */
+		skb->ip_summed = CHECKSUM_NONE;
+		adapter->hw_csum_err++;
+	} else {
+	/* TCP checksum is good */
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		adapter->hw_csum_good++;
+	}
+}
+
+/**
  * e1000_clean_rx_irq - Send received data up the network stack,
  * @adapter: board private structure
  **/
@@ -2581,41 +2616,6 @@
 	return E1000_SUCCESS;
 }
 
-/**
- * e1000_rx_checksum - Receive Checksum Offload for 82543
- * @adapter: board private structure
- * @rx_desc: receive descriptor
- * @sk_buff: socket buffer with received data
- **/
-
-static inline void
-e1000_rx_checksum(struct e1000_adapter *adapter,
-                  struct e1000_rx_desc *rx_desc,
-                  struct sk_buff *skb)
-{
-	/* 82543 or newer only */
-	if((adapter->hw.mac_type < e1000_82543) ||
-	/* Ignore Checksum bit is set */
-	(rx_desc->status & E1000_RXD_STAT_IXSM) ||
-	/* TCP Checksum has not been calculated */
-	(!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {
-		skb->ip_summed = CHECKSUM_NONE;
-		return;
-	}
-
-	/* At this point we know the hardware did the TCP checksum */
-	/* now look at the TCP checksum error bit */
-	if(rx_desc->errors & E1000_RXD_ERR_TCPE) {
-		/* let the stack verify checksum errors */
-		skb->ip_summed = CHECKSUM_NONE;
-		adapter->hw_csum_err++;
-	} else {
-	/* TCP checksum is good */
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		adapter->hw_csum_good++;
-	}
-}
-
 void
 e1000_pci_set_mwi(struct e1000_hw *hw)
 {
--- 28p1/drivers/net/hamradio/dmascc.c~	2002-02-25 21:37:59.000000000 +0200
+++ 28p1/drivers/net/hamradio/dmascc.c	2004-08-16 23:41:59.000000000 +0300
@@ -356,6 +356,12 @@
 
 #endif
 
+static inline unsigned char random(void) {
+  /* See "Numerical Recipes in C", second edition, p. 284 */
+  rand = rand * 1664525L + 1013904223L;
+  return (unsigned char) (rand >> 24);
+}
+
 
 /* Initialization functions */
 
@@ -950,6 +956,34 @@
 }
 
 
+static inline void z8530_isr(struct scc_info *info) {
+  int is, i = 100;
+
+  while ((is = read_scc(&info->priv[0], R3)) && i--) {
+    if (is & CHARxIP) {
+      rx_isr(&info->priv[0]);
+    } else if (is & CHATxIP) {
+      tx_isr(&info->priv[0]);
+    } else if (is & CHAEXT) {
+      es_isr(&info->priv[0]);
+    } else if (is & CHBRxIP) {
+      rx_isr(&info->priv[1]);
+    } else if (is & CHBTxIP) {
+      tx_isr(&info->priv[1]);
+    } else {
+      es_isr(&info->priv[1]);
+    }
+    write_scc(&info->priv[0], R0, RES_H_IUS);
+    i++;
+  }
+  if (i < 0) {
+    printk("dmascc: stuck in ISR with RR3=0x%02x.\n", is);
+  }
+  /* Ok, no interrupts pending from this 8530. The INT line should
+     be inactive now. */
+}
+
+
 static void scc_isr(int irq, void *dev_id, struct pt_regs * regs) {
   struct scc_info *info = dev_id;
 
@@ -983,34 +1017,6 @@
 }
 
 
-static inline void z8530_isr(struct scc_info *info) {
-  int is, i = 100;
-
-  while ((is = read_scc(&info->priv[0], R3)) && i--) {
-    if (is & CHARxIP) {
-      rx_isr(&info->priv[0]);
-    } else if (is & CHATxIP) {
-      tx_isr(&info->priv[0]);
-    } else if (is & CHAEXT) {
-      es_isr(&info->priv[0]);
-    } else if (is & CHBRxIP) {
-      rx_isr(&info->priv[1]);
-    } else if (is & CHBTxIP) {
-      tx_isr(&info->priv[1]);
-    } else {
-      es_isr(&info->priv[1]);
-    }
-    write_scc(&info->priv[0], R0, RES_H_IUS);
-    i++;
-  }
-  if (i < 0) {
-    printk("dmascc: stuck in ISR with RR3=0x%02x.\n", is);
-  }
-  /* Ok, no interrupts pending from this 8530. The INT line should
-     be inactive now. */
-}
-
-
 static void rx_isr(struct scc_priv *priv) {
   if (priv->param.dma >= 0) {
     /* Check special condition and perform error reset. See 2.4.7.5. */
@@ -1160,6 +1166,90 @@
 }
 
 
+static inline void tx_on(struct scc_priv *priv) {
+  int i, n;
+  unsigned long flags;
+
+  if (priv->param.dma >= 0) {
+    n = (priv->chip == Z85230) ? 3 : 1;
+    /* Program DMA controller */
+    flags = claim_dma_lock();
+    set_dma_mode(priv->param.dma, DMA_MODE_WRITE);
+    set_dma_addr(priv->param.dma, (int) priv->tx_buf[priv->tx_tail]+n);
+    set_dma_count(priv->param.dma, priv->tx_len[priv->tx_tail]-n);
+    release_dma_lock(flags);
+    /* Enable TX underrun interrupt */
+    write_scc(priv, R15, TxUIE);
+    /* Configure DREQ */
+    if (priv->type == TYPE_TWIN)
+      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_T1 : TWIN_DMA_HDX_T3,
+	   priv->card_base + TWIN_DMA_CFG);
+    else
+      write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | WT_RDY_ENAB);
+    /* Write first byte(s) */
+    save_flags(flags);
+    cli();
+    for (i = 0; i < n; i++)
+      write_scc_data(priv, priv->tx_buf[priv->tx_tail][i], 1);
+    enable_dma(priv->param.dma);
+    restore_flags(flags);
+  } else {
+    write_scc(priv, R15, TxUIE);
+    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | TxINT_ENAB);
+    tx_isr(priv);
+  }
+  /* Reset EOM latch if we do not have the AUTOEOM feature */
+  if (priv->chip == Z8530) write_scc(priv, R0, RES_EOM_L);
+}
+
+
+static inline void rx_on(struct scc_priv *priv) {
+  unsigned long flags;
+
+  /* Clear RX FIFO */
+  while (read_scc(priv, R0) & Rx_CH_AV) read_scc_data(priv);
+  priv->rx_over = 0;
+  if (priv->param.dma >= 0) {
+    /* Program DMA controller */
+    flags = claim_dma_lock();
+    set_dma_mode(priv->param.dma, DMA_MODE_READ);
+    set_dma_addr(priv->param.dma, (int) priv->rx_buf[priv->rx_head]);
+    set_dma_count(priv->param.dma, BUF_SIZE);
+    release_dma_lock(flags);
+    enable_dma(priv->param.dma);
+    /* Configure PackeTwin DMA */
+    if (priv->type == TYPE_TWIN) {
+      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_R1 : TWIN_DMA_HDX_R3,
+	   priv->card_base + TWIN_DMA_CFG);
+    }
+    /* Sp. cond. intr. only, ext int enable, RX DMA enable */
+    write_scc(priv, R1, EXT_INT_ENAB | INT_ERR_Rx |
+	      WT_RDY_RT | WT_FN_RDYFN | WT_RDY_ENAB);
+  } else {
+    /* Reset current frame */
+    priv->rx_ptr = 0;
+    /* Intr. on all Rx characters and Sp. cond., ext int enable */
+    write_scc(priv, R1, EXT_INT_ENAB | INT_ALL_Rx | WT_RDY_RT |
+	      WT_FN_RDYFN);
+  }
+  write_scc(priv, R0, ERR_RES);
+  write_scc(priv, R3, RxENABLE | Rx8 | RxCRC_ENAB);
+}
+
+
+static inline void rx_off(struct scc_priv *priv) {
+  /* Disable receiver */
+  write_scc(priv, R3, Rx8);
+  /* Disable DREQ / RX interrupt */
+  if (priv->param.dma >= 0 && priv->type == TYPE_TWIN)
+    outb(0, priv->card_base + TWIN_DMA_CFG);
+  else
+    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN);
+  /* Disable DMA */
+  if (priv->param.dma >= 0) disable_dma(priv->param.dma);
+}
+
+
 static void es_isr(struct scc_priv *priv) {
   int i, rr0, drr0, res;
   unsigned long flags;
@@ -1301,90 +1391,6 @@
 }
 
 
-static inline void tx_on(struct scc_priv *priv) {
-  int i, n;
-  unsigned long flags;
-
-  if (priv->param.dma >= 0) {
-    n = (priv->chip == Z85230) ? 3 : 1;
-    /* Program DMA controller */
-    flags = claim_dma_lock();
-    set_dma_mode(priv->param.dma, DMA_MODE_WRITE);
-    set_dma_addr(priv->param.dma, (int) priv->tx_buf[priv->tx_tail]+n);
-    set_dma_count(priv->param.dma, priv->tx_len[priv->tx_tail]-n);
-    release_dma_lock(flags);
-    /* Enable TX underrun interrupt */
-    write_scc(priv, R15, TxUIE);
-    /* Configure DREQ */
-    if (priv->type == TYPE_TWIN)
-      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_T1 : TWIN_DMA_HDX_T3,
-	   priv->card_base + TWIN_DMA_CFG);
-    else
-      write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | WT_RDY_ENAB);
-    /* Write first byte(s) */
-    save_flags(flags);
-    cli();
-    for (i = 0; i < n; i++)
-      write_scc_data(priv, priv->tx_buf[priv->tx_tail][i], 1);
-    enable_dma(priv->param.dma);
-    restore_flags(flags);
-  } else {
-    write_scc(priv, R15, TxUIE);
-    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN | TxINT_ENAB);
-    tx_isr(priv);
-  }
-  /* Reset EOM latch if we do not have the AUTOEOM feature */
-  if (priv->chip == Z8530) write_scc(priv, R0, RES_EOM_L);
-}
-
-
-static inline void rx_on(struct scc_priv *priv) {
-  unsigned long flags;
-
-  /* Clear RX FIFO */
-  while (read_scc(priv, R0) & Rx_CH_AV) read_scc_data(priv);
-  priv->rx_over = 0;
-  if (priv->param.dma >= 0) {
-    /* Program DMA controller */
-    flags = claim_dma_lock();
-    set_dma_mode(priv->param.dma, DMA_MODE_READ);
-    set_dma_addr(priv->param.dma, (int) priv->rx_buf[priv->rx_head]);
-    set_dma_count(priv->param.dma, BUF_SIZE);
-    release_dma_lock(flags);
-    enable_dma(priv->param.dma);
-    /* Configure PackeTwin DMA */
-    if (priv->type == TYPE_TWIN) {
-      outb((priv->param.dma == 1) ? TWIN_DMA_HDX_R1 : TWIN_DMA_HDX_R3,
-	   priv->card_base + TWIN_DMA_CFG);
-    }
-    /* Sp. cond. intr. only, ext int enable, RX DMA enable */
-    write_scc(priv, R1, EXT_INT_ENAB | INT_ERR_Rx |
-	      WT_RDY_RT | WT_FN_RDYFN | WT_RDY_ENAB);
-  } else {
-    /* Reset current frame */
-    priv->rx_ptr = 0;
-    /* Intr. on all Rx characters and Sp. cond., ext int enable */
-    write_scc(priv, R1, EXT_INT_ENAB | INT_ALL_Rx | WT_RDY_RT |
-	      WT_FN_RDYFN);
-  }
-  write_scc(priv, R0, ERR_RES);
-  write_scc(priv, R3, RxENABLE | Rx8 | RxCRC_ENAB);
-}
-
-
-static inline void rx_off(struct scc_priv *priv) {
-  /* Disable receiver */
-  write_scc(priv, R3, Rx8);
-  /* Disable DREQ / RX interrupt */
-  if (priv->param.dma >= 0 && priv->type == TYPE_TWIN)
-    outb(0, priv->card_base + TWIN_DMA_CFG);
-  else
-    write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN);
-  /* Disable DMA */
-  if (priv->param.dma >= 0) disable_dma(priv->param.dma);
-}
-
-
 static void start_timer(struct scc_priv *priv, int t, int r15) {
   unsigned long flags;
 
@@ -1404,10 +1410,3 @@
   }
 }
 
-
-static inline unsigned char random(void) {
-  /* See "Numerical Recipes in C", second edition, p. 284 */
-  rand = rand * 1664525L + 1013904223L;
-  return (unsigned char) (rand >> 24);
-}
-

--------------030203050403000304060605--
