Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbULQVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbULQVBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbULQVBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:01:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32189 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262161AbULQUyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:54:20 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: davej@codemonkey.org.uk
Subject: [patch 2.6.10-rc3 2/4] agpgart: allow multiple backends to be initialized
Date: Fri, 17 Dec 2004 12:56:05 -0800
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412171256.05570.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new version reduces the number of changes required by users of the agpgart
such as drm to support the new api for multiple agp bridges. 
The first patch doesn't touch any platform specific files and all current platform
gart drivers will just work the same as they do now since the global 
agp_bridge is still supported as the default bridge.

Summary for the 4 patches.
[1/4] Allow multiple backends to be initialized for agpgart
[2/4] Run Lindent on generic.c
[3/4] Patch drm code to work with modified agpgart api.
[4/4] Patch framebuffer code to work with modified agpgart api.
-----------------------------------------------------------------------------
 generic.c |  317 ++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 187 insertions(+), 130 deletions(-)

# This is a BitKeeper generated diff -Nru style patch.
#
#   Run Lindent on generic.c
# 
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2004-12-17 11:17:31 -08:00
+++ b/drivers/char/agp/generic.c	2004-12-17 11:17:31 -08:00
@@ -61,8 +61,8 @@
 	if (key < MAXKEY)
 		clear_bit(key, agp_bridge->key_list);
 }
-EXPORT_SYMBOL(agp_free_key);
 
+EXPORT_SYMBOL(agp_free_key);
 
 static int agp_get_key(void)
 {
@@ -76,7 +76,6 @@
 	return -1;
 }
 
-
 struct agp_memory *agp_create_memory(int scratch_pages)
 {
 	struct agp_memory *new;
@@ -103,6 +102,7 @@
 	new->num_scratch_pages = scratch_pages;
 	return new;
 }
+
 EXPORT_SYMBOL(agp_create_memory);
 
 /**
@@ -129,13 +129,15 @@
 	}
 	if (curr->page_count != 0) {
 		for (i = 0; i < curr->page_count; i++) {
-			curr->bridge->driver->agp_destroy_page(phys_to_virt(curr->memory[i]));
+			curr->bridge->driver->
+			    agp_destroy_page(phys_to_virt(curr->memory[i]));
 		}
 	}
 	agp_free_key(curr->key);
 	vfree(curr->memory);
 	kfree(curr);
 }
+
 EXPORT_SYMBOL(agp_free_memory);
 
 #define ENTRIES_PER_PAGE		(PAGE_SIZE / sizeof(unsigned long))
@@ -151,7 +153,8 @@
  *
  *	It returns NULL whenever memory is unavailable.
  */
-struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge, size_t page_count, u32 type)
+struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge,
+				       size_t page_count, u32 type)
 {
 	int scratch_pages;
 	struct agp_memory *new;
@@ -160,7 +163,8 @@
 	if (!bridge)
 		return NULL;
 
-	if ((atomic_read(&bridge->current_memory_agp) + page_count) > bridge->max_memory_agp)
+	if ((atomic_read(&bridge->current_memory_agp) + page_count) >
+	    bridge->max_memory_agp)
 		return NULL;
 
 	if (type != 0) {
@@ -183,7 +187,7 @@
 			return NULL;
 		}
 		new->memory[i] =
-			bridge->driver->mask_memory(virt_to_phys(addr), type);
+		    bridge->driver->mask_memory(virt_to_phys(addr), type);
 		new->page_count++;
 	}
 
@@ -191,12 +195,11 @@
 
 	return new;
 }
-EXPORT_SYMBOL(agp_allocate_memory);
 
+EXPORT_SYMBOL(agp_allocate_memory);
 
 /* End - Generic routines for handling agp_memory structures */
 
-
 static int agp_return_size(void)
 {
 	int current_size;
@@ -225,13 +228,12 @@
 		break;
 	}
 
-	current_size -= (agp_memory_reserved / (1024*1024));
-	if (current_size <0)
+	current_size -= (agp_memory_reserved / (1024 * 1024));
+	if (current_size < 0)
 		current_size = 0;
 	return current_size;
 }
 
