Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCMIK0>; Wed, 13 Mar 2002 03:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSCMIKU>; Wed, 13 Mar 2002 03:10:20 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:41391 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S289272AbSCMIKF>; Wed, 13 Mar 2002 03:10:05 -0500
From: Christoph Rohland <cr@sap.com>
To: davej@suse.de, Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] sync shmem.c in 2.5 to 2.4
Organisation: SAP LinuxLab
Date: Wed, 13 Mar 2002 09:09:42 +0100
Message-ID: <m3y9gwga7t.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Linus,

The appended patch brings the fixes applied in 2.4 to shmem.c to 2.5.

In Detail:
- Add needed checks for shmem_file_write and shmem_symlink
- Add Documentation/filesystems/tmpfs.txt and adjust Config.help
- Add uid and gid mount options
- Make the error messages more user friendly

Please apply
		Christoph


diff -uNr 2.5.5/Documentation/filesystems/tmpfs.txt c/Documentation/filesystems/tmpfs.txt
--- 2.5.5/Documentation/filesystems/tmpfs.txt	Thu Jan  1 01:00:00 1970
+++ c/Documentation/filesystems/tmpfs.txt	Mon Feb 25 09:26:15 2002
@@ -0,0 +1,102 @@
+Tmpfs is a file system which keeps all files in virtual memory.
+
+
+Everything in tmpfs is temporary in the sense that no files will be
+created on your hard drive. If you unmount a tmpfs instance,
+everything stored therein is lost.
+
+tmpfs puts everything into the kernel internal caches and grows and
+shrinks to accommodate the files it contains and is able to swap
+unneeded pages out to swap space. It has maximum size limits which can
+be adjusted on the fly via 'mount -o remount ...'
+
+If you compare it to ramfs (which was the template to create tmpfs)
+you gain swapping and limit checking. Another similar thing is the RAM
+disk (/dev/ram*), which simulates a fixed size hard disk in physical
+RAM, where you have to create an ordinary filesystem on top. Ramdisks
+cannot swap and you do not have the possibility to resize them. 
+
+Since tmpfs lives completely in the page cache and on swap, all tmpfs
+pages currently in memory will show up as cached. It will not show up
+as shared or something like that. Further on you can check the actual
+RAM+swap use of a tmpfs instance with df(1) and du(1).
+
+
+tmpfs has the following uses:
+
+1) There is always a kernel internal mount which you will not see at
+   all. This is used for shared anonymous mappings and SYSV shared
+   memory. 
+
+   This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
+   set, the user visible part of tmpfs is not build. But the internal
+   mechanisms are always present.
+
+2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
+   POSIX shared memory (shm_open, shm_unlink). Adding the following
+   line to /etc/fstab should take care of this:
+
+	tmpfs	/dev/shm	tmpfs	defaults	0 0
+
+   Remember to create the directory that you intend to mount tmpfs on
+   if necessary (/dev/shm is automagically created if you use devfs).
+
+   This mount is _not_ needed for SYSV shared memory. The internal
+   mount is used for that. (In the 2.3 kernel versions it was
+   necessary to mount the predecessor of tmpfs (shm fs) to use SYSV
+   shared memory)
+
+3) Some people (including me) find it very convenient to mount it
+   e.g. on /tmp and /var/tmp and have a big swap partition. But be
+   aware: loop mounts of tmpfs files do not work due to the internal
+   design. So mkinitrd shipped by most distributions will fail with a
+   tmpfs /tmp.
+
+4) And probably a lot more I do not know about :-)
+
+
+tmpfs has a couple of mount options:
+
+size:	   The limit of allocated bytes for this tmpfs instance. The 
+           default is half of your physical RAM without swap. If you
+	   oversize your tmpfs instances the machine will deadlock
+	   since the OOM handler will not be able to free that memory.
+nr_blocks: The same as size, but in blocks of PAGECACHE_SIZE.
+nr_inodes: The maximum number of inodes for this instance. The default
+           is half of the number of your physical RAM pages.
+
+These parameters accept a suffix k, m or g for kilo, mega and giga and
+can be changed on remount.
+
+To specify the initial root directory you can use the following mount
+options:
+
+mode:	The permissions as an octal number
+uid:	The user id 
+gid:	The group id
+
+These options do not have any effect on remount. You can change these
+parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
+
+
+So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
+will give you tmpfs instance on /mytmpfs which can allocate 10GB
+RAM/SWAP in 10240 inodes and it is only accessible by root.
+
+
+TODOs:
+
+1) give the size option a percent semantic: If you give a mount option
+   size=50% the tmpfs instance should be able to grow to 50 percent of
+   RAM + swap. So the instance should adapt automatically if you add
+   or remove swap space.
+2) loop mounts: This is difficult since loop.c relies on the readpage
+   operation. This operation gets a page from the caller to be filled
+   with the content of the file at that position. But tmpfs always has
+   the page and thus cannot copy the content to the given page. So it
+   cannot provide this operation. The VM had to be changed seriously
+   to achieve this.
+3) Show the number of tmpfs RAM pages. (As shared?)
+
+Author:
+   Christoph Rohland <cr@sap.com>, 1.12.01
diff -uNr 2.5.5/fs/Config.help c/fs/Config.help
--- 2.5.5/fs/Config.help	Mon Feb 18 17:58:01 2002
+++ c/fs/Config.help	Mon Feb 25 09:31:17 2002
@@ -211,30 +211,12 @@
 CONFIG_TMPFS
   Tmpfs is a file system which keeps all files in virtual memory.
 
