Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266446AbUFVCW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266446AbUFVCW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 22:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUFVCW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 22:22:26 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:458 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266446AbUFVCWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 22:22:24 -0400
To: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Subject: Question on using MSI in PCI driver
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Mon, 21 Jun 2004 19:22:23 -0700
Message-ID: <52lligqqlc.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 02:22:23.0611 (UTC) FILETIME=[C0CC54B0:01C457FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at implementing MSI/MSI-X support in a PCI device driver
I'm working on.  However, I've run into an issue with the MSI API that
I would like some clarification on.

When I call pci_enable_msi, since my device is MSI-X capable, the
kernel calls msix_capability_init, which works out the memory region
where vectors should be written and then calls request_region.  (In
fact it calls

             request_mem_region(phys_addr,
		dev_msi_cap * PCI_MSIX_ENTRY_SIZE,
		"MSI-X iomap Failure"))

which leads to a bizarre entry in /proc/iomem with the name "MSI-X
iomap Failure")

The problem is that if I follow the standard route in my driver and
call pci_request_regions() during init (since I want to claim my whole
device), the request_mem_region in msix_capability_init will fail.
Now, for my device, the MSI-X table happens to fall in the middle of a
BAR, and I need to access stuff on both sides of it in that BAR.  To
make things even worse for me, my device has two more BARs I want to claim.

So it seems I am forced to turn my nice clean pci_request_regions()
call into two calls to request_mem_region() (to get the beginning and
end of the BAR with the MSI-X table in it) and two more calls to
pci_request_region() (to get the other two BARs).

This isn't the end of the world but it feels suboptimal to me.  Anyone
have an idea for a better way to do this?  (I'm happy to write a patch
to the kernel if someone suggests how to change the MSI API)

Thanks,
  Roland