-
 int agp_num_entries(void)
 {
 	int num_entries;
@@ -260,13 +262,13 @@
 		break;
 	}
 
-	num_entries -= agp_memory_reserved>>PAGE_SHIFT;
-	if (num_entries<0)
+	num_entries -= agp_memory_reserved >> PAGE_SHIFT;
+	if (num_entries < 0)
 		num_entries = 0;
 	return num_entries;
 }
-EXPORT_SYMBOL_GPL(agp_num_entries);
 
+EXPORT_SYMBOL_GPL(agp_num_entries);
 
 /**
  *	agp_copy_info  -  copy bridge state information
@@ -298,12 +300,11 @@
 	info->page_mask = ~0UL;
 	return 0;
 }
-EXPORT_SYMBOL(agp_copy_info);
 
+EXPORT_SYMBOL(agp_copy_info);
 
 /* End - Routine to copy over information structure */
 
-
 /*
  * Routines for handling swapping of agp_memory into the GATT -
  * These routines take agp_memory and insert them into the GATT.
@@ -327,14 +328,15 @@
 		return -EINVAL;
 
 	if (curr->is_bound == TRUE) {
-		printk (KERN_INFO PFX "memory %p is already bound!\n", curr);
+		printk(KERN_INFO PFX "memory %p is already bound!\n", curr);
 		return -EINVAL;
 	}
 	if (curr->is_flushed == FALSE) {
 		curr->bridge->driver->cache_flush();
 		curr->is_flushed = TRUE;
 	}
-	ret_val = curr->bridge->driver->insert_memory(curr, pg_start, curr->type);
+	ret_val =
+	    curr->bridge->driver->insert_memory(curr, pg_start, curr->type);
 
 	if (ret_val != 0)
 		return ret_val;
@@ -343,8 +345,8 @@
 	curr->pg_start = pg_start;
 	return 0;
 }
-EXPORT_SYMBOL(agp_bind_memory);
 
+EXPORT_SYMBOL(agp_bind_memory);
 
 /**
  *	agp_unbind_memory  -  Removes an agp_memory structure from the GATT
@@ -362,11 +364,13 @@
 		return -EINVAL;
 
 	if (curr->is_bound != TRUE) {
-		printk (KERN_INFO PFX "memory %p was not bound!\n", curr);
+		printk(KERN_INFO PFX "memory %p was not bound!\n", curr);
 		return -EINVAL;
 	}
 
-	ret_val = curr->bridge->driver->remove_memory(curr, curr->pg_start, curr->type);
+	ret_val =
+	    curr->bridge->driver->remove_memory(curr, curr->pg_start,
+						curr->type);
 
 	if (ret_val != 0)
 		return ret_val;
@@ -375,26 +379,34 @@
 	curr->pg_start = 0;
 	return 0;
 }
+
 EXPORT_SYMBOL(agp_unbind_memory);
 
 /* End - Routines for handling swapping of agp_memory into the GATT */
 
-
 /* Generic Agp routines - Start */
