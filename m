Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUBSSLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUBSSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:11:34 -0500
Received: from cfcafw.SGI.COM ([198.149.23.1]:11273 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267329AbUBSSKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:10:44 -0500
Date: Thu, 19 Feb 2004 12:09:02 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: davidm@hpl.hp.com, Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
       davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
In-Reply-To: <20040218184411.A11714@infradead.org>
Message-ID: <Pine.SGI.3.96.1040219120145.25715B-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Christoph Hellwig wrote:

+ On Wed, Feb 18, 2004 at 10:38:06AM -0800, David Mosberger wrote:
+ > I don't think anybody is wedded to the code there.  From what I know,
+ > it works fine, but if you want to submit enhancements, I'm pretty sure
+ > they'd be appreciated.
+ 
+ I've submitted a bunch of patches in that area last autum.  This resulted
+ in a big flamewar and most are still outstanding :)
+ 

I looked over the original email that hch sent quite awhle ago on the
fixup code.

This patch is closer to what was suggested:


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1653  -> 1.1654 
#	arch/ia64/sn/io/machvec/pci_bus_cvlink.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/19	pfg@sgi.com	1.1654
# arch/ia64/sn/io/machvec/pci_bus_cvlink.c
#     I incorporated (at least in spirit I hope) hch's suggestions on the fixup code
#     put in some kfrees that I was missing and static for sn_alloc_pci_sysdata
#        (thanks Bartlomiej Zolnierkiewicz)
#     White space clean up
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb 19 12:06:34 2004
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb 19 12:06:34 2004
@@ -54,7 +54,7 @@
 }
 
 /*
- * pci_bus_cvlink_init() - To be called once during initialization before 
+ * pci_bus_cvlink_init() - To be called once during initialization before
  *	SGI IO Infrastructure init is called.
  */
 int
@@ -74,7 +74,7 @@
 }
 
 /*
- * pci_bus_to_vertex() - Given a logical Linux Bus Number returns the associated 
+ * pci_bus_to_vertex() - Given a logical Linux Bus Number returns the associated
  *	pci bus vertex from the SGI IO Infrastructure.
  */
 static inline vertex_hdl_t
@@ -92,7 +92,7 @@
 }
 
 /*
- * devfn_to_vertex() - returns the vertex of the device given the bus, slot, 
+ * devfn_to_vertex() - returns the vertex of the device given the bus, slot,
  *	and function numbers.
  */
 vertex_hdl_t
