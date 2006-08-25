Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWHYJ1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWHYJ1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHYJ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:27:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932370AbWHYJ1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:27:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608250023.13204.arnd@arndb.de> 
References: <200608250023.13204.arnd@arndb.de>  <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213316.21323.54434.stgit@warthog.cambridge.redhat.com> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] BLOCK: Move the loop device ioctl compat stuff to the loop driver [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 10:27:33 +0100
Message-ID: <15287.1156498053@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> The structure should be called compat_loop_info by convention, when it
> is moved to the file itself.

Seems reasonable.

> I guess this should be implemented like loop_set_status_old(), by calling a
> new loop_info64_from_compat() function an then the regular
> loop_set_status().

Whilst that does seem reasonable, it seems like a lot of extra code for
something that I wouldn't have thought would be that performance critical.
Surely these two ioctls aren't called that often...

On the other hand, it does reduce stack space usage somewhat - which is a good
thing - and that can be reduced still further by moving the on-stack struct
compat_loop_info variable and the copy_to/from_user into loop_set_status_compat
and loop_get_status_compat.

Anyway, how about the attached patch (to go on top of the one you've already
got)?

David


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 48ad173..82bc5bd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1176,7 +1176,7 @@ static int lo_ioctl(struct inode * inode
 }
 
 #ifdef CONFIG_COMPAT
-struct loop_info32 {
+struct compat_loop_info {
 	compat_int_t	lo_number;      /* ioctl r/o */
 	compat_dev_t	lo_device;      /* ioctl r/o */
 	compat_ulong_t	lo_inode;       /* ioctl r/o */
@@ -1191,47 +1191,120 @@ struct loop_info32 {
 	char		reserved[4];
 };
 
+static noinline int
+loop_info64_from_compat(const struct compat_loop_info *arg,
+			struct loop_info64 *info64)
+{
+	struct compat_loop_info info;
+
+	if (copy_from_user(&info, arg, sizeof(info)))
+		return -EFAULT;
+
+	memset(info64, 0, sizeof(*info64));
+	info64->lo_number = info.lo_number;
+	info64->lo_device = info.lo_device;
+	info64->lo_inode = info.lo_inode;
+	info64->lo_rdevice = info.lo_rdevice;
+	info64->lo_offset = info.lo_offset;
+	info64->lo_sizelimit = 0;
+	info64->lo_encrypt_type = info.lo_encrypt_type;
+	info64->lo_encrypt_key_size = info.lo_encrypt_key_size;
+	info64->lo_flags = info.lo_flags;
+	info64->lo_init[0] = info.lo_init[0];
+	info64->lo_init[1] = info.lo_init[1];
+	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+		memcpy(info64->lo_crypt_name, info.lo_name, LO_NAME_SIZE);
+	else
+		memcpy(info64->lo_file_name, info.lo_name, LO_NAME_SIZE);
+	memcpy(info64->lo_encrypt_key, info.lo_encrypt_key, LO_KEY_SIZE);
+	return 0;
+}
+
+static noinline int
+loop_info64_to_compat(const struct loop_info64 *info64,
+		      struct compat_loop_info __user *arg)
+{
+	struct compat_loop_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.lo_number = info64->lo_number;
+	info.lo_device = info64->lo_device;
+	info.lo_inode = info64->lo_inode;
+	info.lo_rdevice = info64->lo_rdevice;
+	info.lo_offset = info64->lo_offset;
+	info.lo_encrypt_type = info64->lo_encrypt_type;
+	info.lo_encrypt_key_size = info64->lo_encrypt_key_size;
+	info.lo_flags = info64->lo_flags;
+	info.lo_init[0] = info64->lo_init[0];
+	info.lo_init[1] = info64->lo_init[1];
+	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
+		memcpy(info.lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
+	else
+		memcpy(info.lo_name, info64->lo_file_name, LO_NAME_SIZE);
+	memcpy(info.lo_encrypt_key, info64->lo_encrypt_key, LO_KEY_SIZE);
+
+	/* error in case values were truncated */
+	if (info.lo_device != info64->lo_device ||
+	    info.lo_rdevice != info64->lo_rdevice ||
+	    info.lo_inode != info64->lo_inode ||
+	    info.lo_offset != info64->lo_offset ||
+	    info.lo_init[0] != info64->lo_init[0] ||
+	    info.lo_init[1] != info64->lo_init[1])
+		return -EOVERFLOW;
+
+	if (copy_to_user(arg, &info, sizeof(info)))
+		return -EFAULT;
+	return 0;
+}
+
+static int
+loop_set_status_compat(struct loop_device *lo,
+		       const struct compat_loop_info __user *arg)
+{
+	struct loop_info64 info64;
+	int ret;
+
+	ret = loop_info64_from_compat(arg, &info64);
+	if (ret < 0)
+		return ret;
+	return loop_set_status(lo, &info64);
+}
+
+static int
+loop_get_status_compat(struct loop_device *lo,
+		       struct compat_loop_info __user *arg)
+{
+	struct loop_info64 info64;
+	int err = 0;
+
+	if (!arg)
+		err = -EINVAL;
+	if (!err)
+		err = loop_get_status(lo, &info64);
+	if (!err)
+		err = loop_info64_to_compat(&info64, arg);
+	return err;
+}
+
 static long lo_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	mm_segment_t old_fs = get_fs();
-	struct loop_info l;
-	struct loop_info32 __user *ul;
-	int err = -ENOIOCTLCMD;
-
-	ul = compat_ptr(arg);
+	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	int err;
 
 	lock_kernel();
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = get_user(l.lo_number, &ul->lo_number);
-		err |= __get_user(l.lo_device, &ul->lo_device);
-		err |= __get_user(l.lo_inode, &ul->lo_inode);
-		err |= __get_user(l.lo_rdevice, &ul->lo_rdevice);
-		err |= __copy_from_user(&l.lo_offset, &ul->lo_offset,
-		        8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
-		if (err) {
-			err = -EFAULT;
-		} else {
-			set_fs (KERNEL_DS);
-			err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
-			set_fs (old_fs);
-		}
+		mutex_lock(&lo->lo_ctl_mutex);
+		err = loop_set_status_compat(
+			lo, (const struct compat_loop_info __user *) arg);
+		mutex_unlock(&lo->lo_ctl_mutex);
 		break;
 	case LOOP_GET_STATUS:
-		set_fs (KERNEL_DS);
-		err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
-		set_fs (old_fs);
-		if (!err) {
-			err = put_user(l.lo_number, &ul->lo_number);
-			err |= __put_user(l.lo_device, &ul->lo_device);
-			err |= __put_user(l.lo_inode, &ul->lo_inode);
-			err |= __put_user(l.lo_rdevice, &ul->lo_rdevice);
-			err |= __copy_to_user(&ul->lo_offset, &l.lo_offset,
-				(unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
-			if (err)
-				err = -EFAULT;
-		}
+		mutex_lock(&lo->lo_ctl_mutex);
+		err = loop_get_status_compat(
+			lo, (struct compat_loop_info __user *) arg);
+		mutex_unlock(&lo->lo_ctl_mutex);
 		break;
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
@@ -1241,6 +1314,9 @@ static long lo_compat_ioctl(struct file 
 	case LOOP_CHANGE_FD:
 		err = lo_ioctl(inode, file, cmd, arg);
 		break;
+	default:
+		err = -ENOIOCTLCMD;
+		break;
 	}
 	unlock_kernel();
 	return err;
