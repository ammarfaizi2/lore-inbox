Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSKBXlb>; Sat, 2 Nov 2002 18:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSKBXlb>; Sat, 2 Nov 2002 18:41:31 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:12933
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S261490AbSKBXks>; Sat, 2 Nov 2002 18:40:48 -0500
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Linus Torvalds <torvalds@transmeta.com>,
       Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
Date: Sat, 2 Nov 2002 18:46:44 -0500
User-Agent: KMail/1.4.2
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       <hpa@zytor.com>, <viro@math.psu.edu>
References: <Pine.LNX.4.44.0211021049480.2413-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211021049480.2413-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WD3Z8QAP9E8SYDKGGUP3"
Message-Id: <200211021846.44462.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WD3Z8QAP9E8SYDKGGUP3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Saturday 02 November 2002 14:01, Linus Torvalds wrote:
>
> Note that the reason I personally really want initramfs is not to make the
> kernel boot image smaller, or the kernel sources smaller.

Again for your consideration:

Initrd Dynamic  (Dynamic Initial Ramdisk)

Initrd Dynamic allows extracting tar and tar.gz archives to the rootfs.
It additonally cleans do_mounts, and rewrites the legacy initrd system. 

It provides the same functionality of initramfs but in a more mature and 
robust system. It does not depend on legacy initrd operation. It will
prepare 'early userspace' with klibc, et al. 

With your acceptance an additonal patch will be forthcoming making
the legacy initrd system a compile time option, and moving the call to 
initrd_mount() from do_mounts, to main. (IE compile time initrd.o)

Further patches will purge specific legacy initrd operations from the
general code base and move them to initrd.c where appropreate. 

A patch against 2.5.45 is here and attached:
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/initrd_dynamic-2.5.45.diff.gz

You can view the primary files involved here, already 'post-patched' 2.5.45:
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/do_mounts.c
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/initrd.c
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/untar.c


--------------Boundary-00=_WD3Z8QAP9E8SYDKGGUP3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="initrd_dynamic-2.5.45.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="initrd_dynamic-2.5.45.diff"

diff -uNr linux-2.5.45-virgin/drivers/block/Kconfig linux-2.5.45-initrd_dyn/drivers/block/Kconfig
--- linux-2.5.45-virgin/drivers/block/Kconfig	2002-11-01 05:24:59.000000000 -0500
+++ linux-2.5.45-initrd_dyn/drivers/block/Kconfig	2002-11-01 01:55:37.000000000 -0500
@@ -331,6 +331,18 @@
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
 
+config BLK_DEV_INITRD_UNTAR
+	bool "Initial RAM disk untar support (requires TMPFS)"
+	depends on BLK_DEV_INITRD && TMPFS
+	help
+	  Untar support to a tmpfs root. Say Y.
+
+config BLK_DEV_INITRD_GUNZIP
+	bool "Initial RAM disk gunzip support"
+	depends on BLK_DEV_INITRD
+	help
+	  Use gzip compressed images/archives with initrd. Say Y.
+
 config LBD
 	bool "Support for Large Block Devices"
 	depends on X86
diff -uNr linux-2.5.45-virgin/include/linux/root_dev.h linux-2.5.45-initrd_dyn/include/linux/root_dev.h
--- linux-2.5.45-virgin/include/linux/root_dev.h	2002-10-19 00:01:18.000000000 -0400
+++ linux-2.5.45-initrd_dyn/include/linux/root_dev.h	2002-11-01 03:11:42.000000000 -0500
@@ -3,6 +3,7 @@
 
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
+	Root_TMPFS = MKDEV(UNNAMED_MAJOR, 12),
 	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
 	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
 	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
diff -uNr linux-2.5.45-virgin/init/do_mounts.c linux-2.5.45-initrd_dyn/init/do_mounts.c
--- linux-2.5.45-virgin/init/do_mounts.c	2002-11-01 05:25:08.000000000 -0500
+++ linux-2.5.45-initrd_dyn/init/do_mounts.c	2002-11-01 01:56:50.000000000 -0500
@@ -20,8 +20,6 @@
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 
-#define BUILD_CRAMDISK
-
 extern int get_filesystem_list(char * buf);
 
 extern asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
@@ -37,24 +35,16 @@
 extern asmlinkage long sys_umount(char *name, int flags);
 extern asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
-static int __initdata mount_initrd = 1;
+int root_mountflags = MS_RDONLY | MS_VERBOSE;
 
-static int __init no_initrd(char *str)
-{
-	mount_initrd = 0;
-	return 1;
-}
+int __initdata rd_doload;	/* 1 = load initrd, 0 = don't load */
+int __initdata rd_prompt = 1;	/* 1 = prompt for initrd floppy, 0 = don't prompt */
+int __initdata rd_image_start;	/* starting block # of image */
 
-__setup("noinitrd", no_initrd);
-#else
-static int __initdata mount_initrd = 0;
+#ifdef CONFIG_BLK_DEV_INITRD_UNTAR
+static unsigned long __initdata tmpfs_root_fssize = 0;
 #endif
 
-int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
-
-int root_mountflags = MS_RDONLY | MS_VERBOSE;
 static char root_device_name[64];
 static char saved_root_name[64];
 
@@ -63,13 +53,6 @@
 
 static int do_devfs = 0;
 
-static int __init load_ramdisk(char *str)
-{
-	rd_doload = simple_strtol(str,NULL,0) & 3;
-	return 1;
-}
-__setup("load_ramdisk=", load_ramdisk);
-
 static int __init readonly(char *str)
 {
 	if (*str)
@@ -85,7 +68,6 @@
 	root_mountflags &= ~MS_RDONLY;
 	return 1;
 }
-
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
@@ -220,7 +202,6 @@
 	saved_root_name[63] = '\0';
 	return 1;
 }
-
 __setup("root=", root_dev_setup);
 
 static char * __initdata root_mount_data;
@@ -236,7 +217,6 @@
 	root_fs_names = str;
 	return 1;
 }
-
 __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 
@@ -266,6 +246,20 @@
 	}
 	*s = '\0';
 }
+
+static void __init bad_root_panic(void)
+{
+        /*
+	 * Allow the user to distinguish between failed open
+	 * and bad superblock on root device.
+	 */
+	printk ("VFS: Cannot open root device \"%s\" or %s\n",
+		root_device_name, kdevname (to_kdev_t(ROOT_DEV)));
+	printk ("Please append a correct \"root=\" boot option\n");
+	panic("VFS: Unable to mount root fs on %s",
+		kdevname(to_kdev_t(ROOT_DEV)));
+}
+
 static void __init mount_block_root(char *name, int flags)
 {
 	char *fs_names = __getname();
@@ -284,15 +278,7 @@
 			case -EINVAL:
 				continue;
 		}
