Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVDBBrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVDBBrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVDBBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:47:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56735 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262959AbVDBBpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:45:10 -0500
Subject: [RFC] [PATCH] Set MS_ACTIVE bit before calling ->fill_super
	functions
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: viro@us.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Apr 2005 17:45:00 -0800
Message-Id: <1112406300.25362.100.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes all cases where the MS_ACTIVE bit gets set. This is
done to eliminate a race condition that can occur if an inode is
allocated and then released (using iput) during the ->fill_super
functions. The race condition is between kswapd and mount.

For most filesystems this can only happen in an error path when kswapd
is running concurrently. For isofs, however, the error can occur in a
more common code path (which is how the bug was found).

The changes are fairly straight forward. There are a couple of unique
cases:

ext3_orphan_cleanup() was setting MS_ACTIVE for the CONFIG_QUOTA case.
Since ext3_orphan_cleanup() is only called by ext3_fill_super(), this
is no longer necessary since the MS_ACTIVE will already be set.

Reiserfs:
For the CONFIG_QUOTA case, finish_unfinished() ensures that MS_ACTIVE
is set, and then conditionally turns it off depending on its initial
state.  finish_unfinished() is called by two functions: reiserfs_remount
and reiserfs_fill_super. The MS_ACTIVE flag was previously NOT set for
reiserfs_fill_super, but that has changed now - it will always be
set. The MS_ACTIVE flag is also set in the reiserfs_remount case, so
the manipulation of the MS_ACTIVE in finish_unfinished() is no longer
necessary.

Comments?

- Russ

