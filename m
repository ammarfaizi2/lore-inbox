Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266063AbRGKTmk>; Wed, 11 Jul 2001 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRGKTmb>; Wed, 11 Jul 2001 15:42:31 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6640 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S266046AbRGKTmS>; Wed, 11 Jul 2001 15:42:18 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>, Stephen Tweedie <sct@redhat.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091345070.20937-100000@penguin.transmeta.com>
Organisation: SAP LinuxLab
Message-ID: <m3u20j46eh.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 11 Jul 2001 21:39:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, 9 Jul 2001, Linus Torvalds wrote:
> 
> On 9 Jul 2001, Christoph Rohland wrote:
>>
>> No, it does matter. It prevents races against getpage.
> 
> No it doesn't.
> 
> We have the page locked.
> 
> And if somebody does "getpage()" and doesn't check for the page
> lock, then that test _still_ doesn't prevent races, because the
> getpage might happen just _after_ the "atomic_read()".
>
> As it stands now, that atomic_read() does _nothing_. If you think
> something depends on it, then that something is already buggy.

Yep, you are right. This check hides another error: We cannot use
find_get_page for shmem since this is getting the page without the
lock like you described. I removed this optimization. Also
__find_lock_page has to check that mapping and index are still the
ones we looked for.

I append a patch to fix these errors (and the other obvious buglets in
shmem.c I did send to you several times).

Stephen, could you crosscheck? You had the test case which triggered
the count > 2 bug.

Greetings
		Christoph


diff -uNr 7-pre6/mm/filemap.c 7-pre6-fix/mm/filemap.c
--- 7-pre6/mm/filemap.c	Wed Jul 11 09:59:01 2001
+++ 7-pre6-fix/mm/filemap.c	Wed Jul 11 20:49:14 2001
@@ -760,7 +760,7 @@
 		lock_page(page);
 
 		/* Is the page still hashed? Ok, good.. */
-		if (page->mapping)
+		if (page->mapping == mapping && page->index == offset)
 			return page;
 
 		/* Nope: we raced. Release and try again.. */
diff -uNr 7-pre6/mm/shmem.c 7-pre6-fix/mm/shmem.c
--- 7-pre6/mm/shmem.c	Wed Jul 11 09:59:01 2001
+++ 7-pre6-fix/mm/shmem.c	Wed Jul 11 20:44:35 2001
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
- *		 2000 Christoph Rohland
+ *		 2000-2001 Christoph Rohland
+ *		 2000-2001 SAP AG
  * 
  * This file is released under the GPL.
  */
@@ -33,7 +34,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
-#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -193,7 +194,14 @@
 	}
 
 out:
-	info->max_index = index;
+	/*
+	 * We have no chance to give an error, so we limit it to max
+	 * size here and the application will fail later
+	 */
+	if (index > SHMEM_MAX_BLOCKS) 
+		info->max_index = SHMEM_MAX_BLOCKS;
+	else
+		info->max_index = index;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
@@ -311,6 +319,7 @@
 		return page;
 	}
 	
+	shmem_recalc_inode(inode);
 	if (entry->val) {
 		unsigned long flags;
 
@@ -390,22 +399,9 @@
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
 {
-	struct address_space * mapping = inode->i_mapping;
 	int error;
 
-	*ptr = NOPAGE_SIGBUS;
-	if (inode->i_size <= (loff_t) idx * PAGE_CACHE_SIZE)
-		return -EFAULT;
-
-	*ptr = __find_get_page(mapping, idx, page_hash(mapping, idx));
-	if (*ptr) {
-		if (Page_Uptodate(*ptr))
-			return 0;
-		page_cache_release(*ptr);
-	}
-
 	down (&inode->i_sem);
-	/* retest we may have slept */
 	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
 		goto sigbus;
 	*ptr = shmem_getpage_locked(inode, idx);
@@ -1024,6 +1020,8 @@
 	unsigned long max_inodes, inodes;
 	struct shmem_sb_info *info = &sb->u.shmem_sb;
 
+	max_blocks = info->max_blocks;
+	max_inodes = info->max_inodes;
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
@@ -1071,7 +1069,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long)SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1279,9 +1277,11 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	error = -ENOMEM;
+	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+		return ERR_PTR(-EINVAL);
+
 	if (!vm_enough_memory((size) >> PAGE_SHIFT))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
 	this.len = strlen(name);
@@ -1289,7 +1289,7 @@
 	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1315,7 +1315,6 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
-out:
 	return ERR_PTR(error);	
 }
 /*

