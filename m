Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275140AbRJFNKK>; Sat, 6 Oct 2001 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275137AbRJFNKC>; Sat, 6 Oct 2001 09:10:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21772 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275131AbRJFNJo>; Sat, 6 Oct 2001 09:09:44 -0400
Date: Sat, 6 Oct 2001 15:07:32 +0200
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Quotactl change
Message-ID: <20011006150731.C30450@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you a change for quotactl interface which Nathan Scott proposed
for XFS. Actually it's his patch with just a few changes from me.
  It allows quotactl() to be overidden by a filesystem and so XFS can do it's
tricks with quota without patching dquot.c. Sideeffect of this change is a
cleanup in quotactl() interface :).
  Also statistics about quotas are now exported to /proc which is IMO more
flexible and nicer than GETSTATS call.
  I also commented out MAXDQUOTS sysctl because it has no sense anymore.
BTW: IMHO the same can be done with MAXINODES.

								Honza

------------------------------------<cut>--------------------------------
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/fs/Makefile linux-2.4.10-ac3-fix+quotactl/fs/Makefile
--- linux-2.4.10-ac3-fix/fs/Makefile	Wed Oct  3 23:38:37 2001
+++ linux-2.4.10-ac3-fix+quotactl/fs/Makefile	Sat Oct  6 10:46:35 2001
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
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/fs/dquot.c linux-2.4.10-ac3-fix+quotactl/fs/dquot.c
--- linux-2.4.10-ac3-fix/fs/dquot.c	Thu Oct  4 12:25:37 2001
+++ linux-2.4.10-ac3-fix+quotactl/fs/dquot.c	Sat Oct  6 11:57:06 2001
@@ -65,6 +65,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -73,8 +74,6 @@
 #define __DQUOT_NUM_VERSION__	(6*10000+5*100+0)
 #define __DQUOT_PARANOIA
 
-int nr_dquots, nr_free_dquots;
-
 static const char *quotatypes[] = INITQFNAMES;
 static const uint quota_magics[] = INITQMAGICS;
 static const uint quota_versions[] = INITQVERSIONS;
