Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUBROnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUBROnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:43:50 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:29353 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S267409AbUBROmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:42:37 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
Subject: [2.6 PATCH] Altix update
To: akpm@osdl.org, davidm@napali.hpl.hp.com
Date: Wed, 18 Feb 2004 08:41:18 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here's a small mod for Altix. It breaks up our 'pci fixup' function and
has some other smallish clean ups.

For the ia64 crowd I've added 'platform_data' back into
include/asm-ia64/pci.h

Can you take this ?

Thanks,
-- Pat




diffstat:
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c |  411 ++++++++++++++++++-------------
 arch/ia64/sn/io/machvec/pci_dma.c        |    6 
 arch/ia64/sn/io/sn2/pic.c                |    8 
 include/asm-ia64/pci.h                   |    2 
 include/asm-ia64/sn/pci/pci_bus_cvlink.h |   14 -
 5 files changed, 270 insertions(+), 171 deletions(-)



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1558  -> 1.1559 
#	arch/ia64/sn/io/machvec/pci_dma.c	1.24    -> 1.25   
#	arch/ia64/sn/io/sn2/pic.c	1.14    -> 1.15   
#	arch/ia64/sn/io/machvec/pci_bus_cvlink.c	1.31    -> 1.32   
#	include/asm-ia64/pci.h	1.21    -> 1.22   
#	include/asm-ia64/sn/pci/pci_bus_cvlink.h	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/05	pfg@sgi.com	1.1559
# arch/ia64/sn/io/machvec/pci_bus_cvlink.c
#     Re-orged sn_pci_fixup()
#     sn_dma_flush_init return added - not a void any longer
# arch/ia64/sn/io/machvec/pci_dma.c
#     Wrap references to sysdata in SN_DEVICE_SYSDATA() macro
# arch/ia64/sn/io/sn2/pic.c
#     Some more oom checks
# include/asm-ia64/pci.h
#     Add platform_data
# include/asm-ia64/sn/pci/pci_bus_cvlink.h
#     New data struct elements
#     Removed PCIBUS_VERTEX
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb  5 10:17:40 2004
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Feb  5 10:17:40 2004
@@ -28,7 +28,7 @@
 
 extern void register_pcibr_intr(int irq, pcibr_intr_t intr);
 
-static void sn_dma_flush_init(unsigned long start,
+static struct sn_flush_device_list *sn_dma_flush_init(unsigned long start,
 				unsigned long end,
 				int idx, int pin, int slot);
 extern int cbrick_type_get_nasid(nasid_t);
@@ -156,6 +156,231 @@
 	return(device_vertex);
 }
 
