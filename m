Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284657AbRLPPgm>; Sun, 16 Dec 2001 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbRLPPge>; Sun, 16 Dec 2001 10:36:34 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:41600 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S284657AbRLPPgW>; Sun, 16 Dec 2001 10:36:22 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        "Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
In-Reply-To: <3C0D2843.5060708@antefacto.com>
	<E16BLxI-0003Ic-00@the-village.bc.nu>
	<snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp>
	<m3wv02oz2w.fsf@linux.local> <20011206173755.D16513@zax>
	<m3snamhwle.fsf@linux.local> <20011214063559.J18103@zax>
Organisation: SAP LinuxLab
In-Reply-To: <20011214063559.J18103@zax>
Message-ID: <m3bsh07rd6.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
Date: 16 Dec 2001 16:34:01 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi David,

On Fri, 14 Dec 2001, David Gibson wrote:
>> But the core of shmem is always compiled. And the rest is as simple
>> as ramfs...
> 
> The point of keeping ramfs simple isn't to reduce the kernel image
> size, it's to keep it useful as an example of how to make a trivial
> filesystem.

>From this point of view I prefer the oversimplified version in the
stock kernel. We should probably correct the comment about missing
features like limits and timestamps and tag it as experimental.  But
IMHO this version explains the underlying concept best.


If we want a useable ramfs implementation we should try to keep the
image size down and try to make it as similar to tmpfs as
possible. This would keep the administrators overhead low.

I append two cummulative patches against 2.4.17-rc1 (only slightly
tested):

1) Add removepage to the addresspace_operations to simplify
   shmem.c. This is taken from your ramfs limits patch.
2) Add support for a ramfs2 filesystem type to shmem.c. The only
   feature missing compared to ramfs + limits are loopback devices on
   top of ramfs files. It does not add memory need compared to
   ramfs. Have a look how small this is.

We could do 2 without 1 but it would need some review of the
calculation of the inode sizes.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-removepage

diff -uNr 17-rc1/include/linux/fs.h 17-rc1-removepage/include/linux/fs.h
--- 17-rc1/include/linux/fs.h	Sun Dec 16 10:27:45 2001
+++ 17-rc1-removepage/include/linux/fs.h	Sun Dec 16 10:36:26 2001
@@ -391,6 +391,7 @@
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+	void (*removepage)(struct page *); /* called when page gets removed from the inode */
 };
 
 struct address_space {
diff -uNr 17-rc1/mm/filemap.c 17-rc1-removepage/mm/filemap.c
--- 17-rc1/mm/filemap.c	Sun Dec 16 10:27:48 2001
+++ 17-rc1-removepage/mm/filemap.c	Sun Dec 16 10:31:55 2001
@@ -96,6 +96,9 @@
 {
 	struct address_space * mapping = page->mapping;
 
+	if (mapping->a_ops->removepage)
+		mapping->a_ops->removepage(page);
+	
 	mapping->nrpages--;
 	list_del(&page->list);
 	page->mapping = NULL;
diff -uNr 17-rc1/mm/shmem.c 17-rc1-removepage/mm/shmem.c
--- 17-rc1/mm/shmem.c	Sun Dec 16 10:27:48 2001
+++ 17-rc1-removepage/mm/shmem.c	Sun Dec 16 11:17:47 2001
@@ -47,43 +47,25 @@
 
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
-atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
+atomic_t shmem_nrpages = ATOMIC_INIT(0);
 
 #define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
 
-/*
- * shmem_recalc_inode - recalculate the size of an inode
- *
- * @inode: inode to recalc
- * @swap:  additional swap pages freed externally
- *
- * We have to calculate the free blocks since the mm can drop pages
- * behind our back
- *
- * But we know that normally
- * inodes->i_blocks/BLOCKS_PER_PAGE == 
- * 			inode->i_mapping->nrpages + info->swapped
- *
- * So the mm freed 
- * inodes->i_blocks/BLOCKS_PER_PAGE - 
- * 			(inode->i_mapping->nrpages + info->swapped)
- *
- * It has to be called with the spinlock held.
- */
-
-static void shmem_recalc_inode(struct inode * inode)
+static void shmem_removepage(struct page *page)
 {
-	unsigned long freed;
+	struct inode * inode;
+	struct shmem_sb_info * sbinfo;
 
-	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
-	if (freed){
-		struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
-		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-		spin_lock (&sbinfo->stat_lock);
-		sbinfo->free_blocks += freed;
-		spin_unlock (&sbinfo->stat_lock);
-	}
+	atomic_dec(&shmem_nrpages);
+	if (PageLaunder(page))
+		return;
+
+	inode = page->mapping->host;
+	sbinfo = SHMEM_SB(inode->i_sb);
+	inode->i_blocks -= BLOCKS_PER_PAGE;
+	spin_lock (&sbinfo->stat_lock);
+	sbinfo->free_blocks++;
+	spin_unlock (&sbinfo->stat_lock);
 }
 
 /*
@@ -315,6 +297,7 @@
 	unsigned long index;
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -325,8 +308,11 @@
 		freed += shmem_truncate_indirect(info, index);
 
 	info->swapped -= freed;
-	shmem_recalc_inode(inode);
+	inode->i_blocks -= freed*BLOCKS_PER_PAGE;
 	spin_unlock (&info->lock);
+	spin_lock (&sbinfo->stat_lock);
+	sbinfo->free_blocks += freed;
+	spin_unlock (&sbinfo->stat_lock);
 	up(&info->sem);
 }
 
@@ -385,6 +371,7 @@
 	return 0;
 found:
 	delete_from_swap_cache(page);
+	atomic_inc(&shmem_nrpages);
 	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
 	SetPageDirty(page);
 	SetPageUptodate(page);
@@ -446,7 +433,6 @@
 	entry = shmem_swp_entry(info, index, 0);
 	if (IS_ERR(entry))	/* this had been allocated on page allocation */
 		BUG();
-	shmem_recalc_inode(inode);
 	if (entry->val)
 		BUG();
 
@@ -517,7 +503,6 @@
 		return page;
 	}
 	
-	shmem_recalc_inode(inode);
 	if (entry->val) {
 		unsigned long flags;
 
@@ -583,6 +568,7 @@
 
 	/* We have the page */
 	SetPageUptodate(page);
+	atomic_inc(&shmem_nrpages);
 	return page;
 no_space:
 	spin_unlock (&sbinfo->stat_lock);
@@ -1325,6 +1311,7 @@
 
 
 static struct address_space_operations shmem_aops = {
+	removepage:	shmem_removepage,
 	writepage:	shmem_writepage,
 };
 

--=-=-=
Content-Disposition: attachment; filename=patch-ramfs2

diff -uNr 17-rc1-removepage/mm/shmem.c c/mm/shmem.c
--- 17-rc1-removepage/mm/shmem.c	Sun Dec 16 11:31:21 2001
+++ c/mm/shmem.c	Sun Dec 16 15:04:34 2001
@@ -36,15 +36,28 @@
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
 
 #define SHMEM_SB(sb) (&sb->u.shmem_sb)
+#define SHMEM_NOSWAP(info) ((info)->locked == 2)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
+static struct address_space_operations shmem_noswap_aops;
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
+static struct super_block *shmem_read_super(struct super_block * sb, void * data, int silent);
+
+#ifdef CONFIG_TMPFS
+/* type "shm" will be tagged obsolete in 2.5 */
+static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER);
+static DECLARE_FSTYPE(ramfs2_fs_type, "ramfs2", shmem_read_super, FS_LITTER);
+#else
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
+#endif
+
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0);
@@ -299,8 +312,11 @@
 	struct shmem_inode_info * info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