@@ -133,8 +133,8 @@
 	 * ../pci/1, ../pci/2 ..
 	 */
 	if (func == 0) {
-        	sprintf(name, "%d", slot);
-		if (hwgraph_traverse(pci_bus, name, &device_vertex) == 
+		sprintf(name, "%d", slot);
+		if (hwgraph_traverse(pci_bus, name, &device_vertex) ==
 			GRAPH_SUCCESS) {
 			if (device_vertex) {
 				return(device_vertex);
@@ -161,7 +161,7 @@
  *	which is expected as the pci_dev and pci_bus sysdata by the Linux
  *      PCI infrastructure.
  */
-struct pci_controller *
+static struct pci_controller *
 sn_alloc_pci_sysdata(void)
 {
 	struct pci_controller *pci_sysdata;
@@ -195,6 +195,7 @@
 	if (!widget_sysdata) {
 		printk(KERN_WARNING "sn_pci_fixup_bus(): Unable to "
 			       "allocate memory for widget_sysdata\n");
+		kfree(pci_sysdata);
 		return -ENOMEM;
 	}
 
@@ -240,6 +241,7 @@
 	if (!device_sysdata) {
 		printk(KERN_WARNING "sn_pci_fixup_slot: Unable to "
 			       "allocate memory for device_sysdata\n");
+		kfree(pci_sysdata);
 		return -ENOMEM;
 	}
 
@@ -262,69 +264,69 @@
 	vhdl = device_sysdata->vhdl;
 
 	/* Allocate the IORESOURCE_IO space first */
-        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
-                unsigned long start, end, addr;
+	for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+		unsigned long start, end, addr;
 
 		device_sysdata->pio_map[idx] = NULL;
 
-                if (!(dev->resource[idx].flags & IORESOURCE_IO))
-                        continue;
+		if (!(dev->resource[idx].flags & IORESOURCE_IO))
+			continue;
 
-                start = dev->resource[idx].start;
-                end = dev->resource[idx].end;
-                size = end - start;
-                if (!size)
-                        continue;
+		start = dev->resource[idx].start;
+		end = dev->resource[idx].end;
+		size = end - start;
+		if (!size)
+			continue;
 
-                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
-                                PCIIO_SPACE_WIN(idx), 0, size,
+		addr = (unsigned long)pciio_pio_addr(vhdl, 0,
+		PCIIO_SPACE_WIN(idx), 0, size,
 				&device_sysdata->pio_map[idx], 0);
 
-                if (!addr) {
-                        dev->resource[idx].start = 0;
-                        dev->resource[idx].end = 0;
-                        printk("sn_pci_fixup(): pio map failure for "
-                            "%s bar%d\n", dev->slot_name, idx);
-                } else {
-                        addr |= __IA64_UNCACHED_OFFSET;
-                        dev->resource[idx].start = addr;
-                        dev->resource[idx].end = addr + size;
-                }
-
-                if (dev->resource[idx].flags & IORESOURCE_IO)
-                        cmd |= PCI_COMMAND_IO;
-        }
-
-        /* Allocate the IORESOURCE_MEM space next */
-        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
-                unsigned long start, end, addr;
-
-                if ((dev->resource[idx].flags & IORESOURCE_IO))
-                        continue;
-
-                start = dev->resource[idx].start;
-                end = dev->resource[idx].end;
-                size = end - start;
-                if (!size)
-                        continue;
+		if (!addr) {
+			dev->resource[idx].start = 0;
+			dev->resource[idx].end = 0;
+			printk("sn_pci_fixup(): pio map failure for "
+				"%s bar%d\n", dev->slot_name, idx);
+		} else {
+			addr |= __IA64_UNCACHED_OFFSET;
+			dev->resource[idx].start = addr;
+			dev->resource[idx].end = addr + size;
+		}
+
+		if (dev->resource[idx].flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+	}
+
+	/* Allocate the IORESOURCE_MEM space next */
+	for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+		unsigned long start, end, addr;
+
+		if ((dev->resource[idx].flags & IORESOURCE_IO))
+			continue;
 
-                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
-                                PCIIO_SPACE_WIN(idx), 0, size,
+		start = dev->resource[idx].start;
+		end = dev->resource[idx].end;
+		size = end - start;
+		if (!size)
+			continue;
+
+		addr = (unsigned long)pciio_pio_addr(vhdl, 0,
+		PCIIO_SPACE_WIN(idx), 0, size,
 				&device_sysdata->pio_map[idx], 0);
 
-                if (!addr) {
-                        dev->resource[idx].start = 0;
-                        dev->resource[idx].end = 0;
-                        printk("sn_pci_fixup(): pio map failure for "
-                            "%s bar%d\n", dev->slot_name, idx);
-                } else {
-                        addr |= __IA64_UNCACHED_OFFSET;
-                        dev->resource[idx].start = addr;
-                        dev->resource[idx].end = addr + size;
-                }
+		if (!addr) {
+			dev->resource[idx].start = 0;
+			dev->resource[idx].end = 0;
+			printk("sn_pci_fixup(): pio map failure for "
+				"%s bar%d\n", dev->slot_name, idx);
+		} else {
+			addr |= __IA64_UNCACHED_OFFSET;
+			dev->resource[idx].start = addr;
+			dev->resource[idx].end = addr + size;
+		}
 
-                if (dev->resource[idx].flags & IORESOURCE_MEM)
-                        cmd |= PCI_COMMAND_MEMORY;
+		if (dev->resource[idx].flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
 	}
 
 	/*
@@ -347,6 +349,8 @@
 	intr_handle = (pci_provider->intr_alloc)(device_vertex, NULL, lines, device_vertex);
 	if (intr_handle == NULL) {
 		printk(KERN_WARNING "sn_pci_fixup:  pcibr_intr_alloc() failed\n");
+		kfree(pci_sysdata);
+		kfree(device_sysdata);
 		return -ENOMEM;
 	}
 
@@ -384,16 +388,16 @@
 struct sn_flush_nasid_entry flush_nasid_list[MAX_NASIDS];
 
 /* Initialize the data structures for flushing write buffers after a PIO read.
- * The theory is: 
+ * The theory is:
  * Take an unused int. pin and associate it with a pin that is in use.
  * After a PIO read, force an interrupt on the unused pin, forcing a write buffer flush
- * on the in use pin.  This will prevent the race condition between PIO read responses and 
+ * on the in use pin.  This will prevent the race condition between PIO read responses and
  * DMA writes.
  */
 static struct sn_flush_device_list *
 sn_dma_flush_init(unsigned long start, unsigned long end, int idx, int pin, int slot)
 {
-	nasid_t nasid; 
+	nasid_t nasid;
 	unsigned long dnasid;
 	int wid_num;
 	int bus;
@@ -422,8 +426,8 @@
 
 		itte = HUB_L(IIO_ITTE_GET(nasid, itte_index));
 		flush_nasid_list[nasid].iio_itte[bwin] = itte;
-		wid_num = (itte >> IIO_ITTE_WIDGET_SHIFT) & 
-			  IIO_ITTE_WIDGET_MASK;
+		wid_num = (itte >> IIO_ITTE_WIDGET_SHIFT)
+				& IIO_ITTE_WIDGET_MASK;
 		bus = itte & IIO_ITTE_OFFSET_MASK;
 		if (bus == 0x4 || bus == 0x8) {
 			bus = 0;
@@ -445,7 +449,7 @@
 			printk(KERN_WARNING "sn_dma_flush_init: Cannot allocate memory for nasid sub-list\n");
 			return NULL;
 		}
-		memset(flush_nasid_list[nasid].widget_p[wid_num], 0, 
+		memset(flush_nasid_list[nasid].widget_p[wid_num], 0,
 			DEV_PER_WIDGET * sizeof (struct sn_flush_device_list));
 		p = &flush_nasid_list[nasid].widget_p[wid_num][0];
 		for (i=0; i<DEV_PER_WIDGET;i++) {
@@ -484,7 +488,7 @@
 	 * about the case when there is a card in slot 2.  A multifunction card will appear
 	 * to be in slot 6 (from an interrupt point of view) also.  That's the  most we'll
 	 * have to worry about.  A four function card will overload the interrupt lines in
-	 * slot 2 and 6.  
+	 * slot 2 and 6.
 	 * We also need to special case the 12160 device in slot 3.  Fortunately, we have
 	 * a spare intr. line for pin 4, so we'll use that for the 12160.
 	 * All other buses have slot 3 and 4 and slots 7 and 8 unused.  Since we can only
@@ -504,21 +508,21 @@
 			pcireg_bridge_intr_device_bit_set(b, (1<<18));
 			dnasid = NASID_GET(virt_to_phys(&p->flush_addr));
 			pcireg_bridge_intr_addr_set(b, 6, ((virt_to_phys(&p->flush_addr) & 0xfffffffff) |
-						    (dnasid << 36) | (0xfUL << 48)));
+					(dnasid << 36) | (0xfUL << 48)));
 		} else if (pin == 2) { /* 12160 SCSI device in IO9 */
 			p->force_int_addr = (unsigned long)pcireg_bridge_force_always_addr_get(b, 4);
 			pcireg_bridge_intr_device_bit_set(b, (2<<12));
 			dnasid = NASID_GET(virt_to_phys(&p->flush_addr));
 			pcireg_bridge_intr_addr_set(b, 4,
 					((virt_to_phys(&p->flush_addr) & 0xfffffffff) |
-					    (dnasid << 36) | (0xfUL << 48)));
+					(dnasid << 36) | (0xfUL << 48)));
 		} else { /* slot == 6 */
 			p->force_int_addr = (unsigned long)pcireg_bridge_force_always_addr_get(b, 7);
 			pcireg_bridge_intr_device_bit_set(b, (5<<21));
 			dnasid = NASID_GET(virt_to_phys(&p->flush_addr));
 			pcireg_bridge_intr_addr_set(b, 7,
 					((virt_to_phys(&p->flush_addr) & 0xfffffffff) |
-					    (dnasid << 36) | (0xfUL << 48)));
+					(dnasid << 36) | (0xfUL << 48)));
 		}
 	} else {
 		p->force_int_addr = (unsigned long)pcireg_bridge_force_always_addr_get(b, (pin +2));
@@ -526,99 +530,13 @@
 		dnasid = NASID_GET(virt_to_phys(&p->flush_addr));
 		pcireg_bridge_intr_addr_set(b, (pin + 2),
 				((virt_to_phys(&p->flush_addr) & 0xfffffffff) |
-				    (dnasid << 36) | (0xfUL << 48)));
+				(dnasid << 36) | (0xfUL << 48)));
 	}
 	return p;
 }
 
 /*
- * sn_pci_fixup() - This routine is called when platform_pci_fixup() is 
- *	invoked at the end of pcibios_init() to link the Linux pci 
- *	infrastructure to SGI IO Infrasturcture - ia64/kernel/pci.c
- *
- *	Other platform specific fixup can also be done here.
- */
-static void __init
-sn_pci_fixup(int arg)
-{
-	struct list_head *ln;
-	struct pci_bus *pci_bus = NULL;
-	struct pci_dev *pci_dev = NULL;
-	extern int numnodes;
-	int cnode, ret;
-
-	if (arg == 0) {
-#ifdef CONFIG_PROC_FS
-		extern void register_sn_procfs(void);
-#endif
-		extern void sgi_master_io_infr_init(void);
-		extern void sn_init_cpei_timer(void);
-
-		sgi_master_io_infr_init();
-
-		for (cnode = 0; cnode < numnodes; cnode++) {
-			extern void intr_init_vecblk(cnodeid_t);
-			intr_init_vecblk(cnode);
-		} 
-
-		sn_init_cpei_timer();
-
-#ifdef CONFIG_PROC_FS
-		register_sn_procfs();
-#endif
-		return;
-	}
-
-	done_probing = 1;
-
-	/*
-	 * Initialize the pci bus vertex in the pci_bus struct.
-	 */
-        for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		pci_bus = pci_bus_b(ln);
-		ret = sn_pci_fixup_bus(pci_bus);
-		if ( ret ) {
-			printk(KERN_WARNING
-				"sn_pci_fixup: sn_pci_fixup_bus fails : error %d\n",
-			       		ret);
-			return;
-		}
-	}
-
-	/*
- 	 * set the root start and end so that drivers calling check_region()
-	 * won't see a conflict
-	 */
-
-#ifdef CONFIG_IA64_SGI_SN_SIM
-	if (! IS_RUNNING_ON_SIMULATOR()) {
-		ioport_resource.start  = 0xc000000000000000;
-		ioport_resource.end =    0xcfffffffffffffff;
-	}
-#endif
-
-	/*
-	 * Set the root start and end for Mem Resource.
-	 */
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffffffffffff;
-
-	/*
-	 * Initialize the device vertex in the pci_dev struct.
-	 */
-	while ((pci_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
-		ret = sn_pci_fixup_slot(pci_dev);
-		if ( ret ) {
-			printk(KERN_WARNING
-				"sn_pci_fixup: sn_pci_fixup_slot fails : error %d\n",
-			       		ret);
-			return;
-		}
-	}
-}
-
-/*
- * linux_bus_cvlink() Creates a link between the Linux PCI Bus number 
+ * linux_bus_cvlink() Creates a link between the Linux PCI Bus number
  *	to the actual hardware component that it represents:
  *	/dev/hw/linux/busnum/0 -> ../../../hw/module/001c01/slab/0/Ibrick/xtalk/15/pci
  *
@@ -638,7 +556,7 @@
 			continue;
 
 		sprintf(name, "%x", index);
-		(void) hwgraph_edge_add(linux_busnum, busnum_to_pcibr_vhdl[index], 
+		(void) hwgraph_edge_add(linux_busnum, busnum_to_pcibr_vhdl[index],
 				name);
 	}
 }
@@ -649,7 +567,7 @@
  *	Linux PCI Bus numbers are assigned from lowest module_id numbers
  *	(rack/slot etc.)
  */
