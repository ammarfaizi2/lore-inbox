Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136489AbREDTkc>; Fri, 4 May 2001 15:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136490AbREDTkX>; Fri, 4 May 2001 15:40:23 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:31157 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S136489AbREDTkI>; Fri, 4 May 2001 15:40:08 -0400
From: Christoph Rohland <cr@sap.com>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: [Patch] encapsulate shmem access to shmem_inode_info
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu>
	<m3n196v2un.fsf@linux.local>
Organisation: SAP LinuxLab
Message-ID: <m3vgnjy8to.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 May 2001 21:17:59 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24 Apr 2001, Christoph Rohland wrote:
> Hi Al,
> 
> On Tue, 24 Apr 2001, Alexander Viro wrote:
>> So yes, IMO having such patches available _is_ a good thing. And in
>> 2.5 we definitely want them in the tree. If encapsulation part gets
>> there during 2.4 and separate allocation is available for all of
>> them it will be easier to do without PITA in process.
> 
> OK I will do that for tmpfs soon. And I will do the symlink inlining
> with that patch.

Here comes the patch to encapsulate all accesses to struct
shmem_inode_info into a macro. It is now trivial to allocate the
private part independently from the inode.

Greetings
		Christoph

P.S: The symlink inlining will come in a separate patch

diff -uNr 2.4.4-mmap_write/include/linux/shmem_fs.h 2.4.4-mmap_write-SHMEM_I/include/linux/shmem_fs.h
--- 2.4.4-mmap_write/include/linux/shmem_fs.h	Tue May  1 20:02:00 2001
+++ 2.4.4-mmap_write-SHMEM_I/include/linux/shmem_fs.h	Tue May  1 20:06:10 2001
@@ -18,14 +18,15 @@
 } swp_entry_t;
 
 struct shmem_inode_info {
-	spinlock_t	lock;
-	struct semaphore sem;
-	unsigned long	max_index;
-	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	swp_entry_t   **i_indirect; /* doubly indirect blocks */
-	unsigned long	swapped;
-	int		locked;     /* into memory */
+	spinlock_t		lock;
+	struct semaphore 	sem;
+	unsigned long		max_index;
+	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
+	swp_entry_t           **i_indirect; /* doubly indirect blocks */
+	unsigned long		swapped;
+	int			locked;     /* into memory */
 	struct list_head	list;
+	struct inode	       *inode;
 };
 
 struct shmem_sb_info {
@@ -35,5 +36,7 @@
 	unsigned long free_inodes;  /* How many are left for allocation */
 	spinlock_t    stat_lock;
 };
+
+#define SHMEM_I(inode)  (&inode->u.shmem_i)
 
 #endif
diff -uNr 2.4.4-mmap_write/ipc/shm.c 2.4.4-mmap_write-SHMEM_I/ipc/shm.c
--- 2.4.4-mmap_write/ipc/shm.c	Wed Apr 11 12:36:47 2001
+++ 2.4.4-mmap_write-SHMEM_I/ipc/shm.c	Tue May  1 20:06:10 2001
@@ -348,6 +348,7 @@
 
 static void shm_get_stat (unsigned long *rss, unsigned long *swp) 
 {
+	struct shmem_inode_info *info;
 	int i;
 
 	*rss = 0;
@@ -361,10 +362,11 @@
 		if(shp == NULL)
 			continue;
 		inode = shp->shm_file->f_dentry->d_inode;
-		spin_lock (&inode->u.shmem_i.lock);
+		info = SHMEM_I(inode);
+		spin_lock (&info->lock);
 		*rss += inode->i_mapping->nrpages;
-		*swp += inode->u.shmem_i.swapped;
-		spin_unlock (&inode->u.shmem_i.lock);
+		*swp += info->swapped;
+		spin_unlock (&info->lock);
 	}
 }
 
diff -uNr 2.4.4-mmap_write/mm/shmem.c 2.4.4-mmap_write-SHMEM_I/mm/shmem.c
--- 2.4.4-mmap_write/mm/shmem.c	Tue May  1 20:02:00 2001
+++ 2.4.4-mmap_write-SHMEM_I/mm/shmem.c	Wed May  2 16:46:00 2001
@@ -73,7 +73,7 @@
 	unsigned long freed;
 
 	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
