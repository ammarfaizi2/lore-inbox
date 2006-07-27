Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWG0I2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWG0I2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWG0I2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:28:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48318 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750773AbWG0I2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:28:15 -0400
Subject: Re: [PATCH] Create IP100A Driver
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154029172.5967.8.camel@localhost.localdomain>
References: <1154029172.5967.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 27 Jul 2006 10:28:10 +0200
Message-Id: <1153988890.3039.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 15:39 -0400, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> This is the first version of IP100A Linux Driver.

Hi,

we appreciate your efforts in making a Linux driver a lot!
I assume you are familiar with the process a bit; if not; a few of us
will do a code review of the driver. The goal is just to avoid common
mistakes and to assure a sort of consistent look/feel of the code with
the rest of the kernel. These comments are not a reflection of you not
doing something good, but please see them as suggestions for improving
even further.

> 
> 
>  drivers/net/ipf.c | 1378
> +++++++++++++++++++++++++++++++++++++++++++++++++++++

your email program has wrapped the longer lines of your email. I see
that you are using Evolution; I use evolution as well and what works for
me to avoid this problem is to set the text to "preformat". You can do
this by clicking on the "Normal" box in the area just above the place
where you type your email text; it will show a series of settings,
preformat will be one of them. When you pick that the patch will come
through undamaged.
(it's not a big deal for review but for merging it into the tree it is a
problem; the patch program cannot deal with line wrapped emails)

>  drivers/net/ipf.h |  267 ++++++++++
>  2 files changed, 1644 insertions(+), 1 deletions(-)
> 
> 5e4c20f6799411d9262fc281b5ab1834c85c532a
> diff --git a/drivers/net/ipf.c b/drivers/net/ipf.c
> index 8b13789..6e610bd 100644
> --- a/drivers/net/ipf.c
> +++ b/drivers/net/ipf.c

what would you think of calling your driver ip100a.c instead of ipf.c?
> \

> +/* Work-around for Kendin chip bugs. */
> +#define CONFIG_SUNDANCE_MMIO		// use MMIO
> +#ifndef CONFIG_SUNDANCE_MMIO
> +#define USE_IO_OPS 1
> +#endif

is this relevant for your driver as well?
> +
> +#ifndef __KERNEL__
> +#define __KERNEL__
> +#endif

this is not needed at all, __KERNEL__ is always set; it's better to
remove this, it's redundant and looks strange

> +#if !defined(__OPTIMIZE__)
> +#warning  You must compile this file with the correct options!
> +#warning  See the last lines of the source file.
> +#error You must compile this driver with "-O".
> +#endif

same for this


> I/O (MDIO) interfaces. */
> +static int __devinit eeprom_read(void __iomem * ioaddr, int location)
> +{
> +	int boguscnt = 1000;		/* Typical 190 ticks. */
> +	iowr16(0x0200 | (location & 0xff), ioaddr + EECtrl);
> +	do {
> +		if (! (iord16(ioaddr + EECtrl) & 0x8000)) {
> +			return iord16(ioaddr + EEData);
> +		}

do you want some sort of timeout for this? This would be an infinite
hang if the hardware ever does weird things

> +static int change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	if ((new_mtu < 68) || (new_mtu > 8191)) /* Set by RxDMAFrameLen */
> +		return -EINVAL;

I think the network layer already checks 68, but it's no problem to be
double sure


> +static struct ethtool_ops ipf_ethtool_ops = {
> +	.get_settings = ipf_get_settings,
> +	.set_settings = ipf_set_settings,
> +	.nway_reset   = ipf_nway_reset,
> +};

you probably want a few more ethtool_ops; at least the "get driver info"
one is used by userspace distribution installation programs




> +static int reset_tx (struct net_device *dev)
> +{
> +	struct netdev_private *np = (struct netdev_private*) dev->priv;
> +	void __iomem * ioaddr = ipf_ioaddr(dev);
> +	struct sk_buff *skb;
> +	int i;
> +	int irq = in_interrupt();

this sets of warning lights for me; in_interrupt() very often doesn't do
what people think it does...
however you don't seem to use it in your driver so it might as well go
away

> \+	if (intr_status & IntrPCIErr) {
> +		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
> +			   dev->name, intr_status);
> +		/* We must do a global reset of DMA to continue. */
> +	}

the comment says you need to do something, but I don't see the code
doing that... is that correct?


> +static irqreturn_t intr_handler(int irq, void *dev_instance, struct
> pt_regs *rgs)
> +{
> +	struct net_device *dev = (struct net_device *)dev_instance;
> +	struct netdev_private *np=dev->priv;
> +	void __iomem * ioaddr = ipf_ioaddr(dev);
> +	int hw_frame_id;
> +	int tx_cnt;
> +	int tx_status;
> +    irqreturn_t intr_handled=IRQ_HANDLED;//IRQ_NONE;

this looks like you return IRQ_HANDLED even when the hardware didn't
have any work for you; that's not a good idea, you really ought to only
return that if you did work, and use IRQ_NONE otherwise.
> +					if (tx_status & 0x1e) {
> +					/* It could fail to restart the tx when MaxCollions, need to try
> more times */
> +						int i = 10;
> +						do {
> +							iowr16 (iord16(ioaddr + MACCtrl1) | TxEnable, ioaddr +
> MACCtrl1);
> +							if (iord16(ioaddr + MACCtrl1) & TxEnabled) break;
> +							mdelay(1);

are you really sure you want to do mdelay() in interrupt context?
Especially if you do it 10 times that will give a HUGE latency


> +static int netdev_open(struct net_device *dev)
> +{
> +	struct netdev_private *np = dev->priv;
> +	void __iomem * ioaddr = ipf_ioaddr(dev);
> +	int i;
> +
> +   for(i=0;i<10;i++)
> +   {
> +   	if(np->ProbeDone==1)break;//For Mandrake10.x multi-cpu
> +   	mdelay(1000);
> +   }

ouch! what is this about?

> +	// 04/19/2005 Jesse fix for complete initial step
> +	spin_lock(&np->lock);

this lock is used in the IRQ handler, right? you really want to use
spin_lock_irq or spin_lock_irqsave then!
> +static void tx_timeout(struct net_device *dev)
> +{
> +	struct netdev_private *np = dev->priv;
> +	void __iomem * ioaddr = ipf_ioaddr(dev);
> +	ULONG  flag;

please do not use ULONG but just use "unsigned long"

> +	/* Increment cur_tx before tasklet_schedule() */
> +	np->cur_tx++;
> +	mb();

would this need an atomic increment?


> +
> +    for(i=2000;i> 0;i--) {
> +		if((iord32(ioaddr + DMACtrl)&0xC000) == 0)break;
> +		mdelay(1);
> +    }

you really do like mdelay :)
it's however quite evil since it is busy wait.... you may want to
investigate using msleep() instead in the places that you can sleep
> +   //20040817Jesse_ChangeSpeed: Add
> +   for(i=1000;i;i--)
> +   {
> +	   mdelay(1);
> +      if(mdio_read(dev,np->phys[0],MII_BMSR)&0x20)break;
> +   }

and another one of these ;)


> +/* when a module, this is printed whether or not devices are found in
> probe */
> +#ifdef MODULE
> +	printk(version);
> +#endif

hmm such ifdef is uncommon

> +	INT  msg_enable;
> +	UINT cur_rx, dirty_rx;		/* Producer/consumer ring indices */
> +	UINT rx_buf_sz;			/* Based on MTU+slack. */
> +	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
> +	UINT cur_tx, dirty_tx;

please use linux natural types (eg "int" and "unsigned int") rather than
such defines.\

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

