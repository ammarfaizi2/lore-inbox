Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTBLTBQ>; Wed, 12 Feb 2003 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbTBLTBQ>; Wed, 12 Feb 2003 14:01:16 -0500
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:53774 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267540AbTBLTBN>; Wed, 12 Feb 2003 14:01:13 -0500
Date: Wed, 12 Feb 2003 13:11:40 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071140.GB1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From randy.dunlap@verizon.net, fix memory leaks in cciss driver
(patch 2 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~cciss-memleak	2003-02-12 10:12:41.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:12:41.000000000 +0600
@@ -1013,9 +1013,9 @@ static int register_new_disk(int ctlr)
 	int new_lun_index = 0;
 	int free_index_found = 0;
 	int free_index = 0;
-	ReportLunData_struct *ld_buff;
-	ReadCapdata_struct *size_buff;
-	InquiryData_struct *inq_buff;
+	ReportLunData_struct *ld_buff = NULL;
+	ReadCapdata_struct *size_buff = NULL;
+	InquiryData_struct *inq_buff = NULL;
 	int return_code;
 	int listlength = 0;
 	__u32 lunid = 0;
@@ -1030,26 +1030,14 @@ static int register_new_disk(int ctlr)
 	
 	ld_buff = kmalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
 	if (ld_buff == NULL)
-	{
-		printk(KERN_ERR "cciss: out of memory\n");
-		return -1;
-	}
+		goto mem_msg;
 	memset(ld_buff, 0, sizeof(ReportLunData_struct));
 	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
         if (size_buff == NULL)
-        {
-                printk(KERN_ERR "cciss: out of memory\n");
-		kfree(ld_buff);
-                return -1;
-        }
+		goto mem_msg;
 	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
         if (inq_buff == NULL)
-        {
-                printk(KERN_ERR "cciss: out of memory\n");
-                kfree(ld_buff);
-		kfree(size_buff);
-                return -1;
-        }
+		goto mem_msg;
 	
 	return_code = sendcmd_withirq(CISS_REPORT_LOG, ctlr, ld_buff, 
 			sizeof(ReportLunData_struct), 0, 0, 0 );
@@ -1068,7 +1056,7 @@ static int register_new_disk(int ctlr)
 		printk(KERN_WARNING "cciss: report logical volume"
 			" command failed\n");
 		listlength = 0;
-		return -1;
+		goto free_err;
 	}
 	num_luns = listlength / 8; // 8 bytes pre entry
 	if (num_luns > CISS_MAX_LUN)
@@ -1119,7 +1107,7 @@ static int register_new_disk(int ctlr)
 	 if (!new_lun_found)
 	 {
 		printk(KERN_WARNING "cciss:  New Logical Volume not found\n");
-		return -1;
+		goto free_err;
 	 }
 	 /* Now find the free index 	*/
 	for(i=0; i <CISS_MAX_LUN; i++)
@@ -1140,7 +1128,7 @@ static int register_new_disk(int ctlr)
 	if (!free_index_found)
 	{
 		printk(KERN_WARNING "cciss: unable to find free slot for disk\n");
-                return -1;
+		goto free_err;
          }
 
 	logvol = free_index;
@@ -1233,11 +1221,16 @@ static int register_new_disk(int ctlr)
         disk = hba[ctlr]->gendisk[logvol];
 	set_capacity(disk, hba[ctlr]->drv[logvol].nr_blocks);
 	add_disk(disk);
-	
+freeret:
 	kfree(ld_buff);
 	kfree(size_buff);
 	kfree(inq_buff);
 	return (logvol);
+mem_msg:
+	printk(KERN_ERR "cciss: out of memory\n");
+free_err:
+	logvol = -1;
+	goto freeret;
 }
 /*
  *   Wait polling for a command to complete.

_
