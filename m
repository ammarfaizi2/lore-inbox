Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRIXMRw>; Mon, 24 Sep 2001 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRIXMRf>; Mon, 24 Sep 2001 08:17:35 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:15882 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S273867AbRIXMRa>; Mon, 24 Sep 2001 08:17:30 -0400
Date: Mon, 24 Sep 2001 08:16:42 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: <tip@prs.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <laughing@shared-source.org>
Subject: Re: [PATCH] 2.4.10-pre13: ATM drivers cause panic
In-Reply-To: <3BAF0133.573EF0B7@internetwork-ag.de>
Message-ID: <Pine.LNX.4.33.0109240814240.31525-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  Isn't the linux-atm list the more appropriate list
	for this discussion ?  ie:

	linux-atm-general@lists.sourceforge.net

	The people there would definately like to know of these
	discussions & troubles & fixes that are being shared .
		Tia ,  JimL

On Mon, 24 Sep 2001, Till Immanuel Patzschke wrote:

> Hmm - patch works fine for me - no sleeps! The only spin_lock(&atm_dev_lock)
> statement in my resource.c (the original from 2.4.10-pre13) is in free_atm_dev
> BUT the problem is the unmatched spin_unlock(&atm_dev_lock) statements in
> atm_dev_register...
> Why not just protecting the atm_dev_queue in alloc_atm_dev, atm_find_dev, and
> atm_free_dev individually PLUS removing the two spin_unlock statements in
> atm_dev_register.
>
> What do you think
>
> (This is diffs from 2.4.10-pre13 ! BTW: Still the same in 2.4.10)
>
> --- resources.c.bug     Fri Dec 29 23:35:47 2000
> +++ resources.c.new     Mon Sep 24 11:39:42 2001
> @@ -36,13 +36,16 @@
>         if (!dev) return NULL;
>         memset(dev,0,sizeof(*dev));
>         dev->type = type;
> -       dev->prev = last_dev;
>         dev->signal = ATM_PHY_SIG_UNKNOWN;
>         dev->link_rate = ATM_OC3_PCR;
>         dev->next = NULL;
> +
> +       spin_lock(&atm_dev_lock);
> +       dev->prev = last_dev;
>         if (atm_devs) last_dev->next = dev;
>         else atm_devs = dev;
>         last_dev = dev;
> +       spin_unlock(&atm_dev_lock);
>         return dev;
>  }
>
> @@ -65,9 +68,13 @@
>  {
>         struct atm_dev *dev;
>
> +       spin_lock(&atm_dev_lock);
>         for (dev = atm_devs; dev; dev = dev->next)
> -               if (dev->ops && dev->number == number) return dev;
> -       return NULL;
> +               if (dev->ops && dev->number == number) goto done;
> +       dev=(atm_dev *)NULL;
> + done:
> +       spin_unlock(&atm_dev_lock);
> +       return dev;
>  }
>
>
> @@ -105,12 +112,10 @@
>                 if (atm_proc_dev_register(dev) < 0) {
>                         printk(KERN_ERR "atm_dev_register: "
>                             "atm_proc_dev_register failed for dev %s\n",type);
> -                       spin_unlock (&atm_dev_lock);
>                         free_atm_dev(dev);
>                         return NULL;
>                 }
>  #endif
> -       spin_unlock (&atm_dev_lock);
>         return dev;
>  }
>
>
>
> Alan Cox wrote:
>
> > > seems a couple of spin_lock(s) and a spin_unlock was missing.
> > > Why didn't this problem show up with earlier releases ???
> > > Anyways, please find a (quick) patch below. It would be great if this patch or
> > > any other similar could make it into the next release!
> >
> > How about
> >
> > static struct atm_dev *alloc_atm_dev(const char *type)
> > {
> >         struct atm_dev *dev;
> >
> >         dev = kmalloc(sizeof(*dev),GFP_KERNEL);
> >         if (!dev) return NULL;
> >         memset(dev,0,sizeof(*dev));
> >         dev->type = type;
> >         dev->signal = ATM_PHY_SIG_UNKNOWN;
> >         dev->link_rate = ATM_OC3_PCR;
> >         dev->next = NULL;
> >
> >         spin_lock(&atm_dev_lock);
> >
> >         dev->prev = last_dev;
> >
> >         if (atm_devs) last_dev->next = dev;
> >         else atm_devs = dev;
> >         last_dev = dev;
> >         spin_unlock(&atm_dev_lock);
> >         return dev;
> > }
> >
> > instead. That seems to fix alloc_atm_dev safely. Refcounting wants adding
> > to atm_dev objects too, its impossible currently to make atm_find_dev
> > remotely safe
> >
> > Alan
>
> --
> Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
> interNetwork AG                         Phone:  +49-(0)611-1731-121
> Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
> D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+


