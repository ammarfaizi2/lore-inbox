Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWGUGka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWGUGka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWGUGka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:40:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24805 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030458AbWGUGk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:40:29 -0400
From: Neil Brown <neilb@suse.de>
To: Jan Kara <jack@suse.cz>
Date: Fri, 21 Jul 2006 16:39:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17600.30372.397971.955987@cse.unsw.edu.au>
Cc: James <20@madingley.org>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
Subject: Re: Bad ext3/nfs DoS bug
In-Reply-To: message from Jan Kara on Thursday July 20
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	<1153209318.26690.1.camel@localhost>
	<20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 20, jack@suse.cz wrote:
>   Yes, that looks fine too. I did not realize that we get the inode
> number only in a few places. Maybe we could wrap the checks in a
> function (possibly inline) so that the checks are just in one place?

Like this?

NeilBrown


Avoid triggering ext3_error on bad NFS file handle

The inode number out of an NFS file handle gets passed 
eventually to ext3_get_inode_block without any checking.
If ext3_get_inode_block allows it to trigger a error,
then bad filehandles can have unpleasant effect.

So remove the call to ext3_error there and put a matching
check in ext3/namei.c where inode numbers are read of storage.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/ext3/inode.c         |   13 ++++++-------
 ./fs/ext3/namei.c         |   15 +++++++++++++--
 ./include/linux/ext3_fs.h |    9 +++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff .prev/fs/ext3/inode.c ./fs/ext3/inode.c
--- .prev/fs/ext3/inode.c	2006-07-20 14:41:07.000000000 +1000
+++ ./fs/ext3/inode.c	2006-07-21 16:36:32.000000000 +1000
@@ -2402,14 +2402,13 @@ static ext3_fsblk_t ext3_get_inode_block
 	struct buffer_head *bh;
 	struct ext3_group_desc * gdp;
 
-
-	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
-		ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(sb)) ||
-		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count)) {
-		ext3_error(sb, "ext3_get_inode_block",
-			    "bad inode number: %lu", ino);
+	if (!ext3_valid_inum(sb, ino))
+		/* This error already checked for in namei.c unless we
+		 * are looking at an NFS filehandle, in which case,
+		 * no error reported is needed
+		 */
 		return 0;
-	}
+
 	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
 	if (block_group >= EXT3_SB(sb)->s_groups_count) {
 		ext3_error(sb,"ext3_get_inode_block","group >= groups count");

diff .prev/fs/ext3/namei.c ./fs/ext3/namei.c
--- .prev/fs/ext3/namei.c	2006-07-20 14:39:51.000000000 +1000
+++ ./fs/ext3/namei.c	2006-07-21 16:36:09.000000000 +1000
@@ -1000,7 +1000,12 @@ static struct dentry *ext3_lookup(struct
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
 		brelse (bh);
-		inode = iget(dir->i_sb, ino);
+		if (!ext3_valid_inum(dir->i_sb, ino)) {
+			ext3_error(dir->i_sb, "ext3_lookup",
+				   "bad inode number: %lu", ino);
+			inode = NULL;
+		} else
+			inode = iget(dir->i_sb, ino);
 
 		if (!inode)
 			return ERR_PTR(-EACCES);
@@ -1028,7 +1033,13 @@ struct dentry *ext3_get_parent(struct de
 		return ERR_PTR(-ENOENT);
 	ino = le32_to_cpu(de->inode);
 	brelse(bh);
-	inode = iget(child->d_inode->i_sb, ino);
+
+	if (!ext3_valid_inum(child->d_inode->i_sb, ino)) {
+		ext3_error(child->d_inode->i_sb, "ext3_get_parent",
+			   "bad inode number: %lu", ino);
+		inode = NULL;
+	} else
+		inode = iget(child->d_inode->i_sb, ino);
 
 	if (!inode)
 		return ERR_PTR(-EACCES);

diff .prev/include/linux/ext3_fs.h ./include/linux/ext3_fs.h
--- .prev/include/linux/ext3_fs.h	2006-07-21 16:34:01.000000000 +1000
+++ ./include/linux/ext3_fs.h	2006-07-21 16:35:55.000000000 +1000
@@ -492,6 +492,15 @@ static inline struct ext3_inode_info *EX
 {
 	return container_of(inode, struct ext3_inode_info, vfs_inode);
 }
+
+static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
+{
+	return ino == EXT3_ROOT_INO ||
+		ino == EXT3_JOURNAL_INO ||
+		ino == EXT3_RESIZE_INO ||
+		(ino > EXT3_FIRST_INO(sb) &&
+		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
+}
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test
