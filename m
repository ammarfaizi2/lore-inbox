Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132960AbRDXKBf>; Tue, 24 Apr 2001 06:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRDXKB0>; Tue, 24 Apr 2001 06:01:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48849 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133012AbRDXKBP>;
	Tue, 24 Apr 2001 06:01:15 -0400
Date: Tue, 24 Apr 2001 06:01:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104240356.f3O3ujbI002673@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104240534440.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, Andreas Dilger wrote:

> Al posted a patch to the NFS code which removes nfs_inode_info from the
> inode union.  Since it is (AFAIK) the largest member of the union, we
> have just saved 24 bytes per inode (hfs_inode_info is also rather large).
> If we removed hfs_inode_info as well, we would save 108 bytes per inode,
> about 22% ({ext2,affs,ufs}_inode_info are all about the same size).

For fsck sake! HFS patch. Time: 14 minutes, including checking that sucker
builds (it had most of the accesses to ->u.hfs_i already encapsulated).

What I really don't understand is why the hell people keep coming up
with the grand and convoluted plans of removing the inode bloat and
nobleedinone of them actually cared to sit down and do the simplest variant
possible.

I can certainly go through the rest of filesystems and even do a testing
for most of them, but WTF? Could the rest of you please join the show?
It's not a fscking rocket science - encapsulate accesses to ->u.foofs_i
into inlined function, find ->read_inode, find places that do get_empty_inode()
or new_inode(), add allocation there, add freeing to ->clear_inode()
(defining one if needed), change that inlined function so that it would
return ->u.generic_ip and you are done. Clean the results up and test
them. Furrfu...

It's not like it was a global change that affected the whole kernel -
at every step changes are local to one filesystem and changes for
different filesystems are independent from each other. If at some point
in 2.5 .generic_ip is the only member of union - fine, we just do
%s/u.generic_ip/fs_inode/g
or something like that. Moreover, if maintainer of filesystem foo is
OK with change it _can_ be done in 2.4 - it doesn't affect anything
outside of foofs.

Guys, doing all these patches is ~20 man-hours. And that's bloody generous
estimate. Looking through the results and doing necessary tweaking
(as in "hmm... we keep passing pointer to inode through the long chain
of functions and all of them need only fs-specific part", etc.) - about
the same. Verifiying that thing wasn't fucked up - maybe an hour or two of
audit per filesystem (split the patch into encapsulation part - trivial
to verify - and the rest - pretty small). Grrr...

Oh, well... Initial HFS patch follows:

diff -urN S4-pre6/fs/hfs/inode.c S4-pre6-hfs/fs/hfs/inode.c
--- S4-pre6/fs/hfs/inode.c	Fri Feb 16 22:55:36 2001
+++ S4-pre6-hfs/fs/hfs/inode.c	Tue Apr 24 05:10:21 2001
@@ -231,7 +231,7 @@
 static int hfs_prepare_write(struct file *file, struct page *page, unsigned from, unsigned to)
 {
 	return cont_prepare_write(page,from,to,hfs_get_block,
-		&page->mapping->host->u.hfs_i.mmu_private);
+		&HFS_I(page->mapping->host)->mmu_private);
 }
 static int hfs_bmap(struct address_space *mapping, long block)
 {
@@ -309,7 +309,7 @@
 	        return NULL;
 	}
 
