Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbSJQTh2>; Thu, 17 Oct 2002 15:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbSJQTh2>; Thu, 17 Oct 2002 15:37:28 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:41998 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S262079AbSJQTh0>; Thu, 17 Oct 2002 15:37:26 -0400
Date: Thu, 17 Oct 2002 13:39:38 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.43 cciss add GETLUNINFO ioctl
Message-ID: <20021017133938.A1285@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds CCISS_GETLUNINFO ioctl (used by online array config util for instance)
Applies to 2.5.43 after previous 8 cciss patches sent oct 16th 2002.
-- steve

diff -urN linux-2.5.43-h/drivers/block/cciss.c linux-2.5.43-i/drivers/block/cciss.c
--- linux-2.5.43-h/drivers/block/cciss.c	Wed Oct 16 08:30:54 2002
+++ linux-2.5.43-i/drivers/block/cciss.c	Thu Oct 17 13:20:30 2002
@@ -574,6 +574,24 @@
 	case CCISS_REVALIDVOLS:
                 return( revalidate_allvol(inode->i_rdev));
 
+ 	case CCISS_GETLUNINFO: {
+ 		LogvolInfo_struct luninfo;
+ 		struct gendisk *disk = hba[ctlr]->gendisk[dsk];
+ 		drive_info_struct *drv = &hba[ctlr]->drv[dsk];
+ 		int i;
+ 		
+ 		luninfo.LunID = drv->LunID;
+ 		luninfo.num_opens = drv->usage_count;
+ 		luninfo.num_parts = 0;
+ 		/* count partitions 1 to 15 with sizes > 0 */
+ 		for(i=1; i <MAX_PART; i++)
+ 			if (disk->part[i].nr_sects != 0)
+ 				luninfo.num_parts++;
+ 		if (copy_to_user((void *) arg, &luninfo,
+ 				sizeof(LogvolInfo_struct)))
+ 			return -EFAULT;
+ 		return(0);
+ 	}
 	case CCISS_DEREGDISK:
 		return( deregister_disk(ctlr,dsk));
 
diff -urN linux-2.5.43-h/include/linux/cciss_ioctl.h linux-2.5.43-i/include/linux/cciss_ioctl.h
--- linux-2.5.43-h/include/linux/cciss_ioctl.h	Fri Sep 27 16:49:49 2002
+++ linux-2.5.43-i/include/linux/cciss_ioctl.h	Thu Oct 17 13:21:16 2002
@@ -169,6 +169,11 @@
   BYTE			   *buf;
 } IOCTL_Command_struct;
 
+typedef struct _LogvolInfo_struct{
+	__u32	LunID;
+	int	num_opens;  /* number of opens on the logical volume */
+	int	num_parts;  /* number of partitions configured on logvol */
+} LogvolInfo_struct;
 
 #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
 
@@ -190,5 +195,6 @@
 #define CCISS_REGNEWDISK  _IOW(CCISS_IOC_MAGIC, 13, int)
 
 #define CCISS_REGNEWD	   _IO(CCISS_IOC_MAGIC, 14)
+#define CCISS_GETLUNINFO   _IOR(CCISS_IOC_MAGIC, 17, LogvolInfo_struct)
 
 #endif  