-  In contrast to RAM disks, which get allocated a fixed amount of
-  physical RAM, tmpfs grows and shrinks to accommodate the files it
-  contains and is able to swap unneeded pages out to swap space.
-
-  Everything is "virtual" in the sense that no files will be created
-  on your hard drive; if you reboot, everything in tmpfs will be
+  Everything in tmpfs is temporary in the sense that no files will be
+  created on your hard drive. The files live in memory and swap
+  space. If you unmount a tmpfs instance, everything stored therein is
   lost.
 
-  You should mount the file system somewhere to be able to use
-  POSIX shared memory. Adding the following line to /etc/fstab should
-  take care of things:
-
-  tmpfs		/dev/shm	tmpfs		defaults	0 0
-
-  Remember to create the directory that you intend to mount tmpfs on
-  if necessary (/dev/shm is automagically created if you use devfs).
-
-  You can set limits for the number of blocks and inodes used by the
-  file system with the mount options "size", "nr_blocks" and
-  "nr_inodes". These parameters accept a suffix k, m or g for kilo,
-  mega and giga and can be changed on remount.
-
-  The initial permissions of the root directory can be set with the
-  mount option "mode".
+  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
 CONFIG_RAMFS
   Ramfs is a file system which keeps all files in RAM. It allows
diff -uNr 2.5.5/mm/shmem.c c/mm/shmem.c
--- 2.5.5/mm/shmem.c	Sat Feb 23 16:18:10 2002
+++ c/mm/shmem.c	Mon Feb 25 09:32:30 2002
@@ -758,6 +758,11 @@
 	long		status;
 	int		err;
 
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
 
 	down(&inode->i_sem);
 
@@ -1021,6 +1026,9 @@
 {
 	struct inode *inode = old_dentry->d_inode;
 
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
+
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);	/* New dentry reference */
@@ -1111,16 +1119,14 @@
 	char *kaddr;
 	struct shmem_inode_info * info;
 
+	len = strlen(symname) + 1;
+	if (len > PAGE_CACHE_SIZE)
+		return -ENAMETOOLONG;
+
 	inode = shmem_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
 	if (!inode)
 		return -ENOSPC;
 
-	len = strlen(symname) + 1;
-	if (len > PAGE_CACHE_SIZE) {
-		iput(inode);
-		return -ENAMETOOLONG;
-	}
-		
 	info = SHMEM_I(inode);
 	inode->i_size = len-1;
 	if (len <= sizeof(struct shmem_inode_info)) {
@@ -1201,7 +1207,7 @@
 	follow_link:	shmem_follow_link,
 };
 
-static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
 {
 	char *this_char, *value, *rest;
 
@@ -1213,7 +1219,7 @@
 			*value++ = 0;
 		} else {
 			printk(KERN_ERR 
-			    "shmem_parse_options: No value for option '%s'\n", 
+			    "tmpfs: No value for mount option '%s'\n", 
 			    this_char);
 			return 1;
 		}
@@ -1238,8 +1244,20 @@
 			*mode = simple_strtoul(value,&rest,8);
 			if (*rest)
 				goto bad_val;
+		} else if (!strcmp(this_char,"uid")) {
+			if (!uid)
+				continue;
+			*uid = simple_strtoul(value,&rest,0);
+			if (*rest)
+				goto bad_val;
+		} else if (!strcmp(this_char,"gid")) {
+			if (!gid)
+				continue;
+			*gid = simple_strtoul(value,&rest,0);
+			if (*rest)
+				goto bad_val;
 		} else {
-			printk(KERN_ERR "shmem_parse_options: Bad option %s\n",
+			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
 			       this_char);
 			return 1;
 		}
@@ -1247,7 +1265,7 @@
 	return 0;
 
 bad_val:
-	printk(KERN_ERR "shmem_parse_options: Bad value '%s' for option '%s'\n", 
+	printk(KERN_ERR "tmpfs: Bad value '%s' for mount option '%s'\n", 
 	       value, this_char);
 	return 1;
 
@@ -1259,7 +1277,7 @@
 	unsigned long max_blocks = sbinfo->max_blocks;
 	unsigned long max_inodes = sbinfo->max_inodes;
 
-	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+	if (shmem_parse_options (data, NULL, NULL, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
@@ -1276,6 +1294,8 @@
 	struct dentry * root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
+	uid_t uid = current->fsuid;
+	gid_t gid = current->fsgid;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	struct sysinfo si;
 
@@ -1287,10 +1307,8 @@
 	blocks = inodes = si.totalram / 2;
 
 #ifdef CONFIG_TMPFS
-	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
-		printk(KERN_ERR "tmpfs invalid option\n");
+	if (shmem_parse_options (data, &mode, &uid, &gid, &blocks, &inodes))
 		return -EINVAL;
-	}
 #endif
 
 	spin_lock_init (&sbinfo->stat_lock);
@@ -1307,6 +1325,8 @@
 	if (!inode)
 		return -ENOMEM;
 
+	inode->i_uid = uid;
+	inode->i_gid = gid;
 	root = d_alloc_root(inode);
 	if (!root) {
 		iput(inode);

