Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSHaQbJ>; Sat, 31 Aug 2002 12:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSHaQbJ>; Sat, 31 Aug 2002 12:31:09 -0400
Received: from pat.uio.no ([129.240.130.16]:1173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317767AbSHaQ37>;
	Sat, 31 Aug 2002 12:29:59 -0400
Message-ID: <15728.61450.231265.842331@charged.uio.no>
Date: Sat, 31 Aug 2002 18:34:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Initial support for struct vfs_cred   [1/1]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce basic *BSD style user credentials of the form

struct vfs_cred {
	atomic_t count;
	uid_t    uid;
	gid_t    gid;
	int      ngroups;
	gid_t    *groups;
};

and replace the 'VFS-specific' authentication elements, fsuid, fsgid,
ngroups, and groups from struct task_struct.

struct vfs_cred strictly obeys copy on write rules. As such, it is
not meant as a unit for implementing shared creds between threads.
Instead it is a structure designed for caching user credentials
and passing them around inside the VFS. It will eventually ensure that
even when we do add sharing of credentials between several threads, we
will still be able to keep a consistent authentication scheme
by sharing the vfs_cred as a parameter in VFS function calls. e.g.

  lookup(vfscred, dir, dentry);
  permission(vfscred, dentry->d_inode, MAY_WRITE);
  dentry_open(vfscred, dentry, mnt, FMODE_WRITE);

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.32/arch/s390x/kernel/linux32.c linux-2.5.32-vfscred/arch/s390x/kernel/linux32.c
--- linux-2.5.32/arch/s390x/kernel/linux32.c	Tue Jul 30 00:08:09 2002
+++ linux-2.5.32-vfscred/arch/s390x/kernel/linux32.c	Sat Aug 31 12:48:35 2002
@@ -194,12 +194,10 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -217,10 +215,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	return setgroups16(gidsetsize, grouplist);
 }
 
 asmlinkage long sys32_getuid16(void)
diff -u --recursive --new-file linux-2.5.32/arch/sparc64/kernel/sys_sparc32.c linux-2.5.32-vfscred/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.32/arch/sparc64/kernel/sys_sparc32.c	Sat Aug 24 12:59:14 2002
+++ linux-2.5.32-vfscred/arch/sparc64/kernel/sys_sparc32.c	Sat Aug 31 12:48:35 2002
@@ -211,12 +211,10 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = getgroups16(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
 		if (copy_to_user(grouplist, groups, sizeof(u16)*i))
 			return -EFAULT;
 	}
@@ -234,10 +232,7 @@
 		return -EINVAL;
 	if (copy_from_user(groups, grouplist, gidsetsize * sizeof(u16)))
 		return -EFAULT;
-	for (i = 0 ; i < gidsetsize ; i++)
-		current->groups[i] = (gid_t)groups[i];
-	current->ngroups = gidsetsize;
-	return 0;
+	return setgroups16(gidsetsize, groups);
 }
 
 asmlinkage long sys32_getuid16(void)
diff -u --recursive --new-file linux-2.5.32/drivers/hotplug/pci_hotplug_core.c linux-2.5.32-vfscred/drivers/hotplug/pci_hotplug_core.c
--- linux-2.5.32/drivers/hotplug/pci_hotplug_core.c	Tue Jul 23 02:24:20 2002
+++ linux-2.5.32-vfscred/drivers/hotplug/pci_hotplug_core.c	Sat Aug 31 12:48:31 2002
@@ -93,8 +93,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current->vfscred->uid;
+		inode->i_gid = current->vfscred->gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/drivers/isdn/capi/capifs.c linux-2.5.32-vfscred/drivers/isdn/capi/capifs.c
--- linux-2.5.32/drivers/isdn/capi/capifs.c	Fri Aug 16 00:01:13 2002
+++ linux-2.5.32-vfscred/drivers/isdn/capi/capifs.c	Sat Aug 31 12:48:31 2002
@@ -401,8 +401,8 @@
 
 		if ((np->inode = capifs_new_inode(sb)) != NULL) {
 			struct inode *inode = np->inode;
-			inode->i_uid = sbi->setuid ? sbi->uid : current->fsuid;
-			inode->i_gid = sbi->setgid ? sbi->gid : current->fsgid;
+			inode->i_uid = sbi->setuid ? sbi->uid : current->vfscred->uid;
+			inode->i_gid = sbi->setgid ? sbi->gid : current->vfscred->gid;
 			inode->i_nlink = 1;
 			inode->i_ino = ino + 2;
 			init_special_inode(inode, sbi->mode|S_IFCHR, kdev_t_to_nr(np->kdev));
diff -u --recursive --new-file linux-2.5.32/drivers/usb/core/inode.c linux-2.5.32-vfscred/drivers/usb/core/inode.c
--- linux-2.5.32/drivers/usb/core/inode.c	Fri Aug  2 19:55:22 2002
+++ linux-2.5.32-vfscred/drivers/usb/core/inode.c	Sat Aug 31 12:48:31 2002
@@ -148,8 +148,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current->vfscred->uid;
+		inode->i_gid = current->vfscred->gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/affs/inode.c linux-2.5.32-vfscred/fs/affs/inode.c
--- linux-2.5.32/fs/affs/inode.c	Thu May 23 15:18:41 2002
+++ linux-2.5.32-vfscred/fs/affs/inode.c	Sat Aug 31 12:48:31 2002
@@ -325,8 +325,8 @@
 	mark_buffer_dirty_inode(bh, inode);
 	affs_brelse(bh);
 
-	inode->i_uid     = current->fsuid;
-	inode->i_gid     = current->fsgid;
+	inode->i_uid     = current->vfscred->uid;
+	inode->i_gid     = current->vfscred->gid;
 	inode->i_ino     = block;
 	inode->i_nlink   = 1;
 	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME;
diff -u --recursive --new-file linux-2.5.32/fs/attr.c linux-2.5.32-vfscred/fs/attr.c
--- linux-2.5.32/fs/attr.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-vfscred/fs/attr.c	Sat Aug 31 12:48:31 2002
@@ -30,7 +30,7 @@
 
 	/* Make sure a caller can chown. */
 	if ((ia_valid & ATTR_UID) &&
-	    (current->fsuid != inode->i_uid ||
+	    (current->vfscred->uid != inode->i_uid ||
 	     attr->ia_uid != inode->i_uid) && !capable(CAP_CHOWN))
 		goto error;
 
@@ -42,7 +42,7 @@
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_FOWNER))
 			goto error;
 		/* Also check the setgid bit! */
 		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
@@ -52,7 +52,7 @@
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET)) {
-		if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER))
+		if (current->vfscred->uid != inode->i_uid && !capable(CAP_FOWNER))
 			goto error;
 	}
 fine:
diff -u --recursive --new-file linux-2.5.32/fs/bfs/dir.c linux-2.5.32-vfscred/fs/bfs/dir.c
--- linux-2.5.32/fs/bfs/dir.c	Thu May 23 15:24:30 2002
+++ linux-2.5.32-vfscred/fs/bfs/dir.c	Sat Aug 31 12:48:31 2002
@@ -98,8 +98,8 @@
 	}
 	set_bit(ino, info->si_imap);	
 	info->si_freei--;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	inode->i_uid = current->vfscred->uid;
+	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
 	inode->i_op = &bfs_file_inops;
diff -u --recursive --new-file linux-2.5.32/fs/coda/coda_linux.c linux-2.5.32-vfscred/fs/coda/coda_linux.c
--- linux-2.5.32/fs/coda/coda_linux.c	Mon May 20 15:34:54 2002
+++ linux-2.5.32-vfscred/fs/coda/coda_linux.c	Sat Aug 31 12:48:31 2002
@@ -66,17 +66,17 @@
         cred->cr_uid = (vuid_t) current->uid;
         cred->cr_euid = (vuid_t) current->euid;
         cred->cr_suid = (vuid_t) current->suid;
-        cred->cr_fsuid = (vuid_t) current->fsuid;
+        cred->cr_fsuid = (vuid_t) current->vfscred->uid;
 
         cred->cr_groupid = (vgid_t) current->gid;
         cred->cr_egid = (vgid_t) current->egid;
         cred->cr_sgid = (vgid_t) current->sgid;
-        cred->cr_fsgid = (vgid_t) current->fsgid;
+        cred->cr_fsgid = (vgid_t) current->vfscred->gid;
 }
 
 int coda_cred_ok(struct coda_cred *cred)
 {
-	return(current->fsuid == cred->cr_fsuid);
+	return(current->vfscred->uid == cred->cr_fsuid);
 }
 
 int coda_cred_eq(struct coda_cred *cred1, struct coda_cred *cred2)
diff -u --recursive --new-file linux-2.5.32/fs/devpts/inode.c linux-2.5.32-vfscred/fs/devpts/inode.c
--- linux-2.5.32/fs/devpts/inode.c	Fri Jul  5 02:02:21 2002
+++ linux-2.5.32-vfscred/fs/devpts/inode.c	Sat Aug 31 12:48:31 2002
@@ -137,8 +137,8 @@
 		return;
 	inode->i_ino = number+2;
 	inode->i_blksize = 1024;
-	inode->i_uid = config.setuid ? config.uid : current->fsuid;
-	inode->i_gid = config.setgid ? config.gid : current->fsgid;
+	inode->i_uid = config.setuid ? config.uid : current->vfscred->uid;
+	inode->i_gid = config.setgid ? config.gid : current->vfscred->gid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
 
diff -u --recursive --new-file linux-2.5.32/fs/dquot.c linux-2.5.32-vfscred/fs/dquot.c
--- linux-2.5.32/fs/dquot.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-vfscred/fs/dquot.c	Sat Aug 31 12:48:31 2002
@@ -785,7 +785,7 @@
 {
 	switch (dquot->dq_type) {
 		case USRQUOTA:
-			return current->fsuid == dquot->dq_id && !(dquot->dq_flags & flag);
+			return current->vfscred->uid == dquot->dq_id && !(dquot->dq_flags & flag);
 		case GRPQUOTA:
 			return in_group_p(dquot->dq_id) && !(dquot->dq_flags & flag);
 	}
diff -u --recursive --new-file linux-2.5.32/fs/driverfs/inode.c linux-2.5.32-vfscred/fs/driverfs/inode.c
--- linux-2.5.32/fs/driverfs/inode.c	Mon Aug  5 20:13:07 2002
+++ linux-2.5.32-vfscred/fs/driverfs/inode.c	Sat Aug 31 12:48:31 2002
@@ -98,8 +98,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current->vfscred->uid;
+		inode->i_gid = current->vfscred->gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/exec.c linux-2.5.32-vfscred/fs/exec.c
--- linux-2.5.32/fs/exec.c	Wed Aug 14 15:46:59 2002
+++ linux-2.5.32-vfscred/fs/exec.c	Sat Aug 31 12:48:31 2002
@@ -770,8 +770,10 @@
 		do_unlock = 1;
 	}
 
