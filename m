Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUHIKNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUHIKNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUHIKNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:13:51 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:15049 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S263085AbUHIKNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:13:43 -0400
Date: Mon, 9 Aug 2004 12:13:37 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Suspend/Resume support for ati-agp
In-Reply-To: <20040808195021.GB7765@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0408091203310.12175@mercury.sdinet.de>
References: <Pine.LNX.4.58.0408080331490.15568@mercury.sdinet.de>
 <20040808195021.GB7765@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Pavel Machek wrote:

> > while trying to debug a strange resume problem with 2.6.8-rc3-mm1 and
> > software suspend 2 I suspeced ati-agp, and created the following attached
> > patch to add powermanagement support for it.
> >
> > I don't know if it's the completely right thing to do, I just copied the
> > way via-agp and intel-agp do it - but perhaps you like it and want to send
> > it upstream.
>
> Looks good to me.
>
> > ps:
> > this did not fix the strange "weird vertical bars instead of movie in
> > mplayer after resume" I have, but does not do any bad things either
> > ;)
>
> Hmm, and does it fix anything?

Nothing I could find.

suspend to disk with swsusp in 2.6.8-rc3-mm1 does not work at all for me,
I just get a oops longer than screen height after resume, which I can't
capture because my thinkpad r40e does not have a serial port.
sorry, but I didnt test with it after creating this patch.

suspend to disk with softwaresuspend 2 works mostly, I just need to
remove and reload the snd_ali5154 soundmodule after resume, and mplayer
output with -vo xv is broken.

pmdisk in 2.6.7-mm5 worked with the same problems as softwaresuspend 2 in
the newer kernel.


>
> 									Pavel
>
>
> > --- linux/drivers/char/agp/ati-agp.c.orig	2004-08-08 02:53:10.000000000 +0200
> > +++ linux/drivers/char/agp/ati-agp.c	2004-08-08 03:06:03.000000000 +0200
> > @@ -505,6 +505,33 @@
> >  	agp_put_bridge(bridge);
> >  }
> >
> > +#ifdef CONFIG_PM
> > +
> > +static int agp_ati_suspend(struct pci_dev *pdev, u32 state)
> > +{
> > +	pci_save_state (pdev, pdev->saved_config_space);
> > +	pci_set_power_state (pdev, 3);
> > +
> > +	return 0;
> > +}
> > +
> > +static int agp_ati_resume(struct pci_dev *pdev)
> > +{
> > +	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
> > +
> > +	/* set power state 0 and restore PCI space */
> > +	pci_set_power_state (pdev, 0);
> > +	pci_restore_state(pdev, pdev->saved_config_space);
> > +
> > +	/* reconfigure AGP hardware again */
> > +	if (bridge->driver == &ati_generic_bridge)
> > +		return ati_configure();
> > +
> > +	return 0;
> > +}
> > +
> > +#endif /* CONFIG_PM */
> > +
> >  static struct pci_device_id agp_ati_pci_table[] = {
> >  	{
> >  	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
> > @@ -524,6 +551,10 @@
> >  	.id_table	= agp_ati_pci_table,
> >  	.probe		= agp_ati_probe,
> >  	.remove		= agp_ati_remove,
> > +#ifdef CONFIG_PM
> > +	.suspend	= agp_ati_suspend,
> > +	.resume		= agp_ati_resume,
> > +#endif
> >  };
> >
> >  static int __init agp_ati_init(void)
>

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
