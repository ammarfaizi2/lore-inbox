Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWBMWJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWBMWJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBMWJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:09:29 -0500
Received: from ns.suse.de ([195.135.220.2]:30624 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964875AbWBMWJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:09:27 -0500
From: Neil Brown <neilb@suse.de>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Date: Tue, 14 Feb 2006 09:09:12 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17393.904.252068.459547@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
In-Reply-To: message from Chris Stromsoe on Monday February 13
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 13, cbs@cts.ucla.edu wrote:
> I'm looking for a file system with a tree-based quota system.  XFS on IRIX 
> has projects, but that functionality didn't get ported over to Linux that 
> I can see.
> 
> I'm building a closed-box system to serve web pages.  I expect to have 20k 
> to 30k different user trees.  User's will not have direct access to the 
> box and will not be assigned a uid/gid.  Every tree will be owned by the 
> same uid/gid.
> 
> I would like to be able to apply a quota to a particular tree, and have 
> every file and directory in the path of that tree count toward that tree's 
> quota usage.  I can prevent hard links across trees.
> 
> I noticed that Neil Brown wrote some patches fairly early on in the 2.4 
> cycle to do tree-based quota by UID.  The last patch-set I found was 
> against 2.4.14 (http://cgi.cse.unsw.edu.au/~neilb/patches/linux/2.4.14/) 
> from late 2001, and did not come with patches to quota-tools.

Following is my tree-quota patch updated to 2.6.14.3.  However it
doesn't do exactly what you claim to want.
You still need to assign a uid to each user (the kernel needs some
number to use as an index into the quotas file).  But only the
top-level directory of each tree needs to be owned by the uid.  Files
beneath the top can be owned by anyone.

I can dig-up a patch for quota-utils if you want to proceed with
this.

If you are using a more recent kernel and get a conflict in fs.h,
you'll just need to #define ATTR_TID to be 16384, because 8192 was
taken by ATTR_FILE.

NeilBrown




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/attr.c                |   16 ++++++++++++
 ./fs/dquot.c               |   20 +++++++++++++++
 ./fs/ext2/ialloc.c         |    1 
 ./fs/ext2/inode.c          |    3 ++
 ./fs/ext2/super.c          |    1 
 ./fs/ext3/ialloc.c         |    1 
 ./fs/ext3/inode.c          |    5 +++
 ./fs/ext3/super.c          |   45 +++++++++++++++++++++++++++++-----
 ./fs/namei.c               |   36 ++++++++++++++++++++++++++-
 ./fs/quota_v1.c            |    3 +-
 ./fs/stat.c                |    1 
 ./include/linux/ext2_fs.h  |    4 +--
 ./include/linux/ext3_fs.h  |    2 +
 ./include/linux/fs.h       |    3 ++
 ./include/linux/quota.h    |   16 +++++++++---
 ./include/linux/quotaops.h |   58 +++++++++++++++++++++++++++++++++++++++++++++
 ./include/linux/stat.h     |    1 
 17 files changed, 200 insertions(+), 16 deletions(-)

diff ./fs/attr.c~current~ ./fs/attr.c
--- ./fs/attr.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/attr.c	2005-12-07 11:28:43.000000000 +1100
@@ -87,6 +87,8 @@ int inode_setattr(struct inode * inode, 
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
+	if (ia_valid & ATTR_TID)
+		inode->i_tid = attr->ia_tid;
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = timespec_trunc(attr->ia_atime,
 						inode->i_sb->s_time_gran);
@@ -154,6 +156,19 @@ int notify_change(struct dentry * dentry
 	if (ia_valid & ATTR_SIZE)
 		down_write(&dentry->d_inode->i_alloc_sem);
 
+	if (!(ia_valid & ATTR_TID)
+	    && (ia_valid & ATTR_UID)
+	    && !treequota_parent_uid_ok(inode, dentry->d_parent->d_inode,
+					attr->ia_uid)) {
+		if (dentry == dentry->d_parent)
+			attr->ia_tid = attr->ia_uid;
+		else
+			attr->ia_tid = treequota_tid(dentry->d_parent->d_inode,
+						     attr->ia_uid);
+		ia_valid |= ATTR_TID;
+		attr->ia_valid = ia_valid;
+	}
+
 	if (inode->i_op && inode->i_op->setattr) {
 		error = security_inode_setattr(dentry, attr);
 		if (!error)
@@ -164,6 +179,7 @@ int notify_change(struct dentry * dentry
 			error = security_inode_setattr(dentry, attr);
 		if (!error) {
 			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
+			    (ia_valid & ATTR_TID && attr->ia_tid != inode->i_tid) ||
 			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
 				error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
 			if (!error)

diff ./fs/dquot.c~current~ ./fs/dquot.c
--- ./fs/dquot.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/dquot.c	2005-12-07 11:29:26.000000000 +1100
@@ -784,6 +784,8 @@ static inline int need_print_warning(str
 			return current->fsuid == dquot->dq_id;
 		case GRPQUOTA:
 			return in_group_p(dquot->dq_id);
+		case TREEQUOTA:
+			return current->fsuid == dquot->dq_id;
 	}
 	return 0;
 }
@@ -955,6 +957,9 @@ int dquot_initialize(struct inode *inode
 				case GRPQUOTA:
 					id = inode->i_gid;
 					break;
+				case TREEQUOTA:
+					id = inode->i_tid;
+					break;
 			}
 			inode->i_dquot[cnt] = dqget(inode->i_sb, id, cnt);
 		}
@@ -1167,6 +1172,8 @@ int dquot_transfer(struct inode *inode, 
 	struct dquot *transfer_to[MAXQUOTAS];
 	int cnt, ret = NO_QUOTA, chuid = (iattr->ia_valid & ATTR_UID) && inode->i_uid != iattr->ia_uid,
 	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
+	int chtreeid = (iattr->ia_valid & ATTR_TID) && inode->i_tid != iattr->ia_tid;
+
 	char warntype[MAXQUOTAS];
 
 	/* First test before acquiring semaphore - solves deadlocks when we
@@ -1199,6 +1206,11 @@ int dquot_transfer(struct inode *inode, 
 					continue;
 				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_gid, cnt);
 				break;
+			case TREEQUOTA:
+				if (!chtreeid)
+					continue;
+				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_tid, cnt);
+				break;
 		}
 	}
 	spin_lock(&dq_data_lock);
@@ -1208,6 +1220,8 @@ int dquot_transfer(struct inode *inode, 
 		if (transfer_to[cnt] == NODQUOT)
 			continue;
 		transfer_from[cnt] = inode->i_dquot[cnt];
+		if (iattr->ia_valid & ATTR_FORCE)
+			continue;			/* don't check, just do */
 		if (check_idq(transfer_to[cnt], 1, warntype+cnt) == NO_QUOTA ||
 		    check_bdq(transfer_to[cnt], space, 0, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
@@ -1297,6 +1311,9 @@ static inline void set_enable_flags(stru
 		case GRPQUOTA:
 			dqopt->flags |= DQUOT_GRP_ENABLED;
 			break;
+		case TREEQUOTA:
+			dqopt->flags |= DQUOT_TREE_ENABLED;
+			break;
 	}
 }
 
@@ -1309,6 +1326,9 @@ static inline void reset_enable_flags(st
 		case GRPQUOTA:
 			dqopt->flags &= ~DQUOT_GRP_ENABLED;
 			break;
+		case TREEQUOTA:
+			dqopt->flags &= ~DQUOT_TREE_ENABLED;
+			break;
 	}
 }
 

diff ./fs/ext2/ialloc.c~current~ ./fs/ext2/ialloc.c
--- ./fs/ext2/ialloc.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext2/ialloc.c	2005-12-07 11:28:43.000000000 +1100
@@ -564,6 +564,7 @@ got:
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh2);
 	inode->i_uid = current->fsuid;
+	inode->i_tid = treequota_tid(dir, inode->i_uid);
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {

diff ./fs/ext2/inode.c~current~ ./fs/ext2/inode.c
--- ./fs/ext2/inode.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext2/inode.c	2005-12-07 11:28:43.000000000 +1100
@@ -1079,6 +1079,7 @@ void ext2_read_inode (struct inode * ino
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
+	inode->i_tid = (uid_t)le32_to_cpu(raw_inode->i_e2_tid);
 	if (!(test_opt (inode->i_sb, NO_UID32))) {
 		inode->i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		inode->i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
@@ -1216,6 +1217,7 @@ static int ext2_update_inode(struct inod
 		raw_inode->i_uid_high = 0;
 		raw_inode->i_gid_high = 0;
 	}
+	raw_inode->i_e2_tid = cpu_to_le32(inode->i_tid);
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(inode->i_size);
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
@@ -1302,6 +1304,7 @@ int ext2_setattr(struct dentry *dentry, 
 	if (error)
 		return error;
 	if ((iattr->ia_valid & ATTR_UID && iattr->ia_uid != inode->i_uid) ||
+	    (iattr->ia_valid & ATTR_TID && iattr->ia_tid != inode->i_tid) ||
 	    (iattr->ia_valid & ATTR_GID && iattr->ia_gid != inode->i_gid)) {
 		error = DQUOT_TRANSFER(inode, iattr) ? -EDQUOT : 0;
 		if (error)

diff ./fs/ext2/super.c~current~ ./fs/ext2/super.c
--- ./fs/ext2/super.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext2/super.c	2005-12-07 11:28:44.000000000 +1100
@@ -315,6 +315,7 @@ static match_table_t tokens = {
 	{Opt_xip, "xip"},
 	{Opt_grpquota, "grpquota"},
 	{Opt_ignore, "noquota"},
+	{Opt_ignore, "treequota"},
 	{Opt_quota, "quota"},
 	{Opt_usrquota, "usrquota"},
 	{Opt_err, NULL}

diff ./fs/ext3/ialloc.c~current~ ./fs/ext3/ialloc.c
--- ./fs/ext3/ialloc.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext3/ialloc.c	2005-12-07 11:28:43.000000000 +1100
@@ -545,6 +545,7 @@ got:
 	sb->s_dirt = 1;
 
 	inode->i_uid = current->fsuid;
+	inode->i_tid = treequota_tid(dir, inode->i_uid);
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {

diff ./fs/ext3/inode.c~current~ ./fs/ext3/inode.c
--- ./fs/ext3/inode.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext3/inode.c	2005-12-07 11:28:43.000000000 +1100
@@ -2446,6 +2446,7 @@ void ext3_read_inode(struct inode * inod
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
+	inode->i_tid = (uid_t)le32_to_cpu(raw_inode->i_e3_tid);
 	if(!(test_opt (inode->i_sb, NO_UID32))) {
 		inode->i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		inode->i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
@@ -2608,6 +2609,7 @@ static int ext3_do_update_inode(handle_t
 		raw_inode->i_uid_high = 0;
 		raw_inode->i_gid_high = 0;
 	}
+	raw_inode->i_e3_tid = cpu_to_le32(inode->i_tid);
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(ei->i_disksize);
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
@@ -2760,6 +2762,7 @@ int ext3_setattr(struct dentry *dentry, 
 		return error;
 
 	if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
+	    (ia_valid & ATTR_TID && attr->ia_tid != inode->i_tid) ||
 		(ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid)) {
 		handle_t *handle;
 
@@ -2782,6 +2785,8 @@ int ext3_setattr(struct dentry *dentry, 
 			inode->i_uid = attr->ia_uid;
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
+		if (attr->ia_valid & ATTR_TID)
+			inode->i_tid = attr->ia_tid;
 		error = ext3_mark_inode_dirty(handle, inode);
 		ext3_journal_stop(handle);
 	}

diff ./fs/ext3/super.c~current~ ./fs/ext3/super.c
--- ./fs/ext3/super.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/ext3/super.c	2005-12-07 15:32:13.000000000 +1100
@@ -533,19 +533,25 @@ static int ext3_show_options(struct seq_
 	if (sbi->s_qf_names[GRPQUOTA])
 		seq_printf(seq, ",grpjquota=%s", sbi->s_qf_names[GRPQUOTA]);
 
+	if (sbi->s_qf_names[TREEQUOTA])
+		seq_printf(seq, ",treejquota=%s", sbi->s_qf_names[TREEQUOTA]);
+
 	if (sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA)
 		seq_puts(seq, ",usrquota");
 
 	if (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)
 		seq_puts(seq, ",grpquota");
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_TREEQUOTA)
+		seq_puts(seq, ",treequota");
 #endif
 
 	return 0;
 }
 
 #ifdef CONFIG_QUOTA
-#define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
-#define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
+#define QTYPE2NAME(t) ((t)==USRQUOTA?"user":(t)==GRPQUOTA?"group":"tree")
+#define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):(t)==GRPQUOTA?((on)##GRPJQUOTA):((on)##TREEJQUOTA))
 
 static int ext3_dquot_initialize(struct inode *inode, int type);
 static int ext3_dquot_drop(struct inode *inode);
@@ -622,10 +628,11 @@ enum {
 	Opt_reservation, Opt_noreservation, Opt_noload, Opt_nobh,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
-	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
+	Opt_usrjquota, Opt_grpjquota, Opt_treejquota,
+	Opt_offusrjquota, Opt_offgrpjquota, Opt_offtreejquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_quota, Opt_noquota,
 	Opt_ignore, Opt_barrier, Opt_err, Opt_resize, Opt_usrquota,
-	Opt_grpquota
+	Opt_grpquota, Opt_treequota
 };
 
 static match_table_t tokens = {
@@ -667,10 +674,13 @@ static match_table_t tokens = {
 	{Opt_usrjquota, "usrjquota=%s"},
 	{Opt_offgrpjquota, "grpjquota="},
 	{Opt_grpjquota, "grpjquota=%s"},
+	{Opt_offtreejquota, "treejquota="},
+	{Opt_treejquota, "treejquota=%s"},
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_grpquota, "grpquota"},
 	{Opt_noquota, "noquota"},
+	{Opt_treequota, "treequota"},
 	{Opt_quota, "quota"},
 	{Opt_usrquota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
@@ -875,6 +885,9 @@ static int parse_options (char * options
 			}
 			break;
 #ifdef CONFIG_QUOTA
+		case Opt_treejquota:
+			qtype = TREEQUOTA;
+			goto set_qf_name;
 		case Opt_usrjquota:
 			qtype = USRQUOTA;
 			goto set_qf_name;
@@ -913,6 +926,9 @@ set_qf_name:
 			}
 			set_opt(sbi->s_mount_opt, QUOTA);
 			break;
+		case Opt_offtreejquota:
+			qtype = TREEQUOTA;
+			goto clear_qf_name;
 		case Opt_offusrjquota:
 			qtype = USRQUOTA;
 			goto clear_qf_name;
@@ -946,6 +962,10 @@ clear_qf_name:
 			set_opt(sbi->s_mount_opt, QUOTA);
 			set_opt(sbi->s_mount_opt, GRPQUOTA);
 			break;
+		case Opt_treequota:
+			set_opt(sbi->s_mount_opt, QUOTA);
+			set_opt(sbi->s_mount_opt, TREEQUOTA);
+			break;
 		case Opt_noquota:
 			if (sb_any_quota_enabled(sb)) {
 				printk(KERN_ERR "EXT3-fs: Cannot change quota "
@@ -960,10 +980,13 @@ clear_qf_name:
 		case Opt_quota:
 		case Opt_usrquota:
 		case Opt_grpquota:
+		case Opt_treequota:
 		case Opt_usrjquota:
 		case Opt_grpjquota:
+		case Opt_treejquota:
 		case Opt_offusrjquota:
 		case Opt_offgrpjquota:
+		case Opt_offtreejquota:
 		case Opt_jqfmt_vfsold:
 		case Opt_jqfmt_vfsv0:
 			printk(KERN_ERR
@@ -1007,7 +1030,8 @@ clear_qf_name:
 		}
 	}
 #ifdef CONFIG_QUOTA
-	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
+	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA] ||
+	    sbi->s_qf_names[TREEQUOTA]) {
 		if ((sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA) &&
 		     sbi->s_qf_names[USRQUOTA])
 			clear_opt(sbi->s_mount_opt, USRQUOTA);
@@ -1016,6 +1040,11 @@ clear_qf_name:
 		     sbi->s_qf_names[GRPQUOTA])
 			clear_opt(sbi->s_mount_opt, GRPQUOTA);
 
+		if ((sbi->s_mount_opt & EXT3_MOUNT_TREEQUOTA) &&
+		     sbi->s_qf_names[TREEQUOTA])
+			clear_opt(sbi->s_mount_opt, TREEQUOTA);
+
+/* FIXME */
 		if ((sbi->s_qf_names[USRQUOTA] &&
 				(sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)) ||
 		    (sbi->s_qf_names[GRPQUOTA] &&
@@ -2453,7 +2482,8 @@ static int ext3_mark_dquot_dirty(struct 
 {
 	/* Are we journalling quotas? */
 	if (EXT3_SB(dquot->dq_sb)->s_qf_names[USRQUOTA] ||
-	    EXT3_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA]) {
+	    EXT3_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA] ||
+	    EXT3_SB(dquot->dq_sb)->s_qf_names[TREEQUOTA]) {
 		dquot_mark_dquot_dirty(dquot);
 		return ext3_write_dquot(dquot);
 	} else {
@@ -2500,7 +2530,8 @@ static int ext3_quota_on(struct super_bl
 		return -EINVAL;
 	/* Not journalling quota? */
 	if (!EXT3_SB(sb)->s_qf_names[USRQUOTA] &&
-	    !EXT3_SB(sb)->s_qf_names[GRPQUOTA])
+	    !EXT3_SB(sb)->s_qf_names[GRPQUOTA] &&
+	    !EXT3_SB(sb)->s_qf_names[TREEQUOTA])
 		return vfs_quota_on(sb, type, format_id, path);
 	err = path_lookup(path, LOOKUP_FOLLOW, &nd);
 	if (err)

diff ./fs/namei.c~current~ ./fs/namei.c
--- ./fs/namei.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/namei.c	2005-12-07 11:30:13.000000000 +1100
@@ -808,6 +808,8 @@ static fastcall int __link_path_walk(con
 		if (err)
 			break;
 
+		treequota_check(next.dentry);
+
 		err = -ENOENT;
 		inode = next.dentry->d_inode;
 		if (!inode)
@@ -861,6 +863,9 @@ last_component:
 		err = do_lookup(nd, &this, &next);
 		if (err)
 			break;
+
+		treequota_check(next.dentry);
+
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
@@ -1092,6 +1097,7 @@ static struct dentry * __lookup_hash(str
 		else
 			dput(new);
 	}
+	treequota_check(dentry);
 out:
 	return dentry;
 }
@@ -1994,6 +2000,8 @@ int vfs_link(struct dentry *old_dentry, 
 	if (dir->i_sb != inode->i_sb)
 		return -EXDEV;
 
+	if (!treequota_parent_ok(inode, dir))
+		return -EXDEV;
 	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
@@ -2100,6 +2108,7 @@ static int vfs_rename_dir(struct inode *
 {
 	int error = 0;
 	struct inode *target;
+	struct iattr attr;
 
 	/*
 	 * If we are going to change the parent - check write permissions,
@@ -2111,6 +2120,11 @@ static int vfs_rename_dir(struct inode *
 			return error;
 	}
 
+	if (!treequota_parent_ok(old_dentry->d_inode, new_dir)
+	    && !capable(CAP_CHOWN))
+		return -EXDEV;
+
+
 	error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
@@ -2120,8 +2134,14 @@ static int vfs_rename_dir(struct inode *
 		down(&target->i_sem);
 		dentry_unhash(new_dentry);
 	}
+	attr.ia_valid = ATTR_TID;
+	attr.ia_tid = treequota_tid(new_dir, old_dentry->d_inode->i_uid);
+
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
+	else if (!treequota_parent_ok(old_dentry->d_inode, new_dir)
+		 && (error = notify_change(old_dentry, &attr)))
+		;
 	else 
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (target) {
@@ -2153,8 +2173,20 @@ static int vfs_rename_other(struct inode
 		down(&target->i_sem);
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
-	else
-		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	else {
+		error = 0;
+		if (!treequota_parent_ok(old_dentry->d_inode, new_dir)) {
+			struct iattr attr;
+			if (old_dentry->d_inode->i_nlink > 1)
+				return -EXDEV;
+			attr.ia_valid = ATTR_TID;
+			attr.ia_tid = treequota_tid(new_dir,
+					    old_dentry->d_inode->i_uid);
+			error = notify_change(old_dentry, &attr);
+		}
+		if (!error)
+			error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	}
 	if (!error) {
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))

diff ./fs/quota_v1.c~current~ ./fs/quota_v1.c
--- ./fs/quota_v1.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/quota_v1.c	2005-12-07 11:28:43.000000000 +1100
@@ -91,7 +91,8 @@ out:
 /* Magics of new quota format */
 #define V2_INITQMAGICS {\
 	0xd9c01f11,     /* USRQUOTA */\
-	0xd9c01927      /* GRPQUOTA */\
+	0xd9c01927,     /* GRPQUOTA */\
+	0xd9c01987      /* TREEQUOTA - a lie */\
 }
 
 /* Header of new quota format */

diff ./fs/stat.c~current~ ./fs/stat.c
--- ./fs/stat.c~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./fs/stat.c	2005-12-07 11:28:43.000000000 +1100
@@ -28,6 +28,7 @@ void generic_fillattr(struct inode *inod
 	stat->uid = inode->i_uid;
 	stat->gid = inode->i_gid;
 	stat->rdev = inode->i_rdev;
+	stat->tid = inode->i_tid;
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
 	stat->ctime = inode->i_ctime;

diff ./include/linux/ext2_fs.h~current~ ./include/linux/ext2_fs.h
--- ./include/linux/ext2_fs.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/ext2_fs.h	2005-12-07 11:28:43.000000000 +1100
@@ -243,7 +243,7 @@ struct ext2_inode {
 			__u16	i_pad1;
 			__le16	l_i_uid_high;	/* these 2 fields    */
 			__le16	l_i_gid_high;	/* were reserved2[0] */
-			__u32	l_i_reserved2;
+			__u32	l_i_tid;	/* tree-id for quotas, no longer l_i_reserved2 */
 		} linux2;
 		struct {
 			__u8	h_i_frag;	/* Fragment number */
@@ -272,7 +272,7 @@ struct ext2_inode {
 #define i_gid_low	i_gid
 #define i_uid_high	osd2.linux2.l_i_uid_high
 #define i_gid_high	osd2.linux2.l_i_gid_high
-#define i_reserved2	osd2.linux2.l_i_reserved2
+#define i_e2_tid	osd2.linux2.l_i_tid
 #endif
 
 #ifdef	__hurd__

diff ./include/linux/ext3_fs.h~current~ ./include/linux/ext3_fs.h
--- ./include/linux/ext3_fs.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/ext3_fs.h	2005-12-07 15:51:58.000000000 +1100
@@ -322,6 +322,7 @@ struct ext3_inode {
 #define i_uid_high	osd2.linux2.l_i_uid_high
 #define i_gid_high	osd2.linux2.l_i_gid_high
 #define i_reserved2	osd2.linux2.l_i_reserved2
+#define	i_e3_tid	i_reserved2
 
 #elif defined(__GNU__)
 
@@ -375,6 +376,7 @@ struct ext3_inode {
 #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
 #define EXT3_MOUNT_USRQUOTA		0x100000 /* "old" user quota */
 #define EXT3_MOUNT_GRPQUOTA		0x200000 /* "old" group quota */
+#define EXT3_MOUNT_TREEQUOTA		0x400000 /* "old" tree quota */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/fs.h	2005-12-07 11:55:46.000000000 +1100
@@ -264,6 +264,7 @@ typedef void (dio_iodone_t)(struct kiocb
 #define ATTR_ATTR_FLAG	1024
 #define ATTR_KILL_SUID	2048
 #define ATTR_KILL_SGID	4096
+#define ATTR_TID	8192
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -283,6 +284,7 @@ struct iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
+	uid_t		ia_tid;
 };
 
 /*
@@ -430,6 +432,7 @@ struct inode {
 	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
+	uid_t			i_tid;	/* tree-id for quotas */
 	dev_t			i_rdev;
 	loff_t			i_size;
 	struct timespec		i_atime;

diff ./include/linux/quota.h~current~ ./include/linux/quota.h
--- ./include/linux/quota.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/quota.h	2005-12-07 11:28:43.000000000 +1100
@@ -56,9 +56,10 @@ extern spinlock_t dq_data_lock;
 #define kb2qb(x) ((x) >> (QUOTABLOCK_BITS-10))
 #define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
 
-#define MAXQUOTAS 2
+#define MAXQUOTAS 3
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */
+#define TREEQUOTA 2		/* element used for tree quotas */
 
 /*
  * Definitions for the default names of the quotas files.
@@ -66,6 +67,7 @@ extern spinlock_t dq_data_lock;
 #define INITQFNAMES { \
 	"user",    /* USRQUOTA */ \
 	"group",   /* GRPQUOTA */ \
+	"tree",    /* TREEQUOTA */ \
 	"undefined", \
 };
 
@@ -282,6 +284,7 @@ struct quota_format_type {
 
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
 #define DQUOT_GRP_ENABLED	0x02		/* Group diskquotas enabled */
+#define DQUOT_TREE_ENABLED	0x04		/* Tree diskquotas enabled */
 
 struct quota_info {
 	unsigned int flags;			/* Flags for diskquotas on this device */
@@ -299,11 +302,16 @@ int mark_dquot_dirty(struct dquot *dquot
 
 #define dquot_dirty(dquot) test_bit(DQ_MOD_B, &(dquot)->dq_flags)
 
-#define sb_has_quota_enabled(sb, type) ((type)==USRQUOTA ? \
-	(sb_dqopt(sb)->flags & DQUOT_USR_ENABLED) : (sb_dqopt(sb)->flags & DQUOT_GRP_ENABLED))
+#define sb_has_quota_enabled(sb, type)	\
+	((type)==USRQUOTA ? \
+	   (sb_dqopt(sb)->flags & DQUOT_USR_ENABLED) : \
+	     ((type)==GRPQUOTA ? \
+		(sb_dqopt(sb)->flags & DQUOT_GRP_ENABLED) : \
+	      (sb_dqopt(sb)->flags & DQUOT_TREE_ENABLED)))
 
 #define sb_any_quota_enabled(sb) (sb_has_quota_enabled(sb, USRQUOTA) | \
-				  sb_has_quota_enabled(sb, GRPQUOTA))
+				  sb_has_quota_enabled(sb, GRPQUOTA) | \
+				  sb_has_quota_enabled(sb, TREEQUOTA))
 
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);

diff ./include/linux/quotaops.h~current~ ./include/linux/quotaops.h
--- ./include/linux/quotaops.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/quotaops.h	2005-12-07 11:31:27.000000000 +1100
@@ -183,6 +183,59 @@ static __inline__ int DQUOT_OFF(struct s
 	return ret;
 }
 
+
+static __inline__ int treequota_parent_uid_ok(const struct inode *inode, const struct inode *dir, const uid_t uid)
+{
+	if ( !(inode->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED))
+		return 1;
+	if ((dir->i_tid && dir != inode)
+	    ? (inode->i_tid ==   dir->i_tid)
+	    : (inode->i_tid ==   uid))
+		return 1;
+	return 0;
+}
+
+static __inline__ int treequota_parent_ok(const struct inode *inode, const struct inode *dir)
+{
+	return treequota_parent_uid_ok(inode,dir, inode->i_uid);
+}
+
+static __inline__ int treequota_tid(const struct inode *dir, const uid_t uid)
+{
+	if (!(dir->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED))
+		return 0;
+	return dir->i_tid
+		? dir->i_tid
+		: uid;
+}
+
+static __inline__ void treequota_check(struct dentry *dentry)
+{
+	struct inode *inode;
+	struct iattr attr;
+
+	if (!dentry || IS_ERR(dentry))
+		return;
+	inode = dentry->d_inode;
+	if (!inode || ! (inode->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED))
+		return;
+	if (treequota_parent_ok(inode, dentry->d_parent->d_inode))
+		return;
+
+	attr.ia_valid = ATTR_FORCE | ATTR_TID;
+	attr.ia_tid = treequota_tid(dentry->d_parent->d_inode,
+				    inode->i_uid);
+	if (!S_ISDIR(inode->i_mode)
+	    && inode->i_nlink > 1) {
+		printk(KERN_WARNING "treequota: file with multiple links has wrong tree-id\n");
+		printk(KERN_WARNING "  dev=%x ino=%ld dino=%ld\n",
+		       inode->i_sb->s_dev, inode->i_ino,
+		       dentry->d_parent->d_inode->i_ino);
+		printk(KERN_WARNING "  basename=%s\n", dentry->d_name.name);
+	}
+	notify_change(dentry, &attr);
+}
+
 #else
 
 /*
@@ -235,6 +288,11 @@ extern __inline__ void DQUOT_FREE_SPACE(
 	mark_inode_dirty(inode);
 }	
 
+#define treequota_parent_uid_ok(inode,dir,uid) (1)
+#define treequota_parent_ok(inode,dir) (1)
+#define treequota_tid(inode,uid) (0)
+#define treequota_check(dentry) ((void)(0))
+
 #endif /* CONFIG_QUOTA */
 
 #define DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr)	DQUOT_PREALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)

diff ./include/linux/stat.h~current~ ./include/linux/stat.h
--- ./include/linux/stat.h~current~	2005-12-07 15:51:56.000000000 +1100
+++ ./include/linux/stat.h	2005-12-07 11:28:43.000000000 +1100
@@ -63,6 +63,7 @@ struct kstat {
 	unsigned int	nlink;
 	uid_t		uid;
 	gid_t		gid;
+	uid_t		tid;
 	dev_t		rdev;
 	loff_t		size;
 	struct timespec  atime;
