Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSJPViy>; Wed, 16 Oct 2002 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJPVhi>; Wed, 16 Oct 2002 17:37:38 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:36873 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S261450AbSJPVhL>; Wed, 16 Oct 2002 17:37:11 -0400
Date: Wed, 16 Oct 2002 15:39:24 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 7/8] 2.5.43 cciss factor more dup'ed code
Message-ID: <20021016153924.G2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


factor duplicated geometry inquiry code into common routine

diff -urN linux-2.5.43-f/drivers/block/cciss.c linux-2.5.43-g/drivers/block/cciss.c
--- linux-2.5.43-f/drivers/block/cciss.c	Wed Oct 16 08:26:16 2002
+++ linux-2.5.43-g/drivers/block/cciss.c	Wed Oct 16 08:28:37 2002
@@ -1007,6 +1007,49 @@
         return(return_status);
 
 }
+static void cciss_geometry_inquiry(int ctlr, int logvol,
+			int withirq, unsigned int total_size,
+			unsigned int block_size, InquiryData_struct *inq_buff,
+			drive_info_struct *drv)
+{
+	int return_code;
+	memset(inq_buff, 0, sizeof(InquiryData_struct));
+	if (withirq)
+		return_code = sendcmd_withirq(CISS_INQUIRY, ctlr,
+			inq_buff, sizeof(*inq_buff), 1, logvol ,0xC1);
+	else
+		return_code = sendcmd(CISS_INQUIRY, ctlr, inq_buff,
+			sizeof(*inq_buff), 1, logvol ,0xC1, NULL);
+	if (return_code == IO_OK) {
+		if(inq_buff->data_byte[8] == 0xFF) {
+			printk(KERN_WARNING
+				"cciss: reading geometry failed, volume "
+				"does not support reading geometry\n");
+			drv->block_size = block_size;
+			drv->nr_blocks = total_size;
+			drv->heads = 255;
+			drv->sectors = 32; // Sectors per track
+			drv->cylinders = total_size / 255 / 32;
+		} else {
+			drv->block_size = block_size;
+			drv->nr_blocks = total_size;
+			drv->heads = inq_buff->data_byte[6];
+			drv->sectors = inq_buff->data_byte[7];
+			drv->cylinders = (inq_buff->data_byte[4] & 0xff) << 8;
+			drv->cylinders += inq_buff->data_byte[5];
+		}
+	} else { /* Get geometry failed */
+		printk(KERN_WARNING "cciss: reading geometry failed, "
+			"continuing with default geometry\n");
+		drv->block_size = block_size;
+		drv->nr_blocks = total_size;
+		drv->heads = 255;
+		drv->sectors = 32; // Sectors per track
+		drv->cylinders = total_size / 255 / 32;
+	}
+	printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
+		drv->heads, drv->sectors, drv->cylinders);
+}
 static void
 cciss_read_capacity(int ctlr, int logvol, ReadCapdata_struct *buf,
 		int withirq, unsigned int *total_size, unsigned int *block_size)
@@ -1179,53 +1222,8 @@
 		hba[ctlr]->highest_lun = logvol;
 	cciss_read_capacity(ctlr, logvol, size_buff, 1,
 		&total_size, &block_size);
