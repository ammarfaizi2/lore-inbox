Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264817AbSJOUyk>; Tue, 15 Oct 2002 16:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSJOUyk>; Tue, 15 Oct 2002 16:54:40 -0400
Received: from ns.suse.de ([213.95.15.193]:33041 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264817AbSJOUyh>;
	Tue, 15 Oct 2002 16:54:37 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Add extended attributes to ext2/3
Date: Tue, 15 Oct 2002 23:00:32 +0200
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200210151640.15581.agruen@suse.de> <20021015182943.GA1335@think.thunk.org>
In-Reply-To: <20021015182943.GA1335@think.thunk.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WOJ1CN50FE05WCI523FC"
Message-Id: <200210152300.32190.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WOJ1CN50FE05WCI523FC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 15 October 2002 20:29, Theodore Ts'o wrote:
> It looks like the ext3 change in fix-acl.diff was to revert a change
> that I never had; it's not in the 2.4 0.8.50 patches, and it wasn't in
> my patches.  So I'm not sure what's going on there.

Utter confusion has arisen. Can you put the current versions of your patc=
hes=20
at a well known location (web/ftp/cvs), so we can more easily check and p=
atch=20
against them? That would be great.

The fix-acl patch is on top of either 0.8.50 or 8.0.51. The x_init_acl() =
dirty=20
the inode themselves (at least they should). Initially the x_dirty_inode(=
)=20
calls had been moved below the x_init_acl() calls, but this is no longer=20
necessary, and so the patch moved them up again.

BUG: I have overlooked the dummy implementation of ext[23]_init_acl(). Pl=
ease=20
find attached a corrected version.

> The ext2 change in fix-acl.diff looks *wrong*.  It removes a call to
> mark_inode_dirty which was there in the original, and which is
> necessary.

The original ext2_new_inode with no xattr/acl patches calls mark_inode_di=
rty=20
before unlock_super. This call is not removed in 0.8.50 or 0.8.51, but a=20
second call is added below ext2_init_acl. Since ext2_init_acl takes care =
of=20
dirtying the inode itself this second call is no longer needed (I hope!)

--Andreas.
--------------Boundary-00=_WOJ1CN50FE05WCI523FC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-acl2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-acl2.diff"

--- linux-2.4.19.old/fs/ext3/ialloc.c	2002-10-15 14:18:59.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/ialloc.c	2002-10-15 14:16:34.000000000 +0200
@@ -510,7 +510,9 @@
 	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
 
 	inode->u.ext3_i.i_state = EXT3_STATE_NEW;
-
+	err = ext3_mark_inode_dirty(handle, inode);
+	if (err) goto fail;
+	
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
@@ -522,12 +524,6 @@
 		DQUOT_FREE_INODE(inode);
 		goto fail2;
 	}
-	err = ext3_mark_inode_dirty(handle, inode);
-	if (err) {
-		DQUOT_FREE_INODE(inode);
-		goto fail2;
-	}
-
 	ext3_debug ("allocating inode %lu\n", inode->i_ino);
 	return inode;
 
diff -Nur --exclude='*.orig' linux-2.4.19.old/fs/ext2/ialloc.c linux-2.4.19.new/fs/ext2/ialloc.c
--- linux-2.4.19.old/fs/ext2/ialloc.c	2002-10-15 15:32:24.000000000 +0200
+++ linux-2.4.19.new/fs/ext2/ialloc.c	2002-10-15 15:32:16.000000000 +0200
@@ -410,7 +410,6 @@
 		DQUOT_FREE_INODE(inode);
 		goto fail3;
 	}
-	mark_inode_dirty(inode);
 
 	ext2_debug ("allocating inode %lu\n", inode->i_ino);
 	return inode;
--- linux-2.4.19/fs/ext3/file.c	2002-10-15 22:39:06.000000000 +0200
+++ linux-2.4.19.new/fs/ext3/file.c	2002-10-15 22:34:04.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/locks.h>
+#include <linux/ext3_jbd.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_xattr.h>
--- linux-2.4.19/include/linux/ext2_acl.h	2002-10-15 22:47:09.000000000 +0200
+++ linux-2.4.19.new/include/linux/ext2_acl.h	2002-10-15 22:30:58.000000000 +0200
@@ -87,6 +87,7 @@
 static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
 {
 	inode->i_mode &= ~current->fs->umask;
+	mark_inode_dirty(inode);
 	return 0;
 }
 
--- linux-2.4.19/include/linux/ext3_acl.h	2002-10-15 22:47:16.000000000 +0200
+++ linux-2.4.19.new/include/linux/ext3_acl.h	2002-10-15 22:30:37.000000000 +0200
@@ -90,6 +90,7 @@
 ext3_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
 	inode->i_mode &= ~current->fs->umask;
+	ext3_mark_inode_dirty(handle, inode);
 	return 0;
 }
 

--------------Boundary-00=_WOJ1CN50FE05WCI523FC--

