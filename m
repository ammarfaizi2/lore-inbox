Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRJZIOR>; Fri, 26 Oct 2001 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278038AbRJZIOE>; Fri, 26 Oct 2001 04:14:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24591 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277918AbRJZINh>; Fri, 26 Oct 2001 04:13:37 -0400
Date: Fri, 26 Oct 2001 10:12:50 +0200
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu, Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Quotactl changes
Message-ID: <20011026101250.D7113@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I'm sending an final (at least I think :)) version of patch
to quotas wrt XFS. It allows filesystems to override quota calls
called from quotactl() and hence XFS people have easier life...
The patch also cleanups some things around quotactl() and moves
statistics about quota from Q_GETSTATS quotactl to /proc/fs/quota.
The patch for 2.4.12-ac6 is attached. I'm content with current
patch so if Al Viro doesn't object I think you can apply it.

								Honza

PS to Nathan: I've made just one small change in the patch you've sent me -
 - in setdqblk() I added test so that it returns proper error when quota
 is not enabled.

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quotactl-2.4.12-ac6.diff"

diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/fs/Makefile linux-2.4.12-ac6-quotactl/fs/Makefile
--- linux-2.4.12-ac6/fs/Makefile	Thu Oct 25 23:42:08 2001
+++ linux-2.4.12-ac6-quotactl/fs/Makefile	Thu Oct 25 23:49:50 2001
@@ -14,12 +14,10 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o jbd-kernel.o namespace.o
+		filesystems.o jbd-kernel.o namespace.o quota.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
-else
-obj-y += noquot.o
 endif
 
 subdir-$(CONFIG_PROC_FS)	+= proc
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/fs/dquot.c linux-2.4.12-ac6-quotactl/fs/dquot.c
--- linux-2.4.12-ac6/fs/dquot.c	Thu Oct 25 23:42:08 2001
+++ linux-2.4.12-ac6-quotactl/fs/dquot.c	Fri Oct 26 00:25:49 2001
@@ -46,9 +46,12 @@
  *		Jan Kara <jack@suse.cz> 12/2000
  *
  *		New quotafile format
- *		Alocation units changed to bytes
+ *		Allocation units changed to bytes
  *		Jan Kara, <jack@suse.cz>, 2000
  *
+ *		Reworked the quotactl interface for filesystem-specific quota
+ *		Nathan Scott <nathans@sgi.com> and Jan Kara <jack@suse.cz>, 2001
+ *
  * (C) Copyright 1994 - 1997 Marco van Wieringen 
  */
 
@@ -65,6 +68,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -73,8 +77,6 @@
 #define __DQUOT_NUM_VERSION__	(6*10000+5*100+0)
 #define __DQUOT_PARANOIA
 
-int nr_dquots, nr_free_dquots;
-
 static const char *quotatypes[] = INITQFNAMES;
 static const uint quota_magics[] = INITQMAGICS;
 static const uint quota_versions[] = INITQVERSIONS;
@@ -1019,6 +1021,11 @@
 	return 0;
 }
 
