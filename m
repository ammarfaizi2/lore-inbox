Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130305AbQKFIG6>; Mon, 6 Nov 2000 03:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQKFIGh>; Mon, 6 Nov 2000 03:06:37 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:58638 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130261AbQKFIG0>; Mon, 6 Nov 2000 03:06:26 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A065867.6902473D@yahoo.com>
Date: Mon, 06 Nov 2000 02:06:15 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.17 i486)
MIME-Version: 1.0
To: Jorge Nerin <comandante@zaralinux.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SMP Mailing List <linux-smp@vger.kernel.org>
Subject: Re: ping -f kills ne2k (was:[patch] NE2000)
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com> <39FFE612.2688A5AD@yahoo.com> <3A02F9AA.AFB2DB1B@zaralinux.com>
Content-Type: multipart/mixed; boundary="------------11AC5FDD575C16814DA592CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--------------11AC5FDD575C16814DA592CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> Well, I have tried it with 2.4.0-test10, both SMP and non-SMP, and the
> result is a little confusing.
> 
> Under SMP a ping -s 50000 -f other_host takes down the network access
> with no messages (ne2k-pci), and no possibility of being restored
> without a reboot.
> 
> Under UP the same command works ok, but after a while the dots stop for
> 30sec, then ping prints an 'E' and the dots continue. strace revealed
> this:

Another suggestion - if you have your heart set on using ping
as your network stress tool, you may want to try using multiple
instances of MTU sized pings versus  a single "ping -s 50000".
In this way you aren't involving any IP frag code and its associated
bean counting - giving us one less factor to consider.

Oh, and since you get a silent failure, maybe you would be interested
in testing this patch I was (originally) saving for 2.5.x. -- It adds
watchdog transmit timeout functionality to 8390.c (which is used by
the ne2k-pci driver).  Last time I updated it was a couple of months
ago, but nothing has changed since then.

Paul.

--------------11AC5FDD575C16814DA592CA
Content-Type: text/plain; charset=us-ascii; name="2400-t5-8390-diff0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="2400-t5-8390-diff0"

--- linux~/drivers/net/8390.c	Fri Jul  7 03:45:36 2000
+++ linux/drivers/net/8390.c	Sat Jul 22 04:56:51 2000
@@ -38,6 +38,7 @@
   Paul Gortmaker	: add kmod support for auto-loading of the 8390
 			  module by all drivers that require it.
   Alan Cox		: Spinlocking work, added 'BUG_83C690'
+  Paul Gortmaker	: Separate out Tx timeout code from Tx path.
 
   Sources:
   The National Semiconductor LAN Databook, and the 3Com 3c503 databook.
@@ -105,6 +106,7 @@
 /* Index to functions. */
 static void ei_tx_intr(struct net_device *dev);
 static void ei_tx_err(struct net_device *dev);
+static void ei_tx_timeout(struct net_device *dev);
 static void ei_receive(struct net_device *dev);
 static void ei_rx_overrun(struct net_device *dev);
 
@@ -161,6 +163,13 @@
 		printk(KERN_EMERG "%s: ei_open passed a non-existent device!\n", dev->name);
 		return -ENXIO;
 	}
+	
+	/* The card I/O part of the driver (e.g. 3c503) can hook a Tx timeout
+	    wrapper that does e.g. media check & then calls ei_tx_timeout. */
+	if (dev->tx_timeout == NULL)
+		 dev->tx_timeout = ei_tx_timeout;
+	if (dev->watchdog_timeo <= 0)
+		 dev->watchdog_timeo = TX_TIMEOUT;
     
 	/*
 	 *	Grab the page lock so we own the register set, then call
@@ -200,89 +209,66 @@
 }
 
 /**
- * ei_start_xmit - begin packet transmission
- * @skb: packet to be sent
- * @dev: network device to which packet is sent
+ * ei_tx_timeout - handle transmit time out condition
+ * @dev: network device which has apparently fallen asleep
  *
- * Sends a packet to an 8390 network device.
+ * Called by kernel when device never acknowledges a transmit has
+ * completed (or failed) - i.e. never posted a Tx related interrupt.
  */
