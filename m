Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSKJEp2>; Sat, 9 Nov 2002 23:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264744AbSKJEp2>; Sat, 9 Nov 2002 23:45:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26827 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264743AbSKJEpS>;
	Sat, 9 Nov 2002 23:45:18 -0500
Date: Sat, 9 Nov 2002 23:51:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, jgarzik@math.psu.edu
Subject: [CFT] late-boot cleanups
Message-ID: <Pine.GSO.4.21.0211092341470.24061-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	WARNING: patch is absolutely untested.  Don't merge.

Contents:
	RAID setup switched to use of syscalls (== prepared to be moved to
userland)
	devfs_get_handle() call in do_mounts.c::create_dev() (one of the
remaining obstacles to taking the thing to userland) replaced with use
of syscalls.  Note that it exposes existing horror: in some cases that
code (and existing code in the tree) actually *walks* the devfs tree in
search for node with given major/minor.  Yup, recursively (both the vanilla
and patched tree).  At least now we can take it to userland, getting rid
of stack overflows...

	If any brave soul is willing to test it (different RAID-based setups,
with devfs or not) - you are welcome, but keep in mind that I don't have
RAID setups, so all I can promise is that thing compiles.  Comments are
obviously also welcome.

diff -urN C46-2/drivers/md/md.c C46-late_boot/drivers/md/md.c
--- C46-2/drivers/md/md.c	Sat Nov  9 10:17:30 2002
+++ C46-late_boot/drivers/md/md.c	Sat Nov  9 21:22:17 2002
@@ -3133,20 +3133,6 @@
 #ifndef MODULE
 
 /*
- * When md (and any require personalities) are compiled into the kernel
- * (not a module), arrays can be assembles are boot time using with AUTODETECT
- * where specially marked partitions are registered with md_autodetect_dev(),
- * and with MD_BOOT where devices to be collected are given on the boot line
- * with md=.....
- * The code for that is here.
- */
-
-struct {
-	int set;
-	int noautodetect;
-} raid_setup_args __initdata;
-
-/*
  * Searches all registered partitions for autorun RAID arrays
  * at boot time.
  */
@@ -3187,262 +3173,9 @@
 	autorun_devices();
 }
 
