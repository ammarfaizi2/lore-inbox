Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTBLTOm>; Wed, 12 Feb 2003 14:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbTBLTOm>; Wed, 12 Feb 2003 14:14:42 -0500
Received: from mailin.zma.compaq.com ([161.114.64.102]:47878 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267729AbTBLTNR>; Wed, 12 Feb 2003 14:13:17 -0500
Date: Wed, 12 Feb 2003 13:23:44 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212072344.GJ1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out duplicated read capacity code into common routine in cciss driver.
(patch 10 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~factor_duped_code	2003-02-12 10:13:18.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:13:18.000000000 +0600
@@ -114,6 +114,9 @@ static void cciss_getgeometry(int cntl_n
 
 static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c);
 static void start_io( ctlr_info_t *h);
+static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
+	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
+	unsigned char *scsi3addr);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -1003,6 +1006,30 @@ case CMD_HARDWARE_ERR:
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
@@ -1137,38 +1164,8 @@ static int register_new_disk(int ctlr)
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
-	printk(KERN_INFO "      blocks= %u block_size= %d\n", 
-					total_size, block_size);
+	cciss_read_capacity(ctlr, logvol, size_buff, 1,
+		&total_size, &block_size);
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
 	return_code = sendcmd_withirq(CISS_INQUIRY, ctlr, inq_buff,
@@ -2169,39 +2166,8 @@ static void cciss_getgeometry(int cntl_n
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

_