-        current->suid = current->euid = current->fsuid = bprm->e_uid;
-        current->sgid = current->egid = current->fsgid = bprm->e_gid;
+        current->suid = current->euid = bprm->e_uid;
+	setfsuid(bprm->e_uid);
+        current->sgid = current->egid = bprm->e_gid;
+	setfsgid(bprm->e_gid);
 
 	if(do_unlock)
 		unlock_kernel();
diff -u --recursive --new-file linux-2.5.32/fs/ext2/balloc.c linux-2.5.32-vfscred/fs/ext2/balloc.c
--- linux-2.5.32/fs/ext2/balloc.c	Thu Jul  4 18:17:10 2002
+++ linux-2.5.32-vfscred/fs/ext2/balloc.c	Sat Aug 31 12:48:31 2002
@@ -105,7 +105,7 @@
 		count = free_blocks;
 
 	if (free_blocks < root_blocks + count && !capable(CAP_SYS_RESOURCE) &&
-	    sbi->s_resuid != current->fsuid &&
+	    sbi->s_resuid != current->vfscred->uid &&
 	    (sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
 		/*
 		 * We are too close to reserve and we are not privileged.
diff -u --recursive --new-file linux-2.5.32/fs/ext2/ialloc.c linux-2.5.32-vfscred/fs/ext2/ialloc.c
--- linux-2.5.32/fs/ext2/ialloc.c	Thu Jul  4 18:17:10 2002
+++ linux-2.5.32-vfscred/fs/ext2/ialloc.c	Sat Aug 31 12:48:31 2002
@@ -344,7 +344,7 @@
 		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {
@@ -352,7 +352,7 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 	inode->i_mode = mode;
 
 	inode->i_ino = ino;
diff -u --recursive --new-file linux-2.5.32/fs/ext2/ioctl.c linux-2.5.32-vfscred/fs/ext2/ioctl.c
--- linux-2.5.32/fs/ext2/ioctl.c	Fri Jun 21 07:33:18 2002
+++ linux-2.5.32-vfscred/fs/ext2/ioctl.c	Sat Aug 31 12:48:31 2002
@@ -30,7 +30,7 @@
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EACCES;
 
 		if (get_user(flags, (int *) arg))
@@ -79,7 +79,7 @@
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int *) arg);
 	case EXT2_IOC_SETVERSION:
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
 		if (IS_RDONLY(inode))
 			return -EROFS;
diff -u --recursive --new-file linux-2.5.32/fs/ext3/balloc.c linux-2.5.32-vfscred/fs/ext3/balloc.c
--- linux-2.5.32/fs/ext3/balloc.c	Thu Jul  4 18:17:11 2002
+++ linux-2.5.32-vfscred/fs/ext3/balloc.c	Sat Aug 31 12:48:31 2002
@@ -411,7 +411,7 @@
 	es = sb->u.ext3_sb.s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
-	    ((sb->u.ext3_sb.s_resuid != current->fsuid) &&
+	    ((sb->u.ext3_sb.s_resuid != current->vfscred->uid) &&
 	     (sb->u.ext3_sb.s_resgid == 0 ||
 	      !in_group_p(sb->u.ext3_sb.s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
diff -u --recursive --new-file linux-2.5.32/fs/ext3/ialloc.c linux-2.5.32-vfscred/fs/ext3/ialloc.c
--- linux-2.5.32/fs/ext3/ialloc.c	Thu Jul  4 18:17:11 2002
+++ linux-2.5.32-vfscred/fs/ext3/ialloc.c	Sat Aug 31 12:48:31 2002
@@ -367,7 +367,7 @@
 	sb->s_dirt = 1;
 	if (err) goto fail;
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {
@@ -375,7 +375,7 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 	inode->i_mode = mode;
 
 	inode->i_ino = j;
diff -u --recursive --new-file linux-2.5.32/fs/ext3/ioctl.c linux-2.5.32-vfscred/fs/ext3/ioctl.c
--- linux-2.5.32/fs/ext3/ioctl.c	Fri Jun 21 07:33:18 2002
+++ linux-2.5.32-vfscred/fs/ext3/ioctl.c	Sat Aug 31 12:48:31 2002
@@ -37,7 +37,7 @@
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EACCES;
 
 		if (get_user(flags, (int *) arg))
@@ -123,7 +123,7 @@
 		__u32 generation;
 		int err;
 
-		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
 		if (IS_RDONLY(inode))
 			return -EROFS;
diff -u --recursive --new-file linux-2.5.32/fs/file_table.c linux-2.5.32-vfscred/fs/file_table.c
--- linux-2.5.32/fs/file_table.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-vfscred/fs/file_table.c	Sat Aug 31 12:48:31 2002
@@ -52,8 +52,8 @@
 		}
 		atomic_set(&f->f_count,1);
 		f->f_version = ++event;
-		f->f_uid = current->fsuid;
-		f->f_gid = current->fsgid;
+		f->f_uid = current->vfscred->uid;
+		f->f_gid = current->vfscred->gid;
 		list_add(&f->f_list, &anon_list);
 		file_list_unlock();
 		return f;
@@ -96,8 +96,8 @@
 	filp->f_mode   = mode;
 	atomic_set(&filp->f_count, 1);
 	filp->f_dentry = dentry;
-	filp->f_uid    = current->fsuid;
-	filp->f_gid    = current->fsgid;
+	filp->f_uid    = current->vfscred->uid;
+	filp->f_gid    = current->vfscred->gid;
 	filp->f_op     = dentry->d_inode->i_fop;
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
diff -u --recursive --new-file linux-2.5.32/fs/hpfs/namei.c linux-2.5.32-vfscred/fs/hpfs/namei.c
--- linux-2.5.32/fs/hpfs/namei.c	Thu May 23 15:18:50 2002
+++ linux-2.5.32-vfscred/fs/hpfs/namei.c	Sat Aug 31 12:48:31 2002
@@ -77,11 +77,11 @@
 		result->i_ctime = result->i_mtime = result->i_atime = local_to_gmt(dir->i_sb, dee.creation_date);
 		hpfs_i(result)->i_ea_size = 0;
 		if (dee.read_only) result->i_mode &= ~0222;
-		if (result->i_uid != current->fsuid ||
-		    result->i_gid != current->fsgid ||
+		if (result->i_uid != current->vfscred->uid ||
+		    result->i_gid != current->vfscred->gid ||
 		    result->i_mode != (mode | S_IFDIR)) {
-			result->i_uid = current->fsuid;
-			result->i_gid = current->fsgid;
+			result->i_uid = current->vfscred->uid;
+			result->i_gid = current->vfscred->gid;
 			result->i_mode = mode | S_IFDIR;
 			hpfs_write_inode_nolock(result);
 		}
@@ -152,11 +152,11 @@
 			result->i_data.a_ops = &hpfs_aops;
 			hpfs_i(result)->mmu_private = 0;
 		}
-		if (result->i_uid != current->fsuid ||
-		    result->i_gid != current->fsgid ||
+		if (result->i_uid != current->vfscred->uid ||
+		    result->i_gid != current->vfscred->gid ||
 		    result->i_mode != (mode | S_IFREG)) {
-			result->i_uid = current->fsuid;
-			result->i_gid = current->fsgid;
+			result->i_uid = current->vfscred->uid;
+			result->i_gid = current->vfscred->gid;
 			result->i_mode = mode | S_IFREG;
 			hpfs_write_inode_nolock(result);
 		}
@@ -217,8 +217,8 @@
 		hpfs_i(result)->i_ea_size = 0;
 		/*if (result->i_blocks == -1) result->i_blocks = 1;
 		if (result->i_size == -1) result->i_size = 0;*/
-		result->i_uid = current->fsuid;
-		result->i_gid = current->fsgid;
+		result->i_uid = current->vfscred->uid;
+		result->i_gid = current->vfscred->gid;
 		result->i_nlink = 1;
 		result->i_size = 0;
 		result->i_blocks = 1;
@@ -288,8 +288,8 @@
 		/*if (result->i_blocks == -1) result->i_blocks = 1;
 		if (result->i_size == -1) result->i_size = 0;*/
 		result->i_mode = S_IFLNK | 0777;
-		result->i_uid = current->fsuid;
-		result->i_gid = current->fsgid;
+		result->i_uid = current->vfscred->uid;
+		result->i_gid = current->vfscred->gid;
 		result->i_blocks = 1;
 		result->i_size = strlen(symlink);
 		result->i_op = &page_symlink_inode_operations;
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/file.c linux-2.5.32-vfscred/fs/intermezzo/file.c
--- linux-2.5.32/fs/intermezzo/file.c	Mon May 20 15:36:08 2002
+++ linux-2.5.32-vfscred/fs/intermezzo/file.c	Sat Aug 31 12:48:35 2002
@@ -139,6 +139,7 @@
                 presto_set(file->f_dentry, PRESTO_ATTR | PRESTO_DATA);
 
         if (writable) { 
+		struct vfs_cred *cred;
                 PRESTO_ALLOC(fdata, struct presto_file_data *, sizeof(*fdata));
                 if (!fdata) {
                         EXIT;
@@ -146,15 +147,17 @@
                 }
                 /* we believe that on open the kernel lock
                    assures that only one process will do this allocation */ 
+		cred = get_current_vfscred();
                 fdata->fd_do_lml = 0;
-                fdata->fd_fsuid = current->fsuid;
-                fdata->fd_fsgid = current->fsgid;
+                fdata->fd_fsuid = cred->uid;
+                fdata->fd_fsgid = cred->gid;
                 fdata->fd_mode = file->f_dentry->d_inode->i_mode;
-                fdata->fd_ngroups = current->ngroups;
-                for (i=0 ; i<current->ngroups ; i++)
-                        fdata->fd_groups[i] = current->groups[i]; 
+                fdata->fd_ngroups = cred->ngroups;
+                for (i=0 ; i<cred->ngroups ; i++)
+                        fdata->fd_groups[i] = cred->groups[i]; 
                 fdata->fd_bytes_written = 0; /*when open,written data is zero*/ 
                 file->private_data = fdata; 
+		put_vfscred(cred);
         } else {
                 file->private_data = NULL;
         }
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/journal.c linux-2.5.32-vfscred/fs/intermezzo/journal.c
--- linux-2.5.32/fs/intermezzo/journal.c	Mon May 20 15:36:12 2002
+++ linux-2.5.32-vfscred/fs/intermezzo/journal.c	Sat Aug 31 12:48:35 2002
@@ -254,18 +254,22 @@
 static inline char *
 journal_log_prefix(char *buf, int opcode, struct rec_info *rec)
 {
+	struct vfs_cred *cred;
 	__u32 groups[NGROUPS_MAX]; 
 	int i; 
 
+	cred = get_current_vfscred();
 	/* convert 16 bit gid's to 32 bit gid's */
-	for (i=0; i<current->ngroups; i++) 
-		groups[i] = (__u32) current->groups[i];
+	for (i=0; i<cred->ngroups; i++) 
+		groups[i] = (__u32) cred->groups[i];
 	
-        return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
-                                                      (__u32)current->ngroups,
+        i =  journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
+                                                      (__u32)cred->ngroups,
 						      groups,
-                                                      (__u32)current->fsuid,
-                                                      (__u32)current->fsgid);
+                                                      (__u32)cred->uid,
+                                                      (__u32)cred->gid);
+	put_vfscred(cred);
+	return i;
 }
 
 static inline char *