-static struct {
-	char device_set [MAX_MD_DEVS];
-	int pers[MAX_MD_DEVS];
-	int chunk[MAX_MD_DEVS];
-	char *device_names[MAX_MD_DEVS];
-} md_setup_args __initdata;
-
-/*
- * Parse the command-line parameters given our kernel, but do not
- * actually try to invoke the MD device now; that is handled by
- * md_setup_drive after the low-level disk drivers have initialised.
- *
- * 27/11/1999: Fixed to work correctly with the 2.3 kernel (which
- *             assigns the task of parsing integer arguments to the
- *             invoked program now).  Added ability to initialise all
- *             the MD devices (by specifying multiple "md=" lines)
- *             instead of just one.  -- KTK
- * 18May2000: Added support for persistent-superblock arrays:
- *             md=n,0,factor,fault,device-list   uses RAID0 for device n
- *             md=n,-1,factor,fault,device-list  uses LINEAR for device n
- *             md=n,device-list      reads a RAID superblock from the devices
- *             elements in device-list are read by name_to_kdev_t so can be
- *             a hex number or something like /dev/hda1 /dev/sdb
- * 2001-06-03: Dave Cinege <dcinege@psychosis.com>
- *		Shifted name_to_kdev_t() and related operations to md_set_drive()
- *		for later execution. Rewrote section to make devfs compatible.
- */
-static int __init md_setup(char *str)
-{
-	int minor, level, factor, fault, pers;
-	char *pername = "";
-	char *str1 = str;
-
-	if (get_option(&str, &minor) != 2) {	/* MD Number */
-		printk(KERN_WARNING "md: Too few arguments supplied to md=.\n");
-		return 0;
-	}
-	if (minor >= MAX_MD_DEVS) {
-		printk(KERN_WARNING "md: md=%d, Minor device number too high.\n", minor);
-		return 0;
-	} else if (md_setup_args.device_names[minor]) {
-		printk(KERN_WARNING "md: md=%d, Specified more than once. "
-		       "Replacing previous definition.\n", minor);
-	}
-	switch (get_option(&str, &level)) {	/* RAID Personality */
-	case 2: /* could be 0 or -1.. */
-		if (level == 0 || level == LEVEL_LINEAR) {
-			if (get_option(&str, &factor) != 2 ||	/* Chunk Size */
-					get_option(&str, &fault) != 2) {
-				printk(KERN_WARNING "md: Too few arguments supplied to md=.\n");
-				return 0;
-			}
-			md_setup_args.pers[minor] = level;
-			md_setup_args.chunk[minor] = 1 << (factor+12);
-			switch(level) {
-			case LEVEL_LINEAR:
-				pers = LINEAR;
-				pername = "linear";
-				break;
-			case 0:
-				pers = RAID0;
-				pername = "raid0";
-				break;
-			default:
-				printk(KERN_WARNING
-				       "md: The kernel has not been configured for raid%d support!\n",
-				       level);
-				return 0;
-			}
-			md_setup_args.pers[minor] = pers;
-			break;
-		}
-		/* FALL THROUGH */
-	case 1: /* the first device is numeric */
-		str = str1;
-		/* FALL THROUGH */
-	case 0:
-		md_setup_args.pers[minor] = 0;
-		pername="super-block";
-	}
-
-	printk(KERN_INFO "md: Will configure md%d (%s) from %s, below.\n",
-		minor, pername, str);
-	md_setup_args.device_names[minor] = str;
-
-	return 1;
-}
-
-extern dev_t name_to_dev_t(char *line) __init;
-void __init md_setup_drive(void)
-{
-	int minor, i;
-	dev_t dev;
-	mddev_t*mddev;
-	dev_t devices[MD_SB_DISKS+1];
-
-	for (minor = 0; minor < MAX_MD_DEVS; minor++) {
-		int err = 0;
-		char *devname;
-		mdu_disk_info_t dinfo;
-
-		if (!(devname = md_setup_args.device_names[minor]))
-			continue;
-
-		for (i = 0; i < MD_SB_DISKS && devname != 0; i++) {
-
-			char *p;
-			void *handle;
-
-			p = strchr(devname, ',');
-			if (p)
-				*p++ = 0;
-
-			dev = name_to_dev_t(devname);
-			handle = devfs_get_handle(NULL, devname,
-						MAJOR(dev), MINOR(dev),
-						DEVFS_SPECIAL_BLK, 1);
-			if (handle != 0) {
-				unsigned major, minor;
-				devfs_get_maj_min(handle, &major, &minor);
-				dev = MKDEV(major, minor);
-				devfs_put(handle);
-			}
-			if (!dev) {
-				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
-				break;
-			}
-
-			devices[i] = dev;
-			md_setup_args.device_set[minor] = 1;
-
-			devname = p;
-		}
-		devices[i] = 0;
-
-		if (!md_setup_args.device_set[minor])
-			continue;
-
-		printk(KERN_INFO "md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
-
-		mddev = mddev_find(minor);
-		if (!mddev) {
-			printk(KERN_ERR "md: kmalloc failed - cannot start array %d\n", minor);
-			continue;
-		}
-		if (mddev_lock(mddev)) {
-			printk(KERN_WARNING
-			       "md: Ignoring md=%d, cannot lock!\n",
-			       minor);
-			mddev_put(mddev);
-			continue;
-		}
-
-		if (mddev->raid_disks || !list_empty(&mddev->disks)) {
-			printk(KERN_WARNING
-			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
-			       minor);
-			mddev_unlock(mddev);
-			mddev_put(mddev);
-			continue;
-		}
-		if (md_setup_args.pers[minor]) {
-			/* non-persistent */
-			mdu_array_info_t ainfo;
-			ainfo.level = pers_to_level(md_setup_args.pers[minor]);
-			ainfo.size = 0;
-			ainfo.nr_disks =0;
-			ainfo.raid_disks =0;
-			ainfo.md_minor =minor;
-			ainfo.not_persistent = 1;
-
-			ainfo.state = (1 << MD_SB_CLEAN);
-			ainfo.layout = 0;
-			ainfo.chunk_size = md_setup_args.chunk[minor];
-			err = set_array_info(mddev, &ainfo);
-			for (i = 0; !err && i <= MD_SB_DISKS; i++) {
-				dev = devices[i];
-				if (!dev)
-					break;
-				dinfo.number = i;
-				dinfo.raid_disk = i;
-				dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
-				mddev->raid_disks++;
-				err = add_new_disk (mddev, &dinfo);
-			}
-		} else {
-			/* persistent */
-			for (i = 0; i <= MD_SB_DISKS; i++) {
-				dev = devices[i];
-				if (!dev)
-					break;
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
-				add_new_disk (mddev, &dinfo);
-			}
-		}
-		if (!err)
-			err = do_md_run(mddev);
-		if (err) {
-			mddev->sb_dirty = 0;
-			do_md_stop(mddev, 0);
-			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		}
-		mddev_unlock(mddev);
-		mddev_put(mddev);
-	}
-}
-
-static int __init raid_setup(char *str)
-{
-	int len, pos;
-
-	len = strlen(str) + 1;
-	pos = 0;
-
-	while (pos < len) {
-		char *comma = strchr(str+pos, ',');
-		int wlen;
-		if (comma)
-			wlen = (comma-str)-pos;
-		else	wlen = (len-1)-pos;
-
-		if (!strncmp(str, "noautodetect", wlen))
-			raid_setup_args.noautodetect = 1;
-		pos += wlen+1;
-	}
-	raid_setup_args.set = 1;
-	return 1;
-}
-
-static int __init md_run_setup(void)
-{
-	if (raid_setup_args.noautodetect)
-		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
-	else
-		autostart_arrays();
-	md_setup_drive();
-	return 0;
-}
-
-__setup("raid=", raid_setup);
-__setup("md=", md_setup);
-
-__initcall(md_init);
-__initcall(md_run_setup);
-
-#else /* It is a MODULE */
-
-int init_module(void)
-{
-	return md_init();
-}
+#endif
 
-void cleanup_module(void)
+static __exit void md_exit(void)
 {
 	int i;
 	blk_unregister_region(MKDEV(MAJOR_NR,0), MAX_MD_DEVS);
@@ -3466,7 +3199,9 @@
 		mddev_put(mddev);
 	}
 }
