Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTAJTYF>; Fri, 10 Jan 2003 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTAJTYF>; Fri, 10 Jan 2003 14:24:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30730 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266991AbTAJTXr>; Fri, 10 Jan 2003 14:23:47 -0500
Date: Fri, 10 Jan 2003 20:32:06 +0100
From: Jan Kara <jack@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030110193206.GA14073@atrey.karlin.mff.cuni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz> <20030106151908.GA640@mail.muni.cz> <20030107164028.GC6719@atrey.karlin.mff.cuni.cz> <20030108012133.GA725@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20030108012133.GA725@mail.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Tue, Jan 07, 2003 at 05:40:28PM +0100, Jan Kara wrote:
> >   Reporting 'No such device' was actually bug which was introduced some
> > time ago but nobody probably noticed it... It was introduce when quota
> > code was converted from device numbers to 'bdev' structures.
> >   I also fixed one bug in quotaon() call however I'm not sure wheter it
> > could cause the freeze. Anyway patch is attached, try it and tell me
> > about the changes.
> 
> Hmm, quotaon / with init=/bin/sh seems to work OK, quota accounting is made and
> repquota displays normal info.
> 
> However with normal startup quotaon / still freezes :-(
  Ok. So I found the bug. Fix was a bit nontrivial (at one path we tried
to acquire one lock twice) but know it should work. The patch also
contain fix in ext2 - at some time ext2_setattr was written and call of
DQUOT_TRANSFER was missing so no quota was being transferred.
  Please test whether the patch works for you.

								Honza

PS: First patch is the one I already sent you.
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.5.54-1-lockfix.diff"

diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54/fs/dquot.c linux-2.5.54-1-lockfix/fs/dquot.c
--- linux-2.5.54/fs/dquot.c	Mon Jan  6 21:54:10 2003
+++ linux-2.5.54-1-lockfix/fs/dquot.c	Thu Jan  9 10:10:55 2003
@@ -1157,6 +1157,7 @@
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_format_type *fmt = find_quota_format(format_id);
 	int error;
+	unsigned int oldflags;
 
 	if (!fmt)
 		return -ESRCH;
@@ -1181,10 +1182,11 @@
 		error = -EBUSY;
 		goto out_lock;
 	}
+	oldflags = inode->i_flags;
 	dqopt->files[type] = f;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
-		goto out_lock;
+		goto out_file_init;
 	/* We don't want quota on quota files */
 	dquot_drop_nolock(inode);
 	inode->i_flags |= S_NOQUOTA;
@@ -1194,7 +1196,7 @@
 	down(&dqopt->dqio_sem);
 	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0) {
 		up(&dqopt->dqio_sem);
-		goto out_lock;
+		goto out_file_init;
 	}
 	up(&dqopt->dqio_sem);
 	set_enable_flags(dqopt, type);
@@ -1204,9 +1206,10 @@
 	up_write(&dqopt->dqoff_sem);
 	return 0;
 
-out_lock:
-	inode->i_flags &= ~S_NOQUOTA;
+out_file_init:
+	inode->i_flags = oldflags;
 	dqopt->files[type] = NULL;
+out_lock:
 	up_write(&dqopt->dqoff_sem);
 out_f:
 	filp_close(f, NULL);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54/fs/quota.c linux-2.5.54-1-lockfix/fs/quota.c
--- linux-2.5.54/fs/quota.c	Tue Jan  7 00:47:58 2003
+++ linux-2.5.54-1-lockfix/fs/quota.c	Thu Jan  9 10:11:15 2003
@@ -114,7 +114,11 @@
 	ret = user_path_walk(path, &nd);
 	if (ret)
 		goto out;
-
+	ret = bd_acquire(nd.dentry->d_inode);
+	if (ret) {
+		path_release(&nd);
+		goto out;
+	}
 	bdev = nd.dentry->d_inode->i_bdev;
 	mode = nd.dentry->d_inode->i_mode;
 	path_release(&nd);

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.5.54-2-offsem.diff"

diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54-1-lockfix/fs/dquot.c linux-2.5.54-2-offsem/fs/dquot.c
--- linux-2.5.54-1-lockfix/fs/dquot.c	Thu Jan  9 10:10:55 2003
+++ linux-2.5.54-2-offsem/fs/dquot.c	Fri Jan 10 01:08:57 2003
@@ -159,7 +159,7 @@
  * Note that any operation which operates on dquot data (ie. dq_dqb) must
  * hold dq_data_lock.
  *