@@ -274,8 +278,8 @@
 {
         return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
                                                       ngroups, groups,
-                                                      (__u32)current->fsuid,
-                                                      (__u32)current->fsgid);
+                                                      (__u32)current->vfscred->uid,
+                                                      (__u32)current->vfscred->gid);
 }
 
 static inline char *log_version(char *buf, struct dentry *dentry)
@@ -897,7 +901,7 @@
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
         ino = cpu_to_le64(dentry->d_inode->i_ino);
         generation = cpu_to_le32(dentry->d_inode->i_generation);
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + sizeof(*new_file_ver) +
                 sizeof(ino) + sizeof(generation) + sizeof(pathlen) +
                 sizeof(remote_ino) + sizeof(remote_generation) + 
@@ -1139,7 +1143,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + sizeof(*old_ver) +
                 sizeof(valid) + sizeof(mode) + sizeof(uid) + sizeof(gid) +
                 sizeof(fsize) + sizeof(mtime) + sizeof(ctime) + sizeof(flags) +
@@ -1220,7 +1224,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1282,7 +1286,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(targetlen) + sizeof(struct journal_suffix);
@@ -1345,7 +1349,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size = sizeof(__u32) * current->ngroups + 
+        size = sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1405,7 +1409,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(struct journal_suffix);
 
@@ -1472,7 +1476,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size = sizeof(__u32) * current->ngroups + 
+        size = sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(lmajor) +
                 sizeof(lminor) + sizeof(pathlen) +
@@ -1537,7 +1541,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path = presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1600,7 +1604,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path = presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 4 * sizeof(*src_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct journal_suffix);
@@ -1661,7 +1665,7 @@
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen = cpu_to_le32(MYPATHLEN(buffer, path));
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 3 * sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(struct journal_suffix);
 
@@ -1741,14 +1745,16 @@
                 open_fsuid = fd->fd_fsuid;
                 open_fsgid = fd->fd_fsgid;
         } else {
-                open_ngroups = current->ngroups;
-                for (i=0; i<current->ngroups; i++)
-			open_groups[i] =  (__u32) current->groups[i]; 
+		struct vfs_cred *cred = get_current_vfscred();
+                open_ngroups = cred->ngroups;
+                for (i=0; i<cred->ngroups; i++)
+			open_groups[i] =  (__u32) cred->groups[i]; 
                 open_mode = dentry->d_inode->i_mode;
                 open_uid = dentry->d_inode->i_uid;
                 open_gid = dentry->d_inode->i_gid;
-                open_fsuid = current->fsuid;
-                open_fsgid = current->fsgid;
+                open_fsuid = cred->uid;
+                open_fsgid = cred->gid;
+		put_vfscred(cred);
         }
         BUFF_ALLOC(buffer, NULL);
         path = presto_path(dentry, root, buffer, PAGE_SIZE);
@@ -2011,7 +2017,7 @@
          */
         mode=cpu_to_le32(dentry->d_inode->i_mode);
 
-        size =  sizeof(__u32) * current->ngroups + 
+        size =  sizeof(__u32) * current->vfscred->ngroups + 
                 sizeof(struct journal_prefix) + 
                 2 * sizeof(struct presto_version) +
                 sizeof(flags) + sizeof(mode) + sizeof(namelen) + 
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/kml_reint.c linux-2.5.32-vfscred/fs/intermezzo/kml_reint.c
--- linux-2.5.32/fs/intermezzo/kml_reint.c	Sat Mar  2 05:19:20 2002
+++ linux-2.5.32-vfscred/fs/intermezzo/kml_reint.c	Sat Aug 31 12:48:31 2002
@@ -27,18 +27,18 @@
 
 static void kmlreint_pre_secure (struct kml_rec *rec)
 {
-        if (current->fsuid != current->uid)
+        if (current->vfscred->uid != current->uid)
                 CDEBUG (D_KML, "reint_kmlreint_pre_secure: cannot setfsuid\n");
-        if (current->fsgid != current->gid)
+        if (current->vfscred->gid != current->gid)
                 CDEBUG (D_KML, "reint_kmlreint_pre_secure: cannot setfsgid\n");
-        current->fsuid = rec->rec_head.uid;
-        current->fsgid = rec->rec_head.fsgid;
+        setfsuid(rec->rec_head.uid);
+        setfsgid(rec->rec_head.fsgid);
 }
 
 static void kmlreint_post_secure (struct kml_rec *rec)
 {
-        current->fsuid = current->uid; 
-        current->fsgid = current->gid;
+        setfsuid(current->uid); 
+        setfsgid(current->gid);
         /* current->egid = current->gid; */ 
         /* ????????????? */
 }
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/upcall.c linux-2.5.32-vfscred/fs/intermezzo/upcall.c
--- linux-2.5.32/fs/intermezzo/upcall.c	Mon May 20 15:36:58 2002
+++ linux-2.5.32-vfscred/fs/intermezzo/upcall.c	Sat Aug 31 12:48:31 2002
@@ -63,7 +63,7 @@
         outp = (union down_args *) (inp);\
         inp->uh.opcode = (op);\
         inp->uh.pid = current->pid;\
-        inp->uh.uid = current->fsuid;\
+        inp->uh.uid = current->vfscred->uid;\
         outsize = insize;\
 } while (0)
 
diff -u --recursive --new-file linux-2.5.32/fs/intermezzo/vfs.c linux-2.5.32-vfscred/fs/intermezzo/vfs.c
--- linux-2.5.32/fs/intermezzo/vfs.c	Tue Jun 18 16:02:41 2002
+++ linux-2.5.32-vfscred/fs/intermezzo/vfs.c	Sat Aug 31 12:48:31 2002
@@ -70,9 +70,9 @@
 {
         if (!(dir->i_mode & S_ISVTX))
                 return 0;
-        if (inode->i_uid == current->fsuid)
+        if (inode->i_uid == current->vfscred->uid)
                 return 0;
-        if (dir->i_uid == current->fsuid)
+        if (dir->i_uid == current->vfscred->uid)
                 return 0;
         return !capable(CAP_FOWNER);
 }
diff -u --recursive --new-file linux-2.5.32/fs/jffs/inode-v23.c linux-2.5.32-vfscred/fs/jffs/inode-v23.c
--- linux-2.5.32/fs/jffs/inode-v23.c	Sat Jul 27 17:21:19 2002
+++ linux-2.5.32-vfscred/fs/jffs/inode-v23.c	Sat Aug 31 12:48:31 2002
@@ -479,8 +479,8 @@
 	raw_inode.pino = new_dir_f->ino;
 /*  	raw_inode.version = f->highest_version + 1; */
 	raw_inode.mode = f->mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = current->fsgid;
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = current->vfscred->gid;
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
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
+	/*	raw_inode.gid = current->vfscred->gid; */
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1026,8 +1026,8 @@
 	raw_inode.pino = del_f->pino;
 /*  	raw_inode.version = del_f->highest_version + 1; */
 	raw_inode.mode = del_f->mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = current->fsgid;
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = current->vfscred->gid;
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
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
+	/*	raw_inode.gid = current->vfscred->gid; */
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1212,8 +1212,8 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = S_IFLNK | S_IRWXUGO;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
@@ -1314,8 +1314,8 @@
 	raw_inode.pino = dir_f->ino;
 	raw_inode.version = 1;
 	raw_inode.mode = mode;
-	raw_inode.uid = current->fsuid;
-	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	raw_inode.uid = current->vfscred->uid;
+	raw_inode.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	raw_inode.atime = CURRENT_TIME;
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
diff -u --recursive --new-file linux-2.5.32/fs/jffs2/fs.c linux-2.5.32-vfscred/fs/jffs2/fs.c
--- linux-2.5.32/fs/jffs2/fs.c	Tue Jul 23 15:08:22 2002
+++ linux-2.5.32-vfscred/fs/jffs2/fs.c	Sat Aug 31 12:48:31 2002
@@ -229,14 +229,14 @@
 
 	memset(ri, 0, sizeof(*ri));
 	/* Set OS-specific defaults for new inodes */
-	ri->uid = current->fsuid;
+	ri->uid = current->vfscred->uid;
 
 	if (dir_i->i_mode & S_ISGID) {
 		ri->gid = dir_i->i_gid;
 		if (S_ISDIR(mode))
 			ri->mode |= S_ISGID;
 	} else {
-		ri->gid = current->fsgid;
+		ri->gid = current->vfscred->gid;
 	}
 	ri->mode = mode;
 	ret = jffs2_do_new_inode (c, f, mode, ri);
