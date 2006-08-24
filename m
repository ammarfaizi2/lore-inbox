Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWHXVf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWHXVf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWHXVdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:33:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422696AbWHXVdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:33:18 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/17] BLOCK: Move the loop device ioctl compat stuff to the loop driver [try #2]
Date: Thu, 24 Aug 2006 22:33:16 +0100
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com
Message-Id: <20060824213316.21323.54434.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the loop device ioctl compat stuff from fs/compat_ioctl.c to the loop
driver so that the loop header file doesn't need to be included.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/block/loop.c         |   76 ++++++++++++++++++++++++++++++++++++++++++
 fs/compat_ioctl.c            |   68 --------------------------------------
 include/linux/compat_ioctl.h |    6 ---
 3 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7b3b94d..48ad173 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -66,6 +66,7 @@ #include <linux/smp_lock.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/loop.h>
+#include <linux/compat.h>
 #include <linux/suspend.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
@@ -1174,6 +1175,78 @@ static int lo_ioctl(struct inode * inode
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+struct loop_info32 {
+	compat_int_t	lo_number;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
+	compat_ulong_t	lo_inode;       /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
+	compat_int_t	lo_offset;
+	compat_int_t	lo_encrypt_type;
+	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
+	compat_int_t	lo_flags;       /* ioctl r/o */
+	char		lo_name[LO_NAME_SIZE];
+	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
+	compat_ulong_t	lo_init[2];
+	char		reserved[4];
+};
+
+static long lo_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	mm_segment_t old_fs = get_fs();
+	struct loop_info l;
+	struct loop_info32 __user *ul;
+	int err = -ENOIOCTLCMD;
+
+	ul = compat_ptr(arg);
+
+	lock_kernel();
+	switch(cmd) {
+	case LOOP_SET_STATUS:
+		err = get_user(l.lo_number, &ul->lo_number);
+		err |= __get_user(l.lo_device, &ul->lo_device);
+		err |= __get_user(l.lo_inode, &ul->lo_inode);
+		err |= __get_user(l.lo_rdevice, &ul->lo_rdevice);
+		err |= __copy_from_user(&l.lo_offset, &ul->lo_offset,
+		        8 + (unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+		if (err) {
+			err = -EFAULT;
+		} else {
+			set_fs (KERNEL_DS);
+			err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
+			set_fs (old_fs);
+		}
+		break;
+	case LOOP_GET_STATUS:
+		set_fs (KERNEL_DS);
+		err = lo_ioctl(inode, file, cmd, (unsigned long)&l);
+		set_fs (old_fs);
+		if (!err) {
+			err = put_user(l.lo_number, &ul->lo_number);
+			err |= __put_user(l.lo_device, &ul->lo_device);
+			err |= __put_user(l.lo_inode, &ul->lo_inode);
+			err |= __put_user(l.lo_rdevice, &ul->lo_rdevice);
+			err |= __copy_to_user(&ul->lo_offset, &l.lo_offset,
+				(unsigned long)l.lo_init - (unsigned long)&l.lo_offset);
+			if (err)
+				err = -EFAULT;
+		}
+		break;
+	case LOOP_CLR_FD:
+	case LOOP_GET_STATUS64:
+	case LOOP_SET_STATUS64:
+		arg = (unsigned long) compat_ptr(arg);
+	case LOOP_SET_FD:
+	case LOOP_CHANGE_FD:
+		err = lo_ioctl(inode, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return err;
+}
+#endif
+
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
@@ -1201,6 +1274,9 @@ static struct block_device_operations lo
 	.open =		lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =	lo_compat_ioctl,
+#endif
 };
 
 /*
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 4063a93..d33a2b1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -40,7 +40,6 @@ #include <linux/if_ppp.h>
 #include <linux/if_pppox.h>
 #include <linux/mtio.h>
 #include <linux/cdrom.h>
-#include <linux/loop.h>
 #include <linux/auto_fs.h>
 #include <linux/auto_fs4.h>
 #include <linux/tty.h>
@@ -1214,71 +1213,6 @@ static int cdrom_ioctl_trans(unsigned in
 	return err;
 }
 
-struct loop_info32 {
-	compat_int_t	lo_number;      /* ioctl r/o */
-	compat_dev_t	lo_device;      /* ioctl r/o */
-	compat_ulong_t	lo_inode;       /* ioctl r/o */
-	compat_dev_t	lo_rdevice;     /* ioctl r/o */
-	compat_int_t	lo_offset;
-	compat_int_t	lo_encrypt_type;
-	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
-	compat_int_t	lo_flags;       /* ioctl r/o */
-	char		lo_name[LO_NAME_SIZE];
-	unsigned char	lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
-	compat_ulong_t	lo_init[2];
-	char		reserved[4];
-};
-
-static int loop_status(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct loop_info l;
-	struct loop_info32 __user *ul;
-	int err = -EINVAL;
-
-	ul = compat_ptr(arg);
-	switch(cmd) {
-	case LOOP_SET_STATUS:
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
-			err = sys_ioctl (fd, cmd, (unsigned long)&l);
-			set_fs (old_fs);
-		}
-		break;
-	case LOOP_GET_STATUS:
-		set_fs (KERNEL_DS);
-		err = sys_ioctl (fd, cmd, (unsigned long)&l);
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
-		break;
-	default: {
-		static int count;
-		if (++count <= 20)
-			printk("%s: Unknown loop ioctl cmd, fd(%d) "
-			       "cmd(%08x) arg(%08lx)\n",
-			       __FUNCTION__, fd, cmd, arg);
-	}
-	}
-	return err;
-}
-
 extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);
 
 #ifdef CONFIG_VT
@@ -2810,8 +2744,6 @@ HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
 HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
-HANDLE_IOCTL(LOOP_SET_STATUS, loop_status)
-HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
 #ifdef CONFIG_VT
diff --git a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
index 269d000..13cea44 100644
--- a/include/linux/compat_ioctl.h
+++ b/include/linux/compat_ioctl.h
@@ -394,12 +394,6 @@ COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)
 COMPATIBLE_IOCTL(DVD_AUTH)
 /* pktcdvd */
 COMPATIBLE_IOCTL(PACKET_CTRL_CMD)
-/* Big L */
-ULONG_IOCTL(LOOP_SET_FD)
-ULONG_IOCTL(LOOP_CHANGE_FD)
-COMPATIBLE_IOCTL(LOOP_CLR_FD)
-COMPATIBLE_IOCTL(LOOP_GET_STATUS64)
-COMPATIBLE_IOCTL(LOOP_SET_STATUS64)
 /* Big A */
 /* sparc only */
 /* Big Q for sound/OSS */
