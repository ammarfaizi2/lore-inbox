Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWI2UXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWI2UXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWI2UXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:23:32 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:55836 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422808AbWI2UX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:23:28 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=QIVqSOWXl9AQAClSUI9sTCoa1duNufWJ4Jmrp87KHo9gBJ0fnc/m5FxcA39P7BSfT9Z4JnsJTs/NGQjLl7NYW/o/ElXGEFaKVydzNCDiF5K/rVdY7LVm/ZYJsfWGW9rK;
X-IronPort-AV: i="4.09,238,1157346000"; 
   d="scan'208"; a="89196620:sNHT437025051"
Date: Fri, 29 Sep 2006 15:23:23 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Pierre Peiffer <pierre.peiffer@bull.net>,
       Dan Carpenter <error27.lkml@gmail.com>, ppokorny@penguincomputing.com
Subject: [PATCH 2.6.18] PCI: optionally sort device lists breadth-first
Message-ID: <20060929202323.GD6028@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once more, making the reordering optionally enabled/disabled.

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
which most often is breadth-first also).  2.6 kernels have both the
pci_devices list and the pci_bus_type.klist_devices list, the latter
is what is walked at driver load time to match the pci_id tables; this
klist happens to be in depth-first order.

On systems where, for physical routing reasons, NIC1 appears on a
lower bus number than NIC2, but NIC2's bridge is discovered first in
the depth-first ordering, NIC2 will be discovered before NIC1.  If the
list were sorted breadth-first, NIC1 would be discovered before NIC2.

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
Patch below optionally sorts the two device lists into breadth-first
ordering to maintain compatibility with 2.4 kernels.  It adds two new
command line options:
  pci=bfsort
  pci=nobfsort
to force the sort order, or not, as you wish.  It also adds DMI checks
for the specific Dell systems which exhibit "backwards" ordering, to
make them "right".


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
with 2.6.18.

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
index 5498324..c17d744 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1243,6 +1243,11 @@ running once the system is up.
 				machine check when some devices' config space
 				is read. But various workarounds are disabled
 				and some IOMMU drivers will not work.
+		bfsort		Sort PCI devices into breadth-first order.
+				This sorting is done to get a device
+				order compatible with older (<= 2.4) kernels.
+		nobfsort	Don't sort PCI devices into breadth-first order.
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd.		[PARIDE]
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
index 68bce19..6d5ace8 100644
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
@@ -20,6 +20,7 @@
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 
+int pci_bf_sort;
 int pci_routeirq;
 int pcibios_last_bus = -1;
 unsigned long pirq_table_addr;
@@ -118,6 +119,20 @@ void __devinit  pcibios_fixup_bus(struct
 }
 
 /*
+ * Only use DMI information to set this if nothing was passed
+ * on the kernel command line (which was parsed earlier).
+ */
+
+static int __devinit set_bf_sort(struct dmi_system_id *d)
+{
+	if (pci_bf_sort == pci_bf_sort_default) {
+		pci_bf_sort = pci_dmi_bf;
+		printk(KERN_INFO "PCI: %s detected, enabling pci=bfsort.\n", d->ident);
+	}
+	return 0;
+}
+
+/*
  * Enable renumbering of PCI bus# ranges to reach all PCI busses (Cardbus)
  */
 #ifdef __i386__
@@ -130,11 +145,11 @@ static int __devinit assign_all_busses(s
 }
 #endif
 
+static struct dmi_system_id __devinitdata pciprobe_dmi_table[] = {
+#ifdef __i386__
 /*
  * Laptops which need pci=assign-busses to see Cardbus cards
  */
-static struct dmi_system_id __devinitdata pciprobe_dmi_table[] = {
-#ifdef __i386__
 	{
 		.callback = assign_all_busses,
 		.ident = "Samsung X20 Laptop",
@@ -144,6 +159,38 @@ static struct dmi_system_id __devinitdat
 		},
 	},
 #endif		/* __i386__ */
+	{
+		.callback = set_bf_sort,
+		.ident = "Dell PowerEdge 1950",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1950"),
+		},
+	},
+	{
+		.callback = set_bf_sort,
+		.ident = "Dell PowerEdge 1955",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1955"),
+		},
+	},
+	{
+		.callback = set_bf_sort,
+		.ident = "Dell PowerEdge 2900",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2900"),
+		},
+	},
+	{
+		.callback = set_bf_sort,
+		.ident = "Dell PowerEdge 2950",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2950"),
+		},
+	},
 	{}
 };
 
@@ -189,6 +236,8 @@ static int __init pcibios_init(void)
 
 	pcibios_resource_survey();
 
+	if (pci_bf_sort >= pci_force_bf)
+		pci_sort_breadthfirst();
 #ifdef CONFIG_PCI_BIOS
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
@@ -202,6 +251,12 @@ char * __devinit  pcibios_setup(char *st
 {
 	if (!strcmp(str, "off")) {
 		pci_probe = 0;
+		return NULL;
+	} else if (!strcmp(str, "bfsort")) {
+		pci_bf_sort = pci_force_bf;
+		return NULL;
+	} else if (!strcmp(str, "nobfsort")) {
+		pci_bf_sort = pci_force_nobf;
 		return NULL;
 	}
 #ifdef CONFIG_PCI_BIOS
diff --git a/arch/i386/pci/pci.h b/arch/i386/pci/pci.h
index 1814f74..ad065ce 100644
--- a/arch/i386/pci/pci.h
+++ b/arch/i386/pci/pci.h
@@ -30,6 +30,13 @@
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
 
+enum pci_bf_sort_state {
+	pci_bf_sort_default,
+	pci_force_nobf,
+	pci_force_bf,
+	pci_dmi_bf,
+};
+
 /* pci-i386.c */
 
 extern unsigned int pcibios_max_latency;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3b0a5e..d9e6b82 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1067,3 +1067,93 @@ EXPORT_SYMBOL(pci_scan_bridge);
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
index 5c3a417..78b4bfb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -443,6 +443,7 @@ extern void pci_remove_bus(struct pci_bu
 extern void pci_remove_bus_device(struct pci_dev *dev);
 extern void pci_stop_bus_device(struct pci_dev *dev);
 void pci_setup_cardbus(struct pci_bus *bus);
+extern void pci_sort_breadthfirst(void);
 
 /* Generic PCI functions exported to card drivers */
 
