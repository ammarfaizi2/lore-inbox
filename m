Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269638AbRHMB0P>; Sun, 12 Aug 2001 21:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRHMB0G>; Sun, 12 Aug 2001 21:26:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10635 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269638AbRHMBZr>;
	Sun, 12 Aug 2001 21:25:47 -0400
Date: Sun, 12 Aug 2001 21:25:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/super.c fixes - second series (1/11)
In-Reply-To: <Pine.LNX.4.33.0108102111080.8771-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108110046040.440-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Since the second part of fs/super.c fixes (finally killing the
get_super() races) got public testing in -ac (since 2.4.7-ac6 - i.e. it had
been a week with 0 complaints so far), how about I start feeding it
right now?  That one removes the cruft from FS_SINGLE handling, gives
the final variant of refcounting on superblocks (not dependent upon
mount_sem) and has final (as far as I'm concerned) exclusion on
->s_umount, which closes {u,}mount/get_super races for good.

Basically, after that point we will have sane mount handling. There are
things that can be cleaned up after that, but that's it - trivial cleanups.
Neurosurgery ends here.

Part 1/11

We grab exclusive lock on ->s_umount() in get_sb_...() and release it
once vfsmount is formed (by do_add_mount()). No deadlocks, since all
activity in protected area is already not allowed to lead to anything
that would grab ->s_umount. We hold ->s_lock over the whole non-trivial part
and anything of that kind would deadlock on it.

We are almost done with the get_super() races by now.

diff -urN S9-pre1/fs/super.c S9-pre1-s_umount/fs/super.c
--- S9-pre1/fs/super.c	Sat Aug 11 14:59:24 2001
+++ S9-pre1-s_umount/fs/super.c	Sun Aug 12 20:45:49 2001
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

