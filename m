Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbTEOAgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTEOAgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:36:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43218
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263257AbTEOAg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:36:27 -0400
Date: Thu, 15 May 2003 02:49:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, mika.penttila@kolumbus.fi,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515004915.GR1429@dualathlon.random>
References: <154080000.1052858685@baldur.austin.ibm.com> <20030513181018.4cbff906.akpm@digeo.com> <18240000.1052924530@baldur.austin.ibm.com> <20030514103421.197f177a.akpm@digeo.com> <82240000.1052934152@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82240000.1052934152@baldur.austin.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what do you think of this untested fix?

I wonder if vm_file is valid for all nopage operations, I think it
should, and the i_mapping as well should always exist, but in the worst
case it shouldn't be too difficult to take care of special cases
(just checking if the new_page is reserved and if the vma is VM_SPECIAL)
would eliminate most issues, shall there be any.

--- x/fs/inode.c.~1~	2003-05-14 23:26:10.000000000 +0200
+++ x/fs/inode.c	2003-05-15 02:26:46.000000000 +0200
@@ -147,6 +147,8 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
 	INIT_LIST_HEAD(&inode->i_data.locked_pages);
+	inode->i_data.truncate_sequence1 = 0;
+	inode->i_data.truncate_sequence2 = 0;
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_dirty_buffers);
 	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
--- x/include/linux/fs.h.~1~	2003-05-14 23:26:19.000000000 +0200
+++ x/include/linux/fs.h	2003-05-15 02:35:57.000000000 +0200
@@ -421,6 +421,8 @@ struct address_space {
 	struct vm_area_struct	*i_mmap;	/* list of private mappings */
 	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
+	int			truncate_sequence1; /* serialize ->nopage against truncate */
+	int			truncate_sequence2; /* serialize ->nopage against truncate */
 	int			gfp_mask;	/* how to allocate the pages */
 };
 
--- x/mm/vmscan.c.~1~	2003-05-14 23:26:12.000000000 +0200
+++ x/mm/vmscan.c	2003-05-15 00:22:57.000000000 +0200
@@ -165,11 +165,10 @@ drop_pte:
 		goto drop_pte;
 
 	/*
-	 * Anonymous buffercache pages can be left behind by
+	 * Anonymous buffercache pages can't be left behind by
 	 * concurrent truncate and pagefault.
 	 */
-	if (page->buffers)
-		goto preserve;
+	BUG_ON(page->buffers);
 
 	/*
 	 * This is a dirty, swappable page.  First of all,
--- x/mm/memory.c.~1~	2003-05-14 23:26:19.000000000 +0200
+++ x/mm/memory.c	2003-05-15 02:37:08.000000000 +0200
@@ -1127,6 +1127,8 @@ int vmtruncate(struct inode * inode, lof
 	if (inode->i_size < offset)
 		goto do_expand;
 	i_size_write(inode, offset);
+	mapping->truncate_sequence1++;
+	wmb();
 	spin_lock(&mapping->i_shared_lock);
 	if (!mapping->i_mmap && !mapping->i_mmap_shared)
 		goto out_unlock;
@@ -1140,6 +1142,8 @@ int vmtruncate(struct inode * inode, lof
 out_unlock:
 	spin_unlock(&mapping->i_shared_lock);
 	truncate_inode_pages(mapping, offset);
+	wmb();
+	mapping->truncate_sequence2++;
 	goto out_truncate;
 
 do_expand:
@@ -1335,12 +1339,20 @@ static int do_no_page(struct mm_struct *
 {
 	struct page * new_page;
 	pte_t entry;
+	int truncate_sequence;
+	struct file *file;
+	struct address_space *mapping;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table, pmd, write_access, address);
 	spin_unlock(&mm->page_table_lock);
 	pte_kunmap(page_table);
 
+	file = vma->vm_file;
+	mapping = file->f_dentry->d_inode->i_mapping;
+	truncate_sequence = mapping->truncate_sequence2;
+	mb();
+
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
 
 	if (new_page == NULL)	/* no page was available -- SIGBUS */
@@ -1366,6 +1378,22 @@ static int do_no_page(struct mm_struct *
 
 	page_table = pte_offset_atomic(pmd, address);
 	spin_lock(&mm->page_table_lock);
+	mb(); /* spin_lock has inclusive semantics */
+	if (unlikely(truncate_sequence != mapping->truncate_sequence1)) {
+		struct inode *inode;
+
+		spin_unlock(&mm->page_table_lock);
+
+		/*
+		 * Don't worthless loop here forever overloading the cpu
+		 * until the truncate has completed.
+		 */
+		inode = mapping->host;
+		down(&inode->i_sem);
+		up(&inode->i_sem);
+
+		goto retry;
+	}
 
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
@@ -1388,6 +1416,7 @@ static int do_no_page(struct mm_struct *
 		set_pte(page_table, entry);
 	} else {
 		spin_unlock(&mm->page_table_lock);
+	retry:
 		pte_kunmap(page_table);
 		/* One of our sibling threads was faster, back out. */
 		page_cache_release(new_page);

Andrea
