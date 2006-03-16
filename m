Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWCPQcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCPQcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCPQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:32:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:31910 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932133AbWCPQcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:32:51 -0500
Subject: Re: [RFC PATCH] Make use of PageMappedToDisk() to improve ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060315163119.5d5efe28.akpm@osdl.org>
References: <1142457602.21442.114.camel@dyn9047017100.beaverton.ibm.com>
	 <20060315163119.5d5efe28.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 08:34:32 -0800
Message-Id: <1142526873.21442.147.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 16:31 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > Here is my first pass at making use of PageMappedToDisk() to avoid
> > ext3 prepare_write/commit_write handling + journaling.
..

> I worry about this:
> 
> > ===================================================================
> > --- linux-2.6.16-rc6.orig/fs/buffer.c	2006-03-11 14:12:55.000000000 -0800
> > +++ linux-2.6.16-rc6/fs/buffer.c	2006-03-15 13:05:26.000000000 -0800
> > @@ -2051,8 +2051,10 @@ static int __block_commit_write(struct i
> >  	 * the next read(). Here we 'discover' whether the page went
> >  	 * uptodate as a result of this (potentially partial) write.
> >  	 */
> > -	if (!partial)
> > +	if (!partial) {
> >  		SetPageUptodate(page);
> > +		SetPageMappedToDisk(page);
> > +	}
> >  	return 0;
> >  }
> 
> We're setting SetPageMappedToDisk here if all the buffers are uptodate. 
> But that doesn't mean they're mapped to disk!  They could be over file
> holes and they were brought uptodate with memset.

You are correct.Initially, I coded it to set PageMapped() in
block_prepare_write() and then realized that __block_commit_write()
walks all the buffers anyway - so I moved it there. New patch
should handle it, correctly.

> 
> Are you really sure that we're clearing PageMappedToDisk in all the right
> places?  Truncate...

I think so, Truncate is handled. Are there others ?

