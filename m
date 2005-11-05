Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVKEQhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVKEQhv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVKEQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:37:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:12271 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932100AbVKEQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:19 -0500
Message-Id: <20051105162713.321064000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:57 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, axboe@suse.de,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/25] block: move ioctl32 code to drivers/block/ioctl.c
Content-Disposition: inline; filename=block_ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the conversion handlers in fs/compat_ioctl.c are
specific to block devices, so this patch moves them over
to compat_blkdev_ioctl.

This hopefully gives us a slightly more efficient code
patch for 32 bit block ioctls, and also enables future
cleanups by merging native and compat ioctl implementation.

This patch definitely needs some serious testing.

CC: axboe@suse.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/block/ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/block/ioctl.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/block/ioctl.c	2005-11-05 02:41:31.000000000 +0100
@@ -1,8 +1,12 @@
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/sched.h>		/* for capable() */
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/fd.h>
+#include <linux/hdreg.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
@@ -256,6 +260,438 @@
 	return blkdev_driver_ioctl(inode, file, disk, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int w_long(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	int err;
+	unsigned long val;
+
+	set_fs (KERNEL_DS);
+	err = blkdev_ioctl(inode, file, cmd, (unsigned long)&val);
+	set_fs (old_fs);
+	if (!err && put_user(val, (u32 __user *)compat_ptr(arg)))
+		return -EFAULT;
+	return err;
+}
+
+static int broken_blkgetsize(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	/* The mkswap binary hard codes it to Intel value :-((( */
+	return w_long(inode, file, BLKGETSIZE, arg);
+}
+
+struct hd_geometry32 {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned short cylinders;
+	u32 start;
+};
+
+static int compat_hdio_getgeo(struct inode *inode, struct file *file,
+		unsigned int cmd, struct gendisk *disk, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	struct hd_geometry geo;
+	struct hd_geometry32 __user *ugeo;
+	int err;
+
+	set_fs (KERNEL_DS);
+	err = blkdev_driver_ioctl(inode, file, disk,
+			HDIO_GETGEO, (unsigned long)&geo);
+	set_fs (old_fs);
+	ugeo = compat_ptr(arg);
+	if (!err) {
+		err = copy_to_user (ugeo, &geo, 4);
+		err |= __put_user (geo.start, &ugeo->start);
+	}
+	return err ? -EFAULT : 0;
+}
+
+static int compat_hdio_ioctl(struct inode *inode, struct file *file,
+		struct gendisk *disk, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	unsigned long kval;
+	unsigned int __user *uvp;
+	int error;
+
+	set_fs(KERNEL_DS);
+	error = blkdev_driver_ioctl(inode, file, disk, cmd,
+					(unsigned long)&kval);
+	set_fs(old_fs);
+
+	if (error == 0) {
+		uvp = compat_ptr(arg);
+		if(put_user(kval, uvp))
+			error = -EFAULT;
+	}
+	return error;
+}
+
+struct blkpg_ioctl_arg32 {
+	compat_int_t op;
+	compat_int_t flags;
+	compat_int_t datalen;
+	compat_caddr_t data;
+};
+
+static int compat_blkpg_ioctl(struct block_device *bdev, unsigned int cmd,
+				unsigned long arg)
+{
+	struct blkpg_ioctl_arg32 __user *ua32 = compat_ptr(arg);
+	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
+	compat_caddr_t udata;
+	compat_int_t n;
+	int err;
+
+	err = get_user(n, &ua32->op);
+	err |= put_user(n, &a->op);
+	err |= get_user(n, &ua32->flags);
+	err |= put_user(n, &a->flags);
+	err |= get_user(n, &ua32->datalen);
+	err |= put_user(n, &a->datalen);
+	err |= get_user(udata, &ua32->data);
+	err |= put_user(compat_ptr(udata), &a->data);
+	if (err)
+		return err;
+
+	return blkpg_ioctl(bdev, a);
+}
+
+struct floppy_struct32 {
+	compat_uint_t	size;
+	compat_uint_t	sect;
+	compat_uint_t	head;
+	compat_uint_t	track;
+	compat_uint_t	stretch;
+	unsigned char	gap;
+	unsigned char	rate;
+	unsigned char	spec1;
+	unsigned char	fmt_gap;
+	const compat_caddr_t name;
+};
+
+struct floppy_drive_params32 {
+	char		cmos;
+	compat_ulong_t	max_dtr;
+	compat_ulong_t	hlt;
+	compat_ulong_t	hut;
+	compat_ulong_t	srt;
+	compat_ulong_t	spinup;
+	compat_ulong_t	spindown;
+	unsigned char	spindown_offset;
+	unsigned char	select_delay;
+	unsigned char	rps;
+	unsigned char	tracks;
+	compat_ulong_t	timeout;
+	unsigned char	interleave_sect;
+	struct floppy_max_errors max_errors;
+	char		flags;
+	char		read_track;
+	short		autodetect[8];
+	compat_int_t	checkfreq;
+	compat_int_t	native_format;
+};
+
+struct floppy_drive_struct32 {
+	signed char	flags;
+	compat_ulong_t	spinup_date;
+	compat_ulong_t	select_date;
+	compat_ulong_t	first_read_date;
+	short		probed_format;
+	short		track;
+	short		maxblock;
+	short		maxtrack;
+	compat_int_t	generation;
+	compat_int_t	keep_data;
+	compat_int_t	fd_ref;
+	compat_int_t	fd_device;
+	compat_int_t	last_checked;
+	compat_caddr_t dmabuf;
+	compat_int_t	bufblocks;
+};
+
+struct floppy_fdc_state32 {
+	compat_int_t	spec1;
+	compat_int_t	spec2;
+	compat_int_t	dtr;
+	unsigned char	version;
+	unsigned char	dor;
+	compat_ulong_t	address;
+	unsigned int	rawcmd:2;
+	unsigned int	reset:1;
+	unsigned int	need_configure:1;
+	unsigned int	perp_mode:2;
+	unsigned int	has_fifo:1;
+	unsigned int	driver_version;
+	unsigned char	track[4];
+};
+
+struct floppy_write_errors32 {
+	unsigned int	write_errors;
+	compat_ulong_t	first_error_sector;
+	compat_int_t	first_error_generation;
+	compat_ulong_t	last_error_sector;
+	compat_int_t	last_error_generation;
+	compat_uint_t	badness;
+};
+
+#define FDSETPRM32 _IOW(2, 0x42, struct floppy_struct32)
+#define FDDEFPRM32 _IOW(2, 0x43, struct floppy_struct32)
+#define FDGETPRM32 _IOR(2, 0x04, struct floppy_struct32)
+#define FDSETDRVPRM32 _IOW(2, 0x90, struct floppy_drive_params32)
+#define FDGETDRVPRM32 _IOR(2, 0x11, struct floppy_drive_params32)
+#define FDGETDRVSTAT32 _IOR(2, 0x12, struct floppy_drive_struct32)
+#define FDPOLLDRVSTAT32 _IOR(2, 0x13, struct floppy_drive_struct32)
+#define FDGETFDCSTAT32 _IOR(2, 0x15, struct floppy_fdc_state32)
+#define FDWERRORGET32  _IOR(2, 0x17, struct floppy_write_errors32)
+
+static struct {
+	unsigned int	cmd32;
+	unsigned int	cmd;
+} fd_ioctl_trans_table[] = {
+	{ FDSETPRM32, FDSETPRM },
+	{ FDDEFPRM32, FDDEFPRM },
+	{ FDGETPRM32, FDGETPRM },
+	{ FDSETDRVPRM32, FDSETDRVPRM },
+	{ FDGETDRVPRM32, FDGETDRVPRM },
+	{ FDGETDRVSTAT32, FDGETDRVSTAT },
+	{ FDPOLLDRVSTAT32, FDPOLLDRVSTAT },
+	{ FDGETFDCSTAT32, FDGETFDCSTAT },
+	{ FDWERRORGET32, FDWERRORGET }
+};
+
+#define NR_FD_IOCTL_TRANS (sizeof(fd_ioctl_trans_table)/sizeof(fd_ioctl_trans_table[0]))
+
+static int compat_fd_ioctl(struct inode *inode, struct file *file,
+		struct gendisk *disk, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	void *karg = NULL;
+	unsigned int kcmd = 0;
+	int i, err;
+
+	for (i = 0; i < NR_FD_IOCTL_TRANS; i++)
+		if (cmd == fd_ioctl_trans_table[i].cmd32) {
+			kcmd = fd_ioctl_trans_table[i].cmd;
+			break;
+		}
+	if (!kcmd)
+		return -EINVAL;
+
+	switch (cmd) {
+		case FDSETPRM32:
+		case FDDEFPRM32:
+		case FDGETPRM32:
+		{
+			compat_uptr_t name;
+			struct floppy_struct32 __user *uf;
+			struct floppy_struct *f;
+
+			uf = compat_ptr(arg);
+			f = karg = kmalloc(sizeof(struct floppy_struct), GFP_KERNEL);
+			if (!karg)
+				return -ENOMEM;
+			if (cmd == FDGETPRM32)
+				break;
+			err = __get_user(f->size, &uf->size);
+			err |= __get_user(f->sect, &uf->sect);
+			err |= __get_user(f->head, &uf->head);
+			err |= __get_user(f->track, &uf->track);
+			err |= __get_user(f->stretch, &uf->stretch);
+			err |= __get_user(f->gap, &uf->gap);
+			err |= __get_user(f->rate, &uf->rate);
+			err |= __get_user(f->spec1, &uf->spec1);
+			err |= __get_user(f->fmt_gap, &uf->fmt_gap);
+			err |= __get_user(name, &uf->name);
+			f->name = compat_ptr(name);
+			if (err) {
+				err = -EFAULT;
+				goto out;
+			}
+			break;
+		}
+		case FDSETDRVPRM32:
+		case FDGETDRVPRM32:
+		{
+			struct floppy_drive_params32 __user *uf;
+			struct floppy_drive_params *f;
+
+			uf = compat_ptr(arg);
+			f = karg = kmalloc(sizeof(struct floppy_drive_params), GFP_KERNEL);
+			if (!karg)
+				return -ENOMEM;
+			if (cmd == FDGETDRVPRM32)
+				break;
+			err = __get_user(f->cmos, &uf->cmos);
+			err |= __get_user(f->max_dtr, &uf->max_dtr);
+			err |= __get_user(f->hlt, &uf->hlt);
+			err |= __get_user(f->hut, &uf->hut);
+			err |= __get_user(f->srt, &uf->srt);
+			err |= __get_user(f->spinup, &uf->spinup);
+			err |= __get_user(f->spindown, &uf->spindown);
+			err |= __get_user(f->spindown_offset, &uf->spindown_offset);
+			err |= __get_user(f->select_delay, &uf->select_delay);
+			err |= __get_user(f->rps, &uf->rps);
+			err |= __get_user(f->tracks, &uf->tracks);
+			err |= __get_user(f->timeout, &uf->timeout);
+			err |= __get_user(f->interleave_sect, &uf->interleave_sect);
+			err |= __copy_from_user(&f->max_errors, &uf->max_errors, sizeof(f->max_errors));
+			err |= __get_user(f->flags, &uf->flags);
+			err |= __get_user(f->read_track, &uf->read_track);
+			err |= __copy_from_user(f->autodetect, uf->autodetect, sizeof(f->autodetect));
+			err |= __get_user(f->checkfreq, &uf->checkfreq);
+			err |= __get_user(f->native_format, &uf->native_format);
+			if (err) {
+				err = -EFAULT;
+				goto out;
+			}
+			break;
+		}
+		case FDGETDRVSTAT32:
+		case FDPOLLDRVSTAT32:
+			karg = kmalloc(sizeof(struct floppy_drive_struct), GFP_KERNEL);
+			if (!karg)
+				return -ENOMEM;
+			break;
+		case FDGETFDCSTAT32:
+			karg = kmalloc(sizeof(struct floppy_fdc_state), GFP_KERNEL);
+			if (!karg)
+				return -ENOMEM;
+			break;
+		case FDWERRORGET32:
+			karg = kmalloc(sizeof(struct floppy_write_errors), GFP_KERNEL);
+			if (!karg)
+				return -ENOMEM;
+			break;
+		default:
+			return -EINVAL;
+	}
+	set_fs (KERNEL_DS);
+	err = blkdev_driver_ioctl(inode, file, disk, kcmd, (unsigned long)&karg);
+	set_fs (old_fs);
+	if (err)
+		goto out;
+	switch (cmd) {
+		case FDGETPRM32:
+		{
+			struct floppy_struct *f = karg;
+			struct floppy_struct32 __user *uf = compat_ptr(arg);
+
+			err = __put_user(f->size, &uf->size);
+			err |= __put_user(f->sect, &uf->sect);
+			err |= __put_user(f->head, &uf->head);
+			err |= __put_user(f->track, &uf->track);
+			err |= __put_user(f->stretch, &uf->stretch);
+			err |= __put_user(f->gap, &uf->gap);
+			err |= __put_user(f->rate, &uf->rate);
+			err |= __put_user(f->spec1, &uf->spec1);
+			err |= __put_user(f->fmt_gap, &uf->fmt_gap);
+			err |= __put_user((u64)f->name, (compat_caddr_t __user *)&uf->name);
+			break;
+		}
+		case FDGETDRVPRM32:
+		{
+			struct floppy_drive_params32 __user *uf;
+			struct floppy_drive_params *f = karg;
+
+			uf = compat_ptr(arg);
+			err = __put_user(f->cmos, &uf->cmos);
+			err |= __put_user(f->max_dtr, &uf->max_dtr);
+			err |= __put_user(f->hlt, &uf->hlt);
+			err |= __put_user(f->hut, &uf->hut);
+			err |= __put_user(f->srt, &uf->srt);
+			err |= __put_user(f->spinup, &uf->spinup);
+			err |= __put_user(f->spindown, &uf->spindown);
+			err |= __put_user(f->spindown_offset, &uf->spindown_offset);
+			err |= __put_user(f->select_delay, &uf->select_delay);
+			err |= __put_user(f->rps, &uf->rps);
+			err |= __put_user(f->tracks, &uf->tracks);
+			err |= __put_user(f->timeout, &uf->timeout);
+			err |= __put_user(f->interleave_sect, &uf->interleave_sect);
+			err |= __copy_to_user(&uf->max_errors, &f->max_errors, sizeof(f->max_errors));
+			err |= __put_user(f->flags, &uf->flags);
+			err |= __put_user(f->read_track, &uf->read_track);
+			err |= __copy_to_user(uf->autodetect, f->autodetect, sizeof(f->autodetect));
+			err |= __put_user(f->checkfreq, &uf->checkfreq);
+			err |= __put_user(f->native_format, &uf->native_format);
+			break;
+		}
+		case FDGETDRVSTAT32:
+		case FDPOLLDRVSTAT32:
+		{
+			struct floppy_drive_struct32 __user *uf;
+			struct floppy_drive_struct *f = karg;
+
+			uf = compat_ptr(arg);
+			err = __put_user(f->flags, &uf->flags);
+			err |= __put_user(f->spinup_date, &uf->spinup_date);
+			err |= __put_user(f->select_date, &uf->select_date);
+			err |= __put_user(f->first_read_date, &uf->first_read_date);
+			err |= __put_user(f->probed_format, &uf->probed_format);
+			err |= __put_user(f->track, &uf->track);
+			err |= __put_user(f->maxblock, &uf->maxblock);
+			err |= __put_user(f->maxtrack, &uf->maxtrack);
+			err |= __put_user(f->generation, &uf->generation);
+			err |= __put_user(f->keep_data, &uf->keep_data);
+			err |= __put_user(f->fd_ref, &uf->fd_ref);
+			err |= __put_user(f->fd_device, &uf->fd_device);
+			err |= __put_user(f->last_checked, &uf->last_checked);
+			err |= __put_user((u64)f->dmabuf, &uf->dmabuf);
+			err |= __put_user((u64)f->bufblocks, &uf->bufblocks);
+			break;
+		}
+		case FDGETFDCSTAT32:
+		{
+			struct floppy_fdc_state32 __user *uf;
+			struct floppy_fdc_state *f = karg;
+
+			uf = compat_ptr(arg);
+			err = __put_user(f->spec1, &uf->spec1);
+			err |= __put_user(f->spec2, &uf->spec2);
+			err |= __put_user(f->dtr, &uf->dtr);
+			err |= __put_user(f->version, &uf->version);
+			err |= __put_user(f->dor, &uf->dor);
+			err |= __put_user(f->address, &uf->address);
+			err |= __copy_to_user((char __user *)&uf->address + sizeof(uf->address),
+					   (char *)&f->address + sizeof(f->address), sizeof(int));
+			err |= __put_user(f->driver_version, &uf->driver_version);
+			err |= __copy_to_user(uf->track, f->track, sizeof(f->track));
+			break;
+		}
+		case FDWERRORGET32:
+		{
+			struct floppy_write_errors32 __user *uf;
+			struct floppy_write_errors *f = karg;
+
+			uf = compat_ptr(arg);
+			err = __put_user(f->write_errors, &uf->write_errors);
+			err |= __put_user(f->first_error_sector, &uf->first_error_sector);
+			err |= __put_user(f->first_error_generation, &uf->first_error_generation);
+			err |= __put_user(f->last_error_sector, &uf->last_error_sector);
+			err |= __put_user(f->last_error_generation, &uf->last_error_generation);
+			err |= __put_user(f->badness, &uf->badness);
+			break;
+		}
+		default:
+			break;
+	}
+	if (err)
+		err = -EFAULT;
+
+out:	if (karg) kfree(karg);
+	return err;
+}
+
+
+/* Fix sizeof(sizeof()) breakage */
+#define BLKBSZGET_32   _IOR(0x12,112,int)
+#define BLKBSZSET_32   _IOW(0x12,113,int)
+#define BLKGETSIZE64_32        _IOR(0x12,114,int)
+
 /* Most of the generic ioctls are handled in the normal fallback path.
    This assumes the blkdev's low level compat_ioctl always returns
    ENOIOCTLCMD for unknown ioctls. */
@@ -263,13 +699,115 @@
 {
 	struct block_device *bdev = file->f_dentry->d_inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
+	struct inode *inode = file->f_mapping->host;
 	int ret = -ENOIOCTLCMD;
-	if (disk->fops->compat_ioctl) {
+
+	switch (cmd) {
+	case BLKRAGET:
+	case BLKGETSIZE:
+	case BLKFRAGET:
+	case BLKSECTGET:
+		ret = w_long(inode, file, cmd, arg);
+		break;
+	case 0x1260:
+		ret = broken_blkgetsize(inode, file, cmd, arg);
+		break;
+	case BLKBSZGET_32:
+		lock_kernel();
+		ret = blkdev_locked_ioctl(file, bdev, BLKBSZGET,
+				(unsigned long)compat_ptr(arg));
+		unlock_kernel();
+		break;
+	case BLKBSZSET_32:
+		lock_kernel();
+		ret = blkdev_locked_ioctl(file, bdev, BLKBSZSET,
+				(unsigned long)compat_ptr(arg));
+		unlock_kernel();
+		break;
+	case BLKGETSIZE64_32:
+		lock_kernel();
+		ret = blkdev_locked_ioctl(file, bdev, BLKGETSIZE64,
+				(unsigned long)compat_ptr(arg));
+		unlock_kernel();
+		break;
+	case BLKROSET:
+	case BLKROGET:
+	case BLKRRPART:
+	case BLKFLSBUF:
+	case BLKSECTSET:
+	case BLKSSZGET:
+	case BLKRASET:
+	case BLKFRASET:
+		ret = blkdev_ioctl(inode, file, cmd, arg);
+		break;
+	case BLKPG:
+		lock_kernel();
+		ret = compat_blkpg_ioctl(bdev, cmd, arg);
+		unlock_kernel();
+		break;
+	case HDIO_GETGEO:
+		ret = compat_hdio_getgeo(inode, file, cmd, disk, arg);
+		break;
+	case HDIO_GET_KEEPSETTINGS:
+	case HDIO_GET_UNMASKINTR:
+	case HDIO_GET_DMA:
+	case HDIO_GET_32BIT:
+	case HDIO_GET_MULTCOUNT:
+	case HDIO_GET_NOWERR:
+	case HDIO_GET_NICE:
+		ret = compat_hdio_ioctl(inode, file, disk, cmd, arg);
+		break;
+	case HDIO_GET_IDENTITY:
+	case HDIO_SET_DMA:
+	case HDIO_SET_UNMASKINTR:
+	case HDIO_SET_NOWERR:
+	case HDIO_SET_32BIT:
+	case HDIO_SET_MULTCOUNT:
+	case HDIO_DRIVE_CMD:
+	case HDIO_DRIVE_TASK:
+	case HDIO_SET_PIO_MODE:
+	case HDIO_SET_NICE:
+		ret = blkdev_driver_ioctl(inode, file, disk, cmd, arg);
+		break;
+	case FDSETPRM32:
+	case FDDEFPRM32:
+	case FDGETPRM32:
+	case FDSETDRVPRM32:
+	case FDGETDRVPRM32:
+	case FDGETDRVSTAT32:
+	case FDPOLLDRVSTAT32:
+	case FDGETFDCSTAT32:
+	case FDWERRORGET32:
+		ret = compat_fd_ioctl(inode, file, disk, cmd, arg);
+		break;
+	case FDMSGON:
+	case FDMSGOFF:
+	case FDSETEMSGTRESH:
+	case FDFLUSH:
+	case FDWERRORCLR:
+	case FDSETMAXERRS:
+	case FDGETMAXERRS:
+	case FDGETDRVTYP:
+	case FDEJECT:
+	case FDCLRPRM:
+	case FDFMTBEG:
+	case FDFMTEND:
+	case FDRESET:
+	case FDTWADDLE:
+	case FDFMTTRK:
+	case FDRAWCMD:
+		ret = blkdev_driver_ioctl(inode, file, disk, cmd, arg);
+		break;
+	}
+
+	if (ret == -ENOIOCTLCMD && disk->fops->compat_ioctl) {
 		lock_kernel();
 		ret = disk->fops->compat_ioctl(file, cmd, arg);
 		unlock_kernel();
 	}
+
 	return ret;
 }
+#endif
 
 EXPORT_SYMBOL_GPL(blkdev_ioctl);
Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:30.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:31.000000000 +0100
@@ -413,31 +413,6 @@
 	return err;
 }
 
-struct hd_geometry32 {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned short cylinders;
-	u32 start;
-};
-                        
-static int hdio_getgeo(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct hd_geometry geo;
-	struct hd_geometry32 __user *ugeo;
-	int err;
-	
-	set_fs (KERNEL_DS);
-	err = sys_ioctl(fd, HDIO_GETGEO, (unsigned long)&geo);
-	set_fs (old_fs);
-	ugeo = compat_ptr(arg);
-	if (!err) {
-		err = copy_to_user (ugeo, &geo, 4);
-		err |= __put_user (geo.start, &ugeo->start);
-	}
-	return err ? -EFAULT : 0;
-}
-
 struct fb_fix_screeninfo32 {
 	char			id[16];
         compat_caddr_t	smem_start;
@@ -578,26 +553,6 @@
 	return err;
 }
 
-static int hdio_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	unsigned long kval;
-	unsigned int __user *uvp;
-	int error;
-
-	set_fs(KERNEL_DS);
-	error = sys_ioctl(fd, cmd, (long)&kval);
-	set_fs(old_fs);
-
-	if(error == 0) {
-		uvp = compat_ptr(arg);
-		if(put_user(kval, uvp))
-			error = -EFAULT;
-	}
-	return error;
-}
-
-
 typedef struct sg_io_hdr32 {
 	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
 	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
@@ -1147,67 +1102,11 @@
 	return -EINVAL;
 }
 
