Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUI2FWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUI2FWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 01:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUI2FWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 01:22:51 -0400
Received: from ozlabs.org ([203.10.76.45]:64170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268212AbUI2FVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 01:21:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16730.17837.387665.396256@cargo.ozlabs.ibm.com>
Date: Wed, 29 Sep 2004 15:18:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: johnrose@austin.ibm.com, greg@kroah.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][2/2] PPC64: RPA dynamic addition/removal of PCI Host Bridges
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Rose <johnrose@austin.ibm.com>

The following patch implements the ppc64-specific bits for dynamic (DLPAR)
addition of PCI Host Bridges.  The entry point for this operation is
init_phb_dynamic(), which will be called by the RPA DLPAR driver.  

Among the implementation details, the global number aka PCI domain for the
newly added PHB is assigned using the same simple counter that assigns it at
boot.  This has two consequences.  First, the PCI domain associated with a PHB
will not persist across DLPAR remove and subsequent add.  Second, stress tests
that repeatedly add/remove PHBs might generate some large values for PCI
domain.  If we decide at a later point to hash an OF property to PCI domain
value, this can be easily fixed up.

Also, the linux,pci-domain property is not generated for the newly added PHBs
at the moment.  Because there doesn't seem to be an easy way to dynamically add
single properties to the OFDT, and because the userspace dependency on this
property is being questioned, I've ignored it for now.  If we decide on a
solution for this at a later point, it can also be easily fixed up.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Nru a/arch/ppc64/kernel/pSeries_pci.c b/arch/ppc64/kernel/pSeries_pci.c
--- a/arch/ppc64/kernel/pSeries_pci.c	Tue Sep 28 15:11:38 2004
+++ b/arch/ppc64/kernel/pSeries_pci.c	Tue Sep 28 15:11:38 2004
@@ -190,7 +190,7 @@
 	ibm_write_pci_config = rtas_token("ibm,write-pci-config");
 }
 
-unsigned long __init get_phb_buid (struct device_node *phb)
+unsigned long __devinit get_phb_buid (struct device_node *phb)
 {
 	int addr_cells;
 	unsigned int *buid_vals;
@@ -220,48 +220,85 @@
 	return buid;
 }
 
