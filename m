Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSH3XKq>; Fri, 30 Aug 2002 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSH3XKq>; Fri, 30 Aug 2002 19:10:46 -0400
Received: from mons.uio.no ([129.240.130.14]:42126 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S313113AbSH3XKQ>;
	Fri, 30 Aug 2002 19:10:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15727.64599.363148.533120@charged.uio.no>
Date: Sat, 31 Aug 2002 01:14:31 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Introduce BSD-style user credential [1/3]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert references to current->fsuid, current->fsgid, current->ngroups into

  current_fsuid()
  current_fsgid()
  current_ngroups()
  current_setfsuid(uid)
  current_setfsgid(gid)

in order to simplify transition to user credentials.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.32/arch/s390x/kernel/linux32.c linux-2.5.32-cred1/arch/s390x/kernel/linux32.c
--- linux-2.5.32/arch/s390x/kernel/linux32.c	Tue Jul 30 00:08:09 2002
+++ linux-2.5.32-cred1/arch/s390x/kernel/linux32.c	Wed Aug 28 23:44:39 2002
@@ -194,7 +194,7 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = current_ngroups();
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
diff -u --recursive --new-file linux-2.5.32/arch/sparc64/kernel/sys_sparc32.c linux-2.5.32-cred1/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.32/arch/sparc64/kernel/sys_sparc32.c	Sat Aug 24 12:59:14 2002
+++ linux-2.5.32-cred1/arch/sparc64/kernel/sys_sparc32.c	Wed Aug 28 23:44:39 2002
@@ -211,7 +211,7 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = current_ngroups();
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
diff -u --recursive --new-file linux-2.5.32/drivers/hotplug/pci_hotplug_core.c linux-2.5.32-cred1/drivers/hotplug/pci_hotplug_core.c
--- linux-2.5.32/drivers/hotplug/pci_hotplug_core.c	Tue Jul 23 02:24:20 2002
+++ linux-2.5.32-cred1/drivers/hotplug/pci_hotplug_core.c	Wed Aug 28 23:44:39 2002
@@ -93,8 +93,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/drivers/isdn/capi/capifs.c linux-2.5.32-cred1/drivers/isdn/capi/capifs.c
--- linux-2.5.32/drivers/isdn/capi/capifs.c	Fri Aug 16 00:01:13 2002
+++ linux-2.5.32-cred1/drivers/isdn/capi/capifs.c	Wed Aug 28 23:44:39 2002
@@ -401,8 +401,8 @@
 
 		if ((np->inode = capifs_new_inode(sb)) != NULL) {
 			struct inode *inode = np->inode;
-			inode->i_uid = sbi->setuid ? sbi->uid : current->fsuid;
-			inode->i_gid = sbi->setgid ? sbi->gid : current->fsgid;
+			inode->i_uid = sbi->setuid ? sbi->uid : current_fsuid();
+			inode->i_gid = sbi->setgid ? sbi->gid : current_fsgid();
 			inode->i_nlink = 1;
 			inode->i_ino = ino + 2;
 			init_special_inode(inode, sbi->mode|S_IFCHR, kdev_t_to_nr(np->kdev));
diff -u --recursive --new-file linux-2.5.32/drivers/usb/core/inode.c linux-2.5.32-cred1/drivers/usb/core/inode.c
--- linux-2.5.32/drivers/usb/core/inode.c	Fri Aug  2 19:55:22 2002
+++ linux-2.5.32-cred1/drivers/usb/core/inode.c	Wed Aug 28 23:44:40 2002
@@ -148,8 +148,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/affs/inode.c linux-2.5.32-cred1/fs/affs/inode.c
--- linux-2.5.32/fs/affs/inode.c	Thu May 23 15:18:41 2002
+++ linux-2.5.32-cred1/fs/affs/inode.c	Wed Aug 28 23:44:40 2002
@@ -325,8 +325,8 @@
 	mark_buffer_dirty_inode(bh, inode);
 	affs_brelse(bh);
 
-	inode->i_uid     = current->fsuid;
-	inode->i_gid     = current->fsgid;
+	inode->i_uid     = current_fsuid();
+	inode->i_gid     = current_fsgid();
 	inode->i_ino     = block;
 	inode->i_nlink   = 1;
 	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME;
diff -u --recursive --new-file linux-2.5.32/fs/attr.c linux-2.5.32-cred1/fs/attr.c
--- linux-2.5.32/fs/attr.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-cred1/fs/attr.c	Wed Aug 28 23:44:40 2002
@@ -30,7 +30,7 @@
 
 	/* Make sure a caller can chown. */
 	if ((ia_valid & ATTR_UID) &&
-	    (current->fsuid != inode->i_uid ||
+	    (current_fsuid() != inode->i_uid ||
 	     attr->ia_uid != inode->i_uid) && !capable(CAP_CHOWN))
 		goto error;
 
@@ -42,7 +42,7 @@
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current_fsuid() != inode->i_uid) && !capable(CAP_FOWNER))
 			goto error;
 		/* Also check the setgid bit! */
 		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
@@ -52,7 +52,7 @@
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET)) {
-		if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER))
+		if (current_fsuid() != inode->i_uid && !capable(CAP_FOWNER))
 			goto error;
 	}
 fine:
diff -u --recursive --new-file linux-2.5.32/fs/bfs/dir.c linux-2.5.32-cred1/fs/bfs/dir.c
--- linux-2.5.32/fs/bfs/dir.c	Thu May 23 15:24:30 2002
+++ linux-2.5.32-cred1/fs/bfs/dir.c	Wed Aug 28 23:44:40 2002
@@ -98,8 +98,8 @@
 	}
 	set_bit(ino, info->si_imap);	
 	info->si_freei--;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	inode->i_uid = current_fsuid();
+	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
 	inode->i_op = &bfs_file_inops;
diff -u --recursive --new-file linux-2.5.32/fs/coda/coda_linux.c linux-2.5.32-cred1/fs/coda/coda_linux.c
--- linux-2.5.32/fs/coda/coda_linux.c	Mon May 20 15:34:54 2002
+++ linux-2.5.32-cred1/fs/coda/coda_linux.c	Wed Aug 28 23:44:40 2002
@@ -66,17 +66,17 @@
         cred->cr_uid = (vuid_t) current->uid;
         cred->cr_euid = (vuid_t) current->euid;
         cred->cr_suid = (vuid_t) current->suid;
