Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUHFXys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUHFXys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHFXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:54:48 -0400
Received: from nef.ens.fr ([129.199.96.32]:63240 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S263962AbUHFXyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:54:45 -0400
Date: Sat, 7 Aug 2004 01:54:38 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       p_gortmaker@yahoo.com
Subject: Re: swsuspend not working
Message-ID: <20040806235438.GA7095@lps.ens.fr>
References: <20040715121042.GB9873@lps.ens.fr> <20040715121825.GC22260@elf.ucw.cz> <20040715132348.GA9939@lps.ens.fr> <20040719191906.GA7053@lps.ens.fr> <20040720131748.GI27492@atrey.karlin.mff.cuni.cz> <20040731182001.GA6760@lps.ens.fr> <20040806190649.GC3048@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040806190649.GC3048@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Sat, 07 Aug 2004 01:54:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 09:06:49PM +0200, Pavel Machek wrote:
> > Do you think it could get in ?
> 
> Yes, the patch looks good to me, submit it through ne2k-pci
> maintainer...
> 
Thank you ! The maintainer (Paul Gortmaker) is already in the CC. He
didn't answer but hey, it is August and people are going on holyday. I
will resend the patch in September.

Éric Brunet
> 									Pavel
> 
> > --- ne2k-pci.c.orig	2004-07-20 22:15:30.000000000 +0200
> > +++ ne2k-pci.c	2004-07-31 19:48:38.000000000 +0200
> > @@ -653,12 +653,43 @@
> >  	pci_set_drvdata(pdev, NULL);
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
> > +{
> > +	struct net_device *dev = pci_get_drvdata (pdev);
> > +
> > +	netif_device_detach(dev);
> > +	ne2k_pci_close(dev);
> > +	ne2k_pci_reset_8390(dev);
> > +	pci_set_power_state (pdev, state);
> > +
> > +	return 0;
> > +}
> > +static int ne2k_pci_resume (struct pci_dev *pdev)
> > +{
> > +	struct net_device *dev = pci_get_drvdata (pdev);
> > +
> > +	pci_set_power_state(pdev, 0);
> > +	ne2k_pci_reset_8390(dev);
> > +	ne2k_pci_open(dev);
> > +	netif_device_attach(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +#endif /* CONFIG_PM */
> > +
> >  
> >  static struct pci_driver ne2k_driver = {
> >  	.name		= DRV_NAME,
> >  	.probe		= ne2k_pci_init_one,
> >  	.remove		= __devexit_p(ne2k_pci_remove_one),
> >  	.id_table	= ne2k_pci_tbl,
> > +#ifdef CONFIG_PM
> > +	.suspend	= ne2k_pci_suspend,
> > +	.resume		= ne2k_pci_resume,
> > +#endif /* CONFIG_PM */
> > +
> >  };
> >  
> >  
> 
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