-static struct pci_controller * __init alloc_phb(struct device_node *dev,
-				 unsigned int addr_size_words)
+static enum phb_types get_phb_type(struct device_node *dev)
 {
-	struct pci_controller *phb;
-	unsigned int *ui_ptr = NULL, len;
-	struct reg_property64 reg_struct;
-	int *bus_range;
+	enum phb_types type;
 	char *model;
-	enum phb_types phb_type;
- 	struct property *of_prop;
 
 	model = (char *)get_property(dev, "model", NULL);
 
 	if (!model) {
-		printk(KERN_ERR "alloc_phb: phb has no model property\n");
+		printk(KERN_ERR "%s: phb has no model property\n",
+				__FUNCTION__);
 		model = "<empty>";
 	}
 
+	if (strstr(model, "Python")) {
+		type = phb_type_python;
+	} else if (strstr(model, "Speedwagon")) {
+		type = phb_type_speedwagon;
+	} else if (strstr(model, "Winnipeg")) {
+		type = phb_type_winnipeg;
+	} else {
+		printk(KERN_ERR "%s: unknown PHB %s\n", __FUNCTION__, model);
+		type = phb_type_unknown;
+	}
+
+	return type;
+}
+
+int get_phb_reg_prop(struct device_node *dev, unsigned int addr_size_words,
+		struct reg_property64 *reg)
+{
+	unsigned int *ui_ptr = NULL, len;
+
 	/* Found a PHB, now figure out where his registers are mapped. */
 	ui_ptr = (unsigned int *) get_property(dev, "reg", &len);
 	if (ui_ptr == NULL) {
 		PPCDBG(PPCDBG_PHBINIT, "\tget reg failed.\n"); 
-		return NULL;
+		return 1;
 	}
 
 	if (addr_size_words == 1) {
-		reg_struct.address = ((struct reg_property32 *)ui_ptr)->address;
-		reg_struct.size    = ((struct reg_property32 *)ui_ptr)->size;
+		reg->address = ((struct reg_property32 *)ui_ptr)->address;
+		reg->size    = ((struct reg_property32 *)ui_ptr)->size;
 	} else {
-		reg_struct = *((struct reg_property64 *)ui_ptr);
+		*reg = *((struct reg_property64 *)ui_ptr);
 	}
 
-	if (strstr(model, "Python")) {
-		phb_type = phb_type_python;
-	} else if (strstr(model, "Speedwagon")) {
-		phb_type = phb_type_speedwagon;
-	} else if (strstr(model, "Winnipeg")) {
-		phb_type = phb_type_winnipeg;
-	} else {
-		printk(KERN_ERR "alloc_phb: unknown PHB %s\n", model);
-		phb_type = phb_type_unknown;
-	}
+	return 0;
+}
+
+int phb_set_bus_ranges(struct device_node *dev, struct pci_controller *phb)
+{
+	int *bus_range;
+	unsigned int len;
+
+	bus_range = (int *) get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		return 1;
+ 	}
+ 
+	phb->first_busno =  bus_range[0];
+	phb->last_busno  =  bus_range[1];
+
+	return 0;
+}
+
+static struct pci_controller *alloc_phb(struct device_node *dev,
+				 unsigned int addr_size_words)
+{
+	struct pci_controller *phb;
+	struct reg_property64 reg_struct;
+	enum phb_types phb_type;
+	struct property *of_prop;
+	int rc;
+
+	phb_type = get_phb_type(dev);
+
+	rc = get_phb_reg_prop(dev, addr_size_words, &reg_struct);
+	if (rc)
+		return NULL;
 
 	phb = pci_alloc_pci_controller(phb_type);
 	if (phb == NULL)
@@ -270,11 +307,9 @@
 	if (phb_type == phb_type_python)
 		python_countermeasures(reg_struct.address);
 
-	bus_range = (int *) get_property(dev, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		kfree(phb);
+	rc = phb_set_bus_ranges(dev, phb);
+	if (rc)
 		return NULL;
-	}
 
 	of_prop = (struct property *)alloc_bootmem(sizeof(struct property) +
 			sizeof(phb->global_number));        
@@ -291,9 +326,6 @@
 	memcpy(of_prop->value, &phb->global_number, sizeof(phb->global_number));
 	prom_add_property(dev, of_prop);
 
-	phb->first_busno =  bus_range[0];
-	phb->last_busno  =  bus_range[1];
-
 	phb->arch_data   = dev;
 	phb->ops = &rtas_pci_ops;
 
@@ -302,6 +334,40 @@
 	return phb;
 }
 
