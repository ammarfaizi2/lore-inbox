Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWGFTP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWGFTP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWGFTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:15:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42116 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750702AbWGFTP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:15:27 -0400
Date: Thu, 6 Jul 2006 12:11:29 -0700
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Karsten Keil <kkeil@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hisax fix usage of __init*
Message-ID: <20060706191129.GA20255@kroah.com>
References: <20060705112357.GA7003@pingi.kke.suse.de> <1152099459.3201.19.camel@laptopd505.fenrus.org> <s5h8xn8144m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8xn8144m.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:08:09PM +0200, Takashi Iwai wrote:
> At Wed, 05 Jul 2006 13:37:38 +0200,
> Arjan van de Ven wrote:
> > 
> > On Wed, 2006-07-05 at 13:23 +0200, Karsten Keil wrote:
> > > diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
> > > index 5333be5..e103503 100644
> > > --- a/drivers/isdn/hisax/config.c
> > > +++ b/drivers/isdn/hisax/config.c
> > > @@ -1875,7 +1875,7 @@ static void EChannel_proc_rcv(struct his
> > >  #ifdef CONFIG_PCI
> > >  #include <linux/pci.h>
> > >  
> > > -static struct pci_device_id hisax_pci_tbl[] __initdata = {
> > > +static struct pci_device_id hisax_pci_tbl[] __devinitdata = {
> > >  #ifdef CONFIG_HISAX_FRITZPCI
> > >         {PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,
> > > PCI_ANY_ID, PCI_ANY_ID},
> > >  #endif
> > > diff --git a/drivers
> > 
> > I think this bit is still buggy; afaik pci_device_id tables should not
> > be of any kind of __init at all... CC'ing Greg just to make sure I'm not
> > talking rubbish
> 
> I've been also debugging this since Andrew pointed me about a similar
> bug (sound/pci/maestro3.c).  I actually got section mismatch errors
> when pci id table is defined with __devinitdata tag together with
> CONFIG_HOTPLUG=n, either at compile time or at link time.  So, my
> conclusion is that no tags should be used for pci id table.
> 
> Interestingly, Documentation/pci.txt mentions that __devinitdata
> _should_ be used:
> 
> > Tips:
> > 	The module_init()/module_exit() functions (and all initialization
> >         functions called only from these) should be marked __init/exit.
> > 	The struct pci_driver shouldn't be marked with any of these tags.
> >	The ID table array should be marked __devinitdata.

Yes, and that is correct.  They should never be marked __initdata, as
that is wrong for when CONFIG_HOTPLUG is enabled and the module is built
in.

So either use __devinitdata, or nothing (as it's only a memory savings
if CONFIG_HOTPLUG is not enabled, which is real tough these days, and
the driver is built into the system.)

thanks,

greg k-h
