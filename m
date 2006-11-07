Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWKGRmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWKGRmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbWKGRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:42:53 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:18127 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932747AbWKGRmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:42:52 -0500
Date: Tue, 7 Nov 2006 18:42:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107174217.GA29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061107172835.GB15629@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 18:28:35 +0100, Jörn Engel wrote:
> 
> Anyway, here is a first patch converting some callers that looked
> obvious.

Next patch with the not-so-obvious ones.  I believe this patch is
correct, but someone should double-check it.

Jfs really surprised me.  It appears as if it just takes the number
returned from new_inode in some cases - unbelievable.

Jörn

-- 
"[One] doesn't need to know [...] how to cause a headache in order
to take an aspirin."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/9p/vfs_inode.c  |    2 +-
 fs/cifs/inode.c    |    8 +++++---
 fs/jfs/jfs_inode.c |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

--- iunique/fs/9p/vfs_inode.c~iunique_nonobvious	2006-10-13 15:55:45.000000000 +0200
+++ iunique/fs/9p/vfs_inode.c	2006-11-07 18:30:59.000000000 +0100
@@ -199,7 +199,7 @@ struct inode *v9fs_get_inode(struct supe
 
 	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (inode) {
 		inode->i_mode = mode;
 		inode->i_uid = current->fsuid;
--- iunique/fs/cifs/inode.c~iunique_nonobvious	2006-10-13 15:55:50.000000000 +0200
+++ iunique/fs/cifs/inode.c	2006-11-07 18:33:53.000000000 +0100
@@ -90,7 +90,9 @@ int cifs_get_inode_info_unix(struct inod
 			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 				(*pinode)->i_ino =
 					(unsigned long)findData.UniqueId;
-			} /* note ino incremented to unique num in new_inode */
+			} else {
+				(*pinode)->i_ino = iunique(sb, 0);
+			}
 			insert_inode_hash(*pinode);
 		}
 
@@ -384,7 +386,7 @@ int cifs_get_inode_info(struct inode **p
 
 		/* get new inode */
 		if (*pinode == NULL) {
-			*pinode = new_inode(sb);
+			*pinode = new_inode_autonum(sb);
 			if (*pinode == NULL)
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? Can we use that to check
@@ -416,7 +418,7 @@ int cifs_get_inode_info(struct inode **p
 					/* BB EOPNOSUPP disable SERVER_INUM? */
 				} else /* do we need cast or hash to ino? */
 					(*pinode)->i_ino = inode_num;
-			} /* else ino incremented to unique num in new_inode*/
+			} /* else ino incremented to unique num in new_inode_autonum*/
 			insert_inode_hash(*pinode);
 		}
 		inode = *pinode;
--- iunique/fs/jfs/jfs_inode.c~iunique_nonobvious	2006-10-13 15:56:05.000000000 +0200
+++ iunique/fs/jfs/jfs_inode.c	2006-11-07 18:36:55.000000000 +0100
@@ -58,7 +58,7 @@ struct inode *ialloc(struct inode *paren
 	struct jfs_inode_info *jfs_inode;
 	int rc;
 
-	inode = new_inode(sb);
+	inode = new_inode_autonum(sb);
 	if (!inode) {
 		jfs_warn("ialloc: new_inode returned NULL!");
 		return inode;
