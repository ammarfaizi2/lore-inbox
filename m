Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUHGHNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUHGHNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 03:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUHGHNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 03:13:53 -0400
Received: from web60510.mail.yahoo.com ([216.109.116.131]:62636 "HELO
	web60510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266287AbUHGHNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 03:13:49 -0400
Message-ID: <20040807071346.91641.qmail@web60510.mail.yahoo.com>
Date: Sat, 7 Aug 2004 00:13:46 -0700 (PDT)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: swsuspend not working
To: =?ISO-8859-1?Q?=20=22=C9ric=22?= Brunet <Eric.Brunet@lps.ens.fr>,
       Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       p_gortmaker@yahoo.com
In-Reply-To: <20040806235438.GA7095@lps.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you determine that the reset_8390 was required for
proper suspend/resume behaviour?

--- Éric Brunet <Eric.Brunet@lps.ens.fr> wrote:

> On Fri, Aug 06, 2004 at 09:06:49PM +0200, Pavel Machek wrote:
> > > Do you think it could get in ?
> > 
> > Yes, the patch looks good to me, submit it through ne2k-pci
> > maintainer...
> > 
> Thank you ! The maintainer (Paul Gortmaker) is already in the CC. He
> didn't answer but hey, it is August and people are going on holyday. I
> will resend the patch in September.
> 
> Éric Brunet
> > 									Pavel
> > 
> > > --- ne2k-pci.c.orig	2004-07-20 22:15:30.000000000 +0200
> > > +++ ne2k-pci.c	2004-07-31 19:48:38.000000000 +0200
> > > @@ -653,12 +653,43 @@
> > >  	pci_set_drvdata(pdev, NULL);
> > >  }
> > >  
> > > +#ifdef CONFIG_PM
> > > +static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
> > > +{
> > > +	struct net_device *dev = pci_get_drvdata (pdev);
> > > +
> > > +	netif_device_detach(dev);
> > > +	ne2k_pci_close(dev);
> > > +	ne2k_pci_reset_8390(dev);
> > > +	pci_set_power_state (pdev, state);
> > > +
> > > +	return 0;
> > > +}
> > > +static int ne2k_pci_resume (struct pci_dev *pdev)
> > > +{
> > > +	struct net_device *dev = pci_get_drvdata (pdev);
> > > +
> > > +	pci_set_power_state(pdev, 0);
> > > +	ne2k_pci_reset_8390(dev);
> > > +	ne2k_pci_open(dev);
> > > +	netif_device_attach(dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#endif /* CONFIG_PM */
> > > +
> > >  
> > >  static struct pci_driver ne2k_driver = {
> > >  	.name		= DRV_NAME,
> > >  	.probe		= ne2k_pci_init_one,
> > >  	.remove		= __devexit_p(ne2k_pci_remove_one),
> > >  	.id_table	= ne2k_pci_tbl,
> > > +#ifdef CONFIG_PM
> > > +	.suspend	= ne2k_pci_suspend,
> > > +	.resume		= ne2k_pci_resume,
> > > +#endif /* CONFIG_PM */
> > > +
> > >  };
> > >  
> > >  
> > 
> > -- 
> > People were complaining that M$ turns users into beta-testers...
> > ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