+static int quota_sync(struct super_block *sb, short type)
+{
+	return sync_dquots(sb->s_dev, type);
+}
+
 /* Free unused dquots from cache */
 static void prune_dqcache(int count)
 {
@@ -1477,131 +1484,137 @@
  * Initialize a dquot-struct with new quota info. This is used by the
  * system call interface functions.
  */ 
-static int set_dqblk(struct super_block *sb, qid_t id, short type, int flags, struct mem_dqblk *dqblk)
+static int set_dqblk(struct super_block *sb, short type, qid_t id, struct mem_dqblk *dqblk, int op)
 {
 	struct dquot *dquot;
-	int error = -EFAULT;
-	struct mem_dqblk dq_dqblk;
-
-	if (copy_from_user(&dq_dqblk, dqblk, sizeof(struct mem_dqblk)))
-		return error;
 
-	if (sb && (dquot = dqget(sb, id, type)) != NODQUOT) {
-		/* We can't block while changing quota structure... */
-		if ((flags & SET_QUOTA) || (flags & SET_QLIMIT)) {
-			dquot->dq_bhardlimit = dq_dqblk.dqb_bhardlimit;
-			dquot->dq_bsoftlimit = dq_dqblk.dqb_bsoftlimit;
-			dquot->dq_ihardlimit = dq_dqblk.dqb_ihardlimit;
-			dquot->dq_isoftlimit = dq_dqblk.dqb_isoftlimit;
-		}
+	if (!sb_has_quota_enabled(sb, type))
+		return -ESRCH;
 
-		if ((flags & SET_QUOTA) || (flags & SET_USE)) {
-			if (dquot->dq_isoftlimit &&
-			    dquot->dq_curinodes < dquot->dq_isoftlimit &&
-			    dq_dqblk.dqb_curinodes >= dquot->dq_isoftlimit)
-				dquot->dq_itime = CURRENT_TIME + (__kernel_time_t)(sb_dqopt(dquot->dq_sb)->info[type].dqi_igrace);
-			dquot->dq_curinodes = dq_dqblk.dqb_curinodes;
-			if (dquot->dq_bsoftlimit &&
-			    toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit &&
-			    toqb(dq_dqblk.dqb_curspace) >= dquot->dq_bsoftlimit)
-				dquot->dq_btime = CURRENT_TIME + (__kernel_time_t)(sb_dqopt(dquot->dq_sb)->info[type].dqi_bgrace);
-			dquot->dq_curspace = dq_dqblk.dqb_curspace;
-		}
+	if ((dquot = dqget(sb, id, type)) == NODQUOT)
+		return -ESRCH;
 
-		if (dquot->dq_curinodes < dquot->dq_isoftlimit || !dquot->dq_isoftlimit) {
-			dquot->dq_itime = 0;
-			dquot->dq_flags &= ~DQ_INODES;
-		}
-		if (toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit || !dquot->dq_bsoftlimit) {
-			dquot->dq_btime = 0;
-			dquot->dq_flags &= ~DQ_BLKS;
-		}
+	/* We can't block while changing quota structure... */
+	if (op == Q_SETQUOTA || op == Q_SETQLIM) {
+		dquot->dq_bhardlimit = dqblk->dqb_bhardlimit;
+		dquot->dq_bsoftlimit = dqblk->dqb_bsoftlimit;
+		dquot->dq_ihardlimit = dqblk->dqb_ihardlimit;
+		dquot->dq_isoftlimit = dqblk->dqb_isoftlimit;
+	}
+
+	if (op == Q_SETQUOTA || op == Q_SETUSE) {
+		if (dquot->dq_isoftlimit &&
+		    dquot->dq_curinodes < dquot->dq_isoftlimit &&
+		    dqblk->dqb_curinodes >= dquot->dq_isoftlimit)
+			dquot->dq_itime = CURRENT_TIME + (__kernel_time_t)(sb_dqopt(dquot->dq_sb)->info[type].dqi_igrace);
+		dquot->dq_curinodes = dqblk->dqb_curinodes;
+		if (dquot->dq_bsoftlimit &&
+		    toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit &&
+		    toqb(dqblk->dqb_curspace) >= dquot->dq_bsoftlimit)
+			dquot->dq_btime = CURRENT_TIME + (__kernel_time_t)(sb_dqopt(dquot->dq_sb)->info[type].dqi_bgrace);
+		dquot->dq_curspace = dqblk->dqb_curspace;
+	}
+
+	if (dquot->dq_curinodes < dquot->dq_isoftlimit || !dquot->dq_isoftlimit) {
+		dquot->dq_itime = 0;
+		dquot->dq_flags &= ~DQ_INODES;
+	}
+	if (toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit || !dquot->dq_bsoftlimit) {
+		dquot->dq_btime = 0;
+		dquot->dq_flags &= ~DQ_BLKS;
+	}
 
-		if (dq_dqblk.dqb_bhardlimit == 0 && dq_dqblk.dqb_bsoftlimit == 0 &&
-		    dq_dqblk.dqb_ihardlimit == 0 && dq_dqblk.dqb_isoftlimit == 0)
-			dquot->dq_flags |= DQ_FAKE;
-		else
-			dquot->dq_flags &= ~DQ_FAKE;
+	if (dqblk->dqb_bhardlimit == 0 && dqblk->dqb_bsoftlimit == 0 &&
+	    dqblk->dqb_ihardlimit == 0 && dqblk->dqb_isoftlimit == 0)
+		dquot->dq_flags |= DQ_FAKE;
+	else
+		dquot->dq_flags &= ~DQ_FAKE;
 
-		dquot->dq_flags |= DQ_MOD;
-		dqput(dquot);
-	}
+	dquot->dq_flags |= DQ_MOD;
+	dqput(dquot);
 	return 0;
 }
 
-static int get_quota(struct super_block *sb, qid_t id, short type, struct mem_dqblk *dqblk)
+static int get_dqblk(struct super_block *sb, short type, qid_t id, struct mem_dqblk *dqblk)
 {
 	struct dquot *dquot;
-	struct mem_dqblk data;
 	int error = -ESRCH;
 
-	if (!sb || !sb_has_quota_enabled(sb, type))
+	if (!sb_has_quota_enabled(sb, type))
 		goto out;
 	dquot = dqget(sb, id, type);
 	if (dquot == NODQUOT)
 		goto out;
 
-	memcpy(&data, &dquot->dq_dqb, sizeof(struct mem_dqblk));        /* We copy data to preserve them from changing */
+	memcpy(dqblk, &dquot->dq_dqb, sizeof(struct mem_dqblk));        /* We copy data to preserve them from changing */
 	dqput(dquot);
-	error = -EFAULT;
-	if (dqblk && !copy_to_user(dqblk, &data, sizeof(struct mem_dqblk)))
-		error = 0;
+	error = 0;
 out:
 	return error;
 }
 
-static int get_stats(caddr_t addr)
+#ifdef CONFIG_PROC_FS
+static int read_stats(char *buffer, char **start, off_t offset, int count, int *eof, void *data)
 {
-	int error = -EFAULT;
-	struct dqstats stats;
+	int len;
 
 	dqstats.allocated_dquots = nr_dquots;
 	dqstats.free_dquots = nr_free_dquots;
 
-	/* make a copy, in case we page-fault in user space */
-	memcpy(&stats, &dqstats, sizeof(struct dqstats));
-	if (!copy_to_user(addr, &stats, sizeof(struct dqstats)))
-		error = 0;
-	return error;
-}
+	len = sprintf(buffer, "Version %u\n", dqstats.version);
+	len += sprintf(buffer + len, "%u %u %u %u %u %u %u %u\n",
+			dqstats.lookups, dqstats.drops,
+			dqstats.reads, dqstats.writes,
+			dqstats.cache_hits, dqstats.allocated_dquots,
+			dqstats.free_dquots, dqstats.syncs);
+
+	if (offset >= len) {
+		*start = buffer;
+		*eof = 1;
+		return 0;
+	}
+	*start = buffer + offset;
+	if ((len -= offset) > count)
+		return count;
+	*eof = 1;
+
+	return len;
+}
+#define quota_proc_init()	\
+	create_proc_read_entry("fs/quota", 0, 0, read_stats, NULL);
+#else
+#define quota_proc_init()	do { } while (0)
+#endif
 
