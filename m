Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUFYR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUFYR6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbUFYR6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:58:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:44453 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266808AbUFYR6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:58:23 -0400
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040622120540.1bc8b6e3.akpm@osdl.org>
References: <1087837153.1512.176.camel@watt.suse.com>
	 <20040621171337.44d1b636.akpm@osdl.org>
	 <1087915399.1512.267.camel@watt.suse.com>
	 <20040622120540.1bc8b6e3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088186358.1589.124.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 13:59:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 15:05, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > On Mon, 2004-06-21 at 20:13, Andrew Morton wrote:
> > 
> > > It's super-improbable because we fault the source page in by hand in
> > > generic_file_aio_write_nolock() via fault_in_pages_readable().  Of course,
> > > that prefaulting isn't 100% reliable either, because the VM can come in and
> > > steal the page (or at least unmap its pte) before we get to doing the copy.
> > > 
> > > I think we can fix both problems by changing filemap_copy_from_user() and
> > > filemap_copy_from_user_iovec() to not fall back to kmap() - just fail the
> > > copy in some way if the atomic copy failed.  Then, in
> > > generic_file_aio_write_nolock(), do a zero-length ->commit_write(),
> > > put_page(), then go back and retry the whole thing, starting with
> > > fault_in_pages_readable().
> > 
> > Oh, just realized this will break our data=ordered setup.  prepare_write
> > is going to do things like allocating blocks in the file etc etc.  If we
> > close the transaction via commit_write(0 size) and crash, we'll leak.
> 
> OK, then just zero the pagecache page between `from' and `to' and call
> ->commit_write() with unmodified `from' and `to'?

copy_from_user and variants do the zeroing for us apparently.  IBM
managed to trigger this bug on ext3 as well (same test case as reiser),
no race is too small for the ppc to find ;)

Here's my current code against 2.6.7-mm2.  This has been lightly tested
but I expect there are problems lingering in there.

The basic idea looks like this:

1) change fault_in_pages_readable to return an error if __get_user
fails.  I'm not sure this is right, but wanted some way to avoid looping
forever in generic_file_write if something had gone wrong.

2) use inc/dec_preempt_count to trick __copy_from_user into avoiding the
page faults.  Hopefully there's a better way...

3) close the transaction, retry the prefault and do the write all over
again if we some pages disappeared after the prefault.

The patch tries to fix both reiserfs and generic_file_write.  It doesn't
fix the iovec case in generic_file_write, no sense in cluttering up the
patch with special cases until I've got the main cases right.

-chris

Index: linux.mm/fs/reiserfs/file.c
===================================================================
--- linux.mm.orig/fs/reiserfs/file.c	2004-06-25 13:31:12.695807448 -0400
+++ linux.mm/fs/reiserfs/file.c	2004-06-25 13:32:55.651155856 -0400
@@ -548,8 +548,35 @@ void reiserfs_unprepare_pages(struct pag
     }
 }
 
