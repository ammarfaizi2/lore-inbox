Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUIEJWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUIEJWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 05:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUIEJWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 05:22:54 -0400
Received: from holomorphy.com ([207.189.100.168]:34704 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266460AbUIEJW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 05:22:27 -0400
Date: Sun, 5 Sep 2004 02:22:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040905092216.GB3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
References: <20040905120147.A9202@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905120147.A9202@castle.nmd.msu.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 12:01:47PM +0400, Andrey Savochkin wrote:
> Let's suppose an mmap'ed (SHARED, RW) file has a hole.
> AFAICS, we allow to dirty the file pages without allocating the space for the
> hole - filemap_nopage just "reads" the page filling it with zeroes, and
> nothing is done about the on-disk data until writepage.
> So, if the page can't be written to disk (no space), the dirty data just
> stays in the pagecache.  The data can be read or seen via mmap, but it isn't
> and never be on disk.  The pagecache stays unsynchronized with the on-disk
> content forever.
> Is it the intended behavior?
> Shouldn't we call the filesystem to fill the hole at the moment of the first
> write access?

We would have to trap the first write access for that. What we do at
the moment is lazily collecting the results of write accesses a.k.a.
dirty bits from the pte data structures only under memory pressure.
i.e. mmap() IO is permabust, and fixing it is permavetoed. At the
moment the only protection faults the kernel understands are those
meant for copy-on-write; trapping these accesses involves understanding
that a protection fault may occur for other reasons.

So, in do_no_page() we now have:
   1558      * Note that if write_access is true, we either now have
   1559      * an exclusive copy of the page, or this is a shared mapping,
   1560      * so we can make it writable and dirty to avoid having to
   1561      * handle that later.
   1562      */
   1563     /* Only go through if we didn't race with anybody else... */
   1564     if (pte_none(*page_table)) {
   1565         if (!PageReserved(new_page))
   1566             ++mm->rss;
   1567         flush_icache_page(vma, new_page);
   1568         entry = mk_pte(new_page, vma->vm_page_prot);
   1569         if (write_access)
   1570             entry = maybe_mkwrite(pte_mkdirty(entry), vma);
   1571         set_pte(page_table, entry);

Here we would have to rearrange the pte setup, something vaguely like,
but not precisely like, the following snippet.

The basic idea is that you arrange for the event to occur in
do_no_page() when a read fault is taken on the thing, and then handle
it later in do_no_page(), or otherwise process it immediately if you
know it's happening right in do_no_page(). It probably makes sense to
do set_page_dirty() and other things around this kind of situation
as well, and the calling convention in this example may not be ideal.
At any rate, if the space reservation for the page may block, you'll
have to spin_unlock(&vma->vm_mm->page_table_lock) and also have to
pte_unmap(page_table) in enough_space() in this arrangement.

Of course, you won't be able to use this out of the box; you'll have
to implement enough_space() and possibly even add a new filesystem
method for enough_space() to call to do its ENOSPC detection. This
may also not interoperate particularly well with architecture support
code for non-i386 architectures. I see low enough odds of this kind of
affair getting merged that I don't really see a point in going through
with much of this myself, though if you yourself have a need, maybe
this tells you something useful enough for you to carry out the rest.

There was some kind of talk of an alternative to be carried out at
mmap() -time, but as of yet there's been no coherent explanation of
how it's possible for such half measures to cope with the realities
of block indexing metadata or space consumers competing with mmap().


-- wli

--- mm3-2.6.9-rc1/mm/memory.c	2004-09-03 03:06:24.000000000 -0700
+++ mmap-io-2.6.9-rc1-mm3/mm/memory.c	2004-09-05 02:19:24.469265712 -0700
@@ -1056,6 +1056,19 @@ static int do_wp_page(struct mm_struct *
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
 
+	if (vma->vm_flags & VM_WRITE) {
+		int ret;
+		if (enough_space(vma, address, pte, &page_table)) {
+			ret = VM_FAULT_MINOR;
+			pte = pte_mkwrite(pte_mkyoung(pte_mkdirty(pte))));
+			set_pte(page_table, pte);
+		} else
+			ret = VM_FAULT_SIGBUS;
+		pte_unmap(page_table);
+		spin_unlock(&mm->page_table_lock);
+		return ret;
+	}
+
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
 		 * This should really halt the system so it can be debugged or
@@ -1562,13 +1575,24 @@ do_no_page(struct mm_struct *
 	 */
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
-		if (!PageReserved(new_page))
-			++mm->rss;
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		else
+			entry = pte_wrprotect(pte);
+		if (!write_access ||
+				enough_space(vma, address, pte, &page_table))
+			set_pte(page_table, entry);
+		else {
+			spin_unlock(&mm->page_table_lock);
+			pte_unmap(page_table);
+			ret = VM_FAULT_SIGBUS;
+			page_cache_release(new_page);
+			goto out;
+		}
+		if (!PageReserved(new_page))
+			++mm->rss;
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
