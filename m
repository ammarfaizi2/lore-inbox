Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSG1H1L>; Sun, 28 Jul 2002 03:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSG1HZW>; Sun, 28 Jul 2002 03:25:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318928AbSG1HVt>;
	Sun, 28 Jul 2002 03:21:49 -0400
Message-ID: <3D439E4B.2CCB61D6@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/13] permit modular build of raw driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch allows the raw driver to be built as a kernel module.

It also cleans up a bunch of stuff, C99ifies the initialisers, gives
lots of symbols static scope, etc.

The module is unloadable when there are zero bindings.  The current
ioctl() interface have no way of undoing a binding - it only allows
bindings to be overwritten.  So I overloaded a bind to major=0,minor=0
to mean "undo the binding".  I'll update the raw(8) manpage for that.

generic_file_direct_IO has been exported to modules.

The call to invalidate_inode_pages2() has been removed from all
generic_file_driect_IO() callers, into generic_file_direct_IO() itself.
Mainly to avoid exporting invalidate_inode_pages2() to modules.



 drivers/char/Config.help |    6 +
 drivers/char/Config.in   |    2 
 drivers/char/Makefile    |    3 
 drivers/char/raw.c       |  259 +++++++++++++++++++++--------------------------
 fs/direct-io.c           |    2 
 kernel/ksyms.c           |    1 
 mm/filemap.c             |    7 -
 7 files changed, 133 insertions(+), 147 deletions(-)

--- 2.5.29/drivers/char/raw.c~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/drivers/char/raw.c	Sun Jul 28 00:22:14 2002
@@ -12,161 +12,106 @@
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
+#include <linux/module.h>
 #include <linux/raw.h>
 #include <linux/capability.h>
-#include <linux/smp_lock.h>
+
 #include <asm/uaccess.h>
 
