Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVCQLx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVCQLx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVCQLxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:53:03 -0500
Received: from ozlabs.org ([203.10.76.45]:38298 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263064AbVCQLMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 06:12:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.26014.399741.235995@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 22:10:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Utz Bacher <utz.bacher@de.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: fix error cases in nvram partition scan
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NVRAM on pSeries machines and powermacs is structured as a series
of partitions, each of which has a header containing its length
(including the header) and a header checksum.  When the checksum was
wrong or the length was zero, we would previously keep trying to scan
through the partitions, possibly looping forever if the length was
zero.  This patch changes the behaviour to terminate the scan when a
corrupted partition is found.

Signed-off-by: Utz Bacher <utz.bacher@de.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/nvram.c test/arch/ppc64/kernel/nvram.c
--- linux-2.5/arch/ppc64/kernel/nvram.c	2005-03-14 18:03:26.000000000 +1100
+++ test/arch/ppc64/kernel/nvram.c	2005-03-14 20:26:55.000000000 +1100
@@ -507,8 +507,8 @@
 	struct nvram_partition * tmp_part;
 	unsigned char c_sum;
 	char * header;
-	long size;
 	int total_size;
+	int err;
 
 	if (ppc_md.nvram_size == NULL)
 		return -ENODEV;
@@ -522,29 +522,37 @@
 
 	while (cur_index < total_size) {
 
-		size = ppc_md.nvram_read(header, NVRAM_HEADER_LEN, &cur_index);
-		if (size != NVRAM_HEADER_LEN) {
+		err = ppc_md.nvram_read(header, NVRAM_HEADER_LEN, &cur_index);
+		if (err != NVRAM_HEADER_LEN) {
 			printk(KERN_ERR "nvram_scan_partitions: Error parsing "
 			       "nvram partitions\n");
-			kfree(header);
-			return size;
+			goto out;
 		}
 
 		cur_index -= NVRAM_HEADER_LEN; /* nvram_read will advance us */
 
 		memcpy(&phead, header, NVRAM_HEADER_LEN);
 
+		err = 0;
 		c_sum = nvram_checksum(&phead);
-		if (c_sum != phead.checksum)
-			printk(KERN_WARNING "WARNING: nvram partition checksum "
-			       "was %02x, should be %02x!\n", phead.checksum, c_sum);
-		
+		if (c_sum != phead.checksum) {
+			printk(KERN_WARNING "WARNING: nvram partition checksum"
+			       " was %02x, should be %02x!\n",
+			       phead.checksum, c_sum);
+			printk(KERN_WARNING "Terminating nvram partition scan\n");
+			goto out;
+		}
+		if (!phead.length) {
+			printk(KERN_WARNING "WARNING: nvram corruption "
+			       "detected: 0-length partition\n");
+			goto out;
+		}
 		tmp_part = (struct nvram_partition *)
 			kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
+		err = -ENOMEM;
 		if (!tmp_part) {
 			printk(KERN_ERR "nvram_scan_partitions: kmalloc failed\n");
-			kfree(header);
-			return -ENOMEM;
+			goto out;
 		}
 		
 		memcpy(&tmp_part->header, &phead, NVRAM_HEADER_LEN);
@@ -553,9 +561,11 @@
 		
 		cur_index += phead.length * NVRAM_BLOCK_LEN;
 	}
+	err = 0;
 
+ out:
 	kfree(header);
-	return 0;
+	return err;
 }
 
 static int __init nvram_init(void)
