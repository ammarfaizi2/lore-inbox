Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265056AbSJWPa6>; Wed, 23 Oct 2002 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265057AbSJWPa5>; Wed, 23 Oct 2002 11:30:57 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:24847 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265056AbSJWPab>; Wed, 23 Oct 2002 11:30:31 -0400
Date: Wed, 23 Oct 2002 09:32:48 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] 2.5.44 cciss factor dup'ed code
Message-ID: <20021023093248.G14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 7 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

DESC
Factor out duplicated read capacity code into common routine


 drivers/block/cciss.c |   96 ++++++++++++++++----------------------------------
 1 files changed, 31 insertions, 65 deletions

--- linux-2.5.44/drivers/block/cciss.c~factor_duped_code	Mon Oct 21 12:06:02 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Mon Oct 21 12:06:02 2002
@@ -113,6 +113,9 @@ static void cciss_getgeometry(int cntl_n
 
 static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c);
 static void start_io( ctlr_info_t *h);
+static int sendcmd( __u8 cmd, int ctlr, void *buff, size_t size,
+	unsigned int use_unit_num, unsigned int log_unit, __u8 page_code,
+	unsigned char *scsi3addr);
 
 #ifdef CONFIG_PROC_FS
 static int cciss_proc_get_info(char *buffer, char **start, off_t offset, 
@@ -1002,6 +1005,30 @@ case CMD_HARDWARE_ERR:
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
@@ -1148,38 +1175,8 @@ static int register_new_disk(int ctlr)
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
@@ -2175,39 +2172,8 @@ static void cciss_getgeometry(int cntl_n
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

.
