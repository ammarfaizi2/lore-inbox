Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUG2OEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUG2OEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUG2OEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:04:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45564 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264677AbUG2OET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:04:19 -0400
Date: Thu, 29 Jul 2004 16:04:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: erik@vt.edu, Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.6 patch] net/smc9194.c: fix inline compile errors (fwd)
Message-ID: <20040729140413.GT2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Wed, 14 Jul 2004 23:11:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: erik@vt.edu
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
Subject: [2.6 patch] net/smc9194.c: fix inline compile errors

Trying to compile drivers/net/smc9194.c in 2.6.8-rc1-mm1 with gcc 3.4 
results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/net/smc9194.o
drivers/net/smc9194.c: In function `smc_interrupt':
drivers/net/smc9194.c:278: sorry, unimplemented: inlining failed in call 
to 'smc_rcv': function body not available
drivers/net/smc9194.c:1254: sorry, unimplemented: called from here
drivers/net/smc9194.c:283: sorry, unimplemented: inlining failed in call 
to 'smc_tx': function body not available
drivers/net/smc9194.c:1258: sorry, unimplemented: called from here
make[2]: *** [drivers/net/smc9194.o] Error 1

<--  snip  -->


The patch below moves some inlined functions above the place where they
are called the first time.

An alternative approach would be to remove the inlines.


diffstat output:
 drivers/net/smc9194.c |  255 +++++++++++++++++++++---------------------
 1 files changed, 128 insertions(+), 127 deletions(-)



Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/net/smc9194.c.old	2004-07-09 00:39:05.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/net/smc9194.c	2004-07-09 00:47:01.000000000 +0200
@@ -1191,133 +1191,6 @@
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
-static irqreturn_t smc_interrupt(int irq, void * dev_id,  struct pt_regs * regs)
-{
-	struct net_device *dev 	= dev_id;
-	int ioaddr 		= dev->base_addr;
-	struct smc_local *lp = netdev_priv(dev);
-
-	byte	status;
-	word	card_stats;
-	byte	mask;
-	int	timeout;
-	/* state registers */
-	word	saved_bank;
-	word	saved_pointer;
-	int handled = 0;
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
-		handled = 1;
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
-	return IRQ_RETVAL(handled);
-}
-
 /*-------------------------------------------------------------
  .
  . smc_rcv -  receive a packet from the card
@@ -1509,6 +1381,134 @@
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
+static irqreturn_t smc_interrupt(int irq, void * dev_id,  struct pt_regs * regs)
+{
+	struct net_device *dev 	= dev_id;
+	int ioaddr 		= dev->base_addr;
+	struct smc_local *lp = netdev_priv(dev);
+
+	byte	status;
+	word	card_stats;
+	byte	mask;
+	int	timeout;
+	/* state registers */
+	word	saved_bank;
+	word	saved_pointer;
+	int handled = 0;
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
+		handled = 1;
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
+	return IRQ_RETVAL(handled);
+}
+
+
 /*----------------------------------------------------
  . smc_close
  .

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


