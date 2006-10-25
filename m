Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWJYGa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWJYGa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWJYGa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:30:28 -0400
Received: from colo.lackof.org ([198.49.126.79]:60817 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1161361AbWJYGa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:30:27 -0400
Date: Wed, 25 Oct 2006 00:30:22 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061025063022.GC12319@colo.lackof.org>
References: <adafyddcysw.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafyddcysw.fsf@cisco.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 12:13:19PM -0700, Roland Dreier wrote:
> John Partridge found an interesting bug involving mthca (Mellanox
> InfiniBand HCA driver) on IA64/Altix systems.  Basically, during
> initialization, mthca does:
> 
>     - do some config writes, including enabling BARs
>     - then start a firmware command
>       - read an MMIO register from a BAR (to check if FW is busy)
> 
> However, John found that the Altix PCI-X bridge was allowing the MMIO
> read to start before the config write was done (which is allowed by
> the PCI spec).

Can someone provide a quote of the PCI Local bus spec that allows this?
(Or at least a reference to a spec version and section number)

>   The PCI trace looked like:
> 
> 23454:    Config Write     REG = 01 TYPE = 1    BE = 0000  Req = (0,0,0)  Tag = 1  Bus = 1 Device = 0 Function = 0     WAIT = 2
> 23462:    Memory Rd DW     A = 00280698  BE = 0000  Req = (0,0,0)  Tag = 0      WAIT = 2
> 23470:    Split compl.     Lower A = 00  Req = (0,0,0)  Tag = 0  Comp = (0,2,0)     WAIT = 1   (Error completion)
> 23476:    Split compl.     Lower A = 00  Req = (0,0,0)  Tag = 1  Comp = (0,2,0)     WAIT = 1   (Normal completion of WRITE)
> 
> and that "Error completion" leads to a crash.
> 
> John proposed the following patch to fix this, which looks good to
> me.  However, I have a couple of questions about this situation:
> 
>  1) Is this something that should be fixed in the driver?  The PCI
>     spec allows MMIO cycles to start before an earlier config cycle
>     completed, but do we want to expose this fact to drivers?

I would prefer we did not.

>     Would
>     it be better for ia64 to use some sort of barrier to make sure
>     pci_write_config_xxx() is strongly ordered with MMIO?

That would be my preference.

>  2) Is this issue lurking in other drivers?
> 
> Thanks,
>   Roland
> 
> commit 424b50b6360b325ce642ece687756a600c25d28a
> Author: John Partridge <johnip@sgi.com>
> Date:   Tue Oct 24 11:54:16 2006 -0700
> 
>     IB/mthca: Make sure all PCI config writes reach device before doing MMIO
>     
>     During initialization, mthca writes some PCI config space registers
>     and then does an MMIO read from one of the BARs it just enabled.  This
>     MMIO read sometimes failed and caused a crash on SGI Altix machines,
>     because the PCI-X host bridge (legitimately, according to the PCI
>     spec) allowed the MMIO read to start before the config write completed.

Because of this past discussion with jesse barnes, I'm leary of
any kind of writes traveling through SN2 fabric. The issue is
described pretty well here:
	http://www.usenetlinux.com/archive/topic.php/t-49141.html

I don't know that this is the same (or similar) problem.

>     To fix this, add a config read after all config writes to make sure
>     they are all done before starting the MMIO read.
>     
>     Signed-off-by: John Partridge <johnip@sgi.com>
>     Signed-off-by: Roland Dreier <rolandd@cisco.com>
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
> index 91934f2..578dc7c 100644
> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
> @@ -281,6 +281,20 @@ good:
>  		goto out;
>  	}
>  
> +	/*
> +	 * Perform a "flush" of the PCI config writes here by reading
> +	 * the PCI_COMMAND register.  This is needed to make sure that
> +	 * we don't try to touch other PCI BARs before the config
> +	 * writes are done -- otherwise an MMIO cycle could start
> +	 * before the config writes are done and reach the HCA before
> +	 * the BAR is actually enabled.
> +	 */

If this code is accepted, the comment should provide a specific reference
(PCI Version + section) to the PCI spec that allows the out-of-order.

I agree with jgarzik that the drivers already expect config cycles
to be ordered with respect to MMIO cycles.

I'm looking at arch/ia64/pci/pci.c.
Wouldn't it be reasonable to include memory barriers around calls
to SAL config space access functions?

thanks,
grant
