Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSGQBZI>; Tue, 16 Jul 2002 21:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSGQBZH>; Tue, 16 Jul 2002 21:25:07 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:55051 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S318188AbSGQBZB>; Tue, 16 Jul 2002 21:25:01 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Avoid unnecessary d_count/mnt_count dirtying in link_path_walk()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jul 2002 18:27:04 -0700
Message-Id: <E17Udaq-0004x3-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the error return path (including -ENOENT) in link_path_walk(), we
call

	unlock_nd(nd);
	path_release(nd);

This is equivalent to

	mntget(nd->mnt);
	dget_locked(nd->dentry);
	...
	spin_unlock(&dcache_lock);
	...
	dput(nd->dentry);
	mntput(nd->mnt);

The only way that this can have an effect other than bouncing the
d_count and mnt_count cachelines of the last resolved component is if
the dentry d_count reaches 0, and was either unhashed or had a
d_delete() method that returned true (in which case the dentry is thrown
away).

- Since no-one else can decrement the usage count to 0 while we hold
dcache_lock (due to the use of atomic_dec_and_lock() in dput()) this can
only occur if the usage count is zero originally (i.e. before we called
unlock_nd()).

- Since no-one else can unhash the dentry without dcache_lock (which we
hold) the dentry must be hashed if its reference count was originally 0.

- if dentry->d_op->d_delete() exists, then plausibly it could return 1
to request that the dentry by unhashed. But this failed lookup has no
noticable side-effects (other than perhaps setting DCACHE_REFERENCED)
and might easily have not occurred (and hence d_delete() not called). So
we can't lose correctness by not calling d_delete(), (unless the
d_delete() method would have spuriously decided to kill the dentry
purely due to it being marked DCACHE_REFERENCED, but that would be
pretty perverse).

Hence it is safe to skip the dget_locked()/dput().

The original pointer to nd->mnt came either from 

- the current root/pwd (protected by dcache_lock)

- following a mount (protected by dcache_lock)

- was in nd->mnt when we called lock_nd() (and will be released when we
call mntput() on nd->old_mnt.

Hence it is safe to skip the mntget()/mntput()

This patch adds release_locked_nd(), which skips the dget_locked() and
mntget(), and makes use of it in the error .

Paul

diff -X /mnt/elbrus/home/pmenage/dontdiff -Naur linux-2.5.26/fs/namei.c linux-2.5.26-unlocknd/fs/namei.c
--- linux-2.5.26/fs/namei.c	Tue Jul 16 16:49:31 2002
+++ linux-2.5.26-unlocknd/fs/namei.c	Tue Jul 16 17:59:10 2002
@@ -275,17 +275,22 @@
 }
 
 /*for fastwalking*/
-static inline void unlock_nd(struct nameidata *nd)
+static inline void release_locked_nd(struct nameidata *nd)
 {
 	struct vfsmount *mnt = nd->old_mnt;
 	struct dentry *dentry = nd->old_dentry;
-	mntget(nd->mnt);
-	dget_locked(nd->dentry);
 	nd->old_mnt = NULL;
 	nd->old_dentry = NULL;
 	spin_unlock(&dcache_lock);
 	dput(dentry);
 	mntput(mnt);
+}			
+
+static inline void unlock_nd(struct nameidata *nd)
+{
+	mntget(nd->mnt);
+	dget_locked(nd->dentry);
+	release_locked_nd(nd);
 }
 
 static inline void lock_nd(struct nameidata *nd)
@@ -737,8 +742,8 @@
 		mntput(pinned.mnt);
 		return 0;
 	}
-	unlock_nd(nd);
-	path_release(nd);
+
+	release_locked_nd(nd);
 return_err:
 	dput(pinned.dentry);
 	mntput(pinned.mnt);


