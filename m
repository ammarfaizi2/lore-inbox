Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTEGKRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTEGKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:17:44 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:11461 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263077AbTEGKR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:17:28 -0400
Date: Wed, 7 May 2003 12:27:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507102744.GA258@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This enables sg_io stuff to be shared across architectures and makes
setserial support works on all architectures.

Only change *needed* in each architecture is moving A() macros into
compat.h, so that generic code can use it. Please apply,

								Pavel

--- linux.clean/arch/x86_64/ia32/ia32_ioctl.c	2003-05-05 15:53:57.000000000 -0700
+++ linux/arch/x86_64/ia32/ia32_ioctl.c	2003-05-06 14:16:12.000000000 -0700
@@ -108,10 +108,6 @@
 
 #include <asm/mtrr.h>
 
-
-#define A(__x) ((void *)(unsigned long)(__x))
-#define AA(__x)	A(__x)
-
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
 #define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
@@ -1333,235 +1329,6 @@
 	return err;
 }
 
-
-typedef struct sg_io_hdr32 {
-	s32 interface_id;	/* [i] 'S' for SCSI generic (required) */
-	s32 dxfer_direction;	/* [i] data transfer direction  */
-	u8  cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
-	u8  mx_sb_len;		/* [i] max length to write to sbp */
-	u16 iovec_count;	/* [i] 0 implies no scatter gather */
-	u32 dxfer_len;		/* [i] byte count of data transfer */
-	u32 dxferp;		/* [i], [*io] points to data transfer memory
-					      or scatter gather list */
-	u32 cmdp;		/* [i], [*i] points to command to perform */
-	u32 sbp;		/* [i], [*o] points to sense_buffer memory */
-	u32 timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
-	u32 flags;		/* [i] 0 -> default, see SG_FLAG... */
-	s32 pack_id;		/* [i->o] unused internally (normally) */
-	u32 usr_ptr;		/* [i->o] unused internally */
-	u8  status;		/* [o] scsi status */
-	u8  masked_status;	/* [o] shifted, masked scsi status */
-	u8  msg_status;		/* [o] messaging level data (optional) */
-	u8  sb_len_wr;		/* [o] byte count actually written to sbp */
-	u16 host_status;	/* [o] errors from host adapter */
-	u16 driver_status;	/* [o] errors from software driver */
-	s32 resid;		/* [o] dxfer_len - actual_transferred */
-	u32 duration;		/* [o] time taken by cmd (unit: millisec) */
-	u32 info;		/* [o] auxiliary information */
-} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
-
-typedef struct sg_iovec32 {
-	u32 iov_base;
-	u32 iov_len;
-} sg_iovec32_t;
-
-static int alloc_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
-{
-	sg_iovec32_t *uiov = (sg_iovec32_t *) A(uptr32);
-	sg_iovec_t *kiov;
-	int i;
-
-	sgp->dxferp = kmalloc(sgp->iovec_count *
-			      sizeof(sg_iovec_t), GFP_KERNEL);
-	if (!sgp->dxferp)
-		return -ENOMEM;
-	memset(sgp->dxferp, 0,
-	       sgp->iovec_count * sizeof(sg_iovec_t));
-
-	kiov = (sg_iovec_t *) sgp->dxferp;
-	for (i = 0; i < sgp->iovec_count; i++) {
-		u32 iov_base32;
-		if (__get_user(iov_base32, &uiov->iov_base) ||
-		    __get_user(kiov->iov_len, &uiov->iov_len))
-			return -EFAULT;
-
-		kiov->iov_base = kmalloc(kiov->iov_len, GFP_KERNEL);
-		if (!kiov->iov_base)
-			return -ENOMEM;
-		if (copy_from_user(kiov->iov_base,
-				   (void *) A(iov_base32),
-				   kiov->iov_len))
-			return -EFAULT;
-
-		uiov++;
-		kiov++;
-	}
-
-	return 0;
-}
-
-static int copy_back_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
-{
-	sg_iovec32_t *uiov = (sg_iovec32_t *) A(uptr32);
-	sg_iovec_t *kiov = (sg_iovec_t *) sgp->dxferp;
-	int i;
-
-	for (i = 0; i < sgp->iovec_count; i++) {
-		u32 iov_base32;
-
-		if (__get_user(iov_base32, &uiov->iov_base))
-			return -EFAULT;
-
-		if (copy_to_user((void *) A(iov_base32),
-				 kiov->iov_base,
-				 kiov->iov_len))
-			return -EFAULT;
-
-		uiov++;
-		kiov++;
-	}
-
-	return 0;
-}
-
-static void free_sg_iovec(sg_io_hdr_t *sgp)
-{
-	sg_iovec_t *kiov = (sg_iovec_t *) sgp->dxferp;
-	int i;
-
-	for (i = 0; i < sgp->iovec_count; i++) {
-		if (kiov->iov_base) {
-			kfree(kiov->iov_base);
-			kiov->iov_base = NULL;
-		}
-		kiov++;
-	}
-	kfree(sgp->dxferp);
-	sgp->dxferp = NULL;
-}
-
-static int sg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	sg_io_hdr32_t *sg_io32;
-	sg_io_hdr_t sg_io64;
-	u32 dxferp32, cmdp32, sbp32;
-	mm_segment_t old_fs;
-	int err = 0;
-
-	sg_io32 = (sg_io_hdr32_t *)arg;
-	err = __get_user(sg_io64.interface_id, &sg_io32->interface_id);
-	err |= __get_user(sg_io64.dxfer_direction, &sg_io32->dxfer_direction);
-	err |= __get_user(sg_io64.cmd_len, &sg_io32->cmd_len);
-	err |= __get_user(sg_io64.mx_sb_len, &sg_io32->mx_sb_len);
-	err |= __get_user(sg_io64.iovec_count, &sg_io32->iovec_count);
-	err |= __get_user(sg_io64.dxfer_len, &sg_io32->dxfer_len);
-	err |= __get_user(sg_io64.timeout, &sg_io32->timeout);
-	err |= __get_user(sg_io64.flags, &sg_io32->flags);
-	err |= __get_user(sg_io64.pack_id, &sg_io32->pack_id);
-
-	sg_io64.dxferp = NULL;
-	sg_io64.cmdp = NULL;
-	sg_io64.sbp = NULL;
-
-	err |= __get_user(cmdp32, &sg_io32->cmdp);
-	sg_io64.cmdp = kmalloc(sg_io64.cmd_len, GFP_KERNEL);
-	if (!sg_io64.cmdp) {
-		err = -ENOMEM;
-		goto out;
-	}
-	if (copy_from_user(sg_io64.cmdp,
-			   (void *) A(cmdp32),
-			   sg_io64.cmd_len)) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	err |= __get_user(sbp32, &sg_io32->sbp);
-	sg_io64.sbp = kmalloc(sg_io64.mx_sb_len, GFP_KERNEL);
-	if (!sg_io64.sbp) {
-		err = -ENOMEM;
-		goto out;
-	}
-	if (copy_from_user(sg_io64.sbp,
-			   (void *) A(sbp32),
-			   sg_io64.mx_sb_len)) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	err |= __get_user(dxferp32, &sg_io32->dxferp);
-	if (sg_io64.iovec_count) {
-		int ret;
-
-		if ((ret = alloc_sg_iovec(&sg_io64, dxferp32))) {
-			err = ret;
-			goto out;
-		}
-	} else {
-		sg_io64.dxferp = kmalloc(sg_io64.dxfer_len, GFP_KERNEL);
-		if (!sg_io64.dxferp) {
-			err = -ENOMEM;
-			goto out;
-		}
-		if (copy_from_user(sg_io64.dxferp,
-				   (void *) A(dxferp32),
-				   sg_io64.dxfer_len)) {
-			err = -EFAULT;
-			goto out;
-		}
-	}
-
-	/* Unused internally, do not even bother to copy it over. */
-	sg_io64.usr_ptr = NULL;
-
-	if (err)
-		return -EFAULT;
-
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, cmd, (unsigned long) &sg_io64);
-	set_fs (old_fs);
-
-	if (err < 0)
-		goto out;
-
-	err = __put_user(sg_io64.pack_id, &sg_io32->pack_id);
-	err |= __put_user(sg_io64.status, &sg_io32->status);
-	err |= __put_user(sg_io64.masked_status, &sg_io32->masked_status);
-	err |= __put_user(sg_io64.msg_status, &sg_io32->msg_status);
-	err |= __put_user(sg_io64.sb_len_wr, &sg_io32->sb_len_wr);
-	err |= __put_user(sg_io64.host_status, &sg_io32->host_status);
-	err |= __put_user(sg_io64.driver_status, &sg_io32->driver_status);
-	err |= __put_user(sg_io64.resid, &sg_io32->resid);
-	err |= __put_user(sg_io64.duration, &sg_io32->duration);
-	err |= __put_user(sg_io64.info, &sg_io32->info);
-	err |= copy_to_user((void *)A(sbp32), sg_io64.sbp, sg_io64.mx_sb_len);
-	if (sg_io64.dxferp) {
-		if (sg_io64.iovec_count)
-			err |= copy_back_sg_iovec(&sg_io64, dxferp32);
-		else
-			err |= copy_to_user((void *)A(dxferp32),
-					    sg_io64.dxferp,
-					    sg_io64.dxfer_len);
-	}
-	if (err)
-		err = -EFAULT;
-
-out:
-	if (sg_io64.cmdp)
-		kfree(sg_io64.cmdp);
-	if (sg_io64.sbp)
-		kfree(sg_io64.sbp);
-	if (sg_io64.dxferp) {
-		if (sg_io64.iovec_count) {
-			free_sg_iovec(&sg_io64);
-		} else {
-			kfree(sg_io64.dxferp);
-		}
-	}
-	return err;
-}
-
 struct sock_fprog32 {
 	__u16	len;
 	__u32	filter;
@@ -3190,8 +2957,6 @@
 
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)
-HANDLE_IOCTL(TIOCGSERIAL, serial_struct_ioctl)
-HANDLE_IOCTL(TIOCSSERIAL, serial_struct_ioctl)
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
 #ifdef CONFIG_NET
