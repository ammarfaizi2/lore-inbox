Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIFUjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIFUjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWIFUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:39:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34732 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751167AbWIFUjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:39:41 -0400
Date: Wed, 6 Sep 2006 15:39:39 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: Re: pci error recovery procedure
Message-ID: <20060906203939.GM7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com> <20060905191739.GF7139@austin.ibm.com> <1157508270.20092.426.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157508270.20092.426.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 10:04:31AM +0800, Zhang, Yanmin wrote:
> On Wed, 2006-09-06 at 03:17, Linas Vepstas wrote:
> > On Mon, Sep 04, 2006 at 01:47:30PM +0800, Zhang, Yanmin wrote:
> > > > 
> > > > Again, consider the multi-function cards. On pSeries, I can  only enable 
> > > > DMA on a per-slot basis, not a per-function basis. So if one driver
> > > > enables DMA before some other driver has reset appropriately, everything
> > > > breaks.
> > > Does here 'reset' mean hardware slot reset? 
> > 
> > I should have said: If one driver of a multi-function card enables DMA before 
> > another driver has stabilized its harware, then everything breaks.
> What's another driver's hardware? A function of the previous multi-function
> card? Or a function of another device?

Yes. Either. Both. Doesn't matter.  Enabling DMA is "granular" at a 
different size scale than pci functions, and possibly even pci devices 
or slots, dependeing on the architecture. Before DMA can be enabled, 
*all* affected device drivers have to be approve, and have to be ready
for it. 

> > If we enabled both DMA and MMIO at the same time, there are many cases
> > where the card will immediately trap again -- for example, if its
> > DMA'ing to some crazy address. Thus, typically, one wants DMA disabled 
> > until after the card reset.  Without the mmio_enabled() reset, there
> > is no way of doing this.
>
> Did you asume the card reset is executed by callback mmio_enabled?

I am assuming that, when a driver receives the mmio_enabled() callback,
it will perform some sort of register i/o.  For example, I am currently
planning to modify the e1000 driver to do the following:

-- The error_occurred() callback returns PCI_ERS_RESULT_CAN_RECOVER
-- The arch enables mmio, and then calls the mmio_enabled() callback.
-- The mmio_enabled() callback in the driver takes a full dump of all 
   of the regsters on the card.  It then returns PCI_ERS_RESULT_NEED_RESET
-- The arch performs the full electrical #RST of device. Recovery from
   this point proceeds as before.

> > Again, consider the multi-function cards. On pSeries, I can only enable 
> > DMA on a per-slot basis, not a per-function basis. So if one driver
> > enables DMA before some other driver has reset appropriately, everything
> > breaks.
>
> What does 'I' above stand for? The platform error recovery procedure

Yes. The pSeries platform error recovery procedure can only enable DMA
on a per-slot basis.

> I guess it means platform, that is,
> only platform enables DMA for the whole slot. 

Yes.

> But why does the last sentence
> become driver enables DMA? 

In your proposal, you were suggesting that MMIO and DMA be enabled with 
one and the same routine, and I was attempting to explain why that can't
work.

> Could driver enable DMA for a function?

No, not on pSeries hardware.

> > > If mmio_enabled is not used currently, I think we could delete it firstly. Later on,
> > > if a platform really need it, we could add it, so we could keep the simplied codes.
> > 
> > It would be very difficult to add it later. And it would be especially
> > silly, given that someone would find this discussion in the mailing list 
> > archives.
> You stick to keep mmio_enabled which is not used currently, but if there will be
> a new platform who uses a more fine-grained steps to recover pci/pci-e, would
> you say 'it would be very difficut' and refuse add new callbacks?

Yes. 

> It doesn't prevent software from merging some steps. And, we want
> to implement pci/pci-e error recovery for more platforms instead of just
> pSeries.

Yes. The API was designed so that it could be supported on every
current and future platform we could think of. You haven't yet
claimed that "pci-e can't be supported".  Based on what 
I understand, changing the API wouldn't make the implementation 
any easier. (It is very easy to call a callback, and then 
examine its return value. Removing a few callbacks does not
materially simplify the recovery mechanism. Managing these
callbacks is *not* the hard part of implementing this thing.)

--linas
