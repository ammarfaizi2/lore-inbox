Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbSKLXyK>; Tue, 12 Nov 2002 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSKLXyK>; Tue, 12 Nov 2002 18:54:10 -0500
Received: from holomorphy.com ([66.224.33.161]:39101 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266949AbSKLXyJ>;
	Tue, 12 Nov 2002 18:54:09 -0500
Date: Tue, 12 Nov 2002 15:58:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Cc: gregkh@kroah.com, mochel@osdl.org
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112235824.GG22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	hohnbaum@us.ibm.com, gregkh@kroah.com, mochel@osdl.org
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com> <177250000.1037141189@flay> <20021112215305.GZ23425@holomorphy.com> <179150000.1037145229@flay> <20021112225937.GA23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112225937.GA23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 03:53:49PM -0800, Martin J. Bligh wrote:
>> Right, I'm not against the sysdata thing, seems like a much better way
>> to do it in general (what I did was a quick hack). Was just confused
>> by the global bus number assertion, but if we use the sysdata stuff,
>> it's all a non-issue ;-)
> 
On Tue, Nov 12, 2002 at 02:59:37PM -0800, William Lee Irwin III wrote:
> Non-issue for merging...
> The pain isn't over yet. =(
> Core PCI code is assuming unique bus numbers in several places.

Okay, an attempt to remedy this world-breaking braindamage with the
fewest lines of code:

This alters PCI bus number "clash" detection to compare ->sysdata in
addition to the numbers. The bus number is not a unique identifier.

 drivers/pci/probe.c |   14 ++++++++++++--
 include/linux/pci.h |    2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)


diff -urpN pci-2.5.47-8/drivers/pci/probe.c pci-2.5.47-8-dbg/drivers/pci/probe.c
--- pci-2.5.47-8/drivers/pci/probe.c	2002-11-12 13:37:56.000000000 -0800
+++ pci-2.5.47-8-dbg/drivers/pci/probe.c	2002-11-12 14:27:54.000000000 -0800
@@ -548,11 +548,21 @@ int __devinit pci_bus_exists(const struc
 	return 0;
 }
 
-struct pci_bus * __devinit pci_alloc_primary_bus(int bus)
+static int __devinit pci_root_bus_exists(int number, void *sysdata)
+{
+	const struct pci_bus *bus;
+
+	list_for_each_entry(bus, &pci_root_buses, node)
+		if (bus->number == number && bus->sysdata == sysdata)
+			return 1;
+	return 0;
+}
+
+struct pci_bus * __devinit pci_alloc_primary_bus(int bus, void *sysdata)
 {
 	struct pci_bus *b;
 
-	if (pci_bus_exists(&pci_root_buses, bus)) {
+	if (pci_root_bus_exists(bus, sysdata)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
 		return NULL;
diff -urpN pci-2.5.47-8/include/linux/pci.h pci-2.5.47-8-dbg/include/linux/pci.h
--- pci-2.5.47-8/include/linux/pci.h	2002-11-10 19:28:13.000000000 -0800
+++ pci-2.5.47-8-dbg/include/linux/pci.h	2002-11-12 14:29:13.000000000 -0800
@@ -537,7 +537,7 @@ int pcibios_write_config_dword (unsigned
 
 int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
-struct pci_bus *pci_alloc_primary_bus(int bus);
+struct pci_bus *pci_alloc_primary_bus(int bus, void *sysdata);
 struct pci_dev *pci_scan_slot(struct pci_dev *temp);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);
