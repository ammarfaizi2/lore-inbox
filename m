Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUBEALn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBEAJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:09:42 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:40971 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265056AbUBEAIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:08:46 -0500
Date: Wed, 4 Feb 2004 18:13:10 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [5 of 11]
Message-ID: <Pine.LNX.4.58.0402041811130.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5 of 11. Please apply in order.
This patch addresses a bug in the ASIC on the 6400 series controllers. When
prefetching from host memory we grab an extra 750 or so bytes of data. If
this occurs on a memory boundary the machine will MCA. This bug affects
IPF and Alpha based platforms. It is not known to be a problem on x86.
Prefetch will be disabled via the f/w. We need to enable it on x86 to
address a _big_ performance hit on RAID 1 operations.
It is in the 2.4 tree.
--------------------------------------------------------------------------------------
diff -burN lx261-p004/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p004/drivers/block/cciss.c	2004-01-21 17:02:06.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-22 14:12:04.000000000 -0600
@@ -2277,6 +2277,17 @@
 		printk("Does not appear to be a valid CISS config table\n");
 		return -1;
 	}
+
+#ifdef CONFIG_X86
+{
+	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
+	__u32 prefetch;
+	prefetch = readl(&(c->cfgtable->SCSI_Prefetch));
+	prefetch |= 0x100;
+	writel(prefetch, &(c->cfgtable->SCSI_Prefetch));
+}
+#endif
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif /* CCISS_DEBUG */
diff -burN lx261-p004/drivers/block/cciss_cmd.h lx261/drivers/block/cciss_cmd.h
--- lx261-p004/drivers/block/cciss_cmd.h	2004-01-09 00:59:10.000000000 -0600
+++ lx261/drivers/block/cciss_cmd.h	2004-01-21 17:24:59.000000000 -0600
@@ -265,6 +265,7 @@
   DWORD            Reserved;
   BYTE             ServerName[16];
   DWORD            HeartBeat;
+  DWORD            SCSI_Prefetch;
 } CfgTable_struct;
 #pragma pack()
 #endif // CCISS_CMD_H

Thanks,
mikem
mike.miller@hp.com

