Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVCXBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVCXBEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCXBEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:04:24 -0500
Received: from fmr21.intel.com ([143.183.121.13]:21910 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262054AbVCXBEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:04:16 -0500
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re:
	2.6.12-rc1-mm1: Kernel BUG at pci:389)
From: Len Brown <len.brown@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <200503240049.25695.rjw@sisk.pl>
References: <20050322013535.GA1421@elf.ucw.cz>
	 <200503232329.50461.rjw@sisk.pl> <20050323223918.GL30704@elf.ucw.cz>
	 <200503240049.25695.rjw@sisk.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1111626180.17317.921.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2005 20:03:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 18:49, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wednesday, 23 of March 2005 23:39, Pavel Machek wrote:
> > Hi!
> >
> > > > > > Will this do it for the moment?
> > > > >
> > > > > Its certainly better.
> > > >
> > > > With the Len's patch applied I have to unload the modules:
> > > >
> > > > ohci_hcd
> > > > ehci_hcd
> > > > yenta_socket
> > > >
> > > > before suspend as each of them hangs the box solid during either
> > > > suspend or resume.  Moreover, when I tried to load the ehci_hcd
> > > > module back after resume, it hanged the box solid too.

Is this failure with suspend to RAM or to disk?

How about if you try this patch?

http://linux-acpi.bkbits.net:8080/to-akpm/cset@423b4875tyauh4CrSSoQfXOEPDkmUw

patch -Rp1 from 2.6.12-rc1-mm and see if it stops being broken
or patch -Np1 to 2.6.12-rc and see if it starts being broken.

This one removes an earlier attempt at resuming PCI links -- now
putting the onus on the drivers to be properly written
to release and acquire their interrupt for a successful suspend/resume.


In theory, this is taken care of something like this:
driver.resume
	pci_enable_device
		pci_enable_device_bars
			pcibios_enable_device
				pcibios_enable_irq
					acpi_pci_irq_enable

but if the patch above makes a difference, then theory != practice:-)

I'd believe that ohci_hcd and ehci_hcd are fragile since glancing
at their lengthy .resume routines it isn't immediately obvious
that they do this.  But yenta_dev_resume has a pci_enable_device(),
so that failure may be less straightforward.

cheers,
-Len

ps. if point me to a full dmesg -s64000 from 2.6.12-rc1 acpi-enabled
boot, that would help -- for it will show if we're even using pci
interrupt links (and programming them) for these devices on this box.


