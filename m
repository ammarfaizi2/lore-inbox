Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282269AbRKWWHQ>; Fri, 23 Nov 2001 17:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282266AbRKWWHJ>; Fri, 23 Nov 2001 17:07:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60146 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282258AbRKWWGw>;
	Fri, 23 Nov 2001 17:06:52 -0500
Date: Fri, 23 Nov 2001 17:06:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <Pine.GSO.4.21.0111231634310.2422-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Nov 2001, Alexander Viro wrote:

> 	Untested fix follows.  And please, pass the brown paperbag... ;-/

... and now for something that really builds:

diff -urN S15/fs/inode.c S15-fix/fs/inode.c
--- S15/fs/inode.c	Fri Nov 23 06:45:43 2001
+++ S15-fix/fs/inode.c	Fri Nov 23 17:04:05 2001
@@ -1065,24 +1065,27 @@
 			if (inode->i_state != I_CLEAR)
 				BUG();
 		} else {
-			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
+			if (!list_empty(&inode->i_hash)) {
 				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
 					list_del(&inode->i_list);
 					list_add(&inode->i_list, &inode_unused);
 				}
 				inodes_stat.nr_unused++;
 				spin_unlock(&inode_lock);
-				return;
-			} else {
-				list_del_init(&inode->i_list);
+				if (!sb || sb->s_flags & MS_ACTIVE)
+					return;
+				write_inode_now(inode, 1);
+				spin_lock(&inode_lock);
+				inodes_stat.nr_unused--;
 				list_del_init(&inode->i_hash);
-				inode->i_state|=I_FREEING;
-				inodes_stat.nr_inodes--;
-				spin_unlock(&inode_lock);
-				if (inode->i_data.nrpages)
-					truncate_inode_pages(&inode->i_data, 0);
-				clear_inode(inode);
 			}
+			list_del_init(&inode->i_list);
+			inode->i_state|=I_FREEING;
+			inodes_stat.nr_inodes--;
+			spin_unlock(&inode_lock);
+			if (inode->i_data.nrpages)
+				truncate_inode_pages(&inode->i_data, 0);
+			clear_inode(inode);
 		}
 		destroy_inode(inode);
 	}
diff -urN S15/fs/super.c S15-fix/fs/super.c
--- S15/fs/super.c	Fri Nov 23 06:45:43 2001
+++ S15-fix/fs/super.c	Fri Nov 23 16:56:50 2001
@@ -462,6 +462,7 @@
 	lock_super(s);
 	if (!type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto out_fail;
+	s->s_flags |= MS_ACTIVE;
 	unlock_super(s);
 	/* tell bdcache that we are going to keep this one */
 	if (bdev)
@@ -614,6 +615,7 @@
 	lock_super(s);
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto out_fail;
+	s->s_flags |= MS_ACTIVE;
 	unlock_super(s);
 	get_filesystem(fs_type);
 	path_release(&nd);
@@ -695,6 +697,7 @@
 		lock_super(s);
 		if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 			goto out_fail;
+		s->s_flags |= MS_ACTIVE;
 		unlock_super(s);
 		get_filesystem(fs_type);
 		return s;
@@ -739,6 +742,7 @@
 	dput(root);
 	fsync_super(sb);
 	lock_super(sb);
+	sb->s_flags &= ~MS_ACTIVE;
 	invalidate_inodes(sb);	/* bad name - it should be evict_inodes() */
 	if (sop) {
 		if (sop->write_super && sb->s_dirt)
diff -urN S15/include/linux/fs.h S15-fix/include/linux/fs.h
--- S15/include/linux/fs.h	Fri Nov 23 06:45:44 2001
+++ S15-fix/include/linux/fs.h	Fri Nov 23 17:01:18 2001
@@ -110,6 +110,7 @@
 #define MS_BIND		4096
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
 /*

