Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWGXTh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWGXTh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 15:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWGXThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 15:37:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65460 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751376AbWGXThy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 15:37:54 -0400
Date: Mon, 24 Jul 2006 14:37:52 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 5/5] PCI-Express AER implemetation: pcie_portdrv error handler
Message-ID: <20060724193752.GD7448@austin.ibm.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com> <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com> <1152854873.28493.289.camel@ymzhang-perf.sh.intel.com> <1152854937.28493.291.camel@ymzhang-perf.sh.intel.com> <1152855040.28493.294.camel@ymzhang-perf.sh.intel.com> <1152855124.28493.297.camel@ymzhang-perf.sh.intel.com> <1152855338.28493.300.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152855338.28493.300.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sorry for a late reply...

On Fri, Jul 14, 2006 at 01:35:38PM +0800, Zhang, Yanmin wrote:
> 
> --- linux-2.6.17/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:27:35.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:46:29.000000000 +0800
> +
> +static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> +					enum pci_channel_state error)
> +{
> +	/* If fatal, save cfg space for possible link reset at upstream */
> +	if (error == pci_channel_io_frozen)
> +		pcie_portdrv_save_config(dev);

If the channel is frozen, is the config space still readable? 
In my case, I had to save config space data early on before
the bus error. 

What's more, I discovered that I had to save the pci config 
space data before device drivers do thier probe. During the probe, 
device drivers will change the config. For example, they'll enable
interrupts and dma. If you turn these on, and then do the probe,
you'll get spectacuar failures.

To be safe, I found the best thing to do was to save the pci
config space state as it was during boot, before the PCI probe 
routines ran.

--linas