-	        /*
-		 * Allow the user to distinguish between failed open
-		 * and bad superblock on root device.
-		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
-			root_device_name, kdevname (to_kdev_t(ROOT_DEV)));
-		printk ("Please append a correct \"root=\" boot option\n");
-		panic("VFS: Unable to mount root fs on %s",
-			kdevname(to_kdev_t(ROOT_DEV)));
+		bad_root_panic();
 	}
 	panic("VFS: Unable to mount root fs on %s", kdevname(to_kdev_t(ROOT_DEV)));
 out:
@@ -304,16 +290,63 @@
 		(current->fs->pwdmnt->mnt_sb->s_flags & MS_RDONLY) ? " readonly" : "");
 }
  
-#ifdef CONFIG_ROOT_NFS
+static int __init mount_tmpfs_root(char *name)
+{
+#ifndef CONFIG_BLK_DEV_INITRD_UNTAR
+	if (ROOT_DEV != Root_TMPFS)
+		return 0;
+		
+	printk(KERN_ERR "VFS: Kernel does not support root fs on tmpfs.\n");
+	bad_root_panic();
+	return 0;
+#else
+	char data[16] = {0};
+	
+	if (ROOT_DEV != Root_TMPFS)
+		return 0;
+		
+	if (tmpfs_root_fssize > 0)
+		snprintf(data, sizeof(data), "size=%luk", tmpfs_root_fssize);
+
+	if (sys_mount(name,"/root","tmpfs",root_mountflags & ~MS_RDONLY,data) == 0) {
+		sys_chdir("/root");
+		ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
+		printk("VFS: Mounted root (tmpfs filesystem). [");
+		if (tmpfs_root_fssize) printk("%luKB",tmpfs_root_fssize); else printk("No");
+		printk(" Ceiling]\n");
+		return 1;
+	}
+	printk(KERN_ERR "VFS: Unable to mount root fs on tmpfs.\n");
+	return 0;
+#endif
+}
+ 
 static int __init mount_nfs_root(void)
 {
+#ifndef CONFIG_ROOT_NFS
+	if (ROOT_DEV != Root_NFS)
+		return 0;
+		
+	printk(KERN_ERR "VFS: Kernel does not support root fs via NFS.\n");
+	bad_root_panic();
+	return 0;
+#else
 	void *data = nfs_root_data();
 
-	if (data && sys_mount("/dev/root","/root","nfs",root_mountflags,data) == 0)
+	if (ROOT_DEV != Root_NFS)
+		return 0;
+
+	if (data && sys_mount("/dev/root","/root","nfs",root_mountflags,data) == 0) {
+		sys_chdir("/root");
+		ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
+		printk("VFS: Mounted root (nfs filesystem).\n");
 		return 1;
+	}
+	printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying initrd.\n");
+	root_dev_setup("/dev/ram0");
 	return 0;
-}
 #endif
+}
 
 static int __init create_dev(char *name, dev_t dev, char *devfs_name)
 {
@@ -336,398 +369,21 @@
 	return sys_symlink(path + n + 5, name);
 }
 
-#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
-static void __init change_floppy(char *fmt, ...)
-{
-	struct termios termios;
-	char buf[80];
-	char c;
-	int fd;
-	va_list args;
-	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
-	va_end(args);
-	fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
-	if (fd >= 0) {
-		sys_ioctl(fd, FDEJECT, 0);
-		close(fd);
-	}
-	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
-	fd = open("/dev/console", O_RDWR, 0);
-	if (fd >= 0) {
-		sys_ioctl(fd, TCGETS, (long)&termios);
-		termios.c_lflag &= ~ICANON;
-		sys_ioctl(fd, TCSETSF, (long)&termios);
-		read(fd, &c, 1);
-		termios.c_lflag |= ICANON;
-		sys_ioctl(fd, TCSETSF, (long)&termios);
-		close(fd);
-	}
-}
-#endif
-
-#ifdef CONFIG_BLK_DEV_RAM
-
-int __initdata rd_prompt = 1;	/* 1 = prompt for RAM disk, 0 = don't prompt */
-
-static int __init prompt_ramdisk(char *str)
-{
-	rd_prompt = simple_strtol(str,NULL,0) & 1;
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
-int __initdata rd_image_start;		/* starting block # of image */
-
-static int __init ramdisk_start_setup(char *str)
-{
-	rd_image_start = simple_strtol(str,NULL,0);
-	return 1;
-}
-__setup("ramdisk_start=", ramdisk_start_setup);
-
-static int __init crd_load(int in_fd, int out_fd);
-
-/*
- * This routine tries to find a RAM disk image to load, and returns the
- * number of blocks to read for a non-compressed image, 0 if the image
- * is a compressed image, and -1 if an image with the right magic
- * numbers could not be found.
- *
- * We currently check for the following magic numbers:
- * 	minix
- * 	ext2
- *	romfs
- * 	gzip
- */
-static int __init 
-identify_ramdisk_image(int fd, int start_block)
-{
-	const int size = 512;
-	struct minix_super_block *minixsb;
-	struct ext2_super_block *ext2sb;
-	struct romfs_super_block *romfsb;
-	int nblocks = -1;
-	unsigned char *buf;
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (buf == 0)
-		return -1;
-
-	minixsb = (struct minix_super_block *) buf;
-	ext2sb = (struct ext2_super_block *) buf;
-	romfsb = (struct romfs_super_block *) buf;
-	memset(buf, 0xe5, size);
-
-	/*
-	 * Read block 0 to test for gzipped kernel
-	 */
-	lseek(fd, start_block * BLOCK_SIZE, 0);
-	read(fd, buf, size);
-
-	/*
-	 * If it matches the gzip magic numbers, return -1
-	 */
-	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Compressed image found at block %d\n",
-		       start_block);
-		nblocks = 0;
-		goto done;
-	}
-
-	/* romfs is at block zero too */
-	if (romfsb->word0 == ROMSB_WORD0 &&
-	    romfsb->word1 == ROMSB_WORD1) {
-		printk(KERN_NOTICE
-		       "RAMDISK: romfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/*
-	 * Read block 1 to test for minix and ext2 superblock
-	 */
-	lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
-	read(fd, buf, size);
-
-	/* Try minix */
-	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
-	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
-		       start_block);
-		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
-		goto done;
-	}
-
-	/* Try ext2 */
-	if (ext2sb->s_magic == cpu_to_le16(EXT2_SUPER_MAGIC)) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
-		nblocks = le32_to_cpu(ext2sb->s_blocks_count);
-		goto done;
-	}
-
-	printk(KERN_NOTICE
-	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
-	       start_block);
-	
-done:
-	lseek(fd, start_block * BLOCK_SIZE, 0);
-	kfree(buf);
-	return nblocks;
-}
-#endif
-
-static int __init rd_load_image(char *from)
-{
-	int res = 0;
-
-#ifdef CONFIG_BLK_DEV_RAM
-	int in_fd, out_fd;
-	int nblocks, rd_blocks, devblocks, i;
-	char *buf;
-	unsigned short rotate = 0;
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
-	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
-
-	out_fd = open("/dev/ram", O_RDWR, 0);
-	if (out_fd < 0)
-		goto out;
-
-	in_fd = open(from, O_RDONLY, 0);
-	if (in_fd < 0)
-		goto noclose_input;
-
-	nblocks = identify_ramdisk_image(in_fd, rd_image_start);
-	if (nblocks < 0)
-		goto done;
-
-	if (nblocks == 0) {
-#ifdef BUILD_CRAMDISK
-		if (crd_load(in_fd, out_fd) == 0)
-			goto successful_load;
+#ifdef CONFIG_BLK_DEV_INITRD 
+static int __init initrd_mount(void);	// in initrd.c
 #else
-		printk(KERN_NOTICE
-		       "RAMDISK: Kernel does not support compressed "
-		       "RAM disk images\n");
+static int __init initrd_mount(void) { return 0;}
 #endif
-		goto done;
-	}
-
-	/*
-	 * NOTE NOTE: nblocks suppose that the blocksize is BLOCK_SIZE, so
-	 * rd_load_image will work only with filesystem BLOCK_SIZE wide!
-	 * So make sure to use 1k blocksize while generating ext2fs
-	 * ramdisk-images.
-	 */
-	if (sys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
-		rd_blocks = 0;
-	else
-		rd_blocks >>= 1;
-
-	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%d/%d blocks)\n",
-		       nblocks, rd_blocks);
-		goto done;
-	}
-		
-	/*
-	 * OK, time to copy in the data
-	 */
-	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
-	if (buf == 0) {
-		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
-		goto done;
-	}
-
-	if (sys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
-		devblocks = 0;
-	else
-		devblocks >>= 1;
-
-	if (strcmp(from, "/dev/initrd") == 0)
-		devblocks = nblocks;
-
-	if (devblocks == 0) {
-		printk(KERN_ERR "RAMDISK: could not determine device size\n");
-		goto done;
-	}
-
-	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%d disk%s] into ram disk... ", 
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
-	for (i=0; i < nblocks; i++) {
-		if (i && (i % devblocks == 0)) {
-			printk("done disk #%d.\n", i/devblocks);
-			rotate = 0;
-			if (close(in_fd)) {
-				printk("Error closing the disk.\n");
-				goto noclose_input;
-			}
-			change_floppy("disk #%d", i/devblocks+1);
-			in_fd = open(from, O_RDONLY, 0);
-			if (in_fd < 0)  {
-				printk("Error opening disk.\n");
-				goto noclose_input;
-			}
-			printk("Loading disk #%d... ", i/devblocks+1);
-		}
-		read(in_fd, buf, BLOCK_SIZE);
-		write(out_fd, buf, BLOCK_SIZE);
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
-		if (!(i % 16)) {
-			printk("%c\b", rotator[rotate & 0x3]);
-			rotate++;
-		}
-#endif
-	}
-	printk("done.\n");
-	kfree(buf);
-
-successful_load:
-	res = 1;
-done:
-	close(in_fd);
-noclose_input:
-	close(out_fd);
-out:
-	sys_unlink("/dev/ram");
-#endif
-	return res;
-}
-
-static int __init rd_load_disk(int n)
-{
-#ifdef CONFIG_BLK_DEV_RAM
-	if (rd_prompt)
-		change_floppy("root floppy disk to be loaded into RAM disk");
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n), NULL);
-#endif
-	return rd_load_image("/dev/root");
-}
 
 static void __init mount_root(void)
 {
-#ifdef CONFIG_ROOT_NFS
-	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
-		if (mount_nfs_root()) {
-			sys_chdir("/root");
-			ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
-			printk("VFS: Mounted root (nfs filesystem).\n");
-			return;
-		}
-		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
-		ROOT_DEV = Root_FD0;
-	}
-#endif
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
-#ifdef CONFIG_BLK_DEV_FD
-	if (MAJOR(ROOT_DEV) == FLOPPY_MAJOR) {
-		/* rd_doload is 2 for a dual initrd/ramload setup */
-		if (rd_doload==2) {
-			if (rd_load_disk(1)) {
-				ROOT_DEV = Root_RAM1;
-				create_dev("/dev/root", ROOT_DEV, NULL);
-			}
-		} else
-			change_floppy("root floppy");
-	}
-#endif
-	mount_block_root("/dev/root", root_mountflags);
-}
-
-#ifdef CONFIG_BLK_DEV_INITRD
-static int old_fd, root_fd;
-static int do_linuxrc(void * shell)
-{
-	static char *argv[] = { "linuxrc", NULL, };
-	extern char * envp_init[];
-
-	close(old_fd);close(root_fd);
-	close(0);close(1);close(2);
-	setsid();
-	(void) open("/dev/console",O_RDWR,0);
-	(void) dup(0);
-	(void) dup(0);
-	return execve(shell, argv, envp_init);
-}
-
-#endif
-
-static void __init handle_initrd(void)
-{
-#ifdef CONFIG_BLK_DEV_INITRD
-	int error;
-	int i, pid;
-
-	create_dev("/dev/root.old", Root_RAM0, NULL);
-	/* mount initrd on rootfs' /root */
-	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
-	sys_mkdir("/old", 0700);
-	root_fd = open("/", 0, 0);
-	old_fd = open("/old", 0, 0);
-	/* move initrd over / and chdir/chroot in initrd root */
-	sys_chdir("/root");
-	sys_mount(".", "/", NULL, MS_MOVE, NULL);
-	sys_chroot(".");
-	mount_devfs_fs ();
 
-	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
-	if (pid > 0) {
-		while (pid != waitpid(-1, &i, 0))
-			yield();
-	}
-
-	/* move initrd to rootfs' /old */
-	sys_fchdir(old_fd);
-	sys_mount("/", ".", NULL, MS_MOVE, NULL);
-	/* switch root and cwd back to / of rootfs */
-	sys_fchdir(root_fd);
-	sys_chroot(".");
-	close(old_fd);
-	close(root_fd);
-	sys_umount("/old/dev", 0);
-
-	if (real_root_dev == Root_RAM0) {
-		sys_chdir("/old");
-		return;
-	}
-
-	ROOT_DEV = real_root_dev;
-	mount_root();
-
-	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = sys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
-	if (!error)
-		printk("okay\n");
-	else {
-		int fd = open("/dev/root.old", O_RDWR, 0);
-		printk("failed\n");
-		printk(KERN_NOTICE "Unmounting old root\n");
-		sys_umount("/old", MNT_DETACH);
-		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
-		if (fd < 0) {
-			error = fd;
-		} else {
-			error = sys_ioctl(fd, BLKFLSBUF, 0);
-			close(fd);
-		}
-		printk(!error ? "okay\n" : "failed\n");
-	}
-#endif
-}
-
-static int __init initrd_load(void)
-{
-#ifdef CONFIG_BLK_DEV_INITRD
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, 0), NULL);
-	create_dev("/dev/initrd", MKDEV(RAMDISK_MAJOR, INITRD_MINOR), NULL);
-#endif
-	return rd_load_image("/dev/initrd");
+	if (mount_nfs_root())	return;
+	
+	if (initrd_mount())	return;
+	
+	mount_block_root("/dev/root", root_mountflags);
 }
 
 /*
@@ -735,7 +391,6 @@
  */
 void prepare_namespace(void)
 {
-	int is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 	if (saved_root_name[0]) {
 		char *p = saved_root_name;
 		ROOT_DEV = name_to_dev_t(p);
@@ -743,11 +398,6 @@
 			p += 5;
 		strcpy(root_device_name, p);
 	}
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (!initrd_start)
-		mount_initrd = 0;
-	real_root_dev = ROOT_DEV;
-#endif
 	sys_mkdir("/dev", 0700);
 	sys_mkdir("/root", 0700);
 	sys_mknod("/dev/console", S_IFCHR|0600, MKDEV(TTYAUX_MAJOR, 1));
@@ -755,22 +405,14 @@
 	sys_mount("devfs", "/dev", "devfs", 0, NULL);
 	do_devfs = 1;
 #endif
-
 	create_dev("/dev/root", ROOT_DEV, NULL);
 
 	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
 	   log corrupting stuff */
 	software_resume();
 
-	if (mount_initrd) {
-		if (initrd_load() && ROOT_DEV != Root_RAM0) {
-			handle_initrd();
-			goto out;
-		}
-	} else if (is_floppy && rd_doload && rd_load_disk(0))
-		ROOT_DEV = Root_RAM0;
 	mount_root();
-out:
+
 	sys_umount("/dev", 0);
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
@@ -778,149 +420,6 @@
 	mount_devfs_fs ();
 }
 
