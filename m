Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290602AbSARSpA>; Fri, 18 Jan 2002 13:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSARSov>; Fri, 18 Jan 2002 13:44:51 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:3271 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290602AbSARSoa>;
	Fri, 18 Jan 2002 13:44:30 -0500
Date: Fri, 18 Jan 2002 10:44:19 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
Message-ID: <20020118104419.B31163@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com> <3C47ADAC.6D92E2A5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C47ADAC.6D92E2A5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jan 18, 2002 at 12:07:56AM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2002 at 12:07:56AM -0500, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> 
	Well... A bit of background...
	The Wavelan hardware has been obsoleted for the last 5
years. I put the driver in minimal maintainance mode, because I
already have a lot on my place (you would not want me to spend less
time on the IrDA stack, the Orinoco driver or the new Wireless
Extensions ?).
	The point is that the driver didn't work. I didn't look any
further and I decided for better or worse to use the version that is
in the Pcmcia package that has been working for more than one
year. Now that the two version are in sync, I can work from there.
	I tried to make sure to not loose any changes. Of course, I'm
only human.
	I hope that explains the situation.

	Attached you will find a patch that address some of your
concerns. This patch will apply to both the kernel version AND the
Pcmcia package version.
	Note also that it applies to the kernel *after* driver move
(that is pending - because I've put this patch at the end of my patch
queue).

> ug...  you are much better to put spin_lock_irqsave directly into the
> code, don't wrap it.  wrapping, here, only obscures the code using it to
> the casual reader.
> 
> This change also makes the diff long.

	That's only personal preference. And the wrapper in theory
would allow to simply change the locking strategy if needed (like
disabling irq on the hardware instead of in software).

> > +#if 0
> > +  /* Some people don't need this, some other may need it */
> > +  nwid=nwid^ntohs(beacon->domain_id);
> > +#endif
> 
> maybe better as #ifdef I_NEED_THIS_FEATURE then?

	Done.

> > +  /* Busy wait while the LAN controller executes the command. */
> > +  spin = 1000;
> > +  do
> >      {
> > -      outb(OP0_NOP, LCCR(base));
> > +      /* Time calibration of the loop */
> > +      udelay(10);
> 
> I hate busy-waits :)  Long term I wonder if some of the longer ones can
> be pushed into tasklets or even kernel threads.  (if a kernel thread,
> then the intr handler would really turn into an async notification to
> the kernel thread of new work)

	For such an obsolete driver, it's not worth replacing code
that is working fine and has been debugged and tested for
years. Moreover, on most case the wait is really small.

> > +static inline void
> > +wv_82593_reconfig(device *     dev)
> >  {
> > -       net_local *lp = (net_local *) dev->priv;
> > -       dev_link_t *link = ((net_local *) dev->priv)->link;
> > +  net_local *          lp = (net_local *)dev->priv;
> > +  dev_link_t *         link = ((net_local *) dev->priv)->link;
> 
> Is it possible to use standard kernel types, ie. "struct net_device"
> instead of "device"?

	If you want to spend time on this, please send me a patch and
I'll apply it to both the kernel version and the Pcmcia package.

> >  #ifdef DEBUG_IOCTL_INFO
> > -               printk (KERN_DEBUG "%s: wv_82593_reconfig(): delayed (link = 
> 
> you could use __FUNCTION__ here if you wanted to.  (make sure to pass it
> via %s if you do)

	I would not bother.
	By the way, I looked at the __FUNCTION__ business, and IrDA
will need a massive cleanup. *sight*...

> > @@ -1404,7 +1417,7 @@ wv_init_info(device *     dev)
> >           printk("2430.5");
> >           break;
> >         default:
> > -         printk("unknown");
> > +         printk("???");
> >         }
> >      }
> > 
> 
> you are reverting a change - "???" causes a trigraph-related warning in
> newer gcc

	I didn't knew about that, and my gcc doesn't give any
warning. I can't believe that gcc is too stupid to realise that you
can't have trigraph within a string or a comment.
	Done. And guess what, it will also go in the Pcmcia package ;-)

