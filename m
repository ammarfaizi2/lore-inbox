Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310509AbSCCKIv>; Sun, 3 Mar 2002 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293536AbSCCKHv>; Sun, 3 Mar 2002 05:07:51 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:43270 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S293548AbSCCJ5B>; Sun, 3 Mar 2002 04:57:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 12
Date: Sun, 3 Mar 2002 04:57:21 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095640Z293042-31667+12@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the twelveth of 13 patches.


	This patch adds a compatibility interface (aka old style) to the code and an 
option to enable it.



diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Config.in 
linux-2.5/fs/Config.in
--- linux-2.5-linus/fs/Config.in	Sun Mar  3 03:30:20 2002
+++ linux-2.5/fs/Config.in	Sun Mar  3 03:43:44 2002
@@ -7,6 +7,12 @@
 bool 'Quota support' CONFIG_QUOTA
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
 dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
+dep_mbool '  Compatible quota interfaces' CONFIG_QIFACE_COMPAT $CONFIG_QUOTA
+if [ "$CONFIG_QUOTA" = "y" -a "$CONFIG_QIFACE_COMPAT" = "y" ]; then
+   choice '    Compatible quota interfaces' \
+	"Original	CONFIG_QIFACE_V1 \
+	 VFSv0		CONFIG_QIFACE_V2" Original
+fi
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' 
CONFIG_AUTOFS4_FS
 
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/quota.c linux-2.5/fs/quota.c
--- linux-2.5-linus/fs/quota.c	Sun Mar  3 03:17:12 2002
+++ linux-2.5/fs/quota.c	Sun Mar  3 03:43:44 2002
@@ -12,6 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
+#ifdef CONFIG_QIFACE_COMPAT
+#include <linux/quotacompat.h>
+#endif
+
 
 int nr_dquots, nr_free_dquots;
 
@@ -232,6 +236,371 @@
 	return 0;
 }
 