+/*
+ * sn_alloc_pci_sysdata() - This routine allocates a pci controller 
+ *	which is expected as the pci_dev and pci_bus sysdata by the Linux
+ *      PCI infrastructure.
+ */
+struct pci_controller *
+sn_alloc_pci_sysdata(void) 
+{
+	struct pci_controller *pci_sysdata;
+
+	pci_sysdata = kmalloc(sizeof(*pci_sysdata), GFP_KERNEL);
+	if (!pci_sysdata)
+		return NULL;
+
+	memset(pci_sysdata, 0, sizeof(*pci_sysdata));
+	return pci_sysdata;
+}
+
+/*
+ * sn_pci_fixup_bus() - This routine sets up a bus's resources
+ * consistent with the Linux PCI abstraction layer.
+ */
+static int __init
+sn_pci_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_controller *pci_sysdata;
+	struct sn_widget_sysdata *widget_sysdata;
+
+	pci_sysdata = sn_alloc_pci_sysdata();
+	if  (!pci_sysdata) {
+		printk(KERN_WARNING "sn_pci_fixup_bus(): Unable to "
+			       "allocate memory for pci_sysdata\n");
+		return -ENOMEM;
+	}
+	widget_sysdata = kmalloc(sizeof(struct sn_widget_sysdata), 
+				 GFP_KERNEL);
+	if (!widget_sysdata) {
+		printk(KERN_WARNING "sn_pci_fixup_bus(): Unable to "
+			       "allocate memory for widget_sysdata\n");
+		return -ENOMEM;
+	}
+
+	widget_sysdata->vhdl = pci_bus_to_vertex(bus->number);
+	pci_sysdata->platform_data = (void *)widget_sysdata;
+	bus->sysdata = pci_sysdata;
+	return 0;
+}
+
+
+/*
+ * sn_pci_fixup_slot() - This routine sets up a slot's resources
+ * consistent with the Linux PCI abstraction layer.  Resources acquired
+ * from our PCI provider include PIO maps to BAR space and interrupt
+ * objects.
+ */
+static int
+sn_pci_fixup_slot(struct pci_dev *dev)
+{
+	extern int bit_pos_to_irq(int);
+	unsigned int irq;
+	int idx;
+	u16 cmd;
+	vertex_hdl_t vhdl;
+	unsigned long size;
+	struct pci_controller *pci_sysdata;
+	struct sn_device_sysdata *device_sysdata;
+	pciio_intr_line_t lines = 0;
+	vertex_hdl_t device_vertex;
+	pciio_provider_t *pci_provider;
+	pciio_intr_t intr_handle;
+
+	/* Allocate a controller structure */
+	pci_sysdata = sn_alloc_pci_sysdata();
+	if (!pci_sysdata) {
+		printk(KERN_WARNING "sn_pci_fixup_slot: Unable to "
+			       "allocate memory for pci_sysdata\n");
+		return -ENOMEM;
+	}
+
+	/* Set the device vertex */
+	device_sysdata = kmalloc(sizeof(struct sn_device_sysdata), GFP_KERNEL);
+	if (!device_sysdata) {
+		printk(KERN_WARNING "sn_pci_fixup_slot: Unable to "
+			       "allocate memory for device_sysdata\n");
+		return -ENOMEM;
+	}
+
+	device_sysdata->vhdl = devfn_to_vertex(dev->bus->number, dev->devfn);
+	pci_sysdata->platform_data = (void *) device_sysdata;
+	dev->sysdata = pci_sysdata;
+	set_pci_provider(device_sysdata);
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	/*
+	 * Set the resources address correctly.  The assumption here 
+	 * is that the addresses in the resource structure has been
+	 * read from the card and it was set in the card by our
+	 * Infrastructure.  NOTE: PIC and TIOCP don't have big-window
+	 * upport for PCI I/O space.  So by mapping the I/O space
+	 * first we will attempt to use Device(x) registers for I/O
+	 * BARs (which can't use big windows like MEM BARs can).
+	 */
+	vhdl = device_sysdata->vhdl;
+
+	/* Allocate the IORESOURCE_IO space first */
+        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+                unsigned long start, end, addr;
+
+		device_sysdata->pio_map[idx] = NULL;
+
+                if (!(dev->resource[idx].flags & IORESOURCE_IO))
+                        continue;
+                                        
+                start = dev->resource[idx].start;
+                end = dev->resource[idx].end;
+                size = end - start;
+                if (!size)
+                        continue; 
+                                        
+                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
+                                PCIIO_SPACE_WIN(idx), 0, size,
+				&device_sysdata->pio_map[idx], 0);
+
+                if (!addr) {            
+                        dev->resource[idx].start = 0;
+                        dev->resource[idx].end = 0;
+                        printk("sn_pci_fixup(): pio map failure for "
+                            "%s bar%d\n", dev->slot_name, idx);
+                } else {            
+                        addr |= __IA64_UNCACHED_OFFSET;
+                        dev->resource[idx].start = addr;
+                        dev->resource[idx].end = addr + size;
+                }               
+
+                if (dev->resource[idx].flags & IORESOURCE_IO)
+                        cmd |= PCI_COMMAND_IO; 
+        }                       
+
+        /* Allocate the IORESOURCE_MEM space next */
+        for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+                unsigned long start, end, addr;
+
+                if ((dev->resource[idx].flags & IORESOURCE_IO))
+                        continue; 
+
+                start = dev->resource[idx].start;
+                end = dev->resource[idx].end;
+                size = end - start;
+                if (!size)
+                        continue; 
+
+                addr = (unsigned long)pciio_pio_addr(vhdl, 0,
+                                PCIIO_SPACE_WIN(idx), 0, size,
+				&device_sysdata->pio_map[idx], 0);
+
+                if (!addr) {            
+                        dev->resource[idx].start = 0;
+                        dev->resource[idx].end = 0;
+                        printk("sn_pci_fixup(): pio map failure for "
+                            "%s bar%d\n", dev->slot_name, idx);
+                } else {            
+                        addr |= __IA64_UNCACHED_OFFSET;
+                        dev->resource[idx].start = addr;
+                        dev->resource[idx].end = addr + size;
+                }               
+
+                if (dev->resource[idx].flags & IORESOURCE_MEM)
+                        cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	/*
+	 * Update the Command Word on the Card.
+	 */
+	cmd |= PCI_COMMAND_MASTER; /* If the device doesn't support */
+				   /* bit gets dropped .. no harm */
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, (unsigned char *)&lines);
+	device_vertex = device_sysdata->vhdl;
+	pci_provider = device_sysdata->pci_provider;
+	device_sysdata->intr_handle = NULL;
+
+	if (!lines)
+		return 0;
+
+	irqpdaindr->curr = dev;
+
+	intr_handle = (pci_provider->intr_alloc)(device_vertex, NULL, lines, device_vertex);
+	if (intr_handle == NULL) {
+		printk(KERN_WARNING "sn_pci_fixup:  pcibr_intr_alloc() failed\n");
+		return -ENOMEM;
+	}
+
+	device_sysdata->intr_handle = intr_handle;
+	irq = intr_handle->pi_irq;
+	irqpdaindr->device_dev[irq] = dev;
+	(pci_provider->intr_connect)(intr_handle, (intr_func_t)0, (intr_arg_t)0);
+	dev->irq = irq;
+
+	register_pcibr_intr(irq, (pcibr_intr_t)intr_handle);
+
+	for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
+		int ibits = ((pcibr_intr_t)intr_handle)->bi_ibits;
+		int i;
+
+		size = dev->resource[idx].end -
+			dev->resource[idx].start;
+		if (size == 0) continue;
+
+		for (i=0; i<8; i++) {
+			if (ibits & (1 << i) ) {
+				extern pcibr_info_t pcibr_info_get(vertex_hdl_t);
+				device_sysdata->dma_flush_list =
+				 sn_dma_flush_init(dev->resource[idx].start, 
+						   dev->resource[idx].end,
+						   idx,
+						   i,
+						   PCIBR_INFO_SLOT_GET_EXT(pcibr_info_get(device_sysdata->vhdl)));
+			}
+		}
+	}
+	return 0;
+}
+
 struct sn_flush_nasid_entry flush_nasid_list[MAX_NASIDS];
 
 /* Initialize the data structures for flushing write buffers after a PIO read.
@@ -165,7 +390,7 @@
  * on the in use pin.  This will prevent the race condition between PIO read responses and 
  * DMA writes.
  */
