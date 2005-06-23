Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVFWRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVFWRGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFWRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:06:14 -0400
Received: from fmr24.intel.com ([143.183.121.16]:962 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262156AbVFWRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:05:55 -0400
Date: Thu, 23 Jun 2005 10:05:36 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
Message-ID: <20050623100536.A21592@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de> <42B6831B.3040506@ens-lyon.org> <20050620085449.GA32330@isilmar.linta.de> <42B6C06F.4000704@ens-lyon.org> <20050622163427.A10079@unix-os.sc.intel.com> <42BA55D2.7020900@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42BA55D2.7020900@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Thu, Jun 23, 2005 at 08:25:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 08:25:22AM +0200, Brice Goglin wrote:
> 
> You're right. I reverted this one two days ago and got a working
> system. Actually, the system had other problems (got an oops when
> reading /proc/ioports). But they might be caused by dependencies
> between Grekgh's PCI patches that were still applied and and the
> one I removed, right ?
> Anyway, this fixed my maestro3 divide error and the yenta hang
> during boot.
> 
Reverting the host bridge patch should not affect /proc/ioports,
that's probably something different. I'd like to see what your
ACPI tables look like and what the firmware reported for host
bridge resources. Can you send me the system DSDT 
(cat /proc/acpi/dsdt > dsdt.hex). Also, can you apply this debug
hack patch to 2.6.12-mm1 and send me the dmesg output? You will
have to change your .config (e.g. disable yenta support?) to avoid
the system hang you seeing with 2.6.12-mm1 (or, you could capture
debug messages via serial console).

Rajesh
---------

Index: linux-2.6.12-mm1/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/i386/pci/acpi.c
+++ linux-2.6.12-mm1/arch/i386/pci/acpi.c
@@ -9,6 +9,13 @@ static void inline
 add_resource_range(int idx, struct pci_bus *bus,
 		struct acpi_resource_address64 *addr, unsigned long flags)
 {
+	printk("%s: adding resource %Lx:%Lx, flags %lx @ bus %x:%x\n",
+			__FUNCTION__,
+			addr->min_address_range,
+			addr->max_address_range,
+			flags,
+			bus->number,
+			idx);
 	memset(bus->resource[idx], 0, sizeof(*(bus->resource[idx])));
 	bus->resource[idx]->name = bus->name;
 	bus->resource[idx]->start = addr->min_address_range;
@@ -72,10 +79,28 @@ add_resources(struct acpi_resource *acpi
 		/* Consolidate adjacent resource ranges */
 		if (busr->end + 1 == address.min_address_range) {
 			busr->end = address.max_address_range;
+			printk("%s: consolidating %Lx:%Lx flags %lx for bus %x:%x, new %lx:%lx\n",
+					__FUNCTION__,
+					address.min_address_range,
+					address.max_address_range,
+					flags,
+					bus->number,
+					idx,
+					busr->start,
+					busr->end);
 			return AE_OK;
 		}
 		if (address.max_address_range + 1 == busr->start) {
 			busr->start = address.min_address_range;
+			printk("%s: consolidating %Lx:%Lx flags %lx for bus %x:%x, new %lx:%lx\n",
+					__FUNCTION__,
+					address.min_address_range,
+					address.max_address_range,
+					flags,
+					bus->number,
+					idx,
+					busr->start,
+					busr->end);
 			return AE_OK;
 		}
 		/* Consolidate overlapping resource ranges */
@@ -87,6 +112,15 @@ add_resources(struct acpi_resource *acpi
 			busr->start = address.min_address_range;
 		if (address.max_address_range > busr->end)
 			busr->end = address.max_address_range;
+		printk("%s: consolidating %Lx:%Lx flags %lx for bus %x:%x, new %lx:%lx\n",
+				__FUNCTION__,
+				address.min_address_range,
+				address.max_address_range,
+				flags,
+				bus->number,
+				idx,
+				busr->start,
+				busr->end);
 		return AE_OK;
 	}
 	printk(KERN_WARNING
@@ -125,6 +159,25 @@ verify_root_windows(struct pci_bus *bus)
 	return 0;
 }
 
+static void dump_bridge_resources(struct pci_bus *bus)
+{
+       int i;
+       unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+
+       printk("%s: Bus resources for bus %s, num %2x, prim %2x, sec %2x, sub %2x\n",
+                       __FUNCTION__,
+                       ((bus->self)? pci_name(bus->self): "root"),
+		       bus->number,
+                       bus->primary, bus->secondary, bus->subordinate);
+       for (i=0; i<PCI_BUS_NUM_RESOURCES; i++) {
+               struct resource *res = bus->resource[i];
+               if ((res) && (res->flags & type_mask)) {
+                      printk("\tbus resouce #%2x, start %lx, end %lx, flags %lx\n",
+                                      i, res->start, res->end, res->flags);
+               }
+       }
+}
+
 static void __devinit
 pcibios_setup_root_windows(struct pci_bus *bus, acpi_handle handle)
 {
@@ -141,6 +194,8 @@ pcibios_setup_root_windows(struct pci_bu
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 			add_resources, bus);
 	if (ACPI_FAILURE(status) || !verify_root_windows(bus)) {
+		printk("%s: Falling back to default host bridge resources\n",
+				__FUNCTION__);
 		printk(KERN_WARNING
 			"PCI: Falling back to default host bridge resources\n");
 		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
@@ -148,6 +203,7 @@ pcibios_setup_root_windows(struct pci_bu
 			bus->resource[i] = bres[i];
 		}
 	}
+	dump_bridge_resources(bus);
 }
 
 