-        cred->cr_fsuid = (vuid_t) current->fsuid;
+        cred->cr_fsuid = (vuid_t) current_fsuid();
 
         cred->cr_groupid = (vgid_t) current->gid;
         cred->cr_egid = (vgid_t) current->egid;
         cred->cr_sgid = (vgid_t) current->sgid;
-        cred->cr_fsgid = (vgid_t) current->fsgid;
+        cred->cr_fsgid = (vgid_t) current_fsgid();
 }
 
 int coda_cred_ok(struct coda_cred *cred)
 {
-	return(current->fsuid == cred->cr_fsuid);
+	return(current_fsuid() == cred->cr_fsuid);
 }
 
 int coda_cred_eq(struct coda_cred *cred1, struct coda_cred *cred2)
diff -u --recursive --new-file linux-2.5.32/fs/devpts/inode.c linux-2.5.32-cred1/fs/devpts/inode.c
--- linux-2.5.32/fs/devpts/inode.c	Fri Jul  5 02:02:21 2002
+++ linux-2.5.32-cred1/fs/devpts/inode.c	Wed Aug 28 23:44:40 2002
@@ -137,8 +137,8 @@
 		return;
 	inode->i_ino = number+2;
 	inode->i_blksize = 1024;
-	inode->i_uid = config.setuid ? config.uid : current->fsuid;
-	inode->i_gid = config.setgid ? config.gid : current->fsgid;
+	inode->i_uid = config.setuid ? config.uid : current_fsuid();
+	inode->i_gid = config.setgid ? config.gid : current_fsgid();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
 
diff -u --recursive --new-file linux-2.5.32/fs/dquot.c linux-2.5.32-cred1/fs/dquot.c
--- linux-2.5.32/fs/dquot.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-cred1/fs/dquot.c	Wed Aug 28 23:44:40 2002
@@ -785,7 +785,7 @@
 {
 	switch (dquot->dq_type) {
 		case USRQUOTA:
-			return current->fsuid == dquot->dq_id && !(dquot->dq_flags & flag);
+			return current_fsuid() == dquot->dq_id && !(dquot->dq_flags & flag);
 		case GRPQUOTA:
 			return in_group_p(dquot->dq_id) && !(dquot->dq_flags & flag);
 	}
diff -u --recursive --new-file linux-2.5.32/fs/driverfs/inode.c linux-2.5.32-cred1/fs/driverfs/inode.c
--- linux-2.5.32/fs/driverfs/inode.c	Mon Aug  5 20:13:07 2002
+++ linux-2.5.32-cred1/fs/driverfs/inode.c	Wed Aug 28 23:44:40 2002
@@ -98,8 +98,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/exec.c linux-2.5.32-cred1/fs/exec.c
--- linux-2.5.32/fs/exec.c	Wed Aug 14 15:46:59 2002
+++ linux-2.5.32-cred1/fs/exec.c	Thu Aug 29 00:28:51 2002
@@ -770,8 +770,10 @@
 		do_unlock = 1;
 	}
 
-        current->suid = current->euid = current->fsuid = bprm->e_uid;
-        current->sgid = current->egid = current->fsgid = bprm->e_gid;
+        current->suid = current->euid = bprm->e_uid;
+	current_setfsuid(bprm->e_uid);
+        current->sgid = current->egid = bprm->e_gid;
+	current_setfsgid(bprm->e_gid);
 
 	if(do_unlock)
 		unlock_kernel();
diff -u --recursive --new-file linux-2.5.32/fs/ext2/balloc.c linux-2.5.32-cred1/fs/ext2/balloc.c
--- linux-2.5.32/fs/ext2/balloc.c	Thu Jul  4 18:17:10 2002
+++ linux-2.5.32-cred1/fs/ext2/balloc.c	Wed Aug 28 23:44:40 2002
@@ -105,7 +105,7 @@
 		count = free_blocks;
 
 	if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
