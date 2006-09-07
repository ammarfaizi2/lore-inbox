Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWIGJUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWIGJUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWIGJUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:20:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37295 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751360AbWIGJUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:20:40 -0400
Subject: Re: [PATCH 2.6.18-rc6 1/2] dllink driver: porting v1.19 to linux
	2.6.18-rc6
From: Arjan van de Ven <arjan@infradead.org>
To: Hayim Shaul <hayim@iportent.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org
In-Reply-To: <1157620189.2904.16.camel@localhost.localdomain>
References: <1157620189.2904.16.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 07 Sep 2006 11:19:55 +0200
Message-Id: <1157620795.14882.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -335,8 +374,9 @@
>  #endif
>  	/* Read eeprom */
>  	for (i = 0; i < 128; i++) {
> -		((u16 *) sromdata)[i] = le16_to_cpu (read_eeprom (ioaddr, i));
> +		((u16 *) sromdata)[i] = cpu_to_le16 (read_eeprom (ioaddr, i));
>  	}
> +	psrom->crc = le32_to_cpu(psrom->crc);

this looks wrong, the data comes from the hw as le, so le*_to_cpu()
sounds the right direction

> @@ -401,7 +441,7 @@
>  	int i;
>  	u16 macctrl;
>  	
> -	i = request_irq (dev->irq, &rio_interrupt, IRQF_SHARED, dev->name, dev);
> +	i = request_irq (dev->irq, &rio_interrupt, SA_SHIRQ, dev->name, dev);
>  	if (i)
>  		return i;

this is backing out a fix/conversion to the new API. Bad.


>  	
> @@ -434,9 +474,12 @@
>  	writeb (0x30, ioaddr + RxDMABurstThresh);
>  	writeb (0x30, ioaddr + RxDMAUrgentThresh);
>  	writel (0x0007ffff, ioaddr + RmonStatMask);
> +
>  	/* clear statistics */
>  	clear_stats (dev);
>  
> +	atomic_set(&np->tx_desc_lock, 0);

I'm quite scared by this naming; it suggests home-brew locking

>  	dev->trans_start = jiffies;
> +	tasklet_enable(&np->tx_tasklet);
> +	writew(DEFAULT_INTR, ioaddr + IntEnable);
> +	return;

this looks like a PCI posting bug


> -rio_free_tx (struct net_device *dev, int irq) 
> +rio_free_tx (struct net_device *dev) 
>  {
>  	struct netdev_private *np = netdev_priv(dev);
>  	int entry = np->old_tx % TX_RING_SIZE;
> -	int tx_use = 0;
>  	unsigned long flag = 0;
> +	int irq = in_interrupt();

eeeeep

> +
> +	if (atomic_read(&np->tx_desc_lock))
> +		return;
> +	atomic_inc(&np->tx_desc_lock);

and yes.. it is broken self made locking....
there is a nice race between the _read and the _inc here.


>  	
>  	if (irq)
>  		spin_lock(&np->tx_lock);
>  	else
>  		spin_lock_irqsave(&np->tx_lock, flag);

double eeeep

this is wrong to do with in_interrupt() as gating factor!
Always doing the irqsave() is fine btw