-static int 
+static int
 pci_bus_map_create(struct pcibr_list_s *softlistp, moduleid_t moduleid)
 {
 	
@@ -659,10 +577,10 @@
 
 	memset(moduleid_str, 0, 16);
 	format_module_id(moduleid_str, moduleid, MODULE_FORMAT_BRIEF);
-        (void) ioconfig_get_busnum((char *)moduleid_str, &basebus_num);
+	(void) ioconfig_get_busnum((char *)moduleid_str, &basebus_num);
 
 	/*
-	 * Assign the correct bus number and also the nasid of this 
+	 * Assign the correct bus number and also the nasid of this
 	 * pci Xwidget.
 	 */
 	bus_number = basebus_num + pcibr_widget_to_bus(pci_bus);
@@ -690,20 +608,20 @@
 		printk("pci_bus_map_create: Cannot allocate memory for ate maps\n");
 		return -1;
 	}
-	memset(busnum_to_atedmamaps[bus_number], 0x0, 
+	memset(busnum_to_atedmamaps[bus_number], 0x0,
 			sizeof(struct pcibr_dmamap_s) * MAX_ATE_MAPS);
 	return(0);
 }
 
 /*
- * pci_bus_to_hcl_cvlink() - This routine is called after SGI IO Infrastructure 
+ * pci_bus_to_hcl_cvlink() - This routine is called after SGI IO Infrastructure
  *      initialization has completed to set up the mappings between PCI BRIDGE
- *      ASIC and logical pci bus numbers. 
+ *      ASIC and logical pci bus numbers.
  *
  *      Must be called before pci_init() is invoked.
  */
 int
