Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWGZFuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWGZFuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 01:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWGZFuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 01:50:06 -0400
Received: from mga06.intel.com ([134.134.136.21]:17060 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751341AbWGZFuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 01:50:05 -0400
X-IronPort-AV: i="4.07,181,1151910000"; 
   d="scan'208"; a="70473409:sNHT67652949"
Subject: Re: [PATCH 1/5] PCI-Express AER implemetation: aer howto document
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060724204801.GE7448@austin.ibm.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
	 <20060724204801.GE7448@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1153892923.3984.53.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 26 Jul 2006 13:48:48 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 04:48, Linas Vepstas wrote:
> Hi,
> 
> More late commentary ...
> 
> On Fri, Jul 14, 2006 at 01:25:49PM +0800, Zhang, Yanmin wrote:
> > --- linux-2.6.17/Documentation/pcieaer-howto.txt	1970-01-01 08:00:00.000000000 +0800
> > +++ linux-2.6.17_aer/Documentation/pcieaer-howto.txt	2006-07-14 11:09:37.000000000 +0800
> > +6.1. Configuring the AER capability structure
> > +
> > +AER aware drivers of PCI Express component need change the device
> > +control registers to enable AER. They also could change AER registers,
> > +including mask and severity registers.
> 
> Hmm. Why not just enable error reporting for everything? Why make 
> the device driver jump through this extra hoop?
> If there is some really good reason not to enable reporting by default,
> (which I cannot think of at the moment), then there's another
> possiblity: enable error reporting if and only if the device
> driver has struct pci_driver -> err_handler != NULL.
It could be a reason. If we choose to enable AER for all devices by default, we
could do so in function pci_enable_device. Then, aerdriver could only be compiled
into kernel instead of a module.

> 
> > +6.2. Provide PCI error-recovery callbacks
> > +
> > +If an error message indicates a non-fatal error, performing link reset
> > +at upstream is not required. The AER driver calls error_detected(dev,
> > +pci_channel_io_normal) to all drivers associated within a hierarchy in
> 
> Hmm. I would rather extend enum pci_channel_state to include a non-fatal 
> error notification. That is, add pci_channel_io_nonfatal_error=4; to the enum.
It looks like good, but makes things complicated. I once wrote the error handlers
for tg3 pci-e driver and felt it's not easy to follow pci-error-recovery.txt.

Just like the driver error handlers of some NIC you wrote before, you chose
to do slot reset for all errors. Is it really useful to add a new state? 

>   
> 
> > +If an error message indicates a fatal error, kernel will broadcast
> > +error_detected(dev, pci_channel_io_frozen) to all drivers within
> > +a hierarchy in question. 
> 
> "The hierarchy in question" -- does that meen all drivers attached to
> the root port?  Or only drivers that aree using some particular link?
> You don't want to notify/reset every PCI slot in the system (that would
> hurt!); ideally one rests only the one PCI slot that was affected.
The hierarchy consists of just all the devices below the device who reports
the error to root port. For example, assume device tg3 NIC connects to bridge
A. The connection is like:
NIC<==>Downstream port B<==>Upstream port A<==>Root port.

If Upstream port A captures an AER error, the hierarchy consists of
Downstream port B and NIC.

> 
> > +As different kinds of devices might use different approaches
> > +to reset link, AER port service driver is required to provide the
> > +function to reset link. Firstly, kernel looks for if the upstream
> > +component has an aer driver. If it has, kernel uses the reset_link
> > +callback of the aer driver. 
> 
> I don't yet entirely understand link reset. However, the original
> pci error recovery spec was written by assuming that it would be 
> the aer root port driver that performs the link reset.
aer root port driver is just AER port service driver. Specific switch's
upstream port might have different link reset method. 


>  The callback
> link_reset() was to notify the device driver that the link was reset.
Callback link_reset definition is confusing and causes driver error handlers
too complicated. The link reset only happens when a fatal error happens,
driver should do a full recovery.

> 
> > +8. Frequent Asked Questions
> > +
> > +Q: What happens if a PCI Express device driver does not provide an
> > +error recovery handle?
> 
> What's an "error recovery handle"? Does this refer to the 
> struct pci_driver {
>    struct pci_error_handlers *err_handler;
> }
> 
> pointer?  I think it does, but at first this is unclear. 
Yes. I will add more pointers.

> 
> > +Q: How does this infrastructure deal with driver that is not PCI
> > +Express aware?
> > +
> > +A: This infrastructure calls the error callback functions of the
> > +driver when an error happens. But if the driver is not aware of
> > +PCI Express, the device might not report its own errors to root
> > +port.
> 
> Which is a good reason to enable eror reporting by default, or at 
> least, to enable error reporting when 
> struct pci_driver->err_handler != NULL
Is it true for bridges (Upstream port and downstream port)? Most bridges
have no drivers, not mentioning error handlers.
Currently, I choose to enable AER for all ports (bridges) by default.

Thanks,
Yanmin