-	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	if (SHMEM_NOSWAP(info))
+		return;
+
+	down(&info->sem);
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 
@@ -352,6 +368,9 @@
 	unsigned long idx;
 	int offset;
 	
+	if (SHMEM_NOSWAP(info))
+		return 0;
+
 	idx = 0;
 	spin_lock (&info->lock);
 	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
@@ -484,6 +503,9 @@
 	if (page)
 		return page;
 
+	if (SHMEM_NOSWAP(info))
+		goto noswap_alloc;
+
 	entry = shmem_alloc_entry (info, idx);
 	if (IS_ERR(entry))
 		return (void *)entry;
@@ -543,6 +565,7 @@
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
+	noswap_alloc:
 		sbinfo = SHMEM_SB(inode->i_sb);
 		spin_unlock (&info->lock);
 		spin_lock (&sbinfo->stat_lock);
@@ -628,8 +651,11 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
+	if (SHMEM_NOSWAP(info))
+		return;
+
 	down(&info->sem);
-	info->locked = lock;
+	info->locked = (lock != 0);
 	up(&info->sem);
 }
 
@@ -668,12 +694,19 @@
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
-		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = SHMEM_I(inode);
 		info->inode = inode;
 		spin_lock_init (&info->lock);
 		sema_init (&info->sem, 1);
+
+		if (sb->s_type == &ramfs2_fs_type) {
+			info->locked = 2;
+			inode->i_mapping->a_ops = &shmem_noswap_aops;
+		} else {
+			inode->i_mapping->a_ops = &shmem_aops;
+		}
+
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -1310,6 +1343,11 @@
 
 
 
+static struct address_space_operations shmem_noswap_aops = {
+	removepage:	shmem_removepage,
+	writepage:	fail_writepage,
+};
+
 static struct address_space_operations shmem_aops = {
 	removepage:	shmem_removepage,
 	writepage:	shmem_writepage,
@@ -1363,13 +1401,6 @@
 	nopage:	shmem_nopage,
 };
 
-#ifdef CONFIG_TMPFS
-/* type "shm" will be tagged obsolete in 2.5 */
-static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
-static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER);
-#else
-static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
-#endif
 static struct vfsmount *shm_mnt;
 
 static int __init init_shmem_fs(void)
@@ -1382,6 +1413,11 @@
 		return error;
 	}
 #ifdef CONFIG_TMPFS
+	if ((error = register_filesystem(&ramfs2_fs_type))) {
+		printk (KERN_ERR "Could not register ramfs2\n");
+		return error;
+	}
+
 	if ((error = register_filesystem(&shmem_fs_type))) {
 		printk (KERN_ERR "Could not register shm fs\n");
 		return error;
@@ -1407,6 +1443,7 @@
 {
 #ifdef CONFIG_TMPFS
 	unregister_filesystem(&shmem_fs_type);
+	unregister_filesystem(&ramfs2_fs_type);
 #endif
 	unregister_filesystem(&tmpfs_fs_type);
 	mntput(shm_mnt);

--=-=-=--

