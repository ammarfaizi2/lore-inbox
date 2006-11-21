Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755925AbWKUWQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbWKUWQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbWKUWQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:16:40 -0500
Received: from server42.ukservers.net ([217.10.138.242]:41090 "EHLO
	server42.ukservers.net") by vger.kernel.org with ESMTP
	id S1755216AbWKUWQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:16:39 -0500
Date: Tue, 21 Nov 2006 22:16:32 +0000
From: James Hunt <james@jameshunt.org.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sct@redhat.com
Subject: [PATCH 1/3] ext2/3/4: enable "undeletable" file attribute.
Message-ID: <20061121221632.GA12422@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, although you can mark a file as undeletable with 'chattr'...

  > touch /tmp/wibble
  > ls -l /tmp/wibble
  -rw-rw-r-- 1 james james 0 Nov 16 20:00 /tmp/wibble
  > chattr +u /tmp/wibble      # mark file as undeletable
  > lsattr /tmp/wibble
  -u----------- /tmp/wibble

... it's not honoured by the kernel:

  > rm /tmp/wibble             # yikes! this should fail!!

This patch makes ext3 aware of the undeletable attribute such that
attempting to delete a file marked as undeltable works as expected:

  > chattr +u /tmp/wibble      # mark file as undeletable
  > lsattr /tmp/wibble
  -u----------- /tmp/wibble
  > rm /tmp/wibble
  rm: cannot remove `/tmp/wibble': Operation not permitted
  > chattr -u /tmp/wibble      # remove undeletable attribute
  > lsattr /tmp/wibble
  ------------- /tmp/wibble
  > rm /tmp/wibble             # works as expected this time

Tested with e2fsprogs-1.38-12 (FC5).

Signed-off-by: James Hunt <james@jameshunt.org.uk>
---
 fs/ext3/inode.c    |    4 +++-
 fs/namei.c         |    6 +++---
 include/linux/fs.h |    3 +++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index 03ba5bc..dd1428e 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -2568,11 +2568,13 @@ void ext3_set_inode_flags(struct inode *
 {
 	unsigned int flags = EXT3_I(inode)->i_flags;
 
-	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_UNRM);
 	if (flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (flags & EXT3_APPEND_FL)
 		inode->i_flags |= S_APPEND;
+	if (flags & EXT3_UNRM_FL)
+		inode->i_flags |= S_UNRM;
 	if (flags & EXT3_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
 	if (flags & EXT3_NOATIME_FL)
diff --git a/fs/namei.c b/fs/namei.c
index 28d49b3..d845d4d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1376,8 +1376,8 @@ static inline int check_sticky(struct in
  *	a. be owner of dir, or
  *	b. be owner of victim, or
  *	c. have CAP_FOWNER capability
- *  6. If the victim is append-only or immutable we can't do antyhing with
- *     links pointing to it.
+ *	6. If the victim is append-only or immutable or undeletable, we can't do
+ *	   anthying with links pointing to it.
  *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
  *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
  *  9. We can't remove a root or mountpoint.
@@ -1400,7 +1400,7 @@ static int may_delete(struct inode *dir,
 	if (IS_APPEND(dir))
 		return -EPERM;
 	if (check_sticky(dir, victim->d_inode)||IS_APPEND(victim->d_inode)||
-	    IS_IMMUTABLE(victim->d_inode))
+	    IS_IMMUTABLE(victim->d_inode)||IS_UNRM(victim->d_inode))
 		return -EPERM;
 	if (isdir) {
 		if (!S_ISDIR(victim->d_inode->i_mode))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..725d35d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -146,6 +146,8 @@ #define S_DIRSYNC	64	/* Directory modifi
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	512	/* Inode is fs-internal */
+#define S_UNRM		1024	/* Inode is undeletable */
+
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -178,6 +180,7 @@ #define IS_DEADDIR(inode)	((inode)->i_fl
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
+#define IS_UNRM(inode)		((inode)->i_flags & S_UNRM)
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
-- 
1.4.1

-- 
JaMeS
