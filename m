Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWJXX23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWJXX23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJXX23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:28:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10409 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422806AbWJXX22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:28:28 -0400
Date: Tue, 24 Oct 2006 18:27:55 -0500
From: Jack Steiner <steiner@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Roland Dreier <rdreier@cisco.com>, Jeff Garzik <jeff@garzik.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024232755.GA26521@sgi.com>
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
> 
> Hang on.  I wasn't thinking clearly.  mmiowb() only ensures the write
> has got as far as the shub.  

I think mmiowb() should work on SN hardware. mmiowb() delays until shub
reports that all previously issued PIO writes have completed. 

The processor "mf.a" guarantees "platform acceptance" which on SN means
that shub has accepted the write - not that it has actually completed (or
even forwarded anywhere by shub). That makes "mf.a" more-or-less useless
on SN. However, shub has an additional MMR register (PIO_WRITE_COUNT) that
counts actual outstanding PIOs.  mmiob() delays until that count goes to
zero.

I'll check if there is any additional reordering that can occur AFTER the
PIO_WRITE_COUNT goes to zero.  If so, it would be at bus level - not in
shub or routers.


> There's no way to fix this in the pci core
> -- any PCI-PCI bridge can reorder the two.
> 
> This is only really a problem for setup (when we program the BARs), so
> it seems silly to enforce an ordering at any other time.  Reluctantly, I
> must disagree with Jeff -- drivers need to fix this.

-- jack