-static void
+static struct sn_flush_device_list *
 sn_dma_flush_init(unsigned long start, unsigned long end, int idx, int pin, int slot)
 {
 	nasid_t nasid; 
@@ -187,7 +412,7 @@
 			sizeof(struct sn_flush_device_list *), GFP_KERNEL);
 		if (!flush_nasid_list[nasid].widget_p) {
 			printk(KERN_WARNING "sn_dma_flush_init: Cannot allocate memory for nasid list\n");
-			return;
+			return NULL;
 		}
 		memset(flush_nasid_list[nasid].widget_p, 0, (HUB_WIDGET_ID_MAX+1) * sizeof(struct sn_flush_device_list *));
 	}
@@ -211,14 +436,14 @@
 	 * because these are the IOC4 slots and we don't flush them.
 	 */
 	if (isIO9(nasid) && bus == 0 && (slot == 1 || slot == 4)) {
-		return;
+		return NULL;
 	}
 	if (flush_nasid_list[nasid].widget_p[wid_num] == NULL) {
 		flush_nasid_list[nasid].widget_p[wid_num] = (struct sn_flush_device_list *)kmalloc(
 			DEV_PER_WIDGET * sizeof (struct sn_flush_device_list), GFP_KERNEL);
 		if (!flush_nasid_list[nasid].widget_p[wid_num]) {
 			printk(KERN_WARNING "sn_dma_flush_init: Cannot allocate memory for nasid sub-list\n");
-			return;
+			return NULL;
 		}
 		memset(flush_nasid_list[nasid].widget_p[wid_num], 0, 
 			DEV_PER_WIDGET * sizeof (struct sn_flush_device_list));
@@ -303,6 +528,7 @@
 				((virt_to_phys(&p->flush_addr) & 0xfffffffff) |
 				    (dnasid << 36) | (0xfUL << 48)));
 	}
