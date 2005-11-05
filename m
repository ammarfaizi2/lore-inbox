Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVKEQfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVKEQfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVKEQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:6348 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932112AbVKEQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:38 -0500
Message-Id: <20051105162720.047264000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:13 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, petero2@telia.com, packet-writing@suse.com,
       axboe@suse.de, emoenke@gwdg.de, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 23/25] cdrom: move ioctl32 code to drivers/cdrom/compat.c
Content-Disposition: inline; filename=cdrom-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All cdrom drivers use a subset of the same ioctl numbers, so
the 32 bit conversion handlers can be moved to a common place.

This patch simply uses the global cdrom_compat_ioctl function as
the .compat_ioctl block device operation for each of them.

Since I'm already touching pktcdvd, make that use its own
ctl compat_ioctl function as well.

CC: petero2@telia.com
CC: packet-writing@suse.com
CC: axboe@suse.de
CC: emoenke@gwdg.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/block/paride/pcd.c
===================================================================
--- linux-cg.orig/drivers/block/paride/pcd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/block/paride/pcd.c	2005-11-05 15:48:02.000000000 +0100
@@ -253,6 +253,7 @@
 	.open		= pcd_block_open,
 	.release	= pcd_block_release,
 	.ioctl		= pcd_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= pcd_block_media_changed,
 };
 
Index: linux-cg/drivers/block/paride/pd.c
===================================================================
--- linux-cg.orig/drivers/block/paride/pd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/block/paride/pd.c	2005-11-05 15:48:02.000000000 +0100
@@ -815,6 +815,7 @@
 	.open		= pd_open,
 	.release	= pd_release,
 	.ioctl		= pd_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= pd_check_media,
 	.revalidate_disk= pd_revalidate
 };
Index: linux-cg/drivers/block/pktcdvd.c
===================================================================
--- linux-cg.orig/drivers/block/pktcdvd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/block/pktcdvd.c	2005-11-05 16:07:02.000000000 +0100
@@ -47,6 +47,7 @@
 
 #include <linux/pktcdvd.h>
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -2465,6 +2466,7 @@
 	.open =			pkt_open,
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
+	.compat_ioctl =		cdrom_compat_ioctl,
 	.media_changed =	pkt_media_changed,
 };
 
@@ -2595,7 +2597,7 @@
 	ctrl_cmd->num_devices = MAX_WRITERS;
 }
 
-static int pkt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int pkt_ctl_locked_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct pkt_ctrl_command ctrl_cmd;
@@ -2636,10 +2638,22 @@
 	return ret;
 }
 
+static long pkt_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	lock_kernel();
+	arg = (unsigned long) compat_ptr(arg);
+	ret = pkt_ctl_locked_ioctl(file, cmd, arg);
+	unlock_kernel();
+
+	return ret;
+}
 
 static struct file_operations pkt_ctl_fops = {
-	.ioctl	 = pkt_ctl_ioctl,
-	.owner	 = THIS_MODULE,
+	.unlocked_ioctl	= pkt_ctl_ioctl,
+	.compat_ioctl	= pkt_ctl_ioctl,
+	.owner		= THIS_MODULE,
 };
 
 static struct miscdevice pkt_misc = {
Index: linux-cg/drivers/cdrom/Makefile
===================================================================
--- linux-cg.orig/drivers/cdrom/Makefile	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/Makefile	2005-11-05 15:48:02.000000000 +0100
@@ -21,3 +21,5 @@
 obj-$(CONFIG_SJCD)		+= sjcd.o
 obj-$(CONFIG_CDU535)		+= sonycd535.o
 obj-$(CONFIG_VIOCD)		+= viocd.o      cdrom.o
+
+obj-y				+= compat.o
Index: linux-cg/drivers/cdrom/aztcd.c
===================================================================
--- linux-cg.orig/drivers/cdrom/aztcd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/aztcd.c	2005-11-05 15:48:02.000000000 +0100
@@ -339,6 +339,7 @@
 	.open		= aztcd_open,
 	.release	= aztcd_release,
 	.ioctl		= aztcd_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= check_aztcd_media_change,
 };
 
Index: linux-cg/drivers/cdrom/cdu31a.c
===================================================================
--- linux-cg.orig/drivers/cdrom/cdu31a.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/cdu31a.c	2005-11-05 15:48:02.000000000 +0100
@@ -2953,6 +2953,7 @@
 	.open		= scd_block_open,
 	.release	= scd_block_release,
 	.ioctl		= scd_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= scd_block_media_changed,
 };
 
