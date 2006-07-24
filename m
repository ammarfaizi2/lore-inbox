Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWGXUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWGXUsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGXUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:48:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44268 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751441AbWGXUsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:48:03 -0400
Date: Mon, 24 Jul 2006 15:48:01 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 1/5] PCI-Express AER implemetation: aer howto document
Message-ID: <20060724204801.GE7448@austin.ibm.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com> <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

More late commentary ...

On Fri, Jul 14, 2006 at 01:25:49PM +0800, Zhang, Yanmin wrote:
> --- linux-2.6.17/Documentation/pcieaer-howto.txt	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.17_aer/Documentation/pcieaer-howto.txt	2006-07-14 11:09:37.000000000 +0800
> +6.1. Configuring the AER capability structure
> +
> +AER aware drivers of PCI Express component need change the device
> +control registers to enable AER. They also could change AER registers,
> +including mask and severity registers.

Hmm. Why not just enable error reporting for everything? Why make 
the device driver jump through this extra hoop?

If there is some really good reason not to enable reporting by default,
(which I cannot think of at the moment), then there's another
possiblity: enable error reporting if and only if the device
driver has struct pci_driver -> err_handler != NULL.

> +6.2. Provide PCI error-recovery callbacks
> +
> +If an error message indicates a non-fatal error, performing link reset
> +at upstream is not required. The AER driver calls error_detected(dev,
> +pci_channel_io_normal) to all drivers associated within a hierarchy in

Hmm. I would rather extend enum pci_channel_state to include a non-fatal 
error notification. That is, add pci_channel_io_nonfatal_error=4; to the enum.  

> +If an error message indicates a fatal error, kernel will broadcast
> +error_detected(dev, pci_channel_io_frozen) to all drivers within
> +a hierarchy in question. 

"The hierarchy in question" -- does that meen all drivers attached to
the root port?  Or only drivers that aree using some particular link?
You don't want to notify/reset every PCI slot in the system (that would
hurt!); ideally one rests only the one PCI slot that was affected.

> +As different kinds of devices might use different approaches
> +to reset link, AER port service driver is required to provide the
> +function to reset link. Firstly, kernel looks for if the upstream
> +component has an aer driver. If it has, kernel uses the reset_link
> +callback of the aer driver. 

I don't yet entirely understand link reset. However, the original
pci error recovery spec was written by assuming that it would be 
the aer root port driver that performs the link reset. The callback
link_reset() was to notify the device driver that the link was reset.

> +8. Frequent Asked Questions
> +
> +Q: What happens if a PCI Express device driver does not provide an
> +error recovery handle?

What's an "error recovery handle"? Does this refer to the 
struct pci_driver {
   struct pci_error_handlers *err_handler;
}

pointer?  I think it does, but at first this is unclear. 

> +Q: How does this infrastructure deal with driver that is not PCI
> +Express aware?
> +
> +A: This infrastructure calls the error callback functions of the
> +driver when an error happens. But if the driver is not aware of
> +PCI Express, the device might not report its own errors to root
> +port.

Which is a good reason to enable eror reporting by default, or at 
least, to enable error reporting when 
struct pci_driver->err_handler != NULL


--linas