- * Any operation working with dquots must hold dqoff_sem. If operation is
+ * Any operation working with dquots must hold dqptr_sem. If operation is
  * just reading pointers from inodes than read lock is enough. If pointers
  * are altered function must hold write lock.
  *
@@ -270,7 +270,7 @@
 }
 
 /* Invalidate all dquots on the list. Note that this function is called after
- * quota is disabled so no new quota might be created. Because we hold dqoff_sem
+ * quota is disabled so no new quota might be created. Because we hold dqptr_sem
  * for writing and pointers were already removed from inodes we actually know that
  * no quota for this sb+type should be held. */
 static void invalidate_dquots(struct super_block *sb, int type)
@@ -287,7 +287,7 @@
 		if (dquot->dq_type != type)
 			continue;
 #ifdef __DQUOT_PARANOIA	
-		/* There should be no users of quota - we hold dqoff_sem for writing */
+		/* There should be no users of quota - we hold dqptr_sem for writing */
 		if (atomic_read(&dquot->dq_count))
 			BUG();
 #endif
@@ -307,7 +307,7 @@
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
 
-	down_read(&dqopt->dqoff_sem);
+	down_read(&dqopt->dqptr_sem);
 restart:
 	/* At this point any dirty dquot will definitely be written so we can clear
 	   dirty flag from info */
@@ -340,7 +340,7 @@
 	spin_lock(&dq_list_lock);
 	dqstats.syncs++;
 	spin_unlock(&dq_list_lock);
-	up_read(&dqopt->dqoff_sem);
+	up_read(&dqopt->dqptr_sem);
 
 	return 0;
 }
@@ -427,7 +427,7 @@
 /*
  * Put reference to dquot
  * NOTE: If you change this function please check whether dqput_blocks() works right...
- * MUST be called with dqoff_sem held
+ * MUST be called with dqptr_sem held
  */
 static void dqput(struct dquot *dquot)
 {
@@ -492,7 +492,7 @@
 
 /*
  * Get reference to dquot
- * MUST be called with dqoff_sem held
+ * MUST be called with dqptr_sem held
  */
 static struct dquot *dqget(struct super_block *sb, unsigned int id, int type)
 {
@@ -553,7 +553,7 @@
 	return 0;
 }
 
-/* This routine is guarded by dqoff_sem semaphore */
+/* This routine is guarded by dqptr_sem semaphore */
 static void add_dquot_ref(struct super_block *sb, int type)
 {
 	struct list_head *p;
@@ -586,7 +586,7 @@
 }
 
 /* Remove references to dquots from inode - add dquot to list for freeing if needed */
-/* We can't race with anybody because we hold dqoff_sem for writing... */
+/* We can't race with anybody because we hold dqptr_sem for writing... */
 int remove_inode_dquot_ref(struct inode *inode, int type, struct list_head *tofree_head)
 {
 	struct dquot *dquot = inode->i_dquot[type];
@@ -829,10 +829,10 @@
 	unsigned int id = 0;
 	int cnt;
 
-	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
-	/* Having dqoff lock we know NOQUOTA flags can't be altered... */
+	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	/* Having dqptr_sem we know NOQUOTA flags can't be altered... */
 	if (IS_NOQUOTA(inode)) {
-		up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+		up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 		return;
 	}
 	/* Build list of quotas to initialize... */
@@ -853,7 +853,7 @@
 				inode->i_flags |= S_QUOTA;
 		}
 	}
-	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 }
 
 /*
@@ -876,9 +876,9 @@
 
 void dquot_drop(struct inode *inode)
 {
-	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	dquot_drop_nolock(inode);
-	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 }
 
 /*
@@ -892,7 +892,7 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 
-	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -910,7 +910,7 @@
 warn_put_all:
 	spin_unlock(&dq_data_lock);
 	flush_warnings(inode->i_dquot, warntype);
-	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
 }
 
@@ -924,7 +924,7 @@
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
-	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -942,7 +942,7 @@
 warn_put_all:
 	spin_unlock(&dq_data_lock);
 	flush_warnings((struct dquot **)inode->i_dquot, warntype);
-	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
 }
 
@@ -953,7 +953,7 @@
 {
 	unsigned int cnt;
 
-	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -962,7 +962,7 @@
 	}
 	inode_sub_bytes(inode, number);
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 }
 
 /*
@@ -972,7 +972,7 @@
 {
 	unsigned int cnt;
 
-	down_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
@@ -980,7 +980,7 @@
 		dquot_decr_inodes(inode->i_dquot[cnt], number);
 	}
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 }
 
 /*
@@ -1002,7 +1002,7 @@
 		transfer_to[cnt] = transfer_from[cnt] = NODQUOT;
 		warntype[cnt] = NOWARN;
 	}
-	down_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	if (IS_NOQUOTA(inode))	/* File without quota accounting? */
 		goto warn_put_all;
 	/* First build the transfer_to list - here we can block on reading of dquots... */
