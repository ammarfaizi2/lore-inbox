Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbVBDTvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbVBDTvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVBDTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:51:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264286AbVBDTpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:45:25 -0500
Date: Fri, 4 Feb 2005 11:45:14 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: jgarzik@pobox.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: SATA in 2.4 at PE750
Message-ID: <20050204114514.4ae7ef2a@localhost.localdomain>
In-Reply-To: <20050203135829.319d3b69@localhost.localdomain>
References: <20050203135829.319d3b69@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005 13:58:29 -0800, Pete Zaitcev <zaitcev@redhat.com> wrote:

> I haven't reached the test for corruption because the stock SATA oopses at
> probe time. Running Marcelo's 2.4.29 and 2.4.29-rc1-libata1.patch
> (also ksymoops from RHEL 3). Please see the attached snapshot.
> 
> NULL oops in ata_host_add
> ata_device_add
> ata_scsi_detect
> piix_init_one
> .....

Jeff, you're allocating a block of two probe entries with a signle kmalloc
then freeing halfs of it with two kfrees.

I threw that stuff out and reverted to normal allocations like in RHEL3
and the Dell boots now. See the patch, please.

The judgment is outstanding about the corruption, I'll let you know how
that goes.

-- Pete

diff -urp -X dontdiff linux-2.4.29-jgbase/drivers/scsi/libata-core.c linux-2.4.29-t1/drivers/scsi/libata-core.c
--- linux-2.4.29-jgbase/drivers/scsi/libata-core.c	2005-02-04 11:36:47.000000000 -0800
+++ linux-2.4.29-t1/drivers/scsi/libata-core.c	2005-02-04 11:17:34.000000000 -0800
@@ -3470,32 +3470,28 @@ void ata_std_ports(struct ata_ioports *i
 }
 
 static struct ata_probe_ent *
-ata_probe_ent_alloc(int n, struct device *dev, struct ata_port_info **port)
+ata_probe_ent_alloc(struct device *dev, struct ata_port_info *port)
 {
 	struct ata_probe_ent *probe_ent;
-	int i;
 
-	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       pci_name(to_pci_dev(dev)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent) * n);
+	memset(probe_ent, 0, sizeof(*probe_ent));
 
-	for (i = 0; i < n; i++) {
-		INIT_LIST_HEAD(&probe_ent[i].node);
-		probe_ent[i].dev = dev;
-
-		probe_ent[i].sht = port[i]->sht;
-		probe_ent[i].host_flags = port[i]->host_flags;
-		probe_ent[i].pio_mask = port[i]->pio_mask;
-		probe_ent[i].mwdma_mask = port[i]->mwdma_mask;
-		probe_ent[i].udma_mask = port[i]->udma_mask;
-		probe_ent[i].port_ops = port[i]->port_ops;
+	INIT_LIST_HEAD(&probe_ent->node);
+	probe_ent->dev = dev;
 
-	}
+	probe_ent->sht = port->sht;
+	probe_ent->host_flags = port->host_flags;
+	probe_ent->pio_mask = port->pio_mask;
+	probe_ent->mwdma_mask = port->mwdma_mask;
+	probe_ent->udma_mask = port->udma_mask;
+	probe_ent->port_ops = port->port_ops;
 
 	return probe_ent;
 }
@@ -3505,7 +3501,7 @@ struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
 	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(1, pci_dev_to_dev(pdev), port);
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
@@ -3532,38 +3528,46 @@ ata_pci_init_native_mode(struct pci_dev 
 }
 
 struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port,
+    struct ata_probe_ent **ppe2)
 {
-	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(2, pci_dev_to_dev(pdev), port);
+	struct ata_probe_ent *probe_ent, *probe_ent2;
+
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
+	probe_ent2 = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[1]);
+	if (!probe_ent2) {
+		kfree(probe_ent);
+		return NULL;
+	}
+
+	probe_ent->n_ports = 1;
+	probe_ent->irq = 14;
 
-	probe_ent[0].n_ports = 1;
-	probe_ent[0].irq = 14;
+	probe_ent->hard_port_no = 0;
+	probe_ent->legacy_mode = 1;
 
-	probe_ent[0].hard_port_no = 0;
-	probe_ent[0].legacy_mode = 1;
+	probe_ent2->n_ports = 1;
+	probe_ent2->irq = 15;
 
-	probe_ent[1].n_ports = 1;
-	probe_ent[1].irq = 15;
+	probe_ent2->hard_port_no = 1;
+	probe_ent2->legacy_mode = 1;
 
-	probe_ent[1].hard_port_no = 1;
-	probe_ent[1].legacy_mode = 1;
-
-	probe_ent[0].port[0].cmd_addr = 0x1f0;
-	probe_ent[0].port[0].altstatus_addr =
-	probe_ent[0].port[0].ctl_addr = 0x3f6;
-	probe_ent[0].port[0].bmdma_addr = pci_resource_start(pdev, 4);
-
-	probe_ent[1].port[0].cmd_addr = 0x170;
-	probe_ent[1].port[0].altstatus_addr =
-	probe_ent[1].port[0].ctl_addr = 0x376;
-	probe_ent[1].port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+	probe_ent->port[0].cmd_addr = 0x1f0;
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr = 0x3f6;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
+	probe_ent2->port[0].cmd_addr = 0x170;
+	probe_ent2->port[0].altstatus_addr =
+	probe_ent2->port[0].ctl_addr = 0x376;
+	probe_ent2->port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
 
-	ata_std_ports(&probe_ent[0].port[0]);
-	ata_std_ports(&probe_ent[1].port[0]);
+	ata_std_ports(&probe_ent->port[0]);
+	ata_std_ports(&probe_ent2->port[0]);
 
+	*ppe2 = probe_ent2;
 	return probe_ent;
 }
 
@@ -3656,9 +3660,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 
 	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_mode(pdev, port);
-		if (probe_ent)
-			probe_ent2 = &probe_ent[1];
+		probe_ent = ata_pci_init_legacy_mode(pdev, port, &probe_ent2);
 	} else
 		probe_ent = ata_pci_init_native_mode(pdev, port);
 	if (!probe_ent) {
@@ -3670,17 +3672,14 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	spin_lock(&ata_module_lock);
 	if (legacy_mode) {
-		int free = 0;
 		if (legacy_mode & (1 << 0))
 			list_add_tail(&probe_ent->node, &ata_probe_list);
 		else
-			free++;
+			kfree(probe_ent);
 		if (legacy_mode & (1 << 1))
 			list_add_tail(&probe_ent2->node, &ata_probe_list);
 		else
-			free++;
-		if (free > 1)
-			kfree(probe_ent);
+			kfree(probe_ent2);
 	} else {
 		list_add_tail(&probe_ent->node, &ata_probe_list);
 	}
diff -urp -X dontdiff linux-2.4.29-jgbase/include/linux/libata.h linux-2.4.29-t1/include/linux/libata.h
--- linux-2.4.29-jgbase/include/linux/libata.h	2005-02-03 23:55:33.000000000 -0800
+++ linux-2.4.29-t1/include/linux/libata.h	2005-02-04 00:03:23.000000000 -0800
@@ -436,7 +436,8 @@ struct pci_bits {
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port,
+    struct ata_probe_ent **);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 
 #endif /* CONFIG_PCI */
