Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVKQXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVKQXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVKQXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:41:25 -0500
Received: from peabody.ximian.com ([130.57.169.10]:21212 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965118AbVKQXlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:41:24 -0500
Subject: Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
From: Adam Belay <abelay@novell.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116180655.GC6908@suse.de>
References: <1132111902.9809.59.camel@localhost.localdomain>
	 <20051116063125.GE31375@suse.de>
	 <1132125965.3656.15.camel@localhost.localdomain>
	 <20051116180655.GC6908@suse.de>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 18:50:30 -0500
Message-Id: <1132271430.3656.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 10:06 -0800, Greg KH wrote:
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

I'm probably going to regret this, but I'd be happy to take on any PCI
PM subsystem bug reports.  Unless I forgot a register we need to
restore, I'm not expecting this to cause too many problems.  A little
time in -mm should shake out any issues out rather quickly.

Thanks,
Adam


