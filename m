Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWFHPqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWFHPqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFHPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:46:48 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:21457 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964887AbWFHPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:46:47 -0400
Date: Thu, 8 Jun 2006 11:46:44 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] pcnet32 driver NAPI support
Message-ID: <20060608154644.GD558@csclub.uwaterloo.ca>
References: <20060607165225.GB7859@csclub.uwaterloo.ca> <20060608080253.GA20601@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608080253.GA20601@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 10:03:03AM +0200, Pavel Machek wrote:
> Hi!
> 
> > I have made a diff against 2.6.16.20 and 2.6.17-rc6.
> > 
> > Comments would be very welcome.
> > 
> > Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> > 
> > Len Sorensen
> 
> > diff -ruN linux-2.6.16.20/drivers/net/Kconfig linux-2.6.16.20.pcnet32napi/drivers/net/Kconfig
> > --- linux-2.6.16.20/drivers/net/Kconfig	2006-06-05 13:18:23.000000000 -0400
> > +++ linux-2.6.16.20.pcnet32napi/drivers/net/Kconfig	2006-06-07 11:19:54.000000000 -0400
> > @@ -1272,6 +1272,23 @@
> >  	  <file:Documentation/networking/net-modules.txt>. The module
> >  	  will be called pcnet32.
> >  
> > +config PCNET32_NAPI
> > +	bool "Use NAPI RX polling "
> > +	depends on PCNET32
> > +	help
> > +	  NAPI is a new driver API designed to reduce CPU and interrupt load
> > +	  when the driver is receiving lots of packets from the card. It is
> > +	  still somewhat experimental and thus not yet enabled by default.
> > +
> > +	  If your estimated Rx load is 10kpps or more, or if the card will be
> > +	  deployed on potentially unfriendly networks (e.g. in a firewall),
> > +	  then say Y here.
> > +
> > +	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
> > +	  information.
> > +
> > +	  If in doubt, say N.
> > +
> >  config AMD8111_ETH
> >  	tristate "AMD 8111 (new PCI lance) support"
> >  	depends on NET_PCI && PCI
> > diff -ruN linux-2.6.16.20/drivers/net/pcnet32.c linux-2.6.16.20.pcnet32napi/drivers/net/pcnet32.c
> > --- linux-2.6.16.20/drivers/net/pcnet32.c	2006-06-05 13:18:23.000000000 -0400
> > +++ linux-2.6.16.20.pcnet32napi/drivers/net/pcnet32.c	2006-06-07 12:00:36.000000000 -0400
> > @@ -21,9 +21,15 @@
> >   *
> >   *************************************************************************/
> >  
> > +#include <linux/config.h>
> > +
> > +#ifdef CONFIG_PCNET32_NAPI
> > +#define DRV_NAME	"pcnet32napi"
> > +#else
> >  #define DRV_NAME	"pcnet32"
> > -#define DRV_VERSION	"1.31c"
> > -#define DRV_RELDATE	"01.Nov.2005"
> > +#endif
> > +#define DRV_VERSION	"1.31d"
> > +#define DRV_RELDATE	"06.Jun.2006"
> >  #define PFX		DRV_NAME ": "
> >  
> >  static const char *version =
> > @@ -265,6 +271,7 @@
> >   * v1.31c  01 Nov 2005 Don Fry Allied Telesyn 2700/2701 FX are 100Mbit only.
> >   *	   Force 100Mbit FD if Auto (ASEL) is selected.
> >   *	   See Bugzilla 2669 and 4551.
> > + * v1.31d  06 Jun 2006 Len Sorensen added NAPI support.
> >   */
> >  
> >  
> > @@ -383,6 +390,7 @@
> >      struct mii_if_info	mii_if;
> >      struct timer_list	watchdog_timer;
> >      struct timer_list	blink_timer;
> > +    struct timer_list	oom_timer;
> >      u32			msg_enable;	/* debug message level */
> >  };
> >  
> > @@ -392,7 +400,13 @@
> >  static int  pcnet32_open(struct net_device *);
> >  static int  pcnet32_init_ring(struct net_device *);
> >  static int  pcnet32_start_xmit(struct sk_buff *, struct net_device *);
> > +#ifdef CONFIG_PCNET32_NAPI
> > +void disable_rx_and_norxbuff_ints(struct net_device *dev);
> > +void enable_rx_and_norxbuff_ints(struct net_device *dev);
> > +static int  pcnet32_poll(struct net_device *, int *budget);
> > +#else
> >  static int  pcnet32_rx(struct net_device *);
> > +#endif
> >  static void pcnet32_tx_timeout (struct net_device *dev);
> >  static irqreturn_t pcnet32_interrupt(int, void *, struct pt_regs *);
> >  static int  pcnet32_close(struct net_device *);
> > @@ -422,6 +436,174 @@
> >      PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
> >  };
> >  
> > +#ifdef CONFIG_PCNET32_NAPI
> > +void oom_timer(unsigned long data)
> > +{
> > +    struct net_device *dev = (struct net_device *)data;
> > +    struct pcnet32_private *lp = dev->priv;
> > +    lp->rl_active = 0;
> > +    netif_rx_schedule(dev);
> > +}
> > +
> > +static
> > +int pcnet32_poll(struct net_device *dev, int *budget)
> > +{
> > +    struct pcnet32_private *lp = dev->priv;
> > +    ulong ioaddr = dev->base_addr;
> > +
> > +    int entry = lp->cur_rx & lp->rx_mod_mask;
> > +    int rx_work_limit = dev->quota;
> > +    int received = 0;
> > +
> > +    if (!netif_running(dev))
> > +	goto done;
> > +
> > +    do {
> > +	// Clear RX interrupts
> > +	lp->a.write_csr (ioaddr, 0, 0x1400);
> 
> Please indent with tabs (according to coding style) and avoid using //
> comments.

The existing driver has some places that indent by 4 spaces (on top of a
bunch of tabs) which I tried to copy exactly.  The part you found there
on the other hand I do have to fix.  The driver in 2.6.16 had a lot less
tabs and a lot more spaces, and 2.6.8 (which I started from originally)
had very bad and inconsistent indentation.  I am happy to see
2.6.17-rc6's version is a lot more consistent, although personally I
think some of the changes are amazingly ugly, splitting argument lists
to a function call over 10 lines with only about 8 characters per line.

Len Sorensen