+static int prefault_pages_for_write(loff_t pos, const char *buf, 
+                                     size_t count)
+{
+    unsigned long off;
+    unsigned long bytes;
+    int status;
+
+    /* looks like fault_in_pages_readable only does 1 page, so lets make
+     * a loop
+     */
+    do {
+	off = (pos & (PAGE_CACHE_SIZE - 1));
+	bytes = PAGE_CACHE_SIZE - off;
+	if (bytes > count)
+	    bytes = count;
+	status = fault_in_pages_readable(buf, bytes);
+	if (status)
+	    return -EFAULT;
+        count -= bytes;
+	buf += bytes;
+	pos += bytes;
+    } while(count > 0);
+    return 0;
+}
+
 /* This function will copy data from userspace to specified pages within
-   supplied byte range */
+ * supplied byte range, this returns zero if all went well, or -EFAULT if
+ * it was unable to copy some pages
+ */
 int reiserfs_copy_from_user_to_file_region(
 				loff_t pos, /* In-file position */
 				int num_pages, /* Number of pages affected */
@@ -565,24 +592,36 @@ int reiserfs_copy_from_user_to_file_regi
     long page_fault=0; // status of copy_from_user.
     int i; // loop counter.
     int offset; // offset in page
+    int zero_all = 0;
 
     for ( i = 0, offset = (pos & (PAGE_CACHE_SIZE-1)); i < num_pages ; i++,offset=0) {
 	int count = min_t(int,PAGE_CACHE_SIZE-offset,write_bytes); // How much of bytes to write to this page
 	struct page *page=prepared_pages[i]; // Current page we process.
-
-	fault_in_pages_readable( buf, count);
+	char *kaddr;
 
 	/* Copy data from userspace to the current page */
-	kmap(page);
-	page_fault = __copy_from_user(page_address(page)+offset, buf, count); // Copy the data.
+	kaddr = kmap_atomic(page, KM_USER0);
+	if (zero_all)
+	    memset(kaddr+offset, 0, count);
+	else {
+	    /* we need to make sure we don't
+	     * take a page fault, otherwise we end up with a lock
+	     * inversion deadlock against the log.  inc_preempt_count
+	     * should do the trick.
+	     */
+	    inc_preempt_count();
+	    page_fault = __copy_from_user(kaddr+offset, buf, count);
+	    dec_preempt_count();
+	}
+	kunmap_atomic(kaddr, KM_USER0);
+
 	/* Flush processor's dcache for this page */
 	flush_dcache_page(page);
-	kunmap(page);
 	buf+=count;
 	write_bytes-=count;
 
 	if (page_fault)
-	    break; // Was there a fault? abort.
+	    zero_all = 1;
     }
 
     return page_fault?-EFAULT:0;
@@ -1182,6 +1221,7 @@ ssize_t reiserfs_file_write( struct file
 	int blocks_to_allocate; /* how much blocks we need to allocate for
 				   this iteration */
         
+	int page_fault;
         /*  (pos & (PAGE_CACHE_SIZE-1)) is an idiom for offset into a page of pos*/
 	num_pages = !!((pos+count) & (PAGE_CACHE_SIZE - 1)) + /* round up partial
 							  pages */
@@ -1240,6 +1280,15 @@ ssize_t reiserfs_file_write( struct file
 	/* First we correct our estimate of how many blocks we need */
 	reiserfs_release_claimed_blocks(inode->i_sb, (num_pages << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits)) - blocks_to_allocate );
 
+	/* prefault the pages now, this the last possible moment before
+	 * we start a transaction
+	 */
+	res = prefault_pages_for_write(pos, buf, write_bytes);
+	if (res) {
+	    reiserfs_unprepare_pages(prepared_pages, num_pages);
+	    break;
+	}
+
 	if ( blocks_to_allocate > 0) {/*We only allocate blocks if we need to*/
 	    /* Fill in all the possible holes and append the file if needed */
 	    res = reiserfs_allocate_blocks_for_region(&th, inode, pos, num_pages, write_bytes, prepared_pages, blocks_to_allocate);
@@ -1258,11 +1307,7 @@ ssize_t reiserfs_file_write( struct file
    crash */
 
 	/* Copy data from user-supplied buffer to file's pages */
-	res = reiserfs_copy_from_user_to_file_region(pos, num_pages, write_bytes, prepared_pages, buf);
-	if ( res ) {
-	    reiserfs_unprepare_pages(prepared_pages, num_pages);
-	    break;
-	}
+	page_fault = reiserfs_copy_from_user_to_file_region(pos, num_pages, write_bytes, prepared_pages, buf);
 
 	/* Send the pages to disk and unlock them. */
 	res = reiserfs_submit_file_region_for_write(&th, inode, pos, num_pages,
@@ -1270,10 +1315,16 @@ ssize_t reiserfs_file_write( struct file
 	if ( res )
 	    break;
 
-	already_written += write_bytes;
-	buf += write_bytes;
-	*ppos = pos += write_bytes;
-	count -= write_bytes;
+	/* if we get a page fault, leave all the counters alone.
+	 * we'll retry this exact same section of the write again
+	 * after closing and restarting the transaction
+	 */
+	if (!page_fault) {
+	    already_written += write_bytes;
+	    buf += write_bytes;
+	    *ppos = pos += write_bytes;
+	    count -= write_bytes;
+	}
 	balance_dirty_pages_ratelimited(inode->i_mapping);
     }
 
Index: linux.mm/include/linux/pagemap.h
===================================================================
--- linux.mm.orig/include/linux/pagemap.h	2004-06-25 13:31:17.193123752 -0400
+++ linux.mm/include/linux/pagemap.h	2004-06-25 13:33:52.648490944 -0400
@@ -219,7 +219,10 @@ static inline int fault_in_pages_writeab
 	return ret;
 }
 
-static inline void fault_in_pages_readable(const char __user *uaddr, int size)
+/*
+ * returns zero on success, -EFAULT on failure
+ */
+static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 {
 	volatile char c;
 	int ret;
@@ -230,8 +233,9 @@ static inline void fault_in_pages_readab
 
 		if (((unsigned long)uaddr & PAGE_MASK) !=
 				((unsigned long)end & PAGE_MASK))
-		 	__get_user(c, end);
+		 	ret = __get_user(c, end);
 	}
+	return ret;
 }
 
 #endif /* _LINUX_PAGEMAP_H */
Index: linux.mm/mm/filemap.c
===================================================================
--- linux.mm.orig/mm/filemap.c	2004-06-25 13:31:18.007000024 -0400
+++ linux.mm/mm/filemap.c	2004-06-25 13:31:25.115919304 -0400
@@ -1633,15 +1633,11 @@ filemap_copy_from_user(struct page *page
 	int left;
 
 	kaddr = kmap_atomic(page, KM_USER0);
+	inc_preempt_count();
 	left = __copy_from_user(kaddr + offset, buf, bytes);
+	dec_preempt_count();
 	kunmap_atomic(kaddr, KM_USER0);
 
-	if (left != 0) {
-		/* Do it the slow way */
-		kaddr = kmap(page);
-		left = __copy_from_user(kaddr + offset, buf, bytes);
-		kunmap(page);
-	}
 	return bytes - left;
 }
 
@@ -1933,7 +1929,9 @@ generic_file_aio_write_nolock(struct kio
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		status = fault_in_pages_readable(buf, bytes);
+		if (status < 0)
+			break;
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
@@ -1976,9 +1974,6 @@ generic_file_aio_write_nolock(struct kio
 							&iov_base, status);
 			}
 		}
-		if (unlikely(copied != bytes))
-			if (status >= 0)
-				status = -EFAULT;
 		unlock_page(page);
 		mark_page_accessed(page);
 		page_cache_release(page);


