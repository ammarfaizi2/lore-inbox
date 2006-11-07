Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753982AbWKGG0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbWKGG0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbWKGG0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:26:05 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:22925 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1753982AbWKGG0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:26:01 -0500
Date: Mon, 6 Nov 2006 22:25:36 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-mm@kvack.org,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-ID: <20061107062536.GA3729@localhost.localdomain>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net> <20061104225629.GA31437@lst.de> <20061104230648.GB640@redhat.com> <20061104235323.GA1353@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061104235323.GA1353@lst.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 12:53:23AM +0100, Christoph Hellwig wrote:
> On Sat, Nov 04, 2006 at 06:06:48PM -0500, Dave Jones wrote:
> > On Sat, Nov 04, 2006 at 11:56:29PM +0100, Christoph Hellwig wrote:
> > 
> > This will break the compile for !NUMA if someone ends up doing a bisect
> > and lands here as a bisect point.
> > 
> > You introduce this nice wrapper..
> 
> The dev_to_node wrapper is not enough as we can't assign to (-1) for
> the non-NUMA case.  So I added a second macro, set_dev_node for that.
> 
> The patch below compiles and works on numa and non-NUMA platforms.
> 
> 

Hi Christoph,
dev_to_node does not work as expected on x86_64 (and i386).  This is because
node value returned by pcibus_to_node is initialized after a struct device
is created with current x86_64 code.

We need the node value initialized before the call to pci_scan_bus_parented,
as the generic devices are allocated and initialized
off pci_scan_child_bus, which gets called from pci_scan_bus_parented
The following patch does that using "pci_sysdata" introduced by the PCI
domain patches in -mm.

Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.19-rc4mm2/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.19-rc4mm2.orig/arch/i386/pci/acpi.c	2006-11-06 11:03:50.000000000 -0800
+++ linux-2.6.19-rc4mm2/arch/i386/pci/acpi.c	2006-11-06 22:04:14.000000000 -0800
@@ -9,6 +9,7 @@ struct pci_bus * __devinit pci_acpi_scan
 {
 	struct pci_bus *bus;
 	struct pci_sysdata *sd;
+	int pxm;
 
 	/* Allocate per-root-bus (not per bus) arch-specific data.
 	 * TODO: leak; this memory is never freed.
@@ -30,15 +31,21 @@ struct pci_bus * __devinit pci_acpi_scan
 	}
 #endif /* CONFIG_PCI_DOMAINS */
 
+	sd->node = -1;
+
+	pxm = acpi_get_pxm(device->handle);
+#ifdef CONFIG_ACPI_NUMA
+	if (pxm >= 0)
+		sd->node = pxm_to_node(pxm);
+#endif
+
 	bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);
 	if (!bus)
 		kfree(sd);
 
 #ifdef CONFIG_ACPI_NUMA
 	if (bus != NULL) {
-		int pxm = acpi_get_pxm(device->handle);
 		if (pxm >= 0) {
-			sd->node = pxm_to_node(pxm);
 			printk("bus %d -> pxm %d -> node %d\n",
 				busnum, pxm, sd->node);
 		}