+static struct pci_controller * __devinit alloc_phb_dynamic(struct device_node *dev, unsigned int addr_size_words)
+{
+	struct pci_controller *phb;
+	struct reg_property64 reg_struct;
+	enum phb_types phb_type;
+	int rc;
+
+	phb_type = get_phb_type(dev);
+
+	rc = get_phb_reg_prop(dev, addr_size_words, &reg_struct);
+	if (rc)
+		return NULL;
+
+	phb = pci_alloc_phb_dynamic(phb_type);
+	if (phb == NULL)
+		return NULL;
+
+	if (phb_type == phb_type_python)
+		python_countermeasures(reg_struct.address);
+
+	rc = phb_set_bus_ranges(dev, phb);
+	if (rc)
+		return NULL;
+
+	/* TODO: linux,pci-domain? */
+
+	phb->arch_data   = dev;
+	phb->ops = &rtas_pci_ops;
+
+	phb->buid = get_phb_buid(dev);
+
+ 	return phb;
+}
+
 unsigned long __init find_and_init_phbs(void)
 {
 	struct device_node *node;
@@ -330,7 +396,8 @@
 		if (!phb)
 			continue;
 
-		pci_process_bridge_OF_ranges(phb, node, index == 0);
+		pci_process_bridge_OF_ranges(phb, node);
+		pci_setup_phb_io(phb, index == 0);
 
 		if (naca->interrupt_controller == IC_OPEN_PIC) {
 			int addr = root_size_cells * (index + 2) - 1;
@@ -346,6 +413,34 @@
 	return 0;
 }
 
+struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
+{
+	struct device_node *root = of_find_node_by_path("/");
+	unsigned int root_size_cells = 0;
+	struct pci_controller *phb;
+	struct pci_bus *bus;
+
+	root_size_cells = prom_n_size_cells(root);
+
+	phb = alloc_phb_dynamic(dn, root_size_cells);
+	if (!phb)
+		return NULL;
+
+	pci_process_bridge_OF_ranges(phb, dn);
+
+	pci_setup_phb_io_dynamic(phb);
+	of_node_put(root);
+
+	pci_devs_phb_init_dynamic(phb);
+	phb->last_busno = 0xff;
+	bus = pci_scan_bus(phb->first_busno, phb->ops, phb->arch_data);
+	phb->bus = bus;
+	phb->last_busno = bus->subordinate;
+
+	return phb;
+}
+EXPORT_SYMBOL(init_phb_dynamic);
+
 #if 0
 void pcibios_name_device(struct pci_dev *dev)
 {
@@ -464,7 +559,7 @@
 }
 EXPORT_SYMBOL(remap_bus_range);
 
-static void phbs_fixup_io(void)
+static void phbs_remap_io(void)
 {
 	struct pci_controller *hose, *tmp;
 
@@ -472,7 +567,6 @@
 		remap_bus_range(hose->bus);
 }
 
-
 /* RPA-specific bits for removing PHBs */
 int pcibios_remove_root_bus(struct pci_controller *phb)
 {
@@ -516,6 +610,9 @@
 	}
 
 	list_del(&phb->list_node);
+	if (phb->is_dynamic)
+		kfree(phb);
+
 	return 0;
 }
 EXPORT_SYMBOL(pcibios_remove_root_bus);
@@ -559,7 +656,7 @@
 		}
 	}
 
-	phbs_fixup_io();
+	phbs_remap_io();
 	pSeries_request_regions();
 	pci_fix_bus_sysdata();
 
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	Tue Sep 28 15:11:38 2004
+++ b/arch/ppc64/kernel/pci.c	Tue Sep 28 15:11:38 2004
@@ -179,26 +179,11 @@
 	res->start = start;
 }
 
-/* 
- * Allocate pci_controller(phb) initialized common variables. 
- */
-struct pci_controller * __init
-pci_alloc_pci_controller(enum phb_types controller_type)
+static void phb_set_model(struct pci_controller *hose, 
+			  enum phb_types controller_type)
 {
-        struct pci_controller *hose;
 	char *model;
 
-#ifdef CONFIG_PPC_ISERIES
-        hose = (struct pci_controller *)kmalloc(sizeof(struct pci_controller), GFP_KERNEL);
-#else
-        hose = (struct pci_controller *)alloc_bootmem(sizeof(struct pci_controller));
-#endif
-        if(hose == NULL) {
-                printk(KERN_ERR "PCI: Allocate pci_controller failed.\n");
-                return NULL;
-        }
-        memset(hose, 0, sizeof(struct pci_controller));
-
 	switch(controller_type) {
 #ifdef CONFIG_PPC_ISERIES
 	case phb_type_hypervisor:
@@ -226,12 +211,63 @@
 		strcpy(hose->what,model);
         else
 		memcpy(hose->what,model,7);
-        hose->type = controller_type;
-        hose->global_number = global_phb_number++;
+}
+/*
+ * Allocate pci_controller(phb) initialized common variables.
+ */
+struct pci_controller * __init
+pci_alloc_pci_controller(enum phb_types controller_type)
+{
+	struct pci_controller *hose;
+
+#ifdef CONFIG_PPC_ISERIES
+	hose = (struct pci_controller *)kmalloc(sizeof(struct pci_controller),
+						GFP_KERNEL);
+#else
+	hose = (struct pci_controller *)alloc_bootmem(sizeof(struct pci_controller));
+#endif
+	if (hose == NULL) {
+		printk(KERN_ERR "PCI: Allocate pci_controller failed.\n");
+		return NULL;
+	}
+	memset(hose, 0, sizeof(struct pci_controller));
+
+	phb_set_model(hose, controller_type);
+
+	hose->is_dynamic = 0;
+	hose->type = controller_type;
+	hose->global_number = global_phb_number++;
+
+	list_add_tail(&hose->list_node, &hose_list);
+
+	return hose;
+}
+
+/*
+ * Dymnamically allocate pci_controller(phb), initialize common variables.
+ */
+struct pci_controller *
+pci_alloc_phb_dynamic(enum phb_types controller_type)
+{
+	struct pci_controller *hose;
+
+	hose = (struct pci_controller *)kmalloc(sizeof(struct pci_controller),
+						GFP_KERNEL);
+	if(hose == NULL) {
+		printk(KERN_ERR "PCI: Allocate pci_controller failed.\n");
+		return NULL;
+	}
+	memset(hose, 0, sizeof(struct pci_controller));
+
+	phb_set_model(hose, controller_type);
+
+	hose->is_dynamic = 1;
+	hose->type = controller_type;
+	hose->global_number = global_phb_number++;
 
 	list_add_tail(&hose->list_node, &hose_list);
 
-        return hose;
+	return hose;
 }
 
 static void __init pcibios_claim_one_bus(struct pci_bus *b)
@@ -534,7 +570,7 @@
 #define ISA_SPACE_MASK 0x1
 #define ISA_SPACE_IO 0x1
 
-static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
+static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
 				      unsigned long phb_io_base_phys,
 				      void * phb_io_base_virt)
 {
@@ -579,8 +615,8 @@
 	}
 }
 