+	return p;
 }
 
 /*
@@ -317,15 +543,9 @@
 {
 	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
-	struct pci_dev *device_dev = NULL;
-	struct sn_widget_sysdata *widget_sysdata;
-	struct sn_device_sysdata *device_sysdata;
-	pcibr_intr_t intr_handle;
-	pciio_provider_t *pci_provider;
-	vertex_hdl_t device_vertex;
-	pciio_intr_line_t lines = 0;
+	struct pci_dev *pci_dev = NULL;
 	extern int numnodes;
-	int cnode;
+	int cnode, ret;
 
 	if (arg == 0) {
 #ifdef CONFIG_PROC_FS
@@ -333,9 +553,9 @@
 #endif
 		extern void sgi_master_io_infr_init(void);
 		extern void sn_init_cpei_timer(void);
-		
+
 		sgi_master_io_infr_init();
-		
+
 		for (cnode = 0; cnode < numnodes; cnode++) {
 			extern void intr_init_vecblk(cnodeid_t);
 			intr_init_vecblk(cnode);
@@ -349,23 +569,20 @@
 		return;
 	}
 
-
 	done_probing = 1;
 
 	/*
 	 * Initialize the pci bus vertex in the pci_bus struct.
 	 */
-	for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
+        for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
 		pci_bus = pci_bus_b(ln);
-		widget_sysdata = kmalloc(sizeof(struct sn_widget_sysdata), 
-					GFP_KERNEL);
-		if (!widget_sysdata) {
-			printk(KERN_WARNING "sn_pci_fixup(): Unable to "
-			       "allocate memory for widget_sysdata\n");
+		ret = sn_pci_fixup_bus(pci_bus);
+		if ( ret ) {
+			printk(KERN_WARNING
+				"sn_pci_fixup: sn_pci_fixup_bus fails : error %d\n",
+			       		ret);
 			return;
-		}			
-		widget_sysdata->vhdl = pci_bus_to_vertex(pci_bus->number);
-		pci_bus->sysdata = (void *)widget_sysdata;
+		}
 	}
 
 	/*
@@ -389,146 +606,14 @@
 	/*
 	 * Initialize the device vertex in the pci_dev struct.
 	 */