-pci_bus_to_hcl_cvlink(void) 
+pci_bus_to_hcl_cvlink(void)
 {
 	int i;
 	extern pcibr_list_p pcibr_list;
@@ -720,7 +638,7 @@
 			
 			/* Is this PCI bus associated with this moduleid? */
 			moduleid = NODE_MODULEID(
-			    NASID_TO_COMPACT_NODEID(pcibr_soft->bs_nasid));
+				NASID_TO_COMPACT_NODEID(pcibr_soft->bs_nasid));
 			if (modules[i]->id == moduleid) {
 				struct pcibr_list_s *new_element;
 
@@ -741,9 +659,9 @@
 					continue;
 				}
 
-				/* 
- 				 * BASEIO IObricks attached to a module have 
-				 * a higher priority than non BASEIO IOBricks 
+				/*
+				 * BASEIO IObricks attached to a module have
+				 * a higher priority than non BASEIO IOBricks
 				 * when it comes to persistant pci bus
 				 * numbering, so put them on the front of the
 				 * list.
@@ -759,7 +677,7 @@
 			softlistp = softlistp->bl_next;
 		}
 				
-		/* 
+		/*
 		 * We now have a list of all the pci bridges associated with
 		 * the module_id, modules[i].  Call pci_bus_map_create() for
 		 * each pci bridge
@@ -787,13 +705,26 @@
 /*
  * Ugly hack to get PCI setup until we have a proper ACPI namespace.
  */