-	if (inode->i_dev != sb->s_dev) {
+	if (inode->i_dev != sb->s_dev || !HFS_I(inode)) {
 	        iput(inode); /* automatically does an hfs_cat_put */
 		inode = NULL;
 	} else if (!inode->i_mode || (*sys_entry == NULL)) {
@@ -373,7 +373,7 @@
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
-		inode->u.hfs_i.mmu_private = inode->i_size;
+		HFS_I(inode)->mmu_private = inode->i_size;
 	} else { /* Directory */
 		struct hfs_dir *hdir = &entry->u.dir;
 
@@ -433,7 +433,7 @@
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
-		inode->u.hfs_i.mmu_private = inode->i_size;
+		HFS_I(inode)->mmu_private = inode->i_size;
 	} else { /* Directory */
 		struct hfs_dir *hdir = &entry->u.dir;
 
@@ -479,7 +479,7 @@
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
-		inode->u.hfs_i.mmu_private = inode->i_size;
+		HFS_I(inode)->mmu_private = inode->i_size;
 	} else { /* Directory */
 		struct hfs_dir *hdir = &entry->u.dir;
 
diff -urN S4-pre6/fs/hfs/super.c S4-pre6-hfs/fs/hfs/super.c
--- S4-pre6/fs/hfs/super.c	Sat Apr 21 14:35:20 2001
+++ S4-pre6-hfs/fs/hfs/super.c	Tue Apr 24 05:26:04 2001
@@ -35,6 +35,7 @@
 /*================ Forward declarations ================*/
 
 static void hfs_read_inode(struct inode *);
+static void hfs_clear_inode(struct inode *);
 static void hfs_put_super(struct super_block *);
 static int hfs_statfs(struct super_block *, struct statfs *);
 static void hfs_write_super(struct super_block *);
@@ -43,6 +44,7 @@
 
 static struct super_operations hfs_super_operations = { 
 	read_inode:	hfs_read_inode,
+	clear_inode:	hfs_clear_inode,
 	put_inode:	hfs_put_inode,
 	put_super:	hfs_put_super,
 	write_super:	hfs_write_super,
@@ -52,6 +54,7 @@
 /*================ File-local variables ================*/
 
 static DECLARE_FSTYPE_DEV(hfs_fs, "hfs", hfs_read_super);
+static kmem_cache_t *hfs_cachep;
 
 /*================ File-local functions ================*/
 
@@ -64,6 +67,15 @@
 static void hfs_read_inode(struct inode *inode)
 {
   inode->i_mode = 0;
+  inode->u.generic_ip = kmem_cache_alloc(hfs_cachep, SLAB_KERNEL);
+}
+
+static void hfs_clear_inode(struct inode *inode)
+{
+  struct hfs_inode_info *hfsi = HFS_I(inode);
+  inode->u.generic_ip = NULL;
+  if (hfsi)
+	kmem_cache_free(hfs_cachep, hfsi);
 }
 
 /*
@@ -475,12 +487,20 @@
 static int __init init_hfs_fs(void)
 {
         hfs_cat_init();
+	hfs_cachep = kmem_cache_create("hfs_inodes",
+				     sizeof(struct hfs_inode_info),
+				     0, SLAB_HWCACHE_ALIGN,
+				     NULL, NULL);
+	if (hfs_cachep == NULL)
+		return -ENOMEM;
 	return register_filesystem(&hfs_fs);
 }
 
 static void __exit exit_hfs_fs(void) {
 	hfs_cat_free();
 	unregister_filesystem(&hfs_fs);
+	if (kmem_cache_destroy(hfs_cachep))
+		printk(KERN_INFO "hfs_inodes: not all structures were freed\n");
 }
 
 module_init(init_hfs_fs)
diff -urN S4-pre6/include/linux/fs.h S4-pre6-hfs/include/linux/fs.h
--- S4-pre6/include/linux/fs.h	Sat Apr 21 14:35:32 2001
+++ S4-pre6-hfs/include/linux/fs.h	Tue Apr 24 05:21:34 2001
@@ -293,7 +293,6 @@
 #include <linux/romfs_fs_i.h>
 #include <linux/shmem_fs.h>
 #include <linux/smb_fs_i.h>
-#include <linux/hfs_fs_i.h>
 #include <linux/adfs_fs_i.h>
 #include <linux/qnx4_fs_i.h>
 #include <linux/reiserfs_fs_i.h>
@@ -457,7 +456,6 @@
 		struct shmem_inode_info		shmem_i;
 		struct coda_inode_info		coda_i;
 		struct smb_inode_info		smbfs_i;
-		struct hfs_inode_info		hfs_i;
 		struct adfs_inode_info		adfs_i;
 		struct qnx4_inode_info		qnx4_i;
 		struct reiserfs_inode_info	reiserfs_i;
diff -urN S4-pre6/include/linux/hfs_fs.h S4-pre6-hfs/include/linux/hfs_fs.h
--- S4-pre6/include/linux/hfs_fs.h	Fri Feb 16 22:55:40 2001
+++ S4-pre6-hfs/include/linux/hfs_fs.h	Tue Apr 24 05:24:18 2001
@@ -317,7 +317,11 @@
 extern int hfs_mac2triv(char *, const struct hfs_name *);
 extern void hfs_tolower(unsigned char *, int);
 
-#define	HFS_I(X)	(&((X)->u.hfs_i))
+static inline struct hfs_inode_info *HFS_I(struct inode *inode)
+{
+	return (struct hfs_inode_info *)inode->u.generic_ip;
+}
+
 #define	HFS_SB(X)	(&((X)->u.hfs_sb))
 
 static inline void hfs_nameout(struct inode *dir, struct hfs_name *out,