@@ -1058,7 +1058,7 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (transfer_from[cnt] != NODQUOT)
 			dqput(transfer_from[cnt]);
-	up_write(&sb_dqopt(inode->i_sb)->dqoff_sem);
+	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
 }
 
@@ -1114,7 +1114,8 @@
 		goto out;
 
 	/* We need to serialize quota_off() for device */
-	down_write(&dqopt->dqoff_sem);
+	down(&dqopt->dqonoff_sem);
+	down_write(&dqopt->dqptr_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
 			continue;
@@ -1145,7 +1146,8 @@
 		dqopt->info[cnt].dqi_bgrace = 0;
 		dqopt->ops[cnt] = NULL;
 	}
-	up_write(&dqopt->dqoff_sem);
+	up_write(&dqopt->dqptr_sem);
+	up(&dqopt->dqonoff_sem);
 out:
 	return 0;
 }
@@ -1177,7 +1179,8 @@
 	if (!S_ISREG(inode->i_mode))
 		goto out_f;
 
-	down_write(&dqopt->dqoff_sem);
+	down(&dqopt->dqonoff_sem);
+	down_write(&dqopt->dqptr_sem);
 	if (sb_has_quota_enabled(sb, type)) {
 		error = -EBUSY;
 		goto out_lock;
@@ -1200,17 +1203,19 @@
 	}
 	up(&dqopt->dqio_sem);
 	set_enable_flags(dqopt, type);
+	up_write(&dqopt->dqptr_sem);
 
 	add_dquot_ref(sb, type);
+	up(&dqopt->dqonoff_sem);
 
-	up_write(&dqopt->dqoff_sem);
 	return 0;
 
 out_file_init:
 	inode->i_flags = oldflags;
 	dqopt->files[type] = NULL;
 out_lock:
-	up_write(&dqopt->dqoff_sem);
+	up_write(&dqopt->dqptr_sem);
+	up(&dqopt->dqonoff_sem);
 out_f:
 	filp_close(f, NULL);
 out_fmt:
@@ -1241,14 +1246,14 @@
 {
 	struct dquot *dquot;
 
-	down_read(&sb_dqopt(sb)->dqoff_sem);
+	down_read(&sb_dqopt(sb)->dqptr_sem);
 	if (!(dquot = dqget(sb, id, type))) {
-		up_read(&sb_dqopt(sb)->dqoff_sem);
+		up_read(&sb_dqopt(sb)->dqptr_sem);
 		return -ESRCH;
 	}
 	do_get_dqblk(dquot, di);
 	dqput(dquot);
-	up_read(&sb_dqopt(sb)->dqoff_sem);
+	up_read(&sb_dqopt(sb)->dqptr_sem);
 	return 0;
 }
 
@@ -1310,14 +1315,14 @@
 {
 	struct dquot *dquot;
 
-	down_read(&sb_dqopt(sb)->dqoff_sem);
+	down_read(&sb_dqopt(sb)->dqptr_sem);
 	if (!(dquot = dqget(sb, id, type))) {
-		up_read(&sb_dqopt(sb)->dqoff_sem);
+		up_read(&sb_dqopt(sb)->dqptr_sem);
 		return -ESRCH;
 	}
 	do_set_dqblk(dquot, di);
 	dqput(dquot);
-	up_read(&sb_dqopt(sb)->dqoff_sem);
+	up_read(&sb_dqopt(sb)->dqptr_sem);
 	return 0;
 }
 
@@ -1326,9 +1331,9 @@
 {
 	struct mem_dqinfo *mi;
   
-	down_read(&sb_dqopt(sb)->dqoff_sem);
+	down_read(&sb_dqopt(sb)->dqptr_sem);
 	if (!sb_has_quota_enabled(sb, type)) {
-		up_read(&sb_dqopt(sb)->dqoff_sem);
+		up_read(&sb_dqopt(sb)->dqptr_sem);
 		return -ESRCH;
 	}
 	mi = sb_dqopt(sb)->info + type;
@@ -1338,7 +1343,7 @@
 	ii->dqi_flags = mi->dqi_flags & DQF_MASK;
 	ii->dqi_valid = IIF_ALL;
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(sb)->dqoff_sem);
+	up_read(&sb_dqopt(sb)->dqptr_sem);
 	return 0;
 }
 
