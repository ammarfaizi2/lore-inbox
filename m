Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132179AbQK0Qmh>; Mon, 27 Nov 2000 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132187AbQK0QmR>; Mon, 27 Nov 2000 11:42:17 -0500
Received: from 216-99-201-166.hurrah.com ([216.99.201.166]:43791 "EHLO
        magic.skylab.org") by vger.kernel.org with ESMTP id <S132179AbQK0QmL> convert rfc822-to-8bit;
        Mon, 27 Nov 2000 11:42:11 -0500
Date: Mon, 27 Nov 2000 08:12:09 -0800 (PST)
From: "T. Camp" <campt@openmars.com>
To: linux-kernel@vger.kernel.org
Subject: Patch against 2.4-pre-8 for multiple boot-time root= root devices
Message-ID: <Pine.LNX.4.21.0011270801420.4856-100000@magic.skylab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will allow you from something like lilo to do the following:

linux root=/dev/hda1,/dev/hdb1,/dev/hdd1

which will cause the kernel to attempt to probe all three devices in order
until it finds one with a valid filesytem.  This is handy for people that
move devices around a lot (ie the devices changes ID) and provides an easy
and direct solution for bootable cd-roms that could be on anyone of
several types of cdrom device.

caveates:  I don't know much about initrd and the change_root() handling,
to the best of my knowledge this co-exists happily.

I'm not on the list so if you have replies of any nature be sure to cc me
directly.  thanks,

t. camp

--cut here--
diff --recursive --unified --ignore-all-space linux/Documentation/kernel-parameters.txt linux-2.4.0.8/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt	Tue Sep  5 13:51:14 2000
+++ linux-2.4.0.8/Documentation/kernel-parameters.txt	Fri Nov 24 16:51:12 2000
@@ -473,7 +473,11 @@
 
 	ro		[KNL] Mount root device read-only on boot.
 
-	root=		[KNL] root filesystem.
+	root=		[KNL] root filesystem, comma separated list of up
+			to eight /dev/ entries will be tried in order 
+			presented until kernel suceeds in mounting a 
+			filesystem, multiple independant 'root=' entries
+			allowed as well.
 
 	rw		[KNL] Mount root device read-write on boot.
 
diff --recursive --unified --ignore-all-space linux/fs/super.c linux-2.4.0.8/fs/super.c
--- linux/fs/super.c	Fri Aug 11 14:31:45 2000
+++ linux-2.4.0.8/fs/super.c	Fri Nov 24 17:00:29 2000
@@ -18,6 +18,8 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Modifications to mount_root for trying a list of root devices.
+ * 			Tracy Camp <campt@openmars.com> 11/22/00
  */
 
 #include <linux/config.h>
@@ -1447,27 +1449,33 @@
 	struct block_device *bdev = NULL;
 	mode_t mode;
 	int retval;
+	int root_device_index = 0;
 	void *handle;
 	char path[64];
 	int path_start = -1;
 
 #ifdef CONFIG_ROOT_NFS
 	void *data;
-	if (MAJOR(ROOT_DEV) != UNNAMED_MAJOR)
+	if (MAJOR(ROOT_DEV) != UNNAMED_MAJOR) {
 		goto skip_nfs;
+		}
 	fs_type = get_fs_type("nfs");
-	if (!fs_type)
+	if (!fs_type) {
 		goto no_nfs;
+		}
 	ROOT_DEV = get_unnamed_dev();
 	if (!ROOT_DEV)
 		/*
 		 * Your /linuxrc sucks worse than MSExchange - that's the
 		 * only way you could run out of anon devices at that point.
 		 */
+		{
 		goto no_anon;
+		}
 	data = nfs_root_data();
-	if (!data)
+	if (!data) {
 		goto no_server;
+		}
 	sb = read_super(ROOT_DEV, NULL, fs_type, root_mountflags, data, 1);
 	if (sb)
 		/*
@@ -1475,7 +1483,9 @@
 		 * chance anyway (no memory for vfsmnt and we _will_ need it,
 		 * no matter which fs we try to mount).
 		 */
+		{
 		goto mount_it;
+		}
 no_server:
 	put_unnamed_dev(ROOT_DEV);
 no_anon:
@@ -1497,8 +1507,9 @@
 		printk(KERN_NOTICE "(Warning, this kernel has no ramdisk support)\n");
 #else
 		/* rd_doload is 2 for a dual initrd/ramload setup */
-		if(rd_doload==2)
+		if(rd_doload==2) {
 			rd_load_secondary();
+			}
 		else
 #endif
 		{
@@ -1507,13 +1518,21 @@
 		}
 	}
 #endif
