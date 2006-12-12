Return-Path: <linux-kernel-owner+w=401wt.eu-S932236AbWLLUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWLLUOf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWLLUOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:14:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:42217 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbWLLUOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:14:34 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitriy Monakhov <dmonakhov@openvz.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>, <devel@openvz.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH]  incorrect error handling inside generic_file_direct_write
References: <87k60y1rq4.fsf@sw.ru> <20061211124052.144e69a0.akpm@osdl.org>
	<87bqm9tie3.fsf@sw.ru> <20061212015232.eacfbb46.akpm@osdl.org>
	<87psapz1zr.fsf@sw.ru> <20061212024027.6c2a79d3.akpm@osdl.org>
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Wed, 13 Dec 2006 02:14:18 +0300
In-Reply-To: <20061212024027.6c2a79d3.akpm@osdl.org> (Andrew Morton's message of "Tue, 12 Dec 2006 02:40:27 -0800")
Message-ID: <87y7pcn1v9.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 12 Dec 2006 16:18:32 +0300
> Dmitriy Monakhov <dmonakhov@sw.ru> wrote:
>
>> >> but according to filemaps locking rules: mm/filemap.c:77
>> >>  ..
>> >>  *  ->i_mutex			(generic_file_buffered_write)
>> >>  *    ->mmap_sem		(fault_in_pages_readable->do_page_fault)
>> >>  ..
>> >> I'm confused a litle bit, where is the truth? 
>> >
>> > xfs_write() calls generic_file_direct_write() without taking i_mutex for
>> > O_DIRECT writes.
>> Yes, but my quastion is about __generic_file_aio_write_nolock().
>> As i understand _nolock sufix means that i_mutex was already locked 
>> by caller, am i right ?
>
> Nope.  It just means that __generic_file_aio_write_nolock() doesn't take
> the lock.  We don't assume or require that the caller took it.  For example
> the raw driver calls generic_file_aio_write_nolock() without taking
> i_mutex.  Raw isn't relevant to the problem (although ocfs2 might be).  But
> we cannot assume that all callers have taken i_mutex, I think.
>
> I guess we can make that a rule (document it, add
> BUG_ON(!mutex_is_locked(..)) if it isn't a blockdev) if needs be.  After
> really checking that this matches reality for all callers.
I've checked generic_file_aio_write_nolock() callers for non blockdev.
Only ocfs2 call it explicitly, and do it under i_mutex.
So we need to do: 
1) Change wrong comments.
2) Add BUG_ON(!mutex_is_locked(..)) for non blkdev.
3) Invoke vmtruncate only for non blkdev.

Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-------

--=-=-=
Content-Disposition: inline; filename=direct-io-fix.patch

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b84dc8..540ef5e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2046,8 +2046,8 @@ generic_file_direct_write(struct kiocb *
 	/*
 	 * Sync the fs metadata but not the minor inode changes and
 	 * of course not the data as we did direct DMA for the IO.
-	 * i_mutex is held, which protects generic_osync_inode() from
-	 * livelocking.
+	 * i_mutex may not being held, if so some specific locking
+	 * ordering must protect generic_osync_inode() from livelocking.
 	 */
 	if (written >= 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		int err = generic_osync_inode(inode, mapping, OSYNC_METADATA);
@@ -2282,6 +2282,17 @@ __generic_file_aio_write_nolock(struct k
 
 		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
 							ppos, count, ocount);
+		/*
+		 * If host is not S_ISBLK generic_file_direct_write() may 
+		 * have instantiated a few blocks outside i_size  files
+		 * Trim these off again.
+		 */
+		if (unlikely(written < 0) && !S_ISBLK(inode->i_mode)) {
+			loff_t isize = i_size_read(inode);
+			if (pos + count > isize)
+				vmtruncate(inode, isize);
+		}
+
 		if (written < 0 || written == count)
 			goto out;
 		/*
@@ -2344,6 +2355,13 @@ ssize_t generic_file_aio_write_nolock(st
 	ssize_t ret;
 
 	BUG_ON(iocb->ki_pos != pos);
+	/*
+	 *  generic_file_buffered_write() may be called inside 
+	 *  __generic_file_aio_write_nolock() even in case of
+	 *  O_DIRECT for non S_ISBLK files. So i_mutex must be held.
+	 */
+	if (!S_ISBLK(inode->i_mode))
+		BUG_ON(!mutex_is_locked(&inode->i_mutex));
 
 	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs,
 			&iocb->ki_pos);
@@ -2386,8 +2404,8 @@ ssize_t generic_file_aio_write(struct ki
 EXPORT_SYMBOL(generic_file_aio_write);
 
 /*
- * Called under i_mutex for writes to S_ISREG files.   Returns -EIO if something
- * went wrong during pagecache shootdown.
+ * May be called without i_mutex for writes to S_ISREG files.
+ * Returns -EIO if something went wrong during pagecache shootdown.
  */
 static ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,

--=-=-=--