@@ -3274,7 +3039,6 @@
 HANDLE_IOCTL(FDPOLLDRVSTAT32, fd_ioctl_trans)
 HANDLE_IOCTL(FDGETFDCSTAT32, fd_ioctl_trans)
 HANDLE_IOCTL(FDWERRORGET32, fd_ioctl_trans)
-HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
 HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
 HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
--- linux.clean/drivers/block/Makefile	2003-05-05 15:49:42.000000000 -0700
+++ linux/drivers/block/Makefile	2003-05-06 13:53:24.000000000 -0700
@@ -25,7 +25,7 @@
 obj-$(CONFIG_BLK_DEV_PS2)	+= ps2esdi.o
 obj-$(CONFIG_BLK_DEV_XD)	+= xd.o
 obj-$(CONFIG_BLK_CPQ_DA)	+= cpqarray.o
-obj-$(CONFIG_BLK_CPQ_CISS_DA)  += cciss.o
+obj-$(CONFIG_BLK_CPQ_CISS_DA)	+= cciss.o
 obj-$(CONFIG_BLK_DEV_DAC960)	+= DAC960.o
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
--- linux.clean/drivers/block/scsi_ioctl.c	2003-05-05 15:49:42.000000000 -0700
+++ linux/drivers/block/scsi_ioctl.c	2003-05-07 04:51:52.000000000 -0700
@@ -15,6 +15,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
  *
