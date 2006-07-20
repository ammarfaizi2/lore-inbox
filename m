Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWGTEru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWGTEru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 00:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWGTErt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 00:47:49 -0400
Received: from ns.suse.de ([195.135.220.2]:37068 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932566AbWGTErt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 00:47:49 -0400
From: Neil Brown <neilb@suse.de>
To: Jan Kara <jack@suse.cz>
Date: Thu, 20 Jul 2006 14:46:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17599.2754.962927.627515@cse.unsw.edu.au>
Cc: James <20@madingley.org>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
Subject: Re: Bad ext3/nfs DoS bug
In-Reply-To: message from Jan Kara on Wednesday July 19
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	<1153209318.26690.1.camel@localhost>
	<20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 19, jack@suse.cz wrote:
> > So what happens next? Is the ext3 maintainer on sabatical,
> > or am I expected to submit a patch to fix this?
>   I guess people are mostly busy with OLS and such so maybe they missed
> the discussion.. Giving CC to relevant people to catch their attention
> :)
>   Andrew, Stephen: James has come across a nasty bug (potentially remote
> DoS). NFS extracts inode number from a filehandle and the inode number
> eventually ends in ext3_read_inode(). Now if the inode number is bogus,
> ext3_get_inode_block() calls ext3_error() and filesystem is remounted
> RO or whatever else is configured. That is quite undesirable in this
> case.
>   Now the easy "fix" is to change ext3_error() to ext3_warning() but an
> attacker flooding your logs with warnings is probably not good either
> and in case the inode number comes from ext3 itself we should really do
> ext3_error() as there is some corruption in the fs.
>   Better fix would be to add a flag to read_inode() saying that the inode
> number is from untrusted source (but that means changing a prototype of a
> function every fs uses) and change export_iget() to pass this flag. Yet
> another solution would be to make ext3 implement its own get_dentry() export
> function and pass the flag internally...
>   What do you think is the best solution?

I think that a good solution (hard to say if it is the best) is to
remove that error message altogether, and put it where inode numbers
are read out of directories.  Something like the following patch -
compile tested only.

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
 ./fs/ext3/inode.c |   10 ++++++----
 ./fs/ext3/namei.c |   19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 6 deletions(-)

diff .prev/fs/ext3/inode.c ./fs/ext3/inode.c
--- .prev/fs/ext3/inode.c	2006-07-20 14:41:07.000000000 +1000
+++ ./fs/ext3/inode.c	2006-07-20 14:42:04.000000000 +1000
@@ -2405,11 +2405,13 @@ static ext3_fsblk_t ext3_get_inode_block
 
 	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
 		ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(sb)) ||
-		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count)) {
-		ext3_error(sb, "ext3_get_inode_block",
-			    "bad inode number: %lu", ino);
+		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count))
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
+++ ./fs/ext3/namei.c	2006-07-20 14:44:23.000000000 +1000
@@ -1000,7 +1000,14 @@ static struct dentry *ext3_lookup(struct
 	if (bh) {
 		unsigned long ino = le32_to_cpu(de->inode);
 		brelse (bh);
-		inode = iget(dir->i_sb, ino);
+		if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
+		     ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(dir->i_sb)) ||
+		    ino > le32_to_cpu(EXT3_SB(dir->i_sb)->s_es->s_inodes_count)) {
+			ext3_error(dir->i_sb, "ext3_lookup",
+				   "bad inode number: %lu", ino);
+			inode = NULL;
+		} else
+			inode = iget(dir->i_sb, ino);
 
 		if (!inode)
 			return ERR_PTR(-EACCES);
@@ -1028,7 +1035,15 @@ struct dentry *ext3_get_parent(struct de
 		return ERR_PTR(-ENOENT);
 	ino = le32_to_cpu(de->inode);
 	brelse(bh);
-	inode = iget(child->d_inode->i_sb, ino);
+
+	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
+	     ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(child->d_inode->i_sb)) ||
+	    ino > le32_to_cpu(EXT3_SB(child->d_inode->i_sb)->s_es->s_inodes_count)) {
+		ext3_error(child->d_inode->i_sb, "ext3_get_parent",
+			   "bad inode number: %lu", ino);
+		inode = NULL;
+	} else
+		inode = iget(child->d_inode->i_sb, ino);
 
 	if (!inode)
 		return ERR_PTR(-EACCES);