+
+#define PCI_BUSES_TO_SCAN 256
+
 extern struct pci_ops sn_pci_ops;
 int __init
 sn_pci_init (void)
 {
-#	define PCI_BUSES_TO_SCAN 256
 	int i = 0;
 	struct pci_controller *controller;
+	struct list_head *ln;
+	struct pci_bus *pci_bus = NULL;
+	struct pci_dev *pci_dev = NULL;
+	extern int numnodes;
+	int cnode, ret;
+#ifdef CONFIG_PROC_FS
+	extern void register_sn_procfs(void);
+#endif
+	extern void sgi_master_io_infr_init(void);
+	extern void sn_init_cpei_timer(void);
+
 
 	if (!ia64_platform_is("sn2") || IS_RUNNING_ON_SIMULATOR())
 		return 0;
@@ -806,7 +737,19 @@
 	/*
 	 * set pci_raw_ops, etc.
 	 */
-	sn_pci_fixup(0);
+
+	sgi_master_io_infr_init();
+
+	for (cnode = 0; cnode < numnodes; cnode++) {
+		extern void intr_init_vecblk(cnodeid_t);
+		intr_init_vecblk(cnode);
+	}
+
+	sn_init_cpei_timer();
+
+#ifdef CONFIG_PROC_FS
+	register_sn_procfs();
+#endif
 
 	controller = kmalloc(sizeof(struct pci_controller), GFP_KERNEL);
 	if (controller) {
@@ -819,7 +762,53 @@
 	/*
 	 * actually find devices and fill in hwgraph structs
 	 */
-	sn_pci_fixup(1);
+
+	done_probing = 1;
+
+	/*
+	 * Initialize the pci bus vertex in the pci_bus struct.
+	 */
+	for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
+		pci_bus = pci_bus_b(ln);
+		ret = sn_pci_fixup_bus(pci_bus);
+		if ( ret ) {
+			printk(KERN_WARNING
+				"sn_pci_fixup: sn_pci_fixup_bus fails : error %d\n",
+					ret);
+			return;
+		}
+	}
+
+	/*
+	 * set the root start and end so that drivers calling check_region()
+	 * won't see a conflict
+	 */
+
+#ifdef CONFIG_IA64_SGI_SN_SIM
+	if (! IS_RUNNING_ON_SIMULATOR()) {
+		ioport_resource.start  = 0xc000000000000000;
+		ioport_resource.end =    0xcfffffffffffffff;
+	}
+#endif
+
+	/*
+	 * Set the root start and end for Mem Resource.
+	 */
+	iomem_resource.start = 0;
+	iomem_resource.end = 0xffffffffffffffff;
+
+	/*
+	 * Initialize the device vertex in the pci_dev struct.
+	 */
+	while ((pci_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
+		ret = sn_pci_fixup_slot(pci_dev);
+		if ( ret ) {
+			printk(KERN_WARNING
+				"sn_pci_fixup: sn_pci_fixup_slot fails : error %d\n",
+					ret);
+			return;
+		}
+	}
 
 	return 0;
 }




