Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJPVgy>; Wed, 16 Oct 2002 17:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSJPVgt>; Wed, 16 Oct 2002 17:36:49 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:17156 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261450AbSJPVg2>; Wed, 16 Oct 2002 17:36:28 -0400
Date: Wed, 16 Oct 2002 15:38:42 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 6/8] 2.5.43 cciss factor dup'ed code
Message-ID: <20021016153842.F2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out duplicated read capacity code into common routine

diff -urN linux-2.5.43-e/drivers/block/cciss.c linux-2.5.43-f/drivers/block/cciss.c
--- linux-2.5.43-e/drivers/block/cciss.c	Wed Oct 16 08:24:19 2002
+++ linux-2.5.43-f/drivers/block/cciss.c	Wed Oct 16 08:26:16 2002
@@ -113,6 +113,9 @@
 
 static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c);
 static void start_io( ctlr_info_t *h);
+static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
+	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
+	unsigned char *scsi3addr);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -1004,6 +1007,30 @@
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
@@ -1150,38 +1177,8 @@
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
@@ -2185,39 +2182,8 @@
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