-static int broken_blkgetsize(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	/* The mkswap binary hard codes it to Intel value :-((( */
-	return w_long(fd, BLKGETSIZE, arg);
-}
-
-struct blkpg_ioctl_arg32 {
-	compat_int_t op;
-	compat_int_t flags;
-	compat_int_t datalen;
-	compat_caddr_t data;
-};
-
-static int blkpg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct blkpg_ioctl_arg32 __user *ua32 = compat_ptr(arg);
-	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
-	compat_caddr_t udata;
-	compat_int_t n;
-	int err;
-	
-	err = get_user(n, &ua32->op);
-	err |= put_user(n, &a->op);
-	err |= get_user(n, &ua32->flags);
-	err |= put_user(n, &a->flags);
-	err |= get_user(n, &ua32->datalen);
-	err |= put_user(n, &a->datalen);
-	err |= get_user(udata, &ua32->data);
-	err |= put_user(compat_ptr(udata), &a->data);
-	if (err)
-		return err;
-
-	return sys_ioctl(fd, cmd, (unsigned long)a);
-}
-
 static int ioc_settimeout(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	return rw_long(fd, AUTOFS_IOC_SETTIMEOUT, arg);
 }
 
-/* Fix sizeof(sizeof()) breakage */
-#define BLKBSZGET_32   _IOR(0x12,112,int)
-#define BLKBSZSET_32   _IOW(0x12,113,int)
-#define BLKGETSIZE64_32        _IOR(0x12,114,int)
-
-static int do_blkbszget(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-       return sys_ioctl(fd, BLKBSZGET, (unsigned long)compat_ptr(arg));
-}
-
-static int do_blkbszset(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-       return sys_ioctl(fd, BLKBSZSET, (unsigned long)compat_ptr(arg));
-}
-
-static int do_blkgetsize64(unsigned int fd, unsigned int cmd,
-                          unsigned long arg)
-{
-       return sys_ioctl(fd, BLKGETSIZE64, (unsigned long)compat_ptr(arg));
-}
-
 /* Bluetooth ioctls */
 #define HCIUARTSETPROTO	_IOW('U', 200, int)
 #define HCIUARTGETPROTO	_IOR('U', 201, int)