-static void agp_v2_parse_one(u32 *mode, u32 *cmd, u32 *tmp)
+static void agp_v2_parse_one(u32 * mode, u32 * cmd, u32 * tmp)
 {
 	/* disable SBA if it's not supported */
-	if (!((*cmd & AGPSTAT_SBA) && (*tmp & AGPSTAT_SBA) && (*mode & AGPSTAT_SBA)))
+	if (!
+	    ((*cmd & AGPSTAT_SBA) && (*tmp & AGPSTAT_SBA)
+	     && (*mode & AGPSTAT_SBA)))
 		*cmd &= ~AGPSTAT_SBA;
 
 	/* Set speed */
-	if (!((*cmd & AGPSTAT2_4X) && (*tmp & AGPSTAT2_4X) && (*mode & AGPSTAT2_4X)))
+	if (!
+	    ((*cmd & AGPSTAT2_4X) && (*tmp & AGPSTAT2_4X)
+	     && (*mode & AGPSTAT2_4X)))
 		*cmd &= ~AGPSTAT2_4X;
 
-	if (!((*cmd & AGPSTAT2_2X) && (*tmp & AGPSTAT2_2X) && (*mode & AGPSTAT2_2X)))
+	if (!
+	    ((*cmd & AGPSTAT2_2X) && (*tmp & AGPSTAT2_2X)
+	     && (*mode & AGPSTAT2_2X)))
 		*cmd &= ~AGPSTAT2_2X;
 
-	if (!((*cmd & AGPSTAT2_1X) && (*tmp & AGPSTAT2_1X) && (*mode & AGPSTAT2_1X)))
+	if (!
+	    ((*cmd & AGPSTAT2_1X) && (*tmp & AGPSTAT2_1X)
+	     && (*mode & AGPSTAT2_1X)))
 		*cmd &= ~AGPSTAT2_1X;
 
 	/* Now we know what mode it should be, clear out the unwanted bits. */
@@ -413,19 +425,20 @@
  * cmd = PCI_AGP_STATUS from agp bridge.
  * tmp = PCI_AGP_STATUS from graphic card.
  */
-static void agp_v3_parse_one(u32 *mode, u32 *cmd, u32 *tmp)
+static void agp_v3_parse_one(u32 * mode, u32 * cmd, u32 * tmp)
 {
-	u32 origcmd=*cmd, origtmp=*tmp;
+	u32 origcmd = *cmd, origtmp = *tmp;
 
 	/* ARQSZ - Set the value to the maximum one.
 	 * Don't allow the mode register to override values. */
 	*cmd = ((*cmd & ~AGPSTAT_ARQSZ) |
-		max_t(u32,(*cmd & AGPSTAT_ARQSZ),(*tmp & AGPSTAT_ARQSZ)));
+		max_t(u32, (*cmd & AGPSTAT_ARQSZ), (*tmp & AGPSTAT_ARQSZ)));
 
 	/* Calibration cycle.
 	 * Don't allow the mode register to override values. */
 	*cmd = ((*cmd & ~AGPSTAT_CAL_MASK) |
-		min_t(u32,(*cmd & AGPSTAT_CAL_MASK),(*tmp & AGPSTAT_CAL_MASK)));
+		min_t(u32, (*cmd & AGPSTAT_CAL_MASK),
+		      (*tmp & AGPSTAT_CAL_MASK)));
 
 	/* SBA *must* be supported for AGP v3 */
 	*cmd |= AGPSTAT_SBA;
@@ -442,8 +455,9 @@
 		 * AGP2.x 4x -> AGP3.0 4x.
 		 */
 		if (*mode & AGPSTAT2_4X) {
-			printk (KERN_INFO PFX "%s passes broken AGP3 flags (%x). Fixed.\n",
-						current->comm, *mode);
+			printk(KERN_INFO PFX
+			       "%s passes broken AGP3 flags (%x). Fixed.\n",
+			       current->comm, *mode);
 			*mode &= ~AGPSTAT2_4X;
 			*mode |= AGPSTAT3_4X;
 		}
@@ -453,8 +467,9 @@
 		 * but have been passed an AGP 2.x mode.
 		 * Convert AGP 1x,2x,4x -> AGP 3.0 4x.
 		 */
-		printk (KERN_INFO PFX "%s passes broken AGP2 flags (%x) in AGP3 mode. Fixed.\n",
-					current->comm, *mode);
+		printk(KERN_INFO PFX
+		       "%s passes broken AGP2 flags (%x) in AGP3 mode. Fixed.\n",
+		       current->comm, *mode);
 		*mode &= ~(AGPSTAT2_4X | AGPSTAT2_2X | AGPSTAT2_1X);
 		*mode |= AGPSTAT3_4X;
 	}
@@ -463,16 +478,19 @@
 		if (!(*cmd & AGPSTAT3_8X)) {
 			*cmd &= ~(AGPSTAT3_8X | AGPSTAT3_RSVD);
 			*cmd |= AGPSTAT3_4X;
-			printk ("%s requested AGPx8 but bridge not capable.\n", current->comm);
+			printk("%s requested AGPx8 but bridge not capable.\n",
+			       current->comm);
 			return;
 		}
 		if (!(*tmp & AGPSTAT3_8X)) {
 			*cmd &= ~(AGPSTAT3_8X | AGPSTAT3_RSVD);
 			*cmd |= AGPSTAT3_4X;
-			printk ("%s requested AGPx8 but graphic card not capable.\n", current->comm);
+			printk
+			    ("%s requested AGPx8 but graphic card not capable.\n",
+			     current->comm);
 			return;
 		}
