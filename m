Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVKQQzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVKQQzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVKQQzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:55:41 -0500
Received: from digitalimplant.org ([64.62.235.95]:49572 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932408AbVKQQzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:55:40 -0500
Date: Thu, 17 Nov 2005 08:55:29 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <gregkh@suse.de>
cc: Adam Belay <abelay@novell.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state
 improvements
In-Reply-To: <20051116180655.GC6908@suse.de>
Message-ID: <Pine.LNX.4.50.0511170849060.6343-100000@monsoon.he.net>
References: <1132111902.9809.59.camel@localhost.localdomain>
 <20051116063125.GE31375@suse.de> <1132125965.3656.15.camel@localhost.localdomain>
 <20051116180655.GC6908@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Nov 2005, Greg KH wrote:

> On Wed, Nov 16, 2005 at 02:26:04AM -0500, Adam Belay wrote:
> > On Tue, 2005-11-15 at 22:31 -0800, Greg KH wrote:
> > > On Tue, Nov 15, 2005 at 10:31:42PM -0500, Adam Belay wrote:
> > > > This patch makes some improvements to pci_save_state and
> > > > pci_restore_state.  Instead of saving and restoring all standard
> > > > registers (even read-only ones), it only restores necessary registers.
> > > > Also, the command register is handled more carefully.  Let me know if
> > > > I'm missing anything important.
> > > >
> > > >
> > > > --- a/drivers/pci/pm.c	2005-11-13 20:32:24.000000000 -0500
> > > > +++ b/drivers/pci/pm.c	2005-11-13 20:29:32.000000000 -0500
> > > > @@ -53,10 +53,13 @@
> > > >   */
> > > >  int pci_save_state(struct pci_dev *dev)
> > > >  {
> > > > -	int i;
> > > > -	/* XXX: 100% dword access ok here? */
> > > > -	for (i = 0; i < 16; i++)
> > > > -		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
> > > > +	struct pci_dev_config * conf = &dev->saved_config;
> > > > +
> > > > +	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
> > > > +	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
> > > > +	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
> > > > +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_line);
> > >
> > > Why are we saving and restoring smaller ammounts of config space now?
> >
> > After looking at the spec, it seems that most of the registers we were
> > restoring were read-only and couldn't possibly need to be restored.
> > Also, the PCI PM spec suggests that only a subset of the registers
> > should be restored.  Finally, things like BIST should probably never be
> > touched.
>
> Ok, but be aware that this _might_ cause problems for some cards/drivers
> that were relying on the old way...  As long as you don't mind me
> assigning those bugs to you, I don't have a problem with this :)

If any drivers have bugs in that area, then they most likely only worked
by accident in the first place. The confg space is mostly read-only
anyway, and there could be things we don't want to blindly overwrite. If
any drivers need more, they should save it themselves.



	Pat