+		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
 	if (freed){
 		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
 		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
@@ -159,7 +159,7 @@
 	unsigned long index, start;
 	unsigned long freed = 0;
 	swp_entry_t **base, **ptr, **last;
-	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -206,7 +206,7 @@
 	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
 
 	spin_lock (&shmem_ilock);
-	list_del (&inode->u.shmem_i.list);
+	list_del (&SHMEM_I(inode)->list);
 	spin_unlock (&shmem_ilock);
 	inode->i_size = 0;
 	shmem_truncate (inode);
@@ -239,7 +239,7 @@
 		goto out;
 	
 	inode = page->mapping->host;
-	info = &inode->u.shmem_i;
+	info = SHMEM_I(inode);
 	swap = __get_swap_page(2);
 	error = -ENOMEM;
 	if (!swap.val)
@@ -407,7 +407,7 @@
 		page_cache_release(*ptr);
 	}
 
-	info = &inode->u.shmem_i;
+	info = SHMEM_I(inode);
 	down (&info->sem);
 	/* retest we may have slept */  	
 
@@ -415,7 +415,7 @@
 	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
 		goto failed;
 
-	*ptr = shmem_getpage_locked(&inode->u.shmem_i, inode, idx);
+	*ptr = shmem_getpage_locked(info, inode, idx);
 	if (IS_ERR (*ptr))
 		goto failed;
 
@@ -462,7 +462,7 @@
 void shmem_lock(struct file * file, int lock)
 {
 	struct inode * inode = file->f_dentry->d_inode;
-	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct shmem_inode_info * info = SHMEM_I(inode);
 	struct page * page;
 	unsigned long idx, size;
 
@@ -521,7 +521,8 @@
 		inode->i_rdev = to_kdev_t(dev);
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		info = &inode->u.shmem_i;
+		info = SHMEM_I(inode);
+		info->inode = inode;
 		spin_lock_init (&info->lock);
 		sema_init (&info->sem, 1);
 		switch (mode & S_IFMT) {
@@ -542,7 +543,7 @@
 			break;
 		}
 		spin_lock (&shmem_ilock);
-		list_add (&inode->u.shmem_i.list, &shmem_inodes);
+		list_add (&SHMEM_I(inode)->list, &shmem_inodes);
 		spin_unlock (&shmem_ilock);
 	}
 	return inode;
@@ -629,7 +630,7 @@
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		info = &inode->u.shmem_i;
+		info = SHMEM_I(inode);
 		down (&info->sem);
 		page = shmem_getpage_locked(info, inode, index);
 		up (&info->sem);
@@ -658,8 +659,8 @@
 			buf += bytes;
 			if (pos > inode->i_size) 
 				inode->i_size = pos;
-			if (inode->u.shmem_i.max_index <= index)
-				inode->u.shmem_i.max_index = index+1;
+			if (info->max_index <= index)
+				info->max_index = index+1;
 
 		}
 unlock:
@@ -940,7 +941,7 @@
 		
 	inode = dentry->d_inode;
 	down(&inode->i_sem);
-	page = shmem_getpage_locked(&inode->u.shmem_i, inode, 0);
+	page = shmem_getpage_locked(SHMEM_I(inode), inode, 0);
 	if (IS_ERR(page))
 		goto fail;
 	kaddr = kmap(page);
@@ -1220,12 +1221,11 @@
 	return -1;
 }
 
-static int shmem_unuse_inode (struct inode *inode, swp_entry_t entry, struct page *page)
+static int shmem_unuse_inode (struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
 	swp_entry_t **base, **ptr;
 	unsigned long idx;
 	int offset;
-	struct shmem_inode_info *info = &inode->u.shmem_i;
 	
 	idx = 0;
 	spin_lock (&info->lock);
@@ -1246,7 +1246,7 @@
 	spin_unlock (&info->lock);
 	return 0;
 found:
-	add_to_page_cache(page, inode->i_mapping, offset + idx);
+	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
 	set_page_dirty(page);
 	SetPageUptodate(page);
 	UnlockPage(page);
@@ -1261,13 +1261,13 @@
 void shmem_unuse(swp_entry_t entry, struct page *page)
 {
 	struct list_head *p;
-	struct inode * inode;
+	struct shmem_inode_info * info;
 
 	spin_lock (&shmem_ilock);
 	list_for_each(p, &shmem_inodes) {
-		inode = list_entry(p, struct inode, u.shmem_i.list);
+		info = list_entry(p, struct shmem_inode_info, list);
 
-		if (shmem_unuse_inode(inode, entry, page))
+		if (shmem_unuse_inode(info, entry, page))
 			break;
 	}
 	spin_unlock (&shmem_ilock);

