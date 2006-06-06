Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWFFM7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWFFM7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWFFM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:59:31 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:46732
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932149AbWFFM7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:59:30 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Date: Tue, 6 Jun 2006 14:58:06 +0200
User-Agent: KMail/1.9.1
References: <2005123213211@nnikde.cz> <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz> <20060605205309.GA31061@kroah.com>
In-Reply-To: <20060605205309.GA31061@kroah.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
       linville@tuxdriver.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061458.06928.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 22:53, Greg KH wrote:
> On Mon, Jun 05, 2006 at 10:20:07PM +0200, Jiri Slaby wrote:
> > bcm43xx avoid pci_find_device
> > 
> > Change pci_find_device to safer pci_get_device with support for more
> > devices.
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> > 
> > ---
> > commit 4b73c16f5411d97360d5f26f292ffddeb670ff75
> > tree 6e43c8bd02498eb1ceec6bdc64277fa8408da9e2
> > parent d59f9ea8489749f59cd0c7333a4784cab964daa8
> > author Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
> > committer Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
> > 
> >  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   21 ++++++++++++++++-----
> >  1 files changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > index 22b8fa6..d1a9975 100644
> > --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > @@ -2133,6 +2133,13 @@ out:
> >  	return err;
> >  }
> >  
> > +#ifdef CONFIG_BCM947XX
> > +static struct pci_device_id bcm43xx_47xx_ids[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4324) },
> > +	{ 0 }
> > +};
> > +#endif
> > +
> >  static int bcm43xx_initialize_irq(struct bcm43xx_private *bcm)
> >  {
> >  	int res;
> > @@ -2142,11 +2149,15 @@ static int bcm43xx_initialize_irq(struct
> >  	bcm->irq = bcm->pci_dev->irq;
> >  #ifdef CONFIG_BCM947XX
> >  	if (bcm->pci_dev->bus->number == 0) {
> > -		struct pci_dev *d = NULL;
> > -		/* FIXME: we will probably need more device IDs here... */
> > -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> > -		if (d != NULL) {
> > -			bcm->irq = d->irq;
> > +		struct pci_dev *d;
> > +		struct pci_device_id *id;
> > +		for (id = bcm43xx_47xx_ids; id->vendor; id++) {
> > +			d = pci_get_device(id->vendor, id->device, NULL);
> > +			if (d != NULL) {
> > +				bcm->irq = d->irq;
> > +				pci_dev_put(d);
> > +				break;
> > +			}
> 
> This will not work if you have more than one of the same devices in the
> system.
> 
> Well, the original code will not either :(
> 
> Why not just use the proper pci interface?  Why poke around in another
> pci device to steal an irq, when that irq might not even be valid?
> (irqs are not valid until pci_enable_device() is called on them...)

Ok, if someone really wants to have this patch in mainline.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

But the whole purpose of this patch is really questionable.
* This code is only compiled for the OpenWRT Router kernel.
  This kernel does not use softmac, but dscape stack.
  So nobody will ever actually use this code.
  One could even argue, if the code should be removed from
  the softmac driver, but I think openwrt people use it for
  some kind of hacking, testing, whatever.
  It's not so much code, so I don't care. It does not add
  maintainance work.
* Do we really need to increment some reference counters?
  I mean, we are asking for a bus here. This bus is not
  hotpluggable or something and will never go away. Either it
  is soldered on the board or not. That is what we test here.

So, Jiri, if you really want to have this patch upstream, you
have my Signed-off-by. If nobody else cares, it will get lost
in the deep black netdev hole. ;)

-- 
Greetings Michael.