-	while ((device_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device_dev)) != NULL) {
-		unsigned int irq;
-		int idx;
-		u16 cmd;
-		vertex_hdl_t vhdl;
-		unsigned long size;
-		extern int bit_pos_to_irq(int);
-
-		/* Set the device vertex */
-
-		device_sysdata = kmalloc(sizeof(struct sn_device_sysdata),
-					 GFP_KERNEL);
-		if (!device_sysdata) {
-			printk(KERN_WARNING "sn_pci_fixup: Cannot allocate memory for device sysdata\n");
+	while ((pci_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
+		ret = sn_pci_fixup_slot(pci_dev);
+		if ( ret ) {
+			printk(KERN_WARNING
+				"sn_pci_fixup: sn_pci_fixup_slot fails : error %d\n",
+			       		ret);
 			return;
 		}
-
-		device_sysdata->vhdl = devfn_to_vertex(device_dev->bus->number, device_dev->devfn);
-		device_dev->sysdata = (void *) device_sysdata;
-		set_pci_provider(device_sysdata);
-
-		pci_read_config_word(device_dev, PCI_COMMAND, &cmd);
-
-		/*
-		 * Set the resources address correctly.  The assumption here 
-		 * is that the addresses in the resource structure has been
-		 * read from the card and it was set in the card by our
-		 * Infrastructure ..
-		 */
-		vhdl = device_sysdata->vhdl;
-		/* Allocate the IORESOURCE_IO space first */
-		for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
-			unsigned long start, end, addr;
-
-			if (!(device_dev->resource[idx].flags & IORESOURCE_IO))
-				continue; 
-			
-			start = device_dev->resource[idx].start;
-			end = device_dev->resource[idx].end;
-			size = end - start;
-			if (!size)
-				continue; 
-			
-			addr = (unsigned long)pciio_pio_addr(vhdl, 0, 
-					PCIIO_SPACE_WIN(idx), 0, size, 0, 0);
-			if (!addr) {
-				device_dev->resource[idx].start = 0;
-				device_dev->resource[idx].end = 0;
-				printk("sn_pci_fixup(): pio map failure for "
-				    "%s bar%d\n", device_dev->slot_name, idx);
-			} else {
-				addr |= __IA64_UNCACHED_OFFSET;
-				device_dev->resource[idx].start = addr;
-				device_dev->resource[idx].end = addr + size;
-			}	
-
-			if (device_dev->resource[idx].flags & IORESOURCE_IO) 
-				cmd |= PCI_COMMAND_IO; 
-		} 
-
-		/* Allocate the IORESOURCE_MEM space next */
-		for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
-			unsigned long start, end, addr;
-
-			if ((device_dev->resource[idx].flags & IORESOURCE_IO))
-				continue; 
-
-			start = device_dev->resource[idx].start;
-			end = device_dev->resource[idx].end;
-			size = end - start;
-			if (!size)
-				continue; 
-
-			addr = (unsigned long)pciio_pio_addr(vhdl, 0, 
-					PCIIO_SPACE_WIN(idx), 0, size, 0, 0);
-			if (!addr) {
-				device_dev->resource[idx].start = 0;
-				device_dev->resource[idx].end = 0;
-				printk("sn_pci_fixup(): pio map failure for "
-				    "%s bar%d\n", device_dev->slot_name, idx);
-			} else {
-				addr |= __IA64_UNCACHED_OFFSET;
-				device_dev->resource[idx].start = addr;
-				device_dev->resource[idx].end = addr + size;
-			}	
-
-			if (device_dev->resource[idx].flags & IORESOURCE_MEM)
-				cmd |= PCI_COMMAND_MEMORY;
-		}
-
-		/*
-		 * Update the Command Word on the Card.
-		 */
-		cmd |= PCI_COMMAND_MASTER; /* If the device doesn't support */
-					   /* bit gets dropped .. no harm */
-		pci_write_config_word(device_dev, PCI_COMMAND, cmd);
-
-		pci_read_config_byte(device_dev, PCI_INTERRUPT_PIN,
-				     (unsigned char *)&lines);
-		device_sysdata = (struct sn_device_sysdata *)device_dev->sysdata;
-		device_vertex = device_sysdata->vhdl;
-		pci_provider = device_sysdata->pci_provider;
- 
-		if (!lines) {
-			continue;
-		}
-
-		irqpdaindr->curr = device_dev;
-		intr_handle = (pci_provider->intr_alloc)(device_vertex, NULL, lines, device_vertex);
-
-		if (intr_handle == NULL) {
-			printk("sn_pci_fixup:  pcibr_intr_alloc() failed\n");
-			continue;
-		}
-		irq = intr_handle->bi_irq;
-		irqpdaindr->device_dev[irq] = device_dev;
-		(pci_provider->intr_connect)(intr_handle, (intr_func_t)0, (intr_arg_t)0);
-		device_dev->irq = irq;
-		register_pcibr_intr(irq, (pcibr_intr_t)intr_handle);
-
-		for (idx = 0; idx < PCI_ROM_RESOURCE; idx++) {
-			int ibits = intr_handle->bi_ibits;
-			int i;
-
-			size = device_dev->resource[idx].end -
-				device_dev->resource[idx].start;
-			if (size == 0)
-				continue;
-
-			for (i=0; i<8; i++) {
-				if (ibits & (1 << i) ) {
-					sn_dma_flush_init(device_dev->resource[idx].start, 
-						device_dev->resource[idx].end,
-						idx,
-						i,
-						PCIBR_INFO_SLOT_GET_EXT(pcibr_info_get(device_sysdata->vhdl)));
-				}
-			}
-		}
-
 	}
 }
 
diff -Nru a/arch/ia64/sn/io/machvec/pci_dma.c b/arch/ia64/sn/io/machvec/pci_dma.c
--- a/arch/ia64/sn/io/machvec/pci_dma.c	Thu Feb  5 10:17:40 2004
+++ b/arch/ia64/sn/io/machvec/pci_dma.c	Thu Feb  5 10:17:40 2004
@@ -127,7 +127,7 @@
 	/*
 	 * Get hwgraph vertex for the device
 	 */
-	device_sysdata = (struct sn_device_sysdata *) hwdev->sysdata;
+	device_sysdata = SN_DEVICE_SYSDATA(hwdev);
 	vhdl = device_sysdata->vhdl;
 
 	/*
@@ -240,7 +240,7 @@
 	/*
 	 * Get the hwgraph vertex for the device
 	 */