diff -u --recursive --new-file linux-2.5.32/fs/jfs/jfs_inode.c linux-2.5.32-vfscred/fs/jfs/jfs_inode.c
--- linux-2.5.32/fs/jfs/jfs_inode.c	Sun Aug  4 03:47:06 2002
+++ linux-2.5.32-vfscred/fs/jfs/jfs_inode.c	Sat Aug 31 12:48:31 2002
@@ -52,13 +52,13 @@
 		return NULL;
 	}
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	if (parent->i_mode & S_ISGID) {
 		inode->i_gid = parent->i_gid;
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 
 	inode->i_mode = mode;
 	if (S_ISDIR(mode))
diff -u --recursive --new-file linux-2.5.32/fs/lockd/host.c linux-2.5.32-vfscred/fs/lockd/host.c
--- linux-2.5.32/fs/lockd/host.c	Tue Feb  5 08:49:27 2002
+++ linux-2.5.32-vfscred/fs/lockd/host.c	Sat Aug 31 17:31:37 2002
@@ -187,14 +187,15 @@
 					host->h_nextrebind - jiffies);
 		}
 	} else {
-		uid_t saved_fsuid = current->fsuid;
+		struct vfs_cred *saved_cred = get_current_vfscred();
 		kernel_cap_t saved_cap = current->cap_effective;
 
 		/* Create RPC socket as root user so we get a priv port */
-		current->fsuid = 0;
+		setfsuid(0);
 		cap_raise (current->cap_effective, CAP_NET_BIND_SERVICE);
 		xprt = xprt_create_proto(host->h_proto, &host->h_addr, NULL);
-		current->fsuid = saved_fsuid;
+		set_current_vfscred(saved_cred);
+		put_vfscred(saved_cred);
 		current->cap_effective = saved_cap;
 		if (xprt == NULL)
 			goto forgetit;
diff -u --recursive --new-file linux-2.5.32/fs/locks.c linux-2.5.32-vfscred/fs/locks.c
--- linux-2.5.32/fs/locks.c	Wed Aug 21 17:29:29 2002
+++ linux-2.5.32-vfscred/fs/locks.c	Sat Aug 31 12:48:31 2002
@@ -1202,7 +1202,7 @@
 	dentry = filp->f_dentry;
 	inode = dentry->d_inode;
 
-	if ((current->fsuid != inode->i_uid) && !capable(CAP_LEASE))
+	if ((current->vfscred->uid != inode->i_uid) && !capable(CAP_LEASE))
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
diff -u --recursive --new-file linux-2.5.32/fs/minix/bitmap.c linux-2.5.32-vfscred/fs/minix/bitmap.c
--- linux-2.5.32/fs/minix/bitmap.c	Thu May 23 15:18:51 2002
+++ linux-2.5.32-vfscred/fs/minix/bitmap.c	Sat Aug 31 12:48:31 2002
@@ -247,8 +247,8 @@
 		iput(inode);
 		return NULL;
 	}
-	inode->i_uid = current->fsuid;
-	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	inode->i_uid = current->vfscred->uid;
+	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
diff -u --recursive --new-file linux-2.5.32/fs/namei.c linux-2.5.32-vfscred/fs/namei.c
--- linux-2.5.32/fs/namei.c	Mon Jul 22 23:20:31 2002
+++ linux-2.5.32-vfscred/fs/namei.c	Sat Aug 31 12:48:31 2002
@@ -174,7 +174,7 @@
 			return -EACCES;
 	}
 
-	if (current->fsuid == inode->i_uid)
+	if (current->vfscred->uid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
@@ -324,7 +324,7 @@
 	if ((inode->i_op && inode->i_op->permission))
 		return -EAGAIN;
 
-	if (current->fsuid == inode->i_uid)
+	if (current->vfscred->uid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
 		mode >>= 3;
@@ -983,9 +983,9 @@
 {
 	if (!(dir->i_mode & S_ISVTX))
 		return 0;
-	if (inode->i_uid == current->fsuid)
+	if (inode->i_uid == current->vfscred->uid)
 		return 0;
-	if (dir->i_uid == current->fsuid)
+	if (dir->i_uid == current->vfscred->uid)
 		return 0;
 	return !capable(CAP_FOWNER);
 }
diff -u --recursive --new-file linux-2.5.32/fs/nfsd/auth.c linux-2.5.32-vfscred/fs/nfsd/auth.c
--- linux-2.5.32/fs/nfsd/auth.c	Tue Feb  5 18:39:38 2002
+++ linux-2.5.32-vfscred/fs/nfsd/auth.c	Sat Aug 31 12:48:35 2002
@@ -35,20 +35,19 @@
 	}
 
 	if (cred->cr_uid != (uid_t) -1)
-		current->fsuid = cred->cr_uid;
+		setfsuid(cred->cr_uid);
 	else
-		current->fsuid = exp->ex_anon_uid;
+		setfsuid(exp->ex_anon_uid);
 	if (cred->cr_gid != (gid_t) -1)
-		current->fsgid = cred->cr_gid;
+		setfsgid(cred->cr_gid);
 	else
-		current->fsgid = exp->ex_anon_gid;
+		setfsgid(exp->ex_anon_gid);
 	for (i = 0; i < NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		current->groups[i] = group;
 	}
-	current->ngroups = i;
+	setgroups(i, cred->cr_groups);
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
diff -u --recursive --new-file linux-2.5.32/fs/nfsd/vfs.c linux-2.5.32-vfscred/fs/nfsd/vfs.c
--- linux-2.5.32/fs/nfsd/vfs.c	Thu Aug 29 22:27:25 2002
+++ linux-2.5.32-vfscred/fs/nfsd/vfs.c	Sat Aug 31 12:48:31 2002
@@ -1497,7 +1497,7 @@
 		IS_APPEND(inode)?	" append" : "",
 		IS_RDONLY(inode)?	" ro" : "");
 	dprintk("      owner %d/%d user %d/%d\n",
-		inode->i_uid, inode->i_gid, current->fsuid, current->fsgid);
+		inode->i_uid, inode->i_gid, current->vfscred->uid, current->vfscred->gid);
 #endif
 
 	/* only care about readonly exports for files and
@@ -1539,7 +1539,7 @@
 	 * with NFSv3.
 	 */
 	if ((acc & MAY_OWNER_OVERRIDE) &&
-	    inode->i_uid == current->fsuid)
+	    inode->i_uid == current->vfscred->uid)
 		return 0;
 
 	acc &= ~ MAY_OWNER_OVERRIDE; /* This bit is no longer needed,
diff -u --recursive --new-file linux-2.5.32/fs/open.c linux-2.5.32-vfscred/fs/open.c
--- linux-2.5.32/fs/open.c	Mon Jul 22 12:12:48 2002
+++ linux-2.5.32-vfscred/fs/open.c	Sat Aug 31 17:32:23 2002
@@ -259,7 +259,7 @@
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
-		if (current->fsuid != inode->i_uid &&
+		if (current->vfscred->uid != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
@@ -306,7 +306,7 @@
 		newattrs.ia_mtime = times[1].tv_sec;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
-		if (current->fsuid != inode->i_uid &&
+		if (current->vfscred->uid != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
@@ -327,19 +327,18 @@
 asmlinkage long sys_access(const char * filename, int mode)
 {
 	struct nameidata nd;
-	int old_fsuid, old_fsgid;
+	struct vfs_cred *old_cred;
 	kernel_cap_t old_cap;
 	int res;
 
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
-	old_fsuid = current->fsuid;
-	old_fsgid = current->fsgid;
+	old_cred = get_current_vfscred();
 	old_cap = current->cap_effective;
 
-	current->fsuid = current->uid;
-	current->fsgid = current->gid;
+	setfsuid(current->uid);
+	setfsgid(current->gid);
 
 	/*
 	 * Clear the capabilities if we switch to a non-root user
@@ -364,8 +363,8 @@
 		path_release(&nd);
 	}
 
-	current->fsuid = old_fsuid;
-	current->fsgid = old_fsgid;
+	set_current_vfscred(old_cred);
+	put_vfscred(old_cred);
 	current->cap_effective = old_cap;
 
 	return res;
diff -u --recursive --new-file linux-2.5.32/fs/pipe.c linux-2.5.32-vfscred/fs/pipe.c
--- linux-2.5.32/fs/pipe.c	Mon Jul 15 19:03:05 2002
+++ linux-2.5.32-vfscred/fs/pipe.c	Sat Aug 31 12:48:31 2002
@@ -564,8 +564,8 @@
 	 */
 	inode->i_state = I_DIRTY;
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
+	inode->i_uid = current->vfscred->uid;
+	inode->i_gid = current->vfscred->gid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blksize = PAGE_SIZE;
 	return inode;
diff -u --recursive --new-file linux-2.5.32/fs/proc/array.c linux-2.5.32-vfscred/fs/proc/array.c
--- linux-2.5.32/fs/proc/array.c	Thu Jul 25 03:36:09 2002
+++ linux-2.5.32-vfscred/fs/proc/array.c	Sat Aug 31 12:48:35 2002
@@ -148,9 +148,11 @@
 
 static inline char * task_state(struct task_struct *p, char *buffer)
 {
+	struct vfs_cred *cred;
 	int g;
 
 	read_lock(&tasklist_lock);
+	cred = get_task_vfscred(p);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
 		"Tgid:\t%d\n"
@@ -161,8 +163,8 @@
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p), p->tgid,
 		p->pid, p->pid ? p->real_parent->pid : 0, 0,
-		p->uid, p->euid, p->suid, p->fsuid,
-		p->gid, p->egid, p->sgid, p->fsgid);
+		p->uid, p->euid, p->suid, cred->uid,
+		p->gid, p->egid, p->sgid, cred->gid);
 	read_unlock(&tasklist_lock);	
 	task_lock(p);
 	buffer += sprintf(buffer,
@@ -171,10 +173,11 @@
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
-	for (g = 0; g < p->ngroups; g++)
-		buffer += sprintf(buffer, "%d ", p->groups[g]);
+	for (g = 0; g < cred->ngroups; g++)
+		buffer += sprintf(buffer, "%d ", cred->groups[g]);
 
 	buffer += sprintf(buffer, "\n");
+	put_vfscred(cred);
 	return buffer;
 }
 
