Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSEDS44>; Sat, 4 May 2002 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315169AbSEDS4z>; Sat, 4 May 2002 14:56:55 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:36232 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315168AbSEDS4x>; Sat, 4 May 2002 14:56:53 -0400
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs
Date: Sat, 4 May 2002 21:57:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: hpa@transmeta.com, viro@math.psu.edu
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7FRL7BBIOOPOA1OPA5R3"
Message-ID: <1744hw-0EYlYuC@fwd01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_7FRL7BBIOOPOA1OPA5R3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I have tried to implement the "initramfs buffer spec -- third draft" by hpa 
and Al Viro. 

It isn't complete yet, because off the following unresolved topics:
1. For the moment it only supports files,dirs and symlinks.
2. It still needs the "RAM disk" and "initrd" support compiled in the Kernel.
3. I haven't tried to support hardlinks.
4. Since i use the ramdisk for decompression the cpio image must be a 
multiple of BLOCK_SIZE bytes.
5. The cpio crc field is ignored.

I have done this only for testing if the "initramfs buffer spec -- third 
draft" suffers all requirements. And to give a starting point for 
implementing this. The patch works for linux 2.5.9 - 2.5.13.

The only problem i found is that after a "TRAILER!!!" cpio (per default) 
align on a 512 bytes boundary, not 4 bytes.

I also have an idea about the "mounting the real root over the ramfs root" 
thing, is it/could it be possible to mark an filesystem as "unmount on 
closing the last used file", similary to how autofs does it ?
This could also be usefull for removal media.
(don't blame me if this is stupid, i'm only a human).

cu, Christian Koenig. (and sorry for my poor English)



--------------Boundary-00=_7FRL7BBIOOPOA1OPA5R3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="initramfs.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="initramfs.patch"

diff -ubNr linux-2.5.9.orig/drivers/block/Config.in linux-2.5.9.new/drivers/block/Config.in
--- linux-2.5.9.orig/drivers/block/Config.in	Tue Apr 23 00:28:23 2002
+++ linux-2.5.9.new/drivers/block/Config.in	Sun Apr 28 14:47:37 2002
@@ -46,5 +46,6 @@
    int '  Default RAM disk size' CONFIG_BLK_DEV_RAM_SIZE 4096
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
+dep_bool '  Initial RAM fs (initramfs) support' CONFIG_BLK_DEV_INITRAMFS $CONFIG_BLK_DEV_INITRD

 endmenu
diff -ubNr linux-2.5.9.orig/include/linux/initramfs.h linux-2.5.9.new/include/linux/initramfs.h
--- linux-2.5.9.orig/include/linux/initramfs.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.9.new/include/linux/initramfs.h	Thu Apr 25 02:38:36 2002
@@ -0,0 +1,25 @@
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+struct cpio_header {
+	char c_magic[6];    //The string "070701" or "070702"
+	char c_ino[8];      //File inode number
+	char c_mode[8];     //File mode and permissions
+	char c_uid[8];      //File uid
+	char c_gid[8];      //File gid
+	char c_nlink[8];    //Number of links
+	char c_mtime[8];    //Modification time
+	char c_filesize[8]; //Size of data field
+	char c_maj[8];      //Major part of file device number
+	char c_min[8];      //Minor part of file device number
+	char c_rmaj[8];     //Major part of device node reference
+	char c_rmin[8];     //Minor part of device node reference
+	char c_namesize[8]; //Length of filename, including final \0
+	char c_chksum[8];   //Checksum of data field if c_magic is 070702;
+};
+
+#define CPIO_MAGIC	"070701"
+#define CPIO_MAGIC_CRC	"070702"
+#define CPIO_TRAILER	"TRAILER!!!"
+
+#endif
diff -ubNr linux-2.5.9.orig/init/do_mounts.c linux-2.5.9.new/init/do_mounts.c
--- linux-2.5.9.orig/init/do_mounts.c	Tue Apr 23 00:28:49 2002
+++ linux-2.5.9.new/init/do_mounts.c	Sat May  4 19:12:57 2002
@@ -17,6 +17,7 @@
 #include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
+#include <linux/initramfs.h>

 #define BUILD_CRAMDISK

@@ -34,6 +35,9 @@
 asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);

 #ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_BLK_DEV_INITRAMFS
+static off_t initramfs_size = 0;
+#endif
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;

@@ -414,6 +418,178 @@

 static int __init crd_load(int in_fd, int out_fd);