-void __init pci_process_bridge_OF_ranges(struct pci_controller *hose,
-					 struct device_node *dev, int primary)
+void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
+					struct device_node *dev)
 {
 	unsigned int *ranges;
 	unsigned long size;
@@ -589,7 +625,6 @@
 	struct resource *res;
 	int np, na = prom_n_addr_cells(dev);
 	unsigned long pci_addr, cpu_phys_addr;
-	struct device_node *isa_dn;
 
 	np = na + 5;
 
@@ -617,31 +652,11 @@
 		switch (ranges[0] >> 24) {
 		case 1:		/* I/O space */
 			hose->io_base_phys = cpu_phys_addr;
-			hose->io_base_virt = reserve_phb_iospace(size);
-			PPCDBG(PPCDBG_PHBINIT, 
-			       "phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n", 
-			       hose->global_number, hose->io_base_phys, 
-			       (unsigned long) hose->io_base_virt);
-
-			if (primary) {
-				pci_io_base = (unsigned long)hose->io_base_virt;
-				isa_dn = of_find_node_by_type(NULL, "isa");
-				if (isa_dn) {
-					isa_io_base = pci_io_base;
-					pci_process_ISA_OF_ranges(isa_dn,
-						hose->io_base_phys,
-						hose->io_base_virt);
-					of_node_put(isa_dn);
-                                        /* Allow all IO */
-                                        io_page_mask = -1;
-				}
-			}
+			hose->pci_io_size = size;
 
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
 			res->start = pci_addr;
-			res->start += (unsigned long)hose->io_base_virt -
-				pci_io_base;
 			break;
 		case 2:		/* memory space */
 			memno = 0;
@@ -666,6 +681,55 @@
 		}
 		ranges += np;
 	}