-static int get_info(struct super_block *sb, short type, struct mem_dqinfo *pinfo)
+static int get_info(struct super_block *sb, short type, struct mem_dqinfo *kinfo)
 {
-	struct mem_dqinfo kinfo;
-	
-	if (!sb || !sb_has_quota_enabled(sb, type))
+	if (!sb_has_quota_enabled(sb, type))
 		return -ESRCH;
 	/* Make our own copy so we can guarantee consistent structure */
-	memcpy(&kinfo, sb_dqopt(sb)->info+type, sizeof(struct mem_dqinfo));
-	kinfo.dqi_flags &= DQF_MASK;
-	if (copy_to_user(pinfo, &kinfo, sizeof(struct mem_dqinfo)))
-		return -EFAULT;
+	memcpy(kinfo, sb_dqopt(sb)->info+type, sizeof(struct mem_dqinfo));
+	kinfo->dqi_flags &= DQF_MASK;
 	return 0;
 }
 
-static int set_info(int op, struct super_block *sb, short type, struct mem_dqinfo *pinfo)
+static int set_info(struct super_block *sb, short type, struct mem_dqinfo *pinfo, int op)
 {
-	struct mem_dqinfo info;
 	struct quota_info *dqopt = sb_dqopt(sb);
 
-	if (!sb || !sb_has_quota_enabled(sb, type))
+	if (!sb_has_quota_enabled(sb, type))
 		return -ESRCH;
 
-	if (copy_from_user(&info, pinfo, sizeof(struct mem_dqinfo)))
-		return -EFAULT;
-	
 	switch (op) {
-		case ISET_FLAGS:
+		case Q_SETFLAGS:
 			dqopt->info[type].dqi_flags = (dqopt->info[type].dqi_flags & ~DQF_MASK)
-			  | (info.dqi_flags & DQF_MASK);
+			  | (pinfo->dqi_flags & DQF_MASK);
 			break;
-		case ISET_GRACE:
-			dqopt->info[type].dqi_bgrace = info.dqi_bgrace;
-			dqopt->info[type].dqi_igrace = info.dqi_igrace;
+		case Q_SETGRACE:
+			dqopt->info[type].dqi_bgrace = pinfo->dqi_bgrace;
+			dqopt->info[type].dqi_igrace = pinfo->dqi_igrace;
 			break;
-		case ISET_ALL:
-			info.dqi_flags &= ~DQF_MASK;
-			memcpy(dqopt->info + type, &info, sizeof(struct mem_dqinfo));
+		case Q_SETINFO:
+			pinfo->dqi_flags &= ~DQF_MASK;
+			memcpy(dqopt->info + type, pinfo, sizeof(struct mem_dqinfo));
 			break;
  	}
 	mark_quotafile_info_dirty(dqopt->info + type);
@@ -1886,6 +1899,7 @@
 		INIT_LIST_HEAD(dquot_hash + i);
 	dqstats.version = __DQUOT_NUM_VERSION__;
 	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", __DQUOT_VERSION__);
+	quota_proc_init();
 	return 0;
 }
 __initcall(dquot_init);