-#if defined(BUILD_CRAMDISK) && defined(CONFIG_BLK_DEV_RAM)
-
-/*
- * gzip declarations
- */
-
-#define OF(args)  args
-
-#ifndef memzero
-#define memzero(s, n)     memset ((s), 0, (n))
+#ifdef CONFIG_BLK_DEV_INITRD 
+#include "initrd.c"
 #endif
-
-typedef unsigned char  uch;
-typedef unsigned short ush;
-typedef unsigned long  ulg;
-
-#define INBUFSIZ 4096
-#define WSIZE 0x8000    /* window size--must be a power of two, and */
-			/*  at least 32K for zip's deflate method */
-
-static uch *inbuf;
-static uch *window;
-
-static unsigned insize;  /* valid bytes in inbuf */
-static unsigned inptr;   /* index of next byte to be processed in inbuf */
-static unsigned outcnt;  /* bytes in output buffer */
-static int exit_code;
-static long bytes_out;
-static int crd_infd, crd_outfd;
-
-#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
-		
-/* Diagnostic functions (stubbed out) */
-#define Assert(cond,msg)
-#define Trace(x)
-#define Tracev(x)
-#define Tracevv(x)
-#define Tracec(c,x)
-#define Tracecv(c,x)
-
-#define STATIC static
-
-static int  fill_inbuf(void);
-static void flush_window(void);
-static void *malloc(int size);
-static void free(void *where);
-static void error(char *m);
-static void gzip_mark(void **);
-static void gzip_release(void **);
-
-#include "../lib/inflate.c"
-
-static void __init *malloc(int size)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
-static void __init free(void *where)
-{
-	kfree(where);
-}
-
-static void __init gzip_mark(void **ptr)
-{
-}
-
-static void __init gzip_release(void **ptr)
-{
-}
-
-
-/* ===========================================================================
- * Fill the input buffer. This is called only when the buffer is empty
- * and at least one byte is really needed.
- */
-static int __init fill_inbuf(void)
-{
-	if (exit_code) return -1;
-	
-	insize = read(crd_infd, inbuf, INBUFSIZ);
-	if (insize == 0) return -1;
-
-	inptr = 1;
-
-	return inbuf[0];
-}
-
-/* ===========================================================================
- * Write the output window window[0..outcnt-1] and update crc and bytes_out.
- * (Used for the decompressed data only.)
- */
-static void __init flush_window(void)
-{
-    ulg c = crc;         /* temporary variable */
-    unsigned n;
-    uch *in, ch;
-    
-    write(crd_outfd, window, outcnt);
-    in = window;
-    for (n = 0; n < outcnt; n++) {
-	    ch = *in++;
-	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
-    }
-    crc = c;
-    bytes_out += (ulg)outcnt;
-    outcnt = 0;
-}
-
-static void __init error(char *x)
-{
-	printk(KERN_ERR "%s", x);
-	exit_code = 1;
-}
-
-static int __init crd_load(int in_fd, int out_fd)
-{
-	int result;
-
-	insize = 0;		/* valid bytes in inbuf */
-	inptr = 0;		/* index of next byte to be processed in inbuf */
-	outcnt = 0;		/* bytes in output buffer */
-	exit_code = 0;
-	bytes_out = 0;
-	crc = (ulg)0xffffffffL; /* shift register contents */
-
-	crd_infd = in_fd;
-	crd_outfd = out_fd;
-	inbuf = kmalloc(INBUFSIZ, GFP_KERNEL);
-	if (inbuf == 0) {
-		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip buffer\n");
-		return -1;
-	}
-	window = kmalloc(WSIZE, GFP_KERNEL);
-	if (window == 0) {
-		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip window\n");
-		kfree(inbuf);
-		return -1;
-	}
-	makecrc();
-	result = gunzip();
-	kfree(inbuf);
-	kfree(window);
-	return result;
-}
-
-#endif  /* BUILD_CRAMDISK && CONFIG_BLK_DEV_RAM */
diff -uNr linux-2.5.45-virgin/init/initrd.c linux-2.5.45-initrd_dyn/init/initrd.c
--- linux-2.5.45-virgin/init/initrd.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.45-initrd_dyn/init/initrd.c	2002-11-01 04:17:08.000000000 -0500
@@ -0,0 +1,890 @@
+/*
+ * Copyright 2002 Dave Cinege <dcinege@psychosis.com>
+ * GPL2 - Copyright notice may not be altered.
+ * initrd rewrite and untar to tmpfs additions
+ *
+ */
+ 
+/* 
+DOCS:
+bootloader	initrd=root.img
+cmdline		root=/dev/ram0
+
+Load raw image to /dev/ram0. Mount /dev/ram0 as primary root.
+Try to execute /linuxrc. If /linuxrc changes the root device
+pivot to that device and remount /dev/ram0 to /initrd.
+(DOING THIS HAS DEPRECIATED! Set root= to the final root,
+that is unless you want /dev/ram0 as you final root device.)
+
+bootloader	initrd=root.img
+cmdline		root=/dev/hda1
+Load raw image to /dev/ram0. Mount /dev/ram0 as primary root.
+Try to execute /linuxrc. After excuting /linuxrc pivot to root= device
+and remount initrd to /initrd.
+
+cmdline		root=/dev/hda1 initrd_from_floppy=1
+Attempt to load raw image to /dev/ram0, from /dev/fd0.
+Mount /dev/ram0 as primary root. Try to execute /linuxrc.
+After excuting /linuxrc pivot to root= device and remount /dev/ram0
+to /initrd. If the bootloader has already loaded an initrd image
+it is deallocated.
+
+
+bootloader	initrd=root.tgz,etc.tgz,myhostconifg.tgz
+cmdline		root=/dev/tmpfs initrd_tmpfs_fssize=10MB
+Mount /dev/tmpfs as the primary root. If initrd_tmpfs_fssize= is
+specificed, the root will have a ceiling of that size.
+If initrd_tmpfs_fssize=0, their will be no ceiling limit.
+If initrd_tmpfs_fssize= is not specified, the root will have a
+ceiling equal to ramdisk_size.
+Extract tar.gz archives sequencially.to the root.
+Try to execute /linuxrc. If /linuxrc changes the root device
+pivot to that device and remount /dev/tmpfs to /initrd.
+(DOING THIS HAS DEPRECIATED! Set root= to the final root,
+that is unless you want /dev/tmpfs as your final root device.)
+
+NOTE: Your bootloader must support loading multiple files
+sequencially into the initrd memory space. If your boot loader
+is outdated you can create a multi-archive file like this:
+  cat root.tgz etc.tgz myhostconifg.tgz > root_tgzs.img
+And load this single file.
+
+
+bootloader	initrd=root.tar
+cmdline		root=/dev/hda1
+Mount /dev/tmpfs as the primary root. 
+Since initrd_tmpfs_fssize= is not specified, the root will have a
+ceiling equal to ramdisk_size.
+Extract tar archive to the root.
+Try to execute /linuxrc. After excuting /linuxrc pivot to root= device
+and remount initrd to /initrd.
+
+*/
+#include <linux/file.h>
+
+
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+static int __init gunzip_load(int in_fd, int out_fd, int size);
+#endif
+#ifdef CONFIG_BLK_DEV_INITRD_UNTAR
+static int __init initrd_untar(int in_fd);
+#endif
+
+extern asmlinkage long sys_access(const char * filename, int mode);
+
+unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
+
+static int __initdata mount_initrd = 1;
+static int __initdata initrd_from_floppy = 0;
+static unsigned long __initdata initrd_fssize = 0;
+#ifdef CONFIG_BLK_DEV_INITRD_UNTAR
+static int __initdata initrd_tmpfs_fssize_speced = 0;
+#endif
+
+
+enum image_type {
+	UNKNOWN		= 0,
+	GZIPPED		= 2<<0,	
+	TAR		= 2<<1,
+	IMAGE		= 2<<2,
+	ROMFS		= 2<<3,
+	EXT2		= 2<<4,
+	MINIX		= 2<<5
+};
+
+static int __init no_initrd(char *str)
+{
+	mount_initrd = 0;
+	return 1;
+}
+__setup("noinitrd", no_initrd);
+
+
+#ifdef CONFIG_BLK_DEV_FD
+static int __init prompt_ramdisk(char *str)
+{
+	rd_prompt = simple_strtol(str,NULL,0) & 1;
+	return 1;
+}
+__setup("prompt_ramdisk=", prompt_ramdisk);
+
+static int __init load_floppy(char *str)
+{
+	initrd_from_floppy = 1;
+	return 1;
+}
+__setup("initrd_from_floppy",load_floppy);
+
+static int __init ramdisk_start_setup(char *str)
+{
+	rd_image_start = simple_strtol(str,NULL,0);
+	return 1;
+}
+__setup("ramdisk_start=", ramdisk_start_setup);
+
+static void __init change_floppy(char *fmt, ...)
+{
+	struct termios termios;
+	char buf[80];
+	char c;
+	int fd;
+	va_list args;
+	va_start(args, fmt);
+	vsprintf(buf, fmt, args);
+	va_end(args);
+	fd = open("/dev/fd0", O_RDWR | O_NDELAY, 0);
+	if (fd >= 0) {
+		sys_ioctl(fd, FDEJECT, 0);
+		close(fd);
+	}
+	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
+	fd = open("/dev/console", O_RDWR, 0);
+	if (fd >= 0) {
+		sys_ioctl(fd, TCGETS, (long)&termios);
+		termios.c_lflag &= ~ICANON;
+		sys_ioctl(fd, TCSETSF, (long)&termios);
+		read(fd, &c, 1);
+		termios.c_lflag |= ICANON;
+		sys_ioctl(fd, TCSETSF, (long)&termios);
+		close(fd);
+	}
+}
+#endif
+
+// dc: FIX ME updates these comments
+/*
+ * This routine tries to find a RAM disk image to load, and returns the
+ * number of blocks to read for a non-compressed image, 0 if the image
+ * is a compressed image, and -1 if an image with the right magic
+ * numbers could not be found.
+ *
+ * We currently check for the following magic numbers:
+ *	tar
+ * 	minix
+ * 	ext2
+ *	romfs
+ * 	gzip
+ */
+static int __init initrd_identify(int in_fd, int start_block, int *nblocks)
+{
+	const int size = 512;
+	struct minix_super_block *minixsb;
+	struct ext2_super_block *ext2sb;
+	struct romfs_super_block *romfsb;
+
+	unsigned char *buf;
+	int fd, buf_fd = -1;
+	int initrd_type = 0;
+	
+	*nblocks = -1;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == 0)
+		return -1;
+	memset(buf, 0xe5, size);
+
+	/*
+	 * Read block 0 to test for gzipped kernel
+	 */
+	fd = in_fd;
+	lseek(fd, start_block * BLOCK_SIZE, 0);
+	read(fd, buf, size);
+
+	/*
+	 * If it matches the gzip magic, gunzip some bytes to compare
+	 */
+	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
+		*nblocks = 0;
+		initrd_type = GZIPPED;
+#ifndef CONFIG_BLK_DEV_INITRD_GUNZIP
+		goto done;
+#else
+		memset(buf, 0xe5, size);
+		lseek(in_fd, start_block * BLOCK_SIZE, 0);
+
+		create_dev("/dev/ram1", MKDEV(RAMDISK_MAJOR, 1), NULL);
+		buf_fd = open("/dev/ram1", O_RDWR, 0);
+		if (buf_fd < 0)
+			goto done;
+		gunzip_load(in_fd, buf_fd, ((start_block+1) * BLOCK_SIZE) + size);
+		lseek(buf_fd, 0, 0);
+		read(buf_fd, buf, size);
+		fd = buf_fd;
+#endif
+	}
+
+	/* tar archive */	
+	if (strncmp(&buf[257],"ustar",5) == 0) {
+		*nblocks = 0;
+		initrd_type |= TAR;
+		goto done;
+	}
+
+	romfsb = (struct romfs_super_block *) buf;
+	minixsb = (struct minix_super_block *) buf;
+	ext2sb = (struct ext2_super_block *) buf;
+
+	/* romfs is at block zero too */
+	if (romfsb->word0 == ROMSB_WORD0 &&
+	    romfsb->word1 == ROMSB_WORD1) {
+		*nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
+		initrd_type |=  IMAGE | ROMFS;
+		goto done;
+	}
+
+	/*
+	 * Read block 1 to test for minix and ext2 superblock
+	 */
+	lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
+	read(fd, buf, size);
+
+	/* Try minix */
+	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
+	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
+		*nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
+		initrd_type |=  IMAGE | MINIX;
+		goto done;
+	}
+
+	/* Try ext2 */
+	if (ext2sb->s_magic == cpu_to_le16(EXT2_SUPER_MAGIC)) {
+		*nblocks = le32_to_cpu(ext2sb->s_blocks_count);
+		initrd_type |=  IMAGE | EXT2;
+		goto done;
+	}
+
+	/* It's.....Unknown! */
+	initrd_type = UNKNOWN;
+
+done:
+	lseek(fd, start_block * BLOCK_SIZE, 0);
+	kfree(buf);
+
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+	if (buf_fd > -1) {
+		close(buf_fd);
+		sys_unlink("/dev/ram1");
+	}
+#endif
+	
+	return initrd_type;
+}
+
+
+static int __init rd_load_image(int fd, int nblocks)
+{
+	int res = 0;
+
+	int in_fd, out_fd;
+	int rd_blocks, devblocks, i;
+	char *buf;
+	unsigned short rotate = 0;
+#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+	char rotator[4] = { '|' , '/' , '-' , '\\' };
+#endif
+	in_fd = fd;
+
+	out_fd = open("/dev/ram0", O_RDWR, 0);
+	if (out_fd < 0)
+		goto out;
+		
+	if (nblocks < 0)
+		goto done;
+		
+	if (nblocks == 0) {
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+		if (gunzip_load(in_fd, out_fd, 0) == 0)
+			goto successful_load;
+#endif
+		goto done;
+	}
+
+	/*
+	 * NOTE NOTE: nblocks suppose that the blocksize is BLOCK_SIZE, so
+	 * rd_load_image will work only with filesystem BLOCK_SIZE wide!
+	 * So make sure to use 1k blocksize while generating ext2fs
+	 * ramdisk-images.
+	 */
+	if (sys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
+		rd_blocks = 0;
+	else
+		rd_blocks >>= 1;
+
+	if (nblocks > rd_blocks) {
+		printk("INITRD: image too big! (%d/%d blocks)\n",
+		       nblocks, rd_blocks);
+		goto done;
+	}
+		
+	/*
+	 * OK, time to copy in the data
+	 */
+	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
+	if (buf == 0) {
+		printk(KERN_ERR "INITRD: could not allocate buffer\n");
+		goto done;
+	}
+
+	if (sys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
+		devblocks = 0;
+	else
+		devblocks >>= 1;
+
+	// dc: FIX ME
+	if (initrd_start) //if (strcmp(from, "/dev/initrd") == 0)
+		devblocks = nblocks;
+
+	if (devblocks == 0) {
+		printk(KERN_ERR "INITRD: could not determine device size\n");
+		goto done;
+	}
+
+	printk(KERN_NOTICE "INITRD: Loading %d blocks [%d disk%s] into ram disk... ", 
+		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
+	for (i=0; i < nblocks; i++) {
+		if (i && (i % devblocks == 0)) {
+			printk("done disk #%d.\n", i/devblocks);
+			rotate = 0;
+			if (close(in_fd)) {
+				printk("Error closing the disk.\n");
+				goto noclose_input;
+			}
+			change_floppy("disk #%d", i/devblocks+1);
+			in_fd = open("/dev/fd0", O_RDONLY, 0);
+			if (in_fd < 0)  {
+				printk("Error opening disk.\n");
+				goto noclose_input;
+			}
+			printk("Loading disk #%d... ", i/devblocks+1);
+		}
+		read(in_fd, buf, BLOCK_SIZE);
+		write(out_fd, buf, BLOCK_SIZE);
+#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+		if (!(i % 16)) {
+			printk("%c\b", rotator[rotate & 0x3]);
+			rotate++;
+		}
+#endif
+	}
+	printk("done.\n");
+	kfree(buf);
+
+successful_load:
+	res = 1;
+done:
+	close(in_fd);
+noclose_input:
+	close(out_fd);
+out:
+	return res;
+}
+
+
+static void __init initrd_free_memory(char *dev)
+{
+	int fd = open(dev, O_RDWR, 0);
+	if (fd >= 0) {
+		sys_ioctl(fd, BLKFLSBUF, 0);
+		close(fd);
+	}
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD_UNTAR
+static int __init initrd_tmpfs_setup(char *str)
+{
+	initrd_fssize = simple_strtoul(str,NULL,10);
+	initrd_tmpfs_fssize_speced = 1;
+	tmpfs_root_fssize = initrd_fssize;
+	return 1;
+}
+__setup("initrd_tmpfs_size=", initrd_tmpfs_setup);
+#endif
+
+static int initrd_fd, root_fd;
+static int do_linuxrc(void * shell)
+{
+	static char *argv[] = { "linuxrc", NULL, };
+	extern char * envp_init[];
+
+	close(initrd_fd);close(root_fd);
+	close(0);close(1);close(2);
+	setsid();
+	(void) open("/dev/console",O_RDWR,0);
+	(void) dup(0);
+	(void) dup(0);
+	return execve(shell, argv, envp_init);
+}
+
+/* Depreciated. Purge at will.*/
+static void __init initrd_pivot(void)
+{
+	int error;
+	int i, pid;
+
+	/* If there's no executable /linuxrc to change the ROOT_DEV, it can't pivot. */
+	if (ROOT_DEV == real_root_dev && !sys_access("./linuxrc",1))
+		return;
+
+	create_dev("/dev/root_initrd", ROOT_DEV, NULL);
+
+	/* make location to pivot to. */
+	sys_mkdir("/initrd", 0700);
+	root_fd = open("/", 0, 0);
+	initrd_fd = open("/initrd", 0, 0);
+		
+	/* move initrd over / and chdir/chroot in initrd root */
+	sys_chdir("/root");
+	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	sys_chroot(".");
+	mount_devfs_fs ();
+
+	printk(KERN_NOTICE "INITRD: Executing /linuxrc.\n");
+	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
+	if (pid > 0) {
+		while (pid != waitpid(-1, &i, 0))
+			yield();
+	}
+	printk(KERN_NOTICE "INITRD: Exiting /linuxrc.\n");
+
+	/* linuxrc changed the root. move initrd to rootfs' /initrd */
+	if (ROOT_DEV != real_root_dev) {
+		sys_fchdir(initrd_fd);
+		sys_mount("/", ".", NULL, MS_MOVE, NULL);
+	}
+	
+	/* switch root and cwd back to / of rootfs */
+	sys_fchdir(root_fd);
+	sys_chroot(".");
+	close(initrd_fd);
+	close(root_fd);
+
+	/* linuxrc did not change the root. Move it back. Can't pivot */
+	if (ROOT_DEV == real_root_dev) {
+		sys_umount("/root/dev", 0);
+		create_dev("/dev/root", ROOT_DEV, NULL);
+		sys_chdir("/root");
+		return;
+	}
+	
+	sys_umount("/initrd/dev", 0);
+	
+	ROOT_DEV = real_root_dev;
+	create_dev("/dev/root", ROOT_DEV, NULL);
+	// dc: FIX ME do this or make it safe to reenter mount_root()?
+	// linuxrc pivoting *IS* depreciated after all...
+	mount_block_root("/dev/root", root_mountflags);
+
+	printk(KERN_NOTICE "INITRD: Moving initrd root to /initrd...");
+	error = sys_mount("/initrd", "/root/initrd", NULL, MS_MOVE, NULL);
+	if (!error) {
+		printk("done.\n");
+	} else {
+		printk("failed!\n");
+		sys_umount("/initrd", MNT_DETACH);
+		initrd_free_memory("/dev/initrd");
+	}
+}
+
+static int __init initrd_open(void)
+{
+	create_dev("/dev/ram0", MKDEV(RAMDISK_MAJOR, 0), NULL);
+	create_dev("/dev/initrd", MKDEV(RAMDISK_MAJOR, INITRD_MINOR), NULL);
+
+#ifdef CONFIG_BLK_DEV_FD
+	/* Try loading initrd from floppy. Wipe initrd image if present in memory. */
+	if (initrd_from_floppy) {
+		initrd_free_memory("/dev/initrd");
+		create_dev("/dev/fd0", MKDEV(FLOPPY_MAJOR, 0), NULL);
+		if (rd_prompt)
+			change_floppy("root floppy disk to be loaded into RAM disk");
+		return open("/dev/fd0", O_RDONLY, 0);
+	}
+#endif
+	return open("/dev/initrd", O_RDONLY, 0);
+}
+
+
+static void __init initrd_print_type(int initrd_type, int nblocks)
+{
+	printk(KERN_NOTICE "INITRD: ");
+	if (initrd_type & GZIPPED)		printk("Compressed ");
+	
+	if (initrd_type & TAR)			printk("Tar archive found at block %d.\n",rd_image_start);
+		
+	if (initrd_type & ROMFS)		printk("RomFS");
+	if (initrd_type & EXT2)			printk("EXT2");
+	if (initrd_type & MINIX)		printk("Minix");
+
+	if (initrd_type & IMAGE)		printk(" filesystem found at block %d. %d blocks.\n",rd_image_start, nblocks);
+}
+
+static int __init initrd_mount(void)
+{
+	extern int rd_size;
+	int initrd_type, nblocks;
+	int in_fd;
+
+	/* There is no image in memory AND we shouldn't try to load one from floppy. */
+	if (initrd_start == 0 && initrd_from_floppy == 0)
+		return 0;
+
+	/* Don't mount_initrd (noinitrd option)*/		
+	if (mount_initrd == 0)
+		return 0;	
+
+	real_root_dev = ROOT_DEV;
+
+	/* Open initrd */
+	in_fd = initrd_open();
+	if (in_fd < 0) {
+		printk(KERN_NOTICE "INITRD: Could not open initrd. (This is an error if you loaded one...)\n");
+		return 0;
+	}
+	
+	initrd_type = initrd_identify(in_fd, rd_image_start, &nblocks);
+
+	if (initrd_type & UNKNOWN) {
+		printk(KERN_ERR "INITRD: Could not find a valid image or archive starting at %d!\n",rd_image_start);
+		return 0;
+	}
+#ifndef CONFIG_BLK_DEV_INITRD_GUNZIP
+	if (initrd_type & GZIPPED) {
+		printk(KERN_ERR "INITRD: Kernel does not support compressed images!\n");
+		return 0;
+	}
+#endif
+#ifndef CONFIG_BLK_DEV_INITRD_UNTAR
+	if (initrd_type & TAR) {
+		printk(KERN_ERR "INITRD: Kernel does not support Tar archives!\n");
+		return 0;
+	}
+#endif
+	if ((initrd_type & IMAGE) && (nblocks > rd_size)) {
+		printk(KERN_ERR "INITRD: Image will not fit on ramdisk! (%d vs. %d)\n",nblocks,rd_size);
+		return 0;
+	}
+	
+	initrd_print_type(initrd_type, nblocks);
+
+	/* Mount initrd on rootfs' /root, chdir there, and extract archive if it's tmpfs */
+	if (initrd_type & TAR) {
+#ifndef CONFIG_BLK_DEV_INITRD_UNTAR
+		mount_tmpfs_root("/dev/root");
+	}
+#else
+		if (initrd_tmpfs_fssize_speced == 0)
+			initrd_fssize = rd_size;
+		ROOT_DEV = Root_TMPFS;
+		create_dev("/dev/root", ROOT_DEV, NULL);
+		mount_tmpfs_root("/dev/root");
+		initrd_untar(in_fd);	// dc: FIX ME chroot first. Get rid of mount_tmpfs_root().
+		close(in_fd);
+	}
+#endif	
+	if (initrd_type & IMAGE) {
+		initrd_fssize = rd_size;
+		if(rd_load_image(in_fd, nblocks) == 0)
+			return 0;
+		ROOT_DEV = Root_RAM0;
+		create_dev("/dev/root", ROOT_DEV, NULL);
+		mount_block_root("/dev/root", root_mountflags & ~MS_RDONLY);
+	}
+	
+	/* Make failsafe /dev and /dev/console on initrd.*/
+	sys_mkdir("./dev", 0700);
+	sys_mknod("./dev/console", S_IFCHR|0600, MKDEV(TTYAUX_MAJOR, 1));
+
+	/* Depreciated. Purge at will.*/
+	initrd_pivot();
+	
+	return -1;
+}	
+
+
+#if defined(CONFIG_BLK_DEV_INITRD_GUNZIP) || defined(CONFIG_BLK_DEV_INITRD_UNTAR)
+
+/*
+ * gzip and untar declarations
+ */
+#define OF(args)  args
+
+#ifndef memzero
+#define memzero(s, n)     memset ((s), 0, (n))
+#endif
+
+typedef unsigned char  uch;
+typedef unsigned short ush;
+typedef unsigned long  ulg;
+
+#define INBUFSIZ 4096
+#define WSIZE 0x8000    /* window size--must be a power of two, and */
+			/*  at least 32K for zip's deflate method */
+
+static uch *inbuf;
+static unsigned insizeT;  /* valid bytes in inbuf */
+static unsigned insize;  /* valid bytes in inbuf */
+static unsigned inptr;   /* index of next byte to be processed in inbuf */
+static int exit_code;
+static long bytes_out;
+static long bytes_limit; /* if > 0,  write no more then X bytes to out_fd*/
+static int crd_infd;
+
+
+/* ===========================================================================
+ * Fill the input buffer. This is called only when the buffer is empty
+ * and at least one byte is really needed.
+ */
+static int __init fill_inbuf(void)
+{
+	if ((bytes_out >= bytes_limit) && (bytes_limit > 0))
+		exit_code = 1;
+	
+	insize = read(crd_infd, inbuf, INBUFSIZ);
+	if (insize == 0) return -1;
+
+	insizeT += insize;
+
+	inptr = 1;
+
+	return inbuf[0];
+}
+#endif	//CONFIG_BLK_DEV_INITRD_GUNZIP || CONFIG_BLK_DEV_INITRD_UNTAR
+
+
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+
+static uch *window;
+static unsigned outcnt;  /* bytes in output buffer */
+static int crd_outfd;
+
+#define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
+#define EXIT_CODE exit_code
+		
+/* Diagnostic functions (stubbed out) */
+#define Assert(cond,msg)
+#define Trace(x)
+#define Tracev(x)
+#define Tracevv(x)
+#define Tracec(c,x)
+#define Tracecv(c,x)
+
+#define STATIC static
+
+//static int  fill_inbuf(void);
+static void flush_window(void);
+static void *malloc(int size);
+static void free(void *where);
+static void error(char *m);
+static void gzip_mark(void **);
+static void gzip_release(void **);
+
+#include "../lib/inflate.c"
+
+static void __init *malloc(int size)
+{
+	return kmalloc(size, GFP_KERNEL);
+}
+
+static void __init free(void *where)
+{
+	kfree(where);
+}
+
+static void __init gzip_mark(void **ptr)
+{
+}
+
+static void __init gzip_release(void **ptr)
+{
+}
+
+
+/* ===========================================================================
+ * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * (Used for the decompressed data only.)
+ */
+static void __init flush_window(void)
+{
+	ulg c = crc;		 /* temporary variable */
+	unsigned n;
+	uch *in, ch;
+
+	if ((((bytes_out + (ulg)outcnt) > bytes_limit) && (bytes_limit > 0)))
+		outcnt = bytes_limit - bytes_out;	// dc: FIX ME? We get lazy here and ignore the crc
+
+	// dc: FIX ME? Check for return -1, IE out of space
+	write(crd_outfd, window, outcnt);
+
+	in = window;
+	for (n = 0; n < outcnt; n++) {
+		ch = *in++;
+		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
+	}
+	crc = c;
+	bytes_out += (ulg)outcnt;
+	outcnt = 0;
+}
+
+static void __init error(char *x)
+{
+	printk(KERN_ERR "%s", x);
+	exit_code = 1;
+}
+
+static int __init gunzip_load(int in_fd, int out_fd, int size)
+{
+	int result;
+
+	insize = 0;		/* valid bytes in inbuf */
+	inptr = 0;		/* index of next byte to be processed in inbuf */
+	outcnt = 0;		/* bytes in output buffer */
+	exit_code = 0;
+	bytes_out = 0;		
+	bytes_limit = size;     /* limit of bytes to write out. 0 == unlimited */
+
+	crd_infd = in_fd;
+	crd_outfd = out_fd;
+	inbuf = kmalloc(INBUFSIZ, GFP_KERNEL);
+	if (inbuf == 0) {
+		printk(KERN_ERR "INITRD: Couldn't allocate gzip buffer\n");
+		return -1;
+	}
+	window = kmalloc(WSIZE, GFP_KERNEL);
+	if (window == 0) {
+		printk(KERN_ERR "INITRD: Couldn't allocate gzip window\n");
+		kfree(inbuf);
+		return -1;
+	}
+	makecrc();
+	result = gunzip();
+	lseek(in_fd, -1 * (insize - inptr), 1);	// Place in_fd.fpos where gunzip ended, not window.
+	
+	kfree(inbuf);
+	kfree(window);
+	return result;
+}
+#endif	//CONFIG_BLK_DEV_INITRD_GUNZIP
+
+
+#ifdef CONFIG_BLK_DEV_INITRD_UNTAR
+
+#include "../lib/untar.c"
+
+static struct untar_context *untarPtr;
+
+static int __init untar_load(int in_fd, int size)
+{
+	int result = 0;
+
+	insize = 0;		/* valid bytes in inbuf */
+	exit_code = 0;
+	bytes_out = 0;		
+	bytes_limit = size;     /* limit of bytes to write out. 0 == unlimited */
+
+	crd_infd = in_fd;
+	inbuf = kmalloc(INBUFSIZ, GFP_KERNEL);
+	if (inbuf == 0) {
+		printk(KERN_ERR "INITRD: Couldn't allocate untar buffer\n");
+		return -1;
+	}
+	while (fill_inbuf() >= 0) {
+		int count;
+		count = untar_write(untarPtr, inbuf, insize);
+		bytes_out += insize;
+		if (count > 0) {	// End of archive
+			count -= TARBLOCKSIZE;
+			lseek(in_fd, -1 * count, 1);
+			bytes_out -= count;
+			break;
+		} else if (count < 0) {
+			printk(KERN_ERR "INITRD: corrupt tar archive!\n");
+			result = -1;
+		}
+	}
+	kfree(inbuf);
+	return result;
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+// 'wrapper' so we can access untar_write() like a file descriptor
+static ssize_t __init untar_write_fd(struct file *fp, const char *buf, size_t count, loff_t *fpos)
+{
+	return untar_write(untarPtr, (char*)buf, count);
+}
+#endif
+
+static int __init initrd_untar(int in_fd)
+{
+	int err, i;
+	int type; // 0 unknown, 1 gzip(tar), 2 tar
+	const int size = 512;
+	unsigned char *buf;
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP	
+	int untar_fd;
+	struct file *untar_filp;
+#endif
+	untarPtr = kmalloc(sizeof(struct untar_context), GFP_KERNEL);
+	if (untarPtr == 0) {
+		printk(KERN_ERR "INITRD: Couldn't allocate untar buffer\n");
+		return -1;
+	}
+
+	untar_init(untarPtr);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == 0)
+		return -1;
+	
+	lseek(in_fd, rd_image_start * BLOCK_SIZE, 0); // Sanity
+
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP
+	// Open a 'dummy' fd and filp. Replace f_op.write with untar_write_fd()
+	// It's a bit tidier then deficating in flush_window() with a global var
+	untar_fd = open("/dev/null", O_RDWR, 0);	// Opening against '/dev/null' should be safe, no?
+	untar_filp = fget(untar_fd);
+	untar_filp->f_op->write = untar_write_fd;
+	fput(untar_filp);
+#endif
+	// Now uncompress and/or untar the initrd.tgz/tar archives(s)
+        // Continue for as long as we find magic, for multiple archives.
+	for(i = 0;;i++) {
+		memset(buf, 0xe5, size);
+		read(in_fd, buf, size);
+		lseek(in_fd, -1 * size, 1);	
+		
+		// dc: FIX ME? Call initrd_identify() here in the loop? Overkill?
+		
+		type = 0;
+		if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236)))
+			type = 1;	// gzip
+		if (strncmp(&buf[257],"ustar",5) == 0)
+			type = 2;	// tar
+		if (type == 0)
+			break;		// unknown/EOF
+		
+		if (type == 1) {
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP		
+			printk(KERN_NOTICE "INITRD: Extracting TGZ archive[%d]: ",i);
+			err = gunzip_load(in_fd,untar_fd,0);
+			if(err == 0)
+				printk("done. [%lu bytes]\n", bytes_out);
+#else
+			printk(KERN_ERR "INITRD: Kernel does not support compressed Tar archives.\n");
+			return 0;
+#endif		       
+		}  else {
+			printk(KERN_NOTICE "INITRD: Extracting Tar archive[%d]: ",i);
+			err = untar_load(in_fd,0);
+			if(err == 0)
+				printk("done. [%lu bytes]\n", bytes_out);
+			
+		}
+	}
+#ifdef CONFIG_BLK_DEV_INITRD_GUNZIP	
+	close(untar_fd);
+#endif
+	kfree(untarPtr);
+	kfree(buf);
+	return 0;
+}
+#endif	//CONFIG_BLK_DEV_INITRD_UNTAR
diff -uNr linux-2.5.45-virgin/lib/inflate.c linux-2.5.45-initrd_dyn/lib/inflate.c
--- linux-2.5.45-virgin/lib/inflate.c	2002-10-19 00:01:53.000000000 -0400
+++ linux-2.5.45-initrd_dyn/lib/inflate.c	2002-11-01 02:48:50.000000000 -0500
@@ -161,6 +161,10 @@
 #define wp outcnt
 #define flush_output(w) (wp=(w),flush_window())
 