-	    sbi->s_resuid != current->fsuid &&
+	    sbi->s_resuid != current_fsuid() &&
 	    (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
 		/*
 		 * We are too close to reserve and we are not privileged.
diff -u --recursive --new-file linux-2.5.32/fs/ext2/ialloc.c linux-2.5.32-cred1/fs/ext2/ialloc.c
--- linux-2.5.32/fs/ext2/ialloc.c	Thu Jul  4 18:17:10 2002
+++ linux-2.5.32-cred1/fs/ext2/ialloc.c	Wed Aug 28 23:44:40 2002
@@ -344,7 +344,7 @@
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {
@@ -352,7 +352,7 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 	inode->i_mode = mode;
 
 	inode->i_ino = ino;
diff -u --recursive --new-file linux-2.5.32/fs/ext2/ioctl.c linux-2.5.32-cred1/fs/ext2/ioctl.c
--- linux-2.5.32/fs/ext2/ioctl.c	Fri Jun 21 07:33:18 2002
+++ linux-2.5.32-cred1/fs/ext2/ioctl.c	Wed Aug 28 23:44:40 2002
@@ -30,7 +30,7 @@
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current_fsuid() != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EACCES;
 
 		if (get_user(flags, (int *) arg))
@@ -79,7 +79,7 @@
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int *) arg);
 	case EXT2_IOC_SETVERSION:
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current_fsuid() != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
 		if (IS_RDONLY(inode))
 			return -EROFS;
diff -u --recursive --new-file linux-2.5.32/fs/ext3/balloc.c linux-2.5.32-cred1/fs/ext3/balloc.c
--- linux-2.5.32/fs/ext3/balloc.c	Thu Jul  4 18:17:11 2002
+++ linux-2.5.32-cred1/fs/ext3/balloc.c	Wed Aug 28 23:44:40 2002
@@ -411,7 +411,7 @@
 	es = sb->u.ext3_sb.s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
-	    ((sb->u.ext3_sb.s_resuid != current->fsuid) &&
+	    ((sb->u.ext3_sb.s_resuid != current_fsuid()) &&
 	     (sb->u.ext3_sb.s_resgid == 0 ||
 	      !in_group_p(sb->u.ext3_sb.s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
diff -u --recursive --new-file linux-2.5.32/fs/ext3/ialloc.c linux-2.5.32-cred1/fs/ext3/ialloc.c
--- linux-2.5.32/fs/ext3/ialloc.c	Thu Jul  4 18:17:11 2002
+++ linux-2.5.32-cred1/fs/ext3/ialloc.c	Wed Aug 28 23:44:40 2002
@@ -367,7 +367,7 @@
 	sb->s_dirt = 1;
 	if (err) goto fail;
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {
@@ -375,7 +375,7 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 	inode->i_mode = mode;
 
 	inode->i_ino = j;
diff -u --recursive --new-file linux-2.5.32/fs/ext3/ioctl.c linux-2.5.32-cred1/fs/ext3/ioctl.c
--- linux-2.5.32/fs/ext3/ioctl.c	Fri Jun 21 07:33:18 2002
+++ linux-2.5.32-cred1/fs/ext3/ioctl.c	Wed Aug 28 23:44:40 2002
@@ -37,7 +37,7 @@
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current_fsuid() != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EACCES;
 
 		if (get_user(flags, (int *) arg))
@@ -123,7 +123,7 @@
 		__u32 generation;
 		int err;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current_fsuid() != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
 		if (IS_RDONLY(inode))
 			return -EROFS;
diff -u --recursive --new-file linux-2.5.32/fs/file_table.c linux-2.5.32-cred1/fs/file_table.c
--- linux-2.5.32/fs/file_table.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-cred1/fs/file_table.c	Wed Aug 28 23:44:40 2002
@@ -52,8 +52,8 @@
 		}
 		atomic_set(&f->f_count,1);
 		f->f_version = ++event;
-		f->f_uid = current->fsuid;
-		f->f_gid = current->fsgid;
+		f->f_uid = current_fsuid();
+		f->f_gid = current_fsgid();
 		list_add(&f->f_list, &anon_list);
 		file_list_unlock();
 		return f;
@@ -96,8 +96,8 @@
 	filp->f_mode   = mode;
 	atomic_set(&filp->f_count, 1);
 	filp->f_dentry = dentry;
-	filp->f_uid    = current->fsuid;
-	filp->f_gid    = current->fsgid;
+	filp->f_uid    = current_fsuid();
+	filp->f_gid    = current_fsgid();
 	filp->f_op     = dentry->d_inode->i_fop;
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
diff -u --recursive --new-file linux-2.5.32/fs/hpfs/namei.c linux-2.5.32-cred1/fs/hpfs/namei.c
--- linux-2.5.32/fs/hpfs/namei.c	Thu May 23 15:18:50 2002
+++ linux-2.5.32-cred1/fs/hpfs/namei.c	Wed Aug 28 23:44:40 2002
@@ -77,11 +77,11 @@
 		result->i_ctime = result->i_mtime = result->i_atime = local_to_gmt(dir->i_sb, dee.creation_date);
 		hpfs_i(result)->i_ea_size = 0;
 		if (dee.read_only) result->i_mode &= ~0222;
-		if (result->i_uid != current->fsuid ||
-		    result->i_gid != current->fsgid ||
+		if (result->i_uid != current_fsuid() ||
+		    result->i_gid != current_fsgid() ||
 		    result->i_mode != (mode | S_IFDIR)) {
-			result->i_uid = current->fsuid;
-			result->i_gid = current->fsgid;
+			result->i_uid = current_fsuid();
+			result->i_gid = current_fsgid();
 			result->i_mode = mode | S_IFDIR;
 			hpfs_write_inode_nolock(result);
 		}
@@ -152,11 +152,11 @@
 			result->i_data.a_ops = &hpfs_aops;
 			hpfs_i(result)->mmu_private = 0;
 		}
-		if (result->i_uid != current->fsuid ||
-		    result->i_gid != current->fsgid ||
+		if (result->i_uid != current_fsuid() ||
+		    result->i_gid != current_fsgid() ||
 		    result->i_mode != (mode | S_IFREG)) {
-			result->i_uid = current->fsuid;
-			result->i_gid = current->fsgid;
+			result->i_uid = current_fsuid();
+			result->i_gid = current_fsgid();
 			result->i_mode = mode | S_IFREG;
 			hpfs_write_inode_nolock(result);
 		}
@@ -217,8 +217,8 @@
 		hpfs_i(result)->i_ea_size = 0;
 		/*if (result->i_blocks == -1) result->i_blocks = 1;
 		if (result->i_size == -1) result->i_size = 0;*/
-		result->i_uid = current->fsuid;
-		result->i_gid = current->fsgid;
+		result->i_uid = current_fsuid();
+		result->i_gid = current_fsgid();
 		result->i_nlink = 1;
 		result->i_size = 0;
 		result->i_blocks = 1;
@@ -288,8 +288,8 @@
 		/*if (result->i_blocks == -1) result->i_blocks = 1;
 		if (result->i_size == -1) result->i_size = 0;*/
 		result->i_mode = S_IFLNK | 0777;
-		result->i_uid = current->fsuid;
-		result->i_gid = current->fsgid;
+		result->i_uid = current_fsuid();
+		result->i_gid = current_fsgid();
 		result->i_blocks = 1;
 		result->i_size = strlen(symlink);
 		result->i_op = &page_symlink_inode_operations;
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/file.c linux-2.5.32-cred1/fs/intermezzo/file.c
--- linux-2.5.32/fs/intermezzo/file.c	Mon May 20 15:36:08 2002
+++ linux-2.5.32-cred1/fs/intermezzo/file.c	Wed Aug 28 23:44:41 2002
@@ -147,11 +147,11 @@
                 /* we believe that on open the kernel lock
                    assures that only one process will do this allocation */ 
                 fdata->fd_do_lml = 0;
-                fdata->fd_fsuid = current->fsuid;
-                fdata->fd_fsgid = current->fsgid;
+                fdata->fd_fsuid = current_fsuid();
+                fdata->fd_fsgid = current_fsgid();
                 fdata->fd_mode = file->f_dentry->d_inode->i_mode;
-                fdata->fd_ngroups = current->ngroups;
-                for (i=0 ; i<current->ngroups ; i++)
+                fdata->fd_ngroups = current_ngroups();
+                for (i=0 ; i<current_ngroups() ; i++)
                         fdata->fd_groups[i] = current->groups[i]; 
                 fdata->fd_bytes_written = 0; /*when open,written data is zero*/ 
                 file->private_data = fdata; 
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/journal.c linux-2.5.32-cred1/fs/intermezzo/journal.c
--- linux-2.5.32/fs/intermezzo/journal.c	Mon May 20 15:36:12 2002
+++ linux-2.5.32-cred1/fs/intermezzo/journal.c	Wed Aug 28 23:44:41 2002
@@ -258,14 +258,14 @@
 	int i; 
 
 	/* convert 16 bit gid's to 32 bit gid's */
-	for (i=0; i<current->ngroups; i++) 
+	for (i=0; i<current_ngroups(); i++) 
 		groups[i] = (__u32) current->groups[i];
 	
         return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
-                                                      (__u32)current->ngroups,
+                                                      (__u32)current_ngroups(),
 						      groups,
-                                                      (__u32)current->fsuid,
-                                                      (__u32)current->fsgid);
+                                                      (__u32)current_fsuid(),
+                                                      (__u32)current_fsgid());
 }
 
 static inline char *