Index: linux-cg/drivers/cdrom/cm206.c
===================================================================
--- linux-cg.orig/drivers/cdrom/cm206.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/cm206.c	2005-11-05 15:48:02.000000000 +0100
@@ -1364,6 +1364,7 @@
 	.open		= cm206_block_open,
 	.release	= cm206_block_release,
 	.ioctl		= cm206_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= cm206_block_media_changed,
 };
 
Index: linux-cg/drivers/cdrom/compat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/drivers/cdrom/compat.c	2005-11-05 15:48:02.000000000 +0100
@@ -0,0 +1,163 @@
+#include <linux/config.h>
+#include <linux/cdrom.h>
+#include <linux/compat.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_COMPAT
+static int cdrom_native_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct inode *inode = file->f_mapping->host;
+	return blkdev_ioctl(inode, file, cmd, arg);
+}
+
+struct cdrom_read_audio32 {
+	union cdrom_addr	addr;
+	u8			addr_format;
+	compat_int_t		nframes;
+	compat_caddr_t		buf;
+};
+
+struct cdrom_generic_command32 {
+	unsigned char	cmd[CDROM_PACKET_SIZE];
+	compat_caddr_t	buffer;
+	compat_uint_t	buflen;
+	compat_int_t	stat;
+	compat_caddr_t	sense;
+	unsigned char	data_direction;
+	compat_int_t	quiet;
+	compat_int_t	timeout;
+	compat_caddr_t	reserved[1];
+};
+
+static int cdrom_do_read_audio(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct cdrom_read_audio __user *cdread_audio;
+	struct cdrom_read_audio32 __user *cdread_audio32;
+	__u32 data;
+	void __user *datap;
+
+	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
+	cdread_audio32 = compat_ptr(arg);
+
+	if (copy_in_user(&cdread_audio->addr,
+			 &cdread_audio32->addr,
+			 (sizeof(*cdread_audio32) -
+			  sizeof(compat_caddr_t))))
+	 	return -EFAULT;
+
+	if (get_user(data, &cdread_audio32->buf))
+		return -EFAULT;
+	datap = compat_ptr(data);
+	if (put_user(datap, &cdread_audio->buf))
+		return -EFAULT;
+
+	return cdrom_native_ioctl(file, cmd, (unsigned long) cdread_audio);
+}
+
+static int cdrom_do_generic_command(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct cdrom_generic_command __user *cgc;
+	struct cdrom_generic_command32 __user *cgc32;
+	u32 data;
+	unsigned char dir;
+	int itmp;
+
+	cgc = compat_alloc_user_space(sizeof(*cgc));
+	cgc32 = compat_ptr(arg);
+
+	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
+	    get_user(data, &cgc32->buffer) ||
+	    put_user(compat_ptr(data), &cgc->buffer) ||
+	    copy_in_user(&cgc->buflen, &cgc32->buflen,
+			 (sizeof(unsigned int) + sizeof(int))) ||
+	    get_user(data, &cgc32->sense) ||
+	    put_user(compat_ptr(data), &cgc->sense) ||
+	    get_user(dir, &cgc32->data_direction) ||
+	    put_user(dir, &cgc->data_direction) ||
+	    get_user(itmp, &cgc32->quiet) ||
+	    put_user(itmp, &cgc->quiet) ||
+	    get_user(itmp, &cgc32->timeout) ||
+	    put_user(itmp, &cgc->timeout) ||
+	    get_user(data, &cgc32->reserved[0]) ||
+	    put_user(compat_ptr(data), &cgc->reserved[0]))
+		return -EFAULT;
+
+	return cdrom_native_ioctl(file, cmd, (unsigned long) cgc);
+}
+
+long cdrom_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int err;
+
+	switch(cmd) {
+	case CDROMREADAUDIO:
+		err = cdrom_do_read_audio(file, cmd, arg);
+		break;
+
+	case CDROM_SEND_PACKET:
+		err = cdrom_do_generic_command(file, cmd, arg);
+		break;
+
+	case CDROMPAUSE:
+	case CDROMRESUME:
+	case CDROMPLAYMSF:
+	case CDROMPLAYTRKIND:
+	case CDROMREADTOCHDR:
+	case CDROMREADTOCENTRY:
+	case CDROMSTOP:
+	case CDROMSTART:
+	case CDROMEJECT:
+	case CDROMVOLCTRL:
+	case CDROMSUBCHNL:
+	case CDROMMULTISESSION:
+	case CDROM_GET_MCN:
+	case CDROMRESET:
+	case CDROMVOLREAD:
+	case CDROMSEEK:
+	case CDROMPLAYBLK:
+	case CDROMCLOSETRAY:
+	case CDROM_DISC_STATUS:
+	case CDROM_CHANGER_NSLOTS:
+	case CDROM_GET_CAPABILITY:
+/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
+ * not take a struct cdrom_read, instead they take a struct cdrom_msf
+ * which is compatible.
+ */
+	case CDROMREADMODE2:
+	case CDROMREADMODE1:
+	case CDROMREADRAW:
+	case CDROMREADCOOKED:
+	case CDROMREADALL:
+/* DVD ioctls */
+	case DVD_READ_STRUCT:
+	case DVD_WRITE_STRUCT:
+	case DVD_AUTH:
+		arg = (unsigned long) compat_ptr(arg);
+
+/* these take an integer as their argument, not a pointer */
+	case CDROMEJECT_SW:
+	case CDROM_SET_OPTIONS:
+	case CDROM_CLEAR_OPTIONS:
+	case CDROM_SELECT_SPEED:
+	case CDROM_SELECT_DISC:
+	case CDROM_MEDIA_CHANGED:
+	case CDROM_DRIVE_STATUS:
+	case CDROM_LOCKDOOR:
+	case CDROM_DEBUG:
+		err = cdrom_native_ioctl(file, cmd, arg);
+		break;
+	default:
+		err = -ENOIOCTLCMD;
+	}
+	return err;
+}
+#else
+/* provide an empty operation that drivers can reference */
+long cdrom_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+#endif
+EXPORT_SYMBOL_GPL(cdrom_compat_ioctl);
Index: linux-cg/drivers/cdrom/gscd.c
===================================================================
--- linux-cg.orig/drivers/cdrom/gscd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/gscd.c	2005-11-05 15:48:02.000000000 +0100
@@ -155,6 +155,7 @@
 	.open		= gscd_open,
 	.release	= gscd_release,
 	.ioctl		= gscd_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= check_gscd_med_chg,
 };
 
