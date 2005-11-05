Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVKEQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVKEQin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKEQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:33738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932102AbVKEQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:32 -0500
Message-Id: <20051105162715.367344000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:02 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, dgilbert@interlog.com,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/25] scsi: move SG_IO ioctl32 code to sg.c
Content-Disposition: inline; filename=sg-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sg driver already has a compat_ioctl function, so the
conversion handler for SG_IO can easily be moved in there
as well. It still uses compat_alloc_user_space, so it can
probably be simplified by using merging the conversion
handler with the native method.

CC: dgilbert@interlog.com
CC: James.Bottomley@SteelEye.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/scsi/sg.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/scsi/sg.c	2005-11-05 02:38:14.000000000 +0100
+++ linux-2.6.14-rc/drivers/scsi/sg.c	2005-11-05 02:41:38.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
+#include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -1087,6 +1088,156 @@
 }
 
 #ifdef CONFIG_COMPAT
+
+typedef struct sg_io_hdr32 {
+	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
+	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
+	unsigned char cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
+	unsigned char mx_sb_len;		/* [i] max length to write to sbp */
+	unsigned short iovec_count;	/* [i] 0 implies no scatter gather */
+	compat_uint_t dxfer_len;		/* [i] byte count of data transfer */
+	compat_uint_t dxferp;		/* [i], [*io] points to data transfer memory
+					      or scatter gather list */
+	compat_uptr_t cmdp;		/* [i], [*i] points to command to perform */
+	compat_uptr_t sbp;		/* [i], [*o] points to sense_buffer memory */
+	compat_uint_t timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
+	compat_uint_t flags;		/* [i] 0 -> default, see SG_FLAG... */
+	compat_int_t pack_id;		/* [i->o] unused internally (normally) */
+	compat_uptr_t usr_ptr;		/* [i->o] unused internally */
+	unsigned char status;		/* [o] scsi status */
+	unsigned char masked_status;	/* [o] shifted, masked scsi status */
+	unsigned char msg_status;		/* [o] messaging level data (optional) */
+	unsigned char sb_len_wr;		/* [o] byte count actually written to sbp */
+	unsigned short host_status;	/* [o] errors from host adapter */
+	unsigned short driver_status;	/* [o] errors from software driver */
+	compat_int_t resid;		/* [o] dxfer_len - actual_transferred */
+	compat_uint_t duration;		/* [o] time taken by cmd (unit: millisec) */
+	compat_uint_t info;		/* [o] auxiliary information */
+} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
+
+typedef struct sg_iovec32 {
+	compat_uint_t iov_base;
+	compat_uint_t iov_len;
+} sg_iovec32_t;
+
+static int sg_build_iovec(sg_io_hdr_t __user *sgio, void __user *dxferp, u16 iovec_count)
+{
+	sg_iovec_t __user *iov = (sg_iovec_t __user *) (sgio + 1);
+	sg_iovec32_t __user *iov32 = dxferp;
+	int i;
+
+	for (i = 0; i < iovec_count; i++) {
+		u32 base, len;
+
+		if (get_user(base, &iov32[i].iov_base) ||
+		    get_user(len, &iov32[i].iov_len) ||
+		    put_user(compat_ptr(base), &iov[i].iov_base) ||
+		    put_user(len, &iov[i].iov_len))
+			return -EFAULT;
+	}
+
+	if (put_user(iov, &sgio->dxferp))
+		return -EFAULT;
+	return 0;
+}
+
+static int sg_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	sg_io_hdr_t __user *sgio;
+	sg_io_hdr32_t __user *sgio32;
+	u16 iovec_count;
+	u32 data;
+	void __user *dxferp;
+	int err;
+
+	sgio32 = compat_ptr(arg);
+	if (get_user(iovec_count, &sgio32->iovec_count))
+		return -EFAULT;
+
+	{
+		void __user *top = compat_alloc_user_space(0);
+		void __user *new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
+				       (iovec_count * sizeof(sg_iovec_t)));
+		if (new > top)
+			return -EINVAL;
+
+		sgio = new;
+	}
+
+	/* Ok, now construct.  */
+	if (copy_in_user(&sgio->interface_id, &sgio32->interface_id,
+			 (2 * sizeof(int)) +
+			 (2 * sizeof(unsigned char)) +
+			 (1 * sizeof(unsigned short)) +
+			 (1 * sizeof(unsigned int))))
+		return -EFAULT;
+
+	if (get_user(data, &sgio32->dxferp))
+		return -EFAULT;
+	dxferp = compat_ptr(data);
+	if (iovec_count) {
+		if (sg_build_iovec(sgio, dxferp, iovec_count))
+			return -EFAULT;
+	} else {
+		if (put_user(dxferp, &sgio->dxferp))
+			return -EFAULT;
+	}
+
+	{
+		unsigned char __user *cmdp;
+		unsigned char __user *sbp;
+
+		if (get_user(data, &sgio32->cmdp))
+			return -EFAULT;
+		cmdp = compat_ptr(data);
+
+		if (get_user(data, &sgio32->sbp))
+			return -EFAULT;
+		sbp = compat_ptr(data);
+
+		if (put_user(cmdp, &sgio->cmdp) ||
+		    put_user(sbp, &sgio->sbp))
+			return -EFAULT;
+	}
+
+	if (copy_in_user(&sgio->timeout, &sgio32->timeout,
+			 3 * sizeof(int)))
+		return -EFAULT;
+
+	if (get_user(data, &sgio32->usr_ptr))
+		return -EFAULT;
+	if (put_user(compat_ptr(data), &sgio->usr_ptr))
+		return -EFAULT;
+
+	if (copy_in_user(&sgio->status, &sgio32->status,
+			 (4 * sizeof(unsigned char)) +
+			 (2 * sizeof(unsigned (short))) +
+			 (3 * sizeof(int))))
+		return -EFAULT;
+
+	lock_kernel();
+	err = sg_ioctl(file->f_dentry->d_inode, file,
+			cmd, (unsigned long) sgio);
+	unlock_kernel();
+
+	if (err >= 0) {
+		void __user *datap;
+
+		if (copy_in_user(&sgio32->pack_id, &sgio->pack_id,
+				 sizeof(int)) ||
+		    get_user(datap, &sgio->usr_ptr) ||
+		    put_user((u32)(unsigned long)datap,
+			     &sgio32->usr_ptr) ||
+		    copy_in_user(&sgio32->status, &sgio->status,
+				 (4 * sizeof(unsigned char)) +
+				 (2 * sizeof(unsigned short)) +
+				 (3 * sizeof(int))))
+			err = -EFAULT;
+	}
+
+	return err;
+}
+
 static long sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 {
 	Sg_device *sdp;
@@ -1096,6 +1247,9 @@
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 
+	if (cmd_in == SG_IO)
+		return sg_ioctl_trans(filp, cmd_in, arg);
+
 	sdev = sdp->device;
 	if (sdev->host->hostt->compat_ioctl) { 
 		int ret;
Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:37.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:38.000000000 +0100
@@ -157,152 +157,6 @@
 	return err;
 }
 
-typedef struct sg_io_hdr32 {
-	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
-	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
-	unsigned char cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
-	unsigned char mx_sb_len;		/* [i] max length to write to sbp */
-	unsigned short iovec_count;	/* [i] 0 implies no scatter gather */
-	compat_uint_t dxfer_len;		/* [i] byte count of data transfer */
-	compat_uint_t dxferp;		/* [i], [*io] points to data transfer memory
-					      or scatter gather list */
-	compat_uptr_t cmdp;		/* [i], [*i] points to command to perform */
-	compat_uptr_t sbp;		/* [i], [*o] points to sense_buffer memory */
-	compat_uint_t timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
-	compat_uint_t flags;		/* [i] 0 -> default, see SG_FLAG... */
-	compat_int_t pack_id;		/* [i->o] unused internally (normally) */
-	compat_uptr_t usr_ptr;		/* [i->o] unused internally */
-	unsigned char status;		/* [o] scsi status */
-	unsigned char masked_status;	/* [o] shifted, masked scsi status */
-	unsigned char msg_status;		/* [o] messaging level data (optional) */
-	unsigned char sb_len_wr;		/* [o] byte count actually written to sbp */
-	unsigned short host_status;	/* [o] errors from host adapter */
-	unsigned short driver_status;	/* [o] errors from software driver */
-	compat_int_t resid;		/* [o] dxfer_len - actual_transferred */
-	compat_uint_t duration;		/* [o] time taken by cmd (unit: millisec) */
-	compat_uint_t info;		/* [o] auxiliary information */
-} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
-
-typedef struct sg_iovec32 {
-	compat_uint_t iov_base;
-	compat_uint_t iov_len;
-} sg_iovec32_t;
-
-static int sg_build_iovec(sg_io_hdr_t __user *sgio, void __user *dxferp, u16 iovec_count)
-{
-	sg_iovec_t __user *iov = (sg_iovec_t __user *) (sgio + 1);
-	sg_iovec32_t __user *iov32 = dxferp;
-	int i;
-
-	for (i = 0; i < iovec_count; i++) {
-		u32 base, len;
-
-		if (get_user(base, &iov32[i].iov_base) ||
-		    get_user(len, &iov32[i].iov_len) ||
-		    put_user(compat_ptr(base), &iov[i].iov_base) ||
-		    put_user(len, &iov[i].iov_len))
-			return -EFAULT;
-	}
-
-	if (put_user(iov, &sgio->dxferp))
-		return -EFAULT;
-	return 0;
-}
-
-static int sg_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	sg_io_hdr_t __user *sgio;
-	sg_io_hdr32_t __user *sgio32;
-	u16 iovec_count;
-	u32 data;
-	void __user *dxferp;
-	int err;
-
-	sgio32 = compat_ptr(arg);
-	if (get_user(iovec_count, &sgio32->iovec_count))
-		return -EFAULT;
-
-	{
-		void __user *top = compat_alloc_user_space(0);
-		void __user *new = compat_alloc_user_space(sizeof(sg_io_hdr_t) +
-				       (iovec_count * sizeof(sg_iovec_t)));
-		if (new > top)
-			return -EINVAL;
-
-		sgio = new;
-	}
-
-	/* Ok, now construct.  */
-	if (copy_in_user(&sgio->interface_id, &sgio32->interface_id,
-			 (2 * sizeof(int)) +
-			 (2 * sizeof(unsigned char)) +
-			 (1 * sizeof(unsigned short)) +
-			 (1 * sizeof(unsigned int))))
-		return -EFAULT;
-
-	if (get_user(data, &sgio32->dxferp))
-		return -EFAULT;
-	dxferp = compat_ptr(data);
-	if (iovec_count) {
-		if (sg_build_iovec(sgio, dxferp, iovec_count))
-			return -EFAULT;
-	} else {
-		if (put_user(dxferp, &sgio->dxferp))
-			return -EFAULT;
-	}
-
-	{
-		unsigned char __user *cmdp;
-		unsigned char __user *sbp;
-
-		if (get_user(data, &sgio32->cmdp))
-			return -EFAULT;
-		cmdp = compat_ptr(data);
-
-		if (get_user(data, &sgio32->sbp))
-			return -EFAULT;
-		sbp = compat_ptr(data);
-
-		if (put_user(cmdp, &sgio->cmdp) ||
-		    put_user(sbp, &sgio->sbp))
-			return -EFAULT;
-	}
-
-	if (copy_in_user(&sgio->timeout, &sgio32->timeout,
-			 3 * sizeof(int)))
-		return -EFAULT;
-
-	if (get_user(data, &sgio32->usr_ptr))
-		return -EFAULT;
-	if (put_user(compat_ptr(data), &sgio->usr_ptr))
-		return -EFAULT;
-
-	if (copy_in_user(&sgio->status, &sgio32->status,
-			 (4 * sizeof(unsigned char)) +
-			 (2 * sizeof(unsigned (short))) +
-			 (3 * sizeof(int))))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, cmd, (unsigned long) sgio);
-
-	if (err >= 0) {
-		void __user *datap;
-
-		if (copy_in_user(&sgio32->pack_id, &sgio->pack_id,
-				 sizeof(int)) ||
-		    get_user(datap, &sgio->usr_ptr) ||
-		    put_user((u32)(unsigned long)datap,
-			     &sgio32->usr_ptr) ||
-		    copy_in_user(&sgio32->status, &sgio->status,
-				 (4 * sizeof(unsigned char)) +
-				 (2 * sizeof(unsigned short)) +
-				 (3 * sizeof(int))))
-			err = -EFAULT;
-	}
-
-	return err;
-}
-
 
 struct mtget32 {
 	compat_long_t	mt_type;
@@ -1143,7 +997,6 @@
 #endif
 
 #ifdef DECLARES
-HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)

--

