Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWIHTet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWIHTet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWIHTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:34:49 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:44161 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751118AbWIHTes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:34:48 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=gttQt9ip9MoOjc0Efu9eD0c71/sPMWp80ylTK7Bg9v3MBeGLeEw1aJj7uKh/XQ4ZsZ17LklzuO6r5Yz7Wj23Ydchve7A2xTXsFpkYN29UgpqFVn+SRGnzLnso5dQQqD7;
X-IronPort-AV: i="4.09,134,1157346000"; 
   d="scan'208"; a="77183208:sNHT21138633"
Date: Fri, 8 Sep 2006 14:34:50 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060908193449.GE7165@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made functions __init, replaced indirect call to compare function
with a direct call.

Problem:
New Dell PowerEdge servers have 2 embedded ethernet ports, which are
labeled NIC1 and NIC2 on the chassis, in the BIOS setup screens, and
in the printed documentation.  Assuming no other add-in ethernet ports
in the system, Linux 2.4 kernels name these eth0 and eth1
respectively.  Many people have come to expect this naming.  Linux 2.6
kernels name these eth1 and eth0 respectively (backwards from
expectations).  I also have reports that various Sun and HP servers
have similar behavior.


Root cause:
Linux 2.4 kernels walk the pci_devices list, which happens to be
sorted in breadth-first order (or pcbios_find_device order on i386,
which most often is breadth-first also).  2.6 kernels have both the pci_devices
list and the pci_bus_type.klist_devices list, the latter is what is
walked at driver load time to match the pci_id tables; this klist
happens to be in depth-first order.

On systems where, for physical routing reasons, NIC1 appears on a
lower bus number than NIC2, but NIC2's bridge is discovered first in
the depth-first ordering, NIC2 will be discovered before NIC1.  If the
list were sorted breadth-first, NIC1 woudl be discovered before NIC2.

A PowerEdge 1955 system has the following topology which easily
exhibits the difference between depth-first and breadth-first device
lists.

-[0000:00]-+-00.0  Intel Corporation 5000P Chipset Memory Controller Hub
           +-02.0-[0000:03-08]--+-00.0-[0000:04-07]--+-00.0-[0000:05-06]----00.0-[0000:06]----00.0  Broadcom Corporation NetXtreme II BCM5708S Gigabit Ethernet (labeled NIC2, 2.4 kernel name eth1, 2.6 kernel name eth0)
           +-1c.0-[0000:01-02]----00.0-[0000:02]----00.0  Broadcom Corporation NetXtreme II BCM5708S Gigabit Ethernet (labeled NIC1, 2.4 kernel name eth0, 2.6 kernel name eth1)


Other factors, such as device driver load order and the presence of
PCI slots at various points in the bus hierarchy further complicate
this problem; I'm not trying to solve those here, just restore the
device order, and thus basic behavior, that 2.4 kernels had.


Solution:

The solution can come in multiple steps.

Suggested fix #1: kernel
Patch below sorts the two device lists into breadth-first ordering to
maintain compatibility with 2.4 kernels.  It also overloads the
'pci=nosort' option to disable the breadth-first sort (and on i386 it
continues to disable the pcibios_find_device sort as well).

Suggested fix #2: udev rules from userland
Many people also have the expectation that embedded NICs are always
discovered before add-in NICs (which this patch does not try to do).
Using the PCI IRQ Routing Table provided by system BIOS, it's easy to
determine which PCI devices are embedded, or if add-in, which PCI slot
they're in.  I'm working on a tool that would allow udev to name
ethernet devices in ascending embedded, slot 1 .. slot N order,
subsort by PCI bus/dev/fn breadth-first.  It'll be possible to use it
independent of udev as well for those distributions that don't use
udev in their installers.

Suggested fix #3: system board routing rules
One can constrain the system board layout to put NIC1 ahead of NIC2
regardless of breadth-first or depth-first discovery order.  This adds
a significant level of complexity to board routing, and may not be
possible in all instances (witness the above systems from several
major manufacturers).  I don't want to encourage this particular train
of thought too far, at the expense of not doing #1 or #2 above.


Feedback appreciated.  Patch tested on a Dell PowerEdge 1955 blade
with 2.6.18-rc5.

You'll also note I took some liberty and temporarily break the klist
abstraction to simplify and speed up the sort algorithm.  I think
that's both safe and appropriate in this instance.

Thanks,
Matt

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index b50595a..192435a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1186,7 +1186,11 @@ running once the system is up.
 		nomsi		[MSI] If the PCI_MSI kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of MSI interrupts system-wide.
-		nosort		[IA-32] Don't sort PCI devices according to
+		nosort		Don't sort PCI devices into breadth-first order.
+				This sorting is done to get a device
+				order compatible with older (<= 2.4) kernels.
+				and
+				[IA-32] Don't sort PCI devices according to
 				order given by the PCI BIOS. This sorting is
 				done to get a device order compatible with
 				older kernels.
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index 0a362e3..86657cc 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -189,6 +189,8 @@ static int __init pcibios_init(void)
 
 	pcibios_resource_survey();
 
