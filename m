Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbTCIMqQ>; Sun, 9 Mar 2003 07:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTCIMqO>; Sun, 9 Mar 2003 07:46:14 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:55255 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262507AbTCIMpm>; Sun, 9 Mar 2003 07:45:42 -0500
Date: Sun, 9 Mar 2003 12:54:03 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fwd: struct inode size reduction.
Message-ID: <20030309135402.GB32107@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Third retry, perhaps it'll make it through to the list
now that vger is sending mail again...

--gKMricLos+KVdGMg
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sat, 8 Mar 2003 09:13:13 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: struct inode size reduction.
Message-ID: <20030308101313.GB6532@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i

I've been running with this patch, with no untoward consequences,
seems to pass basic testing here, any objections before I push
this Linuswards ? Al ? Christoph ?

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/fs.h inode/include/linux/fs.h
--- bk-linus/include/linux/fs.h	2003-03-08 08:57:57.000000000 -0100
+++ inode/include/linux/fs.h	2003-03-08 08:57:20.000000000 -0100
@@ -382,12 +382,12 @@ struct inode {
 	struct address_space	*i_mapping;
 	struct address_space	i_data;
 	struct dquot		*i_dquot[MAXQUOTAS];
-	/* These three should probably be a union */
 	struct list_head	i_devices;
-	struct pipe_inode_info	*i_pipe;
-	struct block_device	*i_bdev;
-	struct char_device	*i_cdev;
-
+	union {
+		struct pipe_inode_info	*i_pipe;
+		struct block_device	*i_bdev;
+		struct char_device	*i_cdev;
+	} type;
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/um/drivers/ubd_kern.c inode/arch/um/drivers/ubd_kern.c
--- bk-linus/arch/um/drivers/ubd_kern.c	2003-03-08 08:56:48.000000000 -0100
+++ inode/arch/um/drivers/ubd_kern.c	2003-03-08 08:56:12.000000000 -0100
@@ -737,7 +737,7 @@ device_initcall(ubd_driver_init);
 
 static int ubd_open(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct ubd *dev = disk->private_data;
 	int err = -EISDIR;
 
@@ -766,7 +766,7 @@ static int ubd_open(struct inode *inode,
 
 static int ubd_release(struct inode * inode, struct file * file)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct ubd *dev = disk->private_data;
 
 	if(--dev->count == 0)
@@ -894,7 +894,7 @@ static int ubd_ioctl(struct inode * inod
 		     unsigned int cmd, unsigned long arg)
 {
 	struct hd_geometry *loc = (struct hd_geometry *) arg;
-	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
+	struct ubd *dev = inode->type.i_bdev->bd_disk->private_data;
 	int err;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,
@@ -915,7 +915,7 @@ static int ubd_ioctl(struct inode * inod
 
 	case HDIO_SET_UNMASKINTR:
 		if(!capable(CAP_SYS_ADMIN)) return(-EACCES);
-		if((arg > 1) || (inode->i_bdev->bd_contains != inode->i_bdev))
+		if((arg > 1) || (inode->type.i_bdev->bd_contains != inode->type.i_bdev))
 			return(-EINVAL);
 		return(0);
 
@@ -935,7 +935,7 @@ static int ubd_ioctl(struct inode * inod
 
 	case HDIO_SET_MULTCOUNT:
 		if(!capable(CAP_SYS_ADMIN)) return(-EACCES);
-		if(inode->i_bdev->bd_contains != inode->i_bdev)
+		if(inode->type.i_bdev->bd_contains != inode->type.i_bdev)
 			return(-EINVAL);
 		return(0);
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/acorn/block/fd1772.c inode/drivers/acorn/block/fd1772.c
--- bk-linus/drivers/acorn/block/fd1772.c	2003-03-08 08:56:52.000000000 -0100
+++ inode/drivers/acorn/block/fd1772.c	2003-03-08 08:56:15.000000000 -0100
@@ -1314,7 +1314,7 @@ static int invalidate_drive(struct block
 static int fd_ioctl(struct inode *inode, struct file *filp,
 		    unsigned int cmd, unsigned long param)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 
 	switch (cmd) {
 	case FDFMTEND:
@@ -1481,7 +1481,7 @@ static int floppy_open(struct inode *ino
 		return 0;
 
 	if (filp->f_mode & 3) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (filp->f_mode & 2) {
 			if (unit[drive].wpstat) {
 				floppy_release(inode, filp);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/acorn/block/mfmhd.c inode/drivers/acorn/block/mfmhd.c
--- bk-linus/drivers/acorn/block/mfmhd.c	2003-03-08 08:56:52.000000000 -0100
+++ inode/drivers/acorn/block/mfmhd.c	2003-03-08 08:56:15.000000000 -0100
@@ -1156,7 +1156,7 @@ static int mfm_initdrives(void)
 
 static int mfm_ioctl(struct inode *inode, struct file *file, u_int cmd, u_long arg)
 {
-	struct mfm_info *p = inode->i_bdev->bd_disk->private_data;
+	struct mfm_info *p = inode->type.i_bdev->bd_disk->private_data;
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 	if (cmd != HDIO_GETGEO)
 		return -EINVAL;
@@ -1168,7 +1168,7 @@ static int mfm_ioctl(struct inode *inode
 		return -EFAULT;
 	if (put_user (p->cylinders, &geo->cylinders))
 		return -EFAULT;
-	if (put_user (get_start_sect(inode->i_bdev), &geo->start))
+	if (put_user (get_start_sect(inode->type.i_bdev), &geo->start))
 		return -EFAULT;
 	return 0;
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/DAC960.c inode/drivers/block/DAC960.c
--- bk-linus/drivers/block/DAC960.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/DAC960.c	2003-03-08 08:56:18.000000000 -0100
@@ -5613,7 +5613,7 @@ static int DAC960_Open(Inode_T *Inode, F
       Controller->LogicalDriveInitiallyAccessible[LogicalDriveNumber] = true;
       size = disk_size(Controller, LogicalDriveNumber);
       set_capacity(Controller->disks[LogicalDriveNumber], size);
-      Inode->i_bdev->bd_invalidated = 1;
+      Inode->type.i_bdev->bd_invalidated = 1;
     }
   if (!get_capacity(Controller->disks[LogicalDriveNumber]))
     return -ENXIO;
@@ -5709,7 +5709,7 @@ static int DAC960_IOCTL(Inode_T *Inode, 
 	    LogicalDeviceInfo->ConfigurableDeviceSize
 	    / (Geometry.heads * Geometry.sectors);
 	}
-      Geometry.start = get_start_sect(Inode->i_bdev);
+      Geometry.start = get_start_sect(Inode->type.i_bdev);
       return (copy_to_user(UserGeometry, &Geometry,
 			   sizeof(DiskGeometry_T)) ? -EFAULT : 0);
     }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/acsi.c inode/drivers/block/acsi.c
--- bk-linus/drivers/block/acsi.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/acsi.c	2003-03-08 08:56:18.000000000 -0100
@@ -1083,7 +1083,7 @@ static void redo_acsi_request( void )
 static int acsi_ioctl( struct inode *inode, struct file *file,
 					   unsigned int cmd, unsigned long arg )
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct acsi_info_struct *aip = disk->private_data;
 	switch (cmd) {
 	  case HDIO_GETGEO:
@@ -1095,7 +1095,7 @@ static int acsi_ioctl( struct inode *ino
 	    put_user( 64, &geo->heads );
 	    put_user( 32, &geo->sectors );
 	    put_user( aip->size >> 11, &geo->cylinders );
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
+		put_user(get_start_sect(inode->type.i_bdev), &geo->start);
 		return 0;
 	  }
 	  case SCSI_IOCTL_GET_IDLUN:
@@ -1127,14 +1127,14 @@ static int acsi_ioctl( struct inode *ino
 
 static int acsi_open( struct inode * inode, struct file * filp )
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct acsi_info_struct *aip = disk->private_data;
 
 	if (aip->access_count == 0 && aip->removable) {
 #if 0
 		aip->changed = 1;	/* safety first */
 #endif
-		check_disk_change( inode->i_bdev );
+		check_disk_change( inode->type.i_bdev );
 		if (aip->changed)	/* revalidate was not successful (no medium) */
 			return -ENXIO;
 		acsi_prevent_removal(aip, 1);
@@ -1142,7 +1142,7 @@ static int acsi_open( struct inode * ino
 	aip->access_count++;
 
 	if (filp && filp->f_mode) {
-		check_disk_change( inode->i_bdev );
+		check_disk_change( inode->type.i_bdev );
 		if (filp->f_mode & 2) {
 			if (aip->read_only) {
 				acsi_release( inode, filp );
@@ -1161,7 +1161,7 @@ static int acsi_open( struct inode * ino
 
 static int acsi_release( struct inode * inode, struct file * file )
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct acsi_info_struct *aip = disk->private_data;
 	if (--aip->access_count == 0 && aip->removable)
 		acsi_prevent_removal(aip, 0);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/amiflop.c inode/drivers/block/amiflop.c
--- bk-linus/drivers/block/amiflop.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/amiflop.c	2003-03-08 08:56:18.000000000 -0100
@@ -1474,7 +1474,7 @@ static int fd_ioctl(struct inode *inode,
 			rel_fdc();
 			return -EBUSY;
 		}
-		fsync_bdev(inode->i_bdev);
+		fsync_bdev(inode->type.i_bdev);
 		if (fd_motor_on(drive) == 0) {
 			rel_fdc();
 			return -ENODEV;
@@ -1587,7 +1587,7 @@ static int floppy_open(struct inode *ino
 		return -EBUSY;
 
 	if (filp && filp->f_mode & 3) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (filp->f_mode & 2 ) {
 			int wrprot;
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/ataflop.c inode/drivers/block/ataflop.c
--- bk-linus/drivers/block/ataflop.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/ataflop.c	2003-03-08 08:56:18.000000000 -0100
@@ -1526,7 +1526,7 @@ static int fd_ioctl(struct inode *inode,
 {
 	int drive, type;
 	kdev_t device;
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct atari_format_descr fmt_desc;
 	struct atari_disk_type *dtp;
 	struct floppy_struct getprm;
@@ -1701,7 +1701,7 @@ static int fd_ioctl(struct inode *inode,
 		/* invalidate the buffer track to force a reread */
 		BufferDrive = -1;
 		set_bit(drive, &fake_change);
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1871,7 +1871,7 @@ static int floppy_open( struct inode *in
 		return 0;
 
 	if (filp->f_mode & 3) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (filp->f_mode & 2) {
 			if (UD.wpstat) {
 				floppy_release(inode, filp);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/cciss.c inode/drivers/block/cciss.c
--- bk-linus/drivers/block/cciss.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/cciss.c	2003-03-08 08:56:18.000000000 -0100
@@ -415,7 +415,7 @@ static int cciss_ioctl(struct inode *ino
                         driver_geo.sectors = 0x3f;
                         driver_geo.cylinders = (int)hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
                 }
-                driver_geo.start= get_start_sect(inode->i_bdev);
+                driver_geo.start= get_start_sect(inode->type.i_bdev);
                 if (copy_to_user((void *) arg, &driver_geo,
                                 sizeof( struct hd_geometry)))
                         return  -EFAULT;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/cpqarray.c inode/drivers/block/cpqarray.c
--- bk-linus/drivers/block/cpqarray.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/cpqarray.c	2003-03-08 08:56:18.000000000 -0100
@@ -1039,7 +1039,7 @@ static int ida_ioctl(struct inode *inode
 		put_user(diskinfo[0], &geo->heads);
 		put_user(diskinfo[1], &geo->sectors);
 		put_user(diskinfo[2], &geo->cylinders);
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
+		put_user(get_start_sect(inode->type.i_bdev), &geo->start);
 		return 0;
 	case IDAGETDRVINFO:
 		if (copy_to_user(&io->c.drv, &hba[ctlr]->drv[dsk],
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/floppy.c inode/drivers/block/floppy.c
--- bk-linus/drivers/block/floppy.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/floppy.c	2003-03-08 08:56:18.000000000 -0100
@@ -3525,11 +3525,11 @@ static int fd_ioctl(struct inode *inode,
 			current_type[drive] = NULL;
 			floppy_sizes[drive] = MAX_DISK_SIZE << 1;
 			UDRS->keep_data = 0;
-			return invalidate_drive(inode->i_bdev);
+			return invalidate_drive(inode->type.i_bdev);
 		case FDSETPRM:
 		case FDDEFPRM:
 			return set_geometry(cmd, & inparam.g,
-					    drive, type, inode->i_bdev);
+					    drive, type, inode->type.i_bdev);
 		case FDGETPRM:
 			ECALL(get_floppy_geometry(drive, type, 
 						  (struct floppy_struct**)
@@ -3560,7 +3560,7 @@ static int fd_ioctl(struct inode *inode,
 		case FDFMTEND:
 		case FDFLUSH:
 			LOCK_FDC(drive,1);
-			return invalidate_drive(inode->i_bdev);
+			return invalidate_drive(inode->type.i_bdev);
 
 		case FDSETEMSGTRESH:
 			UDP->max_errors.reporting =
@@ -3782,7 +3782,7 @@ static int floppy_open(struct inode * in
 		return 0;
 	if (filp->f_mode & 3) {
 		UDRS->last_checked = 0;
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (UTESTF(FD_DISK_CHANGED))
 			RETERR(ENXIO);
 	}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/ioctl.c inode/drivers/block/ioctl.c
--- bk-linus/drivers/block/ioctl.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/ioctl.c	2003-03-08 08:56:18.000000000 -0100
@@ -121,7 +121,7 @@ static int put_u64(unsigned long arg, u6
 int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	struct backing_dev_info *bdi;
 	int holder;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/loop.c inode/drivers/block/loop.c
--- bk-linus/drivers/block/loop.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/loop.c	2003-03-08 08:56:18.000000000 -0100
@@ -664,7 +664,7 @@ static int loop_set_fd(struct loop_devic
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
 	if (S_ISBLK(inode->i_mode)) {
-		lo_device = inode->i_bdev;
+		lo_device = inode->type.i_bdev;
 		if (lo_device == bdev) {
 			error = -EBUSY;
 			goto out;
@@ -910,16 +910,16 @@ static int loop_get_status(struct loop_d
 static int lo_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct loop_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	int err;
 
 	down(&lo->lo_ctl_mutex);
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = loop_set_fd(lo, file, inode->i_bdev, arg);
+		err = loop_set_fd(lo, file, inode->type.i_bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		err = loop_clr_fd(lo, inode->i_bdev);
+		err = loop_clr_fd(lo, inode->type.i_bdev);
 		break;
 	case LOOP_SET_STATUS:
 		err = loop_set_status(lo, (struct loop_info *) arg);
@@ -936,7 +936,7 @@ static int lo_ioctl(struct inode * inode
 
 static int lo_open(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct loop_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	int type;
 
 	down(&lo->lo_ctl_mutex);
@@ -951,7 +951,7 @@ static int lo_open(struct inode *inode, 
 
 static int lo_release(struct inode *inode, struct file *file)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct loop_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	int type;
 
 	down(&lo->lo_ctl_mutex);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/nbd.c inode/drivers/block/nbd.c
--- bk-linus/drivers/block/nbd.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/nbd.c	2003-03-08 08:56:18.000000000 -0100
@@ -97,7 +97,7 @@ static void nbd_end_request(struct reque
 
 static int nbd_open(struct inode *inode, struct file *file)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct nbd_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	lo->refcnt++;
 	return 0;
 }
@@ -410,7 +410,7 @@ static void do_nbd_request(request_queue
 static int nbd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct nbd_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	int error, temp;
 	struct request sreq ;
 
@@ -514,7 +514,7 @@ static int nbd_ioctl(struct inode *inode
 #ifdef PARANOIA
 	case NBD_PRINT_DEBUG:
 		printk(KERN_INFO "%s: next = %p, prev = %p. Global: in %d, out %d\n",
-		       inode->i_bdev->bd_disk->disk_name, lo->queue_head.next,
+		       inode->type.i_bdev->bd_disk->disk_name, lo->queue_head.next,
 		       lo->queue_head.prev, requests_in, requests_out);
 		return 0;
 #endif
@@ -524,7 +524,7 @@ static int nbd_ioctl(struct inode *inode
 
 static int nbd_release(struct inode *inode, struct file *file)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct nbd_device *lo = inode->type.i_bdev->bd_disk->private_data;
 	if (lo->refcnt <= 0)
 		printk(KERN_ALERT "nbd_release: refcount(%d) <= 0\n", lo->refcnt);
 	lo->refcnt--;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/pcd.c inode/drivers/block/paride/pcd.c
--- bk-linus/drivers/block/paride/pcd.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/paride/pcd.c	2003-03-08 08:56:18.000000000 -0100
@@ -245,20 +245,20 @@ static int pcd_warned;		/* Have we logge
 
 static int pcd_block_open(struct inode *inode, struct file *file)
 {
-	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
+	struct pcd_unit *cd = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_open(&cd->info, inode, file);
 }
 
 static int pcd_block_release(struct inode *inode, struct file *file)
 {
-	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
+	struct pcd_unit *cd = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_release(&cd->info, file);
 }
 
 static int pcd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
+	struct pcd_unit *cd = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_ioctl(&cd->info, inode, cmd, arg);
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/pd.c inode/drivers/block/paride/pd.c
--- bk-linus/drivers/block/paride/pd.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/paride/pd.c	2003-03-08 08:56:18.000000000 -0100
@@ -339,7 +339,7 @@ static void pd_init_units(void)
 
 static int pd_open(struct inode *inode, struct file *file)
 {
-	struct pd_unit *disk = inode->i_bdev->bd_disk->private_data;
+	struct pd_unit *disk = inode->type.i_bdev->bd_disk->private_data;
 
 	disk->access++;
 
@@ -353,7 +353,7 @@ static int pd_open(struct inode *inode, 
 static int pd_ioctl(struct inode *inode, struct file *file,
 	 unsigned int cmd, unsigned long arg)
 {
-	struct pd_unit *disk = inode->i_bdev->bd_disk->private_data;
+	struct pd_unit *disk = inode->type.i_bdev->bd_disk->private_data;
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 	struct hd_geometry g;
 
@@ -372,7 +372,7 @@ static int pd_ioctl(struct inode *inode,
 			g.sectors = disk->sectors;
 			g.cylinders = disk->cylinders;
 		}
-		g.start = get_start_sect(inode->i_bdev);
+		g.start = get_start_sect(inode->type.i_bdev);
 		if (copy_to_user(geo, &g, sizeof(struct hd_geometry)))
 			return -EFAULT;
 		return 0;
@@ -383,7 +383,7 @@ static int pd_ioctl(struct inode *inode,
 
 static int pd_release(struct inode *inode, struct file *file)
 {
-	struct pd_unit *disk = inode->i_bdev->bd_disk->private_data;
+	struct pd_unit *disk = inode->type.i_bdev->bd_disk->private_data;
 
 	if (!--disk->access && disk->removable)
 		pd_doorlock(disk, IDE_DOORUNLOCK);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/paride/pf.c inode/drivers/block/paride/pf.c
--- bk-linus/drivers/block/paride/pf.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/paride/pf.c	2003-03-08 08:56:18.000000000 -0100
@@ -320,7 +320,7 @@ void pf_init_units(void)
 
 static int pf_open(struct inode *inode, struct file *file)
 {
-	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
+	struct pf_unit *pf = inode->type.i_bdev->bd_disk->private_data;
 
 	pf_identify(pf);
 
@@ -339,7 +339,7 @@ static int pf_open(struct inode *inode, 
 
 static int pf_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
+	struct pf_unit *pf = inode->type.i_bdev->bd_disk->private_data;
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 	struct hd_geometry g;
 	sector_t capacity;
@@ -370,7 +370,7 @@ static int pf_ioctl(struct inode *inode,
 
 static int pf_release(struct inode *inode, struct file *file)
 {
-	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
+	struct pf_unit *pf = inode->type.i_bdev->bd_disk->private_data;
 
 	if (pf->access <= 0)
 		return -EINVAL;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/ps2esdi.c inode/drivers/block/ps2esdi.c
--- bk-linus/drivers/block/ps2esdi.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/ps2esdi.c	2003-03-08 08:56:18.000000000 -0100
@@ -1058,7 +1058,7 @@ static void dump_cmd_complete_status(u_i
 static int ps2esdi_ioctl(struct inode *inode,
 			 struct file *file, u_int cmd, u_long arg)
 {
-	struct ps2esdi_i_struct *p = inode->i_bdev->bd_disk->private_data;
+	struct ps2esdi_i_struct *p = inode->type.i_bdev->bd_disk->private_data;
 	struct ps2esdi_geometry *geometry = (struct ps2esdi_geometry *) arg;
 	int err;
 
@@ -1069,7 +1069,7 @@ static int ps2esdi_ioctl(struct inode *i
 	put_user(p->head, (char *) &geometry->heads);
 	put_user(p->sect, (char *) &geometry->sectors);
 	put_user(p->cyl, (short *) &geometry->cylinders);
-	put_user(get_start_sect(inode->i_bdev), (long *) &geometry->start);
+	put_user(get_start_sect(inode->type.i_bdev), (long *) &geometry->start);
 	return 0;
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/rd.c inode/drivers/block/rd.c
--- bk-linus/drivers/block/rd.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/rd.c	2003-03-08 08:56:18.000000000 -0100
@@ -256,12 +256,12 @@ static int rd_ioctl(struct inode *inode,
 	   it's not like with the other blockdevices where
 	   this ioctl only flushes away the buffer cache. */
 	error = -EBUSY;
-	down(&inode->i_bdev->bd_sem);
-	if (inode->i_bdev->bd_openers <= 2) {
+	down(&inode->type.i_bdev->bd_sem);
+	if (inode->type.i_bdev->bd_openers <= 2) {
 		truncate_inode_pages(inode->i_mapping, 0);
 		error = 0;
 	}
-	up(&inode->i_bdev->bd_sem);
+	up(&inode->type.i_bdev->bd_sem);
 	return error;
 }
 
@@ -290,7 +290,7 @@ static int initrd_release(struct inode *
 {
 	extern void free_initrd_mem(unsigned long, unsigned long);
 
-	blkdev_put(inode->i_bdev, BDEV_FILE);
+	blkdev_put(inode->type.i_bdev, BDEV_FILE);
 
 	spin_lock(&initrd_users_lock);
 	if (!--initrd_users) {
@@ -337,7 +337,7 @@ static int rd_open(struct inode * inode,
 	 * Immunize device against invalidate_buffers() and prune_icache().
 	 */
 	if (rd_bdev[unit] == NULL) {
-		struct block_device *bdev = inode->i_bdev;
+		struct block_device *bdev = inode->type.i_bdev;
 		atomic_inc(&bdev->bd_count);
 		rd_bdev[unit] = bdev;
 		bdev->bd_openers++;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/swim3.c inode/drivers/block/swim3.c
--- bk-linus/drivers/block/swim3.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/swim3.c	2003-03-08 08:56:18.000000000 -0100
@@ -815,7 +815,7 @@ static struct floppy_struct floppy_type 
 static int floppy_ioctl(struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long param)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 	int err;
 		
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
@@ -841,7 +841,7 @@ static int floppy_ioctl(struct inode *in
 
 static int floppy_open(struct inode *inode, struct file *filp)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 	volatile struct swim3 *sw = fs->swim3;
 	int n, err = 0;
 
@@ -877,7 +877,7 @@ static int floppy_open(struct inode *ino
 
 	if (err == 0 && (filp->f_flags & O_NDELAY) == 0
 	    && (filp->f_mode & 3)) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (fs->ejected)
 			err = -ENXIO;
 	}
@@ -907,7 +907,7 @@ static int floppy_open(struct inode *ino
 
 static int floppy_release(struct inode *inode, struct file *filp)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 	volatile struct swim3 *sw = fs->swim3;
 	if (fs->ref_count > 0 && --fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/swim_iop.c inode/drivers/block/swim_iop.c
--- bk-linus/drivers/block/swim_iop.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/swim_iop.c	2003-03-08 08:56:18.000000000 -0100
@@ -345,7 +345,7 @@ static struct floppy_struct floppy_type 
 static int floppy_ioctl(struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long param)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 	int err;
 
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
@@ -368,13 +368,13 @@ static int floppy_ioctl(struct inode *in
 
 static int floppy_open(struct inode *inode, struct file *filp)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 
 	if (fs->ref_count == -1 || filp->f_flags & O_EXCL)
 		return -EBUSY;
 
 	if ((filp->f_flags & O_NDELAY) == 0 && (filp->f_mode & 3)) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		if (fs->ejected)
 			return -ENXIO;
 	}
@@ -392,7 +392,7 @@ static int floppy_open(struct inode *ino
 
 static int floppy_release(struct inode *inode, struct file *filp)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = inode->type.i_bdev->bd_disk->private_data;
 	if (fs->ref_count > 0)
 		fs->ref_count--;
 	return 0;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/umem.c inode/drivers/block/umem.c
--- bk-linus/drivers/block/umem.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/umem.c	2003-03-08 08:56:18.000000000 -0100
@@ -815,7 +815,7 @@ static int mm_revalidate(struct gendisk 
 static int mm_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
 {
 	if (cmd == HDIO_GETGEO) {
-		struct cardinfo *card = i->i_bdev->bd_disk->private_data;
+		struct cardinfo *card = i->type.i_bdev->bd_disk->private_data;
 		int size = card->mm_size * (1024 / MM_HARDSECT);
 		struct hd_geometry geo;
 		/*
@@ -825,7 +825,7 @@ static int mm_ioctl(struct inode *i, str
 		 */
 		geo.heads     = 64;
 		geo.sectors   = 32;
-		geo.start     = get_start_sect(i->i_bdev);
+		geo.start     = get_start_sect(i->type.i_bdev);
 		geo.cylinders = size / (geo.heads * geo.sectors);
 
 		if (copy_to_user((void *) arg, &geo, sizeof(geo)))
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/xd.c inode/drivers/block/xd.c
--- bk-linus/drivers/block/xd.c	2003-03-08 08:56:55.000000000 -0100
+++ inode/drivers/block/xd.c	2003-03-08 08:56:18.000000000 -0100
@@ -317,7 +317,7 @@ static void do_xd_request (request_queue
 /* xd_ioctl: handle device ioctl's */
 static int xd_ioctl (struct inode *inode,struct file *file,u_int cmd,u_long arg)
 {
-	XD_INFO *p = inode->i_bdev->bd_disk->private_data;
+	XD_INFO *p = inode->type.i_bdev->bd_disk->private_data;
 
 	switch (cmd) {
 		case HDIO_GETGEO:
@@ -327,7 +327,7 @@ static int xd_ioctl (struct inode *inode
 			g.heads = p->heads;
 			g.sectors = p->sectors;
 			g.cylinders = p->cylinders;
-			g.start = get_start_sect(inode->i_bdev);
+			g.start = get_start_sect(inode->type.i_bdev);
 			return copy_to_user(geometry, &g, sizeof g) ? -EFAULT : 0;
 		}
 		case HDIO_SET_DMA:
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/aztcd.c inode/drivers/cdrom/aztcd.c
--- bk-linus/drivers/cdrom/aztcd.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/aztcd.c	2003-03-08 08:56:18.000000000 -0100
@@ -1679,7 +1679,7 @@ static int aztcd_release(struct inode *i
 #ifdef AZT_DEBUG
 	printk("aztcd: executing aztcd_release\n");
 	printk("inode: %p, device: %s    file: %p\n", inode,
-	       inode->i_bdev->bd_disk->disk_name, file);
+	       inode->type.i_bdev->bd_disk->disk_name, file);
 #endif
 	if (!--azt_open_count) {
 		azt_invalidate_buffers();
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/cdrom.c inode/drivers/cdrom/cdrom.c
--- bk-linus/drivers/cdrom/cdrom.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/cdrom.c	2003-03-08 08:56:18.000000000 -0100
@@ -436,7 +436,7 @@ int cdrom_open(struct cdrom_device_info 
 	cdinfo(CD_OPEN, "Use count for \"/dev/%s\" now %d\n", cdi->name, cdi->use_count);
 	/* Do this on open.  Don't wait for mount, because they might
 	    not be mounting, but opening with O_NONBLOCK */
-	check_disk_change(ip->i_bdev);
+	check_disk_change(ip->type.i_bdev);
 	return ret;
 }
 
@@ -1439,7 +1439,7 @@ int cdrom_ioctl(struct cdrom_device_info
 	int ret;
 
 	/* Try the generic SCSI command ioctl's first.. */
-	ret = scsi_cmd_ioctl(ip->i_bdev, cmd, arg);
+	ret = scsi_cmd_ioctl(ip->type.i_bdev, cmd, arg);
 	if (ret != -ENOTTY)
 		return ret;
 
@@ -1592,7 +1592,7 @@ int cdrom_ioctl(struct cdrom_device_info
 		cdinfo(CD_DO_IOCTL, "entering CDROM_RESET\n");
 		if (!CDROM_CAN(CDC_RESET))
 			return -ENOSYS;
-		invalidate_bdev(ip->i_bdev, 0);
+		invalidate_bdev(ip->type.i_bdev, 0);
 		return cdo->reset(cdi);
 		}
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/mcdx.c inode/drivers/cdrom/mcdx.c
--- bk-linus/drivers/cdrom/mcdx.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/mcdx.c	2003-03-08 08:56:18.000000000 -0100
@@ -223,20 +223,20 @@ void do_mcdx_request(request_queue_t * q
 
 static int mcdx_block_open(struct inode *inode, struct file *file)
 {
-	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
+	struct s_drive_stuff *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_open(&p->info, inode, file);
 }
 
 static int mcdx_block_release(struct inode *inode, struct file *file)
 {
-	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
+	struct s_drive_stuff *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_release(&p->info, file);
 }
 
 static int mcdx_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
+	struct s_drive_stuff *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_ioctl(&p->info, inode, cmd, arg);
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/optcd.c inode/drivers/cdrom/optcd.c
--- bk-linus/drivers/cdrom/optcd.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/optcd.c	2003-03-08 08:56:19.000000000 -0100
@@ -1897,7 +1897,7 @@ static int opt_release(struct inode *ip,
 
 	DEBUG((DEBUG_VFS, "executing opt_release"));
 	DEBUG((DEBUG_VFS, "inode: %p, device: %s, file: %p\n",
-		ip, ip->i_bdev->bd_disk->disk_name, fp));
+		ip, ip->type.i_bdev->bd_disk->disk_name, fp));
 
 	if (!--open_count) {
 		toc_uptodate = 0;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/sbpcd.c inode/drivers/cdrom/sbpcd.c
--- bk-linus/drivers/cdrom/sbpcd.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/sbpcd.c	2003-03-08 08:56:19.000000000 -0100
@@ -5358,20 +5358,20 @@ static int sbp_data(struct request *req)
 
 static int sbpcd_block_open(struct inode *inode, struct file *file)
 {
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	struct sbpcd_drive *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_open(p->sbpcd_infop, inode, file);
 }
 
 static int sbpcd_block_release(struct inode *inode, struct file *file)
 {
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	struct sbpcd_drive *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_release(p->sbpcd_infop, file);
 }
 
 static int sbpcd_block_ioctl(struct inode *inode, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
+	struct sbpcd_drive *p = inode->type.i_bdev->bd_disk->private_data;
 	return cdrom_ioctl(p->sbpcd_infop, inode, cmd, arg);
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/cdrom/sonycd535.c inode/drivers/cdrom/sonycd535.c
--- bk-linus/drivers/cdrom/sonycd535.c	2003-03-08 08:56:56.000000000 -0100
+++ inode/drivers/cdrom/sonycd535.c	2003-03-08 08:56:19.000000000 -0100
@@ -1377,7 +1377,7 @@ cdu_open(struct inode *inode,
 		sony_inuse = 0;
 		return -EIO;
 	}
-	check_disk_change(inode->i_bdev);
+	check_disk_change(inode->type.i_bdev);
 	sony_usage++;
 
 #ifdef LOCK_DOORS
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/ide-cd.c inode/drivers/ide/ide-cd.c
--- bk-linus/drivers/ide/ide-cd.c	2003-03-08 08:57:02.000000000 -0100
+++ inode/drivers/ide/ide-cd.c	2003-03-08 08:56:23.000000000 -0100
@@ -3272,7 +3272,7 @@ static ide_driver_t ide_cdrom_driver = {
 
 static int idecd_open(struct inode * inode, struct file * file)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	struct cdrom_info *info = drive->driver_data;
 	int rc = -ENOMEM;
 	drive->usage++;
@@ -3286,7 +3286,7 @@ static int idecd_open(struct inode * ino
 
 static int idecd_release(struct inode * inode, struct file * file)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	struct cdrom_info *info = drive->driver_data;
 
 	cdrom_release (&info->devinfo, file);
@@ -3297,7 +3297,7 @@ static int idecd_release(struct inode * 
 static int idecd_ioctl (struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	int err = generic_ide_ioctl(bdev, cmd, arg);
 	if (err == -EINVAL) {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/ide-disk.c inode/drivers/ide/ide-disk.c
--- bk-linus/drivers/ide/ide-disk.c	2003-03-08 08:57:02.000000000 -0100
+++ inode/drivers/ide/ide-disk.c	2003-03-08 08:56:23.000000000 -0100
@@ -1680,7 +1680,7 @@ static ide_driver_t idedisk_driver = {
 
 static int idedisk_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	drive->usage++;
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
@@ -1688,7 +1688,7 @@ static int idedisk_open(struct inode *in
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
 		args.command_type = ide_cmd_type_parser(&args);
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
@@ -1728,13 +1728,13 @@ static int ide_cacheflush_p(ide_drive_t 
 
 static int idedisk_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	if (drive->removable && drive->usage == 1) {
 		ide_task_t args;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
 		args.command_type = ide_cmd_type_parser(&args);
-		invalidate_bdev(inode->i_bdev, 0);
+		invalidate_bdev(inode->type.i_bdev, 0);
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking = 0;
 	}
@@ -1746,7 +1746,7 @@ static int idedisk_release(struct inode 
 static int idedisk_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	return generic_ide_ioctl(bdev, cmd, arg);
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/ide-floppy.c inode/drivers/ide/ide-floppy.c
--- bk-linus/drivers/ide/ide-floppy.c	2003-03-08 08:57:02.000000000 -0100
+++ inode/drivers/ide/ide-floppy.c	2003-03-08 08:56:23.000000000 -0100
@@ -1867,7 +1867,7 @@ static ide_driver_t idefloppy_driver = {
 
 static int idefloppy_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	idefloppy_pc_t pc;
 
@@ -1907,7 +1907,7 @@ static int idefloppy_open(struct inode *
 			idefloppy_create_prevent_cmd(&pc, 1);
 			(void) idefloppy_queue_pc_tail(drive, &pc);
 		}
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 	} else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags)) {
 		drive->usage--;
 		return -EBUSY;
@@ -1917,7 +1917,7 @@ static int idefloppy_open(struct inode *
 
 static int idefloppy_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	idefloppy_pc_t pc;
 	
 	debug_log(KERN_INFO "Reached idefloppy_release\n");
@@ -1940,7 +1940,7 @@ static int idefloppy_release(struct inod
 static int idefloppy_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	int err = generic_ide_ioctl(bdev, cmd, arg);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/ide-tape.c inode/drivers/ide/ide-tape.c
--- bk-linus/drivers/ide/ide-tape.c	2003-03-08 08:57:02.000000000 -0100
+++ inode/drivers/ide/ide-tape.c	2003-03-08 08:56:23.000000000 -0100
@@ -6246,14 +6246,14 @@ static struct file_operations idetape_fo
 
 static int idetape_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	drive->usage++;
 	return 0;
 }
 
 static int idetape_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	drive->usage--;
 	return 0;
 }
@@ -6261,7 +6261,7 @@ static int idetape_release(struct inode 
 static int idetape_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	ide_drive_t *drive = bdev->bd_disk->private_data;
 	int err = generic_ide_ioctl(bdev, cmd, arg);
 	if (err == -EINVAL)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/ide/legacy/hd.c inode/drivers/ide/legacy/hd.c
--- bk-linus/drivers/ide/legacy/hd.c	2003-03-08 08:57:03.000000000 -0100
+++ inode/drivers/ide/legacy/hd.c	2003-03-08 08:56:23.000000000 -0100
@@ -659,7 +659,7 @@ static void do_hd_request (request_queue
 static int hd_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct hd_i_struct *disk = inode->i_bdev->bd_disk->private_data;
+	struct hd_i_struct *disk = inode->type.i_bdev->bd_disk->private_data;
 	struct hd_geometry *loc = (struct hd_geometry *) arg;
 	struct hd_geometry g; 
 
@@ -670,7 +670,7 @@ static int hd_ioctl(struct inode * inode
 	g.heads = disk->head;
 	g.sectors = disk->sect;
 	g.cylinders = disk->cyl;
-	g.start = get_start_sect(inode->i_bdev);
+	g.start = get_start_sect(inode->type.i_bdev);
 	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/md/dm.c inode/drivers/md/dm.c
--- bk-linus/drivers/md/dm.c	2003-03-08 08:57:08.000000000 -0100
+++ inode/drivers/md/dm.c	2003-03-08 08:56:28.000000000 -0100
@@ -159,7 +159,7 @@ static int dm_blk_open(struct inode *ino
 {
 	struct mapped_device *md;
 
-	md = inode->i_bdev->bd_disk->private_data;
+	md = inode->type.i_bdev->bd_disk->private_data;
 	dm_get(md);
 	return 0;
 }
@@ -168,7 +168,7 @@ static int dm_blk_close(struct inode *in
 {
 	struct mapped_device *md;
 
-	md = inode->i_bdev->bd_disk->private_data;
+	md = inode->type.i_bdev->bd_disk->private_data;
 	dm_put(md);
 	return 0;
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/md/md.c inode/drivers/md/md.c
--- bk-linus/drivers/md/md.c	2003-03-08 08:57:08.000000000 -0100
+++ inode/drivers/md/md.c	2003-03-08 08:56:28.000000000 -0100
@@ -2238,7 +2238,7 @@ static int md_ioctl(struct inode *inode,
 	 * Commands creating/starting a new array:
 	 */
 
-	mddev = inode->i_bdev->bd_inode->u.generic_ip;
+	mddev = inode->type.i_bdev->bd_inode->u.generic_ip;
 
 	if (!mddev) {
 		BUG();
@@ -2354,7 +2354,7 @@ static int md_ioctl(struct inode *inode,
 						(short *) &loc->cylinders);
 			if (err)
 				goto abort_unlock;
-			err = put_user (get_start_sect(inode->i_bdev),
+			err = put_user (get_start_sect(inode->type.i_bdev),
 						(long *) &loc->start);
 			goto done_unlock;
 	}
@@ -2447,7 +2447,7 @@ static int md_open(struct inode *inode, 
 
 	err = 0;
 	mddev_unlock(mddev);
-	inode->i_bdev->bd_inode->u.generic_ip = mddev_get(mddev);
+	inode->type.i_bdev->bd_inode->u.generic_ip = mddev_get(mddev);
  put:
 	mddev_put(mddev);
  out:
@@ -2456,7 +2456,7 @@ static int md_open(struct inode *inode, 
 
 static int md_release(struct inode *inode, struct file * file)
 {
- 	mddev_t *mddev = inode->i_bdev->bd_inode->u.generic_ip;
+ 	mddev_t *mddev = inode->type.i_bdev->bd_inode->u.generic_ip;
 
 	if (!mddev)
 		BUG();
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/message/i2o/i2o_block.c inode/drivers/message/i2o/i2o_block.c
--- bk-linus/drivers/message/i2o/i2o_block.c	2003-03-08 08:57:10.000000000 -0100
+++ inode/drivers/message/i2o/i2o_block.c	2003-03-08 08:56:30.000000000 -0100
@@ -892,7 +892,7 @@ static void i2o_block_biosparam(
 static int i2ob_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct i2ob_device *dev = disk->private_data;
 
 	/* Anyone capable of this syscall can do *real bad* things */
@@ -905,7 +905,7 @@ static int i2ob_ioctl(struct inode *inod
 			struct hd_geometry g;
 			i2o_block_biosparam(get_capacity(disk), 
 					&g.cylinders, &g.heads, &g.sectors);
-			g.start = get_start_sect(inode->i_bdev);
+			g.start = get_start_sect(inode->type.i_bdev);
 			return copy_to_user((void *)arg,&g, sizeof(g))?-EFAULT:0;
 		}
 		
@@ -933,7 +933,7 @@ static int i2ob_ioctl(struct inode *inod
  
 static int i2ob_release(struct inode *inode, struct file *file)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct i2ob_device *dev = disk->private_data;
 
 	/*
@@ -1005,7 +1005,7 @@ static int i2ob_release(struct inode *in
  
 static int i2ob_open(struct inode *inode, struct file *file)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct i2ob_device *dev = disk->private_data;
 
 	if(!dev->i2odev)	
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/devices/blkmtd.c inode/drivers/mtd/devices/blkmtd.c
--- bk-linus/drivers/mtd/devices/blkmtd.c	2003-03-08 08:57:11.000000000 -0100
+++ inode/drivers/mtd/devices/blkmtd.c	2003-03-08 08:56:31.000000000 -0100
@@ -1103,7 +1103,7 @@ static int __init init_blkmtd(void)
     filp_close(file, NULL);
     return 1;
   }
-  rdev = inode->i_bdev->bd_dev;
+  rdev = inode->type.i_bdev->bd_dev;
   filp_close(file, NULL);
 #else
   rdev = name_to_dev_t(device);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/ftl.c inode/drivers/mtd/ftl.c
--- bk-linus/drivers/mtd/ftl.c	2003-03-08 08:57:10.000000000 -0100
+++ inode/drivers/mtd/ftl.c	2003-03-08 08:56:31.000000000 -0100
@@ -823,7 +823,7 @@ static u_int32_t find_free(partition_t *
 
 static int ftl_open(struct inode *inode, struct file *file)
 {
-	partition_t *partition = inode->i_bdev->bd_disk->private_data;
+	partition_t *partition = inode->type.i_bdev->bd_disk->private_data;
 	if (!partition)
 		return -ENODEV;
 
@@ -841,7 +841,7 @@ static int ftl_open(struct inode *inode,
 		return -EROFS;
 	}
     
-	DEBUG(0, "ftl_cs: ftl_open(%s)\n", inode->i_bdev->bd_disk->disk_name);
+	DEBUG(0, "ftl_cs: ftl_open(%s)\n", inode->type.i_bdev->bd_disk->disk_name);
 
 	atomic_inc(&partition->open);
 
@@ -852,10 +852,10 @@ static int ftl_open(struct inode *inode,
 
 static release_t ftl_close(struct inode *inode, struct file *file)
 {
-	partition_t *part = inode->i_bdev->bd_disk->private_data;
+	partition_t *part = inode->type.i_bdev->bd_disk->private_data;
 	int i;
     
-	DEBUG(0, "ftl_cs: ftl_close(%s)\n", inode->i_bdev->bd_disk->disk_name);
+	DEBUG(0, "ftl_cs: ftl_close(%s)\n", inode->type.i_bdev->bd_disk->disk_name);
 
 	/* Wait for any pending erase operations to complete */
 	if (part->mtd->sync)
@@ -1083,7 +1083,7 @@ static int ftl_write(partition_t *part, 
 static int ftl_ioctl(struct inode *inode, struct file *file,
 		     u_int cmd, u_long arg)
 {
-	partition_t *part = inode->i_bdev->bd_disk->private_data;
+	partition_t *part = inode->type.i_bdev->bd_disk->private_data;
 	struct hd_geometry *geo = (struct hd_geometry *)arg;
 	int ret = 0;
 	u_long sect;
@@ -1101,7 +1101,7 @@ static int ftl_ioctl(struct inode *inode
 	put_user(1, (char *)&geo->heads);
 	put_user(8, (char *)&geo->sectors);
 	put_user((sect>>3), (short *)&geo->cylinders);
-	put_user(get_start_sect(inode->i_bdev), (u_long *)&geo->start);
+	put_user(get_start_sect(inode->type.i_bdev), (u_long *)&geo->start);
 	return 0;
 } /* ftl_ioctl */
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/mtdblock.c inode/drivers/mtd/mtdblock.c
--- bk-linus/drivers/mtd/mtdblock.c	2003-03-08 08:57:10.000000000 -0100
+++ inode/drivers/mtd/mtdblock.c	2003-03-08 08:56:31.000000000 -0100
@@ -325,7 +325,7 @@ static int mtdblock_open(struct inode *i
 	}
 
 	mtdblks[dev] = mtdblk;
-	set_device_ro(inode->i_bdev, !(mtdblk->mtd->flags & MTD_WRITEABLE));
+	set_device_ro(inode->type.i_bdev, !(mtdblk->mtd->flags & MTD_WRITEABLE));
 
 	spin_unlock(&mtdblks_lock);
 
@@ -495,8 +495,8 @@ static int mtdblock_ioctl(struct inode *
 
 	switch (cmd) {
 	case BLKFLSBUF:
-		fsync_bdev(inode->i_bdev);
-		invalidate_bdev(inode->i_bdev, 0);
+		fsync_bdev(inode->type.i_bdev);
+		invalidate_bdev(inode->type.i_bdev, 0);
 		down(&mtdblk->cache_sem);
 		write_cached_data(mtdblk);
 		up(&mtdblk->cache_sem);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/mtdblock_ro.c inode/drivers/mtd/mtdblock_ro.c
--- bk-linus/drivers/mtd/mtdblock_ro.c	2003-03-08 08:57:10.000000000 -0100
+++ inode/drivers/mtd/mtdblock_ro.c	2003-03-08 08:56:31.000000000 -0100
@@ -42,7 +42,7 @@ static spinlock_t mtdro_lock = SPIN_LOCK
 
 static int mtdblock_open(struct inode *inode, struct file *file)
 {
-	struct mtdro_dev *mdev = inode->i_bdev->bd_disk->private_data;
+	struct mtdro_dev *mdev = inode->type.i_bdev->bd_disk->private_data;
 	int ret = 0;
 
 	DEBUG(1,"mtdblock_open\n");
@@ -58,7 +58,7 @@ static int mtdblock_open(struct inode *i
 	}
 
 	if (ret == 0) {
-		set_device_ro(inode->i_bdev, !(mdev->mtd->flags & MTD_CAP_RAM));
+		set_device_ro(inode->type.i_bdev, !(mdev->mtd->flags & MTD_CAP_RAM));
 		mdev->open++;
 	}
 	up(&mtd_sem);
@@ -70,7 +70,7 @@ static int mtdblock_open(struct inode *i
 
 static release_t mtdblock_release(struct inode *inode, struct file *file)
 {
-	struct mtdro_dev *mdev = inode->i_bdev->bd_disk->private_data;
+	struct mtdro_dev *mdev = inode->type.i_bdev->bd_disk->private_data;
 
    	DEBUG(1, "mtdblock_release\n");
 
@@ -170,13 +170,13 @@ static void mtdblock_request(request_que
 static int mtdblock_ioctl(struct inode * inode, struct file * file,
 		      unsigned int cmd, unsigned long arg)
 {
-	struct mtdro_dev *mdev = inode->i_bdev->bd_disk->private_data;
+	struct mtdro_dev *mdev = inode->type.i_bdev->bd_disk->private_data;
 
 	if (cmd != BLKFLSBUF)
 		return -EINVAL;
 
-	fsync_bdev(inode->i_bdev);
-	invalidate_bdev(inode->i_bdev, 0);
+	fsync_bdev(inode->type.i_bdev);
+	invalidate_bdev(inode->type.i_bdev, 0);
 	if (mdev->mtd->sync)
 		mdev->mtd->sync(mdev->mtd);
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/nftlcore.c inode/drivers/mtd/nftlcore.c
--- bk-linus/drivers/mtd/nftlcore.c	2003-03-08 08:57:10.000000000 -0100
+++ inode/drivers/mtd/nftlcore.c	2003-03-08 08:56:31.000000000 -0100
@@ -756,7 +756,7 @@ static int NFTL_readblock(struct NFTLrec
 
 static int nftl_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg)
 {
-	struct NFTLrecord *nftl = inode->i_bdev->bd_disk->private_data;
+	struct NFTLrecord *nftl = inode->type.i_bdev->bd_disk->private_data;
 	switch (cmd) {
 	case HDIO_GETGEO: {
 		struct hd_geometry g;
@@ -764,12 +764,12 @@ static int nftl_ioctl(struct inode * ino
 		g.heads = nftl->heads;
 		g.sectors = nftl->sectors;
 		g.cylinders = nftl->cylinders;
-		g.start = get_start_sect(inode->i_bdev);
+		g.start = get_start_sect(inode->type.i_bdev);
 		return copy_to_user((void *)arg, &g, sizeof g) ? -EFAULT : 0;
 	}
 	case BLKFLSBUF:
-		fsync_bdev(inode->i_bdev);
-		invalidate_bdev(inode->i_bdev, 0);
+		fsync_bdev(inode->type.i_bdev);
+		invalidate_bdev(inode->type.i_bdev, 0);
 		if (nftl->mtd->sync)
 			nftl->mtd->sync(nftl->mtd);
 		return 0;
@@ -869,7 +869,7 @@ static struct gendisk *nftl_probe(dev_t 
 
 static int nftl_open(struct inode *ip, struct file *fp)
 {
-	struct NFTLrecord *thisNFTL = ip->i_bdev->bd_disk->private_data;
+	struct NFTLrecord *thisNFTL = ip->type.i_bdev->bd_disk->private_data;
 
 	DEBUG(MTD_DEBUG_LEVEL2,"NFTL_open\n");
 	if (!thisNFTL)
@@ -888,7 +888,7 @@ static int nftl_open(struct inode *ip, s
 
 static int nftl_release(struct inode *inode, struct file *fp)
 {
-	struct NFTLrecord *thisNFTL = inode->i_bdev->bd_disk->private_data;
+	struct NFTLrecord *thisNFTL = inode->type.i_bdev->bd_disk->private_data;
 
 	DEBUG(MTD_DEBUG_LEVEL2, "NFTL_release\n");
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/s390/block/dasd.c inode/drivers/s390/block/dasd.c
--- bk-linus/drivers/s390/block/dasd.c	2003-03-08 08:57:22.000000000 -0100
+++ inode/drivers/s390/block/dasd.c	2003-03-08 08:56:38.000000000 -0100
@@ -1728,7 +1728,7 @@ dasd_open(struct inode *inp, struct file
 		return -EPERM;
 	}
 
-	device = inp->i_bdev->bd_disk->private_data;
+	device = inp->type.i_bdev->bd_disk->private_data;
 	if (device->state < DASD_STATE_BASIC) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
 			      " Cannot open unrecognized device");
@@ -1751,7 +1751,7 @@ dasd_release(struct inode *inp, struct f
 {
 	dasd_device_t *device;
 
-	device = inp->i_bdev->bd_disk->private_data;
+	device = inp->type.i_bdev->bd_disk->private_data;
 
 	if (device->state < DASD_STATE_ACCEPT) {
 		DBF_DEV_EVENT(DBF_ERR, device, " %s",
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/s390/block/dasd_ioctl.c inode/drivers/s390/block/dasd_ioctl.c
--- bk-linus/drivers/s390/block/dasd_ioctl.c	2003-03-08 08:57:22.000000000 -0100
+++ inode/drivers/s390/block/dasd_ioctl.c	2003-03-08 08:56:39.000000000 -0100
@@ -88,7 +88,7 @@ int
 dasd_ioctl(struct inode *inp, struct file *filp,
 	   unsigned int no, unsigned long data)
 {
-	struct block_device *bdev = inp->i_bdev;
+	struct block_device *bdev = inp->type.i_bdev;
 	dasd_device_t *device = bdev->bd_disk->private_data;
 	dasd_ioctl_list_t *ioctl;
 	struct list_head *l;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/ide-scsi.c inode/drivers/scsi/ide-scsi.c
--- bk-linus/drivers/scsi/ide-scsi.c	2003-02-04 11:58:09.000000000 -0100
+++ inode/drivers/scsi/ide-scsi.c	2003-03-08 08:56:42.000000000 -0100
@@ -634,14 +634,14 @@ static ide_driver_t idescsi_driver = {
 
 static int idescsi_ide_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	drive->usage++;
 	return 0;
 }
 
 static int idescsi_ide_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	ide_drive_t *drive = inode->type.i_bdev->bd_disk->private_data;
 	drive->usage--;
 	return 0;
 }
@@ -649,7 +649,7 @@ static int idescsi_ide_release(struct in
 static int idescsi_ide_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	return generic_ide_ioctl(bdev, cmd, arg);
 }
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/sd.c inode/drivers/scsi/sd.c
--- bk-linus/drivers/scsi/sd.c	2003-03-08 08:57:28.000000000 -0100
+++ inode/drivers/scsi/sd.c	2003-03-08 08:56:43.000000000 -0100
@@ -377,7 +377,7 @@ queue:
  **/
 static int sd_open(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdev = sdkp->device;
 	int retval;
@@ -397,7 +397,7 @@ static int sd_open(struct inode *inode, 
 		goto error_out;
 
 	if (sdev->removable) {
-		check_disk_change(inode->i_bdev);
+		check_disk_change(inode->type.i_bdev);
 
 		/*
 		 * If the drive is empty, just let the open fail.
@@ -450,7 +450,7 @@ error_out:
  **/
 static int sd_release(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = inode->type.i_bdev->bd_disk;
 	struct scsi_device *sdev = scsi_disk(disk)->device;
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_release: disk=%s\n", disk->disk_name));
@@ -514,7 +514,7 @@ static int sd_hdio_getgeo(struct block_d
 static int sd_ioctl(struct inode * inode, struct file * filp, 
 		    unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = inode->type.i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	struct scsi_device *sdp = scsi_disk(disk)->device;
 	int error;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/sr.c inode/drivers/scsi/sr.c
--- bk-linus/drivers/scsi/sr.c	2003-03-08 08:57:28.000000000 -0100
+++ inode/drivers/scsi/sr.c	2003-03-08 08:56:43.000000000 -0100
@@ -420,20 +420,20 @@ queue:
 
 static int sr_block_open(struct inode *inode, struct file *file)
 {
-	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(inode->type.i_bdev->bd_disk);
 	return cdrom_open(&cd->cdi, inode, file);
 }
 
 static int sr_block_release(struct inode *inode, struct file *file)
 {
-	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(inode->type.i_bdev->bd_disk);
 	return cdrom_release(&cd->cdi, file);
 }
 
 static int sr_block_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			  unsigned long arg)
 {
-	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(inode->type.i_bdev->bd_disk);
 	struct scsi_device *sdev = cd->device;
 
         /*
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/block_dev.c inode/fs/block_dev.c
--- bk-linus/fs/block_dev.c	2003-03-08 08:57:37.000000000 -0100
+++ inode/fs/block_dev.c	2003-03-08 08:56:51.000000000 -0100
@@ -94,10 +94,10 @@ static int
 blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
 {
-	if (iblock >= max_block(inode->i_bdev))
+	if (iblock >= max_block(inode->type.i_bdev))
 		return -EIO;
 
-	bh->b_bdev = inode->i_bdev;
+	bh->b_bdev = inode->type.i_bdev;
 	bh->b_blocknr = iblock;
 	set_buffer_mapped(bh);
 	return 0;
@@ -107,10 +107,10 @@ static int
 blkdev_get_blocks(struct inode *inode, sector_t iblock,
 		unsigned long max_blocks, struct buffer_head *bh, int create)
 {
-	if ((iblock + max_blocks) > max_block(inode->i_bdev))
+	if ((iblock + max_blocks) > max_block(inode->type.i_bdev))
 		return -EIO;
 
-	bh->b_bdev = inode->i_bdev;
+	bh->b_bdev = inode->type.i_bdev;
 	bh->b_blocknr = iblock;
 	bh->b_size = max_blocks << inode->i_blkbits;
 	set_buffer_mapped(bh);
@@ -124,7 +124,7 @@ blkdev_direct_IO(int rw, struct kiocb *i
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	return blockdev_direct_IO(rw, iocb, inode, inode->i_bdev, iov, offset,
+	return blockdev_direct_IO(rw, iocb, inode, inode->type.i_bdev, iov, offset,
 				nr_segs, blkdev_get_blocks);
 }
 
@@ -156,7 +156,7 @@ static int blkdev_commit_write(struct fi
 static loff_t block_llseek(struct file *file, loff_t offset, int origin)
 {
 	/* ewww */
-	loff_t size = file->f_dentry->d_inode->i_bdev->bd_inode->i_size;
+	loff_t size = file->f_dentry->d_inode->type.i_bdev->bd_inode->i_size;
 	loff_t retval;
 
 	lock_kernel();
@@ -188,7 +188,7 @@ static int block_fsync(struct file *filp
 {
 	struct inode * inode = dentry->d_inode;
 
-	return sync_blockdev(inode->i_bdev);
+	return sync_blockdev(inode->type.i_bdev);
 }
 
 /*
@@ -316,7 +316,7 @@ struct block_device *bdget(dev_t dev)
 			new_bdev->bd_invalidated = 0;
 			inode->i_mode = S_IFBLK;
 			inode->i_rdev = kdev;
-			inode->i_bdev = new_bdev;
+			inode->type.i_bdev = new_bdev;
 			inode->i_data.a_ops = &def_blk_aops;
 			inode->i_data.gfp_mask = GFP_USER;
 			inode->i_data.backing_dev_info = &default_backing_dev_info;
@@ -361,7 +361,7 @@ long nr_blockdev_pages(void)
 static inline void __bd_forget(struct inode *inode)
 {
 	list_del_init(&inode->i_devices);
-	inode->i_bdev = NULL;
+	inode->type.i_bdev = NULL;
 	inode->i_mapping = &inode->i_data;
 }
 
@@ -385,8 +385,8 @@ int bd_acquire(struct inode *inode)
 {
 	struct block_device *bdev;
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev) {
-		atomic_inc(&inode->i_bdev->bd_count);
+	if (inode->type.i_bdev) {
+		atomic_inc(&inode->type.i_bdev->bd_count);
 		spin_unlock(&bdev_lock);
 		return 0;
 	}
@@ -395,11 +395,11 @@ int bd_acquire(struct inode *inode)
 	if (!bdev)
 		return -ENOMEM;
 	spin_lock(&bdev_lock);
-	if (!inode->i_bdev) {
-		inode->i_bdev = bdev;
+	if (!inode->type.i_bdev) {
+		inode->type.i_bdev = bdev;
 		inode->i_mapping = bdev->bd_inode->i_mapping;
 		list_add(&inode->i_devices, &bdev->bd_inodes);
-	} else if (inode->i_bdev != bdev)
+	} else if (inode->type.i_bdev != bdev)
 		BUG();
 	spin_unlock(&bdev_lock);
 	return 0;
@@ -410,7 +410,7 @@ int bd_acquire(struct inode *inode)
 void bd_forget(struct inode *inode)
 {
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev)
+	if (inode->type.i_bdev)
 		__bd_forget(inode);
 	spin_unlock(&bdev_lock);
 }
@@ -691,7 +691,7 @@ int blkdev_open(struct inode * inode, st
 	filp->f_flags |= O_LARGEFILE;
 
 	bd_acquire(inode);
-	bdev = inode->i_bdev;
+	bdev = inode->type.i_bdev;
 
 	return do_open(bdev, inode, filp);
 }
@@ -706,7 +706,7 @@ int blkdev_put(struct block_device *bdev
 	switch (kind) {
 	case BDEV_FILE:
 	case BDEV_FS:
-		sync_blockdev(bd_inode->i_bdev);
+		sync_blockdev(bd_inode->type.i_bdev);
 		break;
 	}
 	lock_kernel();
@@ -741,7 +741,7 @@ int blkdev_put(struct block_device *bdev
 
 int blkdev_close(struct inode * inode, struct file * filp)
 {
-	return blkdev_put(inode->i_bdev, BDEV_FILE);
+	return blkdev_put(inode->type.i_bdev, BDEV_FILE);
 }
 
 static ssize_t blkdev_file_write(struct file *file, const char *buf,
@@ -831,7 +831,7 @@ struct block_device *lookup_bdev(const c
 	error = bd_acquire(inode);
 	if (error)
 		goto fail;
-	bdev = inode->i_bdev;
+	bdev = inode->type.i_bdev;
 
 out:
 	path_release(&nd);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/ext2/xattr.c inode/fs/ext2/xattr.c
--- bk-linus/fs/ext2/xattr.c	2003-03-08 08:57:39.000000000 -0100
+++ inode/fs/ext2/xattr.c	2003-03-08 08:56:52.000000000 -0100
@@ -974,7 +974,7 @@ ext2_xattr_cache_find(struct inode *inod
 	if (!header->h_hash)
 		return NULL;  /* never share */
 	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
-	ce = mb_cache_entry_find_first(ext2_xattr_cache, 0, inode->i_bdev, hash);
+	ce = mb_cache_entry_find_first(ext2_xattr_cache, 0, inode->type.i_bdev, hash);
 	while (ce) {
 		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
 
@@ -994,7 +994,7 @@ ext2_xattr_cache_find(struct inode *inod
 			return bh;
 		}
 		brelse(bh);
-		ce = mb_cache_entry_find_next(ce, 0, inode->i_bdev, hash);
+		ce = mb_cache_entry_find_next(ce, 0, inode->type.i_bdev, hash);
 	}
 	return NULL;
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/ext3/xattr.c inode/fs/ext3/xattr.c
--- bk-linus/fs/ext3/xattr.c	2003-03-08 08:57:39.000000000 -0100
+++ inode/fs/ext3/xattr.c	2003-03-08 08:56:53.000000000 -0100
@@ -1013,7 +1013,7 @@ ext3_xattr_cache_find(struct inode *inod
 	if (!header->h_hash)
 		return NULL;  /* never share */
 	ea_idebug(inode, "looking for cached blocks [%x]", (int)hash);
-	ce = mb_cache_entry_find_first(ext3_xattr_cache, 0, inode->i_bdev, hash);
+	ce = mb_cache_entry_find_first(ext3_xattr_cache, 0, inode->type.i_bdev, hash);
 	while (ce) {
 		struct buffer_head *bh = sb_bread(inode->i_sb, ce->e_block);
 
@@ -1033,7 +1033,7 @@ ext3_xattr_cache_find(struct inode *inod
 			return bh;
 		}
 		brelse(bh);
-		ce = mb_cache_entry_find_next(ce, 0, inode->i_bdev, hash);
+		ce = mb_cache_entry_find_next(ce, 0, inode->type.i_bdev, hash);
 	}
 	return NULL;
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/fifo.c inode/fs/fifo.c
--- bk-linus/fs/fifo.c	2003-03-08 08:57:38.000000000 -0100
+++ inode/fs/fifo.c	2003-03-08 08:56:51.000000000 -0100
@@ -38,7 +38,7 @@ static int fifo_open(struct inode *inode
 	if (down_interruptible(PIPE_SEM(*inode)))
 		goto err_nolock_nocleanup;
 
-	if (!inode->i_pipe) {
+	if (!inode->type.i_pipe) {
 		ret = -ENOMEM;
 		if(!pipe_new(inode))
 			goto err_nocleanup;
@@ -133,8 +133,8 @@ err_wr:
 
 err:
 	if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
-		struct pipe_inode_info *info = inode->i_pipe;
-		inode->i_pipe = NULL;
+		struct pipe_inode_info *info = inode->type.i_pipe;
+		inode->type.i_pipe = NULL;
 		free_page((unsigned long)info->base);
 		kfree(info);
 	}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/inode.c inode/fs/inode.c
--- bk-linus/fs/inode.c	2003-03-08 08:57:38.000000000 -0100
+++ inode/fs/inode.c	2003-03-08 08:56:51.000000000 -0100
@@ -126,9 +126,9 @@ static struct inode *alloc_inode(struct 
 		inode->i_bytes = 0;
 		inode->i_generation = 0;
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
-		inode->i_pipe = NULL;
-		inode->i_bdev = NULL;
-		inode->i_cdev = NULL;
+		inode->type.i_pipe = NULL;
+		inode->type.i_bdev = NULL;
+		inode->type.i_cdev = NULL;
 		inode->i_security = NULL;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
@@ -239,11 +239,11 @@ void clear_inode(struct inode *inode)
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
-	if (inode->i_bdev)
+	if (inode->type.i_bdev)
 		bd_forget(inode);
-	else if (inode->i_cdev) {
-		cdput(inode->i_cdev);
-		inode->i_cdev = NULL;
+	else if (inode->type.i_cdev) {
+		cdput(inode->type.i_cdev);
+		inode->type.i_cdev = NULL;
 	}
 	inode->i_state = I_CLEAR;
 }
@@ -1292,7 +1292,7 @@ void init_special_inode(struct inode *in
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = to_kdev_t(rdev);
-		inode->i_cdev = cdget(rdev);
+		inode->type.i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/pipe.c inode/fs/pipe.c
--- bk-linus/fs/pipe.c	2003-03-08 08:57:38.000000000 -0100
+++ inode/fs/pipe.c	2003-03-08 08:56:51.000000000 -0100
@@ -270,8 +270,8 @@ pipe_release(struct inode *inode, int de
 	PIPE_READERS(*inode) -= decr;
 	PIPE_WRITERS(*inode) -= decw;
 	if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
-		struct pipe_inode_info *info = inode->i_pipe;
-		inode->i_pipe = NULL;
+		struct pipe_inode_info *info = inode->type.i_pipe;
+		inode->type.i_pipe = NULL;
 		free_page((unsigned long) info->base);
 		kfree(info);
 	} else {
@@ -478,8 +478,8 @@ struct inode* pipe_new(struct inode* ino
 	if (!page)
 		return NULL;
 
-	inode->i_pipe = kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
-	if (!inode->i_pipe)
+	inode->type.i_pipe = kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
+	if (!inode->type.i_pipe)
 		goto fail_page;
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
@@ -608,8 +608,8 @@ close_f12_inode_i:
 	put_unused_fd(i);
 close_f12_inode:
 	free_page((unsigned long) PIPE_BASE(*inode));
-	kfree(inode->i_pipe);
-	inode->i_pipe = NULL;
+	kfree(inode->type.i_pipe);
+	inode->type.i_pipe = NULL;
 	iput(inode);
 close_f12:
 	put_filp(f2);
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/reiserfs/journal.c inode/fs/reiserfs/journal.c
--- bk-linus/fs/reiserfs/journal.c	2003-03-08 08:57:42.000000000 -0100
+++ inode/fs/reiserfs/journal.c	2003-03-08 08:56:57.000000000 -0100
@@ -1926,16 +1926,16 @@ static int journal_init_dev( struct supe
 		struct inode *jdev_inode;
 
 		jdev_inode = journal -> j_dev_file -> f_dentry -> d_inode;
-		journal -> j_dev_bd = jdev_inode -> i_bdev;
+		journal -> j_dev_bd = jdev_inode -> type.i_bdev;
 		if( !S_ISBLK( jdev_inode -> i_mode ) ) {
 			printk( "journal_init_dev: '%s' is not a block device", jdev_name );
 			result = -ENOTBLK;
-		} else if( jdev_inode -> i_bdev == NULL ) {
+		} else if( jdev_inode -> type.i_bdev == NULL ) {
 			printk( "journal_init_dev: bdev uninitialized for '%s'", jdev_name );
 			result = -ENOMEM;
 		} else  {
 			/* ok */
-			jdev = jdev_inode -> i_bdev -> bd_dev;
+			jdev = jdev_inode -> type.i_bdev -> bd_dev;
 			set_blocksize(journal->j_dev_bd, super->s_blocksize);
 		}
 	} else {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/pipe_fs_i.h inode/include/linux/pipe_fs_i.h
--- bk-linus/include/linux/pipe_fs_i.h	2003-03-08 08:57:58.000000000 -0100
+++ inode/include/linux/pipe_fs_i.h	2003-03-08 08:57:21.000000000 -0100
@@ -21,17 +21,17 @@ struct pipe_inode_info {
 #define PIPE_SIZE		PAGE_SIZE
 
 #define PIPE_SEM(inode)		(&(inode).i_sem)
-#define PIPE_WAIT(inode)	(&(inode).i_pipe->wait)
-#define PIPE_BASE(inode)	((inode).i_pipe->base)
-#define PIPE_START(inode)	((inode).i_pipe->start)
-#define PIPE_LEN(inode)		((inode).i_pipe->len)
-#define PIPE_READERS(inode)	((inode).i_pipe->readers)
-#define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
-#define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
-#define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
-#define PIPE_FASYNC_READERS(inode)     (&((inode).i_pipe->fasync_readers))
-#define PIPE_FASYNC_WRITERS(inode)     (&((inode).i_pipe->fasync_writers))
+#define PIPE_WAIT(inode)	(&(inode).type.i_pipe->wait)
+#define PIPE_BASE(inode)	((inode).type.i_pipe->base)
+#define PIPE_START(inode)	((inode).type.i_pipe->start)
+#define PIPE_LEN(inode)		((inode).type.i_pipe->len)
+#define PIPE_READERS(inode)	((inode).type.i_pipe->readers)
+#define PIPE_WRITERS(inode)	((inode).type.i_pipe->writers)
+#define PIPE_WAITING_WRITERS(inode)	((inode).type.i_pipe->waiting_writers)
+#define PIPE_RCOUNTER(inode)	((inode).type.i_pipe->r_counter)
+#define PIPE_WCOUNTER(inode)	((inode).type.i_pipe->w_counter)
+#define PIPE_FASYNC_READERS(inode)     (&((inode).type.i_pipe->fasync_readers))
+#define PIPE_FASYNC_WRITERS(inode)     (&((inode).type.i_pipe->fasync_writers))
 
 #define PIPE_EMPTY(inode)	(PIPE_LEN(inode) == 0)
 #define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/filemap.c inode/mm/filemap.c
--- bk-linus/mm/filemap.c	2003-03-08 08:58:01.000000000 -0100
+++ inode/mm/filemap.c	2003-03-08 08:57:26.000000000 -0100
@@ -1545,7 +1545,7 @@ inline int generic_write_checks(struct i
 		if (unlikely(*pos + *count > inode->i_sb->s_maxbytes))
 			*count = inode->i_sb->s_maxbytes - *pos;
 	} else {
-		if (bdev_read_only(inode->i_bdev))
+		if (bdev_read_only(inode->type.i_bdev))
 			return -EPERM;
 		if (*pos >= inode->i_size) {
 			if (*count || *pos > inode->i_size)
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/swapfile.c inode/mm/swapfile.c
--- bk-linus/mm/swapfile.c	2003-03-08 08:58:02.000000000 -0100
+++ inode/mm/swapfile.c	2003-03-08 08:57:27.000000000 -0100
@@ -1055,7 +1055,7 @@ asmlinkage long sys_swapoff(const char *
 	vfree(swap_map);
 	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode)) {
 		struct block_device *bdev;
-		bdev = swap_file->f_dentry->d_inode->i_bdev;
+		bdev = swap_file->f_dentry->d_inode->type.i_bdev;
 		set_blocksize(bdev, p->old_block_size);
 		bd_release(bdev);
 	}
@@ -1240,14 +1240,14 @@ asmlinkage long sys_swapon(const char * 
 
 	error = -EINVAL;
 	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode)) {
-		bdev = swap_file->f_dentry->d_inode->i_bdev;
+		bdev = swap_file->f_dentry->d_inode->type.i_bdev;
 		error = bd_claim(bdev, sys_swapon);
 		if (error < 0) {
 			bdev = NULL;
 			goto bad_swap;
 		}
 		p->old_block_size = block_size(bdev);
-		error = set_blocksize(swap_file->f_dentry->d_inode->i_bdev,
+		error = set_blocksize(swap_file->f_dentry->d_inode->type.i_bdev,
 				      PAGE_SIZE);
 		if (error < 0)
 			goto bad_swap;

--gKMricLos+KVdGMg--
