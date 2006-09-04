Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWIDFta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWIDFta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWIDFta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:49:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:14374 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932329AbWIDFt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:49:28 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,205,1154934000"; 
   d="scan'208"; a="120310942:sNHT422559620"
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <20060901212548.GS8704@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	 <20060831175001.GE8704@austin.ibm.com>
	 <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	 <20060901212548.GS8704@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 04 Sep 2006 13:47:30 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-02 at 05:25, Linas Vepstas wrote:
> On Fri, Sep 01, 2006 at 11:33:49AM +0800, Zhang, Yanmin wrote:
> > On Fri, 2006-09-01 at 01:50, Linas Vepstas wrote:
> > > On Thu, Aug 31, 2006 at 03:10:12PM +0800, Zhang, Yanmin wrote:
> > > > Linas,
> > > > 
> > > > I am reviewing the error handlers of e1000 driver and got some ideas. My
> > > > startpoint is to simplify the err handler implementations for drivers, or
> > > > driver developers are *not willing* to add it if it's too complicated.
> > > 
> > > I don't see that its to complicated ... 
> > Originally, I didn't think so, but after I try to add err_handlers to some
> > drivers, I feel it's too complicated.
> 
> Which drivers are you working on?
I worked out error handlers for tg3 NIC driver. I'm also checking e1000 driver
to try to move all I/O operations from e1000_io_error_detected to e1000_io_slot_reset.

> 
> > > > 1) Callback mmio_enabled looks useless. Documentation/pci-error-recovery.txt
> > > > says the current powerpc implementation does not implement this callback.
> > > 
> > > I don't know if its useless or not. I have not needed it yet for the
> > > symbios, ipr and e1000 drivers, but its possible that some more
> > > sophisticated device may want it. I'm tempted to keep it a while 
> > > longer befoe discarding it.
> > > 
> > > The scenario is this: the device driver decides that, rather than asking
> > > for a full electical reset of the card, instead, it wants to perform 
> > > its own recovery. It can do this as follows:
> > > 
> > > a) enable MMIO
> > > b) issue reset command to adapter
> > > c) enable DMA.
> > > 
> > > If we enabled both DMA and MMIO at the same time, there are mnay cases
> > > where the card will immediately trap again -- for example, if its
> > > DMA'ing to some crazy address. Thus, typically, one wants DMA disabled 
> > > until after the card reset.
I think most drivers' error_detected callbacks return PCI_ERS_RESULT_NEED_RESET,
so the slot will be reset. Then, the example that one wants DMA disabled
until after the card reset is not reasonable.


>   Withouth the mmio_enabled() reset, there
> > > is no way of doing this.
> > The new error_resume, or the old slot_reset could take care of it. The specific
> > device driver knows all the details about how to initiate the devices. The 
> > error_resume could call the step a) b) c) sequencially while doing checking among
> > steps.
> 
> Again, consider the multi-function cards. On pSeries, I can  only enable 
> DMA on a er-slot basis, not a per-function basis. So if one driver
> enables DMA before some other driver has reset appropriately, everything
> breaks.
Does here 'reset' mean hardware slot reset? In error_detected, driver 
needs cancel all pending request and don't start any I/O operations. 
Then, if the slot is always reset, there will be no the problem. Function
handle_eeh_events always resets slot except hard failure. See beow more comments.

As you know, all functions of a device share the same bus number and 5 bit dev number.
They just have different 3 bit function number. We could deduce if functions are in the same
device (slot).

If mmio_enabled is not used currently, I think we could delete it firstly. Later on,
if a platform really need it, we could add it, so we could keep the simplied codes.

> 
> > If there is really a device having specific requirement to reinitiate it (very rarely),
> > it could use walkaround, such like schedule a WORKER. No need to provide a generic
> > mmio_enabled.
> 
> I don't understand. Enabling MMIO and enabling DMA both require specific
> commands to be sent to the PCI-host bridge. These commands are not a
> part of the PCI spec.
Thanks. Now I understand why you specified mmio_enabled and slot_reset. They are just
to map to pSeries platform hardware operation steps. I know little about pSeries hardware,
but is it possible to merge such hardware steps from software point of view?

I checked the source codes of pSeries eeh_driver. Function handle_eeh_events does nothing
between pci_walk_bus(frozen_bus, eeh_report_reset, NULL) and
pci_walk_bus(frozen_bus, eeh_report_resume, NULL), that is, it doesn't enable DMA after
slot_reset. handle_eeh_events always resets slot except hard failure. So, slot_reset
could be merged with resume.