@@ -1227,330 +1126,6 @@
 #define HIDPGETCONNLIST	_IOR('H', 210, int)
 #define HIDPGETCONNINFO	_IOR('H', 211, int)
 
-struct floppy_struct32 {
-	compat_uint_t	size;
-	compat_uint_t	sect;
-	compat_uint_t	head;
-	compat_uint_t	track;
-	compat_uint_t	stretch;
-	unsigned char	gap;
-	unsigned char	rate;
-	unsigned char	spec1;
-	unsigned char	fmt_gap;
-	const compat_caddr_t name;
-};
-
-struct floppy_drive_params32 {
-	char		cmos;
-	compat_ulong_t	max_dtr;
-	compat_ulong_t	hlt;
-	compat_ulong_t	hut;
-	compat_ulong_t	srt;
-	compat_ulong_t	spinup;
-	compat_ulong_t	spindown;
-	unsigned char	spindown_offset;
-	unsigned char	select_delay;
-	unsigned char	rps;
-	unsigned char	tracks;
-	compat_ulong_t	timeout;
-	unsigned char	interleave_sect;
-	struct floppy_max_errors max_errors;
-	char		flags;
-	char		read_track;
-	short		autodetect[8];
-	compat_int_t	checkfreq;
-	compat_int_t	native_format;
-};
-
-struct floppy_drive_struct32 {
-	signed char	flags;
-	compat_ulong_t	spinup_date;
-	compat_ulong_t	select_date;
-	compat_ulong_t	first_read_date;
-	short		probed_format;
-	short		track;
-	short		maxblock;
-	short		maxtrack;
-	compat_int_t	generation;
-	compat_int_t	keep_data;
-	compat_int_t	fd_ref;
-	compat_int_t	fd_device;
-	compat_int_t	last_checked;
-	compat_caddr_t dmabuf;
-	compat_int_t	bufblocks;
-};
-
-struct floppy_fdc_state32 {
-	compat_int_t	spec1;
-	compat_int_t	spec2;
-	compat_int_t	dtr;
-	unsigned char	version;
-	unsigned char	dor;
-	compat_ulong_t	address;
-	unsigned int	rawcmd:2;
-	unsigned int	reset:1;
-	unsigned int	need_configure:1;
-	unsigned int	perp_mode:2;
-	unsigned int	has_fifo:1;
-	unsigned int	driver_version;
-	unsigned char	track[4];
-};
-
-struct floppy_write_errors32 {
-	unsigned int	write_errors;
-	compat_ulong_t	first_error_sector;
-	compat_int_t	first_error_generation;
-	compat_ulong_t	last_error_sector;
-	compat_int_t	last_error_generation;
-	compat_uint_t	badness;
-};
-
-#define FDSETPRM32 _IOW(2, 0x42, struct floppy_struct32)
-#define FDDEFPRM32 _IOW(2, 0x43, struct floppy_struct32)
-#define FDGETPRM32 _IOR(2, 0x04, struct floppy_struct32)
-#define FDSETDRVPRM32 _IOW(2, 0x90, struct floppy_drive_params32)
-#define FDGETDRVPRM32 _IOR(2, 0x11, struct floppy_drive_params32)
-#define FDGETDRVSTAT32 _IOR(2, 0x12, struct floppy_drive_struct32)
-#define FDPOLLDRVSTAT32 _IOR(2, 0x13, struct floppy_drive_struct32)
-#define FDGETFDCSTAT32 _IOR(2, 0x15, struct floppy_fdc_state32)
-#define FDWERRORGET32  _IOR(2, 0x17, struct floppy_write_errors32)
-
-static struct {
-	unsigned int	cmd32;
-	unsigned int	cmd;
-} fd_ioctl_trans_table[] = {
-	{ FDSETPRM32, FDSETPRM },
-	{ FDDEFPRM32, FDDEFPRM },
-	{ FDGETPRM32, FDGETPRM },
-	{ FDSETDRVPRM32, FDSETDRVPRM },
-	{ FDGETDRVPRM32, FDGETDRVPRM },
-	{ FDGETDRVSTAT32, FDGETDRVSTAT },
-	{ FDPOLLDRVSTAT32, FDPOLLDRVSTAT },
-	{ FDGETFDCSTAT32, FDGETFDCSTAT },
-	{ FDWERRORGET32, FDWERRORGET }
-};
-
-#define NR_FD_IOCTL_TRANS (sizeof(fd_ioctl_trans_table)/sizeof(fd_ioctl_trans_table[0]))
-
-static int fd_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	void *karg = NULL;
-	unsigned int kcmd = 0;
-	int i, err;
-
-	for (i = 0; i < NR_FD_IOCTL_TRANS; i++)
-		if (cmd == fd_ioctl_trans_table[i].cmd32) {
-			kcmd = fd_ioctl_trans_table[i].cmd;
-			break;
-		}
-	if (!kcmd)
-		return -EINVAL;
-
-	switch (cmd) {
-		case FDSETPRM32:
-		case FDDEFPRM32:
-		case FDGETPRM32:
-		{
-			compat_uptr_t name;
-			struct floppy_struct32 __user *uf;
-			struct floppy_struct *f;
-
-			uf = compat_ptr(arg);
-			f = karg = kmalloc(sizeof(struct floppy_struct), GFP_KERNEL);
-			if (!karg)
-				return -ENOMEM;
-			if (cmd == FDGETPRM32)
-				break;
-			err = __get_user(f->size, &uf->size);
-			err |= __get_user(f->sect, &uf->sect);
-			err |= __get_user(f->head, &uf->head);
-			err |= __get_user(f->track, &uf->track);
-			err |= __get_user(f->stretch, &uf->stretch);
-			err |= __get_user(f->gap, &uf->gap);
-			err |= __get_user(f->rate, &uf->rate);
-			err |= __get_user(f->spec1, &uf->spec1);
-			err |= __get_user(f->fmt_gap, &uf->fmt_gap);
-			err |= __get_user(name, &uf->name);
-			f->name = compat_ptr(name);
-			if (err) {
-				err = -EFAULT;
-				goto out;
-			}
-			break;
-		}
-		case FDSETDRVPRM32:
-		case FDGETDRVPRM32:
-		{
-			struct floppy_drive_params32 __user *uf;
-			struct floppy_drive_params *f;
-
-			uf = compat_ptr(arg);
-			f = karg = kmalloc(sizeof(struct floppy_drive_params), GFP_KERNEL);
-			if (!karg)
-				return -ENOMEM;
-			if (cmd == FDGETDRVPRM32)
-				break;
-			err = __get_user(f->cmos, &uf->cmos);
-			err |= __get_user(f->max_dtr, &uf->max_dtr);
-			err |= __get_user(f->hlt, &uf->hlt);
-			err |= __get_user(f->hut, &uf->hut);
-			err |= __get_user(f->srt, &uf->srt);
-			err |= __get_user(f->spinup, &uf->spinup);
-			err |= __get_user(f->spindown, &uf->spindown);
-			err |= __get_user(f->spindown_offset, &uf->spindown_offset);
-			err |= __get_user(f->select_delay, &uf->select_delay);
-			err |= __get_user(f->rps, &uf->rps);
-			err |= __get_user(f->tracks, &uf->tracks);
-			err |= __get_user(f->timeout, &uf->timeout);
-			err |= __get_user(f->interleave_sect, &uf->interleave_sect);
-			err |= __copy_from_user(&f->max_errors, &uf->max_errors, sizeof(f->max_errors));
-			err |= __get_user(f->flags, &uf->flags);
-			err |= __get_user(f->read_track, &uf->read_track);
-			err |= __copy_from_user(f->autodetect, uf->autodetect, sizeof(f->autodetect));
-			err |= __get_user(f->checkfreq, &uf->checkfreq);
-			err |= __get_user(f->native_format, &uf->native_format);
-			if (err) {
-				err = -EFAULT;
-				goto out;
-			}
-			break;
-		}
-		case FDGETDRVSTAT32:
-		case FDPOLLDRVSTAT32:
-			karg = kmalloc(sizeof(struct floppy_drive_struct), GFP_KERNEL);
-			if (!karg)
-				return -ENOMEM;
-			break;
-		case FDGETFDCSTAT32:
-			karg = kmalloc(sizeof(struct floppy_fdc_state), GFP_KERNEL);
-			if (!karg)
-				return -ENOMEM;
-			break;
-		case FDWERRORGET32:
-			karg = kmalloc(sizeof(struct floppy_write_errors), GFP_KERNEL);
-			if (!karg)
-				return -ENOMEM;
-			break;
-		default:
-			return -EINVAL;
-	}
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, kcmd, (unsigned long)karg);
-	set_fs (old_fs);
-	if (err)
-		goto out;
-	switch (cmd) {
-		case FDGETPRM32:
-		{
-			struct floppy_struct *f = karg;
-			struct floppy_struct32 __user *uf = compat_ptr(arg);
-
-			err = __put_user(f->size, &uf->size);
-			err |= __put_user(f->sect, &uf->sect);
-			err |= __put_user(f->head, &uf->head);
-			err |= __put_user(f->track, &uf->track);
-			err |= __put_user(f->stretch, &uf->stretch);
-			err |= __put_user(f->gap, &uf->gap);
-			err |= __put_user(f->rate, &uf->rate);
-			err |= __put_user(f->spec1, &uf->spec1);
-			err |= __put_user(f->fmt_gap, &uf->fmt_gap);
-			err |= __put_user((u64)f->name, (compat_caddr_t __user *)&uf->name);
-			break;
-		}
-		case FDGETDRVPRM32:
-		{
-			struct floppy_drive_params32 __user *uf;
-			struct floppy_drive_params *f = karg;
-
-			uf = compat_ptr(arg);
-			err = __put_user(f->cmos, &uf->cmos);
-			err |= __put_user(f->max_dtr, &uf->max_dtr);
-			err |= __put_user(f->hlt, &uf->hlt);
-			err |= __put_user(f->hut, &uf->hut);
-			err |= __put_user(f->srt, &uf->srt);
-			err |= __put_user(f->spinup, &uf->spinup);
-			err |= __put_user(f->spindown, &uf->spindown);
-			err |= __put_user(f->spindown_offset, &uf->spindown_offset);
-			err |= __put_user(f->select_delay, &uf->select_delay);
-			err |= __put_user(f->rps, &uf->rps);
-			err |= __put_user(f->tracks, &uf->tracks);
-			err |= __put_user(f->timeout, &uf->timeout);
-			err |= __put_user(f->interleave_sect, &uf->interleave_sect);
-			err |= __copy_to_user(&uf->max_errors, &f->max_errors, sizeof(f->max_errors));
-			err |= __put_user(f->flags, &uf->flags);
-			err |= __put_user(f->read_track, &uf->read_track);
-			err |= __copy_to_user(uf->autodetect, f->autodetect, sizeof(f->autodetect));
-			err |= __put_user(f->checkfreq, &uf->checkfreq);
-			err |= __put_user(f->native_format, &uf->native_format);
-			break;
-		}
-		case FDGETDRVSTAT32:
-		case FDPOLLDRVSTAT32:
-		{
-			struct floppy_drive_struct32 __user *uf;
-			struct floppy_drive_struct *f = karg;
-
-			uf = compat_ptr(arg);
-			err = __put_user(f->flags, &uf->flags);
-			err |= __put_user(f->spinup_date, &uf->spinup_date);
-			err |= __put_user(f->select_date, &uf->select_date);
-			err |= __put_user(f->first_read_date, &uf->first_read_date);
-			err |= __put_user(f->probed_format, &uf->probed_format);
-			err |= __put_user(f->track, &uf->track);
-			err |= __put_user(f->maxblock, &uf->maxblock);
-			err |= __put_user(f->maxtrack, &uf->maxtrack);
-			err |= __put_user(f->generation, &uf->generation);
-			err |= __put_user(f->keep_data, &uf->keep_data);
-			err |= __put_user(f->fd_ref, &uf->fd_ref);
-			err |= __put_user(f->fd_device, &uf->fd_device);
-			err |= __put_user(f->last_checked, &uf->last_checked);
-			err |= __put_user((u64)f->dmabuf, &uf->dmabuf);
-			err |= __put_user((u64)f->bufblocks, &uf->bufblocks);
-			break;
-		}
-		case FDGETFDCSTAT32:
-		{
-			struct floppy_fdc_state32 __user *uf;
-			struct floppy_fdc_state *f = karg;
-
-			uf = compat_ptr(arg);
-			err = __put_user(f->spec1, &uf->spec1);
-			err |= __put_user(f->spec2, &uf->spec2);
-			err |= __put_user(f->dtr, &uf->dtr);
-			err |= __put_user(f->version, &uf->version);
-			err |= __put_user(f->dor, &uf->dor);
-			err |= __put_user(f->address, &uf->address);
-			err |= __copy_to_user((char __user *)&uf->address + sizeof(uf->address),
-					   (char *)&f->address + sizeof(f->address), sizeof(int));
-			err |= __put_user(f->driver_version, &uf->driver_version);
-			err |= __copy_to_user(uf->track, f->track, sizeof(f->track));
-			break;
-		}
-		case FDWERRORGET32:
-		{
-			struct floppy_write_errors32 __user *uf;
-			struct floppy_write_errors *f = karg;
-
-			uf = compat_ptr(arg);
-			err = __put_user(f->write_errors, &uf->write_errors);
-			err |= __put_user(f->first_error_sector, &uf->first_error_sector);
-			err |= __put_user(f->first_error_generation, &uf->first_error_generation);
-			err |= __put_user(f->last_error_sector, &uf->last_error_sector);
-			err |= __put_user(f->last_error_generation, &uf->last_error_generation);
-			err |= __put_user(f->badness, &uf->badness);
-			break;
-		}
-		default:
-			break;
-	}
-	if (err)
-		err = -EFAULT;
-
-out:	if (karg) kfree(karg);
-	return err;
-}
-
 #define	VFAT_IOCTL_READDIR_BOTH32	_IOR('r', 1, struct compat_dirent[2])
 #define	VFAT_IOCTL_READDIR_SHORT32	_IOR('r', 2, struct compat_dirent[2])
 