+printk("VFS: trying to find root device\n");
+
+	for(root_device_index = 0; root_device_index < number_root_devs; root_device_index++) {
 
-	devfs_make_root (root_device_name);
-	handle = devfs_find_handle (NULL, ROOT_DEVICE_NAME,
-	                            MAJOR (ROOT_DEV), MINOR (ROOT_DEV),
-				    DEVFS_SPECIAL_BLK, 1);
-	if (handle)  /*  Sigh: bd*() functions only paper over the cracks  */
+printk("VFS: trying %s at index %d\n",&root_device_name[root_device_index][0], root_device_index);
+		if(root_device_name[root_device_index][0] != '\0')
 	{
+			ROOT_DEV = name_to_kdev_t(&root_device_name[root_device_index][0]); /* translate */
+			}
+		devfs_make_root (&root_device_name[root_device_index][0]);
+ 
+		handle = devfs_find_handle (NULL, &root_device_name[root_device_index][0], MAJOR (ROOT_DEV), MINOR (ROOT_DEV), DEVFS_SPECIAL_BLK, 1);
+
+/*  Sigh: bd*() functions only paper over the cracks  */
+		if (handle)  {
 	    unsigned major, minor;
 
 	    devfs_get_maj_min (handle, &major, &minor);
@@ -1524,17 +1543,20 @@
 	 * Probably pure paranoia, but I'm less than happy about delving into
 	 * devfs crap and checking it right now. Later.
 	 */
-	if (!ROOT_DEV)
+		if (!ROOT_DEV) {
 		panic("I have no root and I want to scream");
+			}
 
 	bdev = bdget(kdev_t_to_nr(ROOT_DEV));
-	if (!bdev)
+		if (!bdev) {
 		panic(__FUNCTION__ ": unable to allocate root device");
+			}
 	bdev->bd_op = devfs_get_ops (handle);
 	path_start = devfs_generate_path (handle, path + 5, sizeof (path) - 5);
 	mode = FMODE_READ;
-	if (!(root_mountflags & MS_RDONLY))
+		if (!(root_mountflags & MS_RDONLY)) {
 		mode |= FMODE_WRITE;
+			}
 	retval = blkdev_get(bdev, mode, 0, BDEV_FS);
 	if (retval == -EROFS) {
 		root_mountflags |= MS_RDONLY;
@@ -1545,11 +1567,9 @@
 		 * Allow the user to distinguish between failed open
 		 * and bad superblock on root device.
 		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
-			root_device_name, kdevname (ROOT_DEV));
-		printk ("Please append a correct \"root=\" boot option\n");
-		panic("VFS: Unable to mount root fs on %s",
-			kdevname(ROOT_DEV));
+			printk ("VFS: Cannot open root device \"%s\" or %s\n", &root_device_name[root_device_index][0], kdevname (ROOT_DEV));
+			printk("VFS: Unable to mount root fs on %s\n", kdevname(ROOT_DEV));
+			continue;
 	}
 
 	check_disk_change(ROOT_DEV);
@@ -1560,39 +1580,45 @@
 	}
 
 	read_lock(&file_systems_lock);
-	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
-  		if (!(fs_type->fs_flags & FS_REQUIRES_DEV))
+		for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) 
+			{
+  			if (!(fs_type->fs_flags & FS_REQUIRES_DEV)) {
   			continue;
-		if (!try_inc_mod_count(fs_type->owner))
+				}
+			if (!try_inc_mod_count(fs_type->owner)) {
 			continue;
+				}
 		read_unlock(&file_systems_lock);
   		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
-		if (sb) 
+			if (sb) {
 			goto mount_it;
+				}
 		read_lock(&file_systems_lock);
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
-	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+		printk("VFS: Unable to mount root fs on %s\n", kdevname(ROOT_DEV));
+		}
+	printk("VFS: Please append a correct \"root=\" boot option\n");
+	panic("VFS: Unable to mount any root fs at all");
 
 mount_it:
