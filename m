Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287381AbSAGX2f>; Mon, 7 Jan 2002 18:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287379AbSAGX23>; Mon, 7 Jan 2002 18:28:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12819 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287375AbSAGX2S>;
	Mon, 7 Jan 2002 18:28:18 -0500
Message-ID: <3C3A2F0E.4A132214@mandrakesoft.com>
Date: Mon, 07 Jan 2002 18:28:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: [PATCH 7/7 v2] Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <Pine.GSO.4.21.0201071401450.6842-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------056ABEED1D18E973EECE4C0B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------056ABEED1D18E973EECE4C0B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:
> a) if you make struct inode a part of ext2_inode - WTF bother with pointer?

ok, nobody likes the pointer but me, gone :)

> b) ->destroy_inode() / ->clear_inode().  Merge them - that way it's one
> method.

I believe this belongs in a separate patch after my 1-7, because this
involves breaking some other filesystems.  easier migration -step- if we
add, then shoot me if clear_inode is not destroyed by the end of 2.5.x.


> c) get_empty_inode() must die.  Make it new_inode() and be done with that.
> And have socket.c explicitly set ->i_dev to NODEV afterwards.

done


> d) ext2/balloc.c cleanup probably should be merged before.

hum...  if you are sending one patch for this to linus, I would say
after, but if you are breaking the cleanup into all the steps in
balloc.c,v then I agree with you.

> We will need to set very strict rules on passing around/storing pointers to
> ext2_inode and its ilk, though.  There will be bugs when somebody just decides
> that keeping such pointers might be a good idea and forgets to be nice with
> ->i_count.  Or decrement it manually instead of calling iput(), etc.
> 
> It _MUST_ be explicitly documented - preferably beaten into skulls.

documented in patch6.

Updated patch7 attached (the "meat" of the changes).  For updated
patches 1-7, grab them from kernel.org at

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.2-pre9-jg1.tar.bz2

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
--------------056ABEED1D18E973EECE4C0B
Content-Type: text/plain; charset=us-ascii;
 name="ext2-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2-7.patch"

diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/dir.c linux-fs7/fs/ext2/dir.c
--- linux-fs6/fs/ext2/dir.c	Mon Jan  7 07:32:28 2002
+++ linux-fs7/fs/ext2/dir.c	Mon Jan  7 22:48:42 2002
@@ -24,7 +24,6 @@
 #include <linux/fs.h>
 #include "ext2_fs.h"
 #include "ext2_fs_sb.h"
-#include "ext2_fs_i.h"
 #include <linux/pagemap.h>
 
 typedef struct ext2_dir_entry_2 ext2_dirent;
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ext2_fs.h linux-fs7/fs/ext2/ext2_fs.h
--- linux-fs6/fs/ext2/ext2_fs.h	Mon Jan  7 07:54:33 2002
+++ linux-fs7/fs/ext2/ext2_fs.h	Mon Jan  7 22:49:48 2002
@@ -17,7 +17,9 @@
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/list.h>
 #include <linux/slab.h>
+#include "ext2_fs_i.h"
 
 /*
  * The second extended filesystem constants/structures
@@ -581,12 +583,15 @@
 extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 
 /* inode.c */
+#define ext2_inode_entry(inode) \
+	list_entry((inode), struct ext2_inode_info, i_inode_data)
 
 static inline struct ext2_inode_info *ext2_i(struct inode *inode)
 {
-	if (!inode->u.ext2_ip)
+	struct ext2_inode_info *ei = ext2_inode_entry(inode);
+	if (!ei)
 		BUG();
-	return inode->u.ext2_ip;
+	return ei;
 }
 
 extern void ext2_read_inode (struct inode *);