@@ -2104,32 +1679,9 @@
 #endif
 
 #ifdef DECLARES
-HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
-HANDLE_IOCTL(BLKRAGET, w_long)
-HANDLE_IOCTL(BLKGETSIZE, w_long)
-HANDLE_IOCTL(0x1260, broken_blkgetsize)
-HANDLE_IOCTL(BLKFRAGET, w_long)
-HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(FBIOGET_FSCREENINFO, fb_ioctl_trans)
-HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
 HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_KEEPSETTINGS, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_UNMASKINTR, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_DMA, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_32BIT, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_MULTCOUNT, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_NOWERR, hdio_ioctl_trans)
-HANDLE_IOCTL(HDIO_GET_NICE, hdio_ioctl_trans)
-HANDLE_IOCTL(FDSETPRM32, fd_ioctl_trans)
-HANDLE_IOCTL(FDDEFPRM32, fd_ioctl_trans)
-HANDLE_IOCTL(FDGETPRM32, fd_ioctl_trans)
-HANDLE_IOCTL(FDSETDRVPRM32, fd_ioctl_trans)
-HANDLE_IOCTL(FDGETDRVPRM32, fd_ioctl_trans)
-HANDLE_IOCTL(FDGETDRVSTAT32, fd_ioctl_trans)
-HANDLE_IOCTL(FDPOLLDRVSTAT32, fd_ioctl_trans)
-HANDLE_IOCTL(FDGETFDCSTAT32, fd_ioctl_trans)
-HANDLE_IOCTL(FDWERRORGET32, fd_ioctl_trans)
 HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