-		/* All set, bridge & device can do AGP x8*/
+		/* All set, bridge & device can do AGP x8 */
 		*cmd &= ~(AGPSTAT3_4X | AGPSTAT3_RSVD);
 		return;
 
@@ -487,13 +505,16 @@
 		if ((*cmd & AGPSTAT3_4X) && (*tmp & AGPSTAT3_4X))
 			*cmd |= AGPSTAT3_4X;
 		else {
-			printk (KERN_INFO PFX "Badness. Don't know which AGP mode to set. "
-							"[cmd:%x tmp:%x fell back to:- cmd:%x tmp:%x]\n",
-							origcmd, origtmp, *cmd, *tmp);
+			printk(KERN_INFO PFX
+			       "Badness. Don't know which AGP mode to set. "
+			       "[cmd:%x tmp:%x fell back to:- cmd:%x tmp:%x]\n",
+			       origcmd, origtmp, *cmd, *tmp);
 			if (!(*cmd & AGPSTAT3_4X))
-				printk (KERN_INFO PFX "Bridge couldn't do AGP x4.\n");
+				printk(KERN_INFO PFX
+				       "Bridge couldn't do AGP x4.\n");
 			if (!(*tmp & AGPSTAT3_4X))
-				printk (KERN_INFO PFX "Graphic card couldn't do AGP x4.\n");
+				printk(KERN_INFO PFX
+				       "Graphic card couldn't do AGP x4.\n");
 		}
 	}
 }
@@ -507,7 +528,8 @@
 	u32 tmp;
 	u32 agp3;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	while ((device =
+		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
 		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!cap_ptr)
 			continue;
@@ -518,19 +540,22 @@
 		 * Ok, here we have a AGP device. Disable impossible
 		 * settings, and adjust the readqueue to the minimum.
 		 */
-		pci_read_config_dword(device, cap_ptr+PCI_AGP_STATUS, &tmp);
+		pci_read_config_dword(device, cap_ptr + PCI_AGP_STATUS, &tmp);
 
 		/* adjust RQ depth */
 		cmd = ((cmd & ~AGPSTAT_RQ_DEPTH) |
-		     min_t(u32, (mode & AGPSTAT_RQ_DEPTH),
-			 min_t(u32, (cmd & AGPSTAT_RQ_DEPTH), (tmp & AGPSTAT_RQ_DEPTH))));
+		       min_t(u32, (mode & AGPSTAT_RQ_DEPTH),
+			     min_t(u32, (cmd & AGPSTAT_RQ_DEPTH),
+				   (tmp & AGPSTAT_RQ_DEPTH))));
 
 		/* disable FW if it's not supported */
-		if (!((cmd & AGPSTAT_FW) && (tmp & AGPSTAT_FW) && (mode & AGPSTAT_FW)))
+		if (!
+		    ((cmd & AGPSTAT_FW) && (tmp & AGPSTAT_FW)
+		     && (mode & AGPSTAT_FW)))
 			cmd &= ~AGPSTAT_FW;
 
 		/* Check to see if we are operating in 3.0 mode */
-		pci_read_config_dword(device, cap_ptr+AGPSTAT, &agp3);
+		pci_read_config_dword(device, cap_ptr + AGPSTAT, &agp3);
 		if (agp3 & AGPSTAT_MODE_3_0) {
 			agp_v3_parse_one(&mode, &cmd, &tmp);
 		} else {
@@ -539,8 +564,8 @@
 	}
 	return cmd;
 }
-EXPORT_SYMBOL(agp_collect_device_status);
 
+EXPORT_SYMBOL(agp_collect_device_status);
 
 void agp_device_command(u32 command, int agp_v3)
 {
@@ -551,18 +576,20 @@
 	if (agp_v3)
 		mode *= 4;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	while ((device =
+		pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
 		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!agp)
 			continue;
 
-		printk(KERN_INFO PFX "Putting AGP V%d device at %s into %dx mode\n",
-				agp_v3 ? 3 : 2, pci_name(device), mode);
+		printk(KERN_INFO PFX
+		       "Putting AGP V%d device at %s into %dx mode\n",
+		       agp_v3 ? 3 : 2, pci_name(device), mode);
 		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
 	}
 }