@@ -274,8 +274,8 @@
 {
         return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
                                                       ngroups, groups,
-                                                      (__u32)current->fsuid,
-                                                      (__u32)current->fsgid);
+                                                      (__u32)current_fsuid(),
+                                                      (__u32)current_fsgid());
 }
 
 static inline char *log_version(char *buf, struct dentry *dentry)
@@ -897,7 +897,7 @@
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
         ino = cpu_to_le64(dentry->d_inode->i_ino);
         generation = cpu_to_le32(dentry->d_inode->i_generation);
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + sizeof(*new_file_ver) +
                 sizeof(ino) + sizeof(generation) + sizeof(pathlen) +
                 sizeof(remote_ino) + sizeof(remote_generation) + 
@@ -1139,7 +1139,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + sizeof(*old_ver) +
                 sizeof(valid) + sizeof(mode) + sizeof(uid) + sizeof(gid) +
                 sizeof(fsize) + sizeof(mtime) + sizeof(ctime) + sizeof(flags) +
@@ -1220,7 +1220,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1282,7 +1282,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(targetlen) + sizeof(struct journal_suffix);
@@ -1345,7 +1345,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size = sizeof(__u32) * current->ngroups + 
+        size = sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1405,7 +1405,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(struct journal_suffix);
 
@@ -1472,7 +1472,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size = sizeof(__u32) * current->ngroups + 
+        size = sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(lmajor) +
                 sizeof(lminor) + sizeof(pathlen) +
@@ -1537,7 +1537,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path = presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1600,7 +1600,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path = presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 4 * sizeof(*src_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1661,7 +1661,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(struct journal_suffix);
 
@@ -1741,14 +1741,14 @@
                 open_fsuid = fd->fd_fsuid;
                 open_fsgid = fd->fd_fsgid;
         } else {
-                open_ngroups = current->ngroups;
-                for (i=0; i<current->ngroups; i++)
+                open_ngroups = current_ngroups();
+                for (i=0; i<current_ngroups(); i++)
 			open_groups[i] =  (__u32) current->groups[i]; 
                 open_mode = dentry->d_inode->i_mode;
                 open_uid = dentry->d_inode->i_uid;
                 open_gid = dentry->d_inode->i_gid;
-                open_fsuid = current->fsuid;
-                open_fsgid = current->fsgid;
+                open_fsuid = current_fsuid();
+                open_fsgid = current_fsgid();
         }
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
@@ -2011,7 +2011,7 @@
          */
         mode=cpu_to_le32(dentry->d_inode->i_mode);
 
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current_ngroups() + 
                 sizeof(struct journal_prefix) + 
                 2 * sizeof(struct presto_version) +
                 sizeof(flags) + sizeof(mode) + sizeof(namelen) + 
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/kml_reint.c linux-2.5.32-cred1/fs/intermezzo/kml_reint.c
--- linux-2.5.32/fs/intermezzo/kml_reint.c	Sat Mar  2 05:19:20 2002
+++ linux-2.5.32-cred1/fs/intermezzo/kml_reint.c	Wed Aug 28 23:44:41 2002
@@ -27,18 +27,18 @@
 
 static void kmlreint_pre_secure (struct kml_rec *rec)
 {
-        if (current->fsuid != current->uid)
+        if (current_fsuid() != current->uid)
                 CDEBUG (D_KML, "reint_kmlreint_pre_secure: cannot setfsuid\n");
-        if (current->fsgid != current->gid)
+        if (current_fsgid() != current->gid)
                 CDEBUG (D_KML, "reint_kmlreint_pre_secure: cannot setfsgid\n");
-        current->fsuid = rec->rec_head.uid;
-        current->fsgid = rec->rec_head.fsgid;
+        current_setfsuid(rec->rec_head.uid);
+        current_setfsgid(rec->rec_head.fsgid);
 }
 
 static void kmlreint_post_secure (struct kml_rec *rec)
 {
-        current->fsuid = current->uid; 
-        current->fsgid = current->gid;
+        current_setfsuid(current->uid); 
+        current_setfsgid(current->gid);
         /* current->egid = current->gid; */ 
         /* ????????????? */
 }
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/upcall.c linux-2.5.32-cred1/fs/intermezzo/upcall.c
--- linux-2.5.32/fs/intermezzo/upcall.c	Mon May 20 15:36:58 2002
+++ linux-2.5.32-cred1/fs/intermezzo/upcall.c	Wed Aug 28 23:44:41 2002
@@ -63,7 +63,7 @@
         outp = (union down_args *) (inp);\
         inp->uh.opcode = (op);\
         inp->uh.pid = current->pid;\
-        inp->uh.uid = current->fsuid;\
+        inp->uh.uid = current_fsuid();\
         outsize = insize;\
 } while (0)
 
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/vfs.c linux-2.5.32-cred1/fs/intermezzo/vfs.c
--- linux-2.5.32/fs/intermezzo/vfs.c	Tue Jun 18 16:02:41 2002
+++ linux-2.5.32-cred1/fs/intermezzo/vfs.c	Wed Aug 28 23:44:41 2002
@@ -70,9 +70,9 @@
 {
         if (!(dir->i_mode & S_ISVTX))
                 return 0;
-        if (inode->i_uid == current->fsuid)
+        if (inode->i_uid == current_fsuid())
                 return 0;
-        if (dir->i_uid == current->fsuid)
+        if (dir->i_uid == current_fsuid())
                 return 0;
         return !capable(CAP_FOWNER);
 }
diff -u --recursive --new-file linux-2.5.32/fs/jffs/inode-v23.c linux-2.5.32-cred1/fs/jffs/inode-v23.c
--- linux-2.5.32/fs/jffs/inode-v23.c	Sat Jul 27 17:21:19 2002
+++ linux-2.5.32-cred1/fs/jffs/inode-v23.c	Wed Aug 28 23:44:41 2002
@@ -479,8 +479,8 @@
 	raw_inode.pino = new_dir_f->ino;
 /*  	raw_inode.version = f->highest_version + 1; */
 	raw_inode.mode = f->mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = current->fsgid;
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = current_fsgid();
 #if 0
 	raw_inode.uid = f->uid;
 	raw_inode.gid = f->gid;
