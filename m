Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268862AbRHFQii>; Mon, 6 Aug 2001 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHFQi3>; Mon, 6 Aug 2001 12:38:29 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:23295 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S268861AbRHFQiP>; Mon, 6 Aug 2001 12:38:15 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch-ac] Re: DoS with tmpfs #3
In-Reply-To: <20010803163409.62191.qmail@web13609.mail.yahoo.com>
	<Pine.LNX.4.33L.0108040303030.2526-100000@imladris.rielhome.conectiva>
	<20010805063657.C20164@weta.f00f.org> <m3ofpturpx.fsf@linux.local>
Organisation: SAP LinuxLab
In-Reply-To: <m3ofpturpx.fsf@linux.local>
Message-ID: <m3hevlb1no.fsf_-_@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 06 Aug 2001 18:29:00 +0200
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 06 Aug 2001, Christoph Rohland wrote:
> Since there are enough persons having trouble with the current
> behaviour I append a patch (against 2.4.8-pre4) to implement the
> default to be ram/2.

The appended patch is the same against 2.4.7-ac7 plus some further
fixes/cleanups:

- Use PAGE_CACHE_SIZE consistently
- use info->sem instead of inode->i_sem where appropriate
- fix a race in shmem_lock

Greetings
		Christoph


diff -uNr 7-ac7/mm/shmem.c 7-ac7-fix/mm/shmem.c
--- 7-ac7/mm/shmem.c	Mon Aug  6 17:37:28 2001
+++ 7-ac7-fix/mm/shmem.c	Mon Aug  6 18:06:13 2001
@@ -33,7 +33,7 @@
 /* This magic number is used in glibc for posix shared memory */
 #define TMPFS_MAGIC	0x01021994
 
-#define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
+#define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
 
 #define SHMEM_SB(sb) (&sb->u.shmem_sb)
 
@@ -49,7 +49,7 @@
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0);
 
-#define BLOCKS_PER_PAGE (PAGE_SIZE/512)
+#define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
 
 static void shmem_removepage(struct page *page)
 {
@@ -626,7 +626,7 @@
 	unsigned int idx;
 	struct inode * inode = vma->vm_file->f_dentry->d_inode;
 
-	idx = (address - vma->vm_start) >> PAGE_SHIFT;
+	idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
 	idx += vma->vm_pgoff;
 
 	if (shmem_getpage(inode, idx, &page))
@@ -655,9 +655,9 @@
 	struct page * page;
 	unsigned long idx, size;
 
-	if (info->locked == lock)
-		return;
-	down(&inode->i_sem);
+	down(&info->sem);
+	if (info->locked == lock) 
+		goto out;
 	info->locked = lock;
 	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	for (idx = 0; idx < size; idx++) {
@@ -671,7 +671,8 @@
 		}
 		UnlockPage(page);
 	}
-	up(&inode->i_sem);
+out:
+	up(&info->sem);
 }
 
 static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
@@ -962,18 +963,8 @@
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sbinfo->stat_lock);
-	if (sbinfo->max_blocks == ULONG_MAX) {
-		/*
-		 * This is only a guestimate and not honoured.
-		 * We need it to make some programs happy which like to
-		 * test the free space of a file system.
-		 */
-		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);
-		buf->f_blocks = buf->f_bfree + ULONG_MAX - sbinfo->free_blocks;
-	} else {
-		buf->f_blocks = sbinfo->max_blocks;
-		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
-	}
+	buf->f_blocks = sbinfo->max_blocks;
+	buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
 	buf->f_files = sbinfo->max_inodes;
 	buf->f_ffree = sbinfo->free_inodes;
 	spin_unlock (&sbinfo->stat_lock);
@@ -1129,7 +1120,7 @@
 		return error;
 
 	len = strlen(symname) + 1;
-	if (len > PAGE_SIZE)
+	if (len > PAGE_CACHE_SIZE)
 		return -ENAMETOOLONG;
 		
 	inode = dentry->d_inode;
@@ -1143,10 +1134,10 @@
 		spin_lock (&shmem_ilock);
 		list_add (&info->list, &shmem_inodes);
 		spin_unlock (&shmem_ilock);
-		down(&inode->i_sem);
+		down(&info->sem);
 		page = shmem_getpage_locked(info, inode, 0);
 		if (IS_ERR(page)) {
-			up(&inode->i_sem);
+			up(&info->sem);
 			return PTR_ERR(page);
 		}
 		kaddr = kmap(page);
@@ -1155,7 +1146,7 @@
 		SetPageDirty(page);
 		UnlockPage(page);
 		page_cache_release(page);
-		up(&inode->i_sem);
+		up(&info->sem);
 		inode->i_op = &shmem_symlink_inode_operations;
 	}
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
@@ -1253,17 +1244,11 @@
 	return 0;
 }
 
-static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+static int shmem_set_size(struct shmem_sb_info *sbinfo,
+			  unsigned long max_blocks, unsigned long max_inodes)
 {
 	int error;
-	unsigned long max_blocks, blocks;
-	unsigned long max_inodes, inodes;
-	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
-
-	max_blocks = sbinfo->max_blocks;
-	max_inodes = sbinfo->max_inodes;
-	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
-		return -EINVAL;
+	unsigned long blocks, inodes;
 
 	spin_lock(&sbinfo->stat_lock);
 	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
@@ -1283,6 +1268,17 @@
 	return error;
 }
 
+static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+{
+	struct shmem_sb_info *sbinfo = &sb->u.shmem_sb;
+	unsigned long max_blocks = sbinfo->max_blocks;
+	unsigned long max_inodes = sbinfo->max_inodes;
+
+	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+		return -EINVAL;
+	return shmem_set_size(sbinfo, max_blocks, max_inodes);
+}
+
 int shmem_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	return 0;
@@ -1293,10 +1289,17 @@
 {
 	struct inode * inode;
 	struct dentry * root;
-	unsigned long blocks = ULONG_MAX;	/* unlimited */
-	unsigned long inodes = ULONG_MAX;	/* unlimited */
+	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	struct sysinfo si;
+
+	/*
+	 * Per default we only allow half of the physical ram per
+	 * tmpfs instance
+	 */
+	si_meminfo(&si);
+	blocks = inodes = si.totalram / 2;
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
@@ -1416,6 +1419,10 @@
 	}
 	shm_mnt = res;
 
+	/* The internal instance should not do size checking */
+	if ((error = shmem_set_size(SHMEM_SB(res->mnt_sb), ULONG_MAX, ULONG_MAX)))
+		printk (KERN_ERR "could not set limits on internal tmpfs\n");
+
 	return 0;
 }
 
@@ -1450,7 +1457,7 @@
 	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
 		return ERR_PTR(-EINVAL);
 
-	if (!vm_enough_memory((size) >> PAGE_SHIFT))
+	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
 		return ERR_PTR(-ENOMEM);
 
 	this.name = name;

