Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293547AbSCCJ6V>; Sun, 3 Mar 2002 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSCCJ53>; Sun, 3 Mar 2002 04:57:29 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:41228 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293539AbSCCJ4s>; Sun, 3 Mar 2002 04:56:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 7
Date: Sun, 3 Mar 2002 04:57:07 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095625Z293047-31625+7@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh of 13 patches.


	This moves the quota control to quota.c and places the quota_ctl code there 
as well as migrates to the dqdb structure.



diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Makefile 
linux-2.5/fs/Makefile
--- linux-2.5-linus/fs/Makefile	Sat Mar  2 19:23:11 2002
+++ linux-2.5/fs/Makefile	Sat Mar  2 19:45:49 2002
@@ -14,12 +14,10 @@
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o seq_file.o xattr.o
+		filesystems.o namespace.o seq_file.o xattr.o quota.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
-else
-obj-y += noquot.o
 endif
 
 subdir-$(CONFIG_PROC_FS)	+= proc
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sun Mar  3 03:07:55 2002
+++ linux-2.5/fs/dquot.c	Sun Mar  3 02:59:36 2002
@@ -61,12 +61,12 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/quotaops.h>
 
 #include <asm/uaccess.h>
 
-int nr_dquots, nr_free_dquots;
-
 static char *quotatypes[] = INITQFNAMES;
 static struct quota_format_type *quota_formats;	/* List of registered 
formats */
 
@@ -96,10 +96,18 @@
 
 	lock_kernel();
 	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = 
actqf->qf_next);
+	if (actqf && !try_inc_mod_count(actqf->qf_owner))
+		actqf = NULL;
 	unlock_kernel();
 	return actqf;
 }
 
+static void put_quota_format(struct quota_format_type *fmt)
+{
+	if (fmt->qf_owner)
+		__MOD_DEC_USE_COUNT(fmt->qf_owner);
+}
+
 /*
  * Dquot List Management:
  * The quota code uses three lists for dquot management: the inuse_list,
@@ -140,27 +148,11 @@
 static LIST_HEAD(free_dquots);
 static struct list_head dquot_hash[NR_DQHASH];
 
-static struct dqstats dqstats;
+struct dqstats dqstats;
 
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
 
-static inline char is_enabled(struct quota_info *dqopt, short type)
-{
-	switch (type) {
-		case USRQUOTA:
-			return((dqopt->flags & DQUOT_USR_ENABLED) != 0);
-		case GRPQUOTA:
-			return((dqopt->flags & DQUOT_GRP_ENABLED) != 0);
-	}
-	return(0);
-}
-
-static inline char sb_has_quota_enabled(struct super_block *sb, short type)
-{
-	return is_enabled(sb_dqopt(sb), type);
-}
-
 static inline void get_dquot_ref(struct dquot *dquot)
 {
 	dquot->dq_count++;
@@ -404,6 +396,7 @@
 		dqput(dquot);
 		goto restart;
 	}
+	/* FIXME: Here we should also sync all file info */
 	dqstats.syncs++;
 	unlock_kernel();
 	return 0;
