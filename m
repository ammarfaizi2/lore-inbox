Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbUKDOd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUKDOd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbUKDOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:32:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:48836 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262181AbUKDOaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:30:00 -0500
Date: Thu, 4 Nov 2004 15:29:55 +0100
From: Andi Kleen <ak@suse.de>
To: Jack Steiner <steiner@sgi.com>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041104142954.GA27188@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104141337.GA18445@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104141337.GA18445@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 08:13:37AM -0600, Jack Steiner wrote:
> On Thu, Nov 04, 2004 at 10:59:08AM +0900, Takayoshi Kochi wrote:
> > Hi,
> > 
> > For wider audience, added LKML.
> > 
> > From: Jack Steiner <steiner@sgi.com>
> > Subject: Externalize SLIT table
> > Date: Wed, 3 Nov 2004 14:56:56 -0600
> > 
> > > The SLIT table provides useful information on internode
> > > distances. Has anyone considered externalizing this
> > > table via /proc or some equivalent mechanism.
> > > 
> > > For example, something like the following would be useful:
> > > 
> > > 	# cat /proc/acpi/slit
> > > 	010 066 046 066
> > > 	066 010 066 046
> > > 	046 066 010 020
> > > 	066 046 020 010
> > > 
> > > If this looks ok (or something equivalent), I'll generate a patch....
> > 
> > For user space to manipulate scheduling domains, pinning processes
> > to some cpu groups etc, that kind of information is very useful!
> > Without this, users have no notion about how far between two nodes.
> > 
> > But ACPI SLIT table is too arch specific (ia64 and x86 only) and
> > user-visible logical number and ACPI proximity domain number is
> > not always identical.
> > 
> > Why not export node_distance() under sysfs?
> > I like (1).
> > 
> > (1) obey one-value-per-file sysfs principle
> > 
> > % cat /sys/devices/system/node/node0/distance0
> > 10
> > % cat /sys/devices/system/node/node0/distance1
> > 66
> 
> I'm not familar with the internals of sysfs. For example, on a 256 node
> system, there will be 65536 instances of
> 	 /sys/devices/system/node/node<M>/distance<N>
> 
> Does this require any significant amount of kernel resources to
> maintain this amount of information.

Yes it does, even with the new sysfs backing store. And reading
it would create all the inodes and dentries, which are quite
bloated.

> 
> I think it would also be useful to have a similar cpu-to-cpu distance
> metric:
> 	% cat /sys/devices/system/cpu/cpu0/distance
> 	10 20 40 60 
> 
> This gives the same information but is cpu-centric rather than
> node centric.


And the same thing for PCI busses, like in this patch. However
for strict ACPI systems this information would need to be gotten
from _PXM first. x86-64 on Opteron currently reads it directly
from the hardware and uses it to allocate DMA memory near the device.

-Andi


diff -urpN -X ../KDIFX linux-2.6.8rc3/drivers/pci/pci-sysfs.c linux-2.6.8rc3-amd64/drivers/pci/pci-sysfs.c
--- linux-2.6.8rc3/drivers/pci/pci-sysfs.c	2004-07-27 14:44:10.000000000 +0200
+++ linux-2.6.8rc3-amd64/drivers/pci/pci-sysfs.c	2004-08-04 02:42:11.000000000 +0200
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/stat.h>
+#include <linux/topology.h>
 
 #include "pci.h"
 
@@ -38,6 +39,15 @@ pci_config_attr(subsystem_device, "0x%04
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
+static ssize_t local_cpus_show(struct device *dev, char *buf)
+{		
+	struct pci_dev *pdev = to_pci_dev(dev);
+	cpumask_t mask = pcibus_to_cpumask(pdev->bus->number);
+	int len = cpumask_scnprintf(buf, PAGE_SIZE-1, mask);
+	strcat(buf,"\n"); 
+	return 1+len;
+}
+
 /* show resources */
 static ssize_t
 resource_show(struct device * dev, char * buf)
@@ -67,6 +77,7 @@ struct device_attribute pci_dev_attrs[] 
 	__ATTR_RO(subsystem_device),
 	__ATTR_RO(class),
 	__ATTR_RO(irq),
+	__ATTR_RO(local_cpus),
 	__ATTR_NULL,
 };
 