-	printk ("VFS: Mounted root (%s filesystem)%s.\n",
-		fs_type->name,
-		(sb->s_flags & MS_RDONLY) ? " readonly" : "");
+	printk ("VFS: Mounted root (%s filesystem)%s.\n", fs_type->name, (sb->s_flags & MS_RDONLY) ? " readonly" : "");
 	if (path_start >= 0) {
-		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
-				  path + 5 + path_start, NULL, NULL);
+		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT, path + 5 + path_start, NULL, NULL);
 		memcpy (path + path_start, "/dev/", 5);
 		vfsmnt = add_vfsmnt(NULL, sb->s_root, path + path_start);
 	}
-	else
+	else {
 		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root");
+		}
 	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);
 		set_fs_pwd(current->fs, vfsmnt, sb->s_root);
-		if (bdev)
+		if (bdev) {
 			bdput(bdev); /* sb holds a reference */
+			}
 		return;
 	}
 	panic("VFS: add_vfsmnt failed for root fs");
@@ -1735,6 +1761,8 @@
 	struct nameidata devfs_nd, nd;
 	int error = 0;
 
+printk("fs/super.c:change_root() called\n");
+
 	read_lock(&current->fs->lock);
 	old_rootmnt = mntget(current->fs->rootmnt);
 	read_unlock(&current->fs->lock);
@@ -1752,6 +1780,15 @@
 		} else 
 			path_release(&devfs_nd);
 	}
+/* this function seems to only be used when after an initrd usage,
+* so the actual value of ROOT_DEV hasn't been determined until mount_root
+* is called, because we try a list of root devices before giving up,
+* this ROOT_DEV global is somewhat misleading now, as its only valid after
+* a call to mount_root because mount_root ignores the ROOT_DEV value 
+* except for nfs and ram mount attempts going in, but will realise 
+* to not mount RAM again so it should be okay to leave this be. 
+*		- 11/22/00 <campt@openmars.com>
+*/
 	ROOT_DEV = new_root_dev;
 	mount_root();
 #if 1
diff --recursive --unified --ignore-all-space linux/include/linux/fs.h linux-2.4.0.8/include/linux/fs.h
--- linux/include/linux/fs.h	Fri Sep  8 12:52:42 2000
+++ linux-2.4.0.8/include/linux/fs.h	Thu Nov 23 21:25:52 2000
@@ -1200,7 +1200,10 @@
 unsigned long generate_cluster(kdev_t, int b[], int);
 unsigned long generate_cluster_swab32(kdev_t, int b[], int);
 extern kdev_t ROOT_DEV;
-extern char root_device_name[];
+/* following added 11/22/00 by Tracy Camp <campt@openmars.com> */
+extern char root_device_name[8][64];
+extern int number_root_devs;
+extern kdev_t name_to_kdev_t(char *);
 
 
 extern void show_buffers(void);
diff --recursive --unified --ignore-all-space linux/init/main.c linux-2.4.0.8/init/main.c
--- linux/init/main.c	Fri Sep  1 14:25:26 2000
+++ linux-2.4.0.8/init/main.c	Fri Nov 24 16:57:15 2000
@@ -7,6 +7,11 @@
  *  Added initrd & change_root: Werner Almesberger & Hans Lermen, Feb '96
  *  Moan early if gcc is old, avoiding bogus kernels - Paul Gortmaker, May '96
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
+ *
+ *  11/22/00 - added support for up to 8 comma separated and multiple root= 
+ *  arguements. Modified root_dev_setup, and name_to_kdev_t, other changes in
+ *  fs/super.c and include/linux/fs.h to support processing root device list.
+ *  Tracy Camp <campt@openmars.com>
  */
 
 #define __KERNEL_SYSCALLS__
@@ -129,7 +134,8 @@
 
 int root_mountflags = MS_RDONLY;
 char *execute_command;
-char root_device_name[64];
+char root_device_name[8][64];
+int number_root_devs = 0;
 
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
@@ -257,13 +263,13 @@
 	{ NULL, 0 }
 };
 
-kdev_t __init name_to_kdev_t(char *line)
-{
+kdev_t __init name_to_kdev_t(char *line) {
 	int base = 0;
+	struct dev_name_struct *dev = root_dev_names;
 
 	if (strncmp(line,"/dev/",5) == 0) {
-		struct dev_name_struct *dev = root_dev_names;
 		line += 5;
+		}
 		do {
 			int len = strlen(dev->name);
 			if (strncmp(line,dev->name,len) == 0) {
@@ -272,25 +278,51 @@
 				break;
 			}
 			dev++;
-		} while (dev->name);
 	}
+	while (dev->name);
 	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
 }
 
