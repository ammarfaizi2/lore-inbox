Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIAVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIAVZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWIAVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:25:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7627 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750909AbWIAVZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:25:50 -0400
Date: Fri, 1 Sep 2006 16:25:48 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: pci error recovery procedure
Message-ID: <20060901212548.GS8704@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:33:49AM +0800, Zhang, Yanmin wrote:
> On Fri, 2006-09-01 at 01:50, Linas Vepstas wrote:
> > On Thu, Aug 31, 2006 at 03:10:12PM +0800, Zhang, Yanmin wrote:
> > > Linas,
> > > 
> > > I am reviewing the error handlers of e1000 driver and got some ideas. My
> > > startpoint is to simplify the err handler implementations for drivers, or
> > > driver developers are *not willing* to add it if it's too complicated.
> > 
> > I don't see that its to complicated ... 
> Originally, I didn't think so, but after I try to add err_handlers to some
> drivers, I feel it's too complicated.

Which drivers are you working on?

> > > 1) Callback mmio_enabled looks useless. Documentation/pci-error-recovery.txt
> > > says the current powerpc implementation does not implement this callback.
> > 
> > I don't know if its useless or not. I have not needed it yet for the
> > symbios, ipr and e1000 drivers, but its possible that some more
> > sophisticated device may want it. I'm tempted to keep it a while 
> > longer befoe discarding it.
> > 
> > The scenario is this: the device driver decides that, rather than asking
> > for a full electical reset of the card, instead, it wants to perform 
> > its own recovery. It can do this as follows:
> > 
> > a) enable MMIO
> > b) issue reset command to adapter
> > c) enable DMA.
> > 
> > If we enabled both DMA and MMIO at the same time, there are mnay cases
> > where the card will immediately trap again -- for example, if its
> > DMA'ing to some crazy address. Thus, typically, one wants DMA disabled 
> > until after the card reset.  Withouth the mmio_enabled() reset, there
> > is no way of doing this.
> The new error_resume, or the old slot_reset could take care of it. The specific
> device driver knows all the details about how to initiate the devices. The 
> error_resume could call the step a) b) c) sequencially while doing checking among
> steps.

Again, consider the multi-function cards. On pSeries, I can  only enable 
DMA on a er-slot basis, not a per-function basis. So if one driver
enables DMA before some other driver has reset appropriately, everything
breaks.

> If there is really a device having specific requirement to reinitiate it (very rarely),
> it could use walkaround, such like schedule a WORKER. No need to provide a generic
> mmio_enabled.

I don't understand. Enabling MMIO and enabling DMA both require specific
commands to be sent to the PCI-host bridge. These commands are not a
part of the PCI spec. 

> > > 2) Callback slot_reset could be merged with resume. The new resume could be:
> > > int (*error_resume)(struct pci_dev *dev); I checked e1000 and e100 drivers and
> > > think there is no actual reason to have both slot_reset and resume.
> > 
> > The idea here was to handle multi-function cards.  On a multi-function card, 
> > *all* devices need to indicate that they were able to reset. Once all devices 
> > have been successfuly reset, then operation can be resumed. If the reset 
> > of one function fails, then operation is not resumed for any f the
> > functions.
> I don't think we need slot_reset to coordinate multi-function devices. The new
> error_resume could take care of multi-function card. 

How? 

> 'reset' here means driver
> need do I/O to detect if the device (function) still works well. If a function
> of a multi-function device couldn't reset while other functions could reset,
> other functions could just go on to reinitiate. In the end, the error recovery
> procedure (handle_eeh_events in PowerPC implementation) could check all the
> returning values of error_resume. If there is a failure value, then removes
> all the functions' pci_dev of the device from the bus.

I can only enable or disable an entire PCI slot, and not individual PCI
functions. If there are some pins that are shorted, or parity errors or
whatever, I can only turn off the whole card. 

> > > During
> > > our last discussion on LKML, you said PowerPC will block further I/O if the platform captures
> > > a pci error, so the all I/O in e1000_down will be blocked. Later on, e1000_io_slot_reset
> > > will reenable pci device and initiate NIC. I guess late initiate might fail because prior
> > > e1000_down I/O don't reach NIC.
> > 
> > Why would it fail? The e1000_down serves primarily to get the Linux
> > kernel into a known state. It doesn't matter what happens to the card,
> > since the next step will be to perform an electrical reset of the card.
> Who will perform the electrical reset of the card? Function e1000_reset or the platform?

The platform. By "electrical reset", I mean "dropping the #RST pin low
for 200mS". Only the platform can do this.
 
> If it's the platform, I agree with you, but if it's e1000_reset, it might not work because
> e1000_reset uses a e1000-specific approach to reset the card.

The driver has to choices: it can ask for the electrical reset, by 
returning PCI_ERS_RESULT_NEED_RESET. But if the driver doesn't need
the electrical reset, then it can return PCI_ERS_RESULT_CAN_RECOVER,
and issue whatever device-specific commands it needs to reset.

> I'm not sure if the e1000_reset
> will restore the NIC to fresh system power-on state. At least, from the source codes, e1000_reset
> couldn't.

I have no idea. That's why this driver issues PCI_ERS_RESULT_NEED_RESET,
which will get it into a fresh system power-on state. Its easy, its
brute-force, it works.

--linas

-- 
VGER BF report: U 0.5
