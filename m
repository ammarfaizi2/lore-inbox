Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282979AbRLDXR4>; Tue, 4 Dec 2001 18:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283579AbRLDXRr>; Tue, 4 Dec 2001 18:17:47 -0500
Received: from [206.98.161.198] ([206.98.161.198]:9488 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S282979AbRLDXRd>; Tue, 4 Dec 2001 18:17:33 -0500
Subject: Re: [PATCH] eepro100 - need testers
From: Edward Muller <emuller@learningpatterns.com>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
In-Reply-To: <3C0D54DF.4E897B70@sun.com>
In-Reply-To: <E167w6n-0001dz-00@fenrus.demon.nl>  <3C0D54DF.4E897B70@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 18:15:33 -0500
Message-Id: <1007507734.4621.21.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are the eepro100 issues? I have two machines with two eepro100's in
each machine.

I am running 2.4.16 on them and I've been testing nbd and the errors
that I have been having MAY be caused by the network going out (as per a
discussion on the ENBD list).

On Tue, 2001-12-04 at 17:57, Tim Hockin wrote:
> This patch was developed here to resolve a number of eepro100 issues we
> were seeing. I'd like to get people to try this on their eepro100 chips and
> beat on it for a while.
> 
> volunteers?
> 
> Tim
> -- 
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Cobalt Server Appliances
> thockin@sun.com
> ----
> 

> diff -ruN 2.4.14-orig/drivers/net/eepro100.c 2.4.14-cobalt/drivers/net/eepro100.c
> --- 2.4.14-orig/drivers/net/eepro100.c	Tue Dec  4 14:30:09 2001
> +++ 2.4.14-cobalt/drivers/net/eepro100.c	Tue Dec  4 14:03:35 2001
> @@ -64,8 +64,8 @@
>  
>  /* A few values that may be tweaked. */
>  /* The ring sizes should be a power of two for efficiency. */
> -#define TX_RING_SIZE	32
> -#define RX_RING_SIZE	32
> +#define TX_RING_SIZE	64
> +#define RX_RING_SIZE	1024
>  /* How much slots multicast filter setup may take.
>     Do not descrease without changing set_rx_mode() implementaion. */
>  #define TX_MULTICAST_SIZE   2
> @@ -1067,6 +1071,50 @@
>  	outw(CUStart | SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr + SCBCmd);
>  }
>  
> +/*
> + * Sometimes the receiver stops making progress.  This routine knows how to
> + * get it going again, without losing packets or being otherwise nasty like
> + * a chip reset would be.  Previously the driver had a whole sequence
> + * of if RxSuspended, if it's no buffers do one thing, if it's no resources,
> + * do another, etc.  But those things don't really matter.  Separate logic
> + * in the ISR provides for allocating buffers--the other half of operation
> + * is just making sure the receiver is active.  speedo_rx_soft_reset does that.
> + * This problem with the old, more involved algorithm is shown up under
> + * ping floods on the order of 60K packets/second on a 100Mbps fdx network.
> + */
> +static void
> +speedo_rx_soft_reset(struct net_device *dev)
> +{
> +	struct speedo_private *sp = dev->priv;
> +	struct RxFD *rfd;
> +	long ioaddr;
> +
> +	ioaddr = dev->base_addr;
> +	wait_for_cmd_done(ioaddr + SCBCmd);
> +	if (inb(ioaddr + SCBCmd) != 0) {
> +		printk("%s: previous command stalled\n", dev->name);
> +		return;
> +	}
> +	/*
> +	* Put the hardware into a known state.
> +	*/
> +	outb(RxAbort, ioaddr + SCBCmd);
> +
> +	rfd = sp->rx_ringp[sp->cur_rx % RX_RING_SIZE];
> +
> +	rfd->rx_buf_addr = 0xffffffff;
> +
> +	wait_for_cmd_done(ioaddr + SCBCmd);
> +
> +	if (inb(ioaddr + SCBCmd) != 0) {
> +		printk("%s: RxAbort command stalled\n", dev->name);
> +		return;
> +	}
> +	outl(sp->rx_ring_dma[sp->cur_rx % RX_RING_SIZE],
> +		ioaddr + SCBPointer);
> +	outb(RxStart, ioaddr + SCBCmd);
> +}
> +
>  /* Media monitoring and control. */
>  static void speedo_timer(unsigned long data)
>  {
> @@ -1500,82 +1591,37 @@
>  		if ((status & 0xfc00) == 0)
>  			break;
>  
> -		/* Always check if all rx buffers are allocated.  --SAW */
> -		speedo_refill_rx_buffers(dev, 0);
> -
>  		if ((status & 0x5000) ||	/* Packet received, or Rx error. */
>  			(sp->rx_ring_state&(RrNoMem|RrPostponed)) == RrPostponed)
>  									/* Need to gather the postponed packet. */
>  			speedo_rx(dev);
>  
> -		if (status & 0x1000) {
> -			spin_lock(&sp->lock);
> -			if ((status & 0x003c) == 0x0028) {		/* No more Rx buffers. */
> -				struct RxFD *rxf;
> -				printk(KERN_WARNING "%s: card reports no RX buffers.\n",
> -						dev->name);
> -				rxf = sp->rx_ringp[sp->cur_rx % RX_RING_SIZE];
> -				if (rxf == NULL) {
> -					if (speedo_debug > 2)
> -						printk(KERN_DEBUG
> -								"%s: NULL cur_rx in speedo_interrupt().\n",
> -								dev->name);
> -					sp->rx_ring_state |= RrNoMem|RrNoResources;
> -				} else if (rxf == sp->last_rxf) {
> -					if (speedo_debug > 2)
> -						printk(KERN_DEBUG
> -								"%s: cur_rx is last in speedo_interrupt().\n",
> -								dev->name);
> -					sp->rx_ring_state |= RrNoMem|RrNoResources;
> -				} else
> -					outb(RxResumeNoResources, ioaddr + SCBCmd);
> -			} else if ((status & 0x003c) == 0x0008) { /* No resources. */
> -				struct RxFD *rxf;
> -				printk(KERN_WARNING "%s: card reports no resources.\n",
> -						dev->name);
> -				rxf = sp->rx_ringp[sp->cur_rx % RX_RING_SIZE];
> -				if (rxf == NULL) {
> -					if (speedo_debug > 2)
> -						printk(KERN_DEBUG
> -								"%s: NULL cur_rx in speedo_interrupt().\n",
> -								dev->name);
> -					sp->rx_ring_state |= RrNoMem|RrNoResources;
> -				} else if (rxf == sp->last_rxf) {
> -					if (speedo_debug > 2)
> -						printk(KERN_DEBUG
> -								"%s: cur_rx is last in speedo_interrupt().\n",
> -								dev->name);
> -					sp->rx_ring_state |= RrNoMem|RrNoResources;
> -				} else {
> -					/* Restart the receiver. */
> -					outl(sp->rx_ring_dma[sp->cur_rx % RX_RING_SIZE],
> -						 ioaddr + SCBPointer);
> -					outb(RxStart, ioaddr + SCBCmd);
> -				}
> -			}
> -			sp->stats.rx_errors++;
> -			spin_unlock(&sp->lock);
> -		}
> +		/* Always check if all rx buffers are allocated.  --SAW */
> +		speedo_refill_rx_buffers(dev, 0);
>  
> -		if ((sp->rx_ring_state&(RrNoMem|RrNoResources)) == RrNoResources) {
> -			printk(KERN_WARNING
> -					"%s: restart the receiver after a possible hang.\n",
> -					dev->name);
> -			spin_lock(&sp->lock);
> -			/* Restart the receiver.
> -			   I'm not sure if it's always right to restart the receiver
> -			   here but I don't know another way to prevent receiver hangs.
> -			   1999/12/25 SAW */
> -			outl(sp->rx_ring_dma[sp->cur_rx % RX_RING_SIZE],
> -				 ioaddr + SCBPointer);
> -			outb(RxStart, ioaddr + SCBCmd);
> -			sp->rx_ring_state &= ~RrNoResources;
> -			spin_unlock(&sp->lock);
> +		spin_lock(&sp->lock);
> +		/*
> +		 * The chip may have suspended reception for various reasons.
> +		 * Check for that, and re-prime it should this be the case.
> +		 */
> +		switch ((status >> 2) & 0xf) {
> +		case 0: /* Idle */
> +			break;
> +		case 1:	/* Suspended */
> +		case 2:	/* No resources (RxFDs) */
> +		case 9:	/* Suspended with no more RBDs */
> +		case 10: /* No resources due to no RBDs */
> +		case 12: /* Ready with no RBDs */
> +			speedo_rx_soft_reset(dev);
> +			break;
> +		case 3:  case 5:  case 6:  case 7:  case 8:
> +		case 11:  case 13:  case 14:  case 15:
> +			/* these are all reserved values */
> +			break;
>  		}
>  
>  		/* User interrupt, Command/Tx unit interrupt or CU not active. */
>  		if (status & 0xA400) {
> -			spin_lock(&sp->lock);
>  			speedo_tx_buffer_gc(dev);
>  			if (sp->tx_full
>  				&& (int)(sp->cur_tx - sp->dirty_tx) < TX_QUEUE_UNFULL) {
> @@ -1583,8 +1629,8 @@
>  				sp->tx_full = 0;
>  				netif_wake_queue(dev); /* Attention: under a spinlock.  --SAW */
>  			}
> -			spin_unlock(&sp->lock);
>  		}
> +		spin_unlock(&sp->lock);
>  
>  		if (--boguscnt < 0) {
>  			printk(KERN_ERR "%s: Too much work at interrupt, status=0x%4.4x.\n",
> @@ -1702,6 +1748,7 @@
>  	int entry = sp->cur_rx % RX_RING_SIZE;
>  	int rx_work_limit = sp->dirty_rx + RX_RING_SIZE - sp->cur_rx;
>  	int alloc_ok = 1;
> +	int npkts = 0;
>  
>  	if (speedo_debug > 4)
>  		printk(KERN_DEBUG " In speedo_rx().\n");
> @@ -1768,6 +1815,7 @@
>  				memcpy(skb_put(skb, pkt_len), sp->rx_skbuff[entry]->tail,
>  					   pkt_len);
>  #endif
> +				npkts++;
>  			} else {
>  				/* Pass up the already-filled skbuff. */
>  				skb = sp->rx_skbuff[entry];
> @@ -1778,6 +1826,7 @@
>  				}
>  				sp->rx_skbuff[entry] = NULL;
>  				skb_put(skb, pkt_len);
> +				npkts++;
>  				sp->rx_ringp[entry] = NULL;
>  				pci_unmap_single(sp->pdev, sp->rx_ring_dma[entry],
>  						PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
> @@ -1798,7 +1847,8 @@
>  	/* Try hard to refill the recently taken buffers. */
>  	speedo_refill_rx_buffers(dev, 1);
>  
> -	sp->last_rx_time = jiffies;
> +	if (npkts)
> +		sp->last_rx_time = jiffies;
>  
>  	return 0;
>  }
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