@@ -1347,9 +1352,9 @@
 {
 	struct mem_dqinfo *mi;
 
-	down_read(&sb_dqopt(sb)->dqoff_sem);
+	down_read(&sb_dqopt(sb)->dqptr_sem);
 	if (!sb_has_quota_enabled(sb, type)) {
-		up_read(&sb_dqopt(sb)->dqoff_sem);
+		up_read(&sb_dqopt(sb)->dqptr_sem);
 		return -ESRCH;
 	}
 	mi = sb_dqopt(sb)->info + type;
@@ -1362,7 +1367,7 @@
 		mi->dqi_flags = (mi->dqi_flags & ~DQF_MASK) | (ii->dqi_flags & DQF_MASK);
 	mark_info_dirty(mi);
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(sb)->dqoff_sem);
+	up_read(&sb_dqopt(sb)->dqptr_sem);
 	return 0;
 }
 
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54-1-lockfix/fs/ext2/inode.c linux-2.5.54-2-offsem/fs/ext2/inode.c
--- linux-2.5.54-1-lockfix/fs/ext2/inode.c	Mon Jan  6 21:53:37 2003
+++ linux-2.5.54-2-offsem/fs/ext2/inode.c	Fri Jan 10 01:04:02 2003
@@ -1238,6 +1238,12 @@
 	error = inode_change_ok(inode, iattr);
 	if (error)
 		return error;
+	if ((iattr->ia_valid & ATTR_UID && iattr->ia_uid != inode->i_uid) ||
+	    (iattr->ia_valid & ATTR_GID && iattr->ia_gid != inode->i_gid)) {
+		error = DQUOT_TRANSFER(inode, iattr) ? -EDQUOT : 0;
+		if (error)
+			return error;
+	}
 	inode_setattr(inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
 		error = ext2_acl_chmod(inode);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54-1-lockfix/fs/quota.c linux-2.5.54-2-offsem/fs/quota.c
--- linux-2.5.54-1-lockfix/fs/quota.c	Thu Jan  9 10:11:15 2003
+++ linux-2.5.54-2-offsem/fs/quota.c	Thu Jan  9 23:27:24 2003
@@ -156,13 +156,13 @@
 		case Q_GETFMT: {
 			__u32 fmt;
 
-			down_read(&sb_dqopt(sb)->dqoff_sem);
+			down_read(&sb_dqopt(sb)->dqptr_sem);
 			if (!sb_has_quota_enabled(sb, type)) {
-				up_read(&sb_dqopt(sb)->dqoff_sem);
+				up_read(&sb_dqopt(sb)->dqptr_sem);
 				return -ESRCH;
 			}
 			fmt = sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id;
-			up_read(&sb_dqopt(sb)->dqoff_sem);
+			up_read(&sb_dqopt(sb)->dqptr_sem);
 			if (copy_to_user(addr, &fmt, sizeof(fmt)))
 				return -EFAULT;
 			return 0;
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54-1-lockfix/fs/super.c linux-2.5.54-2-offsem/fs/super.c
--- linux-2.5.54-1-lockfix/fs/super.c	Mon Jan  6 21:54:11 2003
+++ linux-2.5.54-2-offsem/fs/super.c	Thu Jan  9 23:26:50 2003
@@ -71,7 +71,8 @@
 		atomic_set(&s->s_active, 1);
 		sema_init(&s->s_vfs_rename_sem,1);
 		sema_init(&s->s_dquot.dqio_sem, 1);
-		init_rwsem(&s->s_dquot.dqoff_sem);
+		sema_init(&s->s_dquot.dqonoff_sem, 1);
+		init_rwsem(&s->s_dquot.dqptr_sem);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54-1-lockfix/include/linux/quota.h linux-2.5.54-2-offsem/include/linux/quota.h
--- linux-2.5.54-1-lockfix/include/linux/quota.h	Mon Jan  6 21:54:13 2003
+++ linux-2.5.54-2-offsem/include/linux/quota.h	Thu Jan  9 23:25:05 2003
@@ -280,7 +280,8 @@
 struct quota_info {
 	unsigned int flags;			/* Flags for diskquotas on this device */
 	struct semaphore dqio_sem;		/* lock device while I/O in progress */
-	struct rw_semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on device and ops using quota_info struct, pointers from inode to dquots */
+	struct semaphore dqonoff_sem;		/* Serialize quotaon & quotaoff */
+	struct rw_semaphore dqptr_sem;		/* serialize ops using quota_info struct, pointers from inode to dquots */
 	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */

--3V7upXqbjpZ4EhLz--
