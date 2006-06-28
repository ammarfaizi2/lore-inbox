Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWF1SCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWF1SCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWF1SCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:02:06 -0400
Received: from web50108.mail.yahoo.com ([206.190.38.36]:17266 "HELO
	web50108.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750700AbWF1SCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:02:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Az9+VL3Rvy/pvm5qDCwmUPKGfvZIzmqkd9nTLinlWigS+mfmyKw7bBPlCBn/mvTMUV8vrd7oUti99rTVzOeclUCjPXWN0Gq7Lyadbl8LyIaONjAqtWiYS0TYg2lSa7B5hXVHF0vngMD3spvuyuhgXy0couxsqOd41M2BGscS26k=  ;
Message-ID: <20060628180201.82201.qmail@web50108.mail.yahoo.com>
Date: Wed, 28 Jun 2006 11:02:00 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 1/6]  EDAC PCI device to DEVICE cleanup
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060627145225.054b1e63.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Andrew Morton <akpm@osdl.org> wrote:

> Doug Thompson <norsk5@yahoo.com> wrote:
> >
> > From: Doug Thompson <norsk5@xmission.com>
> > 
> > Change MC drivers from using CVS revision strings for their version number,
> > Now each driver has its own local string.
> > 
> > Remove some PCI dependencies from the core EDAC module.  
> > Made the code 'struct device' centric instead of 'struct pci_dev'
> > Most of the code changes here are from a patch by Dave Jiang.
> > It may be best to eventually move the PCI-specific code into a separate source
> file.
> > 
> > ...
> >
> > --- linux-2.6.17-rc6.orig/drivers/edac/edac_mc.h	2006-06-12 18:17:17.000000000
> -0600
> > +++ linux-2.6.17-rc6/drivers/edac/edac_mc.h	2006-06-12 18:17:29.000000000 -0600
> > @@ -88,6 +88,12 @@
> >  #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
> >  	PCI_DEVICE_ID_ ## vend ## _ ## dev
> >  
> > +#if defined(CONFIG_X86) && defined(CONFIG_PCI)
> > +#define dev_name(dev) pci_name(to_pci_dev(dev))
> > +#else
> > +#define dev_name(dev) to_platform_device(dev)->name
> > +#endif
> 
> This looks fishy.  pci_name() should work OK on non-x86?

Many of these mods, including this one, came from a non-x86 (PPC I think) developer
to make it work for him. Since I don't have a PPC test machine, I had/have to assume
he knew what he needed. It might work on non-x86, but I don't have a way to test.


> 
> > +static void do_pci_parity_check(void)
> > +{
> > +	unsigned long flags;
> > +	int before_count;
> > +
> > +	debugf3("%s()\n", __func__);
> > +
> > +	if (!check_pci_parity)
> > +		return;
> > +
> > +	before_count = atomic_read(&pci_parity_count);
> > +
> > +	/* scan all PCI devices looking for a Parity Error on devices and
> > +	 * bridges
> > +	 */
> > +	local_irq_save(flags);
> > +	edac_pci_dev_parity_iterator(edac_pci_dev_parity_test);
> > +	local_irq_restore(flags);
> > +
> > +	/* Only if operator has selected panic on PCI Error */
> > +	if (panic_on_pci_parity) {
> > +		/* If the count is different 'after' from 'before' */
> > +		if (before_count != atomic_read(&pci_parity_count))
> > +			panic("EDAC: PCI Parity Error");
> > +	}
> > +}
> 
> What is the local_irq_save() attempting to do in there?  It won't provide
> any locking-style coverage on SMP..

The PCI parity scanning and ECC memory harvesting are performed by a single kthread.
No multi-threads are performing these operation. Thus we only have to worry about
the single thread issues.

The iterator will examine all the PCI devices' parity in the system during a scan.
Since each device under examination will have its reference count bumped, it won't
be removed from the list, until the examination passes the device. I had to assume
that the developer was protecting the list during the scan from possible hotplug
events, which could be wrong on my part, as the reference count should do that.

More comments are needed to explain the single harvester model I suppose.  A future
patch will remove the the kthread and utilize a "work queue" model, but that has no
bearing on this issue.


doug t

> 
> 

