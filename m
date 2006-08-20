Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWHTT1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWHTT1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHTT1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:27:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55565 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751171AbWHTT1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:27:50 -0400
Date: Sun, 20 Aug 2006 21:27:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ext2-devel@lists.sourceforge.net, Neil Brown <neilb@suse.de>,
       Eric Sandeen <sandeen@sandeen.net>
Cc: linux-kernel@vger.kernel.org
Subject: CVE-2006-3468: which patch to use?
Message-ID: <20060820192750.GR7813@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While going through patches for 2.6.16.x, I stumbled over the following 
regarding the "NFS export of ext2/ext3" security vulnerabilities (the 
ext3 one is  CVE-2006-3468, I don't whether there's a number for the 
ext2 one):

There are three patches available:
have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch
have-ext3-reject-file-handles-with-bad-inode-numbers-early.patch
ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch

The first two patches are except for a s/ext2/ext3/ identical.

The two ext3 patches fix the same issue in slightly different ways.

It seems there was already some agreement that the first of the two ext3 
patches should be preferred due to being more the same as the ext2 patch
(see [1] and followups).

But the only patch that is applied in 2.6.18-rc4 (and in 2.6.17.9) is 
the ext3 patch that is _not_ identical to the ext2 one.

Is it the correct solution to revert this ext3 patch in both 2.6.18-rc 
and 2.6.17 and to apply the other two patches?

cu
Adrian

BTW: I've attached all three patches.

[1] http://lkml.org/lkml/2006/8/4/192

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch"

>From neilb@suse.de Thu Aug  3 17:53:52 2006
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Fri, 4 Aug 2006 10:53:40 +1000
Message-ID: <17618.39572.764990.76181@cse.unsw.edu.au>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Have ext2 reject file handles with bad inode numbers early.

From: Neil Brown <neilb@suse.de>

This prevents bad inode numbers from triggering errors in
ext2_get_inode.


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext2/super.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- linux-2.6.17.7.orig/fs/ext2/super.c
+++ linux-2.6.17.7/fs/ext2/super.c
@@ -252,6 +252,46 @@ static struct super_operations ext2_sops
 #endif
 };
 
+static struct dentry *ext2_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext2_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext2_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
+
 /* Yes, most of these are left as NULL!!
  * A NULL value implies the default, which works with ext2-like file
  * systems, but can be improved upon.
@@ -259,6 +299,7 @@ static struct super_operations ext2_sops
  */
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
+	.get_dentry = ext2_get_dentry,
 };
 
 static unsigned long get_sb_block(void **data)

--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="have-ext3-reject-file-handles-with-bad-inode-numbers-early.patch"

>From stable-bounces@linux.kernel.org Fri Aug  4 08:36:24 2006
Message-ID: <44D36946.7020601@redhat.com>
Date: Fri, 04 Aug 2006 10:35:34 -0500
From: Eric Sandeen <esandeen@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <esandeen@redhat.com>,
        Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
        stable@kernel.org, torvalds@osdl.org,
        Justin Forbes <jmforbes@linuxtx.org>,
        Zwane Mwaikambo <zwane@arm.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
        Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
        Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
        alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
        Marcel Holtmann <marcel@holtmann.org>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Have ext3 reject file handles with bad inode numbers early

blatantly ripped off from Neil Brown's ext2 patch.


Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/super.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- linux-2.6.17.8.orig/fs/ext3/super.c
+++ linux-2.6.17.8/fs/ext3/super.c
@@ -620,8 +620,48 @@ static struct super_operations ext3_sops
 #endif
 };
 
+static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext3_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext3_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {

--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch"

>From stable-bounces@linux.kernel.org Sun Jul 30 03:04:26 2006
Message-Id: <200607301003.k6UA31hC002485@shell0.pdx.osdl.net>
To: torvalds@osdl.org
From: akpm@osdl.org
Date: Sun, 30 Jul 2006 03:03:01 -0700
Cc: akpm@osdl.org, jack@suse.cz, esandeen@redhat.com, neilb@suse.de,
        sct@redhat.com, marcel@holtmann.org, stable@kernel.org
Subject: ext3: avoid triggering ext3_error on bad NFS file handle

From: Neil Brown <neilb@suse.de>

The inode number out of an NFS file handle gets passed eventually to
ext3_get_inode_block() without any checking.  If ext3_get_inode_block()
allows it to trigger an error, then bad filehandles can have unpleasant
effect - ext3_error() will usually cause a forced read-only remount, or a
panic if `errors=panic' was used.

So remove the call to ext3_error there and put a matching check in
ext3/namei.c where inode numbers are read off storage.

[akpm@osdl.org: fix off-by-one error]
Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/inode.c         |   13 +++++++------
 fs/ext3/namei.c         |   15 +++++++++++++--
 include/linux/ext3_fs.h |    9 +++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

--- linux-2.6.17.7.orig/fs/ext3/inode.c
+++ linux-2.6.17.7/fs/ext3/inode.c
@@ -2402,14 +2402,15 @@ static unsigned long ext3_get_inode_bloc
 	struct buffer_head *bh;
 	struct ext3_group_desc * gdp;
 
-
-	if ((ino != EXT3_ROOT_INO && ino != EXT3_JOURNAL_INO &&
-		ino != EXT3_RESIZE_INO && ino < EXT3_FIRST_INO(sb)) ||
-		ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count)) {
-		ext3_error(sb, "ext3_get_inode_block",
-			    "bad inode number: %lu", ino);
+	if (!ext3_valid_inum(sb, ino)) {
+		/*
+		 * This error is already checked for in namei.c unless we are
+		 * looking at an NFS filehandle, in which case no error
+		 * report is needed
+		 */
 		return 0;
 	}
+
 	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
 	if (block_group >= EXT3_SB(sb)->s_groups_count) {
 		ext3_error(sb,"ext3_get_inode_block","group >= groups count");
--- linux-2.6.17.7.orig/fs/ext3/namei.c
+++ linux-2.6.17.7/fs/ext3/namei.c
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
--- linux-2.6.17.7.orig/include/linux/ext3_fs.h
+++ linux-2.6.17.7/include/linux/ext3_fs.h
@@ -495,6 +495,15 @@ static inline struct ext3_inode_info *EX
 {
 	return container_of(inode, struct ext3_inode_info, vfs_inode);
 }
+
+static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
+{
+	return ino == EXT3_ROOT_INO ||
+		ino == EXT3_JOURNAL_INO ||
+		ino == EXT3_RESIZE_INO ||
+		(ino >= EXT3_FIRST_INO(sb) &&
+		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
+}
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
  * a kernel struct super_block.  This will allow us to call the feature-test

--x4pBfXISqBoDm8sr--
