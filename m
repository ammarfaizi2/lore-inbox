Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVKPHRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVKPHRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVKPHRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:17:17 -0500
Received: from peabody.ximian.com ([130.57.169.10]:18904 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751458AbVKPHRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:17:16 -0500
Subject: Re: [RFC][PATCH 6/6] PCI PM: pci_save/restore_state improvements
From: Adam Belay <abelay@novell.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116063125.GE31375@suse.de>
References: <1132111902.9809.59.camel@localhost.localdomain>
	 <20051116063125.GE31375@suse.de>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 02:26:04 -0500
Message-Id: <1132125965.3656.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 22:31 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:31:42PM -0500, Adam Belay wrote:
> > This patch makes some improvements to pci_save_state and
> > pci_restore_state.  Instead of saving and restoring all standard
> > registers (even read-only ones), it only restores necessary registers.
> > Also, the command register is handled more carefully.  Let me know if
> > I'm missing anything important.
> > 
> > 
> > --- a/drivers/pci/pm.c	2005-11-13 20:32:24.000000000 -0500
> > +++ b/drivers/pci/pm.c	2005-11-13 20:29:32.000000000 -0500
> > @@ -53,10 +53,13 @@
> >   */
> >  int pci_save_state(struct pci_dev *dev)
> >  {
> > -	int i;
> > -	/* XXX: 100% dword access ok here? */
> > -	for (i = 0; i < 16; i++)
> > -		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
> > +	struct pci_dev_config * conf = &dev->saved_config;
> > +
> > +	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
> > +	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
> > +	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
> > +	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_line);
> 
> Why are we saving and restoring smaller ammounts of config space now?

After looking at the spec, it seems that most of the registers we were
restoring were read-only and couldn't possibly need to be restored.
Also, the PCI PM spec suggests that only a subset of the registers
should be restored.  Finally, things like BIST should probably never be
touched.

This patch is one of the main reasons I'm looking for comments.  I
wanted to see if there are any other necessary registers.  I'm also
thinking we might want to restore some capability structures (which we
don't do now).

Thanks,
Adam


