Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbTGIStk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbTGIStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:49:40 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:59145 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266085AbTGIStf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:49:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] 2.4.21 cpqarray, bigioctl memory leak
Date: Wed, 9 Jul 2003 14:04:11 -0500
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E157CE@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.21 cpqarray, bigioctl memory leak
Thread-Index: AcNGTSCD0yi+Qa0HT0ChqN66NsvbJQ==
From: "Wiran, Francis" <francis.wiran@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jul 2003 19:04:13.0551 (UTC) FILETIME=[E2F287F0:01C3464C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
  1. Bumped version to 2.4.26
  2. memory leak fix in ida_ctlr_big_ioctl()
  3. removed some pci_read_config calls due to values
     already available in pdev (per Tom Coughlan, RedHat, Apr 2003)

 drivers/block/cpqarray.c |   59
+++++++++++++++--------------------------------
 1 files changed, 19 insertions(+), 40 deletions(-)

---
linux-2.4.21-2/drivers/block/cpqarray.c~cpqarray_2.4.26_from_2.4.25_for_
RH80	Wed Jul  9 11:48:48 2003
+++ linux-2.4.21-2-root/drivers/block/cpqarray.c	Wed Jul  9
13:55:05 2003
@@ -41,13 +41,13 @@
 
 #define SMART2_DRIVER_VERSION(maj,min,submin)
((maj<<16)|(min<<8)|(submin))
 
-#define DRIVER_NAME "Compaq SMART2 Driver (v 2.4.25)"
-#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,4,25)
+#define DRIVER_NAME "Compaq SMART2 Driver (v 2.4.26)"
+#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,4,26)
 
 /* Embedded module documentation macros - see modules.h */
 /* Original author Chris Frantz - Compaq Computer Corporation */
 MODULE_AUTHOR("Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.4.25");
+MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.4.26");
 MODULE_LICENSE("GPL");
 
 #define MAJOR_NR COMPAQ_SMART2_MAJOR
@@ -657,9 +657,8 @@ static void free_hba(int i)
  */
 static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
-	ushort vendor_id, device_id, command;
-	unchar cache_line_size, latency_timer;
-	unchar irq, revision;
+	ushort subsystem_vendor_id, subsystem_device_id, command;
+	unchar irq;
 	unsigned long addr[6];
 	__u32 board_id;
 
@@ -673,10 +672,13 @@ static int cpqarray_pci_init(ctlr_info_t
 	}
 	
 	c->pci_dev = pdev;
-	vendor_id = pdev->vendor;
-	device_id = pdev->device;
+	subsystem_vendor_id = pdev->subsystem_vendor;
+	subsystem_device_id = pdev->subsystem_device;
 	irq = pdev->irq;
 
+	board_id = (((__u32) (subsystem_device_id) << 16) & 0xffff0000)
|
+			(__u32) (subsystem_vendor_id);
+
 	for(i=0; i<6; i++)
 		addr[i] = pci_resource_start(pdev, i);
 
@@ -689,25 +691,6 @@ static int cpqarray_pci_init(ctlr_info_t
 		return -1;
 	}
 
-	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
&cache_line_size);
-	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency_timer);
-
-	pci_read_config_dword(pdev, 0x2c, &board_id);
-
-DBGINFO(
-	printk("vendor_id = %x\n", vendor_id);
-	printk("device_id = %x\n", device_id);
-	printk("command = %x\n", command);
-	for(i=0; i<6; i++)
-		printk("addr[%d] = %lx\n", i, addr[i]);
-	printk("revision = %x\n", revision);
-	printk("irq = %x\n", irq);
-	printk("cache_line_size = %x\n", cache_line_size);
-	printk("latency_timer = %x\n", latency_timer);
-	printk("board_id = %x\n", board_id);
-);
-
 	c->intr = irq;
 	for(i=0; i<6; i++) {
 		if (pci_resource_flags(pdev, i) &
PCI_BASE_ADDRESS_SPACE_IO) { 
@@ -1654,6 +1637,7 @@ static int ida_ctlr_big_ioctl(int ctlr, 
 	for(i=0; i<c->req.hdr.sg_cnt; i++) {
 		pci_unmap_single(h->pci_dev, c->req.sg[i].addr, 
 				c->req.sg[i].size,
PCI_DMA_BIDIRECTIONAL);
+		c->reg.sg[i].addr = 0;
 	}
 
 	/* if we are reading data from the hardware copy it back to user
*/
@@ -1674,31 +1658,26 @@ static int ida_ctlr_big_ioctl(int ctlr, 
 
 	io->rcode = c->req.hdr.rcode;
 
+ida_alloc_cleanup:
 	if(scsi_param) {
 		pci_unmap_single(h->pci_dev, c->req.hdr.blk,
 			sizeof(scsi_param_t), PCI_DMA_BIDIRECTIONAL);
 		/* copy the scsi_params back to the user */ 
-		if( copy_to_user(io->scsi_param, scsi_param, 
+		if(error == 0 &&
+			copy_to_user(io->scsi_param, scsi_param, 
 					sizeof(scsi_param_t))) {
 			error = -EFAULT;	
 		}
 		kfree(scsi_param);
 	}
-	cmd_free(h, c, 0);
-	return(error);
 	
-ida_alloc_cleanup:
-	if(scsi_param) {
-		pci_unmap_single(h->pci_dev, c->req.hdr.blk,
-			sizeof(scsi_param_t), PCI_DMA_BIDIRECTIONAL);
-		kfree(scsi_param);
-	}
 	for (i=0; i<sg_used; i++) {
-		if(buff[sg_used] != NULL) {	
+		if(c->req.sg[i].addr != NULL)
 			pci_unmap_single(h->pci_dev, c->req.sg[i].addr, 
-				buff_size[sg_used],
PCI_DMA_BIDIRECTIONAL);
-			kfree(buff[sg_used]);
-		}
+				buff_size[i], PCI_DMA_BIDIRECTIONAL);
+		if(buff[i]!=NULL)
+			kfree(buff[i]);
+
 	}	
 	cmd_free(h, c, 0);
 	return(error);

_
