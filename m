Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290600AbSARFIZ>; Fri, 18 Jan 2002 00:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290601AbSARFIQ>; Fri, 18 Jan 2002 00:08:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290600AbSARFIA>;
	Fri, 18 Jan 2002 00:08:00 -0500
Message-ID: <3C47ADAC.6D92E2A5@mandrakesoft.com>
Date: Fri, 18 Jan 2002 00:07:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:

> + * Wrapper for disabling interrupts.
> + * (note : inline, so optimised away)
> + */
> +static inline void
> +wv_splhi(net_local *           lp,
> +        unsigned long *        pflags)
> +{
> +  spin_lock_irqsave(&lp->spinlock, *pflags);
> +  /* Note : above does the cli(); itself */
> +}
> +
> +/*------------------------------------------------------------------*/
> +/*
> + * Wrapper for re-enabling interrupts.
> + */
> +static inline void
> +wv_splx(net_local *            lp,
> +       unsigned long *         pflags)
> +{
> +  spin_unlock_irqrestore(&lp->spinlock, *pflags);

ug...  you are much better to put spin_lock_irqsave directly into the
code, don't wrap it.  wrapping, here, only obscures the code using it to
the casual reader.

This change also makes the diff long.


> +#if 0
> +  /* Some people don't need this, some other may need it */
> +  nwid=nwid^ntohs(beacon->domain_id);
> +#endif

maybe better as #ifdef I_NEED_THIS_FEATURE then?


> +  /* Busy wait while the LAN controller executes the command. */
> +  spin = 1000;
> +  do
>      {
> -      outb(OP0_NOP, LCCR(base));
> +      /* Time calibration of the loop */
> +      udelay(10);

I hate busy-waits :)  Long term I wonder if some of the longer ones can
be pushed into tasklets or even kernel threads.  (if a kernel thread,
then the intr handler would really turn into an async notification to
the kernel thread of new work)


> +static inline void
> +wv_82593_reconfig(device *     dev)
>  {
> -       net_local *lp = (net_local *) dev->priv;
> -       dev_link_t *link = ((net_local *) dev->priv)->link;
> +  net_local *          lp = (net_local *)dev->priv;
> +  dev_link_t *         link = ((net_local *) dev->priv)->link;

Is it possible to use standard kernel types, ie. "struct net_device"
instead of "device"?


>  #ifdef DEBUG_IOCTL_INFO
> -               printk (KERN_DEBUG "%s: wv_82593_reconfig(): delayed (link = 

you could use __FUNCTION__ here if you wanted to.  (make sure to pass it
via %s if you do)

> @@ -1404,7 +1417,7 @@ wv_init_info(device *     dev)
>           printk("2430.5");
>           break;
>         default:
> -         printk("unknown");
> +         printk("???");
>         }
>      }
> 

you are reverting a change - "???" causes a trigraph-related warning in
newer gcc


> @@ -1719,7 +1732,7 @@ wv_set_frequency(u_long           base,   /* i/o po
>          memcmp(dac, dac_verify, 2 * 2))
>         {
>  #ifdef DEBUG_IOCTL_ERROR
> -         printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (?)\n");
> +         printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (??)\n");
>  #endif
>           return -EOPNOTSUPP;
>         }

likewise


> @@ -1968,7 +1981,7 @@ wavelan_ioctl(struct net_device * dev,    /
> 
>      case SIOCGIWFREQ:
>        /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
> -       * (does it work for everybody XXX - especially old cards...) */
> +       * (does it work for everybody ??? - especially old cards...) */
>        if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
>            (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
>         {

likewise



> +  /* Allocate the generic data structure */
> +  dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> +  if (!dev) {
> +      kfree(link);
> +      return NULL;
> +  }
> +  memset(dev, 0x00, sizeof(struct net_device));
>    link->priv = link->irq.Instance = dev;
> 
> +  /* Allocate the wavelan-specific data structure. */
> +  dev->priv = lp = (net_local *) kmalloc(sizeof(net_local), GFP_KERNEL);
> +  if (!lp) {
> +      kfree(link);
> +      kfree(dev);
> +      return NULL;
> +  }
> +  memset(lp, 0x00, sizeof(net_local));
> +

use alloc_etherdev instead of all this...



> @@ -4720,7 +4718,7 @@ wavelan_event(event_t             event,          /* The ev
>          * obliged to close nicely the wavelan here. David, could you
>          * close the device before suspending them ? And, by the way,
>          * could you, on resume, add a "route add -net ..." after the
> -        * ifconfig up XXX Thanks... */
> +        * ifconfig up ??? Thanks... */
> 
>         /* Stop receiving new messages and wait end of transmission */
>         wv_ru_stop(dev);

reverting valid change



> @@ -4748,7 +4745,7 @@ wavelan_event(event_t             event,          /* The ev
>         if(link->state & DEV_CONFIG)
>           {
>             CardServices(RequestConfiguration, link->handle, &link->conf);
> -           if(link->open)      /* If RESET -> True, If RESUME -> False XXX */
> +           if(link->open)      /* If RESET -> True, If RESUME -> False ??? */
>               {
>                 wv_hw_reset(dev);
>                 netif_device_attach(dev);

likewise


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