-	device_sysdata = (struct sn_device_sysdata *) hwdev->sysdata;
+	device_sysdata = SN_DEVICE_SYSDATA(hwdev);
 	vhdl = device_sysdata->vhdl;
 
 	/*
@@ -367,7 +367,7 @@
 	/*
 	 * find vertex for the device
 	 */
-	device_sysdata = (struct sn_device_sysdata *)hwdev->sysdata;
+	device_sysdata = SN_DEVICE_SYSDATA(hwdev);
 	vhdl = device_sysdata->vhdl;
 
 	/*
diff -Nru a/arch/ia64/sn/io/sn2/pic.c b/arch/ia64/sn/io/sn2/pic.c
--- a/arch/ia64/sn/io/sn2/pic.c	Thu Feb  5 10:17:40 2004
+++ b/arch/ia64/sn/io/sn2/pic.c	Thu Feb  5 10:17:40 2004
@@ -90,10 +90,15 @@
     		peer_widget_info->w_efunc = 0;
     		peer_widget_info->w_einfo = 0;
 		peer_widget_info->w_name = kmalloc(strlen(peer_path) + 1, GFP_KERNEL);
+		if (!peer_widget_info->w_name) {
+			kfree(peer_widget_info);
+			return -ENOMEM;
+		}
 		strcpy(peer_widget_info->w_name, peer_path);
 
 		if (hwgraph_info_add_LBL(peer_conn_v, INFO_LBL_XWIDGET,
 			(arbitrary_info_t)peer_widget_info) != GRAPH_SUCCESS) {
+			kfree(peer_widget_info->w_name);
 				kfree(peer_widget_info);
 				return 0;
 		}
@@ -359,6 +364,9 @@
 
     s = dev_to_name(pcibr_vhdl, devnm, MAXDEVNAME);
     pcibr_soft->bs_name = kmalloc(strlen(s) + 1, GFP_KERNEL);
+    if (!pcibr_soft->bs_name)
+	    return -ENOMEM;
+
     strcpy(pcibr_soft->bs_name, s);
 
     pcibr_soft->bs_conn = xconn_vhdl;
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Thu Feb  5 10:17:40 2004
+++ b/include/asm-ia64/pci.h	Thu Feb  5 10:17:40 2004
@@ -96,6 +96,8 @@
 
 	unsigned int windows;
 	struct pci_window *window;
+
+	void *platform_data;
 };
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
diff -Nru a/include/asm-ia64/sn/pci/pci_bus_cvlink.h b/include/asm-ia64/sn/pci/pci_bus_cvlink.h
--- a/include/asm-ia64/sn/pci/pci_bus_cvlink.h	Thu Feb  5 10:17:40 2004
+++ b/include/asm-ia64/sn/pci/pci_bus_cvlink.h	Thu Feb  5 10:17:40 2004
@@ -31,22 +31,26 @@
 #define MAX_PCI_XWIDGET 256
 #define MAX_ATE_MAPS 1024
 
+#define SN_DEVICE_SYSDATA(dev) \
+	((struct sn_device_sysdata *) \
+	(((struct pci_controller *) ((dev)->sysdata))->platform_data))
+
 #define IS_PCI32G(dev)	((dev)->dma_mask >= 0xffffffff)
 #define IS_PCI32L(dev)	((dev)->dma_mask < 0xffffffff)
 
 #define PCIDEV_VERTEX(pci_dev) \
-	(((struct sn_device_sysdata *)((pci_dev)->sysdata))->vhdl)
-
-#define PCIBUS_VERTEX(pci_bus) \
-	(((struct sn_widget_sysdata *)((pci_bus)->sysdata))->vhdl)
+	((SN_DEVICE_SYSDATA(pci_dev))->vhdl)
 
 struct sn_widget_sysdata {
         vertex_hdl_t  vhdl;
 };
 
 struct sn_device_sysdata {
-        vertex_hdl_t  vhdl;
+        vertex_hdl_t		vhdl;
 	pciio_provider_t	*pci_provider;
+	pciio_intr_t		intr_handle;
+	struct sn_flush_device_list *dma_flush_list;
+        pciio_piomap_t		pio_map[PCI_ROM_RESOURCE];
 };
 
 struct ioports_to_tlbs_s {
