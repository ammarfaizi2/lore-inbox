Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbVIITey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbVIITey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbVIITeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:34:23 -0400
Received: from magic.adaptec.com ([216.52.22.17]:11973 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030342AbVIITeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:34:14 -0400
Message-ID: <4321E3AF.10109@adaptec.com>
Date: Fri, 09 Sep 2005 15:34:07 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 9/20] aic94xx: aic94xx_init.c Driver initialization
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:34:13.0029 (UTC) FILETIME=[7518D550:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx_init.c linux-2.6.13/drivers/scsi/aic94xx/aic94xx_init.c
--- linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx_init.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/aic94xx_init.c	2005-09-09 11:21:23.000000000 -0400
@@ -0,0 +1,785 @@
+/*
+ * Aic94xx SAS/SATA driver initialization.
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This file is part of the aic94xx driver.
+ *
+ * The aic94xx driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ * The aic94xx driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the aic94xx driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/aic94xx/aic94xx_init.c#93 $
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <scsi/scsi_host.h>
+
+#include "aic94xx.h"
+#include "aic94xx_reg.h"
+#include "aic94xx_hwi.h"
+#include "aic94xx_seq.h"
+
+/* The format is "version.release.patchlevel" */
+#define ASD_DRIVER_VERSION "1.0.0"
+
+static int attach_HostRAID = 0;
+module_param_named(attach_HostRAID, attach_HostRAID, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(attach_HostRAID, "\n"
+	"\tEnable(1) or disable(0) attaching to HostRAID enabled host tadapters.\n"
+	"\tDefault: 0");
+
+static int use_msi = 0;
+module_param_named(use_msi, use_msi, int, S_IRUGO);
+MODULE_PARM_DESC(use_msi, "\n"
+	"\tEnable(1) or disable(0) using PCI MSI.\n"
+	"\tDefault: 0");
+
+static int lldd_max_execute_num = 0;
+module_param_named(collector, lldd_max_execute_num, int, S_IRUGO);
+MODULE_PARM_DESC(collector, "\n"
+	"\tIf greater than one, tells the SAS Layer to run in Task Collector\n"
+	"\tMode.  If 1 or 0, tells the SAS Layer to run in Direct Mode.\n"
+	"\tThe aic94xx SAS LLDD supports both modes.\n"
+	"\tDefault: 0 (Direct Mode).\n");
+
+char sas_addr_str[2*SAS_ADDR_SIZE + 1] = "";
+
+static int __devinit asd_map_memio(struct asd_ha_struct *asd_ha)
+{
+	int err, i;
+	struct asd_ha_addrspace *io_handle;
+
+	asd_ha->iospace = 0;
+	for (i = 0; i < 3; i += 2) {
+		io_handle = &asd_ha->io_handle[i==0?0:1];
+		io_handle->start = pci_resource_start(asd_ha->pcidev, i);
+		io_handle->len   = pci_resource_len(asd_ha->pcidev, i);
+		io_handle->flags = pci_resource_flags(asd_ha->pcidev, i);
+		err = -ENODEV;
+		if (!io_handle->start || !io_handle->len) {
+			asd_printk("MBAR%d start or length for %s is 0.\n",
+				   i==0?0:1, pci_name(asd_ha->pcidev));
+			goto Err;
+		}
+		err = pci_request_region(asd_ha->pcidev, i, ASD_DRIVER_NAME);
+		if (err) {
+			asd_printk("couldn't reserve memory region for %s\n",
+				   pci_name(asd_ha->pcidev));
+			goto Err;
+		}
+		if (io_handle->flags & IORESOURCE_CACHEABLE)
+			io_handle->addr = ioremap(io_handle->start,
+						  io_handle->len);
+		else
+			io_handle->addr = ioremap_nocache(io_handle->start,
+							  io_handle->len);
+		if (!io_handle->addr) {
+			asd_printk("couldn't map MBAR%d of %s\n", i==0?0:1,
+				   pci_name(asd_ha->pcidev));
+			goto Err_unreq;
+		}
+	}
+
+	return 0;
+Err_unreq:
+	pci_release_region(asd_ha->pcidev, i);
+Err:
+	if (i > 0) {
+		io_handle = &asd_ha->io_handle[0];
+		iounmap(io_handle->addr);
+		pci_release_region(asd_ha->pcidev, 0);
+	}
+	return err;
+}
+
+static void __devexit asd_unmap_memio(struct asd_ha_struct *asd_ha)
+{
+	struct asd_ha_addrspace *io_handle;
+
+	io_handle = &asd_ha->io_handle[1];
+	iounmap(io_handle->addr);
+	pci_release_region(asd_ha->pcidev, 2);
+	
+	io_handle = &asd_ha->io_handle[0];
+	iounmap(io_handle->addr);
+	pci_release_region(asd_ha->pcidev, 0);
+}
+
+static int __devinit asd_map_ioport(struct asd_ha_struct *asd_ha)
+{
+	int i = PCI_IOBAR_OFFSET, err;
+	struct asd_ha_addrspace *io_handle = &asd_ha->io_handle[0];
+
+	asd_ha->iospace = 1;
+	io_handle->start = pci_resource_start(asd_ha->pcidev, i);
+	io_handle->len   = pci_resource_len(asd_ha->pcidev, i);
+	io_handle->flags = pci_resource_flags(asd_ha->pcidev, i);
+	io_handle->addr  = (void __iomem *) io_handle->start;
+	if (!io_handle->start || !io_handle->len) {
+		asd_printk("couldn't get IO ports for %s\n",
+			   pci_name(asd_ha->pcidev));
+		return -ENODEV;
+	}
+	err = pci_request_region(asd_ha->pcidev, i, ASD_DRIVER_NAME);
+	if (err) {
+		asd_printk("couldn't reserve io space for %s\n",
+			   pci_name(asd_ha->pcidev));
+	}
+	
+	return err;
+}
+
+static void __devexit asd_unmap_ioport(struct asd_ha_struct *asd_ha)
+{
+	pci_release_region(asd_ha->pcidev, PCI_IOBAR_OFFSET);
+}
+
+static int __devinit asd_map_ha(struct asd_ha_struct *asd_ha)
+{
+	int err;
+	u16 cmd_reg;
+
+	err = pci_read_config_word(asd_ha->pcidev, PCI_COMMAND, &cmd_reg);
+	if (err) {
+		asd_printk("couldn't read command register of %s\n",
+			   pci_name(asd_ha->pcidev));
+		goto Err;
+	}
+
+	err = -ENODEV;
+	if (cmd_reg & PCI_COMMAND_MEMORY) {
+		if ((err = asd_map_memio(asd_ha)))
+			goto Err;
+	} else if (cmd_reg & PCI_COMMAND_IO) {
+		if ((err = asd_map_ioport(asd_ha)))
+			goto Err;
+		asd_printk("%s ioport mapped -- upgrade your hardware\n",
+			   pci_name(asd_ha->pcidev));
+	} else {
+		asd_printk("no proper device access to %s\n",
+			   pci_name(asd_ha->pcidev));
+		goto Err;
+	}
+
+	return 0;
+Err:
+	return err;
+}
+
+static void __devexit asd_unmap_ha(struct asd_ha_struct *asd_ha)
+{
+	if (asd_ha->iospace)
+		asd_unmap_ioport(asd_ha);
+	else
+		asd_unmap_memio(asd_ha);
+}
+
+static const char *asd_dev_rev[30] = {
+	[0] = "A0",
+	[1] = "A1",
+	[8] = "B0",
+};
+
+static int __devinit asd_common_setup(struct asd_ha_struct *asd_ha)
+{
+	int err, i;
+	
+	err = pci_read_config_byte(asd_ha->pcidev, PCI_REVISION_ID,
+				   &asd_ha->revision_id);
+	if (err) {
+		asd_printk("couldn't read REVISION ID register of %s\n",
+			   pci_name(asd_ha->pcidev));
+		goto Err;
+	}
+	err = -ENODEV;
+	if (asd_ha->revision_id < AIC9410_DEV_REV_B0) {
+		asd_printk("%s is revision %s (%X), which is not supported\n",
+			   pci_name(asd_ha->pcidev),
+			   asd_dev_rev[asd_ha->revision_id],
+			   asd_ha->revision_id);
+		goto Err;
+	}
+	/* Provide some sane default values. */
+	asd_ha->hw_prof.max_scbs = 512;
+	asd_ha->hw_prof.max_ddbs = 128;
+	asd_ha->hw_prof.num_phys = ASD_MAX_PHYS;
+	/* All phys are enabled, by default. */
+	asd_ha->hw_prof.enabled_phys = 0xFF;
+	for (i = 0; i < ASD_MAX_PHYS; i++) {
+		asd_ha->hw_prof.phy_desc[i].max_sas_lrate = PHY_LINKRATE_3;
+		asd_ha->hw_prof.phy_desc[i].min_sas_lrate = PHY_LINKRATE_1_5;
+		asd_ha->hw_prof.phy_desc[i].max_sata_lrate= PHY_LINKRATE_1_5;
+		asd_ha->hw_prof.phy_desc[i].min_sata_lrate= PHY_LINKRATE_1_5;
+	}
+		
+	return 0;
+Err:
+	return err;
+}
+
+static int __devinit asd_aic9410_setup(struct asd_ha_struct *asd_ha)
+{
+	int err = asd_common_setup(asd_ha);
+
+	if (err)
+		return err;
+
+	asd_ha->hw_prof.addr_range = 8;
+	asd_ha->hw_prof.port_name_base = 0;
+	asd_ha->hw_prof.dev_name_base = 8;
+	asd_ha->hw_prof.sata_name_base = 16;
+	
+	return 0;
+}
+
+static int __devinit asd_aic9405_setup(struct asd_ha_struct *asd_ha)
+{
+	int err = asd_common_setup(asd_ha);
+
+	if (err)
+		return err;
+
+	asd_ha->hw_prof.addr_range = 4;
+	asd_ha->hw_prof.port_name_base = 0;
+	asd_ha->hw_prof.dev_name_base = 4;
+	asd_ha->hw_prof.sata_name_base = 8;
+	
+	return 0;
+}
+
+static ssize_t asd_show_dev_rev(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			asd_dev_rev[asd_ha->revision_id]);
+}
+static DEVICE_ATTR(revision, S_IRUGO, asd_show_dev_rev, NULL);
+
+static ssize_t asd_show_dev_bios_build(struct device *dev,
+				       struct device_attribute *attr,char *buf)
+{
+	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", asd_ha->hw_prof.bios.bld);
+}
+static DEVICE_ATTR(bios_build, S_IRUGO, asd_show_dev_bios_build, NULL);
+
+static ssize_t asd_show_dev_pcba_sn(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", asd_ha->hw_prof.pcba_sn);
+}
+static DEVICE_ATTR(pcba_sn, S_IRUGO, asd_show_dev_pcba_sn, NULL);
+
+static void asd_create_dev_attrs(struct asd_ha_struct *asd_ha)
+{
+	device_create_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	device_create_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
+	device_create_file(&asd_ha->pcidev->dev, &dev_attr_pcba_sn);
+}
+
+static void asd_remove_dev_attrs(struct asd_ha_struct *asd_ha)
+{
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_pcba_sn);
+}
+
+/* The first entry, 0, is used for dynamic ids, the rest for devices
+ * we know about.
+ */
+static struct asd_pcidev_struct {
+	const char * name;
+	int (*setup)(struct asd_ha_struct *asd_ha);
+} asd_pcidev_data[] = {
+	/* Id 0 is used for dynamic ids. */
+	{ .name  = "Adaptec AIC-94xx SAS/SATA Host Adapter",
+	  .setup = asd_aic9410_setup
+	},
+	{ .name  = "Adaptec AIC-9410W SAS/SATA Host Adapter",
+	  .setup = asd_aic9410_setup
+	},
+	{ .name  = "Adaptec AIC-9405W SAS/SATA Host Adapter",
+	  .setup = asd_aic9405_setup
+	},
+};
+
+static inline int asd_create_ha_caches(struct asd_ha_struct *asd_ha)
+{
+	asd_ha->scb_pool = dma_pool_create(ASD_DRIVER_NAME "_scb_pool",
+					   &asd_ha->pcidev->dev,
+					   sizeof(struct scb),
+					   8, 0);
+	if (!asd_ha->scb_pool) {
+		asd_printk("couldn't create scb pool\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * asd_free_edbs -- free empty data buffers
+ * asd_ha: pointer to host adapter structure
+ */
+static inline void asd_free_edbs(struct asd_ha_struct *asd_ha)
+{
+	struct asd_seq_data *seq = &asd_ha->seq;
+	int i;
+
+	for (i = 0; i < seq->num_edbs; i++)
+		asd_free_coherent(asd_ha, seq->edb_arr[i]);
+	kfree(seq->edb_arr);
+	seq->edb_arr = NULL;
+}
+
+static inline void asd_free_escbs(struct asd_ha_struct *asd_ha)
+{
+	struct asd_seq_data *seq = &asd_ha->seq;
+	int i;
+
+	for (i = 0; i < seq->num_escbs; i++) {
+		if (!list_empty(&seq->escb_arr[i]->list))
+			list_del_init(&seq->escb_arr[i]->list);
+		
+		asd_ascb_free(seq->escb_arr[i]);
+	}
+	kfree(seq->escb_arr);
+	seq->escb_arr = NULL;
+}
+
+static inline void asd_destroy_ha_caches(struct asd_ha_struct *asd_ha)
+{
+	int i;
+
+	if (asd_ha->hw_prof.ddb_bitmap)
+		kfree(asd_ha->hw_prof.ddb_bitmap);
+	asd_ha->hw_prof.ddb_bitmap = NULL;
+	
+	for (i = 0; i < ASD_MAX_PHYS; i++) {
+		struct asd_phy *phy = &asd_ha->phys[i];
+
+		asd_free_coherent(asd_ha, phy->id_frm_tok);
+	}
+	if (asd_ha->seq.escb_arr)
+		asd_free_escbs(asd_ha);
+	if (asd_ha->seq.edb_arr)
+		asd_free_edbs(asd_ha);
+	if (asd_ha->hw_prof.ue.area) {
+		kfree(asd_ha->hw_prof.ue.area);
+		asd_ha->hw_prof.ue.area = NULL;
+	}
+	if (asd_ha->seq.tc_index_array) {
+		kfree(asd_ha->seq.tc_index_array);
+		kfree(asd_ha->seq.tc_index_bitmap);
+		asd_ha->seq.tc_index_array = NULL;
+		asd_ha->seq.tc_index_bitmap = NULL;
+	}
+	if (asd_ha->seq.actual_dl) {
+			asd_free_coherent(asd_ha, asd_ha->seq.actual_dl);
+			asd_ha->seq.actual_dl = NULL;
+			asd_ha->seq.dl = NULL;
+	}
+	if (asd_ha->seq.next_scb.vaddr) {
+		dma_pool_free(asd_ha->scb_pool, asd_ha->seq.next_scb.vaddr,
+			      asd_ha->seq.next_scb.dma_handle);
+		asd_ha->seq.next_scb.vaddr = NULL;
+	}
+	dma_pool_destroy(asd_ha->scb_pool);
+	asd_ha->scb_pool = NULL;
+}
+
+kmem_cache_t *asd_dma_token_cache;
+kmem_cache_t *asd_ascb_cache;
+
+static int asd_create_global_caches(void)
+{
+	if (!asd_dma_token_cache) {
+		asd_dma_token_cache
+			= kmem_cache_create(ASD_DRIVER_NAME "_dma_token",
+					    sizeof(struct asd_dma_tok),
+					    0,
+					    SLAB_HWCACHE_ALIGN,
+					    NULL, NULL);
+		if (!asd_dma_token_cache) {
+			asd_printk("couldn't create dma token cache\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (!asd_ascb_cache) {
+		asd_ascb_cache = kmem_cache_create(ASD_DRIVER_NAME "_ascb",
+						   sizeof(struct asd_ascb),
+						   0,
+						   SLAB_HWCACHE_ALIGN,
+						   NULL, NULL);
+		if (!asd_ascb_cache) {
+			asd_printk("couldn't create ascb cache\n");
+			goto Err;
+		}
+	}
+
+	return 0;
+Err:
+	kmem_cache_destroy(asd_dma_token_cache);
+	asd_dma_token_cache = NULL;
+	return -ENOMEM;
+}
+
+static void asd_destroy_global_caches(void)
+{
+	if (asd_dma_token_cache)
+		kmem_cache_destroy(asd_dma_token_cache);
+	asd_dma_token_cache = NULL;
+
+	if (asd_ascb_cache)
+		kmem_cache_destroy(asd_ascb_cache);
+	asd_ascb_cache = NULL;
+}
+
+static int asd_register_sas_ha(struct asd_ha_struct *asd_ha)
+{
+	int i;
+	static struct sas_phy   *sas_phys[ASD_MAX_PHYS];
+	static struct sas_port  *sas_ports[ASD_MAX_PHYS];
+
+	asd_ha->sas_ha.sas_ha_name = (char *) asd_ha->name;
+	asd_ha->sas_ha.lldd_module = THIS_MODULE;
+	asd_ha->sas_ha.sas_addr = &asd_ha->hw_prof.sas_addr[0];
+
+	for (i = 0; i < ASD_MAX_PHYS; i++) {
+		sas_phys[i] = &asd_ha->phys[i].sas_phy;
+		sas_ports[i] = &asd_ha->ports[i];
+	}
+
+	asd_ha->sas_ha.sas_phy = sas_phys;
+	asd_ha->sas_ha.sas_port= sas_ports;
+	asd_ha->sas_ha.num_phys= ASD_MAX_PHYS;
+
+	asd_ha->sas_ha.lldd_port_formed = asd_update_port_links;
+
+	asd_ha->sas_ha.lldd_dev_found = asd_dev_found;
+	asd_ha->sas_ha.lldd_dev_gone = asd_dev_gone;
+
+	asd_ha->sas_ha.lldd_max_execute_num = lldd_max_execute_num;
+	asd_ha->sas_ha.lldd_queue_size = asd_ha->seq.can_queue;
+	asd_ha->sas_ha.lldd_execute_task = asd_execute_task;
+
+	asd_ha->sas_ha.lldd_abort_task     = asd_abort_task;
+	asd_ha->sas_ha.lldd_abort_task_set = asd_abort_task_set;
+	asd_ha->sas_ha.lldd_clear_aca      = asd_clear_aca;
+	asd_ha->sas_ha.lldd_clear_task_set = asd_clear_task_set;
+	asd_ha->sas_ha.lldd_I_T_nexus_reset= NULL;
+	asd_ha->sas_ha.lldd_lu_reset       = asd_lu_reset;
+	asd_ha->sas_ha.lldd_query_task     = asd_query_task;
+
+	asd_ha->sas_ha.lldd_clear_nexus_port = asd_clear_nexus_port;
+	asd_ha->sas_ha.lldd_clear_nexus_ha = asd_clear_nexus_ha;
+
+	asd_ha->sas_ha.lldd_control_phy = asd_control_phy;
+
+	return sas_register_ha(&asd_ha->sas_ha);
+}
+
+static int asd_unregister_sas_ha(struct asd_ha_struct *asd_ha)
+{
+	return sas_unregister_ha(&asd_ha->sas_ha);
+}
+
+static int __devinit asd_pci_probe(struct pci_dev *dev,
+				   const struct pci_device_id *id)
+{
+	struct asd_pcidev_struct *asd_dev;
+	unsigned asd_id = (unsigned) id->driver_data;
+	struct asd_ha_struct *asd_ha;
+	int err;
+
+	if (dev->class == (PCI_CLASS_STORAGE_RAID << 8) && !attach_HostRAID) {
+		asd_printk("will not attach to HostRAID enabled device %s, "
+			   "unless attach_HostRAID parameter is set\n",
+			   pci_name(dev));
+		return -ENODEV;
+	}
+
+	if (asd_id >= ARRAY_SIZE(asd_pcidev_data)) {
+		asd_printk("wrong driver_data in PCI table\n");
+		return -ENODEV;
+	}
+
+	if ((err = pci_enable_device(dev))) {
+		asd_printk("couldn't enable device %s\n", pci_name(dev));
+		return err;
+	}
+
+	pci_set_master(dev);
+	
+	asd_dev = &asd_pcidev_data[asd_id];
+
+	err = -ENOMEM;
+	asd_ha = kmalloc(sizeof(*asd_ha), GFP_KERNEL);
+	if (!asd_ha) {
+		asd_printk("out of memory\n");
+		goto Err;
+	}
+	memset(asd_ha, 0, sizeof(*asd_ha));
+	asd_ha->pcidev = dev;
+	asd_ha->sas_ha.pcidev = asd_ha->pcidev;
+	asd_ha->sas_ha.lldd_ha = asd_ha;
+
+	asd_ha->name = asd_dev->name;
+	asd_printk("found %s, device %s\n", asd_ha->name, pci_name(dev));
+	err = asd_dev->setup(asd_ha);
+	if (err)
+		goto Err_free;
+
+	err = -ENODEV;
+	if (!pci_set_dma_mask(dev, DMA_64BIT_MASK)
+	    && !pci_set_consistent_dma_mask(dev, DMA_64BIT_MASK))
+		;
+	else if (!pci_set_dma_mask(dev, DMA_32BIT_MASK)
+		 && !pci_set_consistent_dma_mask(dev, DMA_32BIT_MASK))
+		;
+	else {
+		asd_printk("no suitable DMA mask for %s\n", pci_name(dev));
+		goto Err_free;
+	}
+
+	pci_set_drvdata(dev, asd_ha);
+
+	err = asd_map_ha(asd_ha);
+	if (err)
+		goto Err_free;
+
+	err = asd_create_ha_caches(asd_ha);
+        if (err)
+		goto Err_unmap;
+
+	err = asd_init_hw(asd_ha);
+	if (err)
+		goto Err_free_cache;
+
+	asd_printk("device %s: SAS addr %llx, PCBA SN %s, %d phys, %d enabled "
+		   "phys, flash %s, BIOS %s%d\n",
+		   pci_name(dev), SAS_ADDR(asd_ha->hw_prof.sas_addr),
+		   asd_ha->hw_prof.pcba_sn, asd_ha->hw_prof.max_phys,
+		   asd_ha->hw_prof.num_phys,
+		   asd_ha->hw_prof.flash.present ? "present" : "not present",
+		   asd_ha->hw_prof.bios.present ? "build " : "not present",
+		   asd_ha->hw_prof.bios.bld);
+
+	if (use_msi)
+		pci_enable_msi(asd_ha->pcidev);
+
+	err = request_irq(asd_ha->pcidev->irq, asd_hw_isr, SA_SHIRQ,
+			  ASD_DRIVER_NAME, asd_ha);
+	if (err) {
+		asd_printk("couldn't get irq %d for %s\n",
+			   asd_ha->pcidev->irq, pci_name(asd_ha->pcidev));
+		goto Err_irq;
+	}
+	asd_enable_ints(asd_ha);
+
+	err = asd_init_post_escbs(asd_ha);
+	if (err) {
+		asd_printk("couldn't post escbs for %s\n",
+			   pci_name(asd_ha->pcidev));
+		goto Err_escbs;
+	}
+	ASD_DPRINTK("escbs posted\n");
+
+	asd_create_dev_attrs(asd_ha);
+
+	err = asd_register_sas_ha(asd_ha);
+	if (err)
+		goto Err_reg_sas;
+	
+	err = asd_enable_phys(asd_ha, asd_ha->hw_prof.enabled_phys);
+	if (err) {
+		asd_printk("coudln't enable phys, err:%d\n", err);
+		goto Err_en_phys;
+	}
+	ASD_DPRINTK("enabled phys\n");
+
+	return 0;
+Err_en_phys:
+	asd_unregister_sas_ha(asd_ha);
+Err_reg_sas:
+	asd_remove_dev_attrs(asd_ha);
+Err_escbs:
+	asd_disable_ints(asd_ha);
+	free_irq(dev->irq, asd_ha);
+Err_irq:
+	if (use_msi)
+		pci_disable_msi(dev);
+	asd_chip_hardrst(asd_ha);
+Err_free_cache:
+	asd_destroy_ha_caches(asd_ha);
+Err_unmap:
+	asd_unmap_ha(asd_ha);
+Err_free:
+	kfree(asd_ha);
+Err:
+	pci_disable_device(dev);
+	return err;
+}
+
+static void asd_free_queues(struct asd_ha_struct *asd_ha)
+{
+	unsigned long flags;
+	LIST_HEAD(pending);
+	struct list_head *n, *pos;
+
+	spin_lock_irqsave(&asd_ha->seq.pend_q_lock, flags);
+	asd_ha->seq.pending = 0;
+	list_splice_init(&asd_ha->seq.pend_q, &pending);
+	spin_unlock_irqrestore(&asd_ha->seq.pend_q_lock, flags);
+
+	if (!list_empty(&pending))
+		ASD_DPRINTK("Uh-oh! Pending is not empty!\n");
+
+	list_for_each_safe(pos, n, &pending) {
+		struct asd_ascb *ascb = list_entry(pos, struct asd_ascb, list);
+		list_del_init(pos);
+		ASD_DPRINTK("freeing from pending\n");
+		asd_ascb_free(ascb);
+	}
+}
+
+static void asd_turn_off_leds(struct asd_ha_struct *asd_ha)
+{
+	u8 phy_mask = asd_ha->hw_prof.enabled_phys;
+	u8 i;
+
+	for_each_phy(phy_mask, phy_mask, i) {
+		asd_turn_led(asd_ha, i, 0);
+		asd_control_led(asd_ha, i, 0);
+	}
+}
+
+static void __devexit asd_pci_remove(struct pci_dev *dev)
+{
+	struct asd_ha_struct *asd_ha = pci_get_drvdata(dev);
+
+	if (!asd_ha)
+		return;
+
+	asd_unregister_sas_ha(asd_ha);
+
+	asd_disable_ints(asd_ha);
+
+	asd_remove_dev_attrs(asd_ha);
+
+	/* XXX more here as needed */
+
+	free_irq(dev->irq, asd_ha);
+	if (use_msi)
+		pci_disable_msi(asd_ha->pcidev);
+	asd_turn_off_leds(asd_ha);
+	asd_chip_hardrst(asd_ha);
+	asd_free_queues(asd_ha);
+	asd_destroy_ha_caches(asd_ha);
+	asd_unmap_ha(asd_ha);
+	kfree(asd_ha);
+	pci_disable_device(dev);
+	return;
+}
+
+static ssize_t asd_version_show(struct device_driver *driver, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", ASD_DRIVER_VERSION);
+}
+static DRIVER_ATTR(version, S_IRUGO, asd_version_show, NULL);
+
+static void asd_create_driver_attrs(struct device_driver *driver)
+{
+	driver_create_file(driver, &driver_attr_version);
+}
+
+static void asd_remove_driver_attrs(struct device_driver *driver)
+{
+	driver_remove_file(driver, &driver_attr_version);
+}
+
+static const struct pci_device_id aic94xx_pci_table[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR10),
+	 0, 0, 1},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR12),
+	 0, 0, 1},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR1E),
+	 0, 0, 1},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR30),
+	 0, 0, 2},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR32),
+	 0, 0, 2},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR3E),
+	 0, 0, 2},
+	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_RAZOR3F),
+	 0, 0, 2},
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, aic94xx_pci_table);
+
+static struct pci_driver aic94xx_pci_driver = {
+	.name		= ASD_DRIVER_NAME,
+	.owner		= THIS_MODULE,
+	.id_table	= aic94xx_pci_table,
+	.probe		= asd_pci_probe,
+	.remove		= __devexit_p(asd_pci_remove),
+};
+
+static int __init aic94xx_init(void)
+{
+	int err;
+
+
+	asd_printk("%s version %s loaded\n", ASD_DRIVER_DESCRIPTION,
+		   ASD_DRIVER_VERSION);
+	
+	err = asd_create_global_caches();
+	if (err)
+		return err;
+	
+	err = pci_register_driver(&aic94xx_pci_driver);
+ 	if (!err)
+ 		asd_create_driver_attrs(&aic94xx_pci_driver.driver);
+	
+	return err;
+}
+
+static void __exit aic94xx_exit(void)
+{
+ 	asd_remove_driver_attrs(&aic94xx_pci_driver.driver);
+	pci_unregister_driver(&aic94xx_pci_driver);
+	asd_destroy_global_caches();
+	asd_printk("%s version %s unloaded\n", ASD_DRIVER_DESCRIPTION,
+		   ASD_DRIVER_VERSION);
+}
+
+module_init(aic94xx_init);
+module_exit(aic94xx_exit);
+
+MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
+MODULE_DESCRIPTION(ASD_DRIVER_DESCRIPTION);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(ASD_DRIVER_VERSION);