-	/* Execute the command to read the disk geometry */
-	memset(inq_buff, 0, sizeof(InquiryData_struct));
-	return_code = sendcmd_withirq(CISS_INQUIRY, ctlr, inq_buff,
-                	sizeof(InquiryData_struct), 1, logvol ,0xC1 );
-	if (return_code == IO_OK)
-		{
-			if(inq_buff->data_byte[8] == 0xFF)
-			{
-			   printk(KERN_WARNING "cciss: reading geometry failed, "
-				"volume does not support reading geometry\n");
-
-                           hba[ctlr]->drv[logvol].block_size = block_size;
-                           hba[ctlr]->drv[logvol].nr_blocks = total_size;
-                           hba[ctlr]->drv[logvol].heads = 255;
-                           hba[ctlr]->drv[logvol].sectors = 32; // Sectors per track
-                           hba[ctlr]->drv[logvol].cylinders = total_size / 255 / 32;
-                	} else
-			{
-
-		 	   hba[ctlr]->drv[logvol].block_size = block_size;
-                           hba[ctlr]->drv[logvol].nr_blocks = total_size;
-                           hba[ctlr]->drv[logvol].heads = 
-					inq_buff->data_byte[6]; 
-                           hba[ctlr]->drv[logvol].sectors = 
-					inq_buff->data_byte[7]; 
-			   hba[ctlr]->drv[logvol].cylinders = 
-					(inq_buff->data_byte[4] & 0xff) << 8;
-			   hba[ctlr]->drv[logvol].cylinders += 
-                                        inq_buff->data_byte[5];
-			}
-		}
-		else /* Get geometry failed */
-		{
-
-			printk(KERN_WARNING "cciss: reading geometry failed, "
-				"continuing with default geometry\n"); 
-
-			hba[ctlr]->drv[logvol].block_size = block_size;
-			hba[ctlr]->drv[logvol].nr_blocks = total_size;
-			hba[ctlr]->drv[logvol].heads = 255;
-			hba[ctlr]->drv[logvol].sectors = 32; // Sectors per track 
-			hba[ctlr]->drv[logvol].cylinders = total_size / 255 / 32;
-		}
-		printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
-			hba[ctlr]->drv[logvol].heads, 
-			hba[ctlr]->drv[logvol].sectors,
-			hba[ctlr]->drv[logvol].cylinders);
+	cciss_geometry_inquiry(ctlr, logvol, 1, total_size, block_size,
+			inq_buff, &hba[ctlr]->drv[logvol]);
 	hba[ctlr]->drv[logvol].usage_count = 0;
 	++hba[ctlr]->num_luns;
 	/* setup partitions per disk */
@@ -2184,50 +2182,8 @@
 #endif /* CCISS_DEBUG */
 		cciss_read_capacity(cntl_num, i, size_buff, 0,
 			&total_size, &block_size);
-		/* Execute the command to read the disk geometry */
-		memset(inq_buff, 0, sizeof(InquiryData_struct));
-		return_code = sendcmd(CISS_INQUIRY, cntl_num, inq_buff,
-                	sizeof(InquiryData_struct), 1, i ,0xC1, NULL );
-	  	if (return_code == IO_OK)
-		{
-			if(inq_buff->data_byte[8] == 0xFF)
-			{
-			   printk(KERN_WARNING "cciss: reading geometry failed, volume does not support reading geometry\n");
-
-                           hba[cntl_num]->drv[i].block_size = block_size;
-                           hba[cntl_num]->drv[i].nr_blocks = total_size;
-                           hba[cntl_num]->drv[i].heads = 255;
-                           hba[cntl_num]->drv[i].sectors = 32; // Sectors per track
-                           hba[cntl_num]->drv[i].cylinders = total_size / 255 / 32;                	} else
-			{
-
-		 	   hba[cntl_num]->drv[i].block_size = block_size;
-                           hba[cntl_num]->drv[i].nr_blocks = total_size;
-                           hba[cntl_num]->drv[i].heads = 
-					inq_buff->data_byte[6]; 
-                           hba[cntl_num]->drv[i].sectors = 
-					inq_buff->data_byte[7]; 
-			   hba[cntl_num]->drv[i].cylinders = 
-					(inq_buff->data_byte[4] & 0xff) << 8;
-			   hba[cntl_num]->drv[i].cylinders += 
-                                        inq_buff->data_byte[5];
-			}
-		}
-		else /* Get geometry failed */
-		{
-			printk(KERN_WARNING "cciss: reading geometry failed, continuing with default geometry\n"); 
-
-			hba[cntl_num]->drv[i].block_size = block_size;
-			hba[cntl_num]->drv[i].nr_blocks = total_size;
-			hba[cntl_num]->drv[i].heads = 255;
-			hba[cntl_num]->drv[i].sectors = 32; // Sectors per track 
-			hba[cntl_num]->drv[i].cylinders = total_size / 255 / 32;
-		}
-		printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
-			hba[cntl_num]->drv[i].heads, 
-			hba[cntl_num]->drv[i].sectors,
-			hba[cntl_num]->drv[i].cylinders);
-
+		cciss_geometry_inquiry(cntl_num, i, 0, total_size, block_size,
+			inq_buff, &hba[cntl_num]->drv[i]);
 	}
 	kfree(ld_buff);
 	kfree(size_buff);