+#ifndef EXIT_CODE
+#define EXIT_CODE 0
+#endif
+
 /* Tables for deflate from PKZIP's appnote.txt. */
 static const unsigned border[] = {    /* Order of the bit length code lengths */
         16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
@@ -980,7 +984,7 @@
     gzip_release(&ptr);
     if (hufts > h)
       h = hufts;
-  } while (!e);
+  } while (!e && !EXIT_CODE);
 
   /* Undo too much lookahead. The next read will be byte aligned so we
    * can discard unused bits in the last meaningful byte.
@@ -1146,7 +1150,10 @@
 	    }
 	    return -1;
     }
-	    
+    
+    if (EXIT_CODE)
+        return 0;
+	
     /* Get the crc and original length */
     /* crc32  (see algorithm.doc)
      * uncompressed input size modulo 2^32
diff -uNr linux-2.5.45-virgin/lib/untar.c linux-2.5.45-initrd_dyn/lib/untar.c
--- linux-2.5.45-virgin/lib/untar.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.45-initrd_dyn/lib/untar.c	2002-11-01 04:21:34.000000000 -0500
@@ -0,0 +1,306 @@
+/*
+ * untar.c
+ * 
+ * Copyright 1998-2002 Dave Cinege <dcinege@psychosis.com>
+ * GPL2 - Copyright notice may not be altered.
+ * 
+ * This is the untar portition of the original Initird Dynamic feature
+ *	 Some original portions by Dimitri Maziuk (very first untar.c)
+ *	 and Robert Kaiser (gunzip buffer)
+ * 
+ * This version of untar is very limited. It expects a fairly good archive, 
+ * as well as expansion to a clean root.
+ * It does not:
+ * 
+ * 	Look for a leading '/'
+ * 	Check before making links
+ * 	Look at the header checksum
+ * 	Check or create any leading directory structure
+ * 
+ * 1998-01-10
+ * First version of Initrd Archive. Extract tar.gz's to a dynamically
+ * created minix FS on /dev/ram0.
+ * 
+ * 2000-05-27
+ * Major code reorganization and rename to Initrd Dynamic.
+ * Unified for 2.0/2.2/2.4 kernels versions up to 2.4.18
+ *
+ * 2001-01-27
+ * Support extracting mutiple tgz's.
+ *
+ * 2001-08-18
+ * Added support for using tmpfs on 2.4 kernels.
+ *
+ * 2002-10-27
+ * Final kernel merge for adoption into 2.4.20/2.5.45.
+ * Initrd routines rewritten. Support for both un/compressed tar archives.
+ * Seemless operation with archive magic testing. Purged minix support.
+ * Many untar enhancments.
+ *
+ */
+
+#include <linux/unistd.h>
+#include <linux/stat.h>
+#include <linux/fcntl.h>
+#include <linux/stddef.h>  
+#include <linux/utime.h>
+
+//#define DEBUG_UNTAR
+
+// These must be already present:
+
+//extern sys_mknod();
+//extern sys_mkdir();
+//extern sys_chdir();
+//extern sys_symlink();
+//extern sys_access();
+
+extern asmlinkage long sys_write(unsigned int fd, const char * buf,unsigned int count);
+extern asmlinkage long sys_chmod(const char * filename, mode_t mode);
+extern asmlinkage long sys_chown(const char * filename, uid_t user, gid_t group);
+extern asmlinkage long sys_lchown(const char * filename, uid_t user, gid_t group);
+extern asmlinkage long sys_link(const char * oldname, const char * newname);
+extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
+extern asmlinkage long sys_time(int * tloc);
+
+#define	TARBLOCKSIZE	512
+
+#define NAME_FIELD_SIZE   100
+#define PREFIX_FIELD_SIZE 155
+#define UNAME_FIELD_SIZE   32
+#define GNAME_FIELD_SIZE   32
+
+#define TMAGIC   "ustar"	// 6 chars and a null
+#define TMAGLEN  6
+#define TVERSION " \0"		// 00 and no null
+#define TVERSLEN 2
+
+	/* POSIX Tar header */
+struct TarFileHeader {		// byte offset
+	char name[NAME_FIELD_SIZE];	//   0
+	char mode[8];			// 100
+	char uid[8];			// 108
+	char gid[8];			// 116
+	char size[12];			// 124
+	char mtime[12];			// 136
+	char chksum[8];			// 148
+	char typeflag;			// 156
+	char linkname[NAME_FIELD_SIZE];	// 157
+	char magic[TMAGLEN];		// 257
+	char version[TVERSLEN];		// 263
+	char uname[UNAME_FIELD_SIZE];	// 265
+	char gname[GNAME_FIELD_SIZE];	// 297
+	char devmajor[8];		// 329
+	char devminor[8];		// 337
+	char prefix[PREFIX_FIELD_SIZE];	// 345
+};
+
+enum untar_type {
+	AREGTYPE = 0,		// regular file
+	REGTYPE	 = '0',		// regular file
+	LNKTYPE  = '1',		// link
+	SYMTYPE  = '2',		// reserved
+	CHRTYPE  = '3',		// character special
+	BLKTYPE  = '4',		// block special
+	DIRTYPE  = '5',		// directory
+	FIFOTYPE = '6',		// FIFO special
+	CONTTYPE = '7'		// reserved
+};
+
+enum untar_status {
+	READING_HEADER,
+	READING_DATA,
+	SKIPPING_REST
+};
+
+typedef union TarInfo {
+	char buf[TARBLOCKSIZE];
+	struct TarFileHeader header;
+} TarInfo;
+
+struct untar_context {
+	enum untar_status	state;
+	unsigned long		fsize_remaining;
+	int			out_fd;
+	int			rotate;
+	TarInfo			tarInfo;	
+} *Untar;
+
+
+/*
+ * simple_strtoul() does not strip leading spaces (0x20) from the input
+ * string. The 'real' strtoul does. This wrapper works around this.
+ * NOTE: This really should be fixed in: lib/vsprintf.c 
+ *
+ */
+#define strtoul simple_strtoul_wrapper
+static unsigned long  __init  simple_strtoul_wrapper( const char *cp, char **endp, unsigned int base)
+{
+	while (*cp == ' ')
+		cp++;
+	return ( simple_strtoul(cp,endp,base) );
+}
+
+/* 
+ * Initialize/Reset the context structure.
+ * The external parent is responcible for definition and kmalloc of *Untar
+ *
+ */
+static void  __init untar_init(struct untar_context *Untar)
+{
+	memset(Untar,0,sizeof(struct untar_context));
+	Untar->state  = READING_HEADER;
+	Untar->rotate = 0;
+}
+
+#define Type	Untar->tarInfo.header.typeflag
+#define Name	Untar->tarInfo.header.name
+#define LName	Untar->tarInfo.header.linkname
+#define Mode	strtoul(Untar->tarInfo.header.mode,NULL,8)
+#define Uid	strtoul(Untar->tarInfo.header.uid,NULL,8)
+#define Gid	strtoul(Untar->tarInfo.header.gid,NULL,8)
+#define Size	strtoul(Untar->tarInfo.header.size,NULL,8)
+#define Dev	MKDEV(strtoul(Untar->tarInfo.header.devmajor,NULL,8),strtoul(Untar->tarInfo.header.devminor,NULL,8))
+#define Magic	Untar->tarInfo.header.magic
+
+static int __init untar_setmodes(struct untar_context *Untar)
+{
+	int err;
+	struct	utimbuf ut;
+
+	if(Type == LNKTYPE || Type == SYMTYPE)
+		return sys_lchown(Name, Uid, Gid);	
+	
+	err = sys_chown(Name, Uid, Gid);
+	err |= sys_chmod(Name, Mode);
+	
+	ut.actime=sys_time(NULL);
+	ut.modtime=strtoul(Untar->tarInfo.header.mtime,NULL,8);
+	err |= sys_utime(Untar->tarInfo.header.name,&ut);
+
+	return err;
+}
+
+static int __init untar_create(struct untar_context *Untar)
+{
+	int err = 0;
+	switch(Type) {
+		case AREGTYPE : case REGTYPE  :
+			Untar->out_fd = sys_open(Name,O_CREAT|O_WRONLY|O_TRUNC,Mode);
+			if(Untar->out_fd == -1) {
+				err = 1;
+				break;
+			}
+			Untar->state = READING_DATA;
+			Untar->fsize_remaining = Size;
+			break;
+		case LNKTYPE  :
+			err = sys_link(LName, Name);
+			break;
+		case SYMTYPE  :
+			err = sys_symlink(LName, Name);
+			break;
+		case CHRTYPE  :	case BLKTYPE  :	case FIFOTYPE :	
+			err = sys_mknod(Name,Mode,Dev);
+   	    		break;
+		case DIRTYPE  :
+			if((Name[0] != '.' && Name[0] != 0) &&	// Skip if dirname is "" "./" "." ".."
+			   (Name[1] != '/' && Name[1] != 0) &&	// Yes, Gnu tar can do stupid shit like this.
+			   (Name[1] != 0)) {
+			   	err = sys_mkdir(Name,Mode);
+			}
+			break;
+		default:	//  corrupt tar archive
+			Untar->state = SKIPPING_REST;
+			return -1;
+	}
+	if (err == 0)
+		return untar_setmodes(Untar);
+	
+	return err;
+}
+
+/*
+ * untar_write() can be re-entered as needed by the external parent function.
+ * We keep status of the current state and Tar header in our context
+ * structure, and return when we need more data to continue with extraction
+ * The parent is responcible for preparing root, chdir(), and chroot().
+ *
+ */
+static ssize_t __init untar_write(struct untar_context *Untar, char *buf, size_t count)
+{
+	int	i, scoop, err;
+	char	*to;
+#ifndef DEBUG_UNTAR
+#ifndef CONFIG_ARCH_S390
+	char rotator[4] = { '|' , '/' , '-' , '\\' };
+
+	printk("%c\b", rotator[Untar->rotate & 0x3]);
+	Untar->rotate++;
+#endif
+#endif
+	while (count) {	
+		err = 0;	
+		switch (Untar->state) {
+			case READING_HEADER:
+				if (count < TARBLOCKSIZE) {
+					count = 0;
+					break;
+				}
+				to = (char*)&Untar->tarInfo;
+				for (i = 0; i < TARBLOCKSIZE; i++) {
+					*to++ = *buf++;
+					--count;
+				}
+				// Tar usually pads the output byte to a multiple of it's block size,
+				// appending zeroes if necessary. Here we skip those zeroes:
+				if (Name[0] == 0 && Magic[0] == 0) {
+					if(count < TARBLOCKSIZE)
+						count = 0;
+					break;
+				}				
+				// Check magic to see if it's a valid header.
+				// If not assume overrun of EOF, and return 'count' that was valid.
+				// Parent can reset buf position with this offset.
+				if (strncmp(Magic,TMAGIC,sizeof(TMAGIC) != 0)) {
+					return count;
+				}
+
+				err = untar_create(Untar);
+	
+				break;
+			case READING_DATA:
+				scoop = 0;
+				while (count > 0 && Untar->fsize_remaining > 0) {
+					scoop = Untar->fsize_remaining > TARBLOCKSIZE ? TARBLOCKSIZE : Untar->fsize_remaining;
+					if(sys_write(Untar->out_fd, buf, scoop) < scoop)
+						err = 1;
+					count -= scoop;
+					buf   += scoop;
+					Untar->fsize_remaining -= scoop;
+				}
+				if (Untar->fsize_remaining == 0) {	//skip to the next tar block
+					sys_close(Untar->out_fd);
+					scoop = count % TARBLOCKSIZE;
+					buf   += scoop;
+					count -= scoop;
+					Untar->state = READING_HEADER;
+				}
+				break;
+
+			case SKIPPING_REST:
+				count = 0;
+				break;
+		}
+		if (err) {
+#ifndef DEBUG_UNTAR		
+			printk("!");
+#else
+			printk("\nerr=%d, Error making %s", err, Name);
+#endif
+		}
+
+	
+	}
+	return 0;
+}

--------------Boundary-00=_WD3Z8QAP9E8SYDKGGUP3--