-EXPORT_SYMBOL(agp_device_command);
 
+EXPORT_SYMBOL(agp_device_command);
 
 void get_agp_version(struct agp_bridge_data *bridge)
 {
@@ -576,8 +603,8 @@
 	agp_bridge->major_version = (ncapid >> AGP_MAJOR_VERSION_SHIFT) & 0xf;
 	agp_bridge->minor_version = (ncapid >> AGP_MINOR_VERSION_SHIFT) & 0xf;
 }
-EXPORT_SYMBOL(get_agp_version);
 
+EXPORT_SYMBOL(get_agp_version);
 
 void agp_generic_enable(u32 mode)
 {
@@ -587,20 +614,19 @@
 	get_agp_version(agp_bridge);
 
 	printk(KERN_INFO PFX "Found an AGP %d.%d compliant device at %s.\n",
-				agp_bridge->major_version,
-				agp_bridge->minor_version,
-				agp_bridge->dev->slot_name);
+	       agp_bridge->major_version,
+	       agp_bridge->minor_version, agp_bridge->dev->slot_name);
 
 	pci_read_config_dword(agp_bridge->dev,
-		      agp_bridge->capndx + PCI_AGP_STATUS, &command);
+			      agp_bridge->capndx + PCI_AGP_STATUS, &command);
 
 	command = agp_collect_device_status(mode, command);
 	command |= AGPSTAT_AGP_ENABLE;
 
 	/* Do AGP version specific frobbing. */
-	if(agp_bridge->major_version >= 3) {
+	if (agp_bridge->major_version >= 3) {
 		pci_read_config_dword(agp_bridge->dev,
-			agp_bridge->capndx+AGPSTAT, &agp3);
+				      agp_bridge->capndx + AGPSTAT, &agp3);
 
 		/* Check to see if we are operating in 3.0 mode */
 		if (agp3 & AGPSTAT_MODE_3_0) {
@@ -610,22 +636,26 @@
 			agp_device_command(command, TRUE);
 			return;
 		} else {
-		    /* Disable calibration cycle in RX91<1> when not in AGP3.0 mode of operation.*/
-		    command &= ~(7<<10) ;
-		    pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &temp);
-		    temp |= (1<<9);
-		    pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, temp);
+			/* Disable calibration cycle in RX91<1> when not in AGP3.0 mode of operation. */
+			command &= ~(7 << 10);
+			pci_read_config_dword(agp_bridge->dev,
+					      agp_bridge->capndx + AGPCTRL,
+					      &temp);
+			temp |= (1 << 9);
+			pci_write_config_dword(agp_bridge->dev,
+					       agp_bridge->capndx + AGPCTRL,
+					       temp);
 
-		    printk (KERN_INFO PFX "Device is in legacy mode,"
-				" falling back to 2.x\n");
+			printk(KERN_INFO PFX "Device is in legacy mode,"
+			       " falling back to 2.x\n");
 		}
 	}
 
 	/* AGP v<3 */
 	agp_device_command(command, FALSE);
 }
-EXPORT_SYMBOL(agp_generic_enable);
 