@@ -1939,9 +1953,6 @@
 	short cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
 
-	if (!sb)
-		goto out;
-
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqoff_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -1963,7 +1974,6 @@
 		fput(filp);
 	}	
 	up(&dqopt->dqoff_sem);
-out:
 	return 0;
 }
 
@@ -2044,114 +2054,14 @@
 }
 
 /*
- * This is the system call interface. This communicates with
- * the user-level programs. Currently this only supports diskquota
- * calls. Maybe we need to add the process quotas etc. in the future,
- * but we probably should use rlimits for that.
+ * Definitions of quota operations accessible through quotactl(2).
  */
-asmlinkage long sys_quotactl(int cmd, const char *special, qid_t id, __kernel_caddr_t addr)
-{
-	int cmds = 0, type = 0, flags = 0;
-	kdev_t dev;
-	struct super_block *sb = NULL;
-	int ret = -EINVAL;
-
-	lock_kernel();
-	cmds = cmd >> SUBCMDSHIFT;
-	type = cmd & SUBCMDMASK;
-
-
-	if ((uint) type >= MAXQUOTAS || cmds > 0x1100 || cmds < 0x100 || cmds == 0x0300 ||
-	    cmds == 0x0400 || cmds == 0x0500 || cmds == 0x1000)
-		goto out;
-
-	ret = -EPERM;
-	switch (cmds) {
-		case Q_SYNC:
-		case Q_GETSTATS:
-		case Q_GETINFO:
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
-			ret = get_quota(sb, id, type, (struct mem_dqblk *) addr);
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
-			ret = sync_dquots(dev, type);
-			goto out;
-		case Q_GETSTATS:
-			ret = get_stats(addr);
-			goto out;
-		case Q_GETINFO:
-			ret = get_info(sb, type, (struct mem_dqinfo *) addr);
-			goto out;
-		case Q_SETFLAGS:
-			ret = set_info(ISET_FLAGS, sb, type, (struct mem_dqinfo *)addr);
-			goto out;
-		case Q_SETGRACE:
-			ret = set_info(ISET_GRACE, sb, type, (struct mem_dqinfo *)addr);
-			goto out;
-		case Q_SETINFO:
-			ret = set_info(ISET_ALL, sb, type, (struct mem_dqinfo *)addr);
- 			goto out;
-		default:
-			goto out;
-	}
-
-	ret = -NODEV;
-	if (sb && sb_has_quota_enabled(sb, type))
-		ret = set_dqblk(sb, id, type, flags, (struct mem_dqblk *) addr);
-out:
-	if (sb)
-		drop_super(sb);
-	unlock_kernel();
-	return ret;
-}
+struct quota_operations generic_quota_ops = {
+	quotaon:	quota_on,
+	quotaoff:	quota_off,
+	quotasync:	quota_sync,
+	getinfo:	get_info,
+	setinfo:	set_info,
+	getdqblk:	get_dqblk,
+	setdqblk:	set_dqblk,
+};
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/fs/noquot.c linux-2.4.12-ac6-quotactl/fs/noquot.c
--- linux-2.4.12-ac6/fs/noquot.c	Thu Oct 25 23:42:10 2001
+++ linux-2.4.12-ac6-quotactl/fs/noquot.c	Thu Jan  1 01:00:00 1970
@@ -1,20 +0,0 @@
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
-asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return(-ENOSYS);
-}
-
-void shrink_dqcache_memory(int priority, unsigned int gfp_mask)
-{
-	;
-}
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/fs/quota.c linux-2.4.12-ac6-quotactl/fs/quota.c
--- linux-2.4.12-ac6/fs/quota.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.12-ac6-quotactl/fs/quota.c	Thu Oct 25 23:49:50 2001
@@ -0,0 +1,211 @@
+/*
+ * Quota code necessary even when VFS quota support is not compiled
+ * into the kernel.  The interesting stuff is over in dquot.c, here
+ * we have symbols for initial quotactl(2) handling, the sysctl(2)
+ * variables, etc - things needed even when quota support disabled.
+ */
+
+#include <linux/fs.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+
+int nr_dquots, nr_free_dquots;
+
+#ifndef CONFIG_QUOTA
+void shrink_dqcache_memory(int priority, unsigned int mask)
+{
+	return;
+}
+#endif
+
+static struct super_block *
+validate_quotactl(int cmd, int type, const char *special, qid_t id)
+{
+	int ret;
+	kdev_t dev;
+	mode_t mode;
+	struct nameidata nd;
+	struct super_block *sb;
+
+	ret = -ENOSYS;
+	if (cmd == 0x0800 || cmd == 0x1100)	/* both were Q_GETSTATS */
+		goto error;
+
+	/* version/compatibility stuff - needs to be early on in the piece */
+	ret = -EINVAL;
+	if (cmd == 0x0300 || cmd == 0x0400 || cmd == 0x0500 || cmd == 0x1000
+	    || cmd < 0x100)
+		goto error;
+	if (type >= MAXQUOTAS)
+		goto error;
+
+	ret = -EPERM;
+	switch (cmd) {
+		case Q_SYNC:
+		case Q_GETINFO:
+		case Q_XGETQSTAT:
+			break;
+
+		case Q_GETQUOTA:
+		case Q_XGETQUOTA:
+			if (((type == USRQUOTA && current->euid != id) ||
+			     (type == GRPQUOTA && !in_egroup_p(id))) &&
+			    !capable(CAP_SYS_ADMIN))
+				goto error;
+
+		default:
+			if (!capable(CAP_SYS_ADMIN))
+				goto error;
+	}
+
+	ret = -ENODEV;
+	if (!special)
+		goto error;
+	ret = user_path_walk(special, &nd);
+	if (ret)
+		goto error;
+
+	dev = nd.dentry->d_inode->i_rdev;
+	mode = nd.dentry->d_inode->i_mode;
+	path_release(&nd);
+
+	ret = -ENOTBLK;
+	if (!S_ISBLK(mode))
+		goto error;
+
+	ret = -ENODEV;
+	sb = get_super(dev);
+	if (!sb)
+		goto error;
+
+	ret = -ENOSYS;
+	if (!sb->s_qop) {
+		drop_super(sb);
+		goto error;
+	}
+
+	return sb;
+error:
+	return ERR_PTR(ret);
+}
+
+asmlinkage long
+sys_quotactl(int cmd, const char *special, qid_t id, __kernel_caddr_t addr)
+{
+	int ret, cmds, type;
+	struct super_block *sb;
+	union {
+		char *pathname;
+		unsigned int flags;
+		struct mem_dqblk mdq;
+		struct mem_dqinfo info;
+		struct fs_disk_quota fdq;
+		struct fs_quota_stat fqs;
+	} u;  /* qualifies valid uses of "addr" */
+
+	lock_kernel();
+	cmds = cmd >> SUBCMDSHIFT;
+	type = cmd & SUBCMDMASK;
+
+	sb = validate_quotactl(cmds, type, special, id);
+	if (IS_ERR(sb)) {
+		unlock_kernel();
+		return PTR_ERR(sb);
+	}
+
+	ret = -EINVAL;
+	switch (cmds) {
+		case Q_QUOTAON:
+			u.pathname = (char *)addr;
+			if (sb->s_qop->quotaon)
+				ret = sb->s_qop->quotaon(sb, type, u.pathname);
+			break;
+
+		case Q_QUOTAOFF:
+			if (sb->s_qop->quotaoff)
+				ret = sb->s_qop->quotaoff(sb, type);
+			break;
+
+	    	case Q_SYNC:
+			if (sb->s_qop->quotasync)
+				ret = sb->s_qop->quotasync(sb, type);
+			break;
+
+		case Q_GETINFO:
+			if (sb->s_qop->getinfo)
+				ret = sb->s_qop->getinfo(sb, type, &u.info);
+			if (!ret && copy_to_user(addr, &u.info, sizeof(u.info)))
+				ret = -EFAULT;
+			break;
+
+		case Q_SETINFO:
+		case Q_SETFLAGS:
+		case Q_SETGRACE:
+			if (!sb->s_qop->setinfo)
+				break;
+			ret = -EFAULT;
+			if (copy_from_user(&u.info, addr, sizeof(u.info)))
+				break;
+			ret = sb->s_qop->setinfo(sb, type, &u.info, cmds);
+			break;
+
+		case Q_GETQUOTA:
+			if (sb->s_qop->getdqblk)
+				ret = sb->s_qop->getdqblk(sb, type, id, &u.mdq);
+			if (!ret && copy_to_user(addr, &u.mdq, sizeof(u.mdq)))
+				ret = -EFAULT;
+			break;
+
+		case Q_SETUSE:
+		case Q_SETQLIM:
+		case Q_SETQUOTA:
+			if (!sb->s_qop->setdqblk)
+				break;
+			ret = -EFAULT;
+			if (copy_from_user(&u.mdq, addr, sizeof(u.mdq)))
+				break;
+			ret = sb->s_qop->setdqblk(sb, type, id, &u.mdq, cmds);
+			break;
+
+		case Q_XQUOTAON:
+		case Q_XQUOTAOFF:
+		case Q_XQUOTARM:
+			if (!sb->s_qop->setxstate)
+				break;
+			ret = -EFAULT;
+			if (copy_from_user(&u.flags, addr, sizeof(u.flags)))
+				break;
+			ret = sb->s_qop->setxstate(sb, u.flags, cmds);
+			break;
+
+		case Q_XGETQSTAT:
+			if (sb->s_qop->getxstate)
+				ret = sb->s_qop->getxstate(sb, &u.fqs);
+			if (!ret && copy_to_user(addr, &u.fqs, sizeof(u.fqs)))
+				ret = -EFAULT;
+			break;
+
+		case Q_XSETQLIM:
+			if (!sb->s_qop->setxquota)
+				break;
+			ret = -EFAULT;
+			if (copy_from_user(&u.fdq, addr, sizeof(u.fdq)))
+				break;
+			ret = sb->s_qop->setxquota(sb, type, id, &u.fdq);
+			break;
+
+		case Q_XGETQUOTA:
+			if (sb->s_qop->getxquota)
+				ret = sb->s_qop->getxquota(sb, type, id, &u.fdq);
+			if (!ret && copy_to_user(addr, &u.fdq, sizeof(u.fdq)))
+				ret = -EFAULT;
+			break;
+
+		default:
+	}
+	drop_super(sb);
+	unlock_kernel();
+	return ret;
+}
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/fs/super.c linux-2.4.12-ac6-quotactl/fs/super.c
--- linux-2.4.12-ac6/fs/super.c	Thu Oct 25 23:42:11 2001
+++ linux-2.4.12-ac6-quotactl/fs/super.c	Thu Oct 25 23:49:50 2001
@@ -437,6 +437,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->s_qop = sb_generic_quota_ops;
 	}
 	return s;
 }
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/include/linux/fs.h linux-2.4.12-ac6-quotactl/include/linux/fs.h
--- linux-2.4.12-ac6/include/linux/fs.h	Thu Oct 25 23:42:16 2001
+++ linux-2.4.12-ac6-quotactl/include/linux/fs.h	Thu Oct 25 23:53:37 2001
@@ -377,6 +377,7 @@
 /*
  * Includes for diskquotas and mount structures.
  */