@@ -596,7 +601,8 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
-extern void ext2_clear_inode (struct inode *inode);
+extern struct inode *ext2_alloc_inode (struct super_block *sb);
+extern void ext2_destroy_inode (struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ext2_fs_i.h linux-fs7/fs/ext2/ext2_fs_i.h
--- linux-fs6/fs/ext2/ext2_fs_i.h	Mon Sep 17 20:16:30 2001
+++ linux-fs7/fs/ext2/ext2_fs_i.h	Mon Jan  7 05:08:38 2002
@@ -36,6 +36,10 @@
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
+
+#ifdef __KERNEL__
+	struct inode i_inode_data;
+#endif
 };
 
 #endif	/* _LINUX_EXT2_FS_I */
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ialloc.c linux-fs7/fs/ext2/ialloc.c
--- linux-fs6/fs/ext2/ialloc.c	Mon Jan  7 08:58:19 2002
+++ linux-fs7/fs/ext2/ialloc.c	Mon Jan  7 22:48:50 2002
@@ -16,7 +16,6 @@
 #include <linux/fs.h>
 #include "ext2_fs.h"
 #include "ext2_fs_sb.h"
-#include "ext2_fs_i.h"
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
@@ -317,7 +316,8 @@
 
 struct inode * ext2_new_inode (const struct inode * dir, int mode)
 {
-	const struct ext2_inode_info *di = dir->u.ext2_ip;
+	const struct ext2_inode_info *di =
+		(const struct ext2_inode_info *) ext2_inode_entry(dir);
 	struct ext2_inode_info *ei;
 	struct super_block * sb;
 	struct buffer_head * bh;
@@ -335,18 +335,7 @@
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-
-	/* allocate private per-inode info.  note that for
-	 * the error cases below, iput and s_op->clear_inode
-	 * will handle freeing the private area.
-	 */
-	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
-	if (!inode->u.ext2_ip) {
-		err = -ENOMEM;
-		goto no_priv;
-	}
-	ei = inode->u.ext2_ip;
-	memset(ei, 0, sizeof(*ei));
+	ei = ext2_i(inode);
 
 	lock_super (sb);
 
@@ -439,7 +428,6 @@
 	mark_buffer_dirty(bh2);
 fail:
 	unlock_super(sb);
-no_priv:
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/inode.c linux-fs7/fs/ext2/inode.c
--- linux-fs6/fs/ext2/inode.c	Mon Jan  7 09:20:19 2002
+++ linux-fs7/fs/ext2/inode.c	Mon Jan  7 22:48:55 2002
@@ -25,7 +25,6 @@
 #include <linux/fs.h>
 #include "ext2_fs.h"
 #include "ext2_fs_sb.h"
-#include "ext2_fs_i.h"
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/sched.h>
@@ -37,7 +36,7 @@
 MODULE_DESCRIPTION("Second Extended Filesystem");
 MODULE_LICENSE("GPL");
 
-
+extern void inode_init_once(void *, kmem_cache_t *, unsigned long);
 static int ext2_update_inode(struct inode * inode, int do_sync);
 
 /*
@@ -890,7 +889,7 @@
 {
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *esb = ext2_sb(sb);
-	struct ext2_inode_info *ei;
+	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
 	unsigned long block_group;
@@ -900,12 +899,6 @@
 	unsigned long offset;
 	struct ext2_group_desc * gdp;
 
-	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
-	if (!inode->u.ext2_ip)
-		goto bad_inode;
-	ei = inode->u.ext2_ip;
-	memset(ei, 0, sizeof(*ei));
-
 	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
 	     inode->i_ino != EXT2_ACL_DATA_INO &&
 	     inode->i_ino < EXT2_FIRST_INO(sb)) ||
@@ -1034,10 +1027,6 @@
 	return;
 	
 bad_inode:
-	if (inode->u.ext2_ip) {
-		kmem_cache_free(ext2_ino_cache, inode->u.ext2_ip);
-		inode->u.ext2_ip = NULL;
-	}
 	make_bad_inode(inode);
 	return;
 }
@@ -1181,12 +1170,24 @@
 	return ext2_update_inode (inode, 1);
 }
 
-void ext2_clear_inode (struct inode *inode)
+struct inode *ext2_alloc_inode (struct super_block *sb)
 {
-	struct ext2_inode_info *ei = inode->u.ext2_ip;
+	struct ext2_inode_info *ei;
+	struct inode *inode;
 
-	if (ei) {
-		kmem_cache_free(ext2_ino_cache, ei);
-		inode->u.ext2_ip = NULL;
-	}
+	ei = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
+	if (!ei)
+		return NULL;
+	inode = &ei->i_inode_data;
+
+	memset(ei, 0, sizeof(*ei));
+	inode_init_once(inode, ext2_ino_cache, SLAB_CTOR_CONSTRUCTOR);
+	return inode;
+}
+
+void ext2_destroy_inode (struct inode *inode)
+{
+	struct ext2_inode_info *ei = ext2_i(inode);
+	kmem_cache_free(ext2_ino_cache, ei);
 }
+
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ioctl.c linux-fs7/fs/ext2/ioctl.c
--- linux-fs6/fs/ext2/ioctl.c	Mon Jan  7 07:32:43 2002
+++ linux-fs7/fs/ext2/ioctl.c	Mon Jan  7 22:48:58 2002
@@ -9,7 +9,6 @@
 
 #include <linux/fs.h>
 #include "ext2_fs.h"
-#include "ext2_fs_i.h"
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/namei.c linux-fs7/fs/ext2/namei.c
--- linux-fs6/fs/ext2/namei.c	Mon Jan  7 07:32:47 2002
+++ linux-fs7/fs/ext2/namei.c	Mon Jan  7 22:49:02 2002
@@ -31,7 +31,6 @@
 
 #include <linux/fs.h>
 #include "ext2_fs.h"
-#include "ext2_fs_i.h"
 #include <linux/pagemap.h>
 
 /*
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/super.c linux-fs7/fs/ext2/super.c
--- linux-fs6/fs/ext2/super.c	Mon Jan  7 07:32:50 2002
+++ linux-fs7/fs/ext2/super.c	Mon Jan  7 22:49:05 2002
@@ -22,7 +22,6 @@
 #include <linux/fs.h>
 #include "ext2_fs.h"
 #include "ext2_fs_sb.h"
-#include "ext2_fs_i.h"
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/locks.h>
@@ -160,7 +159,9 @@
 	write_inode:	ext2_write_inode,
 	put_inode:	ext2_put_inode,
 	delete_inode:	ext2_delete_inode,
-	clear_inode:	ext2_clear_inode,
+	alloc_inode:	ext2_alloc_inode,
+	destroy_inode:	ext2_destroy_inode,
+
 	put_super:	ext2_put_super,
 	write_super:	ext2_write_super,
 	statfs:		ext2_statfs,
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/symlink.c linux-fs7/fs/ext2/symlink.c
--- linux-fs6/fs/ext2/symlink.c	Mon Jan  7 07:32:54 2002
+++ linux-fs7/fs/ext2/symlink.c	Mon Jan  7 22:49:08 2002
@@ -19,7 +19,6 @@
 
 #include <linux/fs.h>
 #include "ext2_fs.h"
-#include "ext2_fs_i.h"
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
diff -Naur -X /g/g/lib/dontdiff linux-fs6/include/linux/fs.h linux-fs7/include/linux/fs.h
--- linux-fs6/include/linux/fs.h	Mon Jan  7 22:19:16 2002
+++ linux-fs7/include/linux/fs.h	Mon Jan  7 22:40:37 2002
@@ -313,8 +313,6 @@
 #include <linux/jffs2_fs_i.h>
 #include <linux/cramfs_fs_sb.h>
 
-struct ext2_inode_info;
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -502,8 +500,6 @@
 		struct proc_inode_info		proc_i;
 		struct socket			socket_i;
 		struct jffs2_inode_info		jffs2_i;
-
-		struct ext2_inode_info		*ext2_ip;
 
 		void				*generic_ip;
 	} u;

--------------056ABEED1D18E973EECE4C0B--