+EXPORT_SYMBOL(agp_generic_enable);
 
 int agp_generic_create_gatt_table(void)
 {
@@ -652,10 +682,8 @@
 			switch (agp_bridge->driver->size_type) {
 			case U8_APER_SIZE:
 				size = A_SIZE_8(temp)->size;
-				page_order =
-				    A_SIZE_8(temp)->page_order;
-				num_entries =
-				    A_SIZE_8(temp)->num_entries;
+				page_order = A_SIZE_8(temp)->page_order;
+				num_entries = A_SIZE_8(temp)->num_entries;
 				break;
 			case U16_APER_SIZE:
 				size = A_SIZE_16(temp)->size;
@@ -675,20 +703,23 @@
 				break;
 			}
 
-			table = (char *) __get_free_pages(GFP_KERNEL,
-							  page_order);
+			table = (char *)__get_free_pages(GFP_KERNEL,
+							 page_order);
 
 			if (table == NULL) {
 				i++;
 				switch (agp_bridge->driver->size_type) {
 				case U8_APER_SIZE:
-					agp_bridge->current_size = A_IDX8(agp_bridge);
+					agp_bridge->current_size =
+					    A_IDX8(agp_bridge);
 					break;
 				case U16_APER_SIZE:
-					agp_bridge->current_size = A_IDX16(agp_bridge);
+					agp_bridge->current_size =
+					    A_IDX16(agp_bridge);
 					break;
 				case U32_APER_SIZE:
-					agp_bridge->current_size = A_IDX32(agp_bridge);
+					agp_bridge->current_size =
+					    A_IDX32(agp_bridge);
 					break;
 					/* This case will never really happen. */
 				case FIXED_APER_SIZE:
@@ -702,12 +733,14 @@
 			} else {
 				agp_bridge->aperture_size_idx = i;
 			}
-		} while (!table && (i < agp_bridge->driver->num_aperture_sizes));
+		} while (!table
+			 && (i < agp_bridge->driver->num_aperture_sizes));
 	} else {
-		size = ((struct aper_size_info_fixed *) temp)->size;
-		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
-		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
-		table = (char *) __get_free_pages(GFP_KERNEL, page_order);
+		size = ((struct aper_size_info_fixed *)temp)->size;
+		page_order = ((struct aper_size_info_fixed *)temp)->page_order;
+		num_entries =
+		    ((struct aper_size_info_fixed *)temp)->num_entries;
+		table = (char *)__get_free_pages(GFP_KERNEL, page_order);
 	}
 
 	if (table == NULL)
@@ -715,7 +748,8 @@
 
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table); page <= virt_to_page(table_end);
+	     page++)
 		SetPageReserved(page);
 
 	agp_bridge->gatt_table_real = (u32 *) table;
@@ -723,14 +757,16 @@
 
 	agp_bridge->driver->cache_flush();
 	agp_bridge->gatt_table = ioremap_nocache(virt_to_phys(table),
-					(PAGE_SIZE * (1 << page_order)));
+						 (PAGE_SIZE *
+						  (1 << page_order)));
 	agp_bridge->driver->cache_flush();
 
 	if (agp_bridge->gatt_table == NULL) {
-		for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+		for (page = virt_to_page(table);
+		     page <= virt_to_page(table_end); page++)
 			ClearPageReserved(page);
 
-		free_pages((unsigned long) table, page_order);
+		free_pages((unsigned long)table, page_order);
 
 		return -ENOMEM;
 	}
@@ -738,10 +774,11 @@
 
 	/* AK: bogus, should encode addresses > 4GB */
 	for (i = 0; i < num_entries; i++)
-		writel(agp_bridge->scratch_page, agp_bridge->gatt_table+i);
+		writel(agp_bridge->scratch_page, agp_bridge->gatt_table + i);
 
 	return 0;
 }
+
 EXPORT_SYMBOL(agp_generic_create_gatt_table);
 
 int agp_generic_free_gatt_table(void)
@@ -780,13 +817,14 @@
 	 * from the table. */
 
 	iounmap(agp_bridge->gatt_table);
-	table = (char *) agp_bridge->gatt_table_real;
+	table = (char *)agp_bridge->gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table); page <= virt_to_page(table_end);
+	     page++)
 		ClearPageReserved(page);
 
-	free_pages((unsigned long) agp_bridge->gatt_table_real, page_order);
+	free_pages((unsigned long)agp_bridge->gatt_table_real, page_order);
 
 	agp_gatt_table = NULL;
 	agp_bridge->gatt_table = NULL;
@@ -795,10 +833,10 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(agp_generic_free_gatt_table);
 
+EXPORT_SYMBOL(agp_generic_free_gatt_table);
 
-int agp_generic_insert_memory(struct agp_memory * mem, off_t pg_start, int type)
+int agp_generic_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	int num_entries;
 	size_t i;
@@ -829,8 +867,9 @@
 		break;
 	}
 