-#endif
+
+module_init(md_init)
+module_exit(md_exit)
 
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
diff -urN C46-2/fs/partitions/check.c C46-late_boot/fs/partitions/check.c
--- C46-2/fs/partitions/check.c	Sat Nov  9 10:17:32 2002
+++ C46-late_boot/fs/partitions/check.c	Sat Nov  9 22:52:16 2002
@@ -190,8 +190,6 @@
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
 	static devfs_handle_t devfs_handle;
-	int part, max_p = dev->minors;
-	struct hd_struct *p = dev->part;
 
 	if (dev->flags & GENHD_FL_REMOVABLE)
 		devfs_flags |= DEVFS_FL_REMOVABLE;
@@ -227,10 +225,6 @@
 static void devfs_create_cdrom(struct gendisk *dev)
 {
 #ifdef CONFIG_DEVFS_FS
-	int pos = 0;
-	devfs_handle_t dir, slave;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
-	char dirname[64], symlink[16];
 	char vname[23];
 
 	if (!cdroms)
diff -urN C46-2/include/linux/suspend.h C46-late_boot/include/linux/suspend.h
--- C46-2/include/linux/suspend.h	Tue Oct 15 23:58:42 2002
+++ C46-late_boot/include/linux/suspend.h	Sat Nov  9 22:31:48 2002
@@ -72,7 +72,9 @@
 extern void do_suspend_lowlevel(int resume);
 
 #else
-#define software_suspend()		do { } while(0)
+static inline void software_suspend(void)
+{
+}
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
diff -urN C46-2/init/do_mounts.c C46-late_boot/init/do_mounts.c
--- C46-2/init/do_mounts.c	Mon Nov  4 19:32:36 2002
+++ C46-late_boot/init/do_mounts.c	Sat Nov  9 22:30:30 2002
@@ -20,6 +20,8 @@
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 
+#include <linux/raid/md.h>
+
 #define BUILD_CRAMDISK
 
 extern int get_filesystem_list(char * buf);
@@ -36,6 +38,10 @@
 extern asmlinkage long sys_mknod(const char *name, int mode, dev_t dev);
 extern asmlinkage long sys_umount(char *name, int flags);
 extern asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
+extern asmlinkage long sys_access(const char * filename, int mode);
+extern asmlinkage long sys_newstat(char * filename, struct stat * statbuf);
+extern asmlinkage long sys_getdents64(unsigned int fd, void * dirent,
+	unsigned int count);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
@@ -315,25 +321,124 @@
 }
 #endif
 