diff -u --recursive --new-file linux-2.5.32/fs/proc/base.c linux-2.5.32-vfscred/fs/proc/base.c
--- linux-2.5.32/fs/proc/base.c	Tue Aug 13 01:20:00 2002
+++ linux-2.5.32-vfscred/fs/proc/base.c	Sat Aug 31 12:48:31 2002
@@ -526,7 +526,7 @@
 	/* We don't need a base pointer in the /proc filesystem */
 	path_release(nd);
 
-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	if (current->vfscred->uid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
 	error = proc_check_root(inode);
 	if (error)
@@ -568,7 +568,7 @@
 
 	lock_kernel();
 
-	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
+	if (current->vfscred->uid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
 	error = proc_check_root(inode);
 	if (error)
diff -u --recursive --new-file linux-2.5.32/fs/ramfs/inode.c linux-2.5.32-vfscred/fs/ramfs/inode.c
--- linux-2.5.32/fs/ramfs/inode.c	Sat Jul 27 17:21:19 2002
+++ linux-2.5.32-vfscred/fs/ramfs/inode.c	Sat Aug 31 12:48:31 2002
@@ -85,8 +85,8 @@
 
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current->vfscred->uid;
+		inode->i_gid = current->vfscred->gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
diff -u --recursive --new-file linux-2.5.32/fs/reiserfs/namei.c linux-2.5.32-vfscred/fs/reiserfs/namei.c
--- linux-2.5.32/fs/reiserfs/namei.c	Tue Aug  6 08:57:09 2002
+++ linux-2.5.32-vfscred/fs/reiserfs/namei.c	Sat Aug 31 12:48:31 2002
@@ -545,7 +545,7 @@
     /* the quota init calls have to know who to charge the quota to, so
     ** we have to set uid and gid here
     */
-    inode->i_uid = current->fsuid;
+    inode->i_uid = current->vfscred->uid;
     inode->i_mode = mode;
 
     if (dir->i_mode & S_ISGID) {
@@ -553,7 +553,7 @@
         if (S_ISDIR(mode))
             inode->i_mode |= S_ISGID;
     } else {
-        inode->i_gid = current->fsgid;
+        inode->i_gid = current->vfscred->gid;
     }
     return 0 ;
 }
diff -u --recursive --new-file linux-2.5.32/fs/sysv/ialloc.c linux-2.5.32-vfscred/fs/sysv/ialloc.c
--- linux-2.5.32/fs/sysv/ialloc.c	Thu May 23 15:18:57 2002
+++ linux-2.5.32-vfscred/fs/sysv/ialloc.c	Sat Aug 31 12:48:31 2002
@@ -165,9 +165,9 @@
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
diff -u --recursive --new-file linux-2.5.32/fs/udf/ialloc.c linux-2.5.32-vfscred/fs/udf/ialloc.c
--- linux-2.5.32/fs/udf/ialloc.c	Thu May 23 15:18:59 2002
+++ linux-2.5.32-vfscred/fs/udf/ialloc.c	Sat Aug 31 12:48:31 2002
@@ -118,7 +118,7 @@
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
 	}
 	inode->i_mode = mode;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	if (dir->i_mode & S_ISGID)
 	{
 		inode->i_gid = dir->i_gid;
@@ -126,7 +126,7 @@
 			mode |= S_ISGID;
 	}
 	else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 
 	UDF_I_LOCATION(inode).logicalBlockNum = block;
 	UDF_I_LOCATION(inode).partitionReferenceNum = UDF_I_LOCATION(dir).partitionReferenceNum;
diff -u --recursive --new-file linux-2.5.32/fs/udf/namei.c linux-2.5.32-vfscred/fs/udf/namei.c
--- linux-2.5.32/fs/udf/namei.c	Thu May 23 15:19:00 2002
+++ linux-2.5.32-vfscred/fs/udf/namei.c	Sat Aug 31 12:48:31 2002
@@ -687,7 +687,7 @@
 	if (!inode)
 		goto out;
 
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	init_special_inode(inode, mode, rdev);
 	if (!(fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err)))
 	{
diff -u --recursive --new-file linux-2.5.32/fs/ufs/ialloc.c linux-2.5.32-vfscred/fs/ufs/ialloc.c
--- linux-2.5.32/fs/ufs/ialloc.c	Tue Aug 20 14:25:37 2002
+++ linux-2.5.32-vfscred/fs/ufs/ialloc.c	Sat Aug 31 12:48:31 2002
@@ -254,13 +254,13 @@
 	sb->s_dirt = 1;
 
 	inode->i_mode = mode;
-	inode->i_uid = current->fsuid;
+	inode->i_uid = current->vfscred->uid;
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 		if (S_ISDIR(mode))
 			inode->i_mode |= S_ISGID;
 	} else
-		inode->i_gid = current->fsgid;
+		inode->i_gid = current->vfscred->gid;
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
diff -u --recursive --new-file linux-2.5.32/fs/umsdos/namei.c linux-2.5.32-vfscred/fs/umsdos/namei.c
--- linux-2.5.32/fs/umsdos/namei.c	Sat Jun  1 03:18:10 2002
+++ linux-2.5.32-vfscred/fs/umsdos/namei.c	Sat Aug 31 12:48:31 2002
@@ -255,8 +255,8 @@
 	info.entry.mode = mode;
 	info.entry.rdev = rdev;
 	info.entry.flags = flags;
-	info.entry.uid = current->fsuid;
-	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	info.entry.uid = current->vfscred->uid;
+	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	info.entry.ctime = info.entry.atime = info.entry.mtime = CURRENT_TIME;
 	info.entry.nlink = 1;
 	ret = umsdos_newentry (dentry->d_parent, &info);
@@ -779,8 +779,8 @@
 
 	info.entry.mode = mode | S_IFDIR;
 	info.entry.rdev = 0;
-	info.entry.uid = current->fsuid;
-	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
+	info.entry.uid = current->vfscred->uid;
+	info.entry.gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->vfscred->gid;
 	info.entry.ctime = info.entry.atime = info.entry.mtime = CURRENT_TIME;
 	info.entry.flags = 0;
 	info.entry.nlink = 1;
diff -u --recursive --new-file linux-2.5.32/include/linux/cred.h linux-2.5.32-vfscred/include/linux/cred.h
--- linux-2.5.32/include/linux/cred.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.32-vfscred/include/linux/cred.h	Sat Aug 31 16:35:12 2002
@@ -0,0 +1,88 @@
+#ifndef _LINUX_CRED_H
+#define _LINUX_CRED_H
+
+#ifdef __KERNEL__
+
+#include <linux/param.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+/*
+ * VFS credentials
+ *
+ * This is for use by filesystems, sockets, RPC for user authentication
+ * purposes. It is a direct replacement for the 2.4.x task entries
+ * fsuid/fsgid + groups[].
+ *
+ * The VFS credential may be shared among different threads, interrupts,...
+ * without any fancy locking mechanisms provided one sticks to using
+ * copy on write semantics. The latter is a guarantee that if more than
+ * one object is referencing the vfscred, then the data in the struct will
+ * not change.
+ *
+ * This again means that the recipe for changing one or more of fsuid,
+ * fsgid, ...  for the current thread will usually be as follows:
+ *  1) copy the existing vfscred into a new one using clone_current_vfscred()
+ *  2) make all the necessary changes to the clone
+ *  3) use set_current_vfscred() in order to register the change to the
+ *     task_struct
+ *
+ */
+struct vfs_cred {
+	atomic_t	count;
+
+	uid_t		uid;
+	gid_t		gid;
+
+	int		ngroups;
+	gid_t		*groups;
+	/* Default storage for groups */
+	gid_t		__group_storage[NGROUPS];
+};
+
+#define NOGID ((gid_t)-1)
+#define NOUID ((uid_t)-1)
+
+extern struct vfs_cred init_vfscred;
+extern void credentials_init(void);
+
+extern void put_vfscred(struct vfs_cred *);
+extern struct vfs_cred *vfscred_create(uid_t, gid_t);
+extern struct vfs_cred *vfscred_clone(struct vfs_cred *);
+extern int vfscred_getgroups(struct vfs_cred *, int, gid_t *);
+extern int vfscred_setgroups(struct vfs_cred *, int, gid_t *);
+extern int vfscred_match_group(struct vfs_cred *, gid_t);
+
+static inline struct vfs_cred *get_vfscred(struct vfs_cred *cred)
+{
+	atomic_inc(&cred->count);
+	return cred;
+}
+
+static inline int vfscred_count(struct vfs_cred *cred)
+{
+	return atomic_read(&cred->count);
+}
+
+#define get_current_vfscred()	get_vfscred(current->vfscred)
+
+extern struct vfs_cred *clone_current_vfscred(void);
+extern void set_current_vfscred(struct vfs_cred *);
+extern int setfsuid(uid_t);
+extern int setfsgid(gid_t);
+extern int setgroups(int, gid_t *);
+extern int getgroups(int, gid_t *);
+
+extern struct vfs_cred *get_task_vfscred(struct task_struct *);
+extern void set_task_vfscred(struct task_struct *, struct vfs_cred *);
+
+/* Grrr: Support for oddball functions in security/dummy.c */
+extern int task_setfsuid(struct task_struct *, uid_t);
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+extern int setgroups16(int, gid16_t *);
+extern int getgroups16(int, gid16_t *);
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CRED_H */
diff -u --recursive --new-file linux-2.5.32/include/linux/init_task.h linux-2.5.32-vfscred/include/linux/init_task.h
--- linux-2.5.32/include/linux/init_task.h	Mon Aug 19 20:12:27 2002
+++ linux-2.5.32-vfscred/include/linux/init_task.h	Sat Aug 31 13:07:13 2002
@@ -65,6 +65,7 @@
 	.real_timer	= {						\
 		.function	= it_real_fn				\
 	},								\