-static int __init root_dev_setup(char *line)
-{
+static int __init root_dev_setup(char *line) {
 	int i;
 	char ch;
 
-	ROOT_DEV = name_to_kdev_t(line);
-	memset (root_device_name, 0, sizeof root_device_name);
-	if (strncmp (line, "/dev/", 5) == 0) line += 5;
-	for (i = 0; i < sizeof root_device_name - 1; ++i)
-	{
+/* number_root_devs is initially 0 and not touched except for 
+incrementing, so this function should be re-callable with the
+desired results */
+	if (strncmp (line, "/dev/", 5) == 0) {
+		line += 5;
+		}
+	memset (root_device_name, 0, sizeof root_device_name[number_root_devs]);
+	for (i = 0; i < sizeof root_device_name[number_root_devs] - 1; ++i) {
 	    ch = line[i];
-	    if ( isspace (ch) || (ch == ',') || (ch == '\0') ) break;
-	    root_device_name[i] = ch;
+	    if ( ch == ',') {
+		if(number_root_devs == 0) {
+			ROOT_DEV = name_to_kdev_t(&root_device_name[number_root_devs][0]); 
+			}
+		number_root_devs++;
+		if(number_root_devs >= 8) {
+			break;
 	}
+		i++;
+		line += i;
+		i = 0;
+		if (strncmp (line, "/dev/", 5) == 0) {
+			line += 5;
+			}
+	        ch = line[i];
+		memset (root_device_name[number_root_devs], 0, sizeof root_device_name[number_root_devs]);
+		}
+	    if ( isspace (ch) || (ch == '\0') ) {
+		if(number_root_devs == 0) {
+			ROOT_DEV = name_to_kdev_t(&root_device_name[number_root_devs][0]); 
+			}
+		number_root_devs++;
+		break;
+		}
+	    root_device_name[number_root_devs][i] = ch;
+	}
+printk("root_dev_setup number_root_devs: %d\n",number_root_devs);
 	return 1;
 }
 
@@ -543,10 +575,8 @@
 	sti();
 	calibrate_delay();
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start && !initrd_below_start_ok &&
-			initrd_start < min_low_pfn << PAGE_SHIFT) {
-		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
-		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
+	if (initrd_start && !initrd_below_start_ok && initrd_start < min_low_pfn << PAGE_SHIFT) {
+		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - " "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
 		initrd_start = 0;
 	}
 #endif
@@ -693,10 +723,10 @@
 	sock_init();
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	real_root_dev = ROOT_DEV;
+	real_root_dev = ROOT_DEV; /* as decided upon by root_dev_setup() */
 	real_root_mountflags = root_mountflags;
-	if (initrd_start && mount_initrd) root_mountflags &= ~MS_RDONLY;
-	else mount_initrd =0;
+	if (initrd_start && mount_initrd) { root_mountflags &= ~MS_RDONLY; }
+	else { mount_initrd =0; }
 #endif
 
 	do_initcalls();
@@ -717,23 +747,22 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	root_mountflags = real_root_mountflags;
-	if (mount_initrd && ROOT_DEV != real_root_dev
-	    && MAJOR(ROOT_DEV) == RAMDISK_MAJOR && MINOR(ROOT_DEV) == 0) {
+	if (mount_initrd && ROOT_DEV != real_root_dev && MAJOR(ROOT_DEV) == RAMDISK_MAJOR && MINOR(ROOT_DEV) == 0) {
 		int error;
 		int i, pid;
 
 		pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
-		if (pid>0)
+		if (pid>0) {
 			while (pid != wait(&i));
-		if (MAJOR(real_root_dev) != RAMDISK_MAJOR
-		     || MINOR(real_root_dev) != 0) {
+			}
+		if (MAJOR(real_root_dev) != RAMDISK_MAJOR || MINOR(real_root_dev) != 0) {
 #ifdef CONFIG_BLK_DEV_MD
 			md_run_setup();
 #endif
 			error = change_root(real_root_dev,"/initrd");
-			if (error)
-				printk(KERN_ERR "Change root to /initrd: "
-				    "error %d\n",error);
+			if (error) {
+				printk(KERN_ERR "Change root to /initrd: error %d\n",error);
+				}
 		}
 	}
 #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
