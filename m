Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUCRUmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCRUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:42:05 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:56875 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262942AbUCRUlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:41:50 -0500
Date: Thu, 18 Mar 2004 20:41:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318022201.GE2113@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403181928210.16385-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrea Arcangeli wrote:

> This implements anon_vma for the anonymous memory unmapping and objrmap
> for the file mappings, effectively removing rmap completely and
> replacing it with more efficient algorithms (in terms of memory
> utilization and cpu cost for the fast paths).

There's a lot about this that I like.

I think your use of anonymous vm_pgoff is brilliant.  I spent the
afternoon vacillating between believing it does the (mremap move)
job so smoothly we don't notice, and believing it's all a con trick
and does nothing at all.  Currently I believe it does the job!

And very satisfying how anon and obj converge in page_referenced
and try_to_unmap: although they converge in my version too, I still
have to use find_vma on anons at the inner level, yours much nicer.

I think the winning answer will actually lie between yours and mine:
the anon vmas linked into one tree belonging to the whole fork group.
Some of the messier aspects of your design come from dealing with the
vmas separately, with merging issues currently unresolved.  A lot of
that goes away if you lump all the anon vmas of the same fork group
into the same list.  Yes, of course the _list_ would be slower to
search; but once we have the right tree structure for the obj vmas,
I believe it should apply just as effectively to the anon vmas.

I am disappointed that you're persisting with that "as" union: many
source files remain to be converted to page->as.mapping, and I don't
think it's worth it at all.  mm/objrmap.c is the _only_ file needing
a cast there for the anon case, please don't demand edits of so many
filesystems and others, not at this stage anyway.  You've been very
diligent about inserting BUG_ONs, but filesystems deal with their own
pages, I don't think it's necessary to impose such changes all over.

And I still think you're making the wrong choice on page_mapping,
to supply &swapper_space if PageSwapCache.  I know you disapprove
of the "if (PageSwapCache(page)) blk_run_queues();" that ends up
in my sync_page(), but mostly you're imposing an irrelevant test
in a common inline function: you'll find _very_ few places really
find the swapper_space mapping useful, I'd rather they be explicit.

I've not reviewed thoroughly at all, was concentrating on bringing
my anonmm version up to date.  Still got to add my comment headers,
will post later without mremap-move and non-linear solutions.

A few minor patches to yours below.

A couple of filesystems history has left in my standard .config but
apparently not in yours.  Some over-enthusiastic BUG_ONs which will
trigger when shmem_writepage swizzles a tmpfs page to swap at the
wrong moment (I saw the filemap.c in practice; I think truncate.c
ones could hit too; didn't search very hard for others).

And impressive though your saving on page tables was ;)
PageTables:          0 kB
a patch to correct that.  Yes, I've left inc out of pte_offset_kernel:
should it have been there anyway? and it's not clear to me whether ppc
and ppc64 can manage an early per-cpu increment.  You'll find you've
broken ppc and ppc64, which have grown to use the pgtable rmap stuff
for themselves, you'll probably want to grab some of my arch patches.

Hugh

--- 26051a1/fs/cramfs/inode.c	2004-03-17 22:02:53.000000000 +0000
+++ 26051A1/fs/cramfs/inode.c	2004-03-18 18:57:15.784636856 +0000
@@ -422,7 +422,7 @@ static struct dentry * cramfs_lookup(str
 
 static int cramfs_readpage(struct file *file, struct page * page)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = page->as.mapping->host;
 	u32 maxblock, bytes_filled;
 	void *pgdata;
 
--- 26051a1/fs/sysv/dir.c	2004-03-17 22:02:53.000000000 +0000
+++ 26051A1/fs/sysv/dir.c	2004-03-18 18:57:15.793635488 +0000
@@ -39,10 +39,10 @@ static inline unsigned long dir_pages(st
 
 static int dir_commit_chunk(struct page *page, unsigned from, unsigned to)
 {
-	struct inode *dir = (struct inode *)page->mapping->host;
+	struct inode *dir = (struct inode *)page->as.mapping->host;
 	int err = 0;
 
-	page->mapping->a_ops->commit_write(NULL, page, from, to);
+	page->as.mapping->a_ops->commit_write(NULL, page, from, to);
 	if (IS_DIRSYNC(dir))
 		err = write_one_page(page, 1);
 	else
@@ -224,7 +224,7 @@ got_it:
 	from = (char*)de - (char*)page_address(page);
 	to = from + SYSV_DIRSIZE;
 	lock_page(page);
-	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	err = page->as.mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
 	memcpy (de->name, name, namelen);
@@ -244,7 +244,7 @@ out_unlock:
 
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = page->as.mapping;
 	struct inode *inode = (struct inode*)mapping->host;
 	char *kaddr = (char*)page_address(page);
 	unsigned from = (char*)de - kaddr;
@@ -346,13 +346,13 @@ not_empty:
 void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	struct inode *inode)
 {
-	struct inode *dir = (struct inode*)page->mapping->host;
+	struct inode *dir = (struct inode*)page->as.mapping->host;
 	unsigned from = (char *)de-(char*)page_address(page);
 	unsigned to = from + SYSV_DIRSIZE;
 	int err;
 
 	lock_page(page);
-	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	err = page->as.mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		BUG();
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
--- 26051a1/mm/filemap.c	2004-03-18 11:08:59.000000000 +0000
+++ 26051A1/mm/filemap.c	2004-03-18 18:57:15.793635488 +0000
@@ -460,7 +460,6 @@ repeat:
 
 			/* Has the page been truncated while we slept? */
 			BUG_ON(PageAnon(page));
-			BUG_ON(PageSwapCache(page));
 			if (page->as.mapping != mapping || page->index != offset) {
 				unlock_page(page);
 				page_cache_release(page);
--- 26051a1/mm/memory.c	2004-03-18 11:08:59.000000000 +0000
+++ 26051A1/mm/memory.c	2004-03-18 18:57:15.793635488 +0000
@@ -104,6 +104,7 @@ static inline void free_one_pmd(struct m
 	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
+	dec_page_state(nr_page_table_pages);
 	pte_free_tlb(tlb, page);
 }
 
@@ -162,6 +163,7 @@ pte_t fastcall * pte_alloc_map(struct mm
 			pte_free(new);
 			goto out;
 		}
+		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 out:
--- 26051a1/mm/truncate.c	2004-03-18 11:08:59.000000000 +0000
+++ 26051A1/mm/truncate.c	2004-03-18 18:57:15.793635488 +0000
@@ -48,7 +48,6 @@ static void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	BUG_ON(PageSwapCache(page));
 	if (page->as.mapping != mapping)
 		return;
 
@@ -73,7 +72,6 @@ static int
 invalidate_complete_page(struct address_space *mapping, struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	BUG_ON(PageSwapCache(page));
 	if (page->as.mapping != mapping)
 		return 0;
 
@@ -264,7 +262,6 @@ void invalidate_inode_pages2(struct addr
 
 			lock_page(page);
 			BUG_ON(PageAnon(page));
-			BUG_ON(PageSwapCache(page));
 			if (page->as.mapping == mapping) {	/* truncate race? */
 				wait_on_page_writeback(page);
 				next = page->index + 1;