+}
+
+void __init pci_setup_phb_io(struct pci_controller *hose, int primary)
+{
+	unsigned long size = hose->pci_io_size;
+	unsigned long io_virt_offset;
+	struct resource *res;
+	struct device_node *isa_dn;
+
+	hose->io_base_virt = reserve_phb_iospace(size);
+	PPCDBG(PPCDBG_PHBINIT, "phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
+		hose->global_number, hose->io_base_phys,
+		(unsigned long) hose->io_base_virt);
+
+	if (primary) {
+		pci_io_base = (unsigned long)hose->io_base_virt;
+		isa_dn = of_find_node_by_type(NULL, "isa");
+		if (isa_dn) {
+			isa_io_base = pci_io_base;
+			pci_process_ISA_OF_ranges(isa_dn, hose->io_base_phys,
+						hose->io_base_virt);
+			of_node_put(isa_dn);
+			/* Allow all IO */
+			io_page_mask = -1;
+		}
+	}
+
+	io_virt_offset = (unsigned long)hose->io_base_virt - pci_io_base;
+	res = &hose->io_resource;
+	res->start += io_virt_offset;
+	res->end += io_virt_offset;
+}
+
+void __devinit pci_setup_phb_io_dynamic(struct pci_controller *hose)
+{
+	unsigned long size = hose->pci_io_size;
+	unsigned long io_virt_offset;
+	struct resource *res;
+
+	hose->io_base_virt = __ioremap(hose->io_base_phys, size,
+					_PAGE_NO_CACHE);
+	PPCDBG(PPCDBG_PHBINIT, "phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
+		hose->global_number, hose->io_base_phys,
+		(unsigned long) hose->io_base_virt);
+
+	io_virt_offset = (unsigned long)hose->io_base_virt - pci_io_base;
+	res = &hose->io_resource;
+	res->start += io_virt_offset;
+	res->end += io_virt_offset;
 }
 
 /*********************************************************************** 
diff -Nru a/arch/ppc64/kernel/pci.h b/arch/ppc64/kernel/pci.h
--- a/arch/ppc64/kernel/pci.h	Tue Sep 28 15:11:38 2004
+++ b/arch/ppc64/kernel/pci.h	Tue Sep 28 15:11:38 2004
@@ -15,7 +15,12 @@
 extern unsigned long isa_io_base;
 
 extern struct pci_controller* pci_alloc_pci_controller(enum phb_types controller_type);
+extern struct pci_controller* pci_alloc_phb_dynamic(enum phb_types controller_type);
+extern void pci_setup_phb_io(struct pci_controller *hose, int primary);
+
 extern struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node);
+extern void pci_setup_phb_io_dynamic(struct pci_controller *hose);
+
 
 extern struct list_head hose_list;
 extern int global_phb_number;
@@ -36,6 +41,7 @@
 		void *data);
 
 void pci_devs_phb_init(void);
+void pci_devs_phb_init_dynamic(struct pci_controller *phb);
 void pci_fix_bus_sysdata(void);
 struct device_node *fetch_dev_dn(struct pci_dev *dev);
 
diff -Nru a/arch/ppc64/kernel/pci_dn.c b/arch/ppc64/kernel/pci_dn.c
--- a/arch/ppc64/kernel/pci_dn.c	Tue Sep 28 15:11:38 2004
+++ b/arch/ppc64/kernel/pci_dn.c	Tue Sep 28 15:11:38 2004
@@ -42,7 +42,7 @@
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
  */
-static void * __init update_dn_pci_info(struct device_node *dn, void *data)
+static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
 	u32 *regs;
@@ -139,6 +139,12 @@
 	return NULL;
 }
 
+void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
+{
+	/* Update dn->phb ptrs for new phb and children devices */
+	traverse_pci_devices((struct device_node *)phb->arch_data,
+			update_dn_pci_info, phb);
+}
 
 /*
  * Traversal func that looks for a <busno,devfcn> value.
diff -Nru a/include/asm-ppc64/pci-bridge.h b/include/asm-ppc64/pci-bridge.h
--- a/include/asm-ppc64/pci-bridge.h	Tue Sep 28 15:11:38 2004
+++ b/include/asm-ppc64/pci-bridge.h	Tue Sep 28 15:11:38 2004
@@ -34,6 +34,7 @@
 	char what[8];                     /* Eye catcher      */
 	enum phb_types type;              /* Type of hardware */
 	struct pci_bus *bus;
+	char is_dynamic;
 	void *arch_data;
 	struct list_head list_node;
 
@@ -47,6 +48,7 @@
 	 * the PCI memory space in the CPU bus space
 	 */
 	unsigned long pci_mem_offset;
+	unsigned long pci_io_size;
 
 	struct pci_ops *ops;
 	volatile unsigned int *cfg_addr;
@@ -88,7 +90,7 @@
 }
 
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-					 struct device_node *dev, int primary);
+					 struct device_node *dev);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	Tue Sep 28 15:11:38 2004
+++ b/include/asm-ppc64/pci.h	Tue Sep 28 15:11:38 2004
@@ -229,6 +229,8 @@
 extern void
 pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus);
 
+extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
+
 extern int pci_read_irq_line(struct pci_dev *dev);
 
 extern void pcibios_add_platform_entries(struct pci_dev *dev);
