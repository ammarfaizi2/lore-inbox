Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSA1H5K>; Mon, 28 Jan 2002 02:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288288AbSA1H5A>; Mon, 28 Jan 2002 02:57:00 -0500
Received: from [195.66.192.167] ([195.66.192.167]:11272 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288668AbSA1H4d>; Mon, 28 Jan 2002 02:56:33 -0500
Message-Id: <200201280753.g0S7rRE21758@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] KERN_INFO for fs messages
Date: Mon, 28 Jan 2002 09:53:29 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for fs/*.c cache size messages and the like.
--
vda

diff --recursive -u linux-2.4.13-orig/fs/buffer.c linux-2.4.13-new/fs/buffer.c
--- linux-2.4.13-orig/fs/buffer.c	Tue Oct 23 22:54:19 2001
+++ linux-2.4.13-new/fs/buffer.c	Thu Nov  8 23:42:11 2001
@@ -2533,7 +2533,7 @@
 		hash_table = (struct buffer_head **)
 		    __get_free_pages(GFP_ATOMIC, order);
 	} while (hash_table == NULL && --order > 0);
-	printk("Buffer-cache hash table entries: %d (order: %d, %ld bytes)\n",
+	printk(KERN_INFO "Buffer cache hash table entries: %d (order: %d, %ld bytes)\n",
 	       nr_hash, order, (PAGE_SIZE << order));
 
 	if (!hash_table)
diff --recursive -u linux-2.4.13-orig/fs/dcache.c linux-2.4.13-new/fs/dcache.c
--- linux-2.4.13-orig/fs/dcache.c	Thu Oct  4 03:57:36 2001
+++ linux-2.4.13-new/fs/dcache.c	Thu Nov  8 23:42:11 2001
@@ -1210,7 +1210,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (dentry_hashtable == NULL && --order >= 0);

-	printk("Dentry-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));

 	if (!dentry_hashtable)
diff --recursive -u linux-2.4.13-orig/fs/inode.c linux-2.4.13-new/fs/inode.c
--- linux-2.4.13-orig/fs/inode.c	Fri Sep 28 23:03:48 2001
+++ linux-2.4.13-new/fs/inode.c	Thu Nov  8 23:42:11 2001
@@ -1150,7 +1150,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (inode_hashtable == NULL && --order >= 0);

-	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Inode cache hash table entries: %d (order: %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));

 	if (!inode_hashtable)
diff --recursive -u linux-2.4.13-orig/fs/namespace.c linux-2.4.13-new/fs/namespace.c
--- linux-2.4.13-orig/fs/namespace.c	Mon Oct 15 23:47:36 2001
+++ linux-2.4.13-new/fs/namespace.c	Thu Nov  8 23:42:11 2001
@@ -1022,8 +1022,9 @@
 	nr_hash = 1UL << hash_bits;
 	hash_mask = nr_hash-1;
 
-	printk("Mount-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
+	printk(KERN_INFO "Mount cache hash table entries: %d"
+		" (order: %ld, %ld bytes)\n",
+		nr_hash, order, (PAGE_SIZE << order));
 
 	/* And initialize the newly allocated array */
 	d = mount_hashtable;
diff --recursive -u linux-2.4.13-orig/fs/super.c linux-2.4.13-new/fs/super.c
--- linux-2.4.13-orig/fs/super.c	Sun Oct 21 00:14:42 2001
+++ linux-2.4.13-new/fs/super.c	Thu Nov  8 23:42:11 2001
@@ -748,7 +748,7 @@

 	/* Forget any remaining inodes */
 	if (invalidate_inodes(sb)) {
-		printk("VFS: Busy inodes after unmount. "
+		printk(KERN_ERR "VFS: Busy inodes after unmount. "
 			"Self-destruct in 5 seconds.  Have a nice day...\n");
 	}
 
@@ -936,12 +936,12 @@
 		goto no_nfs;
 	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", data);
 	if (!IS_ERR(vfsmnt)) {
-		printk ("VFS: Mounted root (%s filesystem).\n", "nfs");
+		printk(KERN_INFO "VFS: Mounted root (%s filesystem)\n", "nfs");
 		ROOT_DEV = vfsmnt->mnt_sb->s_dev;
 		goto attach_it;
 	}
 no_nfs:
-	printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
+	printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy\n");
 	ROOT_DEV = MKDEV(FLOPPY_MAJOR, 0);
 skip_nfs:
 #endif
@@ -1009,9 +1009,9 @@
 		 * Allow the user to distinguish between failed open
 		 * and bad superblock on root device.
 		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
+		printk(KERN_ERR "VFS: Cannot open root device \"%s\" or %s\n",
 			root_device_name, kdevname (ROOT_DEV));
-		printk ("Please append a correct \"root=\" boot option\n");
+		printk(KERN_ERR "Please append a correct \"root=\" boot option\n");
 		panic("VFS: Unable to mount root fs on %s",
 			kdevname(ROOT_DEV));
 	}
@@ -1042,7 +1042,7 @@
 mount_it:
 	/* FIXME */
 	up_write(&sb->s_umount);
-	printk ("VFS: Mounted root (%s filesystem)%s.\n", p,
+	printk(KERN_INFO "VFS: Mounted root (%s filesystem)%s\n", p,
 		(sb->s_flags & MS_RDONLY) ? " readonly" : "");
 	putname(fs_names);
 	if (path_start >= 0) {
