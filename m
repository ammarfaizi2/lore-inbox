Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWCJAyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWCJAyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWCJAy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:54:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26567 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932376AbWCJAyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:54:25 -0500
Date: Fri, 10 Mar 2006 11:50:20 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060310005020.GF1135@frodo>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309231422.GD1135@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 10:14:22AM +1100, Nathan Scott wrote:
> On Thu, Mar 09, 2006 at 10:42:19PM +0000, Christoph Hellwig wrote:
> > On Fri, Mar 10, 2006 at 09:30:42AM +1100, Nathan Scott wrote:
> > > Not for reads AFAICT - __generic_file_aio_read + own-locking
> > > should always have released i_mutex at the end of the direct
> > > read - are you thinking of writes or have I missed something?
> > 
> > if an error occurs before a_ops->direct_IO is called __generic_file_aio_read
> > will return with i_mutex still locked.  Note that checking for negative
> > return values is not enough as __blockdev_direct_IO can return errors
> > aswell.
> 
> *groan* - right you are.  Another option may be to have the
> generic dio+own-locking case reacquire i_mutex if it drops
> it, before returning... thoughts?  Seems alot less invasive
> than the filemap.c code dup'ing thing.

Something like this (works OK for me)...

cheers.

-- 
Nathan


Index: 2.6.x-xfs/fs/direct-io.c
===================================================================
--- 2.6.x-xfs.orig/fs/direct-io.c
+++ 2.6.x-xfs/fs/direct-io.c
@@ -1155,15 +1155,16 @@ direct_io_worker(int rw, struct kiocb *i
  * For writes, i_mutex is not held on entry; it is never taken.
  *
  * DIO_LOCKING (simple locking for regular files)
- * For writes we are called under i_mutex and return with i_mutex held, even though
- * it is internally dropped.
+ * For writes we are called under i_mutex and return with i_mutex held, even
+ * though it is internally dropped.
  * For reads, i_mutex is not held on entry, but it is taken and dropped before
  * returning.
  *
  * DIO_OWN_LOCKING (filesystem provides synchronisation and handling of
  *	uninitialised data, allowing parallel direct readers and writers)
  * For writes we are called without i_mutex, return without it, never touch it.
- * For reads, i_mutex is held on entry and will be released before returning.
+ * For reads we are called under i_mutex and return with i_mutex held, even
+ * though it may be internally dropped.
  *
  * Additional i_alloc_sem locking requirements described inline below.
  */
@@ -1182,7 +1183,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	ssize_t retval = -EINVAL;
 	loff_t end = offset;
 	struct dio *dio;
-	int reader_with_isem = (rw == READ && dio_lock_type == DIO_OWN_LOCKING);
+	int release_i_mutex = 0;
+	int acquire_i_mutex = 0;
 
 	if (rw & WRITE)
 		current->flags |= PF_SYNCWRITE;
@@ -1225,7 +1227,6 @@ __blockdev_direct_IO(int rw, struct kioc
 	 *	writers need to grab i_alloc_sem only (i_mutex is already held)
 	 * For regular files using DIO_OWN_LOCKING,
 	 *	neither readers nor writers take any locks here
-	 *	(i_mutex is already held and release for writers here)
 	 */
 	dio->lock_type = dio_lock_type;
 	if (dio_lock_type != DIO_NO_LOCKING) {
@@ -1236,7 +1237,7 @@ __blockdev_direct_IO(int rw, struct kioc
 			mapping = iocb->ki_filp->f_mapping;
 			if (dio_lock_type != DIO_OWN_LOCKING) {
 				mutex_lock(&inode->i_mutex);
-				reader_with_isem = 1;
+				release_i_mutex = 1;
 			}
 
 			retval = filemap_write_and_wait_range(mapping, offset,
@@ -1248,7 +1249,7 @@ __blockdev_direct_IO(int rw, struct kioc
 
 			if (dio_lock_type == DIO_OWN_LOCKING) {
 				mutex_unlock(&inode->i_mutex);
-				reader_with_isem = 0;
+				acquire_i_mutex = 1;
 			}
 		}
 
@@ -1269,11 +1270,13 @@ __blockdev_direct_IO(int rw, struct kioc
 				nr_segs, blkbits, get_blocks, end_io, dio);
 
 	if (rw == READ && dio_lock_type == DIO_LOCKING)
-		reader_with_isem = 0;
+		release_i_mutex = 0;
 
 out:
-	if (reader_with_isem)
+	if (release_i_mutex)
 		mutex_unlock(&inode->i_mutex);
+	else if (acquire_i_mutex)
+		mutex_lock(&inode->i_mutex);
 	if (rw & WRITE)
 		current->flags &= ~PF_SYNCWRITE;
 	return retval;