@@ -862,9 +862,9 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = dir_mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
-	/*	raw_inode.gid = current->fsgid; */
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
+	/*	raw_inode.gid = current_fsgid(); */
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1026,8 +1026,8 @@
 	raw_inode.pino = del_f->pino;
 /*  	raw_inode.version = del_f->highest_version + 1; */
 	raw_inode.mode = del_f->mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = current->fsgid;
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = current_fsgid();
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = del_f->mtime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1101,9 +1101,9 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
-	/*	raw_inode.gid = current->fsgid; */
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
+	/*	raw_inode.gid = current_fsgid(); */
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1212,8 +1212,8 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = S_IFLNK | S_IRWXUGO;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1314,8 +1314,8 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	raw_inode.uid = current_fsuid();
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
diff -u --recursive --new-file linux-2.5.32/fs/jffs2/fs.c linux-2.5.32-cred1/fs/jffs2/fs.c
--- linux-2.5.32/fs/jffs2/fs.c	Tue Jul 23 15:08:22 2002
+++ linux-2.5.32-cred1/fs/jffs2/fs.c	Wed Aug 28 23:44:41 2002
@@ -229,14 +229,14 @@
 
 	memset(ri, 0, sizeof(*ri));
 	/* Set OS-specific defaults for new inodes */
-	ri->uid = current->fsuid;
+	ri->uid = current_fsuid();
 
 	if (dir_i->i_mode & S_ISGID) {
 		ri->gid = dir_i->i_gid;
 		if (S_ISDIR(mode))
 			ri->mode |= S_ISGID;
 	} else {
-		ri->gid = current->fsgid;
+		ri->gid = current_fsgid();
 	}
 	ri->mode = mode;
 	ret = jffs2_do_new_inode (c, f, mode, ri);
diff -u --recursive --new-file linux-2.5.32/fs/jfs/jfs_inode.c linux-2.5.32-cred1/fs/jfs/jfs_inode.c
--- linux-2.5.32/fs/jfs/jfs_inode.c	Sun Aug  4 03:47:06 2002
+++ linux-2.5.32-cred1/fs/jfs/jfs_inode.c	Wed Aug 28 23:44:41 2002
@@ -52,13 +52,13 @@
 		return NULL;
 	}
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	if (parent->i_mode & S_ISGID) {
 		inode->i_gid = parent->i_gid;
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 
 	inode->i_mode = mode;
 	if (S_ISDIR(mode))
diff -u --recursive --new-file linux-2.5.32/fs/lockd/host.c linux-2.5.32-cred1/fs/lockd/host.c
--- linux-2.5.32/fs/lockd/host.c	Tue Feb  5 08:49:27 2002
+++ linux-2.5.32-cred1/fs/lockd/host.c	Wed Aug 28 23:44:41 2002
@@ -187,14 +187,14 @@
 					host->h_nextrebind - jiffies);
 		}
 	} else {
-		uid_t saved_fsuid = current->fsuid;
+		uid_t saved_fsuid = current_fsuid();
 		kernel_cap_t saved_cap = current->cap_effective;
 
 		/* Create RPC socket as root user so we get a priv port */
-		current->fsuid = 0;
+		current_setfsuid(0);
 		cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
 		xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL);
-		current->fsuid = saved_fsuid;
+		current_setfsuid(saved_fsuid);
 		current->cap_effective = saved_cap;
 		if (xprt == NULL)
 			goto forgetit;
diff -u --recursive --new-file linux-2.5.32/fs/locks.c linux-2.5.32-cred1/fs/locks.c
--- linux-2.5.32/fs/locks.c	Wed Aug 21 17:29:29 2002
+++ linux-2.5.32-cred1/fs/locks.c	Wed Aug 28 23:44:41 2002
@@ -1202,7 +1202,7 @@
 	dentry = filp->f_dentry;
 	inode = dentry->d_inode;
 
-	if ((current->fsuid != inode->i_uid) && !capable(CAP_LEASE))
+	if ((current_fsuid() != inode->i_uid) && !capable(CAP_LEASE))
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
diff -u --recursive --new-file linux-2.5.32/fs/minix/bitmap.c linux-2.5.32-cred1/fs/minix/bitmap.c
--- linux-2.5.32/fs/minix/bitmap.c	Thu May 23 15:18:51 2002
+++ linux-2.5.32-cred1/fs/minix/bitmap.c	Wed Aug 28 23:44:41 2002
@@ -247,8 +247,8 @@
 		iput(inode);
 		return NULL;
 	}
-	inode->i_uid = current->fsuid;
-	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	inode->i_uid = current_fsuid();
+	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
diff -u --recursive --new-file linux-2.5.32/fs/namei.c linux-2.5.32-cred1/fs/namei.c
--- linux-2.5.32/fs/namei.c	Mon Jul 22 23:20:31 2002
+++ linux-2.5.32-cred1/fs/namei.c	Wed Aug 28 23:44:41 2002
@@ -174,7 +174,7 @@
 			return -EACCES;
 	}
 
