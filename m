Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSJIOpP>; Wed, 9 Oct 2002 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbSJIOpP>; Wed, 9 Oct 2002 10:45:15 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:19972 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261762AbSJIOpM>; Wed, 9 Oct 2002 10:45:12 -0400
Date: Wed, 9 Oct 2002 08:46:59 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss, add rescan disk ioctl (6 of 5 :-)
Message-ID: <20021009084659.A8912@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the CCISS_RESCANDISK ioctl which is meant to be used in a 
configuration like Steeleye's Lifekeeper.  Two hosts connect to the storage, 
one reserves disks.  The 2nd will not be able to read the partition 
information because of the reservations.  In the event the 1st system fails, 
the 2nd can detect this, (via special hardware + software typically) and then 
take over the storage and rescan he disks via this ioctl.
Applies to 2.5.41 (after applying my prior 4 patches to 2.5.4[01] )

(yes, this is patch 6 of 5, I can't seem to count this morning.
This will be the last one from me for today, I expect.) 

-- steve

diff -urN linux-2.5.41-c-factor2/drivers/block/cciss.c linux-2.5.41-rescan2/drivers/block/cciss.c
--- linux-2.5.41-c-factor2/drivers/block/cciss.c	Tue Oct  8 08:46:30 2002
+++ linux-2.5.41-rescan2/drivers/block/cciss.c	Tue Oct  8 15:27:58 2002
@@ -46,12 +46,12 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.5.0)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,0)
+#define DRIVER_NAME "Compaq CISS Driver (v 2.5.1)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,1)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.0");
+MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.1");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -108,6 +108,7 @@
 static int cciss_revalidate(kdev_t dev);
 static int deregister_disk(int ctlr, int logvol);
 static int register_new_disk(int cltr);
+static int cciss_rescan_disk(int cltr, int logvol);
 
 static void cciss_getgeometry(int cntl_num);
 
@@ -351,13 +352,22 @@
 		return -ENXIO;
 	/*
 	 * Root is allowed to open raw volume zero even if its not configured
-	 * so array config can still work.  I don't think I really like this,
+	 * so array config can still work.  Root is also allowed to open any
+	 * volume that has a LUN ID, so it can issue IOCTL to reread the
+	 * disk information.  I don't think I really like this,
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
 	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
-		if (minor(inode->i_rdev) != 0)
-			return -ENXIO;
+		if (minor(inode->i_rdev) != 0) {
+			/* if not node 0 make sure it is a partition = 0 */	
+			if (minor(inode->i_rdev) & 0x0f)
+				return -ENXIO;
+			/* if it is, make sure we have a LUN ID */
+			if (hba[ctlr]->drv[minor(inode->i_rdev)
+					>> NWD_SHIFT].LunID == 0)
+				return -ENXIO;
+		}
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 	}
@@ -574,6 +584,9 @@
 	case CCISS_REVALIDVOLS:
                 return( revalidate_allvol(inode->i_rdev));
 
+	case CCISS_RESCANDISK:
+		return(cciss_rescan_disk(ctlr, dsk));
+
 	case CCISS_DEREGDISK:
 		return( deregister_disk(ctlr,dsk));
 
@@ -1234,6 +1247,52 @@
 	kfree(size_buff);
 	kfree(inq_buff);
 	return (logvol);
+}
+static int cciss_rescan_disk(int ctlr, int logvol)
+{
+	/* this is meant to be used in a configuration like 
+	   Steeleye's Lifekeeper.  Two hosts connect to the storage, one 
+	   reserves disks.  The 2nd will not be able to read the partition 
+	   information because of the reservations.  In the event the 1st 
+	   system fails, the 2nd can detect this, (via special hardware +
+	   software typically) and then take over the storage and rescan 
+	   the disks via this ioctl. */
+
+	struct gendisk *disk = hba[ctlr]->gendisk[logvol];
+	ReadCapdata_struct *size_buff;
+	InquiryData_struct *inq_buff;
+	unsigned int block_size;
+	unsigned int total_size;
+	kdev_t kdev;
+	struct block_device *bdev;
+
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
+	if (hba[ctlr]->drv[logvol].nr_blocks != 0) {
+		/* disk is possibly on line, return just a warning */
+		return 1;
+	}
+	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
+	if (size_buff == NULL) {
+		printk(KERN_ERR "cciss: out of memory\n");
+		return -1;
+	}
+	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
+	if (inq_buff == NULL) {
+		printk(KERN_ERR "cciss: out of memory\n");
+		kfree(size_buff);
+		return -1;
+	}
+	cciss_read_capacity(ctlr, logvol, size_buff, 1, &total_size, 
+				&block_size);
+	cciss_geometry_inquiry(ctlr, logvol, 1, total_size, block_size,
+			inq_buff, &hba[ctlr]->drv[logvol]); 
+	kdev = mk_kdev(MAJOR_NR + ctlr, disk->first_minor);
+	bdev = bdget(kdev_t_to_nr(kdev));
+	rescan_partitions(disk, bdev);
+	kfree(size_buff);
+	kfree(inq_buff);
+	return(0);
 }
 /*
  *   Wait polling for a command to complete.
diff -urN linux-2.5.41-c-factor2/include/linux/cciss_ioctl.h linux-2.5.41-rescan2/include/linux/cciss_ioctl.h
--- linux-2.5.41-c-factor2/include/linux/cciss_ioctl.h	Fri Sep 27 16:49:49 2002
+++ linux-2.5.41-rescan2/include/linux/cciss_ioctl.h	Tue Oct  8 13:57:48 2002
@@ -185,6 +185,7 @@
 #define CCISS_REVALIDVOLS  _IO(CCISS_IOC_MAGIC, 10)
 #define CCISS_PASSTHRU	   _IOWR(CCISS_IOC_MAGIC, 11, IOCTL_Command_struct)
 #define CCISS_DEREGDISK	   _IO(CCISS_IOC_MAGIC, 12)
+#define CCISS_RESCANDISK   _IO(CCISS_IOC_MAGIC, 16)
 
 /* no longer used... use REGNEWD instead */ 
 #define CCISS_REGNEWDISK  _IOW(CCISS_IOC_MAGIC, 13, int)
