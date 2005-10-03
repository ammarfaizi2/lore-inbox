Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVJCSGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVJCSGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJCSGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:06:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:20406 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932491AbVJCSGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:06:16 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128261072.9382.4.camel@kleikamp.austin.ibm.com>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923153158.GA4548@x30.random>
	 <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
	 <1127509155.8875.6.camel@kleikamp.austin.ibm.com>
	 <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
	 <20050928223829.GH10408@opteron.random>
	 <1128126424.10237.7.camel@kleikamp.austin.ibm.com>
	 <20051002102726.GB26677@opteron.random>
	 <1128261072.9382.4.camel@kleikamp.austin.ibm.com>
Content-Type: multipart/mixed; boundary="=-kv1bmdlxhXYCaPNeFote"
Date: Mon, 03 Oct 2005 13:06:08 -0500
Message-Id: <1128362768.8967.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kv1bmdlxhXYCaPNeFote
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-10-02 at 08:51 -0500, Dave Kleikamp wrote:
> On Sun, 2005-10-02 at 12:27 +0200, Andrea Arcangeli wrote:
> > On Fri, Sep 30, 2005 at 07:27:04PM -0500, Dave Kleikamp wrote:
> > > I tracked down my problem to a bug in jfs.  jfs is explicitly setting
> > 
> > Ok great this explain things, so perhaps my last hack attempt of not
> > accounting the unstable pages in the "nr_reclaimable" isn't needed.
> 
> Maybe it is.  I just retested the fixed jfs on 2.6.14-rc2-mm1, and I
> still see the hang.  I can probably debug it further on Monday if
> necessary.

I finally figured out what the problem was with jfs.  There are really
three things I ended up fixing, but the most important was that the
reserved inodes that jfs uses for metadata were not in the inode hash.
__mark_inode_dirty() fails to add the inode to the superblock's dirty
list if hlist_unhashed() is true.  Without being on the dirty list, the
inode is not even looked at by writeback_inodes().

The other problems are that jfs explicitly sets I_DIRTY (I already
reported that one) and that metadata_writepage may repeatedly redirty an
inode that is waiting on journal I/O without initiating the journal I/O.

> > What about Valids, were you using jfs too along with ext3? If a single
> > fs has a bug the loop can happen (it could happen in mainline too,
> > except it was less likely to be visible there).

Unfortunately, this doesn't solve Valdis' problem, as he isn't using
jfs.  Valdis, do you have any other file systems mounted besides ext3?
I wonder if another file system has a similar problem.
-- 
David Kleikamp
IBM Linux Technology Center

--=-kv1bmdlxhXYCaPNeFote
Content-Disposition: attachment; filename=jfs-i_hash.patch
Content-Type: text/x-patch; name=jfs-i_hash.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

JFS: make special inodes play nicely with page balancing

This patch fixes up a few problems with jfs's reserved inodes.

1. There is no need for the jfs code setting the I_DIRTY bits in i_state.
   I am ashamed that the code ever did this, and surprised it hasn't been
   noticed until now.

2. Make sure special inodes are on an inode hash list.  If the inodes are
   unhashed, __mark_inode_dirty will fail to put the inode on the
   superblock's dirty list, and the data will not be flushed under memory
   pressure.

3. Force writing journal data to disk when metapage_writepage is unable to
   write a metadata page due to pending journal I/O.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff -Nurp linux-2.6.14-rc2-mm1/fs/jfs/jfs_dmap.c linux/fs/jfs/jfs_dmap.c
--- linux-2.6.14-rc2-mm1/fs/jfs/jfs_dmap.c	2005-09-22 18:06:45.000000000 -0500
+++ linux/fs/jfs/jfs_dmap.c	2005-10-02 14:22:12.000000000 -0500
@@ -305,7 +305,6 @@ int dbSync(struct inode *ipbmap)
 	filemap_fdatawrite(ipbmap->i_mapping);
 	filemap_fdatawait(ipbmap->i_mapping);
 
-	ipbmap->i_state |= I_DIRTY;
 	diWriteSpecial(ipbmap, 0);
 
 	return (0);