-	if (current->fsuid == inode->i_uid)
+	if (current_fsuid() == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
@@ -324,7 +324,7 @@
 	if ((inode->i_op && inode->i_op->permission))
 		return -EAGAIN;
 
-	if (current->fsuid == inode->i_uid)
+	if (current_fsuid() == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
@@ -983,9 +983,9 @@
 {
 	if (!(dir->i_mode & S_ISVTX))
 		return 0;
-	if (inode->i_uid == current->fsuid)
+	if (inode->i_uid == current_fsuid())
 		return 0;
-	if (dir->i_uid == current->fsuid)
+	if (dir->i_uid == current_fsuid())
 		return 0;
 	return !capable(CAP_FOWNER);
 }
diff -u --recursive --new-file linux-2.5.32/fs/nfsd/auth.c linux-2.5.32-cred1/fs/nfsd/auth.c
--- linux-2.5.32/fs/nfsd/auth.c	Tue Feb  5 18:39:38 2002
+++ linux-2.5.32-cred1/fs/nfsd/auth.c	Wed Aug 28 23:44:41 2002
@@ -35,13 +35,13 @@
 	}
 
 	if (cred->cr_uid != (uid_t) -1)
-		current->fsuid = cred->cr_uid;
+		current_setfsuid(cred->cr_uid);
 	else
-		current->fsuid = exp->ex_anon_uid;
+		current_setfsuid(exp->ex_anon_uid);
 	if (cred->cr_gid != (gid_t) -1)
-		current->fsgid = cred->cr_gid;
+		current_setfsgid(cred->cr_gid);
 	else
-		current->fsgid = exp->ex_anon_gid;
+		current_setfsgid(exp->ex_anon_gid);
 	for (i = 0; i < NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
diff -u --recursive --new-file linux-2.5.32/fs/nfsd/vfs.c linux-2.5.32-cred1/fs/nfsd/vfs.c
--- linux-2.5.32/fs/nfsd/vfs.c	Thu Aug 22 01:26:44 2002
+++ linux-2.5.32-cred1/fs/nfsd/vfs.c	Wed Aug 28 23:44:41 2002
@@ -1498,7 +1498,7 @@
 		IS_APPEND(inode)?	" append" : "",
 		IS_RDONLY(inode)?	" ro" : "");
 	dprintk("      owner %d/%d user %d/%d\n",
-		inode->i_uid, inode->i_gid, current->fsuid, current->fsgid);
+		inode->i_uid, inode->i_gid, current_fsuid(), current_fsgid());
 #endif
 
 	/* only care about readonly exports for files and
@@ -1540,7 +1540,7 @@
 	 * with NFSv3.
 	 */
 	if ((acc & MAY_OWNER_OVERRIDE) &&
-	    inode->i_uid == current->fsuid)
+	    inode->i_uid == current_fsuid())
 		return 0;
 
 	acc &= ~ MAY_OWNER_OVERRIDE; /* This bit is no longer needed,
diff -u --recursive --new-file linux-2.5.32/fs/open.c linux-2.5.32-cred1/fs/open.c
--- linux-2.5.32/fs/open.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-cred1/fs/open.c	Wed Aug 28 23:44:41 2002
@@ -259,7 +259,7 @@
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
-		if (current->fsuid != inode->i_uid &&
+		if (current_fsuid() != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
@@ -306,7 +306,7 @@
 		newattrs.ia_mtime = times[1].tv_sec;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
-		if (current->fsuid != inode->i_uid &&
+		if (current_fsuid() != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
@@ -334,12 +334,12 @@
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
-	old_fsuid = current->fsuid;
-	old_fsgid = current->fsgid;
+	old_fsuid = current_fsuid();
+	old_fsgid = current_fsgid();
 	old_cap = current->cap_effective;
 
-	current->fsuid = current->uid;
-	current->fsgid = current->gid;
+	current_setfsuid(current->uid);
+	current_setfsgid(current->gid);
 
 	/*
 	 * Clear the capabilities if we switch to a non-root user
@@ -364,8 +364,8 @@
 		path_release(&nd);
 	}
 
-	current->fsuid = old_fsuid;
-	current->fsgid = old_fsgid;
+	current_setfsuid(old_fsuid);
+	current_setfsgid(old_fsgid);
 	current->cap_effective = old_cap;
 
 	return res;
diff -u --recursive --new-file linux-2.5.32/fs/pipe.c linux-2.5.32-cred1/fs/pipe.c
--- linux-2.5.32/fs/pipe.c	Mon Jul 15 19:03:05 2002
+++ linux-2.5.32-cred1/fs/pipe.c	Wed Aug 28 23:44:41 2002
@@ -564,8 +564,8 @@
 	 */
 	inode->i_state = I_DIRTY;
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
+	inode->i_uid = current_fsuid();
+	inode->i_gid = current_fsgid();
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blksize = PAGE_SIZE;
 	return inode;
diff -u --recursive --new-file linux-2.5.32/fs/proc/base.c linux-2.5.32-cred1/fs/proc/base.c
--- linux-2.5.32/fs/proc/base.c	Tue Aug 13 01:20:00 2002
+++ linux-2.5.32-cred1/fs/proc/base.c	Wed Aug 28 23:44:41 2002
@@ -526,7 +526,7 @@
 	/* We don't need a base pointer in the /proc filesystem */
 	path_release(nd);
 