> 
> > Index: linux-2.6.16-rc6/fs/ext3/inode.c
> > ===================================================================
> > --- linux-2.6.16-rc6.orig/fs/ext3/inode.c	2006-03-11 14:12:55.000000000 -0800
> > +++ linux-2.6.16-rc6/fs/ext3/inode.c	2006-03-15 13:09:14.000000000 -0800
> > @@ -999,6 +999,13 @@ static int ext3_prepare_write(struct fil
> >  	handle_t *handle;
> >  	int retries = 0;
> >  
> > +
> > +	/*
> > + 	 * If the page is already mapped to disk and we are not
> > +	 * journalling the data - there is nothing to do.
> > +	 */
> > +	if (PageMappedToDisk(page) && !ext3_should_journal_data(inode))
> > +		return 0;
> 
> Yipes.  So we're not attaching the buffers to the journal at all in this
> case.  So if nothing has been physically written to the disk yet, a
> crash+recovery will expose unwritten-to disk blocks.
> 
> OK, that might not happen with this patch because __block_commit_write() is
> presently checking BH_uptodate rather than BH_mapped.  And a file hole will
> still be a file hole after the crash+recovery.  But if
> __block_commit_write() is changed to test buffer_mapped(), I _think_ we can
> leak uninitialised data on recovery.
> 
> Or maybe you thought all this through and didn't tell me :(

Well, I thought about this for few days. Here is my reasoning (which
verified with debugfs).

- If we need block allocation - my patches doesn't change the current
code (it still creates a transaction, allocate blocks, updates metadata,
page buffers get added to the transaction).

- If we don't need block allocation - there are no "metadata" updates.
So there is no transaction created. So there is no way/need to attach
buffers to the transaction. Isn't it ? What is the transaction here ?
(I looked through "debugfs" - we don't have anything in the log,
incase of a re-write). What am I missing ?

> Either way, this optimisation (not attaching the ordered-mode buffers to
> the transaction) worries me.  It's largely unrelated to the
> PageMappedToDisk() optimisation and should be coded and thought about
> separately.  It's a significant change in ordered-mode ext3 semantics.

Again, it should change any semantics (atleast intentionally). If you
really prefer not touching transactions, I can redo it - but I really
really want to figure out why we need it (as this is important for
me to do writepages() support).

Thanks,
Badari

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.16-rc6/fs/buffer.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/buffer.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/fs/buffer.c	2006-03-16 08:22:37.000000000 -0800
@@ -2029,6 +2029,7 @@ static int __block_commit_write(struct i
 	int partial = 0;
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
+	int fullymapped = 1;
 
 	blocksize = 1 << inode->i_blkbits;
 
@@ -2043,6 +2044,8 @@ static int __block_commit_write(struct i
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
+		if (!buffer_mapped(bh))
+			fullymapped = 0;
 	}
 
 	/*
@@ -2053,6 +2056,9 @@ static int __block_commit_write(struct i
 	 */
 	if (!partial)
 		SetPageUptodate(page);
+
+	if (fullymapped)
+		SetPageMappedToDisk(page);
 	return 0;
 }
 
Index: linux-2.6.16-rc6/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc6.orig/fs/ext3/inode.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/fs/ext3/inode.c	2006-03-15 13:30:04.000000000 -0800
@@ -999,6 +999,12 @@ static int ext3_prepare_write(struct fil
 	handle_t *handle;
 	int retries = 0;
 
+	/*
+ 	 * If the page is already mapped to disk and we are not
+	 * journalling the data - there is nothing to do.
+	 */
+	if (PageMappedToDisk(page) && !ext3_should_journal_data(inode))
+		return 0;
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
 	if (IS_ERR(handle)) {
@@ -1059,8 +1065,14 @@ static int ext3_ordered_commit_write(str
 	struct inode *inode = page->mapping->host;
 	int ret = 0, ret2;
 
-	ret = walk_page_buffers(handle, page_buffers(page),
-		from, to, NULL, ext3_journal_dirty_data);
+	/*
+	 * If the page is already mapped to disk, we won't have
+	 * a handle - which means no metadata updates are needed.
+	 * So, no need to add buffers to the transaction.
+	 */
+	if (handle)
+		ret = walk_page_buffers(handle, page_buffers(page),
+			from, to, NULL, ext3_journal_dirty_data);
 
 	if (ret == 0) {
 		/*
@@ -1075,9 +1087,11 @@ static int ext3_ordered_commit_write(str
 			EXT3_I(inode)->i_disksize = new_i_size;
 		ret = generic_commit_write(file, page, from, to);
 	}
-	ret2 = ext3_journal_stop(handle);
-	if (!ret)
-		ret = ret2;
+	if (handle) {
+		ret2 = ext3_journal_stop(handle);
+		if (!ret)
+			ret = ret2;
+	}
 	return ret;
 }
 
@@ -1098,9 +1112,11 @@ static int ext3_writeback_commit_write(s
 	else
 		ret = generic_commit_write(file, page, from, to);
 
-	ret2 = ext3_journal_stop(handle);
-	if (!ret)
-		ret = ret2;
+	if (handle) {
+		ret2 = ext3_journal_stop(handle);
+		if (!ret)
+			ret = ret2;
+	}
 	return ret;
 }
 
@@ -1278,6 +1294,14 @@ static int ext3_ordered_writepage(struct
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
+	/*
+	 * If the page is mapped to disk, just do the IO
+	 */
+	if (PageMappedToDisk(page)) {
+		ret = block_write_full_page(page, ext3_get_block, wbc);
+		goto out;
+	}
+
 	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
 
 	if (IS_ERR(handle)) {
@@ -1318,6 +1342,7 @@ static int ext3_ordered_writepage(struct
 	err = ext3_journal_stop(handle);
 	if (!ret)
 		ret = err;
+out:
 	return ret;
 
 out_fail:
@@ -1337,10 +1362,13 @@ static int ext3_writeback_writepage(stru
 	if (ext3_journal_current_handle())
 		goto out_fail;
 
-	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_fail;
+	if (!PageMappedToDisk(page)) {
+		handle = ext3_journal_start(inode,
+				ext3_writepage_trans_blocks(inode));
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_fail;
+		}
 	}
 
 	if (test_opt(inode->i_sb, NOBH))
@@ -1348,9 +1376,11 @@ static int ext3_writeback_writepage(stru
 	else
 		ret = block_write_full_page(page, ext3_get_block, wbc);
 
-	err = ext3_journal_stop(handle);
-	if (!ret)
-		ret = err;
+	if (handle) {
+		err = ext3_journal_stop(handle);
+		if (!ret)
+			ret = err;
+	}
 	return ret;
 
 out_fail:


