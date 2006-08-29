Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965427AbWH2V7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965427AbWH2V7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965435AbWH2V7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:59:47 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:55878 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965427AbWH2V7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:59:46 -0400
Date: Tue, 29 Aug 2006 14:54:48 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk
Subject: [PATCH] Allow file systems to manually d_move() inside of ->rename()
Message-ID: <20060829215448.GO2874@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on removing the "dentry" vote from ocfs2. This is a
network message broadcasted to all mounted nodes on every unlink() or
rename(). Upon recieving the message, those nodes d_delete() the dentry in
question.

What I'm doing is replacing the broadcast mechanism with a cluster lock
which covers a set of dentries. Every node gets a read only lock, until an
unlink during which the unlinking node, will request an exclusive lock,
forcing the other nodes who care about that dentry to d_delete() it. The
effect is that we retain a very lightweight ->d_revalidate(), and at the
same time get to make large improvements to the average case performance
of the ocfs2 unlink and rename operations.

I have uncovered a very small race with rename and d_move() however. The
d_move() for a rename is after the ->rename() callback, outside the parent
directory cluster locks which normally protect the name creation/removal
mechanism. The worry is that after ocfs2_rename(), but before the d_move() a
different node can discover the new name (created during the rename) and
unlink it, forcing a d_delete(). d_move() it seems, unconditionally rehashes
the (renamed) dentry and so if it's done after a d_delete() we could get
some inconsitent state amongst the nodes.

My solution is to simply allow ocfs2 to do the d_move() inside of
ocfs2_rename() by introducing a FS_RENAME_DOES_D_MOVE flag. OCFS2 won't
actually change how or why d_move() is called during a rename, it just uses
this flag to change where the call is made.

For any interested parties, a preliminary ocfs2 patch is at

http://oss.oracle.com/~mfasheh/vote_removal/remove_dentry_vote_wip.patch

The interesting stuff is mostly in fs/ocfs2/dcache.[ch]

The ocfs2 patch isn't posted via e-mail because it's still a work in
progress. That said, it actually works quite well, and the only things I
have left to do are unrelated to rename - the patch needs to be split up
into smaller ones, and a pair of (minor) dlm related fixups are needed.
	--Mark


From: Mark Fasheh <mark.fasheh@oracle.com>

[PATCH] Allow file systems to manually d_move() inside of ->rename()

Some file systems want to be able to manually d_move() the dentries involved
in a rename. Introduce a flag which instructs vfs_rename_dir() and
vfs_rename_other() that it has already been handled internally.

OCFS2 uses this to protect that part of the entire operation with a cluster
lock.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff --git a/fs/namei.c b/fs/namei.c
index c784e8b..e5a8478 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2353,7 +2353,8 @@ static int vfs_rename_dir(struct inode *
 		dput(new_dentry);
 	}
 	if (!error)
-		d_move(old_dentry,new_dentry);
+		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
+			d_move(old_dentry,new_dentry);
 	return error;
 }
 
@@ -2377,7 +2378,7 @@ static int vfs_rename_other(struct inode
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (!error) {
 		/* The following d_move() should become unconditional */
-		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
+		if (!(old_dir->i_sb->s_type->fs_flags & (FS_ODD_RENAME|FS_RENAME_DOES_D_MOVE)))
 			d_move(old_dentry, new_dentry);
 	}
 	if (target)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e04a5cf..8e9a7ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -87,6 +87,7 @@ #define SEL_EX		4
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_RENAME_DOES_D_MOVE 4
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
