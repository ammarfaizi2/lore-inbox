Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWHRL1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWHRL1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWHRL1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:27:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26840 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932426AbWHRL1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:27:36 -0400
Message-ID: <44E5A425.8020200@pobox.com>
Date: Fri, 18 Aug 2006 07:27:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/6] IP100A Fix Tx pause bug
References: <1155841445.4532.10.camel@localhost.localdomain>
In-Reply-To: <1155841445.4532.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> @@ -1099,6 +1099,10 @@ reset_tx (struct net_device *dev)
>  	}
>  	np->cur_tx = np->dirty_tx = 0;
>  	np->cur_task = 0;
> +	
> +	np->last_tx=0;

add whitespace, to make it look like all other assignments:
s/=/ = /


> +	iowrite8(127, ioaddr + TxDMAPollPeriod);	
> +	

what does the value 127 represent?


>  	iowrite16 (StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);
>  	return 0;
>  }
> @@ -1156,29 +1160,29 @@ static irqreturn_t intr_handler(int irq,
>  						np->stats.tx_fifo_errors++;
>  					if (tx_status & 0x02)
>  						np->stats.tx_window_errors++;
> -					/*
> -					** This reset has been verified on
> -					** DFE-580TX boards ! phdm@macqel.be.
> -					*/
> -					if (tx_status & 0x10) {	/* TxUnderrun */
> -						unsigned short txthreshold;
> -
> -						txthreshold = ioread16 (ioaddr + TxStartThresh);
> -						/* Restart Tx FIFO and transmitter */
> -						sundance_reset(dev, (NetworkReset|FIFOReset|TxReset) << 16);
> -						iowrite16 (txthreshold, ioaddr + TxStartThresh);
> -						/* No need to reset the Tx pointer here */
> +
> +					/* FIFO ERROR need to be reset tx */
> +					if (tx_status & 0x10) {	/* Reset the Tx. */
> +						spin_lock(&np->lock);
> +						reset_tx(dev);
> +						spin_unlock(&np->lock);
> +					}
> +					if (tx_status & 0x1e) {
> +					/* need to make sure tx enabled */
> +						int i = 10;
> +						do {
> +							iowrite16 (ioread16(ioaddr + MACCtrl1) | TxEnable, ioaddr + MACCtrl1);
> +							if (ioread16(ioaddr + MACCtrl1) & TxEnabled)
> +								break;
> +							mdelay(1);
> +						} while (--i);
>  					}
> -					/* Restart the Tx. */
> -					iowrite16 (TxEnable, ioaddr + MACCtrl1);
>  				}
> -				/* Yup, this is a documentation bug.  It cost me *hours*. */
> +				
>  				iowrite16 (0, ioaddr + TxStatus);
> -				if (tx_cnt < 0) {
> -					iowrite32(5000, ioaddr + DownCounter);
> -					break;
> -				}
>  				tx_status = ioread16 (ioaddr + TxStatus);
> +				if (tx_cnt < 0)
> +					break;
>  			}
>  			hw_frame_id = (tx_status >> 8) & 0xff;
>  		} else 	{
> @@ -1244,6 +1248,9 @@ static irqreturn_t intr_handler(int irq,
>  	if (netif_msg_intr(np))
>  		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
>  			   dev->name, ioread16(ioaddr + IntrStatus));
> +			   
> +	iowrite32(5000, ioaddr + DownCounter); 
> +				   
>  	return IRQ_RETVAL(handled);

DownCounter should not be written unconditionally.  Consider shared 
interrupts, where sundance performs no work, and handled==0.

	Jeff


