Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUELDbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUELDbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbUELDbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:31:48 -0400
Received: from thunk.org ([140.239.227.29]:45734 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264963AbUELDbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:31:43 -0400
Date: Tue, 11 May 2004 23:31:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [CHECKER] e2fsck writes out blocks out of order, causing root dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34)
Message-ID: <20040512033110.GC4245@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
	madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
References: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:55:30PM -0700, Junfeng Yang wrote:
> 
> We got a warning that the filesystem was in a inconsistent state when:
> 1. created a crashed disk image
> 2. ran fsck over the image and then crash fsck at certain point
> 3. re-ran fsck.
> 
> We got the crashed disk image by making 2 directories under / then runing
> kjournald to commit.  once we saw the commit block was written to disk, we
> crashed the experimental disk (a virtual ram disk), prior to actual disk
> writes.

I'm not sure how this is really a [CHECKER] issue per se, since it
isn't a kernel issue and you didn't really find this via using the a
hacked-up gcc compiler, did you?  

In any case, though, thanks for pointing this out.

> We then ran fsck over the crashed disk image.  We interrupted fsck after
>  the journal super block was reset on disk (fsck will reset the journal
> superblock once it is done replaying).  

I assume you did this by setting a breakpoint somewhere inside e2fsck?
Where, specifically?  I want to make sure I can replicate this test
case exactly as you did, at least under gdb control.  Later I'll think
about some way of automating this for the e2fsck regression test
suite....

> We checked ext3 on linux 2.4.19, with e2fsprogs-1.34.  The crashed disk
> image can be obtained from http://keeda.stanford.edu/~junfeng/exp_disk.tgz

Assuming I can automate this for a regression test suite, may I have
permission to include a compressed version of this crashed disk image
in e2fsprogs?

> Below is the commented messages collected from runing e2fsck without
> interruption.  We print out a debug message when unix_write_blk,
> flush_cached_blocks, reuse_cache, raw_blk_write are called.  reuse_cache
> does the cache eviction.  Comments are in brackets.

BTW, it looks like you didn't realize that there was a simpler way of
instrumenting e2fsck's I/O.  You could have simple built e2fsck with
configure --enable-testio-debug, and then set the environment variable
TEST_IO_FLAGS=0x0F to log all reads, writes, set_blksize, and flush
operations.  See lib/ext2fs/test_io.c for more information.  There are
also environment variables that can be used to direct the log
information to a file, as well as ask the test_io layer to dump out
the contents of a specific block whenver it is read or written.
E2fsprogs has a very civilized debugging environment.  :-)


In any case, I believe the following patch (versus the latest
e2fsprogs tree in Bitkeeper; it looks like probably won't apply
cleanly to e2fpsrogs 1.34, but it shouldn't be that hard to fix up for
1.34) should address this issue, but I'd like to repeat your test case
exactly as you performed it before pronouncing it fixed.  The fix
doesn't cause any problems for the existing regression test suite, so
at the very least I'm confident the fix is safe.

						- Ted


===== e2fsck/jfs_user.h 1.8 vs edited =====
--- 1.8/e2fsck/jfs_user.h	Sun Dec  7 01:00:01 2003
+++ edited/e2fsck/jfs_user.h	Tue May 11 23:15:30 2004
@@ -41,8 +41,6 @@
 
 typedef struct kdev_s *kdev_t;
 
-#define fsync_no_super(dev) do {} while(0)
-#define sync_blockdev(dev) do {} while(0)
 #define lock_buffer(bh) do {} while(0)
 #define unlock_buffer(bh) do {} while(0)
 #define buffer_req(bh) 1
@@ -107,6 +105,7 @@
  */
 int journal_bmap(journal_t *journal, blk_t block, unsigned long *phys);
 struct buffer_head *getblk(kdev_t ctx, blk_t blocknr, int blocksize);
+void sync_blockdev(kdev_t kdev);
 void ll_rw_block(int rw, int dummy, struct buffer_head *bh[]);
 void mark_buffer_dirty(struct buffer_head *bh);
 void mark_buffer_uptodate(struct buffer_head *bh, int val);
===== e2fsck/journal.c 1.53 vs edited =====
--- 1.53/e2fsck/journal.c	Sun Dec 28 09:21:08 2003
+++ edited/e2fsck/journal.c	Tue May 11 23:15:07 2004
@@ -87,6 +87,18 @@
 	return bh;
 }
 
+void sync_blockdev(kdev_t kdev)
+{
+	io_channel	io;
+
+	if (kdev->k_dev == K_DEV_FS)
+		io = kdev->k_ctx->fs->io;
+	else 
+		io = kdev->k_ctx->journal_io;
+
+	io_channel_flush(io);
+}
+
 void ll_rw_block(int rw, int nr, struct buffer_head *bhp[])
 {
 	int retval;
