Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWJXXAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWJXXAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWJXXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:00:17 -0400
Received: from quartz.orcorp.ca ([142.179.161.236]:3802 "EHLO quartz.orcorp.ca")
	by vger.kernel.org with ESMTP id S1422778AbWJXXAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:00:15 -0400
Date: Tue, 24 Oct 2006 16:59:35 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>, linux-ia64@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [openib-general] Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024225935.GK4054@obsidianresearch.com>
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org> <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024223631.GT25210@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 04:36:32PM -0600, Matthew Wilcox wrote:
> On Tue, Oct 24, 2006 at 02:51:30PM -0700, Roland Dreier wrote:
> >  > I think the right way to fix this is to ensure mmio write ordering in
> >  > the pci_write_config_*() implementations.  Like this.
> > 
> > I'm happy to fix this in the PCI core and not force drivers to worry
> > about this.
> > 
> > John, can you confirm that this patch fixes the issue for you?
 
> Hang on.  I wasn't thinking clearly.  mmiowb() only ensures the write
> has got as far as the shub.  There's no way to fix this in the pci core

What about shifting the requirement down to the platform? Ie on ia64
it would seem that inb/outb already solve this problem via mf.a.

All platforms that support inb/outb correctly must have a
synchronizing primitive for outb..

> This is only really a problem for setup (when we program the BARs), so
> it seems silly to enforce an ordering at any other time.  Reluctantly, I
> must disagree with Jeff -- drivers need to fix this.

I'm not sure that can work either. The PCI-X spec is very clear, you
must wait for a non-posted completion if you care about order. Doing a
config read in the driver as a surrogate flush is not good enough in
the general case. Like you say, a pci bridge is free to reorder all
in flight non-posted operations.

Jason