+#include <linux/xqm.h>
 #include <linux/quota.h>
 #include <linux/mount.h>
 
@@ -660,6 +661,20 @@
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 };
 
+struct quota_operations {
+	int (*quotaon)(struct super_block *, short, char *);
+	int (*quotaoff)(struct super_block *, short);
+	int (*quotasync)(struct super_block *, short);
+	int (*getinfo)(struct super_block *, short, struct mem_dqinfo *);
+	int (*setinfo)(struct super_block *, short, struct mem_dqinfo *, int);
+	int (*getdqblk)(struct super_block *, short, qid_t, struct mem_dqblk *);
+	int (*setdqblk)(struct super_block *, short, qid_t, struct mem_dqblk *, int);
+	int (*getxstate)(struct super_block *, struct fs_quota_stat *);
+	int (*setxstate)(struct super_block *, unsigned int, int);
+	int (*getxquota)(struct super_block *, short, qid_t, struct fs_disk_quota *);
+	int (*setxquota)(struct super_block *, short, qid_t, struct fs_disk_quota *);
+};
+
 /*
  *	Umount options
  */
@@ -721,6 +736,7 @@
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct quota_operations	*s_qop;
 
 	union {
 		struct minix_sb_info	minix_sb;
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/include/linux/quota.h linux-2.4.12-ac6-quotactl/include/linux/quota.h
--- linux-2.4.12-ac6/include/linux/quota.h	Thu Oct 25 23:42:17 2001
+++ linux-2.4.12-ac6-quotactl/include/linux/quota.h	Thu Oct 25 23:49:50 2001
@@ -107,7 +107,7 @@
 #define Q_SETQUOTA 0x0E00	/* set limits and usage */
 #define Q_SETUSE   0x0F00	/* set usage */
 /* 0x1000 used by old RSQUASH */
-#define Q_GETSTATS 0x1100	/* get collected stats */
+/* 0x1100 used by GETSTATS v2, since replaced by procfs entry */
 
 /*
  * The following structure defines the format of the disk quota file
@@ -253,13 +253,6 @@
 #define dq_bhardlimit dq_dqb.dqb_bhardlimit
 #define dq_itime dq_dqb.dqb_itime
 #define dq_btime dq_dqb.dqb_btime
-
-/*
- * Flags used for set_dqblk.
- */
-#define SET_QUOTA         0x01
-#define SET_USE           0x02
-#define SET_QLIMIT        0x04
 
 /*
  * Flags used for set_info
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/include/linux/quotaops.h linux-2.4.12-ac6-quotactl/include/linux/quotaops.h
--- linux-2.4.12-ac6/include/linux/quotaops.h	Thu Oct 25 23:42:17 2001
+++ linux-2.4.12-ac6-quotactl/include/linux/quotaops.h	Thu Oct 25 23:57:24 2001
@@ -17,6 +17,9 @@
 
 #include <linux/fs.h>
 
+extern struct quota_operations generic_quota_ops;
+#define sb_generic_quota_ops (&generic_quota_ops)
+
 /*
  * declaration of quota_function calls in kernel.
  */
@@ -166,6 +169,7 @@
 /*
  * NO-OP when quota not configured.
  */
+#define sb_generic_quota_ops			(NULL)
 #define DQUOT_INIT(inode)			do { } while(0)
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/include/linux/sysctl.h linux-2.4.12-ac6-quotactl/include/linux/sysctl.h
--- linux-2.4.12-ac6/include/linux/sysctl.h	Thu Oct 25 23:42:17 2001
+++ linux-2.4.12-ac6-quotactl/include/linux/sysctl.h	Thu Oct 25 23:53:47 2001
@@ -535,7 +535,7 @@
 	FS_STATINODE=2,
 	FS_MAXINODE=3,	/* int:maximum number of inodes that can be allocated */
 	FS_NRDQUOT=4,	/* int:current number of allocated dquots */
-	FS_MAXDQUOT=5,	/* int:maximum number of dquots that can be allocated */
+	/* was FS_MAXDQUOT */
 	FS_NRFILE=6,	/* int:current number of allocated filedescriptors */
 	FS_MAXFILE=7,	/* int:maximum number of filedescriptors that can be allocated */
 	FS_DENTRY=8,
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.12-ac6/include/linux/xqm.h linux-2.4.12-ac6-quotactl/include/linux/xqm.h
--- linux-2.4.12-ac6/include/linux/xqm.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.12-ac6-quotactl/include/linux/xqm.h	Thu Oct 25 23:49:50 2001
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
+ * fs_quota_stat is the struct returned in Q_XGETQSTAT for a given file system.
+ * Provides a centralized way to get meta infomation about the quota subsystem.
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

--DocE+STaALJfprDB--
