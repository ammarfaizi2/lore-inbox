Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756354AbWKVS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbWKVS2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbWKVS2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:28:10 -0500
Received: from colo.lackof.org ([198.49.126.79]:16095 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1756357AbWKVS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:28:08 -0500
Date: Wed, 22 Nov 2006 11:28:04 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-ID: <20061122182804.GE378@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456404E2.1060102@jp.fujitsu.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 05:05:54PM +0900, Hidetoshi Seto wrote:
> This patch adds the description about legacy I/O port free driver into
> Documentation/pci.txt.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Hidetoshi,
I have a nearly finished rewrite of Documentation/pci.txt.
Can you drop this patch for now on my promise to integrate
your proposed text?

I've posted "RFC: rewrite Documentation/pci.txt v3" for review
to linux-pci and linux-arch mailing lists on 21 Oct 2006.
I wanted to finish that up over the US "Thanksgiving Holidays".

thanks,
grant

> 
> ---
>  Documentation/pci.txt |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 70 insertions(+)
> 
> Index: linux-2.6.19-rc6/Documentation/pci.txt
> ===================================================================
> --- linux-2.6.19-rc6.orig/Documentation/pci.txt
> +++ linux-2.6.19-rc6/Documentation/pci.txt
> @@ -287,3 +287,73 @@
>  pci_find_device()		Superseded by pci_get_device()
>  pci_find_subsys()		Superseded by pci_get_subsys()
>  pci_find_slot()			Superseded by pci_get_slot()
> +
> +
> +10. Legacy I/O port free driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Large servers may not be able to provide I/O port resources to all PCI
> +devices. I/O Port space is only 64KB on Intel Architecture[1] and is
> +likely also fragmented since the I/O base register of PCI-to-PCI
> +bridge will usually be aligned to a 4KB boundary[2]. On such systems,
> +pci_enable_device() and pci_request_regions() will fail when
> +attempting to enable I/O Port regions that don't have I/O Port
> +resources assigned.
> +
> +Fortunately, many PCI devices which request I/O Port resources also
> +provide access to the same registers via MMIO BARs. These devices can
> +be handled without using I/O port space and the drivers typically
> +offer a CONFIG_ option to only use MMIO regions
> +(e.g. CONFIG_TULIP_MMIO). PCI devices typically provide I/O port
> +interface for legacy OSs and will work when I/O port resources are not
> +assigned. The "PCI Local Bus Specification Revision 3.0" discusses
> +this on p.44, "IMPLEMENTATION NOTE".
> +
> +If your PCI device driver doesn't need I/O port resources assigned to
> +I/O Port BARs, you should use pci_enable_device_bars() instead of
> +pci_enable_device() in order not to enable I/O port regions for the
> +corresponding devices. In addition, you should use
> +pci_request_selected_regions()/pci_release_selected_regions() instead
> +of pci_request_regions()/pci_release_regions() in order not to
> +request/release I/O port regions for the corresponding devices.
> +
> +[1] Some systems support 64KB I/O port space per PCI segment.
> +[2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.
> +
> +
> +11. MMIO Space and "Write Posting"
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Converting a driver from using I/O Port space to using MMIO space
> +often requires some additional changes. Specifically, "write posting"
> +needs to be handled. Most drivers (e.g. tg3, acenic, sym53c8xx_2)
> +already do. I/O Port space guarantees write transactions reach the PCI
> +device before the CPU can continue. Writes to MMIO space allow to CPU
> +continue before the transaction reaches the PCI device. HW weenies
> +call this "Write Posting" because the write completion is "posted" to
> +the CPU before the transaction has reached it's destination.
> +
> +Thus, timing sensitive code should add readl() where the CPU is
> +expected to wait before doing other work.  The classic "bit banging"
> +sequence works fine for I/O Port space:
> +
> +	for (i=8; --i; val >>= 1) {
> +		outb(val & 1, ioport_reg);	/* write bit */
> +		udelay(10);
> +	}
> +
> +The same sequence for MMIO space should be:
> +
> +	for (i=8; --i; val >>= 1) {
> +		writeb(val & 1, mmio_reg);	/* write bit */
> +		readb(safe_mmio_reg);		/* flush posted write */
> +		udelay(10);
> +	}
> +
> +It is important that "safe_mmio_reg" not have any side effects that
> +interferes with the correct operation of the device.
> +
> +Another case to watch out for is when resetting a PCI device. Use PCI
> +Configuration space reads to flush the writel(). This will gracefully
> +handle the PCI master abort on all platforms if the PCI device is
> +expected to not respond to a readl().  Most x86 platforms will allow
> +MMIO reads to master abort (aka "Soft Fail") and return garbage
> +(e.g. ~0). But many RISC platforms will crash (aka "Hard Fail").
> 