> > @@ -1968,7 +1981,7 @@ wavelan_ioctl(struct net_device * dev,    /
> > 
> >      case SIOCGIWFREQ:
> >        /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
> > -       * (does it work for everybody XXX - especially old cards...) */
> > +       * (does it work for everybody ??? - especially old cards...) */
> >        if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
> >            (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
> >         {
> 
> likewise

	I'm sorry, but "XXX" doesn't mean "???" in any variation of
the english language that I've ever encoutered.

> > +  /* Allocate the generic data structure */
> > +  dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> > +  if (!dev) {
> > +      kfree(link);
> > +      return NULL;
> > +  }
> > +  memset(dev, 0x00, sizeof(struct net_device));
> >    link->priv = link->irq.Instance = dev;
> > 
> > +  /* Allocate the wavelan-specific data structure. */
> > +  dev->priv = lp = (net_local *) kmalloc(sizeof(net_local), GFP_KERNEL);
> > +  if (!lp) {
> > +      kfree(link);
> > +      kfree(dev);
> > +      return NULL;
> > +  }
> > +  memset(lp, 0x00, sizeof(net_local));
> > +
> 
> use alloc_etherdev instead of all this...

	No need to change working code.

> Jeff Garzik

	Thanks for the quick review...

	Jean

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wav_pc.jeff.diff"

diff -u -p -r linux/drivers/net/wireless.v23/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless.v23/wavelan_cs.c	Thu Jan 17 10:48:59 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Fri Jan 18 10:36:22 2002
@@ -797,7 +797,7 @@ static inline void wl_roam_gather(device
   wavepoint_history *wavepoint=NULL;                /* WavePoint table entry */
   net_local *lp=(net_local *)dev->priv;              /* Device info */
 
-#if 0
+#ifdef I_NEED_THIS_FEATURE
   /* Some people don't need this, some other may need it */
   nwid=nwid^ntohs(beacon->domain_id);
 #endif
@@ -1417,7 +1417,7 @@ wv_init_info(device *	dev)
 	  printk("2430.5");
 	  break;
 	default:
-	  printk("???");
+	  printk("unknown");
 	}
     }
 
@@ -1732,7 +1732,7 @@ wv_set_frequency(u_long		base,	/* i/o po
 	 memcmp(dac, dac_verify, 2 * 2))
 	{
 #ifdef DEBUG_IOCTL_ERROR
-	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (??)\n");
+	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (?)\n");
 #endif
 	  return -EOPNOTSUPP;
 	}
@@ -1981,7 +1981,7 @@ wavelan_ioctl(struct net_device *	dev,	/
 
     case SIOCGIWFREQ:
       /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
-       * (does it work for everybody ??? - especially old cards...) */
+       * (does it work for everybody ? - especially old cards...) */
       if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
 	   (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
 	{
@@ -3163,7 +3163,7 @@ wv_mmc_init(device *	dev)
    */
 
   /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
-   * (does it work for everybody ??? - especially old cards...) */
+   * (does it work for everybody ? - especially old cards...) */
   /* Note : WFREQSEL verify that it is able to read from EEprom
    * a sensible frequency (address 0x00) + that MMR_FEE_STATUS_ID
    * is 0xA (Xilinx version) or 0xB (Ariadne version).
@@ -4718,7 +4718,7 @@ wavelan_event(event_t		event,		/* The ev
 	 * obliged to close nicely the wavelan here. David, could you
 	 * close the device before suspending them ? And, by the way,
 	 * could you, on resume, add a "route add -net ..." after the
-	 * ifconfig up ??? Thanks... */
+	 * ifconfig up ? Thanks... */
 
 	/* Stop receiving new messages and wait end of transmission */
 	wv_ru_stop(dev);
@@ -4745,7 +4745,7 @@ wavelan_event(event_t		event,		/* The ev
 	if(link->state & DEV_CONFIG)
 	  {
       	    CardServices(RequestConfiguration, link->handle, &link->conf);
-      	    if(link->open)	/* If RESET -> True, If RESUME -> False ??? */
+      	    if(link->open)	/* If RESET -> True, If RESUME -> False ? */
 	      {
 		wv_hw_reset(dev);
 		netif_device_attach(dev);

--RnlQjJ0d97Da+TV1--