+	.vfscred	= &init_vfscred,				\
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
diff -u --recursive --new-file linux-2.5.32/include/linux/sched.h linux-2.5.32-vfscred/include/linux/sched.h
--- linux-2.5.32/include/linux/sched.h	Fri Aug 30 11:17:44 2002
+++ linux-2.5.32-vfscred/include/linux/sched.h	Sat Aug 31 12:49:13 2002
@@ -27,6 +27,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/cred.h>
 
 struct exec_domain;
 
@@ -327,10 +328,9 @@
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
 /* process credentials */
-	uid_t uid,euid,suid,fsuid;
-	gid_t gid,egid,sgid,fsgid;
-	int ngroups;
-	gid_t	groups[NGROUPS];
+	uid_t uid,euid,suid;
+	gid_t gid,egid,sgid;
+	struct vfs_cred *vfscred;
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	int keep_capabilities:1;
 	struct user_struct *user;
diff -u --recursive --new-file linux-2.5.32/init/main.c linux-2.5.32-vfscred/init/main.c
--- linux-2.5.32/init/main.c	Wed Aug 28 09:54:46 2002
+++ linux-2.5.32-vfscred/init/main.c	Sat Aug 31 12:48:35 2002
@@ -438,6 +438,7 @@
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
 	pte_chain_init();
+	credentials_init();
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
diff -u --recursive --new-file linux-2.5.32/kernel/Makefile linux-2.5.32-vfscred/kernel/Makefile
--- linux-2.5.32/kernel/Makefile	Sat Jul 27 16:14:38 2002
+++ linux-2.5.32-vfscred/kernel/Makefile	Sat Aug 31 12:48:35 2002
@@ -10,12 +10,13 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o cred.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    cred.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -u --recursive --new-file linux-2.5.32/kernel/cred.c linux-2.5.32-vfscred/kernel/cred.c
--- linux-2.5.32/kernel/cred.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.32-vfscred/kernel/cred.c	Sat Aug 31 17:14:02 2002
@@ -0,0 +1,468 @@
+/*
+ * linux/kernel/cred.c
+ *
+ * Copyright (c) 2001 Trond Myklebust <trond.myklebust@fys.uio.no>
+ *
+ * 'cred.c' contains the helper routines for managing task_cred
+ * and vfs_cred structures.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+
+/*
+ * Creds for the init task
+ */
+struct vfs_cred init_vfscred = { 
+	.count		= ATOMIC_INIT(2),
+	/* .uid		= (uid_t)0, */
+	/* .gid		= (gid_t)0, */
+	/* .ngroups	= 0, */
+	.groups		= init_vfscred.__group_storage,
+};
+
+rwlock_t task_credlock = RW_LOCK_UNLOCKED;
+
+static kmem_cache_t	*vfscred_cache;
+
+void __init credentials_init(void)
+{
+	vfscred_cache = kmem_cache_create("vfs_cred",
+				       sizeof(struct vfs_cred),
+				       0,
+				       SLAB_HWCACHE_ALIGN,
+				       NULL, NULL);
+	if (!vfscred_cache)
+		panic("Cannot create vfs credential SLAB cache");
+}
+
+static inline struct vfs_cred *vfscred_alloc(int gfp)
+{
+	struct vfs_cred *cred;
+	cred = (struct vfs_cred *)kmem_cache_alloc(vfscred_cache, gfp);
+	if (cred) {
+		atomic_set(&cred->count, 1);
+		cred->groups = cred->__group_storage;
+	}
+	return cred;
+}
+
+static inline void vfscred_freegroups(struct vfs_cred *cred)
+{
+	if (cred->groups != cred->__group_storage)
+		kfree(cred->groups);
+}
+
+static int vfscred_growgroups(struct vfs_cred *cred, int ngrp)
+{
+	gid_t *buf;
+	int err;
+
+	buf = cred->__group_storage;
+	if (ngrp <= ARRAY_SIZE(cred->__group_storage))
+		goto out;
+	err = -ENOMEM;
+	buf = (gid_t *)kmalloc(ngrp * sizeof(gid_t), GFP_KERNEL);
+	if (!buf)
+		goto out_err;
+out:
+	vfscred_freegroups(cred);
+	cred->groups = buf;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * put_vfscred - Release a user credential
+ * @cred: pointer to vfs_cred
+ */
+void put_vfscred(struct vfs_cred *cred)
+{
+	if (atomic_dec_and_test(&cred->count)) {
+		vfscred_freegroups(cred);
+		kmem_cache_free(vfscred_cache, cred);
+	}
+}
+
+/**
+ * vfscred_create - allocate and initialize a new user credential
+ * @uid:
+ * @gid:
+ */
+struct vfs_cred *vfscred_create(uid_t uid, gid_t gid)
+{
+	struct vfs_cred *cred;
+
+	if (!(cred = vfscred_alloc(SLAB_KERNEL)))
+		return NULL;
+	cred->uid = uid;
+	cred->gid = gid;
+	cred->ngroups = 0;
+	return cred;
+}
+
+/**
+ * vfscred_setgroups - set the supplemental group membership in a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public vfscred, please ensure that you copy it first...
+ */
+int vfscred_setgroups(struct vfs_cred *cred, int ngrp, gid_t *src)
+{
+	int err;
+
+	err = -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err = vfscred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	memcpy(cred->groups, src, ngrp * sizeof(gid_t));
+	cred->ngroups = ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * vfscred_getgroups - return the supplemental groups from a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+int vfscred_getgroups(struct vfs_cred *cred, int ngrp, gid_t *dst)
+{
+	if (ngrp > cred->ngroups)
+		ngrp = cred->ngroups;
+	memcpy(dst, cred->groups, ngrp * sizeof(gid_t));
+	return cred->ngroups;
+}
+
+/**
+ * vfscred_match_group - match a gid to a vfs_cred's supplemental groups
+ * @cred: pointer to vfs_cred
+ * @gid: gid to match
+ */
+int vfscred_match_group(struct vfs_cred *cred, gid_t gid)
+{
+	gid_t *p = cred->groups;
+	int i;
+
+	for (i = cred->ngroups; i != 0 ; i--) {
+		if (gid == *p++)
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * vfscred_clone - duplicate a user credential
+ * @cred: pointer to vfs_cred
+ *
+ * Allocate a new user credential, and copy the entries in cred.
+ */
+struct vfs_cred *vfscred_clone(struct vfs_cred *cred)
+{
+	struct vfs_cred *new;
+	int err;
+
+	new = vfscred_create(cred->uid, cred->gid);
+	if (!new)
+		goto out_nomem;
+	err = vfscred_setgroups(new, cred->ngroups, cred->groups);
+	if (err)
+		goto out_free;
+	return new;
+out_free:
+	put_vfscred(new);
+out_nomem:
+	return NULL;
+}
+
+/**
+ * get_task_vfscred - return a reference to a task's user credentials
+ * @tsk:  pointer to task
+ *
+ * Note: the rwlock is needed in order to protect against /proc
+ * 	 grabbing a reference while the task itself is changing
+ *	 the vfscred.
+ *	 Once CLONE_CRED is introduced it may get worse...
+ */
+struct vfs_cred *get_task_vfscred(struct task_struct *tsk)
+{
+	struct vfs_cred *cred;
+
+	read_lock(&task_credlock);
+	cred = get_vfscred(tsk->vfscred);
+	read_unlock(&task_credlock);
+	return cred;
+}
+
+/**
+ * set_task_vfscred - replace a task's user credentials
+ * @tsk:  pointer to task
+ * @cred: pointer to vfs_cred
+ *
+ * Note: This function does not check capabilities etc.
+ */
+void set_task_vfscred(struct task_struct *tsk, struct vfs_cred *cred)
+{
+	struct vfs_cred *old;
+
+	if (tsk->vfscred == cred)
+		return;
+	write_lock(&task_credlock);
+	old = xchg(&tsk->vfscred, get_vfscred(cred));
+	write_unlock(&task_credlock);
+	if (old)
+		put_vfscred(old);
+}
+
+/**
+ * set_current_vfscred - replace the current task's user credentials
+ * @cred: pointer to vfs_cred
+ */
+void set_current_vfscred(struct vfs_cred *cred)
+{
+	set_task_vfscred(current, cred);
+}
+
+/**
+ * clone_current_vfscred - Clone the current task's vfs_cred
+ */
+struct vfs_cred *clone_current_vfscred(void)
+{
+	struct vfs_cred *cred, *new;
+
+	cred = get_current_vfscred();
+	new = vfscred_clone(cred);
+	put_vfscred(cred);
+	return new;
+}
+
+/*
+ * copy_write_task_vfscred - Conditionally clone a task's vfs_cred.
+ * @tsk: pointer to task
+ *
+ * Clones the task's vfscred if its reference count is > 1, else
+ * just take a reference.
+ * Use this in order to ensure that you are free to write to the
+ * vfscred.
+ *
+ */
+static struct vfs_cred *copy_write_task_vfscred(struct task_struct *tsk)
+{
+	struct vfs_cred *cred;
+
+	cred = get_task_vfscred(tsk);
+	if (vfscred_count(cred) > 2) {
+		struct vfs_cred *new;
+		new = vfscred_clone(cred);
+		put_vfscred(cred);
+		return new;
+	}
+	return cred;
+}
+
+/**
+ * setfsuid - set the current task's vfscred->uid
+ * @uid:  new fsuid
+ */
+int setfsuid(uid_t uid)
+{
+	struct vfs_cred *cred;
+
+	if (uid == current->vfscred->uid)
+		goto out;
+	cred = copy_write_task_vfscred(current);
+	if (!cred)
+		return -ENOMEM;
+	cred->uid = uid;
+	set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return 0;
+}
+
+/**
+ * setfsgid - set the current task's vfscred->gid
+ * @gid:  new fsgid
+ */
+int setfsgid(gid_t gid)
+{
+	struct vfs_cred *cred;
+
+	if (gid == current->vfscred->gid)
+		goto out;
+	cred = copy_write_task_vfscred(current);
+	if (!cred)
+		return -ENOMEM;
+	cred->gid = gid;
+	set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return 0;
+}
+
+/**
+ * setgroups - set the current task's group list
+ * @ngrp: number of gids to copy
+ * @src: pointer to gids
+ */
+int setgroups(int ngrp, gid_t *src)
+{
+	struct vfs_cred *cred;
+	int ret = -ENOMEM;
+
+	cred = copy_write_task_vfscred(current);
+	if (!cred)
+		goto out;
+	ret = vfscred_setgroups(cred, ngrp, src);
+	if (!ret)
+		set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return ret;
+}
+
+/**
+ * getgroups - return the current task's group list
+ * @ngrp: number of gids to copy
+ * @dst: pointer to dest buffer
+ */
+int getgroups(int ngrp, gid_t *dst)
+{
+	struct vfs_cred *cred;
+	int ret;
+
+	cred = get_current_vfscred();
+	ret = vfscred_getgroups(cred, ngrp, dst);
+	put_vfscred(cred);
+	return ret;
+}
+
+/**
+ * task_setfsuid - set the current task's vfscred uid
+ * @uid:  new fsuid
+ *
+ * Doing this for tasks other than 'current' is usually unsafe,
+ * so use of this function is deprecated.
+ */
+int task_setfsuid(struct task_struct *tsk, uid_t uid)
+{
+	struct vfs_cred *cred;
+
+	cred = copy_write_task_vfscred(tsk);
+	if (!cred)
+		return -ENOMEM;
+	cred->uid = uid;
+	set_task_vfscred(tsk, cred);
+	put_vfscred(cred);
+	return 0;
+}
+
+#if defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X)
+/*
+ * vfscred_setgroups16 - set the supplemental group membership in a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of 16-bit gids to copy
+ * @src: pointer to gids
+ *
+ * Note: this function does not COW. If you want to set the groups on
+ *       a public vfscred, please ensure that you copy it first...
+ */
+static int vfscred_setgroups16(struct vfs_cred *cred, int ngrp, gid16_t *src)
+{
+	gid_t *dst;
+	int i, err;
+
+	err = -EINVAL;
+	if (ngrp < 0)
+		goto out_err;
+	err = vfscred_growgroups(cred, ngrp);
+	if (err)
+		goto out_err;
+	dst = cred->groups;
+	for (i = ngrp; i != 0; i--)
+		*dst++ = (gid_t)*src++;
+	cred->ngroups = ngrp;
+	return 0;
+out_err:
+	return err;
+}
+
+/**
+ * vfscred_getgroups16 - return the supplemental groups from a vfs_cred
+ * @cred: pointer to vfs_cred
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ *
+ */
+static int vfscred_getgroups16(struct vfs_cred *cred, int ngrp, gid16_t *dst)
+{
+	gid_t *src = cred->groups;
+	int i;
+	if (ngrp > cred->ngroups)
+		ngrp = cred->ngroups;
+	for (i = ngrp; i != 0; i--)
+		*dst++ = (gid16_t)*src++;
+	return cred->ngroups;
+}
+
+/**
+ * setgroups16 - set the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @src:  pointer to 16-bit gids
+ */
+int setgroups16(int ngrp, gid16_t *src)
+{
+	struct vfs_cred *cred;
+	int ret = -ENOMEM;
+
+	cred = copy_write_task_vfscred(current);
+	if (!cred)
+		goto out;
+	ret = vfscred_setgroups16(cred, ngrp, src);
+	if (!ret)
+		set_current_vfscred(cred);
+	put_vfscred(cred);
+out:
+	return ret;
+}
+
+/**
+ * getgroups16 - return the current task's group list
+ * @ngrp: number of 16-bit gids to copy
+ * @dst: pointer to dest buffer
+ */
+int getgroups16(int ngrp, gid16_t *dst)
+{
+	struct vfs_cred *cred;
+	int ret;
+
+	cred = get_current_vfscred();
+	ret = vfscred_getgroups16(cred, ngrp, dst);
+	put_vfscred(cred);
+	return ret;
+}
+
+#endif /* defined(CONFIG_SPARC64) || defined(CONFIG_ARCH_S390X) */
+
+EXPORT_SYMBOL(put_vfscred);
+EXPORT_SYMBOL(vfscred_getgroups);
+EXPORT_SYMBOL(setfsuid);
+EXPORT_SYMBOL(setfsgid);
+EXPORT_SYMBOL(setgroups);
+EXPORT_SYMBOL(getgroups);
+EXPORT_SYMBOL(set_current_vfscred);
diff -u --recursive --new-file linux-2.5.32/kernel/fork.c linux-2.5.32-vfscred/kernel/fork.c
--- linux-2.5.32/kernel/fork.c	Fri Aug 30 11:18:58 2002
+++ linux-2.5.32-vfscred/kernel/fork.c	Sat Aug 31 12:48:35 2002
@@ -62,6 +62,7 @@
 void __put_task_struct(struct task_struct *tsk)
 {
 	if (tsk != current) {
+		put_vfscred(tsk->vfscred);
 		free_thread_info(tsk->thread_info);
 		kmem_cache_free(task_struct_cachep,tsk);
 	} else {
@@ -69,6 +70,7 @@
 
 		tsk = task_cache[cpu];
 		if (tsk) {
+			put_vfscred(tsk->vfscred);
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
@@ -146,6 +148,7 @@
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
+	tsk->vfscred = get_task_vfscred(orig);
 	atomic_set(&tsk->usage,1);
 
 	return tsk;
@@ -502,6 +505,18 @@
 	return i;
 }
 
+/* For the moment, we never share credentials between processes */
+static int copy_cred(unsigned long clone_flags, struct task_struct * tsk)
+{
+	struct vfs_cred *cred;
+	cred = clone_current_vfscred();
+	if (!cred)
+		return -ENOMEM;
+	set_task_vfscred(tsk, cred);
+	put_vfscred(cred);
+	return 0;
+}
+
 static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct files_struct *oldf, *newf;
@@ -672,6 +687,8 @@
 		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
 			goto bad_fork_free;
 	}
+	if (copy_cred(clone_flags, p))
+		goto bad_fork_free;
 
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);
diff -u --recursive --new-file linux-2.5.32/kernel/kmod.c linux-2.5.32-vfscred/kernel/kmod.c
--- linux-2.5.32/kernel/kmod.c	Fri Aug 16 03:25:31 2002
+++ linux-2.5.32-vfscred/kernel/kmod.c	Sat Aug 31 12:48:35 2002
@@ -132,8 +132,10 @@
 	}
 
 	/* Give kmod all effective privileges.. */
-	curtask->euid = curtask->fsuid = 0;
-	curtask->egid = curtask->fsgid = 0;
+	curtask->euid = 0;
+	curtask->egid = 0;
+	setfsuid(0);
+	setfsgid(0);
 	security_ops->task_kmod_set_label();
 
 	/* Allow execve args to be in kernel space. */
diff -u --recursive --new-file linux-2.5.32/kernel/sys.c linux-2.5.32-vfscred/kernel/sys.c
--- linux-2.5.32/kernel/sys.c	Fri Aug 16 06:33:01 2002
+++ linux-2.5.32-vfscred/kernel/sys.c	Sat Aug 31 13:40:01 2002
@@ -468,7 +468,7 @@
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && egid != old_rgid))
 		current->sgid = new_egid;
-	current->fsgid = new_egid;
+	setfsgid(new_egid);
 	current->egid = new_egid;
 	current->gid = new_rgid;
 	return 0;
@@ -495,7 +495,8 @@
 			current->mm->dumpable=0;
 			wmb();
 		}
