Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWKBDFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWKBDFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWKBDFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:05:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15763 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751645AbWKBDFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:05:30 -0500
Date: Wed, 1 Nov 2006 19:05:11 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Jack Steiner <steiner@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Roland Dreier <rdreier@cisco.com>,
       Jeff Garzik <jeff@garzik.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061102030511.GS150820@sgi.com>
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org> <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024232755.GA26521@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024232755.GA26521@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 06:27:55PM -0500, Jack Steiner wrote:
> On Tue, Oct 24, 2006 at 04:36:32PM -0600, Matthew Wilcox wrote:
> > On Tue, Oct 24, 2006 at 02:51:30PM -0700, Roland Dreier wrote:
> > >  > I think the right way to fix this is to ensure mmio write ordering in
> > >  > the pci_write_config_*() implementations.  Like this.
> > > 
> > > I'm happy to fix this in the PCI core and not force drivers to worry
> > > about this.
> > > 
> > > John, can you confirm that this patch fixes the issue for you?
> > 
> > Hang on.  I wasn't thinking clearly.  mmiowb() only ensures the write
> > has got as far as the shub.  
> 
> I think mmiowb() should work on SN hardware. mmiowb() delays until shub
> reports that all previously issued PIO writes have completed. 
> 
> The processor "mf.a" guarantees "platform acceptance" which on SN means
> that shub has accepted the write - not that it has actually completed (or
> even forwarded anywhere by shub). That makes "mf.a" more-or-less useless
> on SN. However, shub has an additional MMR register (PIO_WRITE_COUNT) that
> counts actual outstanding PIOs.  mmiob() delays until that count goes to
> zero.
> 
> I'll check if there is any additional reordering that can occur AFTER the
> PIO_WRITE_COUNT goes to zero.  If so, it would be at bus level - not in
> shub or routers.

As I understand it, the mmiowb on the shub waits only for the PIO write
to be accepted by the destination node (shub or tio) that the I/O device
is attached to, thus guaranteeing that no reordering will happen within
the NL.

If the PPB can reorder the write, then mmiowb is not sufficient.  You'd
have to do a readback from a chip register (assuming you can trust the
PPB not to reorder reads and writes), or some other work around I haven't
thought of.

jeremy
