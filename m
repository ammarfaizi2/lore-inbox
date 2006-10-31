Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423628AbWJaUvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423628AbWJaUvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423627AbWJaUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:51:14 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:45714 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1423625AbWJaUvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:51:13 -0500
Date: Tue, 31 Oct 2006 22:50:04 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Richard B. Johnson" <jmodem@abominablefirebug.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, matthew@wil.cx,
       openib-general@openib.org, linux-pci@atrey.karlin.mff.cuni.cz,
       David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061031205004.GB6866@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <019301c6fd2c$044d7010$0732700a@djlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019301c6fd2c$044d7010$0732700a@djlaptop>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Richard B. Johnson <jmodem@abominablefirebug.com>:
> Subject: Re: Ordering between PCI config space writes and MMIO reads?
> 
> 
> ----- Original Message ----- 
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> To: "Roland Dreier" <rdreier@cisco.com>
> Cc: <linux-kernel@vger.kernel.org>; <linux-ia64@vger.kernel.org>; 
> <jeff@garzik.org>; <matthew@wil.cx>; <openib-general@openib.org>; 
> <linux-pci@atrey.karlin.mff.cuni.cz>; "David Miller" <davem@davemloft.net>
> Sent: Tuesday, October 31, 2006 2:53 PM
> Subject: Re: Ordering between PCI config space writes and MMIO reads?
> 
> 
> > Quoting r. Roland Dreier <rdreier@cisco.com>:
> >> Subject: Re: Ordering between PCI config space writes and MMIO reads?
> >>
> >> The discussion fizzled out without really reaching a definitive
> >> answer, so I'm going to apply the original patch (below), since I
> >> pretty much convinced myself that only the driver doing the config
> >> access has enough information to fix this reliably.
> >>
> >>  - R.
> >>
> >> Author: John Partridge <johnip@sgi.com>
> >> Date:   Tue Oct 31 11:00:04 2006 -0800
> >>
> >>     IB/mthca: Make sure all PCI config writes reach device before doing 
> >> MMIO
> >>
> >>     During initialization, mthca writes some PCI config space registers
> >>     and then does an MMIO read from one of the BARs it just enabled. 
> >> This
> >>     MMIO read sometimes failed and caused a crash on SGI Altix machines,
> >>     because the PCI-X host bridge (legitimately, according to the PCI
> >>     spec) allowed the MMIO read to start before the config write 
> >> completed.
> >>
> >>     To fix this, add a config read after all config writes to make sure
> >>     they are all done before starting the MMIO read.
> >>
> >>     Signed-off-by: John Partridge <johnip@sgi.com>
> >>     Signed-off-by: Roland Dreier <rolandd@cisco.com>
> >>
> >> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c 
> >> b/drivers/infiniband/hw/mthca/mthca_reset.c
> >> index 91934f2..578dc7c 100644
> >> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
> >> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
> >> @@ -281,6 +281,20 @@ good:
> >>  goto out;
> >>  }
> >>
> >> + /*
> >> + * Perform a "flush" of the PCI config writes here by reading
> >> + * the PCI_COMMAND register.  This is needed to make sure that
> >> + * we don't try to touch other PCI BARs before the config
> >> + * writes are done -- otherwise an MMIO cycle could start
> >> + * before the config writes are done and reach the HCA before
> >> + * the BAR is actually enabled.
> >> + */
> >> + if (pci_read_config_dword(mdev->pdev, PCI_COMMAND, hca_header)) {
> >> + err = -ENODEV;
> >> + mthca_err(mdev, "Couldn't access HCA memory after restoring, "
> >> +   "aborting.\n");
> >> + }
> >> +
> >>  out:
> >>  if (bridge)
> >>  pci_dev_put(bridge);
> >
> > Here's what I don't understand: according to PCI rules, pci config read
> > can bypass pci config write (both are non-posted).
> > So why does doing it help flush the writes as the comment claims?
> >
> > Isn't this more the case of
> > /* pci_config_write seems to complete asynchronously on Altix systems.
> > * This is probably broken but its not clear what's the best
> > * thing to do is - for now, do pci_read_config_dword which seems to flush
> > * everything out. */
> >
> 
> If you write to the PCI bus and then you read the result, the read __might__
> be the read that flushes any posted writes rather than the read of device
> registers that would occur after the BARs were configured (hardware may be
> slower than the CPU). So, it's best to do the required configuration cycles
> first, then after all is done, read  something before you actually need to use
> data from subsequent read/write cycles.

But why should it help? Accordig to the spec, read does not flush configuration
writes (unlike regular writes).

-- 
MST
