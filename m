Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSJIOgs>; Wed, 9 Oct 2002 10:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSJIOgs>; Wed, 9 Oct 2002 10:36:48 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:53778 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S261786AbSJIOgo>; Wed, 9 Oct 2002 10:36:44 -0400
Date: Wed, 9 Oct 2002 08:38:28 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss, factor dup'ed code (4 of 5)
Message-ID: <20021009083828.D6746@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch factors out duplicated code for doing a READ_CAPACITY
into a common function.  Applies to 2.5.41
 cciss.c |   98 ++++++++++++++++++++--------------------------------------------
 1 files changed, 32 insertions, 66 deletions -- steve

diff -urN linux-2.5.41-a-scsi/drivers/block/cciss.c linux-2.5.41-b-factor/drivers/block/cciss.c
--- linux-2.5.41-a-scsi/drivers/block/cciss.c	Mon Oct  7 14:59:31 2002
+++ linux-2.5.41-b-factor/drivers/block/cciss.c	Tue Oct  8 08:48:00 2002
@@ -113,6 +113,9 @@
 
 static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c);
 static void start_io( ctlr_info_t *h);
+static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
+	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
+	unsigned char *scsi3addr);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -1003,6 +1006,30 @@
         return(return_status);
 
 }
+static void 
+cciss_read_capacity(int ctlr, int logvol, ReadCapdata_struct *buf,
+		int withirq, unsigned int *total_size, unsigned int *block_size)
+{
+	int return_code;
+	memset(buf, 0, sizeof(*buf));
+	if (withirq)
+		return_code = sendcmd_withirq(CCISS_READ_CAPACITY, 
+			ctlr, buf, sizeof(*buf), 1, logvol, 0 );
+	else
+		return_code = sendcmd(CCISS_READ_CAPACITY, 
+			ctlr, buf, sizeof(*buf), 1, logvol, 0, NULL );
+	if (return_code == IO_OK) {
+		*total_size = be32_to_cpu(*((__u32 *) &buf->total_size[0]))+1;
+		*block_size = be32_to_cpu(*((__u32 *) &buf->block_size[0]));
+	} else { /* read capacity command failed */ 
+		printk(KERN_WARNING "cciss: read capacity failed\n");
+		*total_size = 0;
+		*block_size = BLOCK_SIZE;
+	}
+	printk(KERN_INFO "      blocks= %d block_size= %d\n", 
+		*total_size, *block_size);
+	return;
+}
 static int register_new_disk(int ctlr)
 {
         struct gendisk *disk;
@@ -1149,38 +1176,8 @@
 		/* there could be gaps in lun numbers, track hightest */
 	if(hba[ctlr]->highest_lun < lunid)
 		hba[ctlr]->highest_lun = logvol;
-		
-	memset(size_buff, 0, sizeof(ReadCapdata_struct));
-	return_code = sendcmd_withirq(CCISS_READ_CAPACITY, ctlr, size_buff,
-		sizeof( ReadCapdata_struct), 1, logvol, 0 );
-	if (return_code == IO_OK)
-	{
-		total_size = (0xff & 
-			(unsigned int)(size_buff->total_size[0])) << 24;
-		total_size |= (0xff & 
-				(unsigned int)(size_buff->total_size[1])) << 16;
-		total_size |= (0xff & 
-				(unsigned int)(size_buff->total_size[2])) << 8;
-		total_size |= (0xff & (unsigned int)
-				(size_buff->total_size[3])); 
-		total_size++; // command returns highest block address
-
-		block_size = (0xff & 
-				(unsigned int)(size_buff->block_size[0])) << 24;
-               	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[1])) << 16;
-               	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[2])) << 8;
-               	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[3]));
-	} else /* read capacity command failed */ 
-	{
-			printk(KERN_WARNING "cciss: read capacity failed\n");
-			total_size = 0;
-			block_size = BLOCK_SIZE;
-	}	
-	printk(KERN_INFO "      blocks= %d block_size= %d\n", 
-					total_size, block_size);
+	cciss_read_capacity(ctlr, logvol, size_buff, 1,
+		&total_size, &block_size);
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
 	return_code = sendcmd_withirq(CISS_INQUIRY, ctlr, inq_buff,
@@ -2184,39 +2181,8 @@
 		ld_buff->LUN[i][0], ld_buff->LUN[i][1],ld_buff->LUN[i][2], 
 		ld_buff->LUN[i][3], hba[cntl_num]->drv[i].LunID);
 #endif /* CCISS_DEBUG */
-
-	  	memset(size_buff, 0, sizeof(ReadCapdata_struct));
-	  	return_code = sendcmd(CCISS_READ_CAPACITY, cntl_num, size_buff, 
-				sizeof( ReadCapdata_struct), 1, i, 0, NULL );
-	  	if (return_code == IO_OK)
-		{
-			total_size = (0xff & 
-				(unsigned int)(size_buff->total_size[0])) << 24;
-			total_size |= (0xff & 
-				(unsigned int)(size_buff->total_size[1])) << 16;
-			total_size |= (0xff & 
-				(unsigned int)(size_buff->total_size[2])) << 8;
-			total_size |= (0xff & (unsigned int)
-				(size_buff->total_size[3])); 
-			total_size++; // command returns highest block address
-
-			block_size = (0xff & 
-				(unsigned int)(size_buff->block_size[0])) << 24;
-                	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[1])) << 16;
-                	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[2])) << 8;
-                	block_size |= (0xff & 
-				(unsigned int)(size_buff->block_size[3]));
-		} else /* read capacity command failed */ 
-		{
-			printk(KERN_WARNING "cciss: read capacity failed\n");
-			total_size = 0;
-			block_size = BLOCK_SIZE;
-		}	
-		printk(KERN_INFO "      blocks= %d block_size= %d\n", 
-					total_size, block_size);
-
+		cciss_read_capacity(cntl_num, i, size_buff, 0,
+			&total_size, &block_size);
 		/* Execute the command to read the disk geometry */
 		memset(inq_buff, 0, sizeof(InquiryData_struct));
 		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