@@ -619,9 +612,6 @@
 {
 	struct list_head *p;
 
-	if (!sb->dq_op)
-		return;	/* nothing to do */
-
 restart:
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
@@ -699,36 +689,36 @@
 
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long 
number)
 {
-	dquot->dq_curinodes += number;
+	dquot->dq_dqb.dqb_curinodes += number;
 	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_incr_space(struct dquot *dquot, qsize_t number)
 {
-	dquot->dq_curspace += number;
+	dquot->dq_dqb.dqb_curspace += number;
 	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_inodes(struct dquot *dquot, unsigned long 
number)
 {
-	if (dquot->dq_curinodes > number)
-		dquot->dq_curinodes -= number;
+	if (dquot->dq_dqb.dqb_curinodes > number)
+		dquot->dq_dqb.dqb_curinodes -= number;
 	else
-		dquot->dq_curinodes = 0;
-	if (dquot->dq_curinodes < dquot->dq_isoftlimit)
-		dquot->dq_itime = (time_t) 0;
+		dquot->dq_dqb.dqb_curinodes = 0;
+	if (dquot->dq_dqb.dqb_curinodes < dquot->dq_dqb.dqb_isoftlimit)
+		dquot->dq_dqb.dqb_itime = (time_t) 0;
 	dquot->dq_flags &= ~DQ_INODES;
 	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_space(struct dquot *dquot, qsize_t number)
 {
-	if (dquot->dq_curspace > number)
-		dquot->dq_curspace -= number;
+	if (dquot->dq_dqb.dqb_curspace > number)
+		dquot->dq_dqb.dqb_curspace -= number;
 	else
-		dquot->dq_curspace = 0;
-	if (toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit)
-		dquot->dq_btime = (time_t) 0;
+		dquot->dq_dqb.dqb_curspace = 0;
+	if (toqb(dquot->dq_dqb.dqb_curspace) < dquot->dq_dqb.dqb_bsoftlimit)
+		dquot->dq_dqb.dqb_btime = (time_t) 0;
 	dquot->dq_flags &= ~DQ_BLKS;
 	mark_dquot_dirty(dquot);
 }
@@ -812,26 +802,26 @@
 	if (inodes <= 0 || dquot->dq_flags & DQ_FAKE)
 		return QUOTA_OK;
 
-	if (dquot->dq_ihardlimit &&
-	   (dquot->dq_curinodes + inodes) > dquot->dq_ihardlimit &&
+	if (dquot->dq_dqb.dqb_ihardlimit &&
+	   (dquot->dq_dqb.dqb_curinodes + inodes) > dquot->dq_dqb.dqb_ihardlimit &&
             !ignore_hardlimit(dquot)) {
 		*warntype = IHARDWARN;
 		return NO_QUOTA;
 	}
 
-	if (dquot->dq_isoftlimit &&
-	   (dquot->dq_curinodes + inodes) > dquot->dq_isoftlimit &&
-	    dquot->dq_itime && CURRENT_TIME >= dquot->dq_itime &&
+	if (dquot->dq_dqb.dqb_isoftlimit &&
+	   (dquot->dq_dqb.dqb_curinodes + inodes) > dquot->dq_dqb.dqb_isoftlimit &&
+	    dquot->dq_dqb.dqb_itime && CURRENT_TIME >= dquot->dq_dqb.dqb_itime &&
             !ignore_hardlimit(dquot)) {
 		*warntype = ISOFTLONGWARN;
 		return NO_QUOTA;
 	}
 
-	if (dquot->dq_isoftlimit &&
-	   (dquot->dq_curinodes + inodes) > dquot->dq_isoftlimit &&
-	    dquot->dq_itime == 0) {
+	if (dquot->dq_dqb.dqb_isoftlimit &&
+	   (dquot->dq_dqb.dqb_curinodes + inodes) > dquot->dq_dqb.dqb_isoftlimit &&
+	    dquot->dq_dqb.dqb_itime == 0) {
 		*warntype = ISOFTWARN;
-		dquot->dq_itime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
+		dquot->dq_dqb.dqb_itime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
 	}
 
 	return QUOTA_OK;
@@ -843,29 +833,29 @@
 	if (space <= 0 || dquot->dq_flags & DQ_FAKE)
 		return QUOTA_OK;
 
-	if (dquot->dq_bhardlimit &&
-	   toqb(dquot->dq_curspace + space) > dquot->dq_bhardlimit &&
+	if (dquot->dq_dqb.dqb_bhardlimit &&
+	   toqb(dquot->dq_dqb.dqb_curspace + space) > dquot->dq_dqb.dqb_bhardlimit 
&&
             !ignore_hardlimit(dquot)) {
 		if (!prealloc)
 			*warntype = BHARDWARN;
 		return NO_QUOTA;
 	}
 
-	if (dquot->dq_bsoftlimit &&
-	   toqb(dquot->dq_curspace + space) > dquot->dq_bsoftlimit &&
-	    dquot->dq_btime && CURRENT_TIME >= dquot->dq_btime &&
+	if (dquot->dq_dqb.dqb_bsoftlimit &&
+	   toqb(dquot->dq_dqb.dqb_curspace + space) > dquot->dq_dqb.dqb_bsoftlimit 
&&
+	    dquot->dq_dqb.dqb_btime && CURRENT_TIME >= dquot->dq_dqb.dqb_btime &&
             !ignore_hardlimit(dquot)) {
 		if (!prealloc)
 			*warntype = BSOFTLONGWARN;
 		return NO_QUOTA;
 	}
 
-	if (dquot->dq_bsoftlimit &&
-	   toqb(dquot->dq_curspace + space) > dquot->dq_bsoftlimit &&
-	    dquot->dq_btime == 0) {
+	if (dquot->dq_dqb.dqb_bsoftlimit &&
+	   toqb(dquot->dq_dqb.dqb_curspace + space) > dquot->dq_dqb.dqb_bsoftlimit 
&&
+	    dquot->dq_dqb.dqb_btime == 0) {
 		if (!prealloc) {
 			*warntype = BSOFTWARN;
-			dquot->dq_btime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
+			dquot->dq_dqb.dqb_btime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
 		}
 		else
 			/*
@@ -1199,10 +1189,9 @@
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
  */
-int quota_off(struct super_block *sb, short type)
+int vfs_quota_off(struct super_block *sb, int type)
 {
-	struct file *filp;
-	short cnt;
+	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 
 	lock_kernel();
@@ -1222,17 +1211,17 @@
 		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb, cnt);
                 if (info_dirty(&dqopt->info[cnt]))
-                        dqopt->ops[cnt]->write_file_info(sb, cnt);
+			dqopt->ops[cnt]->write_file_info(sb, cnt);
 		if (dqopt->ops[cnt]->free_file_info)
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
+		put_quota_format(dqopt->info[cnt].dqi_format);
 
-		filp = dqopt->files[cnt];
+		fput(dqopt->files[cnt]);
 		dqopt->files[cnt] = (struct file *)NULL;
 		dqopt->info[cnt].dqi_flags = 0;
 		dqopt->info[cnt].dqi_igrace = 0;
 		dqopt->info[cnt].dqi_bgrace = 0;
 		dqopt->ops[cnt] = NULL;
-		fput(filp);
 	}	
 	up(&dqopt->dqoff_sem);
 out:
@@ -1240,9 +1229,9 @@
 	return 0;
 }
 
-static int quota_on(struct super_block *sb, int type, int format_id, char 
*path)
+int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
 {
-	struct file *f;
+	struct file *f = NULL;
 	struct inode *inode;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_format_type *fmt = find_quota_format(format_id);
@@ -1250,8 +1239,10 @@
 
 	if (!fmt)
 		return -EINVAL;
-	if (is_enabled(dqopt, type))
-		return -EBUSY;
+	if (is_enabled(dqopt, type)) {
+		error = -EBUSY;
+		goto out_fmt;
+	}
 
 	down(&dqopt->dqoff_sem);
 
@@ -1276,10 +1267,9 @@
 	inode->i_flags |= S_NOQUOTA;
 
 	dqopt->ops[type] = fmt->qf_ops;
-	dqopt->info[type].dqi_format = format_id;
+	dqopt->info[type].dqi_format = fmt;
 	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0)
 		goto out_f;
-	sb->dq_op = &dquot_operations;
 	set_enable_flags(dqopt, type);
 
 	add_dquot_ref(sb, type);
@@ -1288,116 +1278,136 @@
 	return 0;
 
 out_f:
-	filp_close(f, NULL);
+	if (f)
+		filp_close(f, NULL);
 	dqopt->files[type] = NULL;
 out_lock:
 	up(&dqopt->dqoff_sem);
+out_fmt:
+	put_quota_format(fmt);
 
 	return error; 
 }
 
-/*
- * This is the system call interface. This communicates with
- * the user-level programs. Currently this only supports diskquota
- * calls. Maybe we need to add the process quotas etc. in the future,
- * but we probably should use rlimits for that.
- */
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t 
addr)
+int vfs_quota_sync(struct super_block *sb, int type)
 {
-	int cmds = 0, type = 0, flags = 0;
-	kdev_t dev;
-	struct super_block *sb = NULL;
-	int ret = -EINVAL;
+	return sync_dquots(sb->s_dev, type);
+}
 
-	lock_kernel();
-	cmds = cmd >> SUBCMDSHIFT;
-	type = cmd & SUBCMDMASK;
+/* Generic routine for getting common part of quota stucture */
+static void do_get_dqblk(struct dquot *dquot, struct if_dqblk *di)
+{
+	struct mem_dqblk *dm = &dquot->dq_dqb;
 
-	if ((u_int) type >= MAXQUOTAS)
-		goto out;
-	if (id & ~0xFFFF)
-		goto out;
+	di->dqb_bhardlimit = dm->dqb_bhardlimit;
+	di->dqb_bsoftlimit = dm->dqb_bsoftlimit;
+	di->dqb_curspace = dm->dqb_curspace;
+	di->dqb_ihardlimit = dm->dqb_ihardlimit;
+	di->dqb_isoftlimit = dm->dqb_isoftlimit;
+	di->dqb_curinodes = dm->dqb_curinodes;
+	di->dqb_btime = dm->dqb_btime;
+	di->dqb_itime = dm->dqb_itime;
+	di->dqb_valid = QIF_ALL;
+}
 
-	ret = -EPERM;
-	switch (cmds) {
-		case Q_SYNC:
-		case Q_GETSTATS:
-			break;
-		case Q_GETQUOTA:
-			if (((type == USRQUOTA && current->euid != id) ||
-			     (type == GRPQUOTA && !in_egroup_p(id))) &&
-			    !capable(CAP_SYS_ADMIN))
-				goto out;
-			break;
-		default:
-			if (!capable(CAP_SYS_ADMIN))
-				goto out;
-	}
-
-	ret = -EINVAL;
-	dev = NODEV;
-	if (special != NULL || (cmds != Q_SYNC && cmds != Q_GETSTATS)) {
-		mode_t mode;
-		struct nameidata nd;
-
-		ret = user_path_walk(special, &nd);
-		if (ret)
-			goto out;
-
-		dev = nd.dentry->d_inode->i_rdev;
-		mode = nd.dentry->d_inode->i_mode;
-		path_release(&nd);
-
-		ret = -ENOTBLK;
-		if (!S_ISBLK(mode))
-			goto out;
-		ret = -ENODEV;
-		sb = get_super(dev);
-		if (!sb)
-			goto out;
-	}
-
-	ret = -EINVAL;
-	switch (cmds) {
-		case Q_QUOTAON:
-			ret = quota_on(sb, type, (char *) addr);
-			goto out;
-		case Q_QUOTAOFF:
-			ret = quota_off(sb, type);
-			goto out;
-		case Q_GETQUOTA:
-			ret = get_quota(sb, id, type, (struct dqblk *) addr);
-			goto out;
-		case Q_SETQUOTA:
-			flags |= SET_QUOTA;
-			break;
-		case Q_SETUSE:
-			flags |= SET_USE;
-			break;
-		case Q_SETQLIM:
-			flags |= SET_QLIMIT;
-			break;
-		case Q_SYNC:
-			ret = sync_dquots(sb, type);
-			goto out;
-		case Q_GETSTATS:
-			ret = get_stats(addr);
-			goto out;
-		case Q_RSQUASH:
-			ret = quota_root_squash(sb, type, (int *) addr);
-			goto out;
-		default:
-			goto out;
-	}
-
-	ret = -ENODEV;
-	if (sb && sb_has_quota_enabled(sb, type))
-		ret = set_dqblk(sb, id, type, flags, (struct dqblk *) addr);
-out:
-	if (sb)
-		drop_super(sb);
-	unlock_kernel();
-	return ret;
+int vfs_get_dqblk(struct super_block *sb, int type, qid_t id, struct 
if_dqblk *di)
+{
+	struct dquot *dquot = dqget(sb, id, type);
+	if (!dquot)
+		return -EINVAL;
+	do_get_dqblk(dquot, di);
+	dqput(dquot);
+	return 0;
+}
+
+/* Generic routine for setting common part of quota structure */
+static void do_set_dqblk(struct dquot *dquot, struct if_dqblk *di)
+{
+	struct mem_dqblk *dm = &dquot->dq_dqb;
+	int check_blim = 0, check_ilim = 0;
+
+	if (di->dqb_valid & QIF_SPACE) {
+		dm->dqb_curspace = di->dqb_curspace;
+		check_blim = 1;
+	}
+	if (di->dqb_valid & QIF_BLIMITS) {
+		dm->dqb_bsoftlimit = di->dqb_bsoftlimit;
+		dm->dqb_bhardlimit = di->dqb_bhardlimit;
+		check_blim = 1;
+	}
+	if (di->dqb_valid & QIF_INODES) {
+		dm->dqb_curinodes = di->dqb_curinodes;
+		check_ilim = 1;
+	}
+	if (di->dqb_valid & QIF_ILIMITS) {
+		dm->dqb_isoftlimit = di->dqb_isoftlimit;
+		dm->dqb_ihardlimit = di->dqb_ihardlimit;
+		check_ilim = 1;
+	}
+	if (di->dqb_valid & QIF_BTIME)
+		dm->dqb_btime = di->dqb_btime;
+	if (di->dqb_valid & QIF_ITIME)
+		dm->dqb_itime = di->dqb_itime;
+
+	if (check_blim) {
+		if (!dm->dqb_bsoftlimit || toqb(dm->dqb_curspace) < dm->dqb_bsoftlimit) {
+			dm->dqb_btime = 0;
+			dquot->dq_flags &= ~DQ_BLKS;
+		}
+		 else if (!(di->dqb_valid & QIF_BTIME))  /* Set grace only if user hasn't 
provided his own... */
+			 dm->dqb_btime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
+	}
+	if (check_ilim) {
+		if (!dm->dqb_isoftlimit || dm->dqb_curinodes < dm->dqb_isoftlimit) {
+			dm->dqb_itime = 0;
+			dquot->dq_flags &= ~DQ_INODES;
+		}
+		else if (!(di->dqb_valid & QIF_ITIME))  /* Set grace only if user hasn't 
provided his own... */
+			dm->dqb_itime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
+	}
+	if (dm->dqb_bhardlimit || dm->dqb_bsoftlimit || dm->dqb_ihardlimit || 
dm->dqb_isoftlimit)
+		dquot->dq_flags &= ~DQ_FAKE;
+	else
+		dquot->dq_flags |= DQ_FAKE;
+	dquot->dq_flags |= DQ_MOD;
+}
+
+int vfs_set_dqblk(struct super_block *sb, int type, qid_t id, struct 
if_dqblk *di)
+{
+	struct dquot *dquot = dqget(sb, id, type);
+
+	if (!dquot)
+		return -EINVAL;
+	do_set_dqblk(dquot, di);
+	dqput(dquot);
+	return 0;
+}
+
+/* Generic routine for getting common part of quota file information */
+int vfs_get_info(struct super_block *sb, int type, struct if_dqinfo *ii)
+{
+	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
+
+	ii->dqi_bgrace = mi->dqi_bgrace;
+	ii->dqi_igrace = mi->dqi_igrace;
+	ii->dqi_flags = mi->dqi_flags & DQF_MASK;
+	ii->dqi_valid = IIF_ALL;
+	return 0;
+}
+
+/* Generic routine for setting common part of quota file information */
+int vfs_set_info(struct super_block *sb, int type, struct if_dqinfo *ii)
+{
+	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
+
+	if (ii->dqi_valid & IIF_BGRACE)
+		mi->dqi_bgrace = ii->dqi_bgrace;
+	if (ii->dqi_valid & IIF_IGRACE)
+		mi->dqi_igrace = ii->dqi_igrace;
+	if (ii->dqi_valid & IIF_FLAGS)
+		mi->dqi_flags = (mi->dqi_flags & ~DQF_MASK) | (ii->dqi_flags & DQF_MASK);
+	mark_info_dirty(mi);
+	return 0;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1413,7 +1423,7 @@
 	len += sprintf(buffer + len, "Formats");
 	lock_kernel();
 	for (actqf = quota_formats; actqf; actqf = actqf->qf_next)
-		len += sprintf(buffer + len, " %u", actqf->qf_id);
+		len += sprintf(buffer + len, " %u", actqf->qf_fmt_id);
 	unlock_kernel();
 	len += sprintf(buffer + len, "\n%u %u %u %u %u %u %u %u\n",
 			dqstats.lookups, dqstats.drops,
@@ -1435,6 +1445,16 @@
 }
 #endif
 
+struct quotactl_ops vfs_quotactl_ops {
+	quota_on:	vfs_quota_on,
+	quota_off:	vfs_quota_off,
+	quota_sync:	vfs_quota_sync,
+	get_info:	vfs_get_info,
+	set_info:	vfs_set_info,
+	get_dqblk:	vfs_get_dqblk,
+	set_dqblk:	vfs_set_dqblk
+};
+
 static int __init dquot_init(void)
 {
 	int i;
@@ -1448,3 +1468,7 @@
 	return 0;
 }
 __initcall(dquot_init);
+
+EXPORT_SYMBOL(register_quota_format);
+EXPORT_SYMBOL(unregister_quota_format);
+EXPORT_SYMBOL(dqstats);
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/noquot.c 
linux-2.5/fs/noquot.c
--- linux-2.5-linus/fs/noquot.c	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/noquot.c	Wed Dec 31 19:00:00 1969
@@ -1,15 +0,0 @@
-/* noquot.c: Quota stubs necessary for when quotas are not
- *           compiled into the kernel.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-
-int nr_dquots, nr_free_dquots;
-int max_dquots;
-
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t 
addr)
-{
-	return(-ENOSYS);
-}
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/quota.c linux-2.5/fs/quota.c
--- linux-2.5-linus/fs/quota.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5/fs/quota.c	Sat Mar  2 19:44:59 2002
@@ -0,0 +1,264 @@
+/*
+ * Quota code necessary even when VFS quota support is not compiled
+ * into the kernel.  The interesting stuff is over in dquot.c, here
+ * we have symbols for initial quotactl(2) handling, the sysctl(2)
+ * variables, etc - things needed even when quota support disabled.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/quotaops.h>
+
+int nr_dquots, nr_free_dquots;
+
+/* Check validity of quotactl */
+static int check_quotactl_valid(struct super_block *sb, int type, int cmd, 
qid_t id)
+{
+	if (type >= MAXQUOTAS)
+		return -EINVAL;
+	/* Is operation supported? */
+	if (!sb->s_qcop)
+		return -ENOSYS;
+
+	switch (cmd) {
+	    case Q_GETFMT:
+		break;
+	    case Q_QUOTAON:
+		if (!sb->s_qcop->quota_on)
+			return -ENOSYS;
+		break;
+	    case Q_QUOTAOFF:
+		if (!sb->s_qcop->quota_off)
+			return -ENOSYS;
+		break;
+	    case Q_SETINFO:
+		if (!sb->s_qcop->set_info)
+			return -ENOSYS;
+		break;
+	    case Q_GETINFO:
+		if (!sb->s_qcop->get_info)
+			return -ENOSYS;
+		break;
+	    case Q_SETQUOTA:
+		if (!sb->s_qcop->set_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_GETQUOTA:
+		if (!sb->s_qcop->get_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_SYNC:
+		if (!sb->s_qcop->quota_sync)
+			return -ENOSYS;
+		break;
+	    case Q_XQUOTAON:
+	    case Q_XQUOTAOFF:
+	    case Q_XQUOTARM:
+		if (!sb->s_qcop->set_xstate)
+			return -ENOSYS;
+		break;
+	    case Q_XGETQSTAT:
+		if (!sb->s_qcop->get_xstate)
+			return -ENOSYS;
+		break;
+	    case Q_XSETQLIM:
+		if (!sb->s_qcop->set_xquota)
+			return -ENOSYS;
+		break;
+	    case Q_XGETQUOTA:
+		if (!sb->s_qcop->get_xquota)
+			return -ENOSYS;
+		break;
+	    default:
+		return -EINVAL;
+	}
+
+	/* Is quota turned on for commands which need it? */
+	switch (cmd) {
+	    case Q_GETFMT:
+	    case Q_GETINFO:
+	    case Q_QUOTAOFF:
+	    case Q_SETINFO:
+	    case Q_SETQUOTA:
+	    case Q_GETQUOTA:
+		if (!sb_has_quota_enabled(sb, type))
+			return -ESRCH;
+	}
+	/* Check privileges */
+	if (cmd == Q_GETQUOTA || cmd == Q_XGETQUOTA) {
+		if (((type == USRQUOTA && current->euid != id) ||
+		     (type == GRPQUOTA && !in_egroup_p(id))) &&
+		    !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+	else if (cmd != Q_GETFMT && cmd != Q_GETINFO && cmd != Q_SYNC)
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	return 0;
+}
+
+/* Resolve device pathname to superblock */
+static struct super_block *resolve_dev(const char *path)
+{
+	int ret;
+	mode_t mode;
+	struct nameidata nd;
+	kdev_t dev;
+	struct super_block *sb;
+
+	ret = user_path_walk(path, &nd);
+	if (ret)
+		goto out;
+
+	dev = nd.dentry->d_inode->i_rdev;
+	mode = nd.dentry->d_inode->i_mode;
+	path_release(&nd);
+
+	ret = -ENOTBLK;
+	if (!S_ISBLK(mode))
+		goto out;
+	ret = -ENODEV;
+	sb = get_super(dev);
+	if (!sb)
+		goto out;
+	return sb;
+out:
+	return ERR_PTR(ret);
+}
+
+/* Copy parameters and call proper function */
+static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id, 
caddr_t addr)
+{
+	int ret;
+
+	switch (cmd) {
+		case Q_QUOTAON: {
+			char *pathname;
+
+			if (IS_ERR(pathname = getname(addr)))
+				return PTR_ERR(pathname);
+			ret = sb->s_qcop->quota_on(sb, type, id, pathname);
+			putname(pathname);
+			return ret;
+		}
+		case Q_QUOTAOFF:
+			return sb->s_qcop->quota_off(sb, type);
+
+		case Q_GETFMT: {
+			__u32 fmt;
+
+			fmt = sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id;
+			if (copy_to_user(addr, &fmt, sizeof(fmt)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_GETINFO: {
+			struct if_dqinfo info;
+
+			if ((ret = sb->s_qcop->get_info(sb, type, &info)))
+				return ret;
+			if (copy_to_user(addr, &info, sizeof(info)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_SETINFO: {
+			struct if_dqinfo info;
+
+			if (copy_from_user(&info, addr, sizeof(info)))
+				return -EFAULT;
+			return sb->s_qcop->set_info(sb, type, &info);
+		}
+		case Q_GETQUOTA: {
+			struct if_dqblk idq;
+
+			if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)))
+				return ret;
+			if (copy_to_user(addr, &idq, sizeof(idq)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_SETQUOTA: {
+			struct if_dqblk idq;
+
+			if (copy_from_user(&idq, addr, sizeof(idq)))
+				return -EFAULT;
+			return sb->s_qcop->set_dqblk(sb, type, id, &idq);
+		}
+		case Q_SYNC:
+			return sb->s_qcop->quota_sync(sb, type);
+
+		case Q_XQUOTAON:
+		case Q_XQUOTAOFF:
+		case Q_XQUOTARM: {
+			__u32 flags;
+
+			if (copy_from_user(&flags, addr, sizeof(flags)))
+				return -EFAULT;
+			return sb->s_qcop->set_xstate(sb, flags, cmd);
+		}
+		case Q_XGETQSTAT: {
+			struct fs_quota_stat fqs;
+		
+			if ((ret = sb->s_qcop->get_xstate(sb, &fqs)))
+				return ret;
+			if (copy_to_user(addr, &fqs, sizeof(fqs)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_XSETQLIM: {
+			struct fs_disk_quota fdq;
+
+			if (copy_from_user(&fdq, addr, sizeof(fdq)))
+				return -EFAULT;
+		       return sb->s_qcop->set_xquota(sb, type, id, &fdq);
+		}
+		case Q_XGETQUOTA: {
+			struct fs_disk_quota fdq;
+
+			if ((ret = sb->s_qcop->get_xquota(sb, type, id, &fdq)))
+				return ret;
+			if (copy_to_user(addr, &fdq, sizeof(fdq)))
+				return -EFAULT;
+			return 0;
+		}
+		/* We never reach here unless validity check is broken */
+		default:
+			BUG();
+	}
+	return 0;
+}
+
+/*
+ * This is the system call interface. This communicates with
+ * the user-level programs. Currently this only supports diskquota
+ * calls. Maybe we need to add the process quotas etc. in the future,
+ * but we probably should use rlimits for that.
+ */
+asmlinkage long sys_quotactl(unsigned int cmd, const char *special, qid_t 
id, caddr_t addr)
+{
+	uint cmds = 0, type = 0;
+	struct super_block *sb = NULL;
+	int ret = -EINVAL;
+
+	lock_kernel();
+	cmds = cmd >> SUBCMDSHIFT;
+	type = cmd & SUBCMDMASK;
+
+	if ((cmds != Q_SYNC || special) && IS_ERR(sb = resolve_dev(special))) {
+		ret = PTR_ERR(sb);
+		sb = NULL;
+		goto out;
+	}
+	if ((ret = check_quotactl_valid(sb, type, cmds, id)) < 0)
+		goto out;
+	ret = do_quotactl(sb, type, cmds, id, addr);
+out:
+	if (sb)
+		drop_super(sb);
+	unlock_kernel();
+	return ret;
+}
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/super.c linux-2.5/fs/super.c
--- linux-2.5-linus/fs/super.c	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/super.c	Sat Mar  2 19:45:00 2002
@@ -279,6 +279,8 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->dq_op = sb_dquot_ops;
+		s->s_qcop = sb_quotactl_ops;
 	}
 	return s;
 }
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/fs.h 
linux-2.5/include/linux/fs.h
--- linux-2.5-linus/include/linux/fs.h	Sun Mar  3 03:07:56 2002
+++ linux-2.5/include/linux/fs.h	Sat Mar  2 19:45:00 2002
@@ -670,7 +670,7 @@
 	struct semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on 
device */
 	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
-	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each format */
+	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
 
 /*
@@ -719,6 +719,7 @@
 	struct file_system_type	*s_type;
 	struct super_operations	*s_op;
 	struct dquot_operations	*dq_op;
+	struct quotactl_ops	*s_qcop;
 	unsigned long		s_flags;
 	unsigned long		s_magic;
 	struct dentry		*s_root;
@@ -959,16 +960,6 @@
 {
 	__mark_inode_dirty(inode, I_DIRTY_PAGES);
 }
-
-struct dquot_operations {
-	void (*initialize) (struct inode *, short);
-	void (*drop) (struct inode *);
-	int (*alloc_space) (struct inode *, qsize_t, int);
-	int (*alloc_inode) (const struct inode *, unsigned long);
-	void (*free_space) (struct inode *, qsize_t);
-	void (*free_inode) (const struct inode *, unsigned long);
-	int (*transfer) (struct inode *, struct iattr *);
-};
 
 struct file_system_type {
 	const char *name;
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 19:34:16 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 19:45:00 2002
@@ -70,9 +70,6 @@
 	"undefined", \
 };
 
-#define QUOTAFILENAME "quota"
-#define QUOTAGROUP "staff"
-
 /*
  * Command definitions for the 'quotactl' system call.
  * The commands are broken into a main command defined below
@@ -83,7 +80,61 @@
 #define SUBCMDSHIFT 8
 #define QCMD(cmd, type)  (((cmd) << SUBCMDSHIFT) | ((type) & SUBCMDMASK))
 
-#define Q_SYNC     0x0600	/* sync disk copy of a filesystems quotas */
+#define Q_SYNC     0x800001	/* sync disk copy of a filesystems quotas */
+#define Q_QUOTAON  0x800002	/* turn quotas on */
+#define Q_QUOTAOFF 0x800003	/* turn quotas off */
+#define Q_GETFMT   0x800004	/* get quota format used on given filesystem */
+#define Q_GETINFO  0x800005	/* get information about quota files */
+#define Q_SETINFO  0x800006	/* set information about quota files */
+#define Q_GETQUOTA 0x800007	/* get user quota structure */
+#define Q_SETQUOTA 0x800008	/* set user quota structure */
+
+/*
+ * Quota structure used for communication with userspace via quotactl
+ * Following flags are used to specify which fields are valid
+ */
+#define QIF_BLIMITS	1
+#define QIF_SPACE	2
+#define QIF_ILIMITS	4
+#define QIF_INODES	8
+#define QIF_BTIME	16
+#define QIF_ITIME	32
+#define QIF_LIMITS	(QIF_BLIMITS | QIF_ILIMITS)
+#define QIF_USAGE	(QIF_SPACE | QIF_INODES)
+#define QIF_TIMES	(QIF_BTIME | QIF_ITIME)
+#define QIF_ALL		(QIF_LIMITS | QIF_USAGE | QIF_TIMES)
+
+struct if_dqblk {
+	__u64 dqb_bhardlimit;
+	__u64 dqb_bsoftlimit;
+	__u64 dqb_curspace;
+	__u64 dqb_ihardlimit;
+	__u64 dqb_isoftlimit;
+	__u64 dqb_curinodes;
+	__u64 dqb_btime;
+	__u64 dqb_itime;
+	__u32 dqb_valid;
+};
+
+/*
+ * Structure used for setting quota information about file via quotactl
+ * Following flags are used to specify which fields are valid
+ */
+#define IIF_BGRACE	1
+#define IIF_IGRACE	2
+#define IIF_FLAGS	4
+#define IIF_ALL		(IIF_BGRACE | IIF_IGRACE | IIF_FLAGS)
+
+struct if_dqinfo {
+	__u64 dqi_bgrace;
+	__u64 dqi_igrace;
+	__u32 dqi_flags;
+	__u32 dqi_valid;
+};
+
+#ifdef __KERNEL__
+
+#include <linux/xqm.h>
 
 /*
  * Data for one user/group kept in memory
@@ -105,7 +156,7 @@
 struct quota_format_type;
 
 struct mem_dqinfo {
-	struct quota_format_type * dqi_format;
+	struct quota_format_type *dqi_format;
 	int dqi_flags;
 	unsigned int dqi_bgrace;
 	unsigned int dqi_igrace;
@@ -113,8 +164,6 @@
 	} u;
 };
 
-#ifdef __KERNEL__
-
 #define DQF_MASK 0xffff		/* Mask for format specific flags */
 #define DQF_INFO_DIRTY 0x10000  /* Is info dirty? */
 
@@ -127,24 +176,6 @@
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
 
-#endif  /* __KERNEL__ */
-
-/*
- * Shorthand notation.
- */
-#define	dq_bhardlimit	dq_dqb.dqb_bhardlimit
-#define	dq_bsoftlimit	dq_dqb.dqb_bsoftlimit
-#define	dq_curspace	dq_dqb.dqb_curspace
-#define	dq_ihardlimit	dq_dqb.dqb_ihardlimit
-#define	dq_isoftlimit	dq_dqb.dqb_isoftlimit
-#define	dq_curinodes	dq_dqb.dqb_curinodes
-#define	dq_btime	dq_dqb.dqb_btime
-#define	dq_itime	dq_dqb.dqb_itime
-
-#define dqoff(UID)      ((loff_t)((UID) * sizeof (struct dqblk)))
-
-#ifdef __KERNEL__
-
 extern int nr_dquots, nr_free_dquots;
 
 struct dqstats {
@@ -203,25 +234,55 @@
 /* Operations which must be implemented by each quota format */
 struct quota_format_ops {
 	int (*check_quota_file)(struct super_block *sb, int type);	/* Detect 
whether file is in our format */
-	int (*read_file_info)(struct super_block *sb, int type);	/* Read main info 
about file */
+	int (*read_file_info)(struct super_block *sb, int type);	/* Read main info 
about file - called on quotaon() */
 	int (*write_file_info)(struct super_block *sb, int type);	/* Write main 
info about file */
 	int (*free_file_info)(struct super_block *sb, int type);	/* Called on 
quotaoff() */
 	int (*read_dqblk)(struct dquot *dquot);		/* Read structure for one user */
 	int (*commit_dqblk)(struct dquot *dquot);	/* Write (or delete) structure 
for one user */
 };
 
+/* Operations working with dquots */
+struct dquot_operations {
+	void (*initialize) (struct inode *, short);
+	void (*drop) (struct inode *);
+	int (*alloc_space) (struct inode *, qsize_t, int);
+	int (*alloc_inode) (const struct inode *, unsigned long);
+	void (*free_space) (struct inode *, qsize_t);
+	void (*free_inode) (const struct inode *, unsigned long);
+	int (*transfer) (struct inode *, struct iattr *);
+};
+
+/* Operations handling requests from userspace */
+struct quotactl_ops {
+	int (*quota_on)(struct super_block *, int, int, char *);
+	int (*quota_off)(struct super_block *, int);
+	int (*quota_sync)(struct super_block *, int);
+	int (*get_info)(struct super_block *, int, struct if_dqinfo *);
+	int (*set_info)(struct super_block *, int, struct if_dqinfo *);
+	int (*get_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
+	int (*set_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
+	int (*get_xstate)(struct super_block *, struct fs_quota_stat *);
+	int (*set_xstate)(struct super_block *, unsigned int, int);
+	int (*get_xquota)(struct super_block *, int, qid_t, struct fs_disk_quota *);
+	int (*set_xquota)(struct super_block *, int, qid_t, struct fs_disk_quota *);
+};
+
 struct quota_format_type {
 	int qf_fmt_id;	/* Quota format id */
 	struct quota_format_ops *qf_ops;	/* Operations of format */
+	struct module *qf_owner;		/* Module implementing quota format */
 	struct quota_format_type *qf_next;
 };
 
+int register_quota_format(struct quota_format_type *fmt);
+void unregister_quota_format(struct quota_format_type *fmt);
+
 #else
 
 # /* nodep */ include <sys/cdefs.h>
 
 __BEGIN_DECLS
-long quotactl __P ((int, const char *, int, caddr_t));
+long quotactl __P ((unsigned int, const char *, int, caddr_t));
 __END_DECLS
 
 #endif /* __KERNEL__ */
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sun Mar  3 03:07:56 2002
+++ linux-2.5/include/linux/quotaops.h	Sun Mar  3 03:02:33 2002
@@ -15,15 +15,35 @@
 
 #include <linux/fs.h>
 
+/* Following functions are needed even when quota is not compiled into 
kernel (for XFS) */
+#define sb_any_quota_enabled(sb) ((sb)->s_dquot.flags & (DQUOT_USR_ENABLED | 
DQUOT_GRP_ENABLED))
+
+static inline int is_enabled(struct quota_info *dqopt, short type)
+{
+	switch (type) {
+		case USRQUOTA:
+			return (dqopt->flags & DQUOT_USR_ENABLED) != 0;
+		case GRPQUOTA:
+			return (dqopt->flags & DQUOT_GRP_ENABLED) != 0;
+	}
+	return 0;
+}
+
+static inline int sb_has_quota_enabled(struct super_block *sb, short type)
+{
+        return is_enabled(sb_dqopt(sb), type);
+}
+
 #if defined(CONFIG_QUOTA)
 
 /*
  * declaration of quota_function calls in kernel.
  */
+/* Al this will be changed as soon as I release the first patch */
+extern int sync_dquots(kdev_t dev, short type);
+
 extern void dquot_initialize(struct inode *inode, short type);
 extern void dquot_drop(struct inode *inode);
-extern int  quota_off(struct super_block *sb, short type);
-extern int  sync_dquots(struct super_block *sb, short type);
 
 extern int  dquot_alloc_space(struct inode *inode, qsize_t number, int 
prealloc);
 extern int  dquot_alloc_inode(const struct inode *inode, unsigned long 
number);
@@ -36,7 +56,11 @@
 /*
  * Operations supported for diskquotas.
  */
-#define sb_any_quota_enabled(sb) ((sb)->s_dquot.flags & (DQUOT_USR_ENABLED | 
DQUOT_GRP_ENABLED))
+extern struct dquot_operations dquot_operations;
+extern struct quotactl_ops vfs_quotactl_ops;
+
+#define sb_dquot_ops (&dquot_operations)
+#define sb_quotactl_ops (&vfs_quotactl_ops)
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
@@ -160,13 +184,15 @@
 }
 
 #define DQUOT_SYNC(sb)	sync_dquots(sb, -1)
-#define DQUOT_OFF(sb)	quota_off(sb, -1)
+#define DQUOT_OFF(sb)	((sb)->s_qcop->quota_off(sb, -1))
 
 #else
 
 /*
  * NO-OP when quota not configured.
  */
+#define sb_dquot_ops				(NULL)
+#define sb_quotactl_ops				(NULL)
 #define DQUOT_INIT(inode)			do { } while(0)
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/xqm.h 
linux-2.5/include/linux/xqm.h
--- linux-2.5-linus/include/linux/xqm.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5/include/linux/xqm.h	Sat Mar  2 19:45:00 2002
@@ -0,0 +1,159 @@
+/*
+ * Copyright (c) 1995-2001 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, write the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston MA 02111-1307,
+ * USA.
+ *
+ * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
+ */
+#ifndef _LINUX_XQM_H
+#define _LINUX_XQM_H
+
+#include <linux/types.h>
+
+/*
+ * Disk quota - quotactl(2) commands for the XFS Quota Manager (XQM).
+ */
+
+#define XQM_CMD(x)	(('X'<<8)+(x))	/* note: forms first QCMD argument */
+#define Q_XQUOTAON	XQM_CMD(0x1)	/* enable accounting/enforcement */
+#define Q_XQUOTAOFF	XQM_CMD(0x2)	/* disable accounting/enforcement */
+#define Q_XGETQUOTA	XQM_CMD(0x3)	/* get disk limits and usage */
+#define Q_XSETQLIM	XQM_CMD(0x4)	/* set disk limits */
+#define Q_XGETQSTAT	XQM_CMD(0x5)	/* get quota subsystem status */
+#define Q_XQUOTARM	XQM_CMD(0x6)	/* free disk space used by dquots */
+
+/*
+ * fs_disk_quota structure:
+ *
+ * This contains the current quota information regarding a user/proj/group.
+ * It is 64-bit aligned, and all the blk units are in BBs (Basic Blocks) of
+ * 512 bytes.
+ */
+#define FS_DQUOT_VERSION	1	/* fs_disk_quota.d_version */
+typedef struct fs_disk_quota {
+	__s8		d_version;	/* version of this structure */
+	__s8		d_flags;	/* XFS_{USER,PROJ,GROUP}_QUOTA */
+	__u16		d_fieldmask;	/* field specifier */
+	__u32		d_id;		/* user, project, or group ID */
+	__u64		d_blk_hardlimit;/* absolute limit on disk blks */
+	__u64		d_blk_softlimit;/* preferred limit on disk blks */
+	__u64		d_ino_hardlimit;/* maximum # allocated inodes */
+	__u64		d_ino_softlimit;/* preferred inode limit */
+	__u64		d_bcount;	/* # disk blocks owned by the user */
+	__u64		d_icount;	/* # inodes owned by the user */
+	__s32		d_itimer;	/* zero if within inode limits */
+					/* if not, we refuse service */
+	__s32		d_btimer;	/* similar to above; for disk blocks */
+	__u16	  	d_iwarns;       /* # warnings issued wrt num inodes */
+	__u16	  	d_bwarns;       /* # warnings issued wrt disk blocks */
+	__s32		d_padding2;	/* padding2 - for future use */
+	__u64		d_rtb_hardlimit;/* absolute limit on realtime blks */
+	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
+	__u64		d_rtbcount;	/* # realtime blocks owned */
+	__s32		d_rtbtimer;	/* similar to above; for RT disk blks */
+	__u16	  	d_rtbwarns;     /* # warnings issued wrt RT disk blks */
+	__s16		d_padding3;	/* padding3 - for future use */	
+	char		d_padding4[8];	/* yet more padding */
+} fs_disk_quota_t;
+
+/*
+ * These fields are sent to Q_XSETQLIM to specify fields that need to change.
+ */
+#define FS_DQ_ISOFT	(1<<0)
+#define FS_DQ_IHARD	(1<<1)
+#define FS_DQ_BSOFT	(1<<2)
+#define FS_DQ_BHARD 	(1<<3)
+#define FS_DQ_RTBSOFT	(1<<4)
+#define FS_DQ_RTBHARD	(1<<5)
+#define FS_DQ_LIMIT_MASK	(FS_DQ_ISOFT | FS_DQ_IHARD | FS_DQ_BSOFT | \
+				 FS_DQ_BHARD | FS_DQ_RTBSOFT | FS_DQ_RTBHARD)
+/*
+ * These timers can only be set in super user's dquot. For others, timers are
+ * automatically started and stopped. Superusers timer values set the limits
+ * for the rest.  In case these values are zero, the DQ_{F,B}TIMELIMIT values
+ * defined below are used. 
+ * These values also apply only to the d_fieldmask field for Q_XSETQLIM.
+ */
+#define FS_DQ_BTIMER	(1<<6)
+#define FS_DQ_ITIMER	(1<<7)
+#define FS_DQ_RTBTIMER 	(1<<8)
+#define FS_DQ_TIMER_MASK	(FS_DQ_BTIMER | FS_DQ_ITIMER | FS_DQ_RTBTIMER)
+
+/*
+ * The following constants define the default amount of time given a user
+ * before the soft limits are treated as hard limits (usually resulting
+ * in an allocation failure).  These may be modified by the quotactl(2)
+ * system call with the Q_XSETQLIM command.
+ */
+#define	DQ_FTIMELIMIT	(7 * 24*60*60)		/* 1 week */
+#define	DQ_BTIMELIMIT	(7 * 24*60*60)		/* 1 week */
+
+/*
+ * Various flags related to quotactl(2).  Only relevant to XFS filesystems.
+ */
+#define XFS_QUOTA_UDQ_ACCT	(1<<0)  /* user quota accounting */
+#define XFS_QUOTA_UDQ_ENFD	(1<<1)  /* user quota limits enforcement */
+#define XFS_QUOTA_GDQ_ACCT	(1<<2)  /* group quota accounting */
+#define XFS_QUOTA_GDQ_ENFD	(1<<3)  /* group quota limits enforcement */
+
+#define XFS_USER_QUOTA		(1<<0)	/* user quota type */
+#define XFS_PROJ_QUOTA		(1<<1)	/* (IRIX) project quota type */
+#define XFS_GROUP_QUOTA		(1<<2)	/* group quota type */
+
+/*
+ * fs_quota_stat is the struct returned in Q_XGETQSTAT for a given file 
system.
+ * Provides a centralized way to get meta infomation about the quota 
subsystem.
+ * eg. space taken up for user and group quotas, number of dquots currently
+ * incore.
+ */
+#define FS_QSTAT_VERSION	1	/* fs_quota_stat.qs_version */
+
+/*
+ * Some basic infomation about 'quota files'.
+ */
+typedef struct fs_qfilestat {
+	__u64		qfs_ino;	/* inode number */
+	__u64		qfs_nblks;	/* number of BBs 512-byte-blks */
+	__u32		qfs_nextents;	/* number of extents */
+} fs_qfilestat_t;
+
+typedef struct fs_quota_stat {
+	__s8		qs_version;	/* version number for future changes */
+	__u16		qs_flags;	/* XFS_QUOTA_{U,P,G}DQ_{ACCT,ENFD} */
+	__s8		qs_pad;		/* unused */
+	fs_qfilestat_t	qs_uquota;	/* user quota storage information */
+	fs_qfilestat_t	qs_gquota;	/* group quota storage information */
+	__u32		qs_incoredqs;	/* number of dquots incore */
+	__s32		qs_btimelimit;  /* limit for blks timer */	
+	__s32		qs_itimelimit;  /* limit for inodes timer */	
+	__s32		qs_rtbtimelimit;/* limit for rt blks timer */	
+	__u16		qs_bwarnlimit;	/* limit for num warnings */
+	__u16		qs_iwarnlimit;	/* limit for num warnings */
+} fs_quota_stat_t;
+
+#endif	/* _LINUX_XQM_H */
