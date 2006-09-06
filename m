Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWIFCGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWIFCGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 22:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWIFCGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 22:06:18 -0400
Received: from mga05.intel.com ([192.55.52.89]:57364 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S965232AbWIFCGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 22:06:17 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,209,1154934000"; 
   d="scan'208"; a="126346015:sNHT61303116"
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <20060905191739.GF7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	 <20060831175001.GE8704@austin.ibm.com>
	 <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	 <20060901212548.GS8704@austin.ibm.com>
	 <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	 <20060905191739.GF7139@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157508270.20092.426.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Sep 2006 10:04:31 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 03:17, Linas Vepstas wrote:
> On Mon, Sep 04, 2006 at 01:47:30PM +0800, Zhang, Yanmin wrote:
> > > 
> > > Again, consider the multi-function cards. On pSeries, I can  only enable 
> > > DMA on a per-slot basis, not a per-function basis. So if one driver
> > > enables DMA before some other driver has reset appropriately, everything
> > > breaks.
> > Does here 'reset' mean hardware slot reset? 
> 
> I should have said: If one driver of a multi-function card enables DMA before 
> another driver has stabilized its harware, then everything breaks.
What's another driver's hardware? A function of the previous multi-function
card? Or a function of another device?

Ok. now, I copy what you said before below for more discussion.
> If we enabled both DMA and MMIO at the same time, there are mnay cases
> where the card will immediately trap again -- for example, if its
> DMA'ing to some crazy address. Thus, typically, one wants DMA disabled 
> until after the card reset.  Withouth the mmio_enabled() reset, there
> is no way of doing this.
Did you asume the card reset is executed by callback mmio_enabled?


> Again, consider the multi-function cards. On pSeries, I can  only enable 
> DMA on a er-slot basis, not a per-function basis. So if one driver
> enables DMA before some other driver has reset appropriately, everything
> breaks.
What does 'I' above stand for? The platform error recovery procedure
or the error callbacks of drivers? I guess it means platform, that is,
only platform enables DMA for the whole slot. But why does the last sentence
become driver enables DMA? As you know, driver binds device function instead of
slot. Could driver enable DMA for a function?


> 
> > Then, if the slot is always reset, there will be no the problem. 
> 
> But that assumes that a hardware #RST will always be done. The API
> was designed to get away from this requirement.
> 
> > If mmio_enabled is not used currently, I think we could delete it firstly. Later on,
> > if a platform really need it, we could add it, so we could keep the simplied codes.
> 
> It would be very difficult to add it later. And it would be especially
> silly, given that someone would find this discussion in the mailing list 
> archives.
You stick to keep mmio_enabled which is not used currently, but if there will be
a new platform who uses a more fine-grained steps to recover pci/pci-e, would
you say 'it would be very difficut' and refuse add new callbacks?

> 
> > Thanks. Now I understand why you specified mmio_enabled and slot_reset. They are just
> > to map to pSeries platform hardware operation steps. I know little about pSeries hardware,
> 
> The hardware was designed that way because the hardware engineers
> thought that this is what the device driver writers would need. 
> Thay are there to map to actual recovery steps that actual device
> drivers might want to do.
It doesn't prevent software from merging some steps. And, we want
to implement pci/pci-e error recovery for more platforms instead of just
pSeries.

> 
> > but is it possible to merge such hardware steps from software point of view?
> 
> The previous email explained why this would be a bad idea. 
Obviously, such conclusion is too early.

> 
> > > The platform. By "electrical reset", I mean "dropping the #RST pin low
> > > for 200mS". Only the platform can do this.
> > Thanks for your explanation. I assume after the electrical reset, all device
> > functions of the device slot will go back to the initial status before
> > attaching their drivers.
> 
> Maybe. Depends on what yur BIOS does. On pSeries, I also need to
> set up the adress BARs
> 
> > I found a problem of e1000 driver when testing its error handlers. After the NIC is resumed,
> > its RX/TX packets numbers are crazy.
> 
> Hmm. There is a patch to prevent this from happening. I thought
> it was applied a long time ago. e1000_update_stats() should include the
> lines:
> 
>    if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
>       return;
> 
> which is enough to prevent crazy stats on my machine.
Thanks a lot!

Yanmin