@@ -2161,10 +1713,6 @@
 /* One SMB ioctl needs translations. */
 #define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
-/* block stuff */
-HANDLE_IOCTL(BLKBSZGET_32, do_blkbszget)
-HANDLE_IOCTL(BLKBSZSET_32, do_blkbszset)
-HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgetsize64)
 /* vfat */
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:30.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:31.000000000 +0100
@@ -68,45 +68,6 @@
 /* 0x00 */
 COMPATIBLE_IOCTL(FIBMAP)
 COMPATIBLE_IOCTL(FIGETBSZ)
-/* 0x03 -- HD/IDE ioctl's used by hdparm and friends.
- *         Some need translations, these do not.
- */
-COMPATIBLE_IOCTL(HDIO_GET_IDENTITY)
-COMPATIBLE_IOCTL(HDIO_SET_DMA)
-COMPATIBLE_IOCTL(HDIO_SET_UNMASKINTR)
-COMPATIBLE_IOCTL(HDIO_SET_NOWERR)
-COMPATIBLE_IOCTL(HDIO_SET_32BIT)
-COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT)
-COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
-COMPATIBLE_IOCTL(HDIO_DRIVE_TASK)
-COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
-COMPATIBLE_IOCTL(HDIO_SET_NICE)
-/* 0x02 -- Floppy ioctls */
-COMPATIBLE_IOCTL(FDMSGON)
-COMPATIBLE_IOCTL(FDMSGOFF)
-COMPATIBLE_IOCTL(FDSETEMSGTRESH)
-COMPATIBLE_IOCTL(FDFLUSH)
-COMPATIBLE_IOCTL(FDWERRORCLR)
-COMPATIBLE_IOCTL(FDSETMAXERRS)
-COMPATIBLE_IOCTL(FDGETMAXERRS)
-COMPATIBLE_IOCTL(FDGETDRVTYP)
-COMPATIBLE_IOCTL(FDEJECT)
-COMPATIBLE_IOCTL(FDCLRPRM)
-COMPATIBLE_IOCTL(FDFMTBEG)
-COMPATIBLE_IOCTL(FDFMTEND)
-COMPATIBLE_IOCTL(FDRESET)
-COMPATIBLE_IOCTL(FDTWADDLE)
-COMPATIBLE_IOCTL(FDFMTTRK)
-COMPATIBLE_IOCTL(FDRAWCMD)
-/* 0x12 */
-COMPATIBLE_IOCTL(BLKROSET)
-COMPATIBLE_IOCTL(BLKROGET)
-COMPATIBLE_IOCTL(BLKRRPART)
-COMPATIBLE_IOCTL(BLKFLSBUF)
-COMPATIBLE_IOCTL(BLKSECTSET)
-COMPATIBLE_IOCTL(BLKSSZGET)
-ULONG_IOCTL(BLKRASET)
-ULONG_IOCTL(BLKFRASET)
 /* RAID */
 COMPATIBLE_IOCTL(RAID_VERSION)
 COMPATIBLE_IOCTL(GET_ARRAY_INFO)

--