+#ifdef CONFIG_DEVFS_FS
+static int __init do_read_dir(int fd, void *buf, int len)
+{
+	long bytes, n;
+	char *p = buf;
+	lseek(fd, 0, 0);
+
+	for (bytes = 0, p = buf; bytes < len; bytes += n, p+=n) {
+		n = sys_getdents64(fd, p, len);
+		if (n < 0)
+			return -1;
+		if (n == 0)
+			return bytes;
+	}
+	return 0;
+}
+
+static void * __init read_dir(char *path, int *len)
+{
+	int size;
+	int fd = open(path, 0, 0);
+
+	*len = 0;
+	if (fd < 0)
+		return NULL;
+
+	for (size = 1<<9; size < (1<<18); size <<= 1) {
+		void *p = kmalloc(size, GFP_KERNEL);
+		int n;
+		if (!p)
+			break;
+		n = do_read_dir(fd, p, size);
+		if (n < 0)
+			break;
+		if (n > 0) {
+			close(fd);
+			*len = n;
+			return p;
+		}
+	}
+	close(fd);
+	return NULL;
+}
+#endif
+
+struct linux_dirent64 {
+	u64		d_ino;
+	s64		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+static int __init find_in_devfs(char *path, dev_t dev)
+{
+#ifdef CONFIG_DEVFS_FS
+	struct stat buf;
+	char *end = path + strlen(path);
+	int rest = path + 64 - end;
+	int size;
+	char *p = read_dir(path, &size);
+	char *s;
+
+	if (!p)
+		return -1;
+	for (s = p; s < p + size; s += ((struct linux_dirent64 *)s)->d_reclen) {
+		struct linux_dirent64 *d = (struct linux_dirent64 *)s;
+		if (strlen(d->d_name) + 2 > rest)
+			continue;
+		switch (d->d_type) {
+			case DT_BLK:
+				sprintf(end, "/%s", d->d_name);
+				if (sys_newstat(path, &buf) < 0)
+					break;
+				if (!S_ISBLK(buf.st_mode))
+					break;
+				if (buf.st_rdev != dev)
+					break;
+				kfree(p);
+				return 0;
+			case DT_DIR:
+				if (strcmp(d->d_name, ".") == 0)
+					break;
+				if (strcmp(d->d_name, "..") == 0)
+					break;
+				sprintf(end, "/%s", d->d_name);
+				if (find_in_devfs(path, dev) < 0)
+					break;
+				kfree(p);
+				return 0;
+		}
+	}
+	kfree(p);
+#endif
+	return -1;
+}
+
 static int __init create_dev(char *name, dev_t dev, char *devfs_name)
 {
-	void *handle;
 	char path[64];
-	int n;
 
 	sys_unlink(name);
 	if (!do_devfs)
 		return sys_mknod(name, S_IFBLK|0600, dev);
 
-	handle = devfs_get_handle(NULL, !dev ? devfs_name : NULL,
-				  MAJOR(dev), MINOR(dev), DEVFS_SPECIAL_BLK, 1);
-	if (!handle)
+	if (devfs_name && devfs_name[0]) {
+		if (strncmp(devfs_name, "/dev/", 5) == 0)
+			devfs_name += 5;
+		sprintf(path, "/dev/%s", devfs_name);
+		if (sys_access(path, 0) == 0)
+			return sys_symlink(devfs_name, name);
+	}
+	if (!dev)
 		return -1;
-	n = devfs_generate_path(handle, path + 5, sizeof (path) - 5);
-	devfs_put(handle);
-	if (n < 0)
+	strcpy(path, "/dev");
+	if (find_in_devfs(path, dev) < 0)
 		return -1;
-	return sys_symlink(path + n + 5, name);
+	return sys_symlink(path + 5, name);
 }
 
 #if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
@@ -730,12 +835,14 @@
 	return rd_load_image("/dev/initrd");
 }
 
+static void __init md_run_setup(void);
+
 /*
  * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
  */
 void prepare_namespace(void)
 {
-	int is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
+	int is_floppy;
 	if (saved_root_name[0]) {
 		char *p = saved_root_name;
 		ROOT_DEV = name_to_dev_t(p);
@@ -743,6 +850,7 @@
 			p += 5;
 		strcpy(root_device_name, p);
 	}
+	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (!initrd_start)
 		mount_initrd = 0;
@@ -754,6 +862,8 @@
 	do_devfs = 1;
 #endif
 
+	md_run_setup();
+
 	create_dev("/dev/root", ROOT_DEV, NULL);
 
 	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
@@ -922,3 +1032,260 @@
 }
 
 #endif  /* BUILD_CRAMDISK && CONFIG_BLK_DEV_RAM */