-typedef struct raw_device_data_s {
+struct raw_device_data {
 	struct block_device *binding;
 	int inuse;
-	struct semaphore mutex;
-} raw_device_data_t;
-
-static raw_device_data_t raw_devices[256];
-
-static ssize_t rw_raw_dev(int rw, struct file *, char *, size_t, loff_t *);
-
-ssize_t	raw_read(struct file *, char *, size_t, loff_t *);
-ssize_t	raw_write(struct file *, const char *, size_t, loff_t *);
-int	raw_open(struct inode *, struct file *);
-int	raw_release(struct inode *, struct file *);
-int	raw_ctl_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
-int	raw_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
-
-
-static struct file_operations raw_fops = {
-	read:		raw_read,
-	write:		raw_write,
-	open:		raw_open,
-	release:	raw_release,
-	ioctl:		raw_ioctl,
 };
 
-static struct file_operations raw_ctl_fops = {
-	ioctl:		raw_ctl_ioctl,
-	open:		raw_open,
-};
+static struct raw_device_data raw_devices[256];
+static DECLARE_MUTEX(raw_mutex);
+static struct file_operations raw_ctl_fops;
 
-static int __init raw_init(void)
-{
-	int i;
-	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
-
-	for (i = 0; i < 256; i++)
-		init_MUTEX(&raw_devices[i].mutex);
-
-	return 0;
-}
-
-__initcall(raw_init);
-
-/* 
+/*
  * Open/close code for raw IO.
  *
- * Set the device's soft blocksize to the minimum possible.  This gives the 
+ * Set the device's soft blocksize to the minimum possible.  This gives the
  * finest possible alignment and has no adverse impact on performance.
  */
-int raw_open(struct inode *inode, struct file *filp)
+static int raw_open(struct inode *inode, struct file *filp)
 {
-	int minor;
-	struct block_device * bdev;
+	const int minor = minor(inode->i_rdev);
+	struct block_device *bdev;
 	int err;
 
-	minor = minor(inode->i_rdev);
-	
-	/* 
-	 * Is it the control device? 
-	 */
-	
-	if (minor == 0) {
+	if (minor == 0) {	/* It is the control device */
 		filp->f_op = &raw_ctl_fops;
 		return 0;
 	}
 	
-	down(&raw_devices[minor].mutex);
+	down(&raw_mutex);
 
 	/*
-	 * No, it is a normal raw device.  All we need to do on open is
-	 * to check that the device is bound.
+	 * All we need to do on open is check that the device is bound.
 	 */
 	bdev = raw_devices[minor].binding;
 	err = -ENODEV;
-	if (!bdev)
-		goto out;
-
-	atomic_inc(&bdev->bd_count);
-	err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
-	if (!err) {
-		int minsize = bdev_hardsect_size(bdev);
-
-		if (bdev) {
-			int ret;
-
-			ret = set_blocksize(bdev, minsize);
-			if (ret)
-				printk("%s: set_blocksize() failed: %d\n",
-					__FUNCTION__, ret);
+	if (bdev) {
+		atomic_inc(&bdev->bd_count);
+		err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
+		if (!err) {
+			err = set_blocksize(bdev, bdev_hardsect_size(bdev));
+			raw_devices[minor].inuse++;
 		}
-		raw_devices[minor].inuse++;
 	}
- out:
-	up(&raw_devices[minor].mutex);
-	
+	up(&raw_mutex);
 	return err;
 }
 
-int raw_release(struct inode *inode, struct file *filp)
+static int raw_release(struct inode *inode, struct file *filp)
 {
-	int minor;
+	const int minor= minor(inode->i_rdev);
 	struct block_device *bdev;
 	
-	minor = minor(inode->i_rdev);
-	down(&raw_devices[minor].mutex);
+	down(&raw_mutex);
 	bdev = raw_devices[minor].binding;
 	raw_devices[minor].inuse--;
-	up(&raw_devices[minor].mutex);
+	up(&raw_mutex);
 	blkdev_put(bdev, BDEV_RAW);
 	return 0;
 }
 
-/* Forward ioctls to the underlying block device. */ 
-int raw_ioctl(struct inode *inode, 
-		  struct file *filp,
-		  unsigned int command, 
-		  unsigned long arg)
+/*
+ * Forward ioctls to the underlying block device.
+ */
+static int
+raw_ioctl(struct inode *inode, struct file *filp,
+		  unsigned int command, unsigned long arg)
 {
-	int minor = minor(inode->i_rdev);
-	int err; 
-	struct block_device *b; 
+	const int minor = minor(inode->i_rdev);
+	int err;
+	struct block_device *bdev;
 
 	err = -ENODEV;
 	if (minor < 1 && minor > 255)
 		goto out;
 
-	b = raw_devices[minor].binding;
+	bdev = raw_devices[minor].binding;
 	err = -EINVAL;
-	if (b == NULL)
+	if (bdev == NULL)
 		goto out;
-	if (b->bd_inode && b->bd_op && b->bd_op->ioctl)
-		err = b->bd_op->ioctl(b->bd_inode, NULL, command, arg); 
+	if (bdev->bd_inode && bdev->bd_op && bdev->bd_op->ioctl)
+		err = bdev->bd_op->ioctl(bdev->bd_inode, NULL, command, arg);
 out:
 	return err;
 }
 
 /*
  * Deal with ioctls against the raw-device control interface, to bind
- * and unbind other raw devices.  
+ * and unbind other raw devices.
  */
-
-int raw_ctl_ioctl(struct inode *inode, 
-		  struct file *filp,
-		  unsigned int command, 
-		  unsigned long arg)
+static int
+raw_ctl_ioctl(struct inode *inode, struct file *filp,
+		unsigned int command, unsigned long arg)
 {
 	struct raw_config_request rq;
+	struct raw_device_data *rawdev;
 	int err;
-	int minor;
 	
 	switch (command) {
 	case RAW_SETBIND:
@@ -178,10 +123,10 @@ int raw_ctl_ioctl(struct inode *inode, 
 		if (copy_from_user(&rq, (void *) arg, sizeof(rq)))
 			goto out;
 		
-		minor = rq.raw_minor;
 		err = -EINVAL;
-		if (minor <= 0 || minor > MINORMASK)
+		if (rq.raw_minor < 0 || rq.raw_minor > MINORMASK)
 			goto out;
+		rawdev = &raw_devices[rq.raw_minor];
 
 		if (command == RAW_SETBIND) {
 			/*
@@ -192,11 +137,11 @@ int raw_ctl_ioctl(struct inode *inode, 
 			if (!capable(CAP_SYS_ADMIN))
 				goto out;
 
-			/* 
+			/*
 			 * For now, we don't need to check that the underlying
 			 * block device is present or not: we can do that when
 			 * the raw device is opened.  Just check that the
-			 * major/minor numbers make sense. 
+			 * major/minor numbers make sense.
 			 */
 
 			err = -EINVAL;
@@ -205,23 +150,33 @@ int raw_ctl_ioctl(struct inode *inode, 
 					rq.block_minor > MINORMASK)
 				goto out;
 			
-			down(&raw_devices[minor].mutex);
+			down(&raw_mutex);
 			err = -EBUSY;
-			if (raw_devices[minor].inuse) {
-				up(&raw_devices[minor].mutex);
+			if (rawdev->inuse) {
+				up(&raw_mutex);
 				goto out;
 			}
-			if (raw_devices[minor].binding)
-				bdput(raw_devices[minor].binding);
-			raw_devices[minor].binding = 
-				bdget(kdev_t_to_nr(mk_kdev(rq.block_major,
-							rq.block_minor)));
-			up(&raw_devices[minor].mutex);
+			if (rawdev->binding) {
+				bdput(rawdev->binding);
+				MOD_DEC_USE_COUNT;
+			}
+			if (rq.block_major == 0 && rq.block_minor == 0) {
+				/* unbind */
+				rawdev->binding = NULL;
+			} else {
+				kdev_t kdev;
+
+				kdev = mk_kdev(rq.block_major, rq.block_minor);
+				rawdev->binding = bdget(kdev_t_to_nr(kdev));
+				MOD_INC_USE_COUNT;
+			}
+			up(&raw_mutex);
 		} else {
 			struct block_device *bdev;
 			kdev_t dev;
 
-			bdev = raw_devices[minor].binding;
+			down(&raw_mutex);
+			bdev = rawdev->binding;
 			if (bdev) {
 				dev = to_kdev_t(bdev->bd_dev);
 				rq.block_major = major(dev);
@@ -229,8 +184,9 @@ int raw_ctl_ioctl(struct inode *inode, 
 			} else {
 				rq.block_major = rq.block_minor = 0;
 			}
+			up(&raw_mutex);
 			err = -EFAULT;
-			if (copy_to_user((void *) arg, &rq, sizeof(rq)))
+			if (copy_to_user((void *)arg, &rq, sizeof(rq)))
 				goto out;
 		}
 		err = 0;
@@ -244,46 +200,69 @@ out:
 	return err;
 }
 
-ssize_t raw_read(struct file *filp, char * buf, size_t size, loff_t *offp)
-{
-	return rw_raw_dev(READ, filp, buf, size, offp);
-}
-
-ssize_t	raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
-{
-	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
-}
-
-ssize_t
+static ssize_t
 rw_raw_dev(int rw, struct file *filp, char *buf, size_t size, loff_t *offp)
 {
-	struct block_device *bdev;
-	struct inode *inode;
-	int minor;
+	const int minor = minor(filp->f_dentry->d_inode->i_rdev);
+	struct block_device *bdev = raw_devices[minor].binding;
+	struct inode *inode = bdev->bd_inode;
 	ssize_t ret = 0;
 
-	minor = minor(filp->f_dentry->d_inode->i_rdev);
-	bdev = raw_devices[minor].binding;
-	inode = bdev->bd_inode;
-
 	if (size == 0)
 		goto out;
-	if (size < 0) {
-		ret = -EINVAL;
+	ret = -EINVAL;
+	if (size < 0)
 		goto out;
-	}
-	if (*offp >= inode->i_size) {
-		ret = -ENXIO;
+	ret = -ENXIO;
+	if (*offp >= inode->i_size)
 		goto out;
-	}
+
 	if (size + *offp > inode->i_size)
 		size = inode->i_size - *offp;
-
 	ret = generic_file_direct_IO(rw, inode, buf, *offp, size);
 	if (ret > 0)
 		*offp += ret;
-	if (inode->i_mapping->nrpages)
-		invalidate_inode_pages2(inode->i_mapping);
 out:
 	return ret;
 }
+
+static ssize_t
+raw_read(struct file *filp, char * buf, size_t size, loff_t *offp)
+{
+	return rw_raw_dev(READ, filp, buf, size, offp);
+}
+
+static ssize_t
+raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
+{
+	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
+}
+
+static struct file_operations raw_fops = {
+	.read	=	raw_read,
+	.write	=	raw_write,
+	.open	=	raw_open,
+	.release=	raw_release,
+	.ioctl	=	raw_ioctl,
+	.owner	=	THIS_MODULE,
+};
+
+static struct file_operations raw_ctl_fops = {
+	.ioctl	=	raw_ctl_ioctl,
+	.open	=	raw_open,
+	.owner	=	THIS_MODULE,
+};
+
+static int __init raw_init(void)
+{
+	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+	return 0;
+}
+
+static void __exit raw_exit(void)
+{
+	unregister_chrdev(RAW_MAJOR, "raw");
+}
+
+module_init(raw_init);
+module_exit(raw_exit);
--- 2.5.29/drivers/char/Makefile~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/drivers/char/Makefile	Sun Jul 28 00:22:14 2002
@@ -7,7 +7,7 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
@@ -146,6 +146,7 @@ obj-$(CONFIG_MVME162_SCC) += generic_ser
 obj-$(CONFIG_BVME6000_SCC) += generic_serial.o vme_scc.o
 obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
 obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o
+obj-$(CONFIG_RAW_DRIVER) += raw.o
 
 obj-$(CONFIG_PRINTER) += lp.o
 
--- 2.5.29/drivers/char/Config.in~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/drivers/char/Config.in	Sun Jul 28 00:22:14 2002
@@ -198,4 +198,6 @@ if [ "$CONFIG_X86" = "y" ]; then
    tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
 fi
 
+tristate '  RAW driver (/dev/raw/rawN)' CONFIG_RAW_DRIVER
+
 endmenu
--- 2.5.29/kernel/ksyms.c~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/kernel/ksyms.c	Sun Jul 28 00:22:14 2002
@@ -340,6 +340,7 @@ EXPORT_SYMBOL(register_disk);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(wipe_partitions);
+EXPORT_SYMBOL(generic_file_direct_IO);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_hangup);
--- 2.5.29/mm/filemap.c~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/mm/filemap.c	Sun Jul 28 00:22:14 2002
@@ -2052,11 +2052,8 @@ generic_file_write(struct file *file, co
 			up(&inode->i_sem);
 			written = generic_file_direct_IO(WRITE, inode,
 						(char *)buf, pos, count);
-			if (written > 0) {
-				if (mapping->nrpages)
-					invalidate_inode_pages2(mapping);
+			if (written > 0)
 				*ppos = pos + written;
-			}
 			err = written;
 			goto out;
 		} else {
@@ -2077,8 +2074,6 @@ generic_file_write(struct file *file, co
 				if (file->f_flags & O_SYNC)
 					status = generic_osync_inode(inode,
 								OSYNC_METADATA);
-				if (mapping->nrpages)
-					invalidate_inode_pages2(mapping);
 			}
 			goto out_status;
 		}
--- 2.5.29/fs/direct-io.c~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/fs/direct-io.c	Sun Jul 28 00:22:14 2002
@@ -625,6 +625,8 @@ generic_file_direct_IO(int rw, struct in
 			goto out;
 	}
 	retval = mapping->a_ops->direct_IO(rw, inode, buf, offset, count);
+	if (inode->i_mapping->nrpages)
+		invalidate_inode_pages2(inode->i_mapping);
 out:
 	return retval;
 }
--- 2.5.29/drivers/char/Config.help~raw-module	Sun Jul 28 00:22:14 2002
+++ 2.5.29-akpm/drivers/char/Config.help	Sun Jul 28 00:22:14 2002
@@ -1110,3 +1110,9 @@ CONFIG_HVC_CONSOLE
   pSeries machines when partitioned support a hypervisor virtual
   console. This driver allows each pSeries partition to have a console
   which is accessed via the HMC.
+
+CONFIG_RAW_DRIVER
+  The raw driver permits block devices to be bound to /dev/raw/rawN. 
+  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
+  See the raw(8) manpage for more details.
+

.