diff -Nurp linux-2.6.14-rc2-mm1/fs/jfs/jfs_imap.c linux/fs/jfs/jfs_imap.c
--- linux-2.6.14-rc2-mm1/fs/jfs/jfs_imap.c	2005-08-28 18:41:01.000000000 -0500
+++ linux/fs/jfs/jfs_imap.c	2005-10-03 13:01:53.000000000 -0500
@@ -57,6 +57,12 @@
 #include "jfs_debug.h"
 
 /*
+ * __mark_inode_dirty expects inodes to be hashed.  Since we don't want
+ * special inodes in the fileset inode space, we hash them to a dummy head
+ */
+static HLIST_HEAD(aggregate_hash);
+
+/*
  * imap locks
  */
 /* iag free list lock */
@@ -491,6 +497,8 @@ struct inode *diReadSpecial(struct super
 	/* release the page */
 	release_metapage(mp);
 
+	hlist_add_head(&ip->i_hash, &aggregate_hash);
+
 	return (ip);
 }
 
@@ -514,8 +522,6 @@ void diWriteSpecial(struct inode *ip, in
 	ino_t inum = ip->i_ino;
 	struct metapage *mp;
 
-	ip->i_state &= ~I_DIRTY;
-
 	if (secondary)
 		address = addressPXD(&sbi->ait2) >> sbi->l2nbperpage;
 	else
diff -Nurp linux-2.6.14-rc2-mm1/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux-2.6.14-rc2-mm1/fs/jfs/jfs_metapage.c	2005-08-28 18:41:01.000000000 -0500
+++ linux/fs/jfs/jfs_metapage.c	2005-10-03 12:26:50.000000000 -0500
@@ -395,6 +395,12 @@ static int metapage_writepage(struct pag
 
 		if (mp->nohomeok && !test_bit(META_forcewrite, &mp->flag)) {
 			redirty = 1;
+			/*
+			 * Make sure this page isn't blocked indefinitely.
+			 * If the journal isn't undergoing I/O, push it
+			 */
+			if (mp->log && !(mp->log->cflag & logGC_PAGEOUT))
+				jfs_flush_journal(mp->log, 0);
 			continue;
 		}
 
diff -Nurp linux-2.6.14-rc2-mm1/fs/jfs/jfs_txnmgr.c linux/fs/jfs/jfs_txnmgr.c
--- linux-2.6.14-rc2-mm1/fs/jfs/jfs_txnmgr.c	2005-09-22 18:06:45.000000000 -0500
+++ linux/fs/jfs/jfs_txnmgr.c	2005-10-02 14:22:12.000000000 -0500
@@ -2396,7 +2396,6 @@ static void txUpdateMap(struct tblock * 
 	 */
 	if (tblk->xflag & COMMIT_CREATE) {
 		diUpdatePMap(ipimap, tblk->ino, FALSE, tblk);
-		ipimap->i_state |= I_DIRTY;
 		/* update persistent block allocation map
 		 * for the allocation of inode extent;
 		 */
@@ -2407,7 +2406,6 @@ static void txUpdateMap(struct tblock * 
 	} else if (tblk->xflag & COMMIT_DELETE) {
 		ip = tblk->u.ip;
 		diUpdatePMap(ipimap, ip->i_ino, TRUE, tblk);
-		ipimap->i_state |= I_DIRTY;
 		iput(ip);
 	}
 }
diff -Nurp linux-2.6.14-rc2-mm1/fs/jfs/super.c linux/fs/jfs/super.c
--- linux-2.6.14-rc2-mm1/fs/jfs/super.c	2005-09-22 18:05:56.000000000 -0500
+++ linux/fs/jfs/super.c	2005-10-03 10:54:41.000000000 -0500
@@ -442,6 +442,7 @@ static int jfs_fill_super(struct super_b
 	inode->i_nlink = 1;
 	inode->i_size = sb->s_bdev->bd_inode->i_size;
 	inode->i_mapping->a_ops = &jfs_metapage_aops;
+	insert_inode_hash(inode);
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 	sbi->direct_inode = inode;

--=-kv1bmdlxhXYCaPNeFote--

