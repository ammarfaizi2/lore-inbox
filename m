Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUAFLbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 06:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAFLbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 06:31:41 -0500
Received: from [193.138.115.2] ([193.138.115.2]:45578 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261774AbUAFLbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 06:31:37 -0500
Date: Tue, 6 Jan 2004 12:28:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Hans Reiser <reiser@namesys.com>
cc: "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
In-Reply-To: <3FFA7717.7080808@namesys.com>
Message-ID: <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
 <3FFA7717.7080808@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Hans Reiser wrote:

> Jesper Juhl wrote:
>
> >
> >
> >The problem is what seems (to me, but I could be dead wrong) to be invalid
> >use of variables of type sector_t.
> >
> >
> >
> thanks.  nikita, please clean.
>

In case the proper fix is to just get rid of the impossible branches and
the unreachable code, I've invluded patches below that does this for the
various filesystems. Seems to compile and behave fine (against 2.6.1-rc1-mm2)..


--- linux-2.6.1-rc1-mm2-orig/fs/ufs/inode.c     2003-12-31 05:46:41.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/ufs/inode.c  2004-01-06 12:12:29.000000000 +0100
@@ -331,8 +331,6 @@ static int ufs_getfrag_block (struct ino
        lock_kernel();

        UFSD(("ENTER, ino %lu, fragment %u\n", inode->i_ino, fragment))
-       if (fragment < 0)
-               goto abort_negative;
        if (fragment >
            ((UFS_NDADDR + uspi->s_apb + uspi->s_2apb + uspi->s_3apb)
             << uspi->s_fpbshift))
@@ -393,10 +391,6 @@ abort:
        unlock_kernel();
        return err;

-abort_negative:
-       ufs_warning(sb, "ufs_get_block", "block < 0");
-       goto abort;
-
 abort_too_big:
        ufs_warning(sb, "ufs_get_block", "block > big");
        goto abort;



--- linux-2.6.1-rc1-mm2-orig/fs/adfs/inode.c    2003-12-31 05:46:54.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/adfs/inode.c 2004-01-06 12:13:08.000000000 +0100
@@ -27,9 +27,6 @@
 int
 adfs_get_block(struct inode *inode, sector_t block, struct buffer_head
*bh, int create)
 {
-       if (block < 0)
-               goto abort_negative;
-
        if (!create) {
                if (block >= inode->i_blocks)
                        goto abort_toobig;
@@ -42,10 +39,6 @@ adfs_get_block(struct inode *inode, sect
        /* don't support allocation of blocks yet */
        return -EIO;

-abort_negative:
-       adfs_error(inode->i_sb, "block %d < 0", block);
-       return -EIO;
-
 abort_toobig:
        return 0;
 }



--- linux-2.6.1-rc1-mm2-orig/fs/befs/linuxvfs.c 2003-12-31 05:47:11.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/befs/linuxvfs.c      2004-01-06 12:35:27.000000000 +0100
@@ -132,13 +132,6 @@ befs_get_block(struct inode *inode, sect
        befs_debug(sb, "---> befs_get_block() for inode %lu, block %ld",
                   inode->i_ino, block);

-       if (block < 0) {
-               befs_error(sb, "befs_get_block() was asked for a block "
-                          "number less than zero: block %ld in inode %lu",
-                          block, inode->i_ino);
-               return -EIO;
-       }
-
        if (create) {
                befs_error(sb, "befs_get_block() was asked to write to "
                           "block %ld in inode %lu", block, inode->i_ino);



--- linux-2.6.1-rc1-mm2-orig/fs/bfs/file.c      2003-12-31 05:46:40.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/bfs/file.c   2004-01-06 12:15:20.000000000 +0100
@@ -64,7 +64,7 @@ static int bfs_get_block(struct inode *
        struct bfs_inode_info *bi = BFS_I(inode);
        struct buffer_head *sbh = info->si_sbh;

-       if (block < 0 || block > info->si_blocks)
+       if (block > info->si_blocks)
                return -EIO;

        phys = bi->i_sblock + block;



--- linux-2.6.1-rc1-mm2-orig/fs/reiserfs/inode.c        2004-01-06 01:33:08.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/reiserfs/inode.c     2004-01-06 12:16:16.000000000 +0100
@@ -574,11 +574,6 @@ int reiserfs_get_block (struct inode * i
     th.t_trans_id = 0 ;
     version = get_inode_item_key_version (inode);

-    if (block < 0) {
-       reiserfs_write_unlock(inode->i_sb);
-       return -EIO;
-    }
-
     if (!file_capable (inode, block)) {
        reiserfs_write_unlock(inode->i_sb);
        return -EFBIG;



Kind regards,

Jesper Juhl

