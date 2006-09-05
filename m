Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWIETRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWIETRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWIETRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:17:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62117 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030263AbWIETRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:17:41 -0400
Date: Tue, 5 Sep 2006 14:17:39 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: Re: pci error recovery procedure
Message-ID: <20060905191739.GF7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 01:47:30PM +0800, Zhang, Yanmin wrote:
> > 
> > Again, consider the multi-function cards. On pSeries, I can  only enable 
> > DMA on a per-slot basis, not a per-function basis. So if one driver
> > enables DMA before some other driver has reset appropriately, everything
> > breaks.
> Does here 'reset' mean hardware slot reset? 

I should have said: If one driver of a multi-function card enables DMA before 
another driver has stabilized its harware, then everything breaks.

> Then, if the slot is always reset, there will be no the problem. 

But that assumes that a hardware #RST will always be done. The API
was designed to get away from this requirement.

> If mmio_enabled is not used currently, I think we could delete it firstly. Later on,
> if a platform really need it, we could add it, so we could keep the simplied codes.

It would be very difficult to add it later. And it would be especially
silly, given that someone would find this discussion in the mailing list 
archives.

> Thanks. Now I understand why you specified mmio_enabled and slot_reset. They are just
> to map to pSeries platform hardware operation steps. I know little about pSeries hardware,

The hardware was designed that way because the hardware engineers
thought that this is what the device driver writers would need. 
Thay are there to map to actual recovery steps that actual device
drivers might want to do.

> but is it possible to merge such hardware steps from software point of view?

The previous email explained why this would be a bad idea. 

> > The platform. By "electrical reset", I mean "dropping the #RST pin low
> > for 200mS". Only the platform can do this.
> Thanks for your explanation. I assume after the electrical reset, all device
> functions of the device slot will go back to the initial status before
> attaching their drivers.

Maybe. Depends on what yur BIOS does. On pSeries, I also need to
set up the adress BARs

> I found a problem of e1000 driver when testing its error handlers. After the NIC is resumed,
> its RX/TX packets numbers are crazy.

Hmm. There is a patch to prevent this from happening. I thought
it was applied a long time ago. e1000_update_stats() should include the
lines:

   if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
      return;

which is enough to prevent crazy stats on my machine.

--linas