Index: linux-cg/drivers/cdrom/mcdx.c
===================================================================
--- linux-cg.orig/drivers/cdrom/mcdx.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/mcdx.c	2005-11-05 15:48:02.000000000 +0100
@@ -243,6 +243,7 @@
 	.open		= mcdx_block_open,
 	.release	= mcdx_block_release,
 	.ioctl		= mcdx_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= mcdx_block_media_changed,
 };
 
Index: linux-cg/drivers/cdrom/optcd.c
===================================================================
--- linux-cg.orig/drivers/cdrom/optcd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/optcd.c	2005-11-05 15:48:02.000000000 +0100
@@ -1993,6 +1993,7 @@
 	.open		= opt_open,
 	.release	= opt_release,
 	.ioctl		= opt_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= opt_media_change,
 };
 
Index: linux-cg/drivers/cdrom/sbpcd.c
===================================================================
--- linux-cg.orig/drivers/cdrom/sbpcd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/sbpcd.c	2005-11-05 15:48:02.000000000 +0100
@@ -5385,6 +5385,7 @@
 	.open		= sbpcd_block_open,
 	.release	= sbpcd_block_release,
 	.ioctl		= sbpcd_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= sbpcd_block_media_changed,
 };
 /*==========================================================================*/
Index: linux-cg/drivers/cdrom/sjcd.c
===================================================================
--- linux-cg.orig/drivers/cdrom/sjcd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/sjcd.c	2005-11-05 15:48:02.000000000 +0100
@@ -1646,6 +1646,7 @@
 	.open		= sjcd_open,
 	.release	= sjcd_release,
 	.ioctl		= sjcd_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= sjcd_disk_change,
 };
 
