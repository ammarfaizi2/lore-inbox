Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265062AbSJWPd4>; Wed, 23 Oct 2002 11:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265057AbSJWPdR>; Wed, 23 Oct 2002 11:33:17 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:49673 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265058AbSJWPcc>; Wed, 23 Oct 2002 11:32:32 -0400
Date: Wed, 23 Oct 2002 09:34:53 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/10] 2.5.44 cciss add getluninfo ioctl
Message-ID: <20021023093453.I14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 9 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

This ioctl returns the LUNID, number of partitions, and current 
number of opens on a logical volume.   Used by the array config utility
or any app that needs to send passthrough commands to a particular 
logical disk.


 drivers/block/cciss.c       |   18 ++++++++++++++++++
 include/linux/cciss_ioctl.h |    6 ++++++
 2 files changed, 24 insertions

--- linux-2.5.44/drivers/block/cciss.c~getluninfo_ioctl	Mon Oct 21 13:44:37 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Tue Oct 22 13:22:15 2002
@@ -574,6 +574,24 @@ static int cciss_ioctl(struct inode *ino
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
 
--- linux-2.5.44/include/linux/cciss_ioctl.h~getluninfo_ioctl	Mon Oct 21 13:44:37 2002
+++ linux-2.5.44-root/include/linux/cciss_ioctl.h	Mon Oct 21 13:44:37 2002
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

.