+	if (!(pci_probe & PCI_NO_SORT))
+		pci_sort_breadthfirst();
 #ifdef CONFIG_PCI_BIOS
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
@@ -203,6 +205,9 @@ char * __devinit  pcibios_setup(char *st
 	if (!strcmp(str, "off")) {
 		pci_probe = 0;
 		return NULL;
+	} else if (!strcmp(str, "nosort")) {
+		pci_probe |= PCI_NO_SORT;
+		return NULL;
 	}
 #ifdef CONFIG_PCI_BIOS
 	else if (!strcmp(str, "bios")) {
@@ -210,9 +215,6 @@ char * __devinit  pcibios_setup(char *st
 		return NULL;
 	} else if (!strcmp(str, "nobios")) {
 		pci_probe &= ~PCI_PROBE_BIOS;
-		return NULL;
-	} else if (!strcmp(str, "nosort")) {
-		pci_probe |= PCI_NO_SORT;
 		return NULL;
 	} else if (!strcmp(str, "biosirq")) {
 		pci_probe |= PCI_BIOS_IRQ_SCAN;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5a58d1..285ef17 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1055,3 +1055,93 @@ EXPORT_SYMBOL(pci_scan_bridge);
 EXPORT_SYMBOL(pci_scan_single_device);
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 #endif
+
+static int __init pci_sort_bf_cmp(const struct pci_dev *a, const struct pci_dev *b)
+{
+	if      (pci_domain_nr(a->bus) < pci_domain_nr(b->bus)) return -1;
+	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus)) return  1;
+
+	if      (a->bus->number < b->bus->number) return -1;
+	else if (a->bus->number > b->bus->number) return  1;
+
+	if      (a->devfn < b->devfn) return -1;
+	else if (a->devfn > b->devfn) return  1;
+
+	return 0;
+}
+
+/*
+ * Yes, this forcably breaks the klist abstraction temporarily.  It
+ * just wants to sort the klist, not change reference counts and
+ * take/drop locks rapidly in the process.  It does all this while
+ * holding the lock for the list, so objects can't otherwise be
+ * added/removed while we're swizzling.
+ */
+
+static void __init pci_insertion_sort_klist(struct pci_dev *a, struct list_head *list)
+{
+	struct list_head *pos;
+	struct klist_node *n;
+	struct device *dev;
+	struct pci_dev *b;
+	list_for_each(pos, list) {
+		n = container_of(pos, struct klist_node, n_node);
+		dev = container_of(n, struct device, knode_bus);
+		b = to_pci_dev(dev);
+		if (pci_sort_bf_cmp(a, b) <= 0) {
+			list_move_tail(&a->dev.knode_bus.n_node, &b->dev.knode_bus.n_node);
+			return;
+		}
+	}
+	list_move_tail(&a->dev.knode_bus.n_node, list);
+}
+
+static void __init pci_sort_breadthfirst_klist(void)
+{
+	LIST_HEAD(sorted_devices);
+	struct list_head *pos, *tmp;
+	struct klist_node *n;
+	struct device *dev;
+	struct pci_dev *pdev;
+	spin_lock(&pci_bus_type.klist_devices.k_lock);
+	list_for_each_safe(pos, tmp, &pci_bus_type.klist_devices.k_list) {
+		n = container_of(pos, struct klist_node, n_node);
+		dev = container_of(n, struct device, knode_bus);
+		pdev = to_pci_dev(dev);
+		pci_insertion_sort_klist(pdev, &sorted_devices);
+	}
+	list_splice(&sorted_devices, &pci_bus_type.klist_devices.k_list);
+	spin_unlock(&pci_bus_type.klist_devices.k_lock);
+}
+
+static void __init pci_insertion_sort_devices(struct pci_dev *a, struct list_head *list)
+{
+	struct pci_dev *b;
+	list_for_each_entry(b, list, global_list) {
+		if (pci_sort_bf_cmp(a, b) <= 0) {
+			list_move_tail(&a->global_list, &b->global_list);
+			return;
+		}
+	}
+	list_move_tail(&a->global_list, list);
+}
+
+static void __init pci_sort_breadthfirst_devices(void)
+{
+	LIST_HEAD(sorted_devices);
+	struct pci_dev *dev, *tmp;
+
+	down_write(&pci_bus_sem);
+	list_for_each_entry_safe(dev, tmp, &pci_devices, global_list) {
+		pci_insertion_sort_devices(dev, &sorted_devices);
+	}
+	list_splice(&sorted_devices, &pci_devices);
+	up_write(&pci_bus_sem);
+}
+
+void __init pci_sort_breadthfirst(void)
+{
+	pci_sort_breadthfirst_devices();
+	pci_sort_breadthfirst_klist();
+}
+
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8565b81..3011715 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -437,6 +437,7 @@ extern void pci_dev_put(struct pci_dev *
 extern void pci_remove_bus(struct pci_bus *b);
 extern void pci_remove_bus_device(struct pci_dev *dev);
 void pci_setup_cardbus(struct pci_bus *bus);
+extern void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