-	num_entries -= agp_memory_reserved/PAGE_SIZE;
-	if (num_entries < 0) num_entries = 0;
+	num_entries -= agp_memory_reserved / PAGE_SIZE;
+	if (num_entries < 0)
+		num_entries = 0;
 
 	if (type != 0 || mem->type != 0) {
 		/* The generic routines know nothing of memory types */
@@ -844,7 +883,7 @@
 	j = pg_start;
 
 	while (j < (pg_start + mem->page_count)) {
-		if (!PGE_EMPTY(agp_bridge, readl(agp_bridge->gatt_table+j)))
+		if (!PGE_EMPTY(agp_bridge, readl(agp_bridge->gatt_table + j)))
 			return -EBUSY;
 		j++;
 	}
@@ -855,13 +894,15 @@
 	}
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++)
-		writel(agp_bridge->driver->mask_memory(mem->memory[i], mem->type), agp_bridge->gatt_table+j);
+		writel(agp_bridge->driver->
+		       mask_memory(mem->memory[i], mem->type),
+		       agp_bridge->gatt_table + j);
 
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
 }
-EXPORT_SYMBOL(agp_generic_insert_memory);
 
+EXPORT_SYMBOL(agp_generic_insert_memory);
 
 int agp_generic_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
@@ -874,20 +915,20 @@
 
 	/* AK: bogus, should encode addresses > 4GB */
 	for (i = pg_start; i < (mem->page_count + pg_start); i++)
-		writel(agp_bridge->scratch_page, agp_bridge->gatt_table+i);
+		writel(agp_bridge->scratch_page, agp_bridge->gatt_table + i);
 
 	agp_bridge->driver->tlb_flush(mem);
 	return 0;
 }
-EXPORT_SYMBOL(agp_generic_remove_memory);
 
+EXPORT_SYMBOL(agp_generic_remove_memory);
 
 struct agp_memory *agp_generic_alloc_by_type(size_t page_count, int type)
 {
 	return NULL;
 }
-EXPORT_SYMBOL(agp_generic_alloc_by_type);
 
+EXPORT_SYMBOL(agp_generic_alloc_by_type);
 
 void agp_generic_free_by_type(struct agp_memory *curr)
 {
@@ -897,8 +938,8 @@
 	agp_free_key(curr->key);
 	kfree(curr);
 }
-EXPORT_SYMBOL(agp_generic_free_by_type);
 
+EXPORT_SYMBOL(agp_generic_free_by_type);
 
 /*
  * Basic Page Allocation Routines -
@@ -909,7 +950,7 @@
 
 void *agp_generic_alloc_page(void)
 {
-	struct page * page;
+	struct page *page;
 
 	page = alloc_page(GFP_KERNEL);
 	if (page == NULL)
@@ -922,8 +963,8 @@
 	atomic_inc(&agp_bridge->current_memory_agp);
 	return page_address(page);
 }
-EXPORT_SYMBOL(agp_generic_alloc_page);
 
+EXPORT_SYMBOL(agp_generic_alloc_page);
 
 void agp_generic_destroy_page(void *addr)
 {
@@ -939,11 +980,11 @@
 	free_page((unsigned long)addr);
 	atomic_dec(&agp_bridge->current_memory_agp);
 }
+
 EXPORT_SYMBOL(agp_generic_destroy_page);
 
 /* End Basic Page Allocation Routines */
 