+#ifdef CONFIG_BLK_DEV_INITRAMFS
+
+static unsigned int __init ascii2int(const char *ascii)
+{
+	unsigned int res = 0;
+	int i;
+	for(i=0;i<8;i++) {
+		if(ascii[i] >= '0' && ascii[i] <= '9')
+			res += (ascii[i] - '0') << (4 * (7-i));
+		else if(ascii[i] >= 'a' && ascii[i] <= 'f')
+			res += (ascii[i] - 'a' + 10) << (4 * (7-i));
+		else if(ascii[i] >= 'A' && ascii[i] <= 'F')
+			res += (ascii[i] - 'A' + 10) << (4 * (7-i));
+		else {
+			printk("INITRAMFS: ASCII field in CPIO header contains illegar char!\n");
+			return res;
+		}
+	}
+	return res;
+}
+
+static unsigned int __init align_cpio(unsigned long pos)
+{
+	if (pos & 3)
+		return (pos & ~3) + 4;
+	return pos;
+}
+
+static int __init initramfs_magic(struct cpio_header *header)
+{
+	if (!strncmp(header->c_magic,CPIO_MAGIC,strlen(CPIO_MAGIC)))
+		return 1;
+	if (!strncmp(header->c_magic,CPIO_MAGIC,strlen(CPIO_MAGIC_CRC))) {
+		return 1;
+	}
+	return 0;
+}
+
+static int __init do_initramfs(void *name)
+{
+	int file_count = 0;
+	int in_fd;
+	off_t cur = 0;
+	char *buf;
+
+	in_fd = open(name, O_RDONLY, 0);
+	if (in_fd < 0) {
+		return 0;
+	}
+
+	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	sys_chdir("/root");
+	sys_chroot(".");
+
+	while(cur < initramfs_size) {
+		struct cpio_header header;
+		char *filename;
+		int out_fd;
+		long filesize;
+		long bytes_read;
+
+		cur = align_cpio(cur);
+		lseek(in_fd, cur, 0);
+		if(read(in_fd, (void *)&header, sizeof (struct cpio_header)) <= 0) {
+			printk(KERN_NOTICE "INITRAMFS: EOF reached aborting extraction!\n");
+			goto out;
+		}
+		cur += sizeof (struct cpio_header);
+
+		if (!initramfs_magic(&header)) {
+			printk(KERN_NOTICE "INITRAMFS: No valid CPIO header found aborting extraction!\n");
+			goto out;
+		}
+
+		filename = kmalloc(ascii2int(header.c_namesize), GFP_KERNEL);
+		filesize = ascii2int(header.c_filesize);
+
+		lseek(in_fd, cur, 0);
+		if(read(in_fd, filename, ascii2int(header.c_namesize)) <= 0) {
+			printk(KERN_NOTICE "INITRAMFS: EOF reached aborting extraction!\n");
+			goto out;
+		}
+		cur += ascii2int(header.c_namesize);
+
+
+		printk("INITRAMFS: FileName: %s Size:%ld\n",filename,filesize);
+		cur = align_cpio(cur);
+		lseek(in_fd, cur, 0);
+		cur += filesize;
+
+		switch (ascii2int(header.c_mode) & S_IFMT) {
+			case S_IFREG: {
+				out_fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, ascii2int(header.c_mode));
+				if (out_fd < 0) {
+					printk("INITRAMFS: Error opening out file %d\n",out_fd);
+					kfree(filename);
+					goto out;
+				}
+				while(filesize) {
+					bytes_read = read(in_fd, buf, (filesize < BLOCK_SIZE) ? filesize : BLOCK_SIZE);
+					if(bytes_read < 0) {
+						printk(KERN_NOTICE "INITRAMFS: EOF reached aborting extraction!\n");
+						kfree(filename);
+						goto out;
+					}
+					write(out_fd, buf, bytes_read);
+					filesize -= bytes_read;
+				}
+				close(out_fd);
+				break;
+			}
+			case S_IFDIR: {
+				sys_mkdir(filename, ascii2int(header.c_mode) & ~S_IFMT);
+				break;
+			}
+			case S_IFLNK: {
+				bytes_read = read(in_fd, buf, (filesize < BLOCK_SIZE) ? filesize : BLOCK_SIZE);
+				buf[bytes_read] = 0;
+				sys_symlink(buf,filename);
+				break;
+			}
+			case 0: {
+				if(strcmp(filename,CPIO_TRAILER) == 0)
+					while((read(in_fd, buf, 1) == 1) && (*buf == 0) && (cur < initramfs_size))
+						cur++;
+			}
+		}
+		kfree(filename);
+		file_count++;
+	}
+	kfree(buf);
+out:
+	close(in_fd);
+	return file_count;
+}
+
+static int __init initramfs_load_image(char *name)
+{
+	int pid,i,fd;
+	unsigned char *buf;
+
+	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
+	if (buf == 0)
+		return 0;
+
+	fd = open(name, O_RDONLY, 0);
+	if (fd < 0) {
+		kfree(buf);
+		return 0;
+	}
+	read(fd, buf, BLOCK_SIZE);
+	close(fd);
+
+	if (!initramfs_magic((struct cpio_header *)buf))
+		return 0;
+
+	printk("INITRAMFS: CPIO Image found starting extraction....\n");
+	sys_mount("ramfs", "/root", "ramfs", 0, NULL);
+
+	pid = kernel_thread(do_initramfs, name, SIGCHLD);
+	if (pid > 0) {
+		while (pid != wait(&i))
+			yield();
+	}
+	return i;
+}
+
+#endif
+
 /*
  * This routine tries to find a RAM disk image to load, and returns the
  * number of blocks to read for a non-compressed image, 0 if the image
@@ -472,6 +648,17 @@
 		goto done;
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRAMFS
+	/* check for cpio header */
+	if (initramfs_magic((struct cpio_header *)buf)) {
+		printk(KERN_NOTICE
+		       "RAMDISK: cpio header found at block %d\n",
+		       start_block);
+		nblocks = (initrd_end - initrd_start)>>BLOCK_SIZE_BITS;
+		goto done;
+	}
+#endif
+
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
@@ -615,6 +802,9 @@
 	kfree(buf);
 
 successful_load:
+#ifdef CONFIG_BLK_DEV_INITRAMFS
+	initramfs_size = lseek(out_fd, 0, 1);
+#endif
 	res = 1;
 done:
 	close(in_fd);
@@ -754,6 +944,7 @@
 	int i, pid;
 
 	create_dev("/dev/root.old", ram0, NULL);
+	if(!initramfs_load_image("/dev/root.old"))
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
 	sys_chdir("/old");

--------------Boundary-00=_7FRL7BBIOOPOA1OPA5R3--
