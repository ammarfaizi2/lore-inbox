Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269960AbRHNBbn>; Mon, 13 Aug 2001 21:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269961AbRHNBbd>; Mon, 13 Aug 2001 21:31:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49623 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269960AbRHNBbU>;
	Mon, 13 Aug 2001 21:31:20 -0400
Date: Mon, 13 Aug 2001 21:31:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/11) fs/super.c fixes
Message-ID: <Pine.GSO.4.21.0108132126270.10579-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, I'm resending the second series of superblock handling
fixes. There are 11 chunks (the largest being 5Kb) - I'm sending each
of them in a separate mail (with descriptions). This stuff finally
closes the get_super() races and seriously cleans superblock handling.
It had been in -ac for a while (and got more than a month of testing on
local boxen). Please, apply.

Part 1/11

We grab exclusive lock on ->s_umount() in get_sb_...() and release it
once vfsmount is formed (by do_add_mount()). No deadlocks, since all
activity in protected area is already not allowed to lead to anything
that would grab ->s_umount. We hold ->s_lock over the whole non-trivial part
and anything of that kind would deadlock on it.

We are almost done with the get_super() races by now.

diff -urN S9-pre3/fs/super.c S9-pre3-s_umount/fs/super.c
--- S9-pre3/fs/super.c	Sat Aug 11 14:59:24 2001
+++ S9-pre3-s_umount/fs/super.c	Mon Aug 13 21:21:26 2001
@@ -820,6 +820,7 @@
 	spin_lock(&sb_lock);
 	list_add (&s->s_list, super_blocks.prev);
 	spin_unlock(&sb_lock);
+	down_write(&s->s_umount);
 	lock_super(s);
 	if (!type->read_super(s, data, silent))
 		goto out_fail;
@@ -839,7 +840,7 @@
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
 	spin_unlock(&sb_lock);
-	__put_super(s);
+	put_super(s);
 	return NULL;
 }
 
@@ -919,7 +920,9 @@
 				spin_unlock(&sb_lock);
 			}
 			atomic_inc(&sb->s_active);
+			/* Next chunk will drop it */
 			up_read(&sb->s_umount);
+			down_write(&sb->s_umount);
 			path_release(&nd);
 			return sb;
 		}
@@ -986,6 +989,7 @@
 		BUG();
 	atomic_inc(&sb->s_active);
 	do_remount_sb(sb, flags, data);
+	down_write(&sb->s_umount);
 	return sb;
 }
 
@@ -1104,6 +1108,7 @@
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
 	type->kern_mnt = mnt;
+	up_write(&sb->s_umount);
 	return mnt;
 }
 
@@ -1379,6 +1384,7 @@
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
+	up_write(&sb->s_umount);
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
@@ -1639,6 +1645,7 @@
 		fs_type = sb->s_type;
 		atomic_inc(&sb->s_active);
 		up_read(&sb->s_umount);
+		down_write(&sb->s_umount);
 		goto mount_it;
 	}
 
@@ -1659,6 +1666,8 @@
 	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
 
 mount_it:
+	/* FIXME */
+	up_write(&sb->s_umount);
 	printk ("VFS: Mounted root (%s filesystem)%s.\n",
 		fs_type->name,
 		(sb->s_flags & MS_RDONLY) ? " readonly" : "");