+ * Changes:
+ * Pavel Machek <pavel@suse.cz> 05/2003
+ * - move ioctl32 emulation here [this patch is dedicated to johanka@root.cz]
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -25,12 +28,14 @@
 #include <linux/cdrom.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
+#include <linux/compat.h>
+#include <linux/ioctl32.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
 
-
 /* Command group 3 is reserved and should never be used.  */
 const unsigned char scsi_command_size[8] =
 {
@@ -294,6 +299,213 @@
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+typedef struct sg_io_hdr32 {
+	s32 interface_id;	/* [i] 'S' for SCSI generic (required) */
+	s32 dxfer_direction;	/* [i] data transfer direction  */
+	u8  cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
+	u8  mx_sb_len;		/* [i] max length to write to sbp */
+	u16 iovec_count;	/* [i] 0 implies no scatter gather */
+	u32 dxfer_len;		/* [i] byte count of data transfer */
+	u32 dxferp;		/* [i], [*io] points to data transfer memory
+					      or scatter gather list */
+	u32 cmdp;		/* [i], [*i] points to command to perform */
+	u32 sbp;		/* [i], [*o] points to sense_buffer memory */
+	u32 timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
+	u32 flags;		/* [i] 0 -> default, see SG_FLAG... */
+	s32 pack_id;		/* [i->o] unused internally (normally) */
+	u32 usr_ptr;		/* [i->o] unused internally */
+	u8  status;		/* [o] scsi status */
+	u8  masked_status;	/* [o] shifted, masked scsi status */
+	u8  msg_status;		/* [o] messaging level data (optional) */
+	u8  sb_len_wr;		/* [o] byte count actually written to sbp */
+	u16 host_status;	/* [o] errors from host adapter */
+	u16 driver_status;	/* [o] errors from software driver */
+	s32 resid;		/* [o] dxfer_len - actual_transferred */
+	u32 duration;		/* [o] time taken by cmd (unit: millisec) */
+	u32 info;		/* [o] auxiliary information */
+} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
+
+typedef struct sg_iovec32 {
+	u32 iov_base;
+	u32 iov_len;
+} sg_iovec32_t;
+
+#define EMU_SG_MAX 128
+
+static int alloc_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
+{
+	sg_iovec32_t *uiov = (sg_iovec32_t *) A(uptr32);
+	sg_iovec_t *kiov;
+	int i;
+
+	if (sgp->iovec_count > EMU_SG_MAX)
+		return -EINVAL;
+	sgp->dxferp = kmalloc(sgp->iovec_count *
+			      sizeof(sg_iovec_t), GFP_KERNEL);
+	if (!sgp->dxferp)
+		return -ENOMEM;
+	memset(sgp->dxferp, 0,
+	       sgp->iovec_count * sizeof(sg_iovec_t));
+
+	kiov = (sg_iovec_t *) sgp->dxferp;
+	for (i = 0; i < sgp->iovec_count; i++) {
+		u32 iov_base32;
+		if (__get_user(iov_base32, &uiov->iov_base) ||
+		    __get_user(kiov->iov_len, &uiov->iov_len))
+			return -EFAULT;
+		if (verify_area(VERIFY_WRITE, (void *)A(iov_base32), kiov->iov_len))
+			return -EFAULT;
+		kiov->iov_base = (void *)A(iov_base32);
+		uiov++;
+		kiov++;
+	}
+
+	return 0;
+}
+
+static void free_sg_iovec(sg_io_hdr_t *sgp)
+{
+	kfree(sgp->dxferp);
+	sgp->dxferp = NULL;
+}
+
+static int sg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *f)
+{
+	sg_io_hdr32_t *sg_io32;
+	sg_io_hdr_t sg_io64;
+	u32 dxferp32, cmdp32, sbp32;
+	mm_segment_t old_fs;
+	int err = 0;
+
+	sg_io32 = (sg_io_hdr32_t *)arg;
+	err = __get_user(sg_io64.interface_id, &sg_io32->interface_id);
+	err |= __get_user(sg_io64.dxfer_direction, &sg_io32->dxfer_direction);
+	err |= __get_user(sg_io64.cmd_len, &sg_io32->cmd_len);
+	err |= __get_user(sg_io64.mx_sb_len, &sg_io32->mx_sb_len);
+	err |= __get_user(sg_io64.iovec_count, &sg_io32->iovec_count);
+	err |= __get_user(sg_io64.dxfer_len, &sg_io32->dxfer_len);
+	err |= __get_user(sg_io64.timeout, &sg_io32->timeout);
+	err |= __get_user(sg_io64.flags, &sg_io32->flags);
+	err |= __get_user(sg_io64.pack_id, &sg_io32->pack_id);
+
+	sg_io64.dxferp = NULL;
+	sg_io64.cmdp = NULL;
+	sg_io64.sbp = NULL;
+
+	err |= __get_user(cmdp32, &sg_io32->cmdp);
+	sg_io64.cmdp = kmalloc(sg_io64.cmd_len, GFP_KERNEL);
+	if (!sg_io64.cmdp) {
+		err = -ENOMEM;
+		goto out;
+	}
+	if (copy_from_user(sg_io64.cmdp,
+			   (void *) A(cmdp32),
+			   sg_io64.cmd_len)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	err |= __get_user(sbp32, &sg_io32->sbp);
+	sg_io64.sbp = kmalloc(sg_io64.mx_sb_len, GFP_KERNEL);
+	if (!sg_io64.sbp) {
+		err = -ENOMEM;
+		goto out;
+	}
+	if (copy_from_user(sg_io64.sbp,
+			   (void *) A(sbp32),
+			   sg_io64.mx_sb_len)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	err |= __get_user(dxferp32, &sg_io32->dxferp);
+	if (sg_io64.iovec_count) {
+		int ret;
+
+		if ((ret = alloc_sg_iovec(&sg_io64, dxferp32))) {
+			err = ret;
+			goto out;
+		}
+	} else {
+		if (sg_io64.dxfer_len > 4*PAGE_SIZE) { 
+			err = -EINVAL;
+			goto out;
+		}
+
+		sg_io64.dxferp = kmalloc(sg_io64.dxfer_len, GFP_KERNEL);
+		if (!sg_io64.dxferp) {
+			err = -ENOMEM;
+			goto out;
+		}
+		if (copy_from_user(sg_io64.dxferp,
+				   (void *) A(dxferp32),
+				   sg_io64.dxfer_len)) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+
+	/* Unused internally, do not even bother to copy it over. */
+	sg_io64.usr_ptr = NULL;
+
+	if (err)
+		return -EFAULT;
+
+	old_fs = get_fs();
+	set_fs (KERNEL_DS);
+	err = sys_ioctl (fd, cmd, (unsigned long) &sg_io64);
+	set_fs (old_fs);
+
+	if (err < 0)
+		goto out;
+
+	err = __put_user(sg_io64.pack_id, &sg_io32->pack_id);
+	err |= __put_user(sg_io64.status, &sg_io32->status);
+	err |= __put_user(sg_io64.masked_status, &sg_io32->masked_status);
+	err |= __put_user(sg_io64.msg_status, &sg_io32->msg_status);
+	err |= __put_user(sg_io64.sb_len_wr, &sg_io32->sb_len_wr);
+	err |= __put_user(sg_io64.host_status, &sg_io32->host_status);
+	err |= __put_user(sg_io64.driver_status, &sg_io32->driver_status);
+	err |= __put_user(sg_io64.resid, &sg_io32->resid);
+	err |= __put_user(sg_io64.duration, &sg_io32->duration);
+	err |= __put_user(sg_io64.info, &sg_io32->info);
+	err |= copy_to_user((void *)A(sbp32), sg_io64.sbp, sg_io64.mx_sb_len);
+	if (sg_io64.dxferp) {
+		if (sg_io64.iovec_count)
+			;
+		else
+			err |= copy_to_user((void *)A(dxferp32),
+					    sg_io64.dxferp,
+					    sg_io64.dxfer_len);
+	}
+	if (err)
+		err = -EFAULT;
+
+out:
+	if (sg_io64.cmdp)
+		kfree(sg_io64.cmdp);
+	if (sg_io64.sbp)
+		kfree(sg_io64.sbp);
+	if (sg_io64.dxferp) {
+		if (sg_io64.iovec_count) {
+			free_sg_iovec(&sg_io64);
+		} else {
+			kfree(sg_io64.dxferp);
+		}
+	}
+	return err;
+}
+
+static int __init init_compat(void)
+{
+	register_ioctl32_conversion(SG_IO, sg_ioctl_trans);
+	return 0;
+}
+
+__initcall(init_compat);
+#endif
+
 #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
 #define START_STOP_TIMEOUT		(60 * HZ)
 #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
--- linux.clean/drivers/scsi/scsi_ioctl.c	2003-04-08 04:20:20.000000000 -0700
+++ linux/drivers/scsi/scsi_ioctl.c	2003-05-06 14:24:19.000000000 -0700
@@ -24,12 +24,12 @@
 #include <scsi/scsi_ioctl.h>
 
 #define NORMAL_RETRIES			5
-#define IOCTL_NORMAL_TIMEOUT			(10 * HZ)
+#define IOCTL_NORMAL_TIMEOUT		(10 * HZ)
 #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
 #define START_STOP_TIMEOUT		(60 * HZ)
 #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
 #define READ_ELEMENT_STATUS_TIMEOUT	(5 * 60 * HZ)
-#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )  /* ZIP-250 on parallel port takes as long! */
+#define READ_DEFECT_DATA_TIMEOUT	(60 * HZ)  /* ZIP-250 on parallel port takes as long! */
 
 #define MAX_BUF PAGE_SIZE
 
@@ -362,8 +362,6 @@
 error:
 	if (buf)
 		kfree(buf);
-
-
 	return result;
 #else
 	{
--- linux.clean/drivers/serial/core.c	2003-05-05 15:50:12.000000000 -0700
+++ linux/drivers/serial/core.c	2003-05-06 14:17:08.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
+#include <linux/ioctl32.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -1147,6 +1148,67 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+struct serial_struct32 {
+	int	type;
+	int	line;
+	unsigned int	port;
+	int	irq;
+	int	flags;
+	int	xmit_fifo_size;
+	int	custom_divisor;
+	int	baud_base;
+	unsigned short	close_delay;
+	char	io_type;
+	char	reserved_char[1];
+	int	hub6;
+	unsigned short	closing_wait; /* time to wait before closing */
+	unsigned short	closing_wait2; /* no longer used... */
+	__u32 iomem_base;
+	unsigned short	iomem_reg_shift;
+	unsigned int	port_high;
+	int	reserved[1];
+};
+
+static int serial_struct_ioctl(unsigned fd, unsigned cmd, unsigned long ptr, struct file *f) 
+{
+	typedef struct serial_struct SS;
+	struct serial_struct32 *ss32 = (void *) ptr; 
+	int err;
+	struct serial_struct ss; 
+	mm_segment_t oldseg = get_fs(); 
+	if (cmd == TIOCSSERIAL) { 
+		if (copy_from_user(&ss, ss32, sizeof(struct serial_struct32)))
+			return -EFAULT;
+		memmove(&ss.iomem_reg_shift, ((char*)&ss.iomem_base)+4, 
+			sizeof(SS)-offsetof(SS,iomem_reg_shift)); 
+		ss.iomem_base = (void *)((unsigned long)ss.iomem_base & 0xffffffff);
+	}
+	set_fs(KERNEL_DS);
+		err = sys_ioctl(fd,cmd,(unsigned long)(&ss)); 
+	set_fs(oldseg);
+	if (cmd == TIOCGSERIAL && err >= 0) { 
+		if (__copy_to_user(ss32,&ss,offsetof(SS,iomem_base)) ||
+		    __put_user((unsigned long)ss.iomem_base  >> 32 ? 
+			       0xffffffff : (unsigned)(unsigned long)ss.iomem_base,
+			       &ss32->iomem_base) ||
+		    __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift) ||
+		    __put_user(ss.port_high, &ss32->port_high))
+			return -EFAULT;
+	} 
+	return err;	
+}
+
+static int __init init_compat(void)
+{
+	register_ioctl32_conversion(TIOCGSERIAL, serial_struct_ioctl);
+	register_ioctl32_conversion(TIOCSSERIAL, serial_struct_ioctl);
+	return 0;
+}
+
+__initcall(init_compat);
+#endif
+
 static void uart_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;
--- linux.clean/include/asm-x86_64/compat.h	2003-04-21 13:41:23.000000000 -0700
+++ linux/include/asm-x86_64/compat.h	2003-05-06 14:00:02.000000000 -0700
@@ -128,4 +128,8 @@
 	return (void *)(unsigned long)uptr;
 }
 
+/* For compat_ioctl handlers */
+#define A(__x) ((void *)(unsigned long)(__x))
+#define AA(__x)	A(__x)
+
 #endif /* _ASM_X86_64_COMPAT_H */
--- linux.clean/include/linux/ioctl32.h	2003-05-05 15:53:04.000000000 -0700
+++ linux/include/linux/ioctl32.h	2003-05-06 13:58:57.000000000 -0700
@@ -2,9 +2,9 @@
 #define IOCTL32_H 1
 
 struct file;
-
 extern long sys_ioctl(unsigned int, unsigned int, unsigned long);
 
+
 /* 
  * Register an 32bit ioctl translation handler for ioctl cmd.
  *
@@ -14,12 +14,15 @@
  *                        arg: ioctl argument
  *                        struct file *file: file descriptor pointer.
  */ 
+typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
 
 extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
-
 extern int unregister_ioctl32_conversion(unsigned int cmd);
 
-typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
+/* FIXME: several conversions make sense for one cmd depending on
+ * device being used (don't complain, its ioctl, its supposed to be
+ * ugly). Therefore unregisters needs *handler, too.
+ */
 
 struct ioctl_trans {
 	unsigned long cmd;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
