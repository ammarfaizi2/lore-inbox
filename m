Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTB0UXc>; Thu, 27 Feb 2003 15:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTB0UXc>; Thu, 27 Feb 2003 15:23:32 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:62223 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S266953AbTB0UXa>; Thu, 27 Feb 2003 15:23:30 -0500
Date: Thu, 27 Feb 2003 14:36:22 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 cciss fix unlikely startup problem
Message-ID: <20030227083622.GA3704@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another cciss patch for 2.5.63

Add CCISS_GETLUNINFO ioctl.

This ioctl returns the LUNID, number of partitions, and current 
number of opens on a logical volume.   Used by the array config utility
or any app that needs to send passthrough commands to a particular 
logical disk.

-- steve

--- linux-2.5.63/drivers/block/cciss.c~getluninfo_ioctl	2003-02-27 14:11:51.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss.c	2003-02-27 14:11:51.000000000 +0600
@@ -589,6 +589,24 @@ static int cciss_ioctl(struct inode *ino
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
 
--- linux-2.5.63/include/linux/cciss_ioctl.h~getluninfo_ioctl	2003-02-27 14:11:51.000000000 +0600
+++ linux-2.5.63-scameron/include/linux/cciss_ioctl.h	2003-02-27 14:11:51.000000000 +0600
@@ -169,6 +169,11 @@ typedef struct _IOCTL_Command_struct {
   BYTE			   *buf;
 } IOCTL_Command_struct;
 
+typedef struct _LogvolInfo_struct{
+	__u32	LunID;
+	int	num_opens;  /* number of opens on the logical volume */
+	int	num_parts;  /* number of partitions configured on logvol */
+} LogvolInfo_struct;
 
 #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
 
@@ -190,5 +195,6 @@ typedef struct _IOCTL_Command_struct {
 #define CCISS_REGNEWDISK  _IOW(CCISS_IOC_MAGIC, 13, int)
 
 #define CCISS_REGNEWD	   _IO(CCISS_IOC_MAGIC, 14)
+#define CCISS_GETLUNINFO   _IOR(CCISS_IOC_MAGIC, 17, LogvolInfo_struct)
 
 #endif  

_
