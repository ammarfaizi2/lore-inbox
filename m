Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVCXBbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVCXBbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVCXBbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:31:06 -0500
Received: from fmr20.intel.com ([134.134.136.19]:39146 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262314AbVCXBa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:30:58 -0500
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was:
	Re:2.6.12-rc1-mm1: Kernel BUG at pci:389)
From: Li Shaohua <shaohua.li@intel.com>
To: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111626180.17317.921.camel@d845pe>
References: <1111626180.17317.921.camel@d845pe>
Content-Type: text/plain
Message-Id: <1111627673.11775.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Mar 2005 09:27:53 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 09:03, Len Brown wrote:
> On Wed, 2005-03-23 at 18:49, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Wednesday, 23 of March 2005 23:39, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > > Will this do it for the moment?
> > > > > >
> > > > > > Its certainly better.
> > > > >
> > > > > With the Len's patch applied I have to unload the modules:
> > > > >
> > > > > ohci_hcd
> > > > > ehci_hcd
> > > > > yenta_socket
> > > > >
> > > > > before suspend as each of them hangs the box solid during
> either
> > > > > suspend or resume.  Moreover, when I tried to load the
> ehci_hcd
> > > > > module back after resume, it hanged the box solid too.
> 
> Is this failure with suspend to RAM or to disk?
> 
> How about if you try this patch?
> 
> http://linux-acpi.bkbits.net:8080/to-akpm/cset@423b4875tyauh4CrSSoQfXOEPDkmUw
> 
> patch -Rp1 from 2.6.12-rc1-mm and see if it stops being broken
> or patch -Np1 to 2.6.12-rc and see if it starts being broken.
> 
> This one removes an earlier attempt at resuming PCI links -- now
> putting the onus on the drivers to be properly written
> to release and acquire their interrupt for a successful
> suspend/resume.
> 
> 
> In theory, this is taken care of something like this:
> driver.resume
>         pci_enable_device
>                 pci_enable_device_bars
>                         pcibios_enable_device
>                                 pcibios_enable_irq
>                                         acpi_pci_irq_enable
> 
> but if the patch above makes a difference, then theory != practice:-)
> 
> I'd believe that ohci_hcd and ehci_hcd are fragile since glancing
> at their lengthy .resume routines it isn't immediately obvious
> that they do this.  But yenta_dev_resume has a pci_enable_device(),
> so that failure may be less straightforward.
> 
> cheers,
> -Len
> 
> ps. if point me to a full dmesg -s64000 from 2.6.12-rc1 acpi-enabled
> boot, that would help -- for it will show if we're even using pci
> interrupt links (and programming them) for these devices on this box.
Yes, we changed the behavior of device suspend/resume. Every PCI device
should call 'pci_disable_device' at suspend and call 'pci_enable_device'
at resume. It fixes a bug and more important thing is it's safer (Eg. it
disable interrupts, bus master and etc).
I actually added such calls in uhci, ehci and yenta. It's ok for S3 (and
definitely required for S3). Unclear if it's ok for S4, so please try
revert the patch.

Thanks,
Shaohua

