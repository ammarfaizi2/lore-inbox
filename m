Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313797AbSDHXyx>; Mon, 8 Apr 2002 19:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313798AbSDHXyw>; Mon, 8 Apr 2002 19:54:52 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:33191 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313797AbSDHXyv>; Mon, 8 Apr 2002 19:54:51 -0400
Message-Id: <5.1.0.14.2.20020409005404.046991f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 09 Apr 2002 00:55:21 +0100
To: torvalds@transmeta.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [BKPatch-2.5.8-pre2] Cleanup: Remove BH_Req
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16uic4-0002wq-00@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. I take that one back. /-:

/me applies self LART: try to compile before sending...

Anton

At 00:31 09/04/02, Anton Altaparmakov wrote:
>Linus,
>
>I have noticed that BH_Req is not actually used for anything any more both
>in 2.4 and 2.5 kernels. There are a handful of places that set/clear it
>but no one tests for it so it seems to me it is a good target for removal.
>
>Unless someone has sinister plans for BH_Req (in which case I expect them
>to scream NOW), please apply below patch which removes the no longer
>user BH_Req altogether from the kernel tree.
>
>Best regards,
>
>         Anton
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
>IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
>WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>--------bhreq.patch--------
>You can import this changeset into BK by piping this whole message to:
>'| bk receive [path to repository]' or apply the patch as usual.
>
>===================================================================
>
>
>ChangeSet@1.586, 2002-04-09 00:14:26+01:00, aia21@cam.ac.uk
>   Remove BH_Req as it is no longer used for anything.
>
>
>  drivers/block/ll_rw_blk.c     |    2 --
>  drivers/md/raid5.c            |    2 +-
>  fs/buffer.c                   |    2 --
>  fs/jbd/transaction.c          |    1 -
>  fs/reiserfs/tail_conversion.c |    1 -
>  include/linux/fs.h            |    1 -
>  6 files changed, 1 insertion(+), 8 deletions(-)
>
>
>diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
>--- a/drivers/block/ll_rw_blk.c Tue Apr  9 00:22:36 2002
>+++ b/drivers/block/ll_rw_blk.c Tue Apr  9 00:22:36 2002
>@@ -1396,8 +1396,6 @@
>         BUG_ON(!buffer_mapped(bh));
>         BUG_ON(!bh->b_end_io);
>
>-       set_bit(BH_Req, &bh->b_state);
>-
>         /*
>         * from here on down, it's all bio -- do the initial mapping,
>         * submit_bio -> generic_make_request may further map this bio around
>diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
>--- a/drivers/md/raid5.c        Tue Apr  9 00:22:36 2002
>+++ b/drivers/md/raid5.c        Tue Apr  9 00:22:36 2002
>@@ -472,7 +472,7 @@
>         /* FIXME - later we will need bdev here */
>         bh->b_blocknr   = block;
>
>-       bh->b_state     = (1 << BH_Req) | (1 << BH_Mapped);
>+       bh->b_state     = 1 << BH_Mapped;
>         bh->b_size      = sh->size;
>         bh->b_list      = BUF_LOCKED;
>         return bh;
>diff -Nru a/fs/buffer.c b/fs/buffer.c
>--- a/fs/buffer.c       Tue Apr  9 00:22:36 2002
>+++ b/fs/buffer.c       Tue Apr  9 00:22:36 2002
>@@ -1313,7 +1313,6 @@
>                 bh->b_bdev = NULL;
>                 clear_bit(BH_Uptodate, &bh->b_state);
>                 clear_bit(BH_Mapped, &bh->b_state);
>-               clear_bit(BH_Req, &bh->b_state);
>                 clear_bit(BH_New, &bh->b_state);
>                 remove_from_queues(bh);
>                 unlock_buffer(bh);
>@@ -1436,7 +1435,6 @@
>         if (old_bh) {
>                 mark_buffer_clean(old_bh);
>                 wait_on_buffer(old_bh);
>-               clear_bit(BH_Req, &old_bh->b_state);
>                 __brelse(old_bh);
>         }
>  }
>diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
>--- a/fs/jbd/transaction.c      Tue Apr  9 00:22:36 2002
>+++ b/fs/jbd/transaction.c      Tue Apr  9 00:22:36 2002
>@@ -1862,7 +1862,6 @@
>         J_ASSERT_BH(bh, !buffer_jdirty(bh));
>         clear_bit(BH_Uptodate, &bh->b_state);
>         clear_bit(BH_Mapped, &bh->b_state);
>-       clear_bit(BH_Req, &bh->b_state);
>         clear_bit(BH_New, &bh->b_state);
>         bh->b_bdev = NULL;
>         return may_free;
>diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
>--- a/fs/reiserfs/tail_conversion.c     Tue Apr  9 00:22:36 2002
>+++ b/fs/reiserfs/tail_conversion.c     Tue Apr  9 00:22:36 2002
>@@ -140,7 +140,6 @@
>      mark_buffer_clean(bh) ;
>      lock_buffer(bh) ;
>      clear_bit(BH_Mapped, &bh->b_state) ;
>-    clear_bit(BH_Req, &bh->b_state) ;
>      clear_bit(BH_New, &bh->b_state) ;
>      bh->b_bdev = NULL;
>      unlock_buffer(bh) ;
>diff -Nru a/include/linux/fs.h b/include/linux/fs.h
>--- a/include/linux/fs.h        Tue Apr  9 00:22:36 2002
>+++ b/include/linux/fs.h        Tue Apr  9 00:22:36 2002
>@@ -215,7 +215,6 @@
>         BH_Uptodate,    /* 1 if the buffer contains valid data */
>         BH_Dirty,       /* 1 if the buffer is dirty */
>         BH_Lock,        /* 1 if the buffer is locked */
>-       BH_Req,         /* 0 if the buffer has been invalidated */
>         BH_Mapped,      /* 1 if the buffer has a disk mapping */
>         BH_New,         /* 1 if the buffer is new and not yet written out */
>         BH_Async,       /* 1 if the buffer is under end_buffer_io_async 
> I/O */
>
>===================================================================
>
>
>This BitKeeper patch contains the following changesets:
>+
>## Wrapped with gzip_uu ##
>
>
>makepatch: ChangeSet |1 revisions
>makepatch: fs/jbd/transaction.c |1 revisions
>makepatch: fs/reiserfs/tail_conversion.c |1 revisions
>makepatch: drivers/block/ll_rw_blk.c |1 revisions
>makepatch: drivers/md/raid5.c |1 revisions
>makepatch: fs/buffer.c |1 revisions
>makepatch: include/linux/fs.h |1 revisions
>makepatch: patch contains 7 revisions from 7 files
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

