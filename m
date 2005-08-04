Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVHDEsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVHDEsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVHDEqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:46:54 -0400
Received: from bgerelbas01.asiapac.hp.net ([15.219.201.134]:63874 "EHLO
	bgerelbas01.ind.hp.com") by vger.kernel.org with ESMTP
	id S261793AbVHDEph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:45:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2/3] cpqarray: ioctl support to configure LUNs dynamically
Date: Thu, 4 Aug 2005 10:15:29 +0530
Message-ID: <4221C1B21C20854291E185D1243EA8F302623BD9@bgeexc04.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] cpqarray: ioctl support to configure LUNs dynamically
Thread-Index: AcWYr1b8CzzDHhn1Ske1Utlp4MbZjA==
From: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 04 Aug 2005 04:45:30.0281 (UTC) FILETIME=[57643190:01C598AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 3
This patch adds support for IDAREGNEWDISK, IDADEREGDISK, IDAGETLOGINFO
ioctls required
to configure LUNs dynamically on SA4200 controller using ACU.

Please consider this for inclusion.

Signed-off-by: Ramanamurthy Saripalli <saripalli@hp.com>

 cpqarray.c  |  281
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 cpqarray.h  |    1 
 ida_ioctl.h |   10 ++
 3 files changed, 286 insertions(+), 6 deletions(-)
------------------------------------------------------------------------
------
diff -burpN old/drivers/block/cpqarray.c new2/drivers/block/cpqarray.c
--- old/drivers/block/cpqarray.c	2005-06-28 23:26:06.000000000
-0400
+++ new2/drivers/block/cpqarray.c	2005-06-28 23:42:22.000000000
-0400
@@ -45,13 +45,13 @@
 
 #define SMART2_DRIVER_VERSION(maj,min,submin)
((maj<<16)|(min<<8)|(submin))
 
-#define DRIVER_NAME "Compaq SMART2 Driver (v 2.6.0)"
-#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,6,0)
+#define DRIVER_NAME "Compaq SMART2 Driver (v 2.6.1)"
+#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,6,1)
 
 /* Embedded module documentation macros - see modules.h */
 /* Original author Chris Frantz - Compaq Computer Corporation */
 MODULE_AUTHOR("Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.6.0");
+MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.6.1");
 MODULE_LICENSE("GPL");
 
 #include "cpqarray.h"
@@ -143,6 +143,8 @@ static int pollcomplete(int ctlr);
 static void getgeometry(int ctlr);
 static void start_fwbk(int ctlr);
 
+static int register_new_disk(ctlr_info_t *h, int logovl);
+static int deregister_disk(struct gendisk *disk);
 static cmdlist_t * cmd_alloc(ctlr_info_t *h, int get_from_pool);
 static void cmd_free(ctlr_info_t *h, cmdlist_t *c, int got_from_pool);
 
@@ -157,6 +159,14 @@ static int sendcmd(
 	unsigned int blk,
 	unsigned int blkcnt,
 	unsigned int log_unit );
+static int sendcmd_withirq(
+        __u8    cmd,
+        int     ctlr,
+        void    *buff,
+        size_t  size,
+        unsigned int blk,
+        unsigned int blkcnt,
+        unsigned int log_unit );
 
 static int ida_open(struct inode *inode, struct file *filep);
 static int ida_release(struct inode *inode, struct file *filep);
@@ -354,7 +364,10 @@ static void __devexit cpqarray_remove_on
 	kfree(hba[i]->cmd_pool_bits);
 	for(j = 0; j < NWD; j++) {
 		if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
+		{
 			del_gendisk(ida_gendisk[i][j]);
+		}
+
 		devfs_remove("ida/c%dd%d",i,j);
 		put_disk(ida_gendisk[i][j]);
 	}
@@ -1141,8 +1154,11 @@ static int ida_ioctl(struct inode *inode
 {
 	drv_info_t *drv = get_drv(inode->i_bdev->bd_disk);
 	ctlr_info_t *host = get_host(inode->i_bdev->bd_disk);
+	struct gendisk *disk = inode->i_bdev->bd_disk;
 	int error;
 	int diskinfo[4];
+        int ctlr = MAJOR(inode->i_rdev) - COMPAQ_SMART2_MAJOR;
+        int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
 	struct hd_geometry __user *geo = (struct hd_geometry __user
*)arg;
 	ida_ioctl_t __user *io = (ida_ioctl_t __user *)arg;
 	ida_ioctl_t *my_io;
@@ -1212,15 +1228,268 @@ out_passthru:
 				return -EFAULT;
 		return(0);
 	}	
+	case IDADEREGDISK:	
+                return( deregister_disk(disk));
+        case IDAREGNEWDISK:
+        {
+                int logvol = arg;
+                return register_new_disk(host, logvol);
+        }
 
+        case IDAGETLOGINFO:
+	{
+		idaLogvolInfo_struct luninfo;
+
+                luninfo.LogVolID = dsk; 
+                luninfo.num_opens = hba[ctlr]->drv[dsk].usage_count;
+         
+                /* count partitions 1 to 15 with sizes > 0 */
+                /*start = (dsk << NWD_SHIFT);
+                for(i=1; i <IDA_MAX_PART; i++) {
+                        int minor = start+i;
+                        if(hba[ctlr]->sizes[minor] != 0)
+                                num_parts++;
+                }
+                luninfo.num_parts = num_parts;*/
+                if (copy_to_user((void *) arg, &luninfo,
+                        sizeof( idaLogvolInfo_struct) ))
+                                return -EFAULT;
+                return(0);
+	}
 	default:
+                printk(KERN_WARNING "cpqarray: calling default
ioctl\n");
 		return -EINVAL;
 	}
 		
 }
-/*
- * ida_ctlr_ioctl is for passing commands to the controller from
userspace.
- * The command block (io) has already been copied to kernel space for
us,
+
+static int sendcmd_withirq(
+        __u8    cmd,
+        int     ctlr,
+        void    *buff,
+        size_t  size,
+        unsigned int blk,
+        unsigned int blkcnt,
+        unsigned int log_unit )
+{
+        cmdlist_t *c;
+        unsigned long flags;
+        ctlr_info_t *info_p = hba[ctlr];
+        //DECLARE_COMPLETION(wait);
+
+
+        c = cmd_alloc(info_p, 0);
+        if(!c)
+                return IO_ERROR;
+
+        c->type = CMD_IOCTL_PEND;
+        c->ctlr = ctlr;
+        c->hdr.unit = log_unit;
+        c->hdr.prio = 0;
+        c->hdr.size = sizeof(rblk_t) >> 2;
+        c->size += sizeof(rblk_t);
+
+        /* The request information. */
+        c->req.hdr.next = 0;
+        c->req.hdr.rcode = 0;
+        c->req.bp = 0;
+        c->req.hdr.sg_cnt = 1;
+        c->req.hdr.reserved = 0;
+
+
+        if (size == 0)
+                c->req.sg[0].size = 512;
+        else
+                c->req.sg[0].size = size;
+
+        c->req.hdr.blk = blk;
+        c->req.hdr.blk_cnt = blkcnt;
+        c->req.hdr.cmd = (unsigned char) cmd;
+        c->req.sg[0].addr = (__u32) pci_map_single(info_p->pci_dev,
+                buff, c->req.sg[0].size, PCI_DMA_BIDIRECTIONAL);
+
+        /* Put the request on the tail of the request queue */
+	spin_lock_irqsave(IDA_LOCK(ctlr), flags);
+        addQ(&info_p->reqQ, c);
+        info_p->Qdepth++;
+        start_io(info_p);
+        spin_unlock_irqrestore(IDA_LOCK(ctlr), flags);
+
+	/* Wait for completion */
+	while(c->type != CMD_IOCTL_DONE)
+		schedule();
+
+        if (c->req.hdr.rcode & RCODE_FATAL) {
+                printk(KERN_WARNING "Fatal error on ida/c%dd%d\n",
+                                c->ctlr, c->hdr.unit);
+                cmd_free(info_p, c, 0);
+                return(IO_ERROR);
+        }
+        if (c->req.hdr.rcode & RCODE_INVREQ) {
+                printk(KERN_WARNING "Invalid request on ida/c%dd%d =
(cmd=%x sect=%d cnt=%d sg=%d ret=%x)\n",
c->ctlr, c->hdr.unit, c->req.hdr.cmd,
+                                c->req.hdr.blk, c->req.hdr.blk_cnt,
+                                c->req.hdr.sg_cnt, c->req.hdr.rcode);
+                cmd_free(info_p, c, 0);
+                return(IO_ERROR);
+        }
+        cmd_free(info_p, c, 0);
+        return(IO_OK);
+}
+
+static int register_new_disk(ctlr_info_t *h, int logvol)
+{
+        struct gendisk *disk;
+	int ctlr = h->ctlr;
+        int ret_code, size;
+        sense_log_drv_stat_t *id_lstatus_buf;
+        id_log_drv_t *id_ldrive;
+        drv_info_t *drv;
+
+        if (!capable(CAP_SYS_RAWIO))
+                return -EPERM;
+
+	if( (logvol < 0) || (logvol >= IDA_MAX_PART))
+                return -EINVAL;
+
+	        /* disk is already registered */
+        if(hba[ctlr]->drv[logvol].nr_blks != 0 && 
+           hba[ctlr]->drv[logvol].cylinders != 0 &&
+           hba[ctlr]->drv[logvol].blk_size  != 0  )
+        {
+                printk("disk already registered:%d\n", logvol);
+                return -EINVAL;
+        }
+
+        id_ldrive = (id_log_drv_t *)kmalloc(sizeof(id_log_drv_t),
GFP_KERNEL);
+        if(id_ldrive == NULL) {
+                printk( KERN_ERR "cpqarray:  out of memory.\n");
+                return -1;
+        }
+        id_lstatus_buf = (sense_log_drv_stat_t
*)kmalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
+        if(id_lstatus_buf == NULL) {
+                kfree(id_ldrive);
+                printk( KERN_ERR "cpqarray:  out of memory.\n");
+                return -1;
+        }
+        size = sizeof(sense_log_drv_stat_t);
+
+        /*
+                Send "Identify logical drive status" cmd
+         */
+        ret_code = sendcmd_withirq(SENSE_LOG_DRV_STAT,
+                ctlr, id_lstatus_buf, size, 0, 0, logvol);
+        if (ret_code == IO_ERROR) {
+                        /*
+                           If can't get logical drive status, set
+                           the logical drive map to 0, so the
+                           idastubopen will fail for all logical drives
+                           on the controller. 
+                         */
+                        /* Free all the buffers and return */
+
+                kfree(id_lstatus_buf);
+                kfree(id_ldrive);
+                return -1;
+        }
+
+        /*
+                   Make sure the logical drive is configured
+         */
+        if (id_lstatus_buf->status == LOG_NOT_CONF) {
+                printk(KERN_WARNING "cpqarray: c%dd%d array not
configured\n",
+                        ctlr, logvol);
+                kfree(id_lstatus_buf);
+                kfree(id_ldrive);
+                return -1;
+        }
+
+        ret_code = sendcmd_withirq(ID_LOG_DRV, ctlr, id_ldrive,
+                               sizeof(id_log_drv_t), 0, 0, logvol);
+                        /*
+                           If error, the bit for this
+  			   logical drive won't be set and
+                           idastubopen will return error. 
+                         */
+        if (ret_code == IO_ERROR) {
+                printk(KERN_WARNING "cpqarray: c%dd%d unable to ID
logical volume\n",
+                        ctlr,logvol);
+                kfree(id_lstatus_buf);
+                kfree(id_ldrive);
+                return -1;
+        }
+
+        drv = &h->drv[logvol];
+        drv->blk_size = id_ldrive->blk_size;
+        drv->nr_blks = id_ldrive->nr_blks;
+        drv->cylinders = id_ldrive->drv.cyl;
+        drv->heads = id_ldrive->drv.heads;
+        drv->sectors = id_ldrive->drv.sect_per_track;
+        h->log_drv_map |=  (1 << logvol);
+
+        printk("cpqarray ida/c%dd%d: blksz=%d nr_blks=%d,
usage_cnt:%d\n",
+                ctlr, logvol, drv->blk_size, drv->nr_blks,
hba[ctlr]->drv[logvol].usage_count);
+
+        //hba[ctlr]->drv[logvol].usage_count = 0;
+        ++hba[ctlr]->log_drives;
+	
+	/* setup partitions per disk */
+        disk = ida_gendisk[ctlr][logvol];
+
+	blk_queue_hardsect_size(hba[ctlr]->queue, drv->blk_size);
+        set_capacity(disk, h->drv[logvol].nr_blks);
+	disk->queue = hba[ctlr]->queue;
+	disk->private_data = drv;
+
+        /* if it's the controller it's already added */
+        if(logvol)
+                add_disk(disk);
+
+
+        kfree(id_lstatus_buf);
+        kfree(id_ldrive);
+
+        return (0);
+}
+
+
+static int deregister_disk(struct gendisk *disk)
+{
+        unsigned long flags;
+	ctlr_info_t *h = get_host(disk);
+	drv_info_t *drv = get_drv(disk);
+	int ctlr = h->ctlr;
+	int logvol = disk->first_minor >> NWD_SHIFT;
+
+
+        if (!capable(CAP_SYS_RAWIO))
+                return -EPERM;
+
+	spin_lock_irqsave(IDA_LOCK(ctlr), flags);
+        /* make sure logical volume is NOT is use */
+        if( drv->usage_count > 1) {
+                spin_unlock_irqrestore(IDA_LOCK(ctlr), flags);
+                return -EBUSY;
+        }
+        spin_unlock_irqrestore(IDA_LOCK(ctlr), flags);
+
+	/* invalidate the devices and deregister the disk */ 	
+	if (disk->flags & GENHD_FL_UP) {
+		printk("Before delete gendisk deregister ctlr:%d,
log:%d\n", ctlr,logvol);
+		del_gendisk(disk);
+	}
+
+        --h->log_drives;
+
+        /* zero out the disk size info */
+        drv->nr_blks = 0;
+        drv->cylinders = 0;
+        drv->blk_size = 0;
+        return(0);
+}
+
+

+
+/** The command block (io) has already been copied to kernel space for
us,
  * however, any elements in the sglist need to be copied to kernel
space
  * or copied back to userspace.
  *
diff -burpN old/drivers/block/cpqarray.h new2/drivers/block/cpqarray.h
--- old/drivers/block/cpqarray.h	2005-06-28 23:26:14.000000000
-0400
+++ new2/drivers/block/cpqarray.h	2005-06-28 23:42:22.000000000
-0400
@@ -38,6 +38,7 @@
 #define IO_ERROR	1
 #define NWD		16
 #define NWD_SHIFT	4
+#define  IDA_MAX_PART   16
 
 #define IDA_TIMER	(5*HZ)
 #define IDA_TIMEOUT	(10*HZ)
diff -burpN old/drivers/block/ida_ioctl.h new2/drivers/block/ida_ioctl.h
--- old/drivers/block/ida_ioctl.h	2005-06-28 23:26:23.000000000
-0400
+++ new2/drivers/block/ida_ioctl.h	2005-06-28 23:42:22.000000000
-0400
@@ -31,6 +31,9 @@
 #define IDAREVALIDATEVOLS	0x30303131
 #define IDADRIVERVERSION	0x31313232
 #define IDAGETPCIINFO		0x32323333
+#define IDADEREGDISK            0x33333434
+#define IDAREGNEWDISK           0x34343535
+#define IDAGETLOGINFO           0x35353636
 
 typedef struct _ida_pci_info_struct
 {
@@ -38,6 +41,13 @@ typedef struct _ida_pci_info_struct
 	unsigned char 	dev_fn;
 	__u32 		board_id;
 } ida_pci_info_struct;
+
+typedef struct _idaLogvolInfo_struct{
+	int             LogVolID;
+	int             num_opens;  /* number of opens on the logical
volume */
+	int             num_parts;  /* number of partitions configured
on logvol */
+} idaLogvolInfo_struct;
+
 /*
  * Normally, the ioctl determines the logical unit for this command by
  * the major,minor number of the fd passed to ioctl.  If you need to
send