- 
-static int ei_start_xmit(struct sk_buff *skb, struct net_device *dev)
+
+void ei_tx_timeout(struct net_device *dev)
 {
 	long e8390_base = dev->base_addr;
 	struct ei_device *ei_local = (struct ei_device *) dev->priv;
-	int length, send_length, output_page;
+	int txsr, isr, tickssofar = jiffies - dev->trans_start;
 	unsigned long flags;
 
-	/*
-	 *  If it has been too long since the last Tx, we assume the
-	 *  board has died and kick it.
-	 */
- 
-	if (netif_queue_stopped(dev)) {
-		/* Do timeouts, just like the 8003 driver. */
-		int txsr;
-		int isr;
-		int tickssofar = jiffies - dev->trans_start;
-
-		/*
-		 *	Need the page lock. Now see what went wrong. This bit is
-		 *	fast.
-		 */
-		 		
-		spin_lock_irqsave(&ei_local->page_lock, flags);
-		txsr = inb(e8390_base+EN0_TSR);
-		if (tickssofar < TX_TIMEOUT ||	(tickssofar < (TX_TIMEOUT+5) && ! (txsr & ENTSR_PTX))) 
-		{
-			spin_unlock_irqrestore(&ei_local->page_lock, flags);
-			return 1;
-		}
-
-		ei_local->stat.tx_errors++;
-		isr = inb(e8390_base+EN0_ISR);
-		if (!netif_running(dev)) {
-			spin_unlock_irqrestore(&ei_local->page_lock, flags);
-			printk(KERN_WARNING "%s: xmit on stopped card\n", dev->name);
-			return 1;
-		}
-
-		/*
-		 * Note that if the Tx posted a TX_ERR interrupt, then the
-		 * error will have been handled from the interrupt handler
-		 * and not here. Error statistics are handled there as well.
-		 */
+	ei_local->stat.tx_errors++;
 
-		printk(KERN_DEBUG "%s: Tx timed out, %s TSR=%#2x, ISR=%#2x, t=%d.\n",
-			dev->name, (txsr & ENTSR_ABT) ? "excess collisions." :
-			(isr) ? "lost interrupt?" : "cable problem?", txsr, isr, tickssofar);
+	spin_lock_irqsave(&ei_local->page_lock, flags);
+	txsr = inb(e8390_base+EN0_TSR);
+	isr = inb(e8390_base+EN0_ISR);
+	spin_unlock_irqrestore(&ei_local->page_lock, flags);
 
-		if (!isr && !ei_local->stat.tx_packets) 
-		{
-			/* The 8390 probably hasn't gotten on the cable yet. */
-			ei_local->interface_num ^= 1;   /* Try a different xcvr.  */
-		}
+	printk(KERN_DEBUG "%s: Tx timed out, %s TSR=%#2x, ISR=%#2x, t=%d.\n",
+		dev->name, (txsr & ENTSR_ABT) ? "excess collisions." :
+		(isr) ? "lost interrupt?" : "cable problem?", txsr, isr, tickssofar);
 
-		/*
-		 *	Play shuffle the locks, a reset on some chips takes a few
-		 *	mS. We very rarely hit this point.
-		 */
-		 
-		spin_unlock_irqrestore(&ei_local->page_lock, flags);
+	if (!isr && !ei_local->stat.tx_packets) 
+	{
+		/* The 8390 probably hasn't gotten on the cable yet. */
+		ei_local->interface_num ^= 1;   /* Try a different xcvr.  */
+	}
 
-		/* Ugly but a reset can be slow, yet must be protected */
+	/* Ugly but a reset can be slow, yet must be protected */
 		
-		disable_irq_nosync(dev->irq);
-		spin_lock(&ei_local->page_lock);
+	disable_irq_nosync(dev->irq);
+	spin_lock(&ei_local->page_lock);
 		
-		/* Try to restart the card.  Perhaps the user has fixed something. */
-		ei_reset_8390(dev);
-		NS8390_init(dev, 1);
+	/* Try to restart the card.  Perhaps the user has fixed something. */
+	ei_reset_8390(dev);
+	NS8390_init(dev, 1);
 		
-		spin_unlock(&ei_local->page_lock);
-		enable_irq(dev->irq);
-		dev->trans_start = jiffies;
-	}
+	spin_unlock(&ei_local->page_lock);
+	enable_irq(dev->irq);
+	netif_wake_queue(dev);
+}
     
+/**
+ * ei_start_xmit - begin packet transmission
+ * @skb: packet to be sent
+ * @dev: network device to which packet is sent
+ *
+ * Sends a packet to an 8390 network device.
+ */
+ 
+static int ei_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	long e8390_base = dev->base_addr;
+	struct ei_device *ei_local = (struct ei_device *) dev->priv;
+	int length, send_length, output_page;
+	unsigned long flags;
+
 	length = skb->len;
 
 	/* Mask interrupts from the ethercard. 
@@ -1147,6 +1133,7 @@
 EXPORT_SYMBOL(ei_open);
 EXPORT_SYMBOL(ei_close);
 EXPORT_SYMBOL(ei_interrupt);
+EXPORT_SYMBOL(ei_tx_timeout);
 EXPORT_SYMBOL(ethdev_init);
 EXPORT_SYMBOL(NS8390_init);
 

--------------11AC5FDD575C16814DA592CA--




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