+
+#ifdef CONFIG_BLK_DEV_MD
+
+/*
+ * When md (and any require personalities) are compiled into the kernel
+ * (not a module), arrays can be assembles are boot time using with AUTODETECT
+ * where specially marked partitions are registered with md_autodetect_dev(),
+ * and with MD_BOOT where devices to be collected are given on the boot line
+ * with md=.....
+ * The code for that is here.
+ */
+
+struct {
+	int set;
+	int noautodetect;
+} raid_setup_args __initdata;
+
+static struct {
+	char device_set [MAX_MD_DEVS];
+	int pers[MAX_MD_DEVS];
+	int chunk[MAX_MD_DEVS];
+	char *device_names[MAX_MD_DEVS];
+} md_setup_args __initdata;
+
+/*
+ * Parse the command-line parameters given our kernel, but do not
+ * actually try to invoke the MD device now; that is handled by
+ * md_setup_drive after the low-level disk drivers have initialised.
+ *
+ * 27/11/1999: Fixed to work correctly with the 2.3 kernel (which
+ *             assigns the task of parsing integer arguments to the
+ *             invoked program now).  Added ability to initialise all
+ *             the MD devices (by specifying multiple "md=" lines)
+ *             instead of just one.  -- KTK
+ * 18May2000: Added support for persistent-superblock arrays:
+ *             md=n,0,factor,fault,device-list   uses RAID0 for device n
+ *             md=n,-1,factor,fault,device-list  uses LINEAR for device n
+ *             md=n,device-list      reads a RAID superblock from the devices
+ *             elements in device-list are read by name_to_kdev_t so can be
+ *             a hex number or something like /dev/hda1 /dev/sdb
+ * 2001-06-03: Dave Cinege <dcinege@psychosis.com>
+ *		Shifted name_to_kdev_t() and related operations to md_set_drive()
+ *		for later execution. Rewrote section to make devfs compatible.
+ */
+static int __init md_setup(char *str)
+{
+	int minor, level, factor, fault, pers;
+	char *pername = "";
+	char *str1 = str;
+
+	if (get_option(&str, &minor) != 2) {	/* MD Number */
+		printk(KERN_WARNING "md: Too few arguments supplied to md=.\n");
+		return 0;
+	}
+	if (minor >= MAX_MD_DEVS) {
+		printk(KERN_WARNING "md: md=%d, Minor device number too high.\n", minor);
+		return 0;
+	} else if (md_setup_args.device_names[minor]) {
+		printk(KERN_WARNING "md: md=%d, Specified more than once. "
+		       "Replacing previous definition.\n", minor);
+	}
+	switch (get_option(&str, &level)) {	/* RAID Personality */
+	case 2: /* could be 0 or -1.. */
+		if (level == 0 || level == LEVEL_LINEAR) {
+			if (get_option(&str, &factor) != 2 ||	/* Chunk Size */
+					get_option(&str, &fault) != 2) {
+				printk(KERN_WARNING "md: Too few arguments supplied to md=.\n");
+				return 0;
+			}
+			md_setup_args.pers[minor] = level;
+			md_setup_args.chunk[minor] = 1 << (factor+12);
+			switch(level) {
+			case LEVEL_LINEAR:
+				pers = LINEAR;
+				pername = "linear";
+				break;
+			case 0:
+				pers = RAID0;
+				pername = "raid0";
+				break;
+			default:
+				printk(KERN_WARNING
+				       "md: The kernel has not been configured for raid%d support!\n",
+				       level);
+				return 0;
+			}
+			md_setup_args.pers[minor] = pers;
+			break;
+		}
+		/* FALL THROUGH */
+	case 1: /* the first device is numeric */
+		str = str1;
+		/* FALL THROUGH */
+	case 0:
+		md_setup_args.pers[minor] = 0;
+		pername="super-block";
+	}
+
+	printk(KERN_INFO "md: Will configure md%d (%s) from %s, below.\n",
+		minor, pername, str);
+	md_setup_args.device_names[minor] = str;
+
+	return 1;
+}
+static void __init md_setup_drive(void)
+{
+	int minor, i;
+	dev_t dev;
+	dev_t devices[MD_SB_DISKS+1];
+
+	for (minor = 0; minor < MAX_MD_DEVS; minor++) {
+		int fd;
+		int err = 0;
+		char *devname;
+		mdu_disk_info_t dinfo;
+		char name[16], devfs_name[16];
+
+		if (!(devname = md_setup_args.device_names[minor]))
+			continue;
+		
+		sprintf(name, "/dev/md%d", minor);
+		sprintf(devfs_name, "/dev/md/%d", minor);
+		create_dev(name, MKDEV(MD_MAJOR, minor), devfs_name);
+		for (i = 0; i < MD_SB_DISKS && devname != 0; i++) {
+			char *p;
+			char comp_name[64];
+			struct stat buf;
+
+			p = strchr(devname, ',');
+			if (p)
+				*p++ = 0;
+
+			dev = name_to_dev_t(devname);
+			if (strncmp(devname, "/dev/", 5))
+				devname += 5;
+			snprintf(comp_name, 63, "/dev/%s", devname);
+			if (sys_newstat(comp_name, &buf) == 0 &&
+							S_ISBLK(buf.st_mode))
+				dev = buf.st_rdev;
+			if (!dev) {
+				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
+				break;
+			}
+
+			devices[i] = dev;
+			md_setup_args.device_set[minor] = 1;
+
+			devname = p;
+		}
+		devices[i] = 0;
+
+		if (!md_setup_args.device_set[minor])
+			continue;
+
+		printk(KERN_INFO "md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
+
+		fd = open(name, 0, 0);
+		if (fd < 0) {
+			printk(KERN_ERR "md: open failed - cannot start array %d\n", minor);
+			continue;
+		}
+		if (sys_ioctl(fd, SET_ARRAY_INFO, 0) == -EBUSY) {
+			printk(KERN_WARNING
+			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
+			       minor);
+			close(fd);
+			continue;
+		}
+
+		if (md_setup_args.pers[minor]) {
+			/* non-persistent */
+			mdu_array_info_t ainfo;
+			ainfo.level = pers_to_level(md_setup_args.pers[minor]);
+			ainfo.size = 0;
+			ainfo.nr_disks =0;
+			ainfo.raid_disks =0;
+			while (devices[ainfo.raid_disks])
+				ainfo.raid_disks++;
+			ainfo.md_minor =minor;
+			ainfo.not_persistent = 1;
+
+			ainfo.state = (1 << MD_SB_CLEAN);
+			ainfo.layout = 0;
+			ainfo.chunk_size = md_setup_args.chunk[minor];
+			err = sys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
+			for (i = 0; !err && i <= MD_SB_DISKS; i++) {
+				dev = devices[i];
+				if (!dev)
+					break;
+				dinfo.number = i;
+				dinfo.raid_disk = i;
+				dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
+				dinfo.major = MAJOR(dev);
+				dinfo.minor = MINOR(dev);
+				err = sys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
+			}
+		} else {
+			/* persistent */
+			for (i = 0; i <= MD_SB_DISKS; i++) {
+				dev = devices[i];
+				if (!dev)
+					break;
+				dinfo.major = MAJOR(dev);
+				dinfo.minor = MINOR(dev);
+				sys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
+			}
+		}
+		if (!err)
+			err = sys_ioctl(fd, RUN_ARRAY, 0);
+		if (err)
+			printk(KERN_WARNING "md: starting md%d failed\n", minor);
+		close(fd);
+	}
+}
+
+static int __init raid_setup(char *str)
+{
+	int len, pos;
+
+	len = strlen(str) + 1;
+	pos = 0;
+
+	while (pos < len) {
+		char *comma = strchr(str+pos, ',');
+		int wlen;
+		if (comma)
+			wlen = (comma-str)-pos;
+		else	wlen = (len-1)-pos;
+
+		if (!strncmp(str, "noautodetect", wlen))
+			raid_setup_args.noautodetect = 1;
+		pos += wlen+1;
+	}
+	raid_setup_args.set = 1;
+	return 1;
+}
+
+__setup("raid=", raid_setup);
+__setup("md=", md_setup);
+#endif
+
+static void __init md_run_setup(void)
+{
+#ifdef CONFIG_BLK_DEV_MD
+	create_dev("md0", MKDEV(MD_MAJOR, 0), "md/0");
+	if (raid_setup_args.noautodetect)
+		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
+	else {
+		int fd = open("/dev/md0", 0, 0);
+		if (fd >= 0) {
+			sys_ioctl(fd, RAID_AUTORUN, 0);
+			close(fd);
+		}
+	}
+	md_setup_drive();
+#endif
+}