-		current->gid = current->egid = current->sgid = current->fsgid = gid;
+		current->gid = current->egid = current->sgid = gid;
+		setfsgid(gid);
 	}
 	else if ((gid == current->gid) || (gid == current->sgid))
 	{
@@ -504,7 +505,8 @@
 			current->mm->dumpable=0;
 			wmb();
 		}
-		current->egid = current->fsgid = gid;
+		current->egid = gid;
+		setfsgid(gid);
 	}
 	else
 		return -EPERM;
@@ -591,11 +593,11 @@
 		current->mm->dumpable=0;
 		wmb();
 	}
-	current->fsuid = current->euid = new_euid;
+	current->euid = new_euid;
+	setfsuid(new_euid);
 	if (ruid != (uid_t) -1 ||
 	    (euid != (uid_t) -1 && euid != old_ruid))
 		current->suid = current->euid;
-	current->fsuid = current->euid;
 
 	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
@@ -639,7 +641,8 @@
 		current->mm->dumpable = 0;
 		wmb();
 	}
-	current->fsuid = current->euid = uid;
+	current->euid = uid;
+	setfsuid(uid);
 	current->suid = new_suid;
 
 	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
@@ -684,7 +687,7 @@
 		}
 		current->euid = euid;
 	}
-	current->fsuid = current->euid;
+	setfsuid(current->euid);
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
@@ -732,7 +735,7 @@
 		}
 		current->egid = egid;
 	}
-	current->fsgid = current->egid;
+	setfsgid(current->egid);
 	if (rgid != (gid_t) -1)
 		current->gid = rgid;
 	if (sgid != (gid_t) -1)
@@ -767,9 +770,9 @@
 	if (retval)
 		return retval;
 
-	old_fsuid = current->fsuid;
+	old_fsuid = current->vfscred->uid;
 	if (uid == current->uid || uid == current->euid ||
-	    uid == current->suid || uid == current->fsuid || 
+	    uid == current->suid || uid == current->vfscred->uid || 
 	    capable(CAP_SETUID))
 	{
 		if (uid != old_fsuid)
@@ -777,7 +780,7 @@
 			current->mm->dumpable = 0;
 			wmb();
 		}
-		current->fsuid = uid;
+		setfsuid(uid);
 	}
 
 	retval = security_ops->task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
@@ -799,9 +802,9 @@
 	if (retval)
 		return retval;
 
-	old_fsgid = current->fsgid;
+	old_fsgid = current->vfscred->gid;
 	if (gid == current->gid || gid == current->egid ||
-	    gid == current->sgid || gid == current->fsgid || 
+	    gid == current->sgid || gid == current->vfscred->gid || 
 	    capable(CAP_SETGID))
 	{
 		if (gid != old_fsgid)
@@ -809,7 +812,7 @@
 			current->mm->dumpable = 0;
 			wmb();
 		}
-		current->fsgid = gid;
+		setfsgid(gid);
 	}
 	return old_fsgid;
 }
