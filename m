Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTHJLMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHJLKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:10:47 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:36620 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263597AbTHJLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:10:00 -0400
Date: Sun, 10 Aug 2003 20:10:09 +0900 (JST)
Message-Id: <20030810.201009.77128484.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[7/9] convert drivers/scsi to virt_to_pageoff().
 
Index: linux-2.6/drivers/scsi/3w-xxxx.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/3w-xxxx.c,v
retrieving revision 1.34
diff -u -r1.34 3w-xxxx.c
--- linux-2.6/drivers/scsi/3w-xxxx.c	17 Jul 2003 17:43:53 -0000	1.34
+++ linux-2.6/drivers/scsi/3w-xxxx.c	10 Aug 2003 09:30:32 -0000
@@ -2112,7 +2112,7 @@
 	if (cmd->request_bufflen == 0)
 		return 0;
 
-	mapping = pci_map_page(pdev, virt_to_page(cmd->request_buffer), ((unsigned long)cmd->request_buffer & ~PAGE_MASK), cmd->request_bufflen, dma_dir);
+	mapping = pci_map_page(pdev, virt_to_page(cmd->request_buffer), virt_to_pageoff(cmd->request_buffer), cmd->request_bufflen, dma_dir);
 
 	if (mapping == 0) {
 		printk(KERN_WARNING "3w-xxxx: tw_map_scsi_single_data(): pci_map_page() failed.\n");
Index: linux-2.6/drivers/scsi/ide-scsi.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/ide-scsi.c,v
retrieving revision 1.80
diff -u -r1.80 ide-scsi.c
--- linux-2.6/drivers/scsi/ide-scsi.c	18 Jul 2003 20:29:54 -0000	1.80
+++ linux-2.6/drivers/scsi/ide-scsi.c	10 Aug 2003 09:30:32 -0000
@@ -761,8 +761,8 @@
 		printk ("ide-scsi: %s: building DMA table for a single buffer (%dkB)\n", drive->name, pc->request_transfer >> 10);
 #endif /* IDESCSI_DEBUG_LOG */
 		bh->bi_io_vec[0].bv_page = virt_to_page(pc->scsi_cmd->request_buffer);
+		bh->bi_io_vec[0].bv_offset = virt_to_pageoff(pc->scsi_cmd->request_buffer);
 		bh->bi_io_vec[0].bv_len = pc->request_transfer;
-		bh->bi_io_vec[0].bv_offset = (unsigned long) pc->scsi_cmd->request_buffer & ~PAGE_MASK;
 		bh->bi_size = pc->request_transfer;
 	}
 	return first_bh;
Index: linux-2.6/drivers/scsi/megaraid.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/megaraid.c,v
retrieving revision 1.43
diff -u -r1.43 megaraid.c
--- linux-2.6/drivers/scsi/megaraid.c	17 Jul 2003 17:43:53 -0000	1.43
+++ linux-2.6/drivers/scsi/megaraid.c	10 Aug 2003 09:30:32 -0000
@@ -2275,8 +2275,7 @@
 	if( !cmd->use_sg ) {
 
 		page = virt_to_page(cmd->request_buffer);
-
-		offset = ((unsigned long)cmd->request_buffer & ~PAGE_MASK);
+		offset = virt_to_pageoff(cmd->request_buffer);
 
 		scb->dma_h_bulkdata = pci_map_page(adapter->dev,
 						  page, offset,
Index: linux-2.6/drivers/scsi/qlogicfc.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/qlogicfc.c,v
retrieving revision 1.34
diff -u -r1.34 qlogicfc.c
--- linux-2.6/drivers/scsi/qlogicfc.c	17 Jul 2003 17:43:53 -0000	1.34
+++ linux-2.6/drivers/scsi/qlogicfc.c	10 Aug 2003 09:30:32 -0000
@@ -1283,8 +1283,7 @@
 		}
 	} else if (Cmnd->request_bufflen && Cmnd->sc_data_direction != PCI_DMA_NONE) {
 		struct page *page = virt_to_page(Cmnd->request_buffer);
-		unsigned long offset = ((unsigned long)Cmnd->request_buffer &
-					~PAGE_MASK);
+		unsigned long offset = virt_to_pageoff(Cmnd->request_buffer);
 		dma_addr_t busaddr = pci_map_page(hostdata->pci_dev,
 						  page, offset,
 						  Cmnd->request_bufflen,
@@ -1927,8 +1926,7 @@
 	 */
 	busaddr = pci_map_page(hostdata->pci_dev,
 			       virt_to_page(&hostdata->control_block),
-			       ((unsigned long) &hostdata->control_block &
-				~PAGE_MASK),
+			       virt_to_pageoff(&hostdata->control_block),
 			       sizeof(hostdata->control_block),
 			       PCI_DMA_BIDIRECTIONAL);
 
Index: linux-2.6/drivers/scsi/sg.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/sg.c,v
retrieving revision 1.54
diff -u -r1.54 sg.c
--- linux-2.6/drivers/scsi/sg.c	17 Jul 2003 17:43:53 -0000	1.54
+++ linux-2.6/drivers/scsi/sg.c	10 Aug 2003 09:30:33 -0000
@@ -1813,7 +1813,7 @@
 					break;
 			}
 			sclp->page = virt_to_page(p);
-			sclp->offset = (unsigned long) p & ~PAGE_MASK;
+			sclp->offset = virt_to_pageoff(p);
 			sclp->length = ret_sz;
 
 			SCSI_LOG_TIMEOUT(5, printk("sg_build_build: k=%d, a=0x%p, len=%d\n",
Index: linux-2.6/drivers/scsi/sym53c8xx.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/sym53c8xx.c,v
retrieving revision 1.39
diff -u -r1.39 sym53c8xx.c
--- linux-2.6/drivers/scsi/sym53c8xx.c	18 Jul 2003 16:56:15 -0000	1.39
+++ linux-2.6/drivers/scsi/sym53c8xx.c	10 Aug 2003 09:30:33 -0000
@@ -1162,8 +1162,7 @@
 
 	mapping = pci_map_page(pdev,
 			       virt_to_page(cmd->request_buffer),
-			       ((unsigned long)cmd->request_buffer &
-				~PAGE_MASK),
+			       virt_to_pageoff(cmd->request_buffer),
 			       cmd->request_bufflen, dma_dir);
 	__data_mapped(cmd) = 1;
 	__data_mapping(cmd) = mapping;
Index: linux-2.6/drivers/scsi/arm/scsi.h
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/scsi/arm/scsi.h,v
retrieving revision 1.2
diff -u -r1.2 scsi.h
--- linux-2.6/drivers/scsi/arm/scsi.h	19 May 2003 17:48:30 -0000	1.2
+++ linux-2.6/drivers/scsi/arm/scsi.h	10 Aug 2003 09:30:33 -0000
@@ -23,7 +23,7 @@
 	BUG_ON(bufs + 1 > max);
 
 	sg->page   = virt_to_page(SCp->ptr);
-	sg->offset = ((unsigned int)SCp->ptr) & ~PAGE_MASK;
+	sg->offset = virt_to_pageoff(SCp->ptr);
 	sg->length = SCp->this_residual;
 
 	if (bufs)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
