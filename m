Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbUAAUsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUAAUrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:47:36 -0500
Received: from havoc.gtf.org ([63.247.75.124]:23998 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264855AbUAAUo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:44:26 -0500
Date: Thu, 1 Jan 2004 15:44:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 357] Mac89x0 Ethernet
Message-ID: <20040101204405.GA13922@gtf.org>
References: <200401012001.i01K1vlY031781@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401012001.i01K1vlY031781@callisto.of.borg>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 09:01:57PM +0100, Geert Uytterhoeven wrote:
> Macintosh CS89x0 Ethernet: Netif updates (from Matthias Urlichs)
> 
> --- linux-2.6.0/drivers/net/Kconfig	Sun Oct 19 10:45:04 2003
> +++ linux-m68k-2.6.0/drivers/net/Kconfig	Mon Oct 20 21:39:36 2003
> @@ -318,7 +318,7 @@
>  
>  config MAC89x0
>  	tristate "Macintosh CS89x0 based ethernet cards"
> -	depends on NETDEVICES && MAC && BROKEN
> +	depends on NETDEVICES && MAC
>  	---help---
>  	  Support for CS89x0 chipset based Ethernet cards.  If you have a
>  	  Nubus or LC-PDS network (Ethernet) card of this type, say Y and
> --- linux-2.6.0/drivers/net/mac89x0.c	Mon May  5 10:31:32 2003
> +++ linux-m68k-2.6.0/drivers/net/mac89x0.c	Mon Oct 20 21:34:24 2003
> @@ -128,7 +128,7 @@
>  extern void reset_chip(struct net_device *dev);
>  #endif
>  static int net_open(struct net_device *dev);
> -static int	net_send_packet(struct sk_buff *skb, struct net_device *dev);
> +static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
>  static irqreturn_t net_interrupt(int irq, void *dev_id, struct pt_regs *regs);
>  static void set_multicast_list(struct net_device *dev);
>  static void net_rx(struct net_device *dev);
> @@ -367,56 +367,37 @@
>  static int
>  net_send_packet(struct sk_buff *skb, struct net_device *dev)
>  {
> -	if (dev->tbusy) {
> -		/* If we get here, some higher level has decided we are broken.
> -		   There should really be a "kick me" function call instead. */
> -		int tickssofar = jiffies - dev->trans_start;
> -		if (tickssofar < 5)
> -			return 1;
> -		if (net_debug > 0) printk("%s: transmit timed out, %s?\n", dev->name,
> -			   tx_done(dev) ? "IRQ conflict" : "network cable problem");
> -		/* Try to restart the adaptor. */
> -		dev->tbusy=0;
> -		dev->trans_start = jiffies;
> -	}
> -
> -	/* Block a timer-based transmit from overlapping.  This could better be
> -	   done with atomic_swap(1, dev->tbusy), but set_bit() works as well. */
> -	if (test_and_set_bit(0, (void*)&dev->tbusy) != 0)
> -		printk("%s: Transmitter access conflict.\n", dev->name);
> -	else {
> -		struct net_local *lp = (struct net_local *)dev->priv;
> -		unsigned long flags;
> -
> -		if (net_debug > 3)
> -			printk("%s: sent %d byte packet of type %x\n",
> -			       dev->name, skb->len,
> -			       (skb->data[ETH_ALEN+ETH_ALEN] << 8)
> -			       | skb->data[ETH_ALEN+ETH_ALEN+1]);
> -
> -		/* keep the upload from being interrupted, since we
> -                   ask the chip to start transmitting before the
> -                   whole packet has been completely uploaded. */
> -		local_irq_save(flags);
> -
> -		/* initiate a transmit sequence */
> -		writereg(dev, PP_TxCMD, lp->send_cmd);
> -		writereg(dev, PP_TxLength, skb->len);
> -
> -		/* Test to see if the chip has allocated memory for the packet */
> -		if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
> -			/* Gasp!  It hasn't.  But that shouldn't happen since
> -			   we're waiting for TxOk, so return 1 and requeue this packet. */
> -			local_irq_restore(flags);
> -			return 1;
> -		}
> +	struct net_local *lp = (struct net_local *)dev->priv;
> +	unsigned long flags;
>  
> -		/* Write the contents of the packet */
> -		memcpy_toio(dev->mem_start + PP_TxFrame, skb->data, skb->len+1);
> +	if (net_debug > 3)
> +		printk("%s: sent %d byte packet of type %x\n",
> +		       dev->name, skb->len,
> +		       (skb->data[ETH_ALEN+ETH_ALEN] << 8)
> +		       | skb->data[ETH_ALEN+ETH_ALEN+1]);
> +
> +	/* keep the upload from being interrupted, since we
> +	   ask the chip to start transmitting before the
> +	   whole packet has been completely uploaded. */
> +	local_irq_save(flags);
>  
> +	/* initiate a transmit sequence */
> +	writereg(dev, PP_TxCMD, lp->send_cmd);
> +	writereg(dev, PP_TxLength, skb->len);
> +
> +	/* Test to see if the chip has allocated memory for the packet */
> +	if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
> +		/* Gasp!  It hasn't.  But that shouldn't happen since
> +		   we're waiting for TxOk, so return 1 and requeue this packet. */
>  		local_irq_restore(flags);
> -		dev->trans_start = jiffies;
> +		return 1;
>  	}

I know the code was present before your change... but...  this is very
wrong.  Returning 1 only requeues the packet depending on the packet
scheduler.  Other times the packet is simply dropped...  So the above
assumption is incorrect.

If the NIC only has enough room for N maximally-sized packets (possibly
N==1, even), then the driver should netif_stop_queue() after that
capacity is reached, and netif_wake_queue() after the interrupt handler
signals completion.


> +	/* Write the contents of the packet */
> +	memcpy((void *)(dev->mem_start + PP_TxFrame), skb->data, skb->len+1);

Is dev->mem_start DMA memory?

The rest of the patch looks OK.

	Jeff