>  
> 
> > > > 2) Callback slot_reset could be merged with resume. The new resume could be:
> > > > int (*error_resume)(struct pci_dev *dev); I checked e1000 and e100 drivers and
> > > > think there is no actual reason to have both slot_reset and resume.
> > > 
> > > The idea here was to handle multi-function cards.  On a multi-function card, 
> > > *all* devices need to indicate that they were able to reset. Once all devices 
> > > have been successfuly reset, then operation can be resumed. If the reset 
> > > of one function fails, then operation is not resumed for any f the
> > > functions.
> > I don't think we need slot_reset to coordinate multi-function devices. The new
> > error_resume could take care of multi-function card. 
> 
> How? 
> 
> > 'reset' here means driver
> > need do I/O to detect if the device (function) still works well. If a function
> > of a multi-function device couldn't reset while other functions could reset,
> > other functions could just go on to reinitiate. In the end, the error recovery
> > procedure (handle_eeh_events in PowerPC implementation) could check all the
> > returning values of error_resume. If there is a failure value, then removes
> > all the functions' pci_dev of the device from the bus.
> 
> I can only enable or disable an entire PCI slot, and not individual PCI
> functions. If there are some pins that are shorted, or parity errors or
> whatever, I can only turn off the whole card.
It doesn't matter with the simplification. I don't mean that a device function
should be disabled immediately after the error_resume of the function driver
returns.The disable operation could be delayed till all error_resume return. 

>  
> 
> > > > During
> > > > our last discussion on LKML, you said PowerPC will block further I/O if the platform captures
> > > > a pci error, so the all I/O in e1000_down will be blocked. Later on, e1000_io_slot_reset
> > > > will reenable pci device and initiate NIC. I guess late initiate might fail because prior
> > > > e1000_down I/O don't reach NIC.
> > > 
> > > Why would it fail? The e1000_down serves primarily to get the Linux
> > > kernel into a known state. It doesn't matter what happens to the card,
> > > since the next step will be to perform an electrical reset of the card.
> > Who will perform the electrical reset of the card? Function e1000_reset or the platform?
> 
> The platform. By "electrical reset", I mean "dropping the #RST pin low
> for 200mS". Only the platform can do this.
Thanks for your explanation. I assume after the electrical reset, all device
functions of the device slot will go back to the initial status before
attaching their drivers.

>  
> > If it's the platform, I agree with you, but if it's e1000_reset, it might not work because
> > e1000_reset uses a e1000-specific approach to reset the card.
> 
> The driver has to choices: it can ask for the electrical reset, by 
> returning PCI_ERS_RESULT_NEED_RESET. But if the driver doesn't need
> the electrical reset, then it can return PCI_ERS_RESULT_CAN_RECOVER,
> and issue whatever device-specific commands it needs to reset.
> > I'm not sure if the e1000_reset
> > will restore the NIC to fresh system power-on state. At least, from the source codes, e1000_reset
> > couldn't.
> 
> I have no idea. That's why this driver issues PCI_ERS_RESULT_NEED_RESET,
> which will get it into a fresh system power-on state. Its easy, its
> brute-force, it works.
I found a problem of e1000 driver when testing its error handlers. After the NIC is resumed,
its RX/TX packets numbers are crazy. Now, I think it's a bug of function e1000_reset, not
the error handlers. Sorry for bothering you on e1000.

I copy another email below, so we could keep the discussion in one thread.
On Fri, Sep 01, 2006 at 05:04:09PM +0800, Zhang, Yanmin wrote:
> > One more comment: The second parameter of error_detected also could be deleted
> > because recovery procedures will save error to pci_dev->error_state.
> 
> Yes, I beleive so.
Thanks.

> 
> > So, the err_handler pci_error_handlers could be:
> > struct pci_error_handlers
> > {
> >         pci_ers_result_t (*error_detected)(struct pci_dev *dev);
> >         pci_ers_result_t (*error_resume)(struct pci_dev *dev);
> > };
> 
> No, as per other email, we still need a multi-step process for
> multi-function cards,
As above discussion, reset slot could resolve it like you did for pSeries.

>  and for cards that may not want to get
> a full electrical reset.
So I think slot is reset only when a error_detected returns
PCI_ERS_RESULT_NEED_RESET.

> Finally, there might be platforms 
> that cannot perform a per-slot electrical reset, and would 
> therefore require drivers that can recover on thier own.
The new pci_error_handlers could process it easily. The driver's error_resume just
need schedule a driver-specific worker and returns PCI_ERS_RESULT_RECOVERED. The
worker could do recover on the driver own later on.

By checking drivers who support err_handler in the latest kernel, we could find
they all returns PCI_ERS_RESULT_NEED_RESET. They all could be converted to
use the new simplified pci_error_handlers. The new pci_error_handlers also gives
drivers flexibility to have more control on error recovery.

It's hard to look for a perfect solution. I mean, it's a trade-off. As long as
it could finish most functionality, the simpler, the better.

Yanmin

-- 
VGER BF report: H 0.00323297
