Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283114AbRLFPUP>; Thu, 6 Dec 2001 10:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283274AbRLFPUF>; Thu, 6 Dec 2001 10:20:05 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3316 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S283114AbRLFPTz>; Thu, 6 Dec 2001 10:19:55 -0500
From: Christoph Rohland <cr@sap.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre3
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva>
Organisation: SAP LinuxLab
Date: 06 Dec 2001 16:16:23 +0100
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva>
Message-ID: <m3adwwl6pk.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, 5 Dec 2001, Marcelo Tosatti wrote:
> pre3:
> 
> - Enable ppro errata workaround                 (Dave Jones)
> - Update tmpfs documentation                    (Christoph Rohland)

Unfortunately the file Documentation/filesystem/tmpfs.txt did not make
it into your patch.

Here it comes again (slightly modified) 

Further on the documentation drew some attention to the completeness
of the mount option set and I added a uid and gid option. It was
easier than adding a TODO entry ;-)

And I made the error messages somewhat better understandable from a
user perspective.

Please apply
		Christoph

diff -uNr 17-pre4/Documentation/filesystems/tmpfs.txt m17-pre4/Documentation/filesystems/tmpfs.txt
--- 17-pre4/Documentation/filesystems/tmpfs.txt	Thu Jan  1 01:00:00 1970
+++ m17-pre4/Documentation/filesystems/tmpfs.txt	Thu Dec  6 16:09:49 2001
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
diff -uNr 17-pre4/mm/shmem.c m17-pre4/mm/shmem.c
--- 17-pre4/mm/shmem.c	Mon Nov 26 16:21:58 2001
+++ m17-pre4/mm/shmem.c	Thu Dec  6 16:08:26 2001
@@ -1193,7 +1193,7 @@
 	follow_link:	shmem_follow_link,
 };
 
-static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
+static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
 {
 	char *this_char, *value, *rest;
 
@@ -1205,7 +1205,7 @@
 			*value++ = 0;
 		} else {
 			printk(KERN_ERR 
-			    "shmem_parse_options: No value for option '%s'\n", 
+			    "tmpfs: No value for mount option '%s'\n", 
 			    this_char);
 			return 1;
 		}
@@ -1230,8 +1230,20 @@
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
@@ -1239,7 +1251,7 @@
 	return 0;
 
 bad_val:
-	printk(KERN_ERR "shmem_parse_options: Bad value '%s' for option '%s'\n", 
+	printk(KERN_ERR "tmpfs: Bad value '%s' for mount option '%s'\n", 
 	       value, this_char);
 	return 1;
 
@@ -1251,7 +1263,7 @@
 	unsigned long max_blocks = sbinfo->max_blocks;
 	unsigned long max_inodes = sbinfo->max_inodes;
 
-	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+	if (shmem_parse_options (data, NULL, NULL, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 	return shmem_set_size(sbinfo, max_blocks, max_inodes);
 }
@@ -1268,6 +1280,8 @@
 	struct dentry * root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
+	uid_t uid = current->fsuid;
+	gid_t gid = current->fsgid;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	struct sysinfo si;
 
@@ -1279,10 +1293,8 @@
 	blocks = inodes = si.totalram / 2;
 
 #ifdef CONFIG_TMPFS
-	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
-		printk(KERN_ERR "tmpfs invalid option\n");
+	if (shmem_parse_options (data, &mode, &uid, &gid, &blocks, &inodes))
 		return NULL;
-	}
 #endif
 
 	spin_lock_init (&sbinfo->stat_lock);
@@ -1299,6 +1311,8 @@
 	if (!inode)
 		return NULL;
 
+	inode->i_uid = uid;
+	inode->i_gid = gid;
 	root = d_alloc_root(inode);
 	if (!root) {
 		iput(inode);

