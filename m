Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTFAMQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 08:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTFAMQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 08:16:25 -0400
Received: from [217.201.16.8] ([217.201.16.8]:6528 "EHLO x30.random")
	by vger.kernel.org with ESMTP id S264546AbTFAMQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 08:16:16 -0400
Date: Sun, 1 Jun 2003 14:22:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@digeo.com, hch@infradead.org
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030601122200.GB1455@x30.local>
References: <20030530164150.A26766@us.ibm.com> <20030531104617.J672@nightmaster.csn.tu-chemnitz.de> <20030531234816.GB1408@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20030531234816.GB1408@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

On Sat, May 31, 2003 at 04:48:16PM -0700, Paul E. McKenney wrote:
> On Sat, May 31, 2003 at 10:46:18AM +0200, Ingo Oeser wrote:
> > On Fri, May 30, 2003 at 04:41:50PM -0700, Paul E. McKenney wrote:
> > > -struct page *
> > > -ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int no_share)
> > > +int
> > > +ia32_install_shared_page (struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd)
> > 
> > Why do we always pass mm and vma down, even if vma->vm_mm
> > contains the mm, where the vma belongs to? Is the connection
> > between a vma and its mm also protected by the mmap_sem?
> > 
> > Is this really necessary or an oversight and we waste a lot of
> > stack in a lot of places?
> > 
> > If we just need it for accounting: We need current->mm, if we
> > need it to locate the next vma relatively to this vma, vma->vm_mm
> > is the one.
> 
> Interesting point.  The original do_no_page() API does this
> as well:
> 
> 	static int
> 	do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
> 		   unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
> 
> As does do_anonymous_page().  I assumed that there were corner
> cases where this one-to-one correspondence did not exist, but
> must confess that I did not go looking for them.
> 
> Or is this a performance issue, avoiding a dereference and
> possible cache miss?

it's a performance microoptimization issue (the stack memory overhead is
not significant), each new parameter to those calls will slowdown the
kernel, especially with the x86 calling convetions it will hurt more
than with other archs.  Jeff did something similar for UML (dunno if he
also can use vma->vm_mm, anyways I #ifdeffed it out enterely for non UML
compiles for exact this reason that I can't slowdown the whole
production host kernel just for the uml compile) then there's also the
additional extern call. So basically the patch would hurt until there
are active users.

But the real question here I guess is: why should a distributed
filesystem need to install the pte by itself?

The memory coherency with distributed shared memory (i.e. MAP_SHARED
against truncate with MAP_SHARED and truncate running on different boxes
on a DFS) is a generic problem (most of the time using the same
algorithm too), as such  I believe the infrastructure and logics to keep
it coherent could make sense to be a common code functionalty.

And w/o proper high level locking, the non distributed filesystems will
corrupt the VM too with truncate against nopage. I already fixed this in
my tree. (see the attachment) So I wonder if the fixes could be shared.
I mean, you definitely need my fixes even when using the DFS on a
isolated box, and if you don't need them while using the fs locally, it
means we're duplicating effort somehow.

Since I don't see the users of the new hook, it's a bit hard to judje if
the duplication is legitimate or not. So overall I'd agree with Andrew
that to judje the patch it'd make sense to see (or know more) about the
users of the hook too.

as for the anon memory, yes, it's probably more efficient and cleaner to
have it be a nopage callback too, the double branch is probably more
costly than the duplicated unlock anyways. However it has nothing to do
with these issues, so I recommend to keep it separated from the DFS
patches (for readibility). (it can't have anything to do with DFS since
that memory is anon local to the box [if not using openmosix but that's
a different issue ;) ])

thanks,
Andrea

--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=9999_truncate-nopage-race-1

diff -urNp --exclude CVS --exclude BitKeeper xx-ref/fs/inode.c xx/fs/inode.c
--- xx-ref/fs/inode.c	2003-05-27 04:54:24.000000000 +0200
+++ xx/fs/inode.c	2003-05-27 04:54:30.000000000 +0200
@@ -147,6 +147,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
 	INIT_LIST_HEAD(&inode->i_data.locked_pages);
+	frlock_init(&inode->i_data.truncate_lock);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_dirty_buffers);
 	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/include/linux/fs.h xx/include/linux/fs.h
--- xx-ref/include/linux/fs.h	2003-05-27 04:54:28.000000000 +0200
+++ xx/include/linux/fs.h	2003-05-27 04:54:52.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/cache.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/frlock.h>
 
 #include <asm/atomic.h>
 #include <asm/bitops.h>
@@ -422,6 +423,7 @@ struct address_space {
 	struct vm_area_struct	*i_mmap;	/* list of private mappings */
 	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
+	frlock_t		truncate_lock; /* serialize ->nopage against truncate */
 	int			gfp_mask;	/* how to allocate the pages */
 };
 
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/mm/memory.c xx/mm/memory.c
--- xx-ref/mm/memory.c	2003-05-27 04:54:28.000000000 +0200
+++ xx/mm/memory.c	2003-05-27 04:54:30.000000000 +0200
@@ -1127,6 +1127,7 @@ int vmtruncate(struct inode * inode, lof
 	if (inode->i_size < offset)
 		goto do_expand;
 	i_size_write(inode, offset);
+	fr_write_lock(&mapping->truncate_lock);
 	spin_lock(&mapping->i_shared_lock);
 	if (!mapping->i_mmap && !mapping->i_mmap_shared)
 		goto out_unlock;
@@ -1140,6 +1141,7 @@ int vmtruncate(struct inode * inode, lof
 out_unlock:
 	spin_unlock(&mapping->i_shared_lock);
 	truncate_inode_pages(mapping, offset);
+	fr_write_unlock(&mapping->truncate_lock);
 	goto out_truncate;
 
 do_expand:
@@ -1335,12 +1337,19 @@ static int do_no_page(struct mm_struct *
 {
 	struct page * new_page;
 	pte_t entry;
+	unsigned truncate_sequence;
+	struct file *file;
+	struct address_space *mapping;
 
 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table, pmd, write_access, address);
 	spin_unlock(&mm->page_table_lock);
 	pte_kunmap(page_table);
 
+	file = vma->vm_file;
+	mapping = file->f_dentry->d_inode->i_mapping;
+	truncate_sequence = fr_read_begin(&mapping->truncate_lock);
+
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
 
 	if (new_page == NULL)	/* no page was available -- SIGBUS */
@@ -1366,6 +1375,21 @@ static int do_no_page(struct mm_struct *
 
 	page_table = pte_offset_atomic(pmd, address);
 	spin_lock(&mm->page_table_lock);
+	if (unlikely(truncate_sequence != fr_read_end(&mapping->truncate_lock))) {
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
@@ -1388,6 +1412,7 @@ static int do_no_page(struct mm_struct *
 		set_pte(page_table, entry);
 	} else {
 		spin_unlock(&mm->page_table_lock);
+	retry:
 		pte_kunmap(page_table);
 		/* One of our sibling threads was faster, back out. */
 		page_cache_release(new_page);
diff -urNp --exclude CVS --exclude BitKeeper xx-ref/mm/vmscan.c xx/mm/vmscan.c
--- xx-ref/mm/vmscan.c	2003-05-27 04:54:25.000000000 +0200
+++ xx/mm/vmscan.c	2003-05-27 04:54:30.000000000 +0200
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

--eRtJSFbw+EEWtPj3--
