Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVDLJOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVDLJOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVDLJOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:14:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:40886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262070AbVDLJNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:13:51 -0400
Date: Tue, 12 Apr 2005 02:09:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, daniel.ritz@gmx.ch
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Message-Id: <20050412020956.4c64cbb4.akpm@osdl.org>
In-Reply-To: <20050412085922.GA6664@faui00u.informatik.uni-erlangen.de>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de>
	<20050323185225.11097185.akpm@osdl.org>
	<20050412085922.GA6664@faui00u.informatik.uni-erlangen.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
>
> On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > >
> > > 
> > > I'm hitting an annoying bug in kernel 2.6.11.5
> > > 
> > > Every time I _reboot_ (warmstart) my pc my two network cards won't get
> > > recognized any longer.
> > >
> > > Following error message appears on my screen:
> > >
> > > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > > *** EEPROM MAC address is invalid.
> > > 3c59x: vortex_probe1 fails.  Returns -22
> > > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > > PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> > > ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> > > PCI: Setting latency timer of device 0000:00:0d.0 to 64
> > > *** EEPROM MAC address is invalid.
> > > 3c59x: vortex_probe1 fails.  Returns -22
> > > 3c59x: probe of 0000:00:0d.0 failed with error -22
> > >
> > > This doesn't happen with older kernels (especially with 2.6.10) and so
> > > I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> > > first hits me.
> > >
> > > My config, lspci output and the dmesg output of the working and non-working
> > > version can be found at [1]
> > >
> > > Feel free to ask if any information is missing or if I am supposed to try
> > > a patch.
> >
> > Thanks for doing the bsearch - it helps.
> >
> > There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> >
> > The only PCI change I see is
> >
> > --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> > +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> > @@ -268,7 +268,7 @@
> >                 return -EIO;
> >
> >         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> > -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> > +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> >                 printk(KERN_DEBUG
> >                        "PCI: %s has unsupported PM cap regs version (%u)\n",
> >                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> >
> > and you're not getting that message (are you?)
> >
> 
> I have still the problem described above with 2.6.12-rc2-mm2 and
> reverting the above patch solved it. And yes, now I get many of those
> 
> PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
> PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
> PCI: 0000:00:09.0 has unsupported PM cap regs version (1)
> 
> messages.
> 

Yes, we need to work out what's going on here.

Daniel?


