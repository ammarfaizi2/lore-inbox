Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVG2WMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVG2WMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVG2WJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:09:40 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:34346 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262922AbVG2WIt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:08:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k66PZIjnk7kMozSgpOH5ux+4FIObx0lWv4EwuUPxM3iEZYymddfOYtiDxxFpm/JPcAcjdAivzgBQB0MNqNk+Nce5bmRaVUTW0oIIPOWUAahGbbqW7jJb4RA+6ggRmaey/rkAWQ9XbL8BOT5Oe6MxPWZhXfWE1qARNr6yX4Cy4Ak=
Message-ID: <cb755df905072915085552895b@mail.gmail.com>
Date: Fri, 29 Jul 2005 22:08:47 +0000
From: Erior <lars.vahlenberg@gmail.com>
To: romieu@fr.zoreil.com
Subject: Re: sis190 driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cb755df905072914452912d82b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <095433EB6AB9634BB9524203BF7E303C99AA06@EXGBGMB02.europe.cellnetwork.com>
	 <cb755df905072914244ebbe55b@mail.gmail.com>
	 <cb755df905072914452912d82b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can change the speed with my changes however there is something wrong with
taking care of failures.

If we are sending something for example have a ping command running and change
the speed with mii-tool or disconnect the cable and connect it again, the count
on ifconfig says that we are sending packages though I don't know what because
nothing arrives to the destination machine..hmm.. I can try to dump
the the network traffic
on my 10Mbit hub if needed but I don't think we are sending anything
that makes sense.

Is there any kind of test or information I can provid to help you fixing this ?

/Lars

On 7/29/05, Erior <lars.vahlenberg@gmail.com> wrote:
> This will get the driver to aknowledge mii-tool reported mode,
> without this the drivers always says "100BaseTx-FD" while my switch
> shows 10BaseT-HD as the selected mode.
> 
> /Lars
> --- sis190.new  2005-07-29 23:26:39.000000000 +0000
> +++ sis190.c    2005-07-29 23:38:39.000000000 +0000
> @@ -956,7 +956,8 @@ static void sis190_phy_task(void * data)
>                 val = mdio_read(ioaddr, phy_id, 0x1f);
>                 net_link(tp, KERN_INFO "%s: mii ext = %04x.\n", dev->name,
> val);
> 
> -               val = mdio_read(ioaddr, phy_id, MII_LPA);
> +               val = mdio_read(ioaddr, phy_id, MII_LPA)
> +                   & mdio_read(ioaddr, phy_id, MII_ADVERTISE );
>                 net_link(tp, KERN_INFO "%s: mii lpa = %04x.\n", dev->name,
> val);
> 
>                 for (p = reg31; p->ctl; p++) {
> 
> 
> On 7/29/05, Erior <lars.vahlenberg@gmail.com> wrote:
> > Hi
> > 
> > Added PHY identifier for the Asus K8S-MX motherboard.
> > 
> > --- sis190.old  2005-07-29 23:16:07.000000000 +0000
> > +++ sis190.c    2005-07-29 23:15:37.000000000 +0000
> > @@ -325,6 +325,7 @@ static struct mii_chip_info {
> >         { "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN },
> >         { "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN },
> >         { "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN },
> > +       { "Realtek PHY RTL8201CL",{ 0x0000, 0x8200 }, LAN },
> >         { NULL, }
> >  };
> > 
> > /Lars
> > 
> > On 7/29/05, Lars Vahlenberg <lars.vahlenberg@mandator.com> wrote:
> > > 
> > > 
> > > 
> > > -----Original Message-----
> > > From: Francois Romieu [mailto:romieu@fr.zoreil.com]
> > > Sent: Fri 2005-07-29 00:11
> > > To: linux-kernel@vger.kernel.org
> > > Cc: pascal.chapperon@wanadoo.fr; Lars Vahlenberg; Alexey Dobriyan;
> > > jgarzik@pobox.com
> > > Subject: [patch 2.6.13-rc3] sis190 driver
> > >  
> > > Single file patch:
> > >
> >
> http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3-sis190-test.patch
> > > 
> > > Patch-kit:
> > > http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3/patches
> > > 
> > > Tarball:
> > > http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3.tar.bz2
> > > 
> > > Changes from previous version (20050722)
> > > o Add endian annotations (Alexey Dobriyan).
> > > 
> > > o Hopefully fixed the build of the patch.
> > > 
> > > o Minor round of mii/phy related changes. May crash.
> > > 
> > > Testing reports/review/patches are always appreciated.
> > > 
> > > Ok, now back to washing.
> > > 
> > > --
> > > Ueimor
> > > 
> > > 
> > > 
> > > 
> > 
> > 
> > -- 
> > There is nothing that cannot be solved through sufficient application
> > of brute force and ignorance.
> > 
> 
> 
> -- 
> There is nothing that cannot be solved through sufficient application
> of brute force and ignorance.
> 


-- 
There is nothing that cannot be solved through sufficient application
of brute force and ignorance.