@@ -1480,11 +1479,13 @@
 static int set_dqblk(struct super_block *sb, qid_t id, short type, int flags, struct mem_dqblk *dqblk)
 {
 	struct dquot *dquot;
-	int error = -EFAULT;
 	struct mem_dqblk dq_dqblk;
 
+	if (!sb || !sb_has_quota_enabled(sb, type))
+		return -ESRCH;
+
 	if (copy_from_user(&dq_dqblk, dqblk, sizeof(struct mem_dqblk)))
-		return error;
+		return -EFAULT;
 
 	if (sb && (dquot = dqget(sb, id, type)) != NODQUOT) {
 		/* We can't block while changing quota structure... */
@@ -1550,20 +1551,38 @@
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
 
 static int get_info(struct super_block *sb, short type, struct mem_dqinfo *pinfo)
 {
@@ -1886,6 +1905,7 @@
 		INIT_LIST_HEAD(dquot_hash + i);
 	dqstats.version = __DQUOT_NUM_VERSION__;
 	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", __DQUOT_VERSION__);
+	quota_proc_init();
 	return 0;
 }
 __initcall(dquot_init);
@@ -2043,115 +2063,59 @@
 	return error; 
 }
 
-/*
- * This is the system call interface. This communicates with
- * the user-level programs. Currently this only supports diskquota
- * calls. Maybe we need to add the process quotas etc. in the future,
- * but we probably should use rlimits for that.
- */
-asmlinkage long sys_quotactl(int cmd, const char *special, qid_t id, __kernel_caddr_t addr)
+static int generic_quotactl(struct super_block *sb, int cmd, int type, qid_t id, void *addr)
 {
-	int cmds = 0, type = 0, flags = 0;
-	kdev_t dev;
-	struct super_block *sb = NULL;
 	int ret = -EINVAL;
 
-	lock_kernel();
-	cmds = cmd >> SUBCMDSHIFT;
-	type = cmd & SUBCMDMASK;
-
-
-	if ((uint) type >= MAXQUOTAS || cmds > 0x1100 || cmds < 0x100 || cmds == 0x0300 ||
-	    cmds == 0x0400 || cmds == 0x0500 || cmds == 0x1000)
-		goto out;
+	if ((uint) type >= MAXQUOTAS || cmd > 0x1100 || cmd < 0x100 ||
+	    cmd == 0x0300 || cmd == 0x0400 || cmd == 0x0500 || cmd == 0x1000)
+		return ret;
 
 	ret = -EPERM;
-	switch (cmds) {
+	switch (cmd) {
 		case Q_SYNC:
-		case Q_GETSTATS:
 		case Q_GETINFO:
 			break;
 		case Q_GETQUOTA:
 			if (((type == USRQUOTA && current->euid != id) ||
 			     (type == GRPQUOTA && !in_egroup_p(id))) &&
 			    !capable(CAP_SYS_ADMIN))
-				goto out;
+				return ret;
 			break;
 		default:
 			if (!capable(CAP_SYS_ADMIN))
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
+				return ret;
 	}
 
 	ret = -EINVAL;
-	switch (cmds) {
+	switch (cmd) {
 		case Q_QUOTAON:
-			ret = quota_on(sb, type, (char *) addr);
-			goto out;
+			return quota_on(sb, type, (char *) addr);
 		case Q_QUOTAOFF:
-			ret = quota_off(sb, type);
-			goto out;
+			return quota_off(sb, type);
 		case Q_GETQUOTA:
-			ret = get_quota(sb, id, type, (struct mem_dqblk *) addr);
-			goto out;
+			return get_quota(sb, id, type, (struct mem_dqblk *) addr);
 		case Q_SETQUOTA:
-			flags |= SET_QUOTA;
-			break;
+			return set_dqblk(sb, id, type, SET_QUOTA, (struct mem_dqblk *) addr);
 		case Q_SETUSE:
-			flags |= SET_USE;
-			break;
+			return set_dqblk(sb, id, type, SET_USE, (struct mem_dqblk *) addr);
 		case Q_SETQLIM:
-			flags |= SET_QLIMIT;
-			break;
+			return set_dqblk(sb, id, type, SET_QLIMIT, (struct mem_dqblk *) addr);
 		case Q_SYNC:
-			ret = sync_dquots(dev, type);
-			goto out;
-		case Q_GETSTATS:
-			ret = get_stats(addr);
-			goto out;
+			return sync_dquots(sb->s_dev, type);
 		case Q_GETINFO:
-			ret = get_info(sb, type, (struct mem_dqinfo *) addr);
-			goto out;
+			return get_info(sb, type, (struct mem_dqinfo *) addr);
 		case Q_SETFLAGS:
-			ret = set_info(ISET_FLAGS, sb, type, (struct mem_dqinfo *)addr);
-			goto out;
+			return set_info(ISET_FLAGS, sb, type, (struct mem_dqinfo *)addr);
 		case Q_SETGRACE:
-			ret = set_info(ISET_GRACE, sb, type, (struct mem_dqinfo *)addr);
-			goto out;
+			return set_info(ISET_GRACE, sb, type, (struct mem_dqinfo *)addr);
 		case Q_SETINFO:
-			ret = set_info(ISET_ALL, sb, type, (struct mem_dqinfo *)addr);
- 			goto out;
+			return set_info(ISET_ALL, sb, type, (struct mem_dqinfo *)addr);
 		default:
-			goto out;
+			return ret;
 	}
-
-	ret = -NODEV;
-	if (sb && sb_has_quota_enabled(sb, type))
-		ret = set_dqblk(sb, id, type, flags, (struct mem_dqblk *) addr);
-out:
-	if (sb)
-		drop_super(sb);
-	unlock_kernel();
-	return ret;
 }
+
+struct quota_operations generic_quota_ops = {
+	quotactl:	generic_quotactl
+};
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/fs/noquot.c linux-2.4.10-ac3-fix+quotactl/fs/noquot.c
--- linux-2.4.10-ac3-fix/fs/noquot.c	Wed Oct  3 23:38:40 2001
+++ linux-2.4.10-ac3-fix+quotactl/fs/noquot.c	Thu Jan  1 01:00:00 1970
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
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/fs/quota.c linux-2.4.10-ac3-fix+quotactl/fs/quota.c
--- linux-2.4.10-ac3-fix/fs/quota.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.10-ac3-fix+quotactl/fs/quota.c	Sat Oct  6 11:57:27 2001
@@ -0,0 +1,68 @@
+/*
+ * Quota code necessary even when VFS quota support is not compiled
+ * into the kernel.  Allows filesystems to implement their own form
+ * of quota if they wish.  The interesting stuff is over in dquot.c,
+ * living here are symbols for initial quotactl(2) handling, sysctl
+ * variables, etc - things needed even when quota support disabled.
+ */
+
+#include <linux/fs.h>
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
+asmlinkage long sys_quotactl(int cmd, const char *special, qid_t id, __kernel_caddr_t addr)
+{
+	int ret, cmds, type;
+	kdev_t dev;
+	mode_t mode;
+	struct nameidata nd;
+	struct super_block *sb = NULL;
+
+	lock_kernel();
+	cmds = cmd >> SUBCMDSHIFT;
+	type = cmd & SUBCMDMASK;
+
+	ret = -ENOSYS;
+	if (cmds == 0x0800 || cmds == 0x1100)	/* both were Q_GETSTATS */
+		goto out;
+
+	ret = -ENODEV;
+	if (!special)
+		goto out;
+	ret = user_path_walk(special, &nd);
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
+		
+	ret = -ENOSYS;
+	if (!sb->s_qop || !sb->s_qop->quotactl)
+		goto out;
+
+	ret = sb->s_qop->quotactl(sb, cmds, type, id, addr);
+
+out:
+	if (sb)
+		drop_super(sb);
+	unlock_kernel();
+	return ret;
+}
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/fs/super.c linux-2.4.10-ac3-fix+quotactl/fs/super.c
--- linux-2.4.10-ac3-fix/fs/super.c	Wed Oct  3 23:38:42 2001
+++ linux-2.4.10-ac3-fix+quotactl/fs/super.c	Sat Oct  6 10:46:35 2001
@@ -466,6 +466,7 @@
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	s->s_type = type;
+	s->s_qop = sb_generic_quota_ops;
 	spin_lock(&sb_lock);
 	list_add (&s->s_list, super_blocks.prev);
 	list_add (&s->s_instances, &type->fs_supers);
@@ -486,6 +487,7 @@
 	s->s_dev = 0;
 	s->s_bdev = 0;
 	s->s_type = NULL;
+	s->s_qop = NULL;
 	unlock_super(s);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
@@ -617,6 +619,7 @@
 	s->s_bdev = bdev;
 	s->s_flags = flags;
 	s->s_type = fs_type;
+	s->s_qop = sb_generic_quota_ops;
 	list_add (&s->s_list, super_blocks.prev);
 	list_add (&s->s_instances, &fs_type->fs_supers);
 	s->s_count += S_BIAS;
@@ -636,6 +639,7 @@
 	s->s_dev = 0;
 	s->s_bdev = 0;
 	s->s_type = NULL;
+	s->s_qop = NULL;
 	unlock_super(s);
 	spin_lock(&sb_lock);
 	list_del(&s->s_list);
@@ -700,6 +704,7 @@
 		s->s_dev = dev;
 		s->s_flags = flags;
 		s->s_type = fs_type;
+		s->s_qop = sb_generic_quota_ops;
 		list_add (&s->s_list, super_blocks.prev);
 		list_add (&s->s_instances, &fs_type->fs_supers);
 		s->s_count += S_BIAS;
@@ -715,6 +720,7 @@
 		s->s_dev = 0;
 		s->s_bdev = 0;
 		s->s_type = NULL;
+		s->s_qop = NULL;
 		unlock_super(s);
 		spin_lock(&sb_lock);
 		list_del(&s->s_list);
@@ -770,6 +776,7 @@
 	sb->s_bdev = NULL;
 	put_filesystem(fs);
 	sb->s_type = NULL;
+	sb->s_qop = NULL;
 	unlock_super(sb);
 	unlock_kernel();
 	if (bdev)
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/include/linux/fs.h linux-2.4.10-ac3-fix+quotactl/include/linux/fs.h
--- linux-2.4.10-ac3-fix/include/linux/fs.h	Sat Oct  6 11:03:30 2001
+++ linux-2.4.10-ac3-fix+quotactl/include/linux/fs.h	Sat Oct  6 12:03:54 2001
@@ -656,6 +656,10 @@
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 };
 
+struct quota_operations {
+	int (*quotactl)(struct super_block *, int, int, qid_t, void *);
+};
+
 /*
  *	Umount options
  */
@@ -717,6 +721,7 @@
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
+	struct quota_operations	*s_qop;
 
 	union {
 		struct minix_sb_info	minix_sb;
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/include/linux/quota.h linux-2.4.10-ac3-fix+quotactl/include/linux/quota.h
--- linux-2.4.10-ac3-fix/include/linux/quota.h	Wed Oct  3 23:38:47 2001
+++ linux-2.4.10-ac3-fix+quotactl/include/linux/quota.h	Sat Oct  6 11:56:35 2001
@@ -107,7 +107,7 @@
 #define Q_SETQUOTA 0x0E00	/* set limits and usage */
 #define Q_SETUSE   0x0F00	/* set usage */
 /* 0x1000 used by old RSQUASH */
-#define Q_GETSTATS 0x1100	/* get collected stats */
+/* 0x1100 used by GETSTATS v2, since replaced by procfs entry */
 
 /*
  * The following structure defines the format of the disk quota file
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/include/linux/quotaops.h linux-2.4.10-ac3-fix+quotactl/include/linux/quotaops.h
--- linux-2.4.10-ac3-fix/include/linux/quotaops.h	Sat Oct  6 11:09:14 2001
+++ linux-2.4.10-ac3-fix+quotactl/include/linux/quotaops.h	Sat Oct  6 12:17:15 2001
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
diff -ruN -X /home/jack/.kerndiffexclude linux-2.4.10-ac3-fix/include/linux/sysctl.h linux-2.4.10-ac3-fix+quotactl/include/linux/sysctl.h
--- linux-2.4.10-ac3-fix/include/linux/sysctl.h	Sat Oct  6 11:04:28 2001
+++ linux-2.4.10-ac3-fix+quotactl/include/linux/sysctl.h	Sat Oct  6 12:04:13 2001
@@ -535,7 +535,7 @@
 	FS_STATINODE=2,
 	FS_MAXINODE=3,	/* int:maximum number of inodes that can be allocated */
 	FS_NRDQUOT=4,	/* int:current number of allocated dquots */
-	FS_MAXDQUOT=5,	/* int:maximum number of dquots that can be allocated */
+	/* was FS_MAXDQUOT */
 	FS_NRFILE=6,	/* int:current number of allocated filedescriptors */
 	FS_MAXFILE=7,	/* int:maximum number of filedescriptors that can be allocated */
 	FS_DENTRY=8,
