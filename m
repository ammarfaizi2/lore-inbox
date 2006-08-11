Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWHKJUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWHKJUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWHKJUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:20:50 -0400
Received: from web37915.mail.mud.yahoo.com ([209.191.91.177]:39542 "HELO
	web37915.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751006AbWHKJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:20:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=glOsPA55wqYJJ/9cGzJr7s9fnSHhlxN0y2PvCxU89A02q0v6OfN/kq3KQ2R/kNfBfTrvanfxyirrt3t45uaQWrnXu2TBIryOO7uDGgI+RyurvNTEjc+K0pH1P3oKXBS7hPUIO10M4tz7gl5luks1cyKwwOJoPsBpHpR1QisYTms=  ;
Message-ID: <20060811092045.67151.qmail@web37915.mail.mud.yahoo.com>
Date: Fri, 11 Aug 2006 02:20:45 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [irda-users] [PATCH] OMAP: Add support for IrDA driver
To: Samuel Ortiz <samuel@sortiz.org>
Cc: akpm@osdl.org, samuel@sortiz.org, tony@atomide.com,
       linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net,
       r-woodruff2@ti.com
In-Reply-To: <20060811054756.GA14621@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Samuel Ortiz <samuel@sortiz.org> wrote:

> Hi Komal,
> 
> On Mon, Aug 07, 2006 at 02:42:33PM +0530, Komal Shah wrote:
> > Samuel/Tony,
> > 
> > I have attached the OMAP IrDA patch for OMAP1610/1710 and OMAP242x
> > for review. See that for IrDA driver to work on H3 and H4, we need
> > gpio-expander functions to go in mainline, but it can work on H2.
> Overall the patch looks good, I have some comments though. See below:

Thanx for the review.
 
> > +
> > +#define UART3_IIR_TX_STATUS		(1 << 5)
> > +#define UART3_IIR_EOF			(0x80)
> > +
> > +#define IS_FIR(si)		((si)->speed >= 4000000)
> > +#define IRDA_FRAME_SIZE_LIMIT	4096
> You should use IRDA_SKB_MAX_MTU and IRDA_SIR_MAX_FRAME for
> respectively your
> max Rx and Tx sizes.

I will update this and to all the places where FRAME_SIZE_LIMIT was
used as default ro rx and tx sizes.

> 
> 
> > +static int rx_state = 0;	/* RX state for IOCTL */
> rx_state could probably be part of omap_irda.

I think this can be removed all together, as it remains zero only.

> 
> 
> > +struct omap_irda {
> > +	unsigned char open;
> > +	int speed;		/* Current IrDA speed */
> > +	int newspeed;
> > +
> > +	struct net_device_stats stats;
> > +	struct irlap_cb *irlap;
> > +	struct qos_info qos;
> > +
> > +	int rx_dma_channel;
> > +	int tx_dma_channel;
> > +
> > +	dma_addr_t rx_buf_dma_phys;	/* Physical address of RX DMA buffer
> */
> > +	dma_addr_t tx_buf_dma_phys;	/* Physical address of TX DMA buffer
> */
> > +
> > +	void *rx_buf_dma_virt;		/* Virtual address of RX DMA buffer */
> > +	void *tx_buf_dma_virt;		/* Virtual address of TX DMA buffer */
> > +
> > +	struct device *dev;
> > +	struct omap_irda_config *pdata;
> You forgot to define omap_irda_config.
> Same thing for IR_SEL, IR_SIRMODE, IR_FIRMODE and IR_MIRMODE.

Check include/asm-arm/arch-omap/irda.h

> > +static void omap_irda_rx_dma_callback(int lch, u16 ch_status, void
> *data)
> > +{
> > +	struct net_device *dev = data;
> > +	struct omap_irda *si = dev->priv;
> A detail here, but I think that "si" for a variable name is a bit
> meaningless. 

Ok. I will update this.

> > +
> > +	status = uart_reg_in(UART3_SFLSR);	/* Take a frame status */
> > +
> > +	if (status != 0) {	/* Bad frame? */
> > +		si->stats.rx_frame_errors++;
> > +		uart_reg_in(UART3_RESUME);
> > +	} else {
> > +		/* We got a frame! */
> > +		skb = alloc_skb(IRDA_FRAME_SIZE_LIMIT, GFP_ATOMIC);
> Use dev_alloc_skb() for allocating RX packets.

Ok. Done

> > +
> > +	case SIOCGRECEIVING:
> > +		rq->ifr_receiving = rx_state;
> > +		break;
> rx_state is always set to 0, so this looks a bit useless.

I can remove the "case SIOCGRECEIVING" altogether then.

> > +
> > +	if (!pdata->rx_channel || !pdata->tx_channel) {
> > +		printk(KERN_ERR "IrDA invalid rx/tx channel value\n");
> > +		return -ENOENT;
> > +	}
> I see that rx_channel and tx_channel are part of your
> omap_irda_config, which
> seems to be a platform specific structure. However, DMA channels are
> architecture specific and could be removed from this structure, isn't
> it ?

Correct. Then I have to think passing those information using either
device resources or revert back to #ifdefers in omap-ir.c. Any
suggestions?

> > +
> > +	irda_qos_bits_to_value(&si->qos);
> > +
> > +	/* Any better way to avoid this? No. */
> > +	if (machine_is_omap_h3() || machine_is_omap_h4())
> > +		INIT_WORK(&si->pdata->gpio_expa, NULL, NULL);
> What is this for ?


As H3 and H4 platforms uses gpio_expander (through I2C) for selecting
between IrDA and GPS Module, and that code is being called from IRQ
context, as you know that gpip_expander code ultimately leades to I2C
code and which can sleep.

See these links:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/thread.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/005996.html
http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006019.html

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
