Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTLQPWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTLQPWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:22:09 -0500
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:6918 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264434AbTLQPWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:22:05 -0500
Date: Wed, 17 Dec 2003 09:23:03 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com
Subject: cciss update for 2.4.24-pre1, #3
Message-ID: <Pine.LNX.4.58.0312170909380.30620@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I forgot to send this fix in with the 2 patches I submitted
yesterday. We found a bug in the ASIC used on the 64xx Smart Array
controllers. When prefetching from host memory we grab an extra 750 or
so bytes of data. If this occurs on a memory boundary the machine will crash.
This is primarily an issue on IPF and Alpha systems although it could happen
on other platforms. Proliant systems are not affected by this bug because
memory is contiguous and the top 4k of memory is masked off by the system
firmware. The solution to the problem is to disable SCSI prefetch in the
controller firmware. This results in a performance hit on x86 during RAID1
operations. This patch turns on prefetch for x86 based systems only.
Please consider this patch for inclusion in the 2.4.24 kernel.
This patch should be applied after the 2 I submitted yesterday. It will
patch into a fresh tree with offsets.

Thanks,
mikem
mike.miller@hp.com
------------------------------------------------------------------------------
diff -burN lx2424pre1-p02/drivers/block/cciss.c lx2424pre1/drivers/block/cciss.c
--- lx2424pre1-p02/drivers/block/cciss.c	2003-12-16 17:30:41.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.c	2003-12-17 09:02:04.000000000 -0600
@@ -2542,6 +2542,7 @@
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
 	__u64 cfg_base_addr_index;
+	__u32 prefetch;
 	int i;

 	/* check to see if controller has been disabled */
@@ -2675,6 +2676,14 @@
 		printk("Does not appear to be a valid CISS config table\n");
 		return -1;
 	}
+
+#ifdef CONFIG_X86
+	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
+	prefetch = readl(&(c->cfgtable->SCSI_Prefetch));
+	prefetch |= 0x100;
+	writel(prefetch, &(c->cfgtable->SCSI_Prefetch));
+#endif
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif /* CCISS_DEBUG */
diff -burN lx2424pre1-p02/drivers/block/cciss_cmd.h lx2424pre1/drivers/block/cciss_cmd.h
--- lx2424pre1-p02/drivers/block/cciss_cmd.h	2003-06-13 09:51:32.000000000 -0500
+++ lx2424pre1/drivers/block/cciss_cmd.h	2003-12-17 09:01:18.000000000 -0600
@@ -266,6 +266,7 @@
   DWORD            Reserved;
   BYTE             ServerName[16];
   DWORD            HeartBeat;
+  DWORD            SCSI_Prefetch;
 } CfgTable_struct;
 #pragma pack()
 #endif /* CCISS_CMD_H */
------------------------------------------------------------------------------
