Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVF1LwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVF1LwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVF1LwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:52:22 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22408 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261169AbVF1LwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:52:10 -0400
Date: Tue, 28 Jun 2005 15:51:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: rajesh.shah@intel.com
Cc: gregkh@suse.de, ak@suse.de, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
Message-ID: <20050628155152.A24551@jurassic.park.msu.ru>
References: <20050602224147.177031000@csdlinux-1> <20050602224327.051278000@csdlinux-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050602224327.051278000@csdlinux-1>; from rajesh.shah@intel.com on Thu, Jun 02, 2005 at 03:41:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This refers to "gregkh-pci-pci-collect-host-bridge-resources-02.patch"
which went into 2.6.12-mm1 and -mm2]

On Thu, Jun 02, 2005 at 03:41:49PM -0700, rajesh.shah@intel.com wrote:
> This patch reads and stores host bridge resources reported by
> ACPI BIOS for i386 and x86_64 systems.  This is needed since
> ACPI hotplug code now uses the PCI core for resource management. 

That patch introduces two major problems.

1. The new root bus resources aren't properly inserted into global
   resource tree (missing request_resource calls). This leads to
   completely messed up PCI setup, especially with
   pci_assign_unassigned_resources() call, as seen in -mm1 (mm2 is
   also unsafe, though).

2. Transparent bridge handling is broken, no matter is it old code
   in Linus' tree or the new one in -mm. At the point then
   pcibios_setup_root_windows() is called, the "transparent"
   resource pointers have been already set up in pci_read_bridge_bases()
   (typically to ioport_resource and iomem_resource), so after changing
   the root bus windows these pointers are wrong.

The appended patch fixes that. Just compare /proc/ioports and /proc/iomem
with and without it. ;-)

Ivan.

--- 2.6.12-mm2/arch/i386/pci/acpi.c	2005-06-28 13:30:24.000000000 +0400
+++ linux/arch/i386/pci/acpi.c	2005-06-28 14:13:51.000000000 +0400
@@ -107,10 +107,22 @@ verify_root_windows(struct pci_bus *bus)
 			continue;
 		switch (bus->resource[i]->flags & type_mask) {
 			case IORESOURCE_IO:
-				num_io++;
+				if (!request_resource(&ioport_resource,
+						      bus->resource[i]))
+					num_io++;
+				else {
+					kfree(bus->resource[i]);
+					bus->resource[i] = NULL;
+				}
 				break;
 			case IORESOURCE_MEM:
-				num_mem++;
+				if (!request_resource(&iomem_resource,
+						      bus->resource[i]))
+					num_mem++;
+				else {
+					kfree(bus->resource[i]);
+					bus->resource[i] = NULL;
+				}
 				break;
 			default:
 				break;
@@ -126,6 +138,21 @@ verify_root_windows(struct pci_bus *bus)
 }
 
 static void __devinit
+fixup_transparent_bridges(struct list_head *bus_list)
+{
+	int i;
+	struct pci_bus *b;
+
+	list_for_each_entry(b, bus_list, node) {
+		if (b->self && b->self->transparent) {
+			for (i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+				b->resource[i] = b->parent->resource[i - 3];
+		}
+		fixup_transparent_bridges(&b->children);
+	}
+}
+
+static void __devinit
 pcibios_setup_root_windows(struct pci_bus *bus, acpi_handle handle)
 {
 	int i;
@@ -147,6 +174,21 @@ pcibios_setup_root_windows(struct pci_bu
 			kfree(bus->resource[i]);
 			bus->resource[i] = bres[i];
 		}
+	} else {
+		/* Squeeze out unused resource pointers. */
+		int idx = 0;
+
+		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+			if (bus->resource[i])
+				bus->resource[idx++] = bus->resource[i];
+		}
+		for (; idx < PCI_BUS_NUM_RESOURCES; idx++)
+			bus->resource[idx] = NULL;
+
+		/* The root bus resources have been changed. Fix up the
+		   resource pointers of buses behind "transparent" bridges
+		   as well. */
+		fixup_transparent_bridges(&bus->children);
 	}
 }
 