@@ -980,6 +983,7 @@
  */
 asmlinkage long sys_getgroups(int gidsetsize, gid_t *grouplist)
 {
+	gid_t groups[NGROUPS];
 	int i;
 	
 	/*
@@ -989,11 +993,11 @@
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = getgroups(NGROUPS, groups);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
-		if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
+		if (copy_to_user(grouplist, groups, sizeof(gid_t)*i))
 			return -EFAULT;
 	}
 	return i;
@@ -1018,25 +1022,18 @@
 	retval = security_ops->task_setgroups(gidsetsize, groups);
 	if (retval)
 		return retval;
-	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	return setgroups(gidsetsize, groups);
 }
 
 static int supplemental_group_member(gid_t grp)
 {
-	int i = current->ngroups;
+	struct vfs_cred *cred;
+	int retval;
 
-	if (i) {
-		gid_t *groups = current->groups;
-		do {
-			if (*groups == grp)
-				return 1;
-			groups++;
-			i--;
-		} while (i);
-	}
-	return 0;
+	cred = get_current_vfscred();
+	retval = vfscred_match_group(cred, grp);
+	put_vfscred(cred);
+	return retval;
 }
 
 /*
@@ -1044,9 +1041,13 @@
  */
 int in_group_p(gid_t grp)
 {
+	struct vfs_cred *cred;
 	int retval = 1;
-	if (grp != current->fsgid)
-		retval = supplemental_group_member(grp);
+
+	cred = get_current_vfscred();
+	if (grp != cred->gid)
+		retval = vfscred_match_group(cred, grp);
+	put_vfscred(cred);
 	return retval;
 }
 
diff -u --recursive --new-file linux-2.5.32/kernel/uid16.c linux-2.5.32-vfscred/kernel/uid16.c
--- linux-2.5.32/kernel/uid16.c	Sat Jul 20 01:00:55 2002
+++ linux-2.5.32-vfscred/kernel/uid16.c	Sat Aug 31 12:48:35 2002
@@ -109,17 +109,18 @@
 
 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t *grouplist)
 {
+	gid_t gids[NGROUPS];
 	old_gid_t groups[NGROUPS];
 	int i,j;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
-	i = current->ngroups;
+	i = getgroups(NGROUPS, gids);
 	if (gidsetsize) {
 		if (i > gidsetsize)
 			return -EINVAL;
 		for(j=0;j<i;j++)
-			groups[j] = current->groups[j];
+			groups[j] = gids[j];
 		if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
 			return -EFAULT;
 	}
@@ -143,9 +144,7 @@
 	i = security_ops->task_setgroups(gidsetsize, new_groups);
 	if (i)
 		return i;
-	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
-	current->ngroups = gidsetsize;
-	return 0;
+	return setgroups(gidsetsize, new_groups);
 }
 
 asmlinkage long sys_getuid16(void)
diff -u --recursive --new-file linux-2.5.32/mm/shmem.c linux-2.5.32-vfscred/mm/shmem.c
--- linux-2.5.32/mm/shmem.c	Wed Aug 14 03:09:12 2002
+++ linux-2.5.32-vfscred/mm/shmem.c	Sat Aug 31 12:48:31 2002
@@ -783,8 +783,8 @@
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_mode = mode;
-		inode->i_uid = current->fsuid;
-		inode->i_gid = current->fsgid;
+		inode->i_uid = current->vfscred->uid;
+		inode->i_gid = current->vfscred->gid;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
@@ -1408,8 +1408,8 @@
 	struct dentry * root;
 	unsigned long blocks, inodes;
 	int mode   = S_IRWXUGO | S_ISVTX;
-	uid_t uid = current->fsuid;
-	gid_t gid = current->fsgid;
+	uid_t uid = current->vfscred->uid;
+	gid_t gid = current->vfscred->gid;
 	struct shmem_sb_info *sbinfo;
 	struct sysinfo si;
 	int err;
diff -u --recursive --new-file linux-2.5.32/net/socket.c linux-2.5.32-vfscred/net/socket.c
--- linux-2.5.32/net/socket.c	Mon Aug 19 14:08:46 2002
+++ linux-2.5.32-vfscred/net/socket.c	Sat Aug 31 12:48:31 2002
@@ -470,8 +470,8 @@
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
 	inode->i_sock = 1;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
+	inode->i_uid = current->vfscred->uid;
+	inode->i_gid = current->vfscred->gid;
 
 	sockets_in_use[smp_processor_id()].counter++;
 	return sock;
diff -u --recursive --new-file linux-2.5.32/net/sunrpc/auth_unix.c linux-2.5.32-vfscred/net/sunrpc/auth_unix.c
--- linux-2.5.32/net/sunrpc/auth_unix.c	Tue Feb  5 16:23:07 2002
+++ linux-2.5.32-vfscred/net/sunrpc/auth_unix.c	Sat Aug 31 13:14:34 2002
@@ -80,16 +80,11 @@
 		cred->uc_gid = cred->uc_fsgid = 0;
 		cred->uc_gids[0] = NOGROUP;
 	} else {
-		int groups = current->ngroups;
-		if (groups > NFS_NGROUPS)
-			groups = NFS_NGROUPS;
-
 		cred->uc_uid = current->uid;
 		cred->uc_gid = current->gid;
-		cred->uc_fsuid = current->fsuid;
-		cred->uc_fsgid = current->fsgid;
-		for (i = 0; i < groups; i++)
-			cred->uc_gids[i] = (gid_t) current->groups[i];
+		cred->uc_fsuid = current->vfscred->uid;
+		cred->uc_fsgid = current->vfscred->gid;
+		i = getgroups(NFS_NGROUPS, cred->uc_gids);
 		if (i < NFS_NGROUPS)
 		  cred->uc_gids[i] = NOGROUP;
 	}
@@ -135,28 +130,34 @@
 unx_match(struct rpc_cred *rcred, int taskflags)
 {
 	struct unx_cred	*cred = (struct unx_cred *) rcred;
-	int		i;
+	struct vfs_cred *vfscred;
+	int groups, res = 1;
 
-	if (!(taskflags & RPC_TASK_ROOTCREDS)) {
-		int groups;
+	if ((taskflags & RPC_TASK_ROOTCREDS)) {
+		return (cred->uc_uid == 0 && cred->uc_fsuid == 0
+		     && cred->uc_gid == 0 && cred->uc_fsgid == 0
+		     && cred->uc_gids[0] == (gid_t) NOGROUP);
+	}
 
-		if (cred->uc_uid != current->uid
-		 || cred->uc_gid != current->gid
-		 || cred->uc_fsuid != current->fsuid
-		 || cred->uc_fsgid != current->fsgid)
-			return 0;
-
-		groups = current->ngroups;
-		if (groups > NFS_NGROUPS)
-			groups = NFS_NGROUPS;
-		for (i = 0; i < groups ; i++)
-			if (cred->uc_gids[i] != (gid_t) current->groups[i])
-				return 0;
-		return 1;
+	vfscred = get_current_vfscred();
+	if (cred->uc_uid != current->uid
+	 || cred->uc_gid != current->gid
+	 || cred->uc_fsuid != vfscred->uid
+	 || cred->uc_fsgid != vfscred->gid) {
+		res = 0;
+		goto out;
 	}
-	return (cred->uc_uid == 0 && cred->uc_fsuid == 0
-	     && cred->uc_gid == 0 && cred->uc_fsgid == 0
-	     && cred->uc_gids[0] == (gid_t) NOGROUP);
+
+	groups = vfscred->ngroups;
+	if (groups > NFS_NGROUPS)
+		groups = NFS_NGROUPS;
+	if (memcmp(cred->uc_gids, vfscred->groups, groups*sizeof(gid_t)))
+		res = 0;
+	if (groups < NFS_NGROUPS && cred->uc_gids[groups] != NOGROUP)
+		res = 0;
+out:
+	put_vfscred(vfscred);
+	return res;
 }
 
 /*
diff -u --recursive --new-file linux-2.5.32/net/sunrpc/sched.c linux-2.5.32-vfscred/net/sunrpc/sched.c
--- linux-2.5.32/net/sunrpc/sched.c	Wed Aug 28 19:42:50 2002
+++ linux-2.5.32-vfscred/net/sunrpc/sched.c	Sat Aug 31 12:48:31 2002
@@ -750,7 +750,7 @@
 	task->tk_flags  = flags;
 	task->tk_exit   = callback;
 	init_waitqueue_head(&task->tk_wait);
-	if (current->uid != current->fsuid || current->gid != current->fsgid)
+	if (current->uid != current->vfscred->uid || current->gid != current->vfscred->gid)
 		task->tk_flags |= RPC_TASK_SETUID;
 
 	/* Initialize retry counters */
diff -u --recursive --new-file linux-2.5.32/security/capability.c linux-2.5.32-vfscred/security/capability.c
--- linux-2.5.32/security/capability.c	Tue Jul 30 00:44:17 2002
+++ linux-2.5.32-vfscred/security/capability.c	Sat Aug 31 12:48:32 2002
@@ -583,11 +583,11 @@
 			 */
 
 			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-				if (old_fsuid == 0 && current->fsuid != 0) {
+				if (old_fsuid == 0 && current->vfscred->uid != 0) {
 					cap_t (current->cap_effective) &=
 					    ~CAP_FS_MASK;
 				}
-				if (old_fsuid != 0 && current->fsuid == 0) {
+				if (old_fsuid != 0 && current->vfscred->uid == 0) {
 					cap_t (current->cap_effective) |=
 					    (cap_t (current->cap_permitted) &
 					     CAP_FS_MASK);
diff -u --recursive --new-file linux-2.5.32/security/dummy.c linux-2.5.32-vfscred/security/dummy.c
--- linux-2.5.32/security/dummy.c	Tue Jul 30 02:24:55 2002
+++ linux-2.5.32-vfscred/security/dummy.c	Sat Aug 31 12:48:35 2002
@@ -53,7 +53,7 @@
 
 static int dummy_capable (struct task_struct *tsk, int cap)
 {
-	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
+	if (cap_is_fs_cap (cap) ? tsk->vfscred->uid == 0 : tsk->euid == 0)
 		/* capability granted */
 		return 0;
 
@@ -489,7 +489,8 @@
 
 static void dummy_task_reparent_to_init (struct task_struct *p)
 {
-	p->euid = p->fsuid = 0;
+	p->euid = 0;
+	task_setfsuid(p, 0);
 	return;
 }
 