+#ifdef CONFIG_QIFACE_COMPAT
+static int check_compat_quotactl_valid(struct super_block *sb, int type, int 
cmd, qid_t id)
+{
+	if (type >= MAXQUOTAS)
+		return -EINVAL;
+	/* Is operation supported? */
+	if (!sb->s_qcop)
+		return -ENOSYS;
+
+	switch (cmd) {
+	    case Q_COMP_QUOTAON:
+		if (!sb->s_qcop->quota_on)
+			return -ENOSYS;
+		break;
+	    case Q_COMP_QUOTAOFF:
+		if (!sb->s_qcop->quota_off)
+			return -ENOSYS;
+		break;
+	    case Q_COMP_SYNC:
+		if (!sb->s_qcop->quota_sync)
+			return -ENOSYS;
+		break;
+#ifdef CONFIG_QIFACE_V2
+	    case Q_V2_SETFLAGS:
+	    case Q_V2_SETGRACE:
+	    case Q_V2_SETINFO:
+		if (!sb->s_qcop->set_info)
+			return -ENOSYS;
+		break;
+	    case Q_V2_GETINFO:
+		if (!sb->s_qcop->get_info)
+			return -ENOSYS;
+		break;
+	    case Q_V2_SETQLIM:
+	    case Q_V2_SETUSE:
+	    case Q_V2_SETQUOTA:
+		if (!sb->s_qcop->set_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_V2_GETQUOTA:
+		if (!sb->s_qcop->get_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_V2_GETSTATS:
+		break;
+#endif
+#ifdef CONFIG_QIFACE_V1
+	    case Q_V1_SETQLIM:
+	    case Q_V1_SETUSE:
+	    case Q_V1_SETQUOTA:
+		if (!sb->s_qcop->set_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_V1_GETQUOTA:
+		if (!sb->s_qcop->get_dqblk)
+			return -ENOSYS;
+		break;
+	    case Q_V1_RSQUASH:
+		if (!sb->s_qcop->set_info)
+			return -ENOSYS;
+		break;
+	    case Q_V1_GETSTATS:
+		break;
+#endif
+	    default:
+		return -EINVAL;
+	}
+
+#ifdef CONFIG_QIFACE_V1
+	if (cmd != Q_COMP_QUOTAON && cmd != Q_COMP_QUOTAOFF && cmd != Q_COMP_SYNC 
&& sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id != QFMT_VFS_OLD)
+#else
+	if (cmd != Q_COMP_QUOTAON && cmd != Q_COMP_QUOTAOFF && cmd != Q_COMP_SYNC 
&& sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id != QFMT_VFS_V0)
+#endif
+		return -ESRCH;
+
+	/* Is quota turned on for commands which need it? */
+	switch (cmd) {
+	    case Q_V2_SETFLAGS:
+	    case Q_V2_SETGRACE:
+	    case Q_V2_SETINFO:
+	    case Q_V2_GETINFO:
+	    case Q_COMP_QUOTAOFF:
+	    case Q_V1_RSQUASH:
+	    case Q_V1_SETQUOTA:
+	    case Q_V1_SETQLIM:
+	    case Q_V1_SETUSE:
+	    case Q_V2_SETQUOTA:
+	    /* Q_V2_SETQLIM: collision with Q_V1_SETQLIM */
+	    case Q_V2_SETUSE:
+	    case Q_V1_GETQUOTA:
+	    case Q_V2_GETQUOTA:
+		if (!sb_has_quota_enabled(sb, type))
+			return -ESRCH;
+	}
+	/* Check privileges */
+	if (cmd == Q_V1_GETQUOTA || cmd == Q_V2_GETQUOTA) {
+		if (((type == USRQUOTA && current->euid != id) ||
+		     (type == GRPQUOTA && !in_egroup_p(id))) &&
+		    !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+	else if (cmd != Q_V1_GETSTATS && cmd != Q_V2_GETSTATS && cmd != 
Q_V2_GETINFO && cmd != Q_COMP_SYNC)
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	return 0;
+}
+
+static int v1_set_rsquash(struct super_block *sb, int type, int flag)
+{
+	struct if_dqinfo info;
+
+	info.dqi_valid = IIF_FLAGS;
+	info.dqi_flags = flag ? V1_DQF_RSQUASH : 0;
+	return sb->s_qcop->set_info(sb, type, &info);
+}
+
+static int v1_get_dqblk(struct super_block *sb, int type, qid_t id, struct 
v1c_mem_dqblk *mdq)
+{
+	struct if_dqblk idq;
+	int ret;
+
+	if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)) < 0)
+		return ret;
+	mdq->dqb_ihardlimit = idq.dqb_ihardlimit;
+	mdq->dqb_isoftlimit = idq.dqb_isoftlimit;
+	mdq->dqb_curinodes = idq.dqb_curinodes;
+	mdq->dqb_bhardlimit = idq.dqb_bhardlimit;
+	mdq->dqb_bsoftlimit = idq.dqb_bsoftlimit;
+	mdq->dqb_curblocks = toqb(idq.dqb_curspace);
+	mdq->dqb_itime = idq.dqb_itime;
+	mdq->dqb_btime = idq.dqb_btime;
+	if (id == 0) {	/* Times for id 0 are in fact grace times */
+		struct if_dqinfo info;
+
+		if ((ret = sb->s_qcop->get_info(sb, type, &info)) < 0)
+			return ret;
+		mdq->dqb_btime = info.dqi_bgrace;
+		mdq->dqb_itime = info.dqi_igrace;
+	}
+	return 0;
+}
+
+static int v1_set_dqblk(struct super_block *sb, int type, int cmd, qid_t id, 
struct v1c_mem_dqblk *mdq)
+{
+	struct if_dqblk idq;
+	int ret;
+
+	idq.dqb_valid = 0;
+	if (cmd == Q_V1_SETQUOTA || cmd == Q_V1_SETQLIM) {
+		idq.dqb_ihardlimit = mdq->dqb_ihardlimit;
+		idq.dqb_isoftlimit = mdq->dqb_isoftlimit;
+		idq.dqb_bhardlimit = mdq->dqb_bhardlimit;
+		idq.dqb_bsoftlimit = mdq->dqb_bsoftlimit;
+		idq.dqb_valid |= QIF_LIMITS;
+	}
+	if (cmd == Q_V1_SETQUOTA || cmd == Q_V1_SETUSE) {
+		idq.dqb_curinodes = mdq->dqb_curinodes;
+		idq.dqb_curspace = ((qsize_t)mdq->dqb_curblocks) << QUOTABLOCK_BITS;
+		idq.dqb_valid |= QIF_USAGE;
+	}
+	ret = sb->s_qcop->set_dqblk(sb, type, id, &idq);
+	if (!ret && id == 0 && cmd == Q_V1_SETQUOTA) {	/* Times for id 0 are in 
fact grace times */
+		struct if_dqinfo info;
+
+		info.dqi_bgrace = mdq->dqb_btime;
+		info.dqi_igrace = mdq->dqb_itime;
+		info.dqi_valid = IIF_BGRACE | IIF_IGRACE;
+		ret = sb->s_qcop->set_info(sb, type, &info);
+	}
+	return ret;
+}
+
+static void v1_get_stats(struct v1c_dqstats *dst)
+{
+	memcpy(dst, &dqstats, sizeof(dqstats));
+}
+
+static int v2_get_info(struct super_block *sb, int type, struct 
v2c_mem_dqinfo *oinfo)
+{
+	struct if_dqinfo info;
+	int ret;
+
+	if ((ret = sb->s_qcop->get_info(sb, type, &info)) < 0)
+		return ret;
+	oinfo->dqi_bgrace = info.dqi_bgrace;
+	oinfo->dqi_igrace = info.dqi_igrace;
+	oinfo->dqi_flags = info.dqi_flags;
+	oinfo->dqi_blocks = sb_dqopt(sb)->info[type].u.v2_i.dqi_blocks;
+	oinfo->dqi_free_blk = sb_dqopt(sb)->info[type].u.v2_i.dqi_free_blk;
+	oinfo->dqi_free_entry = sb_dqopt(sb)->info[type].u.v2_i.dqi_free_entry;
+	return 0;
+}
+
+static int v2_set_info(struct super_block *sb, int type, int cmd, struct 
v2c_mem_dqinfo *oinfo)
+{
+	struct if_dqinfo info;
+
+	info.dqi_valid = 0;
+	if (cmd == Q_V2_SETGRACE || cmd == Q_V2_SETQUOTA) {
+		info.dqi_bgrace = oinfo->dqi_bgrace;
+		info.dqi_igrace = oinfo->dqi_igrace;
+		info.dqi_valid |= IIF_BGRACE | IIF_IGRACE;
+	}
+	if (cmd == Q_V2_SETFLAGS || cmd == Q_V2_SETQUOTA) {
+		info.dqi_flags = oinfo->dqi_flags;
+		info.dqi_valid |= IIF_FLAGS;
+	}
+	/* We don't simulate deadly effects of setting other parameters ;-) */
+	return sb->s_qcop->set_info(sb, type, &info);
+}
+
+static int v2_get_dqblk(struct super_block *sb, int type, qid_t id, struct 
v2c_mem_dqblk *mdq)
+{
+	struct if_dqblk idq;
+	int ret;
+
+	if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)) < 0)
+		return ret;
+	mdq->dqb_ihardlimit = idq.dqb_ihardlimit;
+	mdq->dqb_isoftlimit = idq.dqb_isoftlimit;
+	mdq->dqb_curinodes = idq.dqb_curinodes;
+	mdq->dqb_bhardlimit = idq.dqb_bhardlimit;
+	mdq->dqb_bsoftlimit = idq.dqb_bsoftlimit;
+	mdq->dqb_curspace = idq.dqb_curspace;
+	mdq->dqb_itime = idq.dqb_itime;
+	mdq->dqb_btime = idq.dqb_btime;
+	return 0;
+}
+
+static int v2_set_dqblk(struct super_block *sb, int type, int cmd, qid_t id, 
struct v2c_mem_dqblk *mdq)
+{
+	struct if_dqblk idq;
+
+	idq.dqb_valid = 0;
+	if (cmd == Q_V2_SETQUOTA || cmd == Q_V2_SETQLIM) {
+		idq.dqb_ihardlimit = mdq->dqb_ihardlimit;
+		idq.dqb_isoftlimit = mdq->dqb_isoftlimit;
+		idq.dqb_bhardlimit = mdq->dqb_bhardlimit;
+		idq.dqb_bsoftlimit = mdq->dqb_bsoftlimit;
+		idq.dqb_valid |= QIF_LIMITS;
+	}
+	if (cmd == Q_V2_SETQUOTA || cmd == Q_V2_SETUSE) {
+		idq.dqb_curinodes = mdq->dqb_curinodes;
+		idq.dqb_curspace = mdq->dqb_curspace;
+		idq.dqb_valid |= QIF_USAGE;
+	}
+	return sb->s_qcop->set_dqblk(sb, type, id, &idq);
+}
+
+static void v2_get_stats(struct v2c_dqstats *dst)
+{
+	memcpy(dst, &dqstats, sizeof(dqstats));
+	dst->version = __DQUOT_NUM_VERSION__;
+}
+
+/* Handle requests to old interface */
+static int do_compat_quotactl(struct super_block *sb, int type, int cmd, 
qid_t id, caddr_t addr)
+{
+	int ret;
+
+	switch (cmd) {
+		case Q_COMP_QUOTAON: {
+			char *pathname;
+
+			if (IS_ERR(pathname = getname(addr)))
+				return PTR_ERR(pathname);
+#ifdef CONFIG_QIFACE_V1
+			ret = sb->s_qcop->quota_on(sb, type, QFMT_VFS_OLD, pathname);
+#else
+			ret = sb->s_qcop->quota_on(sb, type, QFMT_VFS_V0, pathname);
+#endif
+			putname(pathname);
+			return ret;
+		}
+		case Q_COMP_QUOTAOFF:
+			return sb->s_qcop->quota_off(sb, type);
+		case Q_COMP_SYNC:
+			return sb->s_qcop->quota_sync(sb, type);
+		case Q_V1_RSQUASH: {
+			int flag;
+
+			if (copy_from_user(&flag, addr, sizeof(flag)))
+				return -EFAULT;
+			return v1_set_rsquash(sb, type, flag);
+		}
+		case Q_V1_GETQUOTA: {
+			struct v1c_mem_dqblk mdq;
+
+			if ((ret = v1_get_dqblk(sb, type, id, &mdq)))
+				return ret;
+			if (copy_to_user(addr, &mdq, sizeof(mdq)))
+				return -EFAULT;
+			return 0;
+		}
+		/* We must resolve collision of Q_V1_SETQLIM and Q_V2_SETQLIM */
+		case Q_V1_SETQLIM:
+		case Q_V1_SETUSE:
+		case Q_V1_SETQUOTA:
+		case Q_V2_SETUSE:
+		/* Q_V2_SETQLIM collision with Q_V1_SETQLIM */
+		case Q_V2_SETQUOTA:
+			if (sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id == QFMT_VFS_V0) {
+				struct v2c_mem_dqblk mdq;
+
+				if (copy_from_user(&mdq, addr, sizeof(mdq)))
+					return -EFAULT;
+				return v2_set_dqblk(sb, type, cmd, id, &mdq);
+			}
+			else {
+				struct v1c_mem_dqblk mdq;
+
+				if (copy_from_user(&mdq, addr, sizeof(mdq)))
+					return -EFAULT;
+				return v1_set_dqblk(sb, type, cmd, id, &mdq);
+			}
+		case Q_V1_GETSTATS: {
+			struct v1c_dqstats dst;
+
+			v1_get_stats(&dst);
+			if (copy_to_user(addr, &dst, sizeof(dst)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_V2_GETINFO: {
+			struct v2c_mem_dqinfo info;
+
+			if ((ret = v2_get_info(sb, type, &info)))
+				return ret;
+			if (copy_to_user(addr, &info, sizeof(info)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_V2_SETFLAGS:
+		case Q_V2_SETGRACE:
+		case Q_V2_SETINFO: {
+			struct v2c_mem_dqinfo info;
+
+			if (copy_from_user(&info, addr, sizeof(info)))
+				return -EFAULT;
+			
+			return v2_set_info(sb, type, cmd, &info);
+		}
+		case Q_V2_GETQUOTA: {
+			struct v2c_mem_dqblk mdq;
+
+			if ((ret = v2_get_dqblk(sb, type, id, &mdq)))
+				return ret;
+			if (copy_to_user(addr, &mdq, sizeof(mdq)))
+				return -EFAULT;
+			return 0;
+		}
+		case Q_V2_GETSTATS: {
+			struct v2c_dqstats dst;
+
+			v2_get_stats(&dst);
+			if (copy_to_user(addr, &dst, sizeof(dst)))
+				return -EFAULT;
+			return 0;
+		}
+	}
+	BUG();
+	return 0;
+}
+#endif
+
 /*
  * This is the system call interface. This communicates with
  * the user-level programs. Currently this only supports diskquota
@@ -248,11 +617,26 @@
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
+#ifdef CONFIG_QIFACE_COMPAT
+	if (((cmds != Q_SYNC && cmds != Q_COMP_SYNC) || special) && IS_ERR(sb = 
resolve_dev(special))) {
+		ret = PTR_ERR(sb);
+		sb = NULL;
+		goto out;
+	}
+	if (!(cmds & 0x800000) && cmds != Q_XQUOTAON && cmds != Q_XQUOTAOFF && cmds 
!= Q_XQUOTARM &&
+	    cmds != Q_XGETQSTAT && cmds != Q_XGETQUOTA && cmds != Q_XSETQLIM) {
+		if ((ret = check_compat_quotactl_valid(sb, type, cmds, id)) < 0)
+			goto out;
+		ret = do_compat_quotactl(sb, type, cmds, id, addr);
+		goto out;
+	}
+#else
 	if ((cmds != Q_SYNC || special) && IS_ERR(sb = resolve_dev(special))) {
 		ret = PTR_ERR(sb);
 		sb = NULL;
 		goto out;
 	}
+#endif
 	if ((ret = check_quotactl_valid(sb, type, cmds, id)) < 0)
 		goto out;
 	ret = do_quotactl(sb, type, cmds, id, addr);
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotacompat.h 
linux-2.5/include/linux/quotacompat.h
--- linux-2.5-linus/include/linux/quotacompat.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5/include/linux/quotacompat.h	Sun Mar  3 03:43:44 2002
@@ -0,0 +1,86 @@
+/*
+ *	Definition of symbols used for backward compatible interface
+ */
+
+#ifndef _LINUX_QUOTACOMPAT_
+#define _LINUX_QUOTACOMPAT_
+
+#include <linux/types.h>
+#include <linux/quota.h>
+
+struct v1c_mem_dqblk {
+	__u32 dqb_bhardlimit;	/* absolute limit on disk blks alloc */
+	__u32 dqb_bsoftlimit;	/* preferred limit on disk blks */
+	__u32 dqb_curblocks;	/* current block count */
+	__u32 dqb_ihardlimit;	/* maximum # allocated inodes */
+	__u32 dqb_isoftlimit;	/* preferred inode limit */
+	__u32 dqb_curinodes;	/* current # allocated inodes */
+	time_t dqb_btime;	/* time limit for excessive disk use */
+	time_t dqb_itime;	/* time limit for excessive files */
+};
+
+struct v1c_dqstats {
+	__u32 lookups;
+	__u32 drops;
+	__u32 reads;
+	__u32 writes;
+	__u32 cache_hits;
+	__u32 allocated_dquots;
+	__u32 free_dquots;
+	__u32 syncs;
+};
+
+struct v2c_mem_dqblk {
+	unsigned int dqb_ihardlimit;
+	unsigned int dqb_isoftlimit;
+	unsigned int dqb_curinodes;
+	unsigned int dqb_bhardlimit;
+	unsigned int dqb_bsoftlimit;
+	qsize_t dqb_curspace;
+	__kernel_time_t dqb_btime;
+	__kernel_time_t dqb_itime;
+};
+
+struct v2c_mem_dqinfo {
+	unsigned int dqi_bgrace;
+	unsigned int dqi_igrace;
+	unsigned int dqi_flags;
+	unsigned int dqi_blocks;
+	unsigned int dqi_free_blk;
+	unsigned int dqi_free_entry;
+};
+
+struct v2c_dqstats {
+	__u32 lookups;
+	__u32 drops;
+	__u32 reads;
+	__u32 writes;
+	__u32 cache_hits;
+	__u32 allocated_dquots;
+	__u32 free_dquots;
+	__u32 syncs;
+	__u32 version;
+};
+
+#define Q_COMP_QUOTAON  0x0100	/* enable quotas */
+#define Q_COMP_QUOTAOFF 0x0200	/* disable quotas */
+#define Q_COMP_SYNC     0x0600	/* sync disk copy of a filesystems quotas */
+
+#define Q_V1_GETQUOTA 0x0300	/* get limits and usage */
+#define Q_V1_SETQUOTA 0x0400	/* set limits and usage */
+#define Q_V1_SETUSE   0x0500	/* set usage */
+#define Q_V1_SETQLIM  0x0700	/* set limits */
+#define Q_V1_GETSTATS 0x0800	/* get collected stats */
+#define Q_V1_RSQUASH  0x1000	/* set root_squash option */
+
+#define Q_V2_SETQLIM  0x0700	/* set limits */
+#define Q_V2_GETINFO  0x0900	/* get info about quotas - graces, flags... */
+#define Q_V2_SETINFO  0x0A00	/* set info about quotas */
+#define Q_V2_SETGRACE 0x0B00	/* set inode and block grace */
+#define Q_V2_SETFLAGS 0x0C00	/* set flags for quota */
+#define Q_V2_GETQUOTA 0x0D00	/* get limits and usage */
+#define Q_V2_SETQUOTA 0x0E00	/* set limits and usage */
+#define Q_V2_SETUSE   0x0F00	/* set usage */
+#define Q_V2_GETSTATS 0x1100	/* get collected stats */
+
+#endif
