Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWJXVCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWJXVCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWJXVCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:02:12 -0400
Received: from rrcs-mta-04.hrndva.rr.com ([24.28.200.156]:50426 "EHLO
	rrcs-mta-04.hrndva.rr.com") by vger.kernel.org with ESMTP
	id S965199AbWJXVCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:02:10 -0400
Message-ID: <00df01c6f7af$91af9aa0$7401a8c0@Maelstrom>
From: "JWM" <jwm@systemfabricworks.com>
To: <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-ia64@vger.kernel.org>,
       "Roland Dreier" <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
References: <adafyddcysw.fsf@cisco.com>
Subject: Re: [openib-general] Ordering between PCI config space writes and MMIO reads?
Date: Tue, 24 Oct 2006 16:01:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On IA64 there are two memory barriers mf and mf.a. To protect against 
the scenario below mf.a (slower of course) would be required.
    ....JW
----- Original Message ----- 
From: "Roland Dreier" <rdreier@cisco.com>
To: <linux-pci@atrey.karlin.mff.cuni.cz>; <linux-ia64@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>; <openib-general@openib.org>
Sent: Tuesday, October 24, 2006 2:13 PM
Subject: [openib-general] Ordering between PCI config space writes and MMIO 
reads?


> John Partridge found an interesting bug involving mthca (Mellanox
> InfiniBand HCA driver) on IA64/Altix systems.  Basically, during
> initialization, mthca does:
>
>    - do some config writes, including enabling BARs
>    - then start a firmware command
>      - read an MMIO register from a BAR (to check if FW is busy)
>
> However, John found that the Altix PCI-X bridge was allowing the MMIO
> read to start before the config write was done (which is allowed by
> the PCI spec).  The PCI trace looked like:
>
> 23454:    Config Write     REG = 01 TYPE = 1    BE = 0000  Req = (0,0,0) 
> Tag = 1  Bus = 1 Device = 0 Function = 0     WAIT = 2
> 23462:    Memory Rd DW     A = 00280698  BE = 0000  Req = (0,0,0)  Tag = 0 
> WAIT = 2
> 23470:    Split compl.     Lower A = 00  Req = (0,0,0)  Tag = 0  Comp = 
> (0,2,0)     WAIT = 1   (Error completion)
> 23476:    Split compl.     Lower A = 00  Req = (0,0,0)  Tag = 1  Comp = 
> (0,2,0)     WAIT = 1   (Normal completion of WRITE)
>
> and that "Error completion" leads to a crash.
>
> John proposed the following patch to fix this, which looks good to
> me.  However, I have a couple of questions about this situation:
>
> 1) Is this something that should be fixed in the driver?  The PCI
>    spec allows MMIO cycles to start before an earlier config cycle
>    completed, but do we want to expose this fact to drivers?  Would
>    it be better for ia64 to use some sort of barrier to make sure
>    pci_write_config_xxx() is strongly ordered with MMIO?
>
> 2) Is this issue lurking in other drivers?
>
> Thanks,
>  Roland
>
> commit 424b50b6360b325ce642ece687756a600c25d28a
> Author: John Partridge <johnip@sgi.com>
> Date:   Tue Oct 24 11:54:16 2006 -0700
>
>    IB/mthca: Make sure all PCI config writes reach device before doing 
> MMIO
>
>    During initialization, mthca writes some PCI config space registers
>    and then does an MMIO read from one of the BARs it just enabled.  This
>    MMIO read sometimes failed and caused a crash on SGI Altix machines,
>    because the PCI-X host bridge (legitimately, according to the PCI
>    spec) allowed the MMIO read to start before the config write completed.
>
>    To fix this, add a config read after all config writes to make sure
>    they are all done before starting the MMIO read.
>
>    Signed-off-by: John Partridge <johnip@sgi.com>
>    Signed-off-by: Roland Dreier <rolandd@cisco.com>
>
> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c 
> b/drivers/infiniband/hw/mthca/mthca_reset.c
> index 91934f2..578dc7c 100644
> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
> @@ -281,6 +281,20 @@ good:
>  goto out;
>  }
>
> + /*
> + * Perform a "flush" of the PCI config writes here by reading
> + * the PCI_COMMAND register.  This is needed to make sure that
> + * we don't try to touch other PCI BARs before the config
> + * writes are done -- otherwise an MMIO cycle could start
> + * before the config writes are done and reach the HCA before
> + * the BAR is actually enabled.
> + */
> + if (pci_read_config_dword(mdev->pdev, PCI_COMMAND, hca_header)) {
> + err = -ENODEV;
> + mthca_err(mdev, "Couldn't access HCA memory after restoring, "
> +   "aborting.\n");
> + }
> +
> out:
>  if (bridge)
>  pci_dev_put(bridge);
>
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
>
> To unsubscribe, please visit 
> http://openib.org/mailman/listinfo/openib-general
>
> 