Index: linux-cg/drivers/cdrom/sonycd535.c
===================================================================
--- linux-cg.orig/drivers/cdrom/sonycd535.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/cdrom/sonycd535.c	2005-11-05 15:48:02.000000000 +0100
@@ -1,4 +1,5 @@
 /*
+	.compat_ioctl	= cdrom_compat_ioctl,
  * Sony CDU-535 interface device driver
  *
  * This is a modified version of the CDU-31A device driver (see below).
@@ -1433,6 +1434,7 @@
 	.open		= cdu_open,
 	.release	= cdu_release,
 	.ioctl		= cdu_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= cdu535_check_media_change,
 };
 
Index: linux-cg/drivers/ide/ide-cd.c
===================================================================
--- linux-cg.orig/drivers/ide/ide-cd.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/ide/ide-cd.c	2005-11-05 15:48:02.000000000 +0100
@@ -3421,6 +3421,7 @@
 	.open		= idecd_open,
 	.release	= idecd_release,
 	.ioctl		= idecd_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= idecd_media_changed,
 	.revalidate_disk= idecd_revalidate_disk
 };
Index: linux-cg/drivers/ide/ide-floppy.c
===================================================================
--- linux-cg.orig/drivers/ide/ide-floppy.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/ide/ide-floppy.c	2005-11-05 15:48:02.000000000 +0100
@@ -2122,6 +2122,7 @@
 	.open		= idefloppy_open,
 	.release	= idefloppy_release,
 	.ioctl		= idefloppy_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= idefloppy_media_changed,
 	.revalidate_disk= idefloppy_revalidate_disk
 };
Index: linux-cg/drivers/scsi/sr.c
===================================================================
--- linux-cg.orig/drivers/scsi/sr.c	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/drivers/scsi/sr.c	2005-11-05 15:48:02.000000000 +0100
@@ -510,6 +510,7 @@
 	.open		= sr_block_open,
 	.release	= sr_block_release,
 	.ioctl		= sr_block_ioctl,
+	.compat_ioctl	= cdrom_compat_ioctl,
 	.media_changed	= sr_block_media_changed,
 	/* 
 	 * No compat_ioctl for now because sr_block_ioctl never
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 16:43:51.000000000 +0100
@@ -228,109 +228,6 @@
 	return err ? -EFAULT: 0;
 }
 
-struct cdrom_read_audio32 {
-	union cdrom_addr	addr;
-	u8			addr_format;
-	compat_int_t		nframes;
-	compat_caddr_t		buf;
-};
-
-struct cdrom_generic_command32 {
-	unsigned char	cmd[CDROM_PACKET_SIZE];
-	compat_caddr_t	buffer;
-	compat_uint_t	buflen;
-	compat_int_t	stat;
-	compat_caddr_t	sense;
-	unsigned char	data_direction;
-	compat_int_t	quiet;
-	compat_int_t	timeout;
-	compat_caddr_t	reserved[1];
-};
-  
-static int cdrom_do_read_audio(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_read_audio __user *cdread_audio;
-	struct cdrom_read_audio32 __user *cdread_audio32;
-	__u32 data;
-	void __user *datap;
-
-	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
-	cdread_audio32 = compat_ptr(arg);
-
-	if (copy_in_user(&cdread_audio->addr,
-			 &cdread_audio32->addr,
-			 (sizeof(*cdread_audio32) -
-			  sizeof(compat_caddr_t))))
-	 	return -EFAULT;
-
-	if (get_user(data, &cdread_audio32->buf))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(datap, &cdread_audio->buf))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long) cdread_audio);
-}
-
-static int cdrom_do_generic_command(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_generic_command __user *cgc;
-	struct cdrom_generic_command32 __user *cgc32;
-	u32 data;
-	unsigned char dir;
-	int itmp;
-
-	cgc = compat_alloc_user_space(sizeof(*cgc));
-	cgc32 = compat_ptr(arg);
-
-	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
-	    get_user(data, &cgc32->buffer) ||
-	    put_user(compat_ptr(data), &cgc->buffer) ||
-	    copy_in_user(&cgc->buflen, &cgc32->buflen,
-			 (sizeof(unsigned int) + sizeof(int))) ||
-	    get_user(data, &cgc32->sense) ||
-	    put_user(compat_ptr(data), &cgc->sense) ||
-	    get_user(dir, &cgc32->data_direction) ||
-	    put_user(dir, &cgc->data_direction) ||
-	    get_user(itmp, &cgc32->quiet) ||
-	    put_user(itmp, &cgc->quiet) ||
-	    get_user(itmp, &cgc32->timeout) ||
-	    put_user(itmp, &cgc->timeout) ||
-	    get_user(data, &cgc32->reserved[0]) ||
-	    put_user(compat_ptr(data), &cgc->reserved[0]))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long) cgc);
-}
-
-static int cdrom_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	switch(cmd) {
-	case CDROMREADAUDIO:
-		err = cdrom_do_read_audio(fd, cmd, arg);
-		break;
-
-	case CDROM_SEND_PACKET:
-		err = cdrom_do_generic_command(fd, cmd, arg);
-		break;
-
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("cdrom_ioctl: Unknown cmd fd(%d) "
-				       "cmd(%08x) arg(%08x)\n",
-				       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		} while(0);
-		err = -EINVAL;
-		break;
-	};
-
-	return err;
-}
-
 static __attribute_used__ int 
 ret_einval(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -362,7 +259,5 @@
 #ifdef DECLARES
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
-HANDLE_IOCTL(CDROMREADAUDIO, cdrom_ioctl_trans)
-HANDLE_IOCTL(CDROM_SEND_PACKET, cdrom_ioctl_trans)
 #undef DECLARES
 #endif
Index: linux-cg/include/linux/cdrom.h
===================================================================
--- linux-cg.orig/include/linux/cdrom.h	2005-11-05 15:46:46.000000000 +0100
+++ linux-cg/include/linux/cdrom.h	2005-11-05 15:48:02.000000000 +0100
@@ -991,6 +991,8 @@
 extern int cdrom_release(struct cdrom_device_info *cdi, struct file *fp);
 extern int cdrom_ioctl(struct file *file, struct cdrom_device_info *cdi,
 		struct inode *ip, unsigned int cmd, unsigned long arg);
+extern long cdrom_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg);
 extern int cdrom_media_changed(struct cdrom_device_info *);
 
 extern int register_cdrom(struct cdrom_device_info *cdi);
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 16:43:51.000000000 +0100
@@ -158,52 +158,6 @@
 COMPATIBLE_IOCTL(PPGETPHASE)
 COMPATIBLE_IOCTL(PPGETFLAGS)
 COMPATIBLE_IOCTL(PPSETFLAGS)
-/* CDROM stuff */
-COMPATIBLE_IOCTL(CDROMPAUSE)
-COMPATIBLE_IOCTL(CDROMRESUME)
-COMPATIBLE_IOCTL(CDROMPLAYMSF)
-COMPATIBLE_IOCTL(CDROMPLAYTRKIND)
-COMPATIBLE_IOCTL(CDROMREADTOCHDR)
-COMPATIBLE_IOCTL(CDROMREADTOCENTRY)
-COMPATIBLE_IOCTL(CDROMSTOP)
-COMPATIBLE_IOCTL(CDROMSTART)
-COMPATIBLE_IOCTL(CDROMEJECT)
-COMPATIBLE_IOCTL(CDROMVOLCTRL)
-COMPATIBLE_IOCTL(CDROMSUBCHNL)
-ULONG_IOCTL(CDROMEJECT_SW)
-COMPATIBLE_IOCTL(CDROMMULTISESSION)
-COMPATIBLE_IOCTL(CDROM_GET_MCN)
-COMPATIBLE_IOCTL(CDROMRESET)
-COMPATIBLE_IOCTL(CDROMVOLREAD)
-COMPATIBLE_IOCTL(CDROMSEEK)
-COMPATIBLE_IOCTL(CDROMPLAYBLK)
-COMPATIBLE_IOCTL(CDROMCLOSETRAY)
-ULONG_IOCTL(CDROM_SET_OPTIONS)
-ULONG_IOCTL(CDROM_CLEAR_OPTIONS)
-ULONG_IOCTL(CDROM_SELECT_SPEED)
-ULONG_IOCTL(CDROM_SELECT_DISC)
-ULONG_IOCTL(CDROM_MEDIA_CHANGED)
-ULONG_IOCTL(CDROM_DRIVE_STATUS)
-COMPATIBLE_IOCTL(CDROM_DISC_STATUS)
-COMPATIBLE_IOCTL(CDROM_CHANGER_NSLOTS)
-ULONG_IOCTL(CDROM_LOCKDOOR)
-ULONG_IOCTL(CDROM_DEBUG)
-COMPATIBLE_IOCTL(CDROM_GET_CAPABILITY)
-/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
- * not take a struct cdrom_read, instead they take a struct cdrom_msf
- * which is compatible.
- */
-COMPATIBLE_IOCTL(CDROMREADMODE2)
-COMPATIBLE_IOCTL(CDROMREADMODE1)
-COMPATIBLE_IOCTL(CDROMREADRAW)
-COMPATIBLE_IOCTL(CDROMREADCOOKED)
-COMPATIBLE_IOCTL(CDROMREADALL)
-/* DVD ioctls */
-COMPATIBLE_IOCTL(DVD_READ_STRUCT)
-COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)
-COMPATIBLE_IOCTL(DVD_AUTH)
-/* pktcdvd */
-COMPATIBLE_IOCTL(PACKET_CTRL_CMD)
 /* Big A */
 /* sparc only */
 /* Big Q for sound/OSS */

--