-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	if (current_fsuid() != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
 	error = proc_check_root(inode);
 	if (error)
@@ -568,7 +568,7 @@
 
 	lock_kernel();
 
-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	if (current_fsuid() != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
 	error = proc_check_root(inode);
 	if (error)
diff -u --recursive --new-file linux-2.5.32/fs/ramfs/inode.c linux-2.5.32-cred1/fs/ramfs/inode.c
--- linux-2.5.32/fs/ramfs/inode.c	Sat Jul 27 17:21:19 2002
+++ linux-2.5.32-cred1/fs/ramfs/inode.c	Wed Aug 28 23:44:41 2002
@@ -85,8 +85,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/reiserfs/namei.c linux-2.5.32-cred1/fs/reiserfs/namei.c
--- linux-2.5.32/fs/reiserfs/namei.c	Tue Aug  6 08:57:09 2002
+++ linux-2.5.32-cred1/fs/reiserfs/namei.c	Wed Aug 28 23:44:41 2002
@@ -545,7 +545,7 @@
     /* the quota init calls have to know who to charge the quota to, so
     ** we have to set uid and gid here
     */
-    inode->i_uid = current->fsuid;
+    inode->i_uid = current_fsuid();
     inode->i_mode = mode;
 
     if (dir->i_mode & S_ISGID) {
@@ -553,7 +553,7 @@
         if (S_ISDIR(mode))
             inode->i_mode |= S_ISGID;
     } else {
-        inode->i_gid = current->fsgid;
+        inode->i_gid = current_fsgid();
     }
     return 0 ;
 }
diff -u --recursive --new-file linux-2.5.32/fs/sysv/ialloc.c linux-2.5.32-cred1/fs/sysv/ialloc.c
--- linux-2.5.32/fs/sysv/ialloc.c	Thu May 23 15:18:57 2002
+++ linux-2.5.32-cred1/fs/sysv/ialloc.c	Wed Aug 28 23:44:41 2002
@@ -165,9 +165,9 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
diff -u --recursive --new-file linux-2.5.32/fs/udf/ialloc.c linux-2.5.32-cred1/fs/udf/ialloc.c
--- linux-2.5.32/fs/udf/ialloc.c	Thu May 23 15:18:59 2002
+++ linux-2.5.32-cred1/fs/udf/ialloc.c	Wed Aug 28 23:44:41 2002
@@ -118,7 +118,7 @@
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	inode->i_mode = mode;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	if (dir->i_mode & S_ISGID)
 	{
 		inode->i_gid = dir->i_gid;
@@ -126,7 +126,7 @@
 			mode |= S_ISGID;
 	}
 	else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 
 	UDF_I_LOCATION(inode).logicalBlockNum = block;
 	UDF_I_LOCATION(inode).partitionReferenceNum = UDF_I_LOCATION(dir).partitionReferenceNum;
diff -u --recursive --new-file linux-2.5.32/fs/udf/namei.c linux-2.5.32-cred1/fs/udf/namei.c
--- linux-2.5.32/fs/udf/namei.c	Thu May 23 15:19:00 2002
+++ linux-2.5.32-cred1/fs/udf/namei.c	Wed Aug 28 23:44:41 2002
@@ -687,7 +687,7 @@
 	if (!inode)
 		goto out;
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	init_special_inode(inode, mode, rdev);
 	if (!(fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err)))
 	{
diff -u --recursive --new-file linux-2.5.32/fs/ufs/ialloc.c linux-2.5.32-cred1/fs/ufs/ialloc.c
--- linux-2.5.32/fs/ufs/ialloc.c	Tue Aug 20 14:25:37 2002
+++ linux-2.5.32-cred1/fs/ufs/ialloc.c	Wed Aug 28 23:44:41 2002
@@ -254,13 +254,13 @@
 	sb->s_dirt = 1;
 
 	inode->i_mode = mode;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current_fsuid();
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 		if (S_ISDIR(mode))
 			inode->i_mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current_fsgid();
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
diff -u --recursive --new-file linux-2.5.32/fs/umsdos/namei.c linux-2.5.32-cred1/fs/umsdos/namei.c
--- linux-2.5.32/fs/umsdos/namei.c	Sat Jun  1 03:18:10 2002
+++ linux-2.5.32-cred1/fs/umsdos/namei.c	Wed Aug 28 23:44:41 2002
@@ -255,8 +255,8 @@
 	info.entry.mode = mode;
 	info.entry.rdev = rdev;
 	info.entry.flags = flags;
-	info.entry.uid = current->fsuid;
-	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	info.entry.uid = current_fsuid();
+	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	info.entry.ctime = info.entry.atime = info.entry.mtime = CURRENT_TIME;
 	info.entry.nlink = 1;
 	ret = umsdos_newentry (dentry->d_parent, &info);
@@ -779,8 +779,8 @@
 
 	info.entry.mode = mode | S_IFDIR;
 	info.entry.rdev = 0;
-	info.entry.uid = current->fsuid;
-	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	info.entry.uid = current_fsuid();
+	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
 	info.entry.ctime = info.entry.atime = info.entry.mtime = CURRENT_TIME;
 	info.entry.flags = 0;
 	info.entry.nlink = 1;
diff -u --recursive --new-file linux-2.5.32/include/linux/sched.h linux-2.5.32-cred1/include/linux/sched.h
--- linux-2.5.32/include/linux/sched.h	Mon Aug 26 21:30:27 2002
+++ linux-2.5.32-cred1/include/linux/sched.h	Wed Aug 28 23:44:41 2002
@@ -946,6 +946,28 @@
 
 #endif /* CONFIG_SMP */
 
+/* Provisional functions for the transition to reference-counted ucreds */
+static inline uid_t current_fsuid(void)
+{
+	return current->fsuid;
+}
+static inline gid_t current_fsgid(void)
+{
+	return current->fsgid;
+}
+static inline int current_ngroups(void)
+{
+	return current->ngroups;
+}
+static inline void current_setfsuid(uid_t uid)
+{
+	current->fsuid = uid;
+}
+static inline void current_setfsgid(gid_t gid)
+{
+	current->fsgid = gid;
+}
+
 #endif /* __KERNEL__ */
 
 #endif
diff -u --recursive --new-file linux-2.5.32/kernel/sys.c linux-2.5.32-cred1/kernel/sys.c
--- linux-2.5.32/kernel/sys.c	Fri Aug 16 06:33:01 2002
+++ linux-2.5.32-cred1/kernel/sys.c	Thu Aug 29 00:27:10 2002
@@ -468,7 +468,7 @@
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && egid != old_rgid))
 		current->sgid = new_egid;
-	current->fsgid = new_egid;
+	current_setfsgid(new_egid);
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	return 0;
@@ -495,7 +495,8 @@
 			current->mm->dumpable=0;
 			wmb();
 		}
-		current->gid = current->egid = current->sgid = current->fsgid = gid;
+		current->gid = current->egid = current->sgid = gid;
+		current_setfsgid(gid);
 	}
 	else if ((gid == current->gid) || (gid == current->sgid))
 	{
@@ -504,7 +505,8 @@
 			current->mm->dumpable=0;
 			wmb();
 		}
-		current->egid = current->fsgid = gid;
+		current->egid = gid;
+		current_setfsgid(gid);
 	}
 	else
 		return -EPERM;
@@ -591,11 +593,12 @@
 		current->mm->dumpable=0;
 		wmb();
 	}
-	current->fsuid = current->euid = new_euid;
+	current->euid = new_euid;
+	current_setfsuid(new_euid);
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
-	current->fsuid = current->euid;
+	current_setfsuid(current->euid);
 
 	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
@@ -639,7 +642,8 @@
 		current->mm->dumpable = 0;
 		wmb();
 	}
-	current->fsuid = current->euid = uid;
+	current->euid = uid;
+	current_setfsuid(uid);
 	current->suid = new_suid;
 
 	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
@@ -684,7 +688,7 @@
 		}
 		current->euid = euid;
 	}
-	current->fsuid = current->euid;
+	current_setfsuid(current->euid);
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
@@ -732,7 +736,7 @@
 		}
 		current->egid = egid;
 	}
-	current->fsgid = current->egid;
+	current_setfsgid(current->egid);
 	if (rgid != (gid_t) -1)
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
@@ -767,9 +771,9 @@
 	if (retval)
 		return retval;
 
-	old_fsuid = current->fsuid;
+	old_fsuid = current_fsuid();
 	if (uid == current->uid || uid == current->euid ||
-	    uid == current->suid || uid == current->fsuid || 
+	    uid == current->suid || uid == current_fsuid() || 
 	    capable(CAP_SETUID))
 	{
 		if (uid != old_fsuid)
@@ -777,7 +781,7 @@
 			current->mm->dumpable = 0;
 			wmb();
 		}
