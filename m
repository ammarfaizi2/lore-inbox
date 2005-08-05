Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVHEEjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVHEEjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 00:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVHEEjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 00:39:04 -0400
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:9103 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262854AbVHEEjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 00:39:03 -0400
To: linux-kernel@vger.kernel.org
Subject: S3 wakeup broken by one commit
In-Reply-To: Your message of "Thu, 04 Aug 2005 10:26:35 PDT."
             <20050804172635.GA14144@kroah.com> 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 05 Aug 2005 00:38:56 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1E0tyy-0000nz-Et@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478819d4bc37d9c2ebfc59cfd1acdcdf69ae3dc63163ab1e6cc350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> By any chance, is this patch
> [3d3c2ae1101c1f2dff7e2f9d514769779dbd2737] causing you problems?

It wasn't that one, so I redid the bisection very carefully, and found
the troublesome patch (I hope):
299de0343c7d18448a69c635378342e9214b14af

See <http://bugzilla.kernel.org/show_bug.cgi?id=4989> for more details.
[Basic story: IBM TP 600X, i386, booting always with acpi_sleep=s3_bios.
With some kernels it won't wake up from S3 sleep, just sits there with
the disk light on but no disk activity.]

The patch is in the kernel (as of -rc5) so if it causes a problem (it
may not be, it may just have exposed another problem, alas), then it may
be worth tracking down.  Otherwise S3 will never get stable.

Any suggestions on patches to test?  (I'll be away for a few days
teaching but will try any experiments when I get back if I cannot get to
them while travelling.)

Here's the log entry:

$ git log 299de0343c7d18448a69c635378342e9214b14af
commit 299de0343c7d18448a69c635378342e9214b14af
Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date:   Wed Jun 15 18:59:27 2005 +0400

    [PATCH] PCI: pci_assign_unassigned_resources() on x86
    
    - Add sanity check for io[port,mem]_resource in setup-bus.c. These
      resources look like "free" as they have no parents, but obviously
      we must not touch them.
    - In i386.c:pci_allocate_bus_resources(), if a bridge resource cannot be
      allocated for some reason, then clear its flags. This prevents any child
      allocations in this range, so the setup-bus code will work with a clean
      resource sub-tree.
    - i386.c:pcibios_enable_resources() doesn't enable bridges, as it checks
      only resources 0-5, which looks like a clear bug to me. I suspect it
      might break hotplug as well in some cases.
    
    From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

...

And the diff itself:

diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -165,6 +165,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
diff --git a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c
+++ b/arch/i386/pci/i386.c
@@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
-				if (!r->start)
+				if (!r->flags)
 					continue;
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0)
+				if (!r->start || !pr || request_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
+					/* Something is wrong with the region.
+					   Invalidate the resource to prevent child
+					   resource allocations in this range. */
+					r->flags = 0;
+				}
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
@@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for(idx=0; idx<6; idx++) {
+	for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -273,6 +273,8 @@ find_free_bus_resource(struct pci_bus *b
 
 	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		r = bus->resource[i];
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
 	}

