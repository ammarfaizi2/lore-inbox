Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTK2UCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTK2UCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:02:44 -0500
Received: from gw-undead3.tht.net ([216.126.84.18]:46720 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S262608AbTK2UCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:02:38 -0500
Message-ID: <3FC8FB58.6080708@undead.cc>
Date: Sat, 29 Nov 2003 15:02:32 -0500
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc> <20031129062136.GH8039@holomorphy.com> <3FC869A3.8070809@undead.cc> <20031129094435.GS14258@holomorphy.com>
In-Reply-To: <20031129094435.GS14258@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>Cool! So when do we get a swappable initrd's/initramfs's?
>
>  
>
It was 5 in the morning and I ran out of cola.  :(   Here's the updated 
patch.  I added an extra error check just in case we ran out of memory 
initializing shm's inode cache.  Shm defaults to half of available ram 
which should be a good limit.  Otherwise the machine might not boot if 
we fill up ram with that early on.   And we can probably remount it with 
a new set of limits later.   Can the swap device be started in early 
userspace?

Just found something while testing.  Looks like we do need CONFIG_TMPFS 
or else we get a kernel oops on bootup.  I'll force that if SHM_ROOTFS 
is selected.  It adds some extra code that the internal kernel use of 
shmem didn't need.   If you already use tmpfs that won't matter and 
ramfs can now be deselected.

Let me know if you find anything wrong with this.

diff -urNX dontdiff linux-2.6.0-test9/drivers/block/Kconfig linux/drivers/block/Kconfig
--- linux-2.6.0-test9/drivers/block/Kconfig	2003-10-25 14:43:07.000000000 -0400
+++ linux/drivers/block/Kconfig	2003-11-29 14:50:02.000000000 -0500
@@ -320,6 +320,22 @@
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
 
+config SHM_ROOTFS
+	bool "Use tmpfs (shm) instead of ramfs for rootfs"
+	depends on BLK_DEV_INITRD
+	default n
+	select TMPFS
+	help
+	  This option switches rootfs so that it uses tmpfs rather than ramfs
+	  for it's file storage.  This makes rootfs swappable so having a large
+	  initrd or initramfs image won't eat up valuable RAM.
+	  
+config RAMFS_ROOTFS
+	bool 
+	depends on !SHM_ROOTFS
+	default y
+	select RAMFS
+
 config LBD
 	bool "Support for Large Block Devices"
 	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
diff -urNX dontdiff linux-2.6.0-test9/fs/Kconfig linux/fs/Kconfig
--- linux-2.6.0-test9/fs/Kconfig	2003-10-25 14:43:51.000000000 -0400
+++ linux/fs/Kconfig	2003-11-28 23:20:48.000000000 -0500
@@ -879,8 +879,8 @@
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
-config RAMFS
-	bool
+config RAMFS 
+	tristate "Ramfs file system support"
 	default y
 	---help---
 	  Ramfs is a file system which keeps all files in RAM. It allows
diff -urNX dontdiff linux-2.6.0-test9/fs/ramfs/inode.c linux/fs/ramfs/inode.c
--- linux-2.6.0-test9/fs/ramfs/inode.c	2003-10-25 14:43:21.000000000 -0400
+++ linux/fs/ramfs/inode.c	2003-11-29 00:13:33.000000000 -0500
@@ -204,22 +204,26 @@
 	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
 }
 
+#ifdef CONFIG_RAMFS_ROOTFS
 static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
 }
+#endif
 
 static struct file_system_type ramfs_fs_type = {
 	.name		= "ramfs",
 	.get_sb		= ramfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
+#ifdef CONFIG_RAMFS_ROOTFS
 static struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.get_sb		= rootfs_get_sb,
 	.kill_sb	= kill_litter_super,
 };
+#endif
 
 static int __init init_ramfs_fs(void)
 {
@@ -234,9 +238,11 @@
 module_init(init_ramfs_fs)
 module_exit(exit_ramfs_fs)
 
+#ifdef CONFIG_RAMFS_ROOTFS
 int __init init_rootfs(void)
 {
 	return register_filesystem(&rootfs_fs_type);
 }
+#endif
 
 MODULE_LICENSE("GPL");
diff -urNX dontdiff linux-2.6.0-test9/mm/shmem.c linux/mm/shmem.c
--- linux-2.6.0-test9/mm/shmem.c	2003-10-25 14:43:30.000000000 -0400
+++ linux/mm/shmem.c	2003-11-29 14:24:37.000000000 -0500
@@ -1773,7 +1773,7 @@
 	sb->s_fs_info = NULL;
 }
 
-static kmem_cache_t *shmem_inode_cachep;
+static kmem_cache_t *shmem_inode_cachep = NULL;
 
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
@@ -1801,12 +1801,14 @@
 
 static int init_inodecache(void)
 {
-	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
-					     sizeof(struct shmem_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
-					     init_once, NULL);
-	if (shmem_inode_cachep == NULL)
-		return -ENOMEM;
+	if (!shmem_inode_cachep) {
+		shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
+						     sizeof(struct shmem_inode_info),
+						     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+						     init_once, NULL);
+		if (shmem_inode_cachep == NULL)
+			return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -2008,3 +2010,24 @@
 }
 
 EXPORT_SYMBOL(shmem_file_setup);
+
+#ifdef CONFIG_SHM_ROOTFS
+static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, shmem_fill_super);
+}
+
+static struct file_system_type rootfs_fs_type = {
+	.name		= "rootfs",
+	.get_sb		= rootfs_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+int __init init_rootfs(void)
+{
+	if (init_inodecache())
+	    panic("Can't initialize shm inode cache");
+	return register_filesystem(&rootfs_fs_type);
+}
+#endif


John