--- linux-2.6.12-rc1/fs/afs/super.c	2005-03-17 17:34:09.000000000 -0800
+++ linux-2.6.12-rc1-fix2/fs/afs/super.c	2005-04-01 16:31:54.803904510
-0800
@@ -339,15 +339,15 @@ static struct super_block *afs_get_sb(st
 	if (IS_ERR(sb))
 		goto error;
 
-	sb->s_flags = flags;
+	sb->s_flags = flags | MS_ACTIVE;
 
 	ret = afs_fill_super(sb, &params, flags & MS_VERBOSE ? 1 : 0);
 	if (ret < 0) {
+		sb->s_flags &= ~MS_ACTIVE;
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
 		goto error;
 	}
-	sb->s_flags |= MS_ACTIVE;
 
 	afs_put_volume(params.volume);
 	afs_put_cell(params.default_cell);
--- linux-2.6.12-rc1/fs/cifs/cifsfs.c	2005-03-17 17:34:13.000000000
-0800
+++ linux-2.6.12-rc1-fix2/fs/cifs/cifsfs.c	2005-04-01 16:14:26.000000000
-0800
@@ -422,15 +422,15 @@ cifs_get_sb(struct file_system_type *fs_
 	if (IS_ERR(sb))
 		return sb;
 
-	sb->s_flags = flags;
+	sb->s_flags = flags | MS_ACTIVE;
 
 	rc = cifs_read_super(sb, data, dev_name, flags & MS_VERBOSE ? 1 : 0);
 	if (rc) {
+		sb->s_flags &= ~MS_ACTIVE;
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
 		return ERR_PTR(rc);
 	}
-	sb->s_flags |= MS_ACTIVE;
 	return sb;
 }
 
--- linux-2.6.12-rc1/fs/ext3/super.c	2005-03-17 17:34:57.000000000 -0800
+++ linux-2.6.12-rc1-fix2/fs/ext3/super.c	2005-04-01 16:17:05.000000000
-0800
@@ -1121,8 +1121,6 @@ static void ext3_orphan_cleanup (struct 
 		sb->s_flags &= ~MS_RDONLY;
 	}
 #ifdef CONFIG_QUOTA
-	/* Needed for iput() to work correctly and not trash data */
-	sb->s_flags |= MS_ACTIVE;
 	/* Turn on quotas so that they are updated correctly */
 	for (i = 0; i < MAXQUOTAS; i++) {
 		if (EXT3_SB(sb)->s_qf_names[i]) {
--- linux-2.6.12-rc1/fs/jffs2/super.c	2005-03-17 17:34:08.000000000
-0800
+++ linux-2.6.12-rc1-fix2/fs/jffs2/super.c	2005-04-01 15:41:06.000000000
-0800
@@ -141,18 +141,18 @@ static struct super_block *jffs2_get_sb_
 		  mtd->index, mtd->name));
 
 	sb->s_op = &jffs2_super_operations;
-	sb->s_flags = flags | MS_NOATIME;
+	sb->s_flags = flags | MS_NOATIME | MS_ACTIVE;
 
 	ret = jffs2_do_fill_super(sb, data, (flags&MS_VERBOSE)?1:0);
 
 	if (ret) {
 		/* Failure case... */
+		sb->s_flags &= ~MS_ACTIVE;
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
 		return ERR_PTR(ret);
 	}
 
-	sb->s_flags |= MS_ACTIVE;
 	return sb;
 
  out_put:
--- linux-2.6.12-rc1/fs/libfs.c	2005-03-17 17:33:48.000000000 -0800
+++ linux-2.6.12-rc1-fix2/fs/libfs.c	2005-04-01 16:20:30.000000000 -0800
@@ -206,7 +206,7 @@ get_sb_pseudo(struct file_system_type *f
 	if (IS_ERR(s))
 		return s;
 
-	s->s_flags = MS_NOUSER;
+	s->s_flags = MS_NOUSER | MS_ACTIVE;
 	s->s_maxbytes = ~0ULL;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
@@ -228,10 +228,10 @@ get_sb_pseudo(struct file_system_type *f
 	dentry->d_parent = dentry;
 	d_instantiate(dentry, root);
 	s->s_root = dentry;
-	s->s_flags |= MS_ACTIVE;
 	return s;
 
 Enomem:
+	s->s_flags &= ~MS_ACTIVE;
 	up_write(&s->s_umount);
 	deactivate_super(s);
 	return ERR_PTR(-ENOMEM);
--- linux-2.6.12-rc1/fs/nfs/inode.c	2005-03-17 17:34:27.000000000 -0800
+++ linux-2.6.12-rc1-fix2/fs/nfs/inode.c	2005-04-01 15:34:39.000000000
-0800
@@ -1445,7 +1445,7 @@ static struct super_block *nfs_get_sb(st
 		return s;
 	}
 
-	s->s_flags = flags;
+	s->s_flags = flags | MS_ACTIVE;
 
 	/* Fire up rpciod if not yet running */
 	if (rpciod_up() != 0) {
@@ -1456,11 +1456,11 @@ static struct super_block *nfs_get_sb(st
 
 	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
+		s->s_flags &= ~MS_ACTIVE;
 		up_write(&s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
-	s->s_flags |= MS_ACTIVE;
 	return s;
 }
 
@@ -1783,7 +1783,7 @@ static struct super_block *nfs4_get_sb(s
 	if (IS_ERR(s) || s->s_root)
 		goto out_free;
 
-	s->s_flags = flags;
+	s->s_flags = flags | MS_ACTIVE;
 
 	/* Fire up rpciod if not yet running */
 	if (rpciod_up() != 0) {
@@ -1794,11 +1794,11 @@ static struct super_block *nfs4_get_sb(s
 
 	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
+		s->s_flags &= ~MS_ACTIVE;
 		up_write(&s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
-	s->s_flags |= MS_ACTIVE;
 	return s;
 out_err:
 	s = (struct super_block *)p;
--- linux-2.6.12-rc1/fs/reiserfs/super.c	2005-03-17 17:34:10.000000000
-0800
+++ linux-2.6.12-rc1-fix2/fs/reiserfs/super.c	2005-04-01
17:10:03.844698882 -0800
@@ -158,7 +158,6 @@ static int finish_unfinished (struct sup
     int truncate;
 #ifdef CONFIG_QUOTA
     int i;
-    int ms_active_set;
 #endif
  
  
@@ -168,13 +167,6 @@ static int finish_unfinished (struct sup
     max_cpu_key.key_length = 3;
 
 #ifdef CONFIG_QUOTA
-    /* Needed for iput() to work correctly and not trash data */
-    if (s->s_flags & MS_ACTIVE) {
-	    ms_active_set = 0;
-    } else {
-	    ms_active_set = 1;
-	    s->s_flags |= MS_ACTIVE;
-    }
     /* Turn on quotas so that they are updated correctly */
     for (i = 0; i < MAXQUOTAS; i++) {
 	if (REISERFS_SB(s)->s_qf_names[i]) {
@@ -282,9 +274,6 @@ static int finish_unfinished (struct sup
             if (sb_dqopt(s)->files[i])
                     vfs_quota_off_mount(s, i);
     }
-    if (ms_active_set)
-	    /* Restore the flag back */
-	    s->s_flags &= ~MS_ACTIVE;
 #endif
     pathrelse (&path);
     if (done)
--- linux-2.6.12-rc1/fs/super.c	2005-03-17 17:34:10.000000000 -0800
+++ linux-2.6.12-rc1-fix2/fs/super.c	2005-04-01 15:27:52.000000000 -0800
@@ -702,17 +702,17 @@ struct super_block *get_sb_bdev(struct f
 	} else {
 		char b[BDEVNAME_SIZE];
 
-		s->s_flags = flags;
+		s->s_flags = flags | MS_ACTIVE;
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
 		s->s_old_blocksize = block_size(bdev);
 		sb_set_blocksize(s, s->s_old_blocksize);
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
+			s->s_flags &= ~MS_ACTIVE;
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
 		} else {
-			s->s_flags |= MS_ACTIVE;
 			bdev_uevent(bdev, KOBJ_MOUNT);
 		}
 	}
@@ -748,15 +748,15 @@ struct super_block *get_sb_nodev(struct 
 	if (IS_ERR(s))
 		return s;
 
-	s->s_flags = flags;
+	s->s_flags = flags | MS_ACTIVE;
 
 	error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error) {
+		s->s_flags &= ~MS_ACTIVE;
 		up_write(&s->s_umount);
 		deactivate_super(s);
 		return ERR_PTR(error);
 	}
-	s->s_flags |= MS_ACTIVE;
 	return s;
 }
 
@@ -778,14 +778,14 @@ struct super_block *get_sb_single(struct
 	if (IS_ERR(s))
 		return s;
 	if (!s->s_root) {
-		s->s_flags = flags;
+		s->s_flags = flags | MS_ACTIVE;
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
+			s->s_flags &= ~MS_ACTIVE;
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			return ERR_PTR(error);
 		}
-		s->s_flags |= MS_ACTIVE;
 	}
 	do_remount_sb(s, flags, data, 0);
 	return s;