-		current->fsuid = uid;
+		current_setfsuid(uid);
 	}
 
 	retval = security_ops->task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
@@ -799,9 +803,9 @@
 	if (retval)
 		return retval;
 
-	old_fsgid = current->fsgid;
+	old_fsgid = current_fsgid();
 	if (gid == current->gid || gid == current->egid ||
-	    gid == current->sgid || gid == current->fsgid || 
+	    gid == current->sgid || gid == current_fsgid() || 
 	    capable(CAP_SETGID))
 	{
 		if (gid != old_fsgid)
@@ -809,7 +813,7 @@
 			current->mm->dumpable = 0;
 			wmb();
 		}
-		current->fsgid = gid;
+		current_setfsgid(gid);
 	}
 	return old_fsgid;
 }
@@ -989,7 +993,7 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = current_ngroups();
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
@@ -1025,7 +1029,7 @@
 
 static int supplemental_group_member(gid_t grp)
 {
-	int i = current->ngroups;
+	int i = current_ngroups();
 
 	if (i) {
 		gid_t *groups = current->groups;
@@ -1045,7 +1049,7 @@
 int in_group_p(gid_t grp)
 {
 	int retval = 1;
-	if (grp != current->fsgid)
+	if (grp != current_fsgid())
 		retval = supplemental_group_member(grp);
 	return retval;
 }
diff -u --recursive --new-file linux-2.5.32/kernel/uid16.c linux-2.5.32-cred1/kernel/uid16.c
--- linux-2.5.32/kernel/uid16.c	Sat Jul 20 01:00:55 2002
+++ linux-2.5.32-cred1/kernel/uid16.c	Wed Aug 28 23:44:41 2002
@@ -114,7 +114,7 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = current_ngroups();
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
diff -u --recursive --new-file linux-2.5.32/mm/shmem.c linux-2.5.32-cred1/mm/shmem.c
--- linux-2.5.32/mm/shmem.c	Wed Aug 14 03:09:12 2002
+++ linux-2.5.32-cred1/mm/shmem.c	Wed Aug 28 23:44:41 2002
@@ -783,8 +783,8 @@
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
@@ -1408,8 +1408,8 @@
 	struct dentry * root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
-	uid_t uid = current->fsuid;
-	gid_t gid = current->fsgid;
+	uid_t uid = current_fsuid();
+	gid_t gid = current_fsgid();
 	struct shmem_sb_info *sbinfo;
 	struct sysinfo si;
 	int err;
diff -u --recursive --new-file linux-2.5.32/net/socket.c linux-2.5.32-cred1/net/socket.c
--- linux-2.5.32/net/socket.c	Mon Jul 29 07:54:49 2002
+++ linux-2.5.32-cred1/net/socket.c	Wed Aug 28 23:44:41 2002
@@ -470,8 +470,8 @@
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
 	inode->i_sock = 1;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
+	inode->i_uid = current_fsuid();
+	inode->i_gid = current_fsgid();
 
 	sockets_in_use[smp_processor_id()].counter++;
 	return sock;
diff -u --recursive --new-file linux-2.5.32/net/sunrpc/auth_unix.c linux-2.5.32-cred1/net/sunrpc/auth_unix.c
--- linux-2.5.32/net/sunrpc/auth_unix.c	Tue Feb  5 16:23:07 2002
+++ linux-2.5.32-cred1/net/sunrpc/auth_unix.c	Wed Aug 28 23:44:41 2002
@@ -80,14 +80,14 @@
 		cred->uc_gid = cred->uc_fsgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = current->ngroups;
+		int groups = current_ngroups();
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 
 		cred->uc_uid = current->uid;
 		cred->uc_gid = current->gid;
-		cred->uc_fsuid = current->fsuid;
-		cred->uc_fsgid = current->fsgid;
+		cred->uc_fsuid = current_fsuid();
+		cred->uc_fsgid = current_fsgid();
 		for (i = 0; i < groups; i++)
 			cred->uc_gids[i] = (gid_t) current->groups[i];
 		if (i < NFS_NGROUPS)
@@ -142,11 +142,11 @@
 
 		if (cred->uc_uid != current->uid
 		 || cred->uc_gid != current->gid
-		 || cred->uc_fsuid != current->fsuid
-		 || cred->uc_fsgid != current->fsgid)
+		 || cred->uc_fsuid != current_fsuid()
+		 || cred->uc_fsgid != current_fsgid())
 			return 0;
 
-		groups = current->ngroups;
+		groups = current_ngroups();
 		if (groups > NFS_NGROUPS)
 			groups = NFS_NGROUPS;
 		for (i = 0; i < groups ; i++)
diff -u --recursive --new-file linux-2.5.32/net/sunrpc/sched.c linux-2.5.32-cred1/net/sunrpc/sched.c
--- linux-2.5.32/net/sunrpc/sched.c	Sun Jul  7 19:50:03 2002
+++ linux-2.5.32-cred1/net/sunrpc/sched.c	Wed Aug 28 23:44:41 2002
@@ -750,7 +750,7 @@
 	task->tk_flags  = flags;
 	task->tk_exit   = callback;
 	init_waitqueue_head(&task->tk_wait);
-	if (current->uid != current->fsuid || current->gid != current->fsgid)
+	if (current->uid != current_fsuid() || current->gid != current_fsgid())
 		task->tk_flags |= RPC_TASK_SETUID;
 
 	/* Initialize retry counters */
diff -u --recursive --new-file linux-2.5.32/security/capability.c linux-2.5.32-cred1/security/capability.c
--- linux-2.5.32/security/capability.c	Tue Jul 30 00:44:17 2002
+++ linux-2.5.32-cred1/security/capability.c	Wed Aug 28 23:44:41 2002
@@ -583,11 +583,11 @@
 			 */
 
 			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-				if (old_fsuid == 0 && current->fsuid != 0) {
+				if (old_fsuid == 0 && current_fsuid() != 0) {
 					cap_t (current->cap_effective) &=
 					    ~CAP_FS_MASK;
 				}
-				if (old_fsuid != 0 && current->fsuid == 0) {
+				if (old_fsuid != 0 && current_fsuid() == 0) {
 					cap_t (current->cap_effective) |=
 					    (cap_t (current->cap_permitted) &
 					     CAP_FS_MASK);