-
 /**
  * agp_enable  -  initialise the agp point-to-point connection.
  *
@@ -955,6 +996,7 @@
 		return;
 	bridge->driver->agp_enable(mode);
 }
+
 EXPORT_SYMBOL(agp_enable);
 
 /* When we remove the global variable agp_bridge from all drivers 
@@ -985,6 +1027,7 @@
 	flush_agp_cache();
 #endif
 }
+
 EXPORT_SYMBOL(global_cache_flush);
 
 unsigned long agp_generic_mask_memory(unsigned long addr, int type)
@@ -995,6 +1038,7 @@
 	else
 		return addr;
 }
+
 EXPORT_SYMBOL(agp_generic_mask_memory);
 
 /*
@@ -1009,13 +1053,14 @@
 	int i;
 	struct aper_size_info_16 *values;
 
-	pci_read_config_word(agp_bridge->dev, agp_bridge->capndx+AGPAPSIZE, &temp_size);
+	pci_read_config_word(agp_bridge->dev, agp_bridge->capndx + AGPAPSIZE,
+			     &temp_size);
 	values = A_SIZE_16(agp_bridge->driver->aperture_sizes);
 
 	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {
 		if (temp_size == values[i].size_value) {
 			agp_bridge->previous_size =
-				agp_bridge->current_size = (void *) (values + i);
+			    agp_bridge->current_size = (void *)(values + i);
 
 			agp_bridge->aperture_size_idx = i;
 			return values[i].size;
@@ -1023,15 +1068,20 @@
 	}
 	return 0;
 }
+
 EXPORT_SYMBOL(agp3_generic_fetch_size);
 
 void agp3_generic_tlbflush(struct agp_memory *mem)
 {
 	u32 ctrl;
-	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &ctrl);
-	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl & ~AGPCTRL_GTLBEN);
-	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl);
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			      &ctrl);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			       ctrl & ~AGPCTRL_GTLBEN);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			       ctrl);
 }
+
 EXPORT_SYMBOL(agp3_generic_tlbflush);
 
 int agp3_generic_configure(void)
@@ -1045,37 +1095,44 @@
 	agp_bridge->gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
 
 	/* set aperture size */
-	pci_write_config_word(agp_bridge->dev, agp_bridge->capndx+AGPAPSIZE, current_size->size_value);
+	pci_write_config_word(agp_bridge->dev, agp_bridge->capndx + AGPAPSIZE,
+			      current_size->size_value);
 	/* set gart pointer */
-	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPGARTLO, agp_bridge->gatt_bus_addr);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPGARTLO,
+			       agp_bridge->gatt_bus_addr);
 	/* enable aperture and GTLB */
-	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &temp);
-	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, temp | AGPCTRL_APERENB | AGPCTRL_GTLBEN);
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			      &temp);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			       temp | AGPCTRL_APERENB | AGPCTRL_GTLBEN);
 	return 0;
 }
+
 EXPORT_SYMBOL(agp3_generic_configure);
 
 void agp3_generic_cleanup(void)
 {
 	u32 ctrl;
-	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, &ctrl);
-	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx+AGPCTRL, ctrl & ~AGPCTRL_APERENB);
+	pci_read_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			      &ctrl);
+	pci_write_config_dword(agp_bridge->dev, agp_bridge->capndx + AGPCTRL,
+			       ctrl & ~AGPCTRL_APERENB);
 }
+
 EXPORT_SYMBOL(agp3_generic_cleanup);
 
-struct aper_size_info_16 agp3_generic_sizes[AGP_GENERIC_SIZES_ENTRIES] =
-{
-	{4096, 1048576, 10,0x000},
-	{2048,  524288, 9, 0x800},
-	{1024,  262144, 8, 0xc00},
-	{ 512,  131072, 7, 0xe00},
-	{ 256,   65536, 6, 0xf00},
-	{ 128,   32768, 5, 0xf20},
-	{  64,   16384, 4, 0xf30},
-	{  32,    8192, 3, 0xf38},
-	{  16,    4096, 2, 0xf3c},
-	{   8,    2048, 1, 0xf3e},
-	{   4,    1024, 0, 0xf3f}
+struct aper_size_info_16 agp3_generic_sizes[AGP_GENERIC_SIZES_ENTRIES] = {
+	{4096, 1048576, 10, 0x000},
+	{2048, 524288, 9, 0x800},
+	{1024, 262144, 8, 0xc00},
+	{512, 131072, 7, 0xe00},
+	{256, 65536, 6, 0xf00},
+	{128, 32768, 5, 0xf20},
+	{64, 16384, 4, 0xf30},
+	{32, 8192, 3, 0xf38},
+	{16, 4096, 2, 0xf3c},
+	{8, 2048, 1, 0xf3e},
+	{4, 1024, 0, 0xf3f}
 };
-EXPORT_SYMBOL(agp3_generic_sizes);
 
+EXPORT_SYMBOL(agp3_generic_sizes);
