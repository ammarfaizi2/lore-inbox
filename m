Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSE0NHF>; Mon, 27 May 2002 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSE0NHE>; Mon, 27 May 2002 09:07:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35600 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316604AbSE0NG4>; Mon, 27 May 2002 09:06:56 -0400
Date: Mon, 27 May 2002 15:06:57 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2 Quota changes
Message-ID: <20020527130657.GB17926@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  here I'm sending you a patch which removes compatible quota interfaces
from kernel quota. The patch also includes renaming of vfs_get_info()
and vfs_set_info() to vfs_get_dqinfo() and vfs_set_dqinfo(). Please
apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/ia64/ia32/ia32_entry.S linux-2.5.17-3-compatfix/arch/ia64/ia32/ia32_entry.S
--- linux-2.5.17-2-procfix/arch/ia64/ia32/ia32_entry.S	Sat May 25 14:25:22 2002
+++ linux-2.5.17-3-compatfix/arch/ia64/ia32/ia32_entry.S	Sat May 25 14:35:39 2002
@@ -310,7 +310,7 @@
 	data8 sys32_ni_syscall	/* init_module */
 	data8 sys32_ni_syscall	/* delete_module */
 	data8 sys32_ni_syscall	/* get_kernel_syms */  /* 130 */
-	data8 sys32_quotactl
+	data8 sys_quotactl
 	data8 sys_getpgid
 	data8 sys_fchdir
 	data8 sys32_ni_syscall	/* sys_bdflush */
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/ia64/ia32/sys_ia32.c linux-2.5.17-3-compatfix/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.17-2-procfix/arch/ia64/ia32/sys_ia32.c	Sat May 25 14:25:29 2002
+++ linux-2.5.17-3-compatfix/arch/ia64/ia32/sys_ia32.c	Sat May 25 14:35:39 2002
@@ -3669,97 +3669,6 @@
 	return result;
 }
 
-extern asmlinkage long sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
-
-#ifdef CONFIG_QIFACE_COMPAT
-#ifdef CONFIG_QIFACE_V1
-struct user_dqblk32 {
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u32 dqb_curblocks;
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v1c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V1_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V1_SETQUOTA
-#define Q_COMP_SETQLIM Q_V1_SETQLIM
-#define Q_COMP_SETUSE Q_V1_SETUSE
-#else
-struct user_dqblk32 {
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u64 dqb_curspace;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v2c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V2_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V2_SETQUOTA
-#define Q_COMP_SETQLIM Q_V2_SETQLIM
-#define Q_COMP_SETUSE Q_V2_SETUSE
-#endif
-
-asmlinkage long sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	int cmds = cmd >> SUBCMDSHIFT;
-	long err;
-	comp_dqblk_t d;
-	mm_segment_t old_fs;
-	char *spec;
-	
-	switch (cmds) {
-		case Q_COMP_GETQUOTA:
-			break;
-		case Q_COMP_SETQUOTA:
-		case Q_COMP_SETUSE:
-		case Q_COMP_SETQLIM:
-			if (copy_from_user(&d, (struct user_dqblk32 *)addr,
-					    sizeof (struct user_dqblk32)))
-				return -EFAULT;
-			d.dqb_itime = ((struct user_dqblk32 *)&d)->dqb_itime;
-			d.dqb_btime = ((struct user_dqblk32 *)&d)->dqb_btime;
-			break;
-	default:
-		return sys_quotactl(cmd, special, id, (__kernel_caddr_t)addr);
-	}
-	spec = getname (special);
-	err = PTR_ERR(spec);
-	if (IS_ERR(spec)) return err;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
-	set_fs (old_fs);
-	putname (spec);
-	if (err)
-		return err;
-	if (cmds == Q_COMP_GETQUOTA) {
-		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct user_dqblk32 *)&d)->dqb_itime = i;
-		((struct user_dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct user_dqblk32 *)addr, &d,
-				  sizeof (struct user_dqblk32)))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-#else
-/* No conversion needed for new interface */
-asmlinkage long sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return sys_quotactl(cmd, special, id, addr);
-}
-#endif
-
 asmlinkage long
 sys32_sched_rr_get_interval (pid_t pid, struct timespec32 *interval)
 {
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/s390x/kernel/linux32.c linux-2.5.17-3-compatfix/arch/s390x/kernel/linux32.c
--- linux-2.5.17-2-procfix/arch/s390x/kernel/linux32.c	Sat May 25 14:25:29 2002
+++ linux-2.5.17-3-compatfix/arch/s390x/kernel/linux32.c	Sat May 25 14:35:39 2002
@@ -897,97 +897,6 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-extern asmlinkage int sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
-
-#ifdef CONFIG_QIFACE_COMPAT
-#ifdef CONFIG_QIFACE_V1
-struct user_dqblk32 {
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u32 dqb_curblocks;
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v1c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V1_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V1_SETQUOTA
-#define Q_COMP_SETQLIM Q_V1_SETQLIM
-#define Q_COMP_SETUSE Q_V1_SETUSE
-#else
-struct user_dqblk32 {
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u64 dqb_curspace;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v2c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V2_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V2_SETQUOTA
-#define Q_COMP_SETQLIM Q_V2_SETQLIM
-#define Q_COMP_SETUSE Q_V2_SETUSE
-#endif
-
-asmlinkage int sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	int cmds = cmd >> SUBCMDSHIFT;
-	int err;
-	comp_dqblk_t d;
-	mm_segment_t old_fs;
-	char *spec;
-	
-	switch (cmds) {
-		case Q_COMP_GETQUOTA:
-			break;
-		case Q_COMP_SETQUOTA:
-		case Q_COMP_SETUSE:
-		case Q_COMP_SETQLIM:
-			if (copy_from_user(&d, (struct user_dqblk32 *)addr,
-					    sizeof (struct user_dqblk32)))
-				return -EFAULT;
-			d.dqb_itime = ((struct user_dqblk32 *)&d)->dqb_itime;
-			d.dqb_btime = ((struct user_dqblk32 *)&d)->dqb_btime;
-			break;
-	default:
-		return sys_quotactl(cmd, special, id, (__kernel_caddr_t)addr);
-	}
-	spec = getname (special);
-	err = PTR_ERR(spec);
-	if (IS_ERR(spec)) return err;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
-	set_fs (old_fs);
-	putname (spec);
-	if (err)
-		return err;
-	if (cmds == Q_COMP_GETQUOTA) {
-		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct user_dqblk32 *)&d)->dqb_itime = i;
-		((struct user_dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct user_dqblk32 *)addr, &d,
-				  sizeof (struct user_dqblk32)))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-#else
-/* No conversion needed for new interface */
-asmlinkage int sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return sys_quotactl(cmd, special, id, addr);
-}
-#endif
-
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
 {
 	int err;
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/s390x/kernel/wrapper32.S linux-2.5.17-3-compatfix/arch/s390x/kernel/wrapper32.S
--- linux-2.5.17-2-procfix/arch/s390x/kernel/wrapper32.S	Wed Feb 20 03:11:02 2002
+++ linux-2.5.17-3-compatfix/arch/s390x/kernel/wrapper32.S	Sat May 25 14:35:39 2002
@@ -586,7 +586,7 @@
 	llgtr	%r3,%r3			# const char *
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# caddr_t
-	jg	sys32_quotactl		# branch to system call
+	jg	sys_quotactl		# branch to system call
 
 	.globl  sys32_getpgid_wrapper 
 sys32_getpgid_wrapper:
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/sparc64/kernel/sys_sparc32.c linux-2.5.17-3-compatfix/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.17-2-procfix/arch/sparc64/kernel/sys_sparc32.c	Sat May 25 14:25:29 2002
+++ linux-2.5.17-3-compatfix/arch/sparc64/kernel/sys_sparc32.c	Sat May 25 14:35:39 2002
@@ -889,97 +889,6 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-extern asmlinkage int sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
-
-#ifdef CONFIG_QIFACE_COMPAT
-#ifdef CONFIG_QIFACE_V1
-struct user_dqblk32 {
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u32 dqb_curblocks;
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v1c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V1_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V1_SETQUOTA
-#define Q_COMP_SETQLIM Q_V1_SETQLIM
-#define Q_COMP_SETUSE Q_V1_SETUSE
-#else
-struct user_dqblk32 {
-	__u32 dqb_ihardlimit;
-	__u32 dqb_isoftlimit;
-	__u32 dqb_curinodes;
-	__u32 dqb_bhardlimit;
-	__u32 dqb_bsoftlimit;
-	__u64 dqb_curspace;
-	__kernel_time_t32 dqb_btime;
-	__kernel_time_t32 dqb_itime;
-};
-typedef struct v2c_mem_dqblk comp_dqblk_t;
-
-#define Q_COMP_GETQUOTA Q_V2_GETQUOTA
-#define Q_COMP_SETQUOTA Q_V2_SETQUOTA
-#define Q_COMP_SETQLIM Q_V2_SETQLIM
-#define Q_COMP_SETUSE Q_V2_SETUSE
-#endif
-
-asmlinkage int sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	int cmds = cmd >> SUBCMDSHIFT;
-	int err;
-	comp_dqblk_t d;
-	mm_segment_t old_fs;
-	char *spec;
-	
-	switch (cmds) {
-		case Q_COMP_GETQUOTA:
-			break;
-		case Q_COMP_SETQUOTA:
-		case Q_COMP_SETUSE:
-		case Q_COMP_SETQLIM:
-			if (copy_from_user(&d, (struct user_dqblk32 *)addr,
-					    sizeof (struct user_dqblk32)))
-				return -EFAULT;
-			d.dqb_itime = ((struct user_dqblk32 *)&d)->dqb_itime;
-			d.dqb_btime = ((struct user_dqblk32 *)&d)->dqb_btime;
-			break;
-	default:
-		return sys_quotactl(cmd, special, id, (__kernel_caddr_t)addr);
-	}
-	spec = getname (special);
-	err = PTR_ERR(spec);
-	if (IS_ERR(spec)) return err;
-	old_fs = get_fs();
-	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
-	set_fs (old_fs);
-	putname (spec);
-	if (err)
-		return err;
-	if (cmds == Q_COMP_GETQUOTA) {
-		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct user_dqblk32 *)&d)->dqb_itime = i;
-		((struct user_dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct user_dqblk32 *)addr, &d,
-				  sizeof (struct user_dqblk32)))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-#else
-/* No conversion needed for new interface */
-asmlinkage int sys32_quotactl(int cmd, const char *special, int id, caddr_t addr)
-{
-	return sys_quotactl(cmd, special, id, addr);
-}
-#endif
-
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
 {
 	int err;
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/arch/sparc64/kernel/systbls.S linux-2.5.17-3-compatfix/arch/sparc64/kernel/systbls.S
--- linux-2.5.17-2-procfix/arch/sparc64/kernel/systbls.S	Sat May 25 14:25:29 2002
+++ linux-2.5.17-3-compatfix/arch/sparc64/kernel/systbls.S	Sat May 25 14:35:39 2002
@@ -52,7 +52,7 @@
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys32_fcntl64, sys_nis_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
 /*160*/	.word sys32_sched_setaffinity, sys32_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
-	.word sys32_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_setxattr
+	.word sys_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
 	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
 /*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, sys32_sigpending, sys32_query_module
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/fs/Config.help linux-2.5.17-3-compatfix/fs/Config.help
--- linux-2.5.17-2-procfix/fs/Config.help	Sat May 25 14:25:31 2002
+++ linux-2.5.17-3-compatfix/fs/Config.help	Sat May 25 14:35:39 2002
@@ -18,21 +18,6 @@
   need this functionality say Y here. Note that you will need latest
   quota utilities for new quota format with this kernel.
 
-CONFIG_QIFACE_COMPAT
-  This option will enable old quota interface in kernel.
-  If you have old quota tools (version <= 3.04) and you don't want to
-  upgrade them say Y here.
-
-CONFIG_QIFACE_V1
-  This is the oldest quota interface. It was used for old quota format.
-  If you have old quota tools and you use old quota format choose this
-  interface (if unsure, this interface is the best one to choose).
-
-CONFIG_QIFACE_V2
-  This quota interface was used by VFS v0 quota format. If you need
-  support for VFS v0 quota format (eg. you're using quota on ReiserFS)
-  and you don't want to upgrade quota tools, choose this interface.
-
 CONFIG_MINIX_FS
   Minix is a simple operating system used in many classes about OS's.
   The minix file system (method to organize files on a hard disk
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/fs/Config.in linux-2.5.17-3-compatfix/fs/Config.in
--- linux-2.5.17-2-procfix/fs/Config.in	Sat May 25 14:29:22 2002
+++ linux-2.5.17-3-compatfix/fs/Config.in	Sat May 25 14:36:44 2002
@@ -7,14 +7,8 @@
 bool 'Quota support' CONFIG_QUOTA
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
 dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
-dep_mbool '  Compatible quota interfaces' CONFIG_QIFACE_COMPAT $CONFIG_QUOTA
 if [ "$CONFIG_QUOTA" = "y" ]; then
    define_bool CONFIG_QUOTACTL y
-   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
-       choice '    Compatible quota interfaces' \
-		"Original	CONFIG_QIFACE_V1 \
-		 VFSv0		CONFIG_QIFACE_V2" Original
-   fi
 fi
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/fs/dquot.c linux-2.5.17-3-compatfix/fs/dquot.c
--- linux-2.5.17-2-procfix/fs/dquot.c	Sat May 25 14:59:20 2002
+++ linux-2.5.17-3-compatfix/fs/dquot.c	Sat May 25 16:03:34 2002
@@ -45,6 +45,10 @@
  *		Added dynamic quota structure allocation
  *		Jan Kara <jack@suse.cz> 12/2000
  *
+ *		Rewritten quota interface. Implemented new quota format and
+ *		formats registering.
+ *		Jan Kara, <jack@suse.cz>, 2001,2002
+ *
  * (C) Copyright 1994 - 1997 Marco van Wieringen 
  */
 
@@ -1295,7 +1299,7 @@
 	int error;
 
 	if (!fmt)
-		return -EINVAL;
+		return -ESRCH;
 	if (is_enabled(dqopt, type)) {
 		error = -EBUSY;
 		goto out_fmt;
@@ -1437,7 +1441,7 @@
 }
 
 /* Generic routine for getting common part of quota file information */
-int vfs_get_info(struct super_block *sb, int type, struct if_dqinfo *ii)
+int vfs_get_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
 {
 	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
 
@@ -1449,7 +1453,7 @@
 }
 
 /* Generic routine for setting common part of quota file information */
-int vfs_set_info(struct super_block *sb, int type, struct if_dqinfo *ii)
+int vfs_set_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii)
 {
 	struct mem_dqinfo *mi = sb_dqopt(sb)->info + type;
 
@@ -1467,8 +1471,8 @@
 	quota_on:	vfs_quota_on,
 	quota_off:	vfs_quota_off,
 	quota_sync:	vfs_quota_sync,
-	get_info:	vfs_get_info,
-	set_info:	vfs_set_info,
+	get_info:	vfs_get_dqinfo,
+	set_info:	vfs_set_dqinfo,
 	get_dqblk:	vfs_get_dqblk,
 	set_dqblk:	vfs_set_dqblk
 };
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/fs/quota.c linux-2.5.17-3-compatfix/fs/quota.c
--- linux-2.5.17-2-procfix/fs/quota.c	Sat May 25 14:32:32 2002
+++ linux-2.5.17-3-compatfix/fs/quota.c	Sat May 25 16:23:30 2002
@@ -11,10 +11,6 @@
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
-#ifdef CONFIG_QIFACE_COMPAT
-#include <linux/quotacompat.h>
-#endif
-
 
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
@@ -233,381 +229,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_QIFACE_COMPAT
-static int check_compat_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
-{
-	if (type >= MAXQUOTAS)
-		return -EINVAL;
-	/* Is operation supported? */
-	/* sb==NULL for GETSTATS calls */
-	if (sb && !sb->s_qcop)
-		return -ENOSYS;
-
-	switch (cmd) {
-		case Q_COMP_QUOTAON:
-			if (!sb->s_qcop->quota_on)
-				return -ENOSYS;
-			break;
-		case Q_COMP_QUOTAOFF:
-			if (!sb->s_qcop->quota_off)
-				return -ENOSYS;
-			break;
-		case Q_COMP_SYNC:
-			if (!sb->s_qcop->quota_sync)
-				return -ENOSYS;
-		break;
-#ifdef CONFIG_QIFACE_V2
-		case Q_V2_SETFLAGS:
-		case Q_V2_SETGRACE:
-		case Q_V2_SETINFO:
-			if (!sb->s_qcop->set_info)
-				return -ENOSYS;
-			break;
-		case Q_V2_GETINFO:
-			if (!sb->s_qcop->get_info)
-				return -ENOSYS;
-			break;
-		case Q_V2_SETQLIM:
-		case Q_V2_SETUSE:
-		case Q_V2_SETQUOTA:
-			if (!sb->s_qcop->set_dqblk)
-				return -ENOSYS;
-			break;
-		case Q_V2_GETQUOTA:
-			if (!sb->s_qcop->get_dqblk)
-				return -ENOSYS;
-			break;
-		case Q_V2_GETSTATS:
-			return 0;	/* GETSTATS need no other checks */
-#endif
-#ifdef CONFIG_QIFACE_V1
-		case Q_V1_SETQLIM:
-		case Q_V1_SETUSE:
-		case Q_V1_SETQUOTA:
-			if (!sb->s_qcop->set_dqblk)
-				return -ENOSYS;
-			break;
-		case Q_V1_GETQUOTA:
-			if (!sb->s_qcop->get_dqblk)
-				return -ENOSYS;
-			break;
-		case Q_V1_RSQUASH:
-			if (!sb->s_qcop->set_info)
-				return -ENOSYS;
-			break;
-		case Q_V1_GETSTATS:
-			return 0;	/* GETSTATS need no other checks */
-#endif
-		default:
-			return -EINVAL;
-	}
-
-	/* Is quota turned on for commands which need it? */
-	switch (cmd) {
-		case Q_V2_SETFLAGS:
-		case Q_V2_SETGRACE:
-		case Q_V2_SETINFO:
-		case Q_V2_GETINFO:
-		case Q_COMP_QUOTAOFF:
-		case Q_V1_RSQUASH:
-		case Q_V1_SETQUOTA:
-		case Q_V1_SETQLIM:
-		case Q_V1_SETUSE:
-		case Q_V2_SETQUOTA:
-		/* Q_V2_SETQLIM: collision with Q_V1_SETQLIM */
-		case Q_V2_SETUSE:
-		case Q_V1_GETQUOTA:
-		case Q_V2_GETQUOTA:
-			if (!sb_has_quota_enabled(sb, type))
-				return -ESRCH;
-	}
-#ifdef CONFIG_QIFACE_V1
-	if (cmd != Q_COMP_QUOTAON && cmd != Q_COMP_QUOTAOFF && cmd != Q_COMP_SYNC && sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id != QFMT_VFS_OLD)
-#else
-	if (cmd != Q_COMP_QUOTAON && cmd != Q_COMP_QUOTAOFF && cmd != Q_COMP_SYNC && sb_dqopt(sb)->info[type].dqi_format->qf_fmt_id != QFMT_VFS_V0)
-#endif
-		return -ESRCH;
-
-	/* Check privileges */
-	if (cmd == Q_V1_GETQUOTA || cmd == Q_V2_GETQUOTA) {
-		if (((type == USRQUOTA && current->euid != id) ||
-		     (type == GRPQUOTA && !in_egroup_p(id))) &&
-		    !capable(CAP_SYS_ADMIN))
-			return -EPERM;
-	}
-	else if (cmd != Q_V1_GETSTATS && cmd != Q_V2_GETSTATS && cmd != Q_V2_GETINFO && cmd != Q_COMP_SYNC)
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-	return 0;
-}
-
-#ifdef CONFIG_QIFACE_V1
-static int v1_set_rsquash(struct super_block *sb, int type, int flag)
-{
-	struct if_dqinfo info;
-
-	info.dqi_valid = IIF_FLAGS;
-	info.dqi_flags = flag ? V1_DQF_RSQUASH : 0;
-	return sb->s_qcop->set_info(sb, type, &info);
-}
-
-static int v1_get_dqblk(struct super_block *sb, int type, qid_t id, struct v1c_mem_dqblk *mdq)
-{
-	struct if_dqblk idq;
-	int ret;
-
-	if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)) < 0)
-		return ret;
-	mdq->dqb_ihardlimit = idq.dqb_ihardlimit;
-	mdq->dqb_isoftlimit = idq.dqb_isoftlimit;
-	mdq->dqb_curinodes = idq.dqb_curinodes;
-	mdq->dqb_bhardlimit = idq.dqb_bhardlimit;
-	mdq->dqb_bsoftlimit = idq.dqb_bsoftlimit;
-	mdq->dqb_curblocks = toqb(idq.dqb_curspace);
-	mdq->dqb_itime = idq.dqb_itime;
-	mdq->dqb_btime = idq.dqb_btime;
-	if (id == 0) {	/* Times for id 0 are in fact grace times */
-		struct if_dqinfo info;
-
-		if ((ret = sb->s_qcop->get_info(sb, type, &info)) < 0)
-			return ret;
-		mdq->dqb_btime = info.dqi_bgrace;
-		mdq->dqb_itime = info.dqi_igrace;
-	}
-	return 0;
-}
-
-static int v1_set_dqblk(struct super_block *sb, int type, int cmd, qid_t id, struct v1c_mem_dqblk *mdq)
-{
-	struct if_dqblk idq;
-	int ret;
-
-	idq.dqb_valid = 0;
-	if (cmd == Q_V1_SETQUOTA || cmd == Q_V1_SETQLIM) {
-		idq.dqb_ihardlimit = mdq->dqb_ihardlimit;
-		idq.dqb_isoftlimit = mdq->dqb_isoftlimit;
-		idq.dqb_bhardlimit = mdq->dqb_bhardlimit;
-		idq.dqb_bsoftlimit = mdq->dqb_bsoftlimit;
-		idq.dqb_valid |= QIF_LIMITS;
-	}
-	if (cmd == Q_V1_SETQUOTA || cmd == Q_V1_SETUSE) {
-		idq.dqb_curinodes = mdq->dqb_curinodes;
-		idq.dqb_curspace = ((qsize_t)mdq->dqb_curblocks) << QUOTABLOCK_BITS;
-		idq.dqb_valid |= QIF_USAGE;
-	}
-	ret = sb->s_qcop->set_dqblk(sb, type, id, &idq);
-	if (!ret && id == 0 && cmd == Q_V1_SETQUOTA) {	/* Times for id 0 are in fact grace times */
-		struct if_dqinfo info;
-
-		info.dqi_bgrace = mdq->dqb_btime;
-		info.dqi_igrace = mdq->dqb_itime;
-		info.dqi_valid = IIF_BGRACE | IIF_IGRACE;
-		ret = sb->s_qcop->set_info(sb, type, &info);
-	}
-	return ret;
-}
-
-static void v1_get_stats(struct v1c_dqstats *dst)
-{
-	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
-}
-#endif
-
-#ifdef CONFIG_QIFACE_V2
-static int v2_get_info(struct super_block *sb, int type, struct v2c_mem_dqinfo *oinfo)
-{
-	struct if_dqinfo info;
-	int ret;
-
-	if ((ret = sb->s_qcop->get_info(sb, type, &info)) < 0)
-		return ret;
-	oinfo->dqi_bgrace = info.dqi_bgrace;
-	oinfo->dqi_igrace = info.dqi_igrace;
-	oinfo->dqi_flags = info.dqi_flags;
-	oinfo->dqi_blocks = sb_dqopt(sb)->info[type].u.v2_i.dqi_blocks;
-	oinfo->dqi_free_blk = sb_dqopt(sb)->info[type].u.v2_i.dqi_free_blk;
-	oinfo->dqi_free_entry = sb_dqopt(sb)->info[type].u.v2_i.dqi_free_entry;
-	return 0;
-}
-
-static int v2_set_info(struct super_block *sb, int type, int cmd, struct v2c_mem_dqinfo *oinfo)
-{
-	struct if_dqinfo info;
-
-	info.dqi_valid = 0;
-	if (cmd == Q_V2_SETGRACE || cmd == Q_V2_SETINFO) {
-		info.dqi_bgrace = oinfo->dqi_bgrace;
-		info.dqi_igrace = oinfo->dqi_igrace;
-		info.dqi_valid |= IIF_BGRACE | IIF_IGRACE;
-	}
-	if (cmd == Q_V2_SETFLAGS || cmd == Q_V2_SETINFO) {
-		info.dqi_flags = oinfo->dqi_flags;
-		info.dqi_valid |= IIF_FLAGS;
-	}
-	/* We don't simulate deadly effects of setting other parameters ;-) */
-	return sb->s_qcop->set_info(sb, type, &info);
-}
-
-static int v2_get_dqblk(struct super_block *sb, int type, qid_t id, struct v2c_mem_dqblk *mdq)
-{
-	struct if_dqblk idq;
-	int ret;
-
-	if ((ret = sb->s_qcop->get_dqblk(sb, type, id, &idq)) < 0)
-		return ret;
-	mdq->dqb_ihardlimit = idq.dqb_ihardlimit;
-	mdq->dqb_isoftlimit = idq.dqb_isoftlimit;
-	mdq->dqb_curinodes = idq.dqb_curinodes;
-	mdq->dqb_bhardlimit = idq.dqb_bhardlimit;
-	mdq->dqb_bsoftlimit = idq.dqb_bsoftlimit;
-	mdq->dqb_curspace = idq.dqb_curspace;
-	mdq->dqb_itime = idq.dqb_itime;
-	mdq->dqb_btime = idq.dqb_btime;
-	return 0;
-}
-
-static int v2_set_dqblk(struct super_block *sb, int type, int cmd, qid_t id, struct v2c_mem_dqblk *mdq)
-{
-	struct if_dqblk idq;
-
-	idq.dqb_valid = 0;
-	if (cmd == Q_V2_SETQUOTA || cmd == Q_V2_SETQLIM) {
-		idq.dqb_ihardlimit = mdq->dqb_ihardlimit;
-		idq.dqb_isoftlimit = mdq->dqb_isoftlimit;
-		idq.dqb_bhardlimit = mdq->dqb_bhardlimit;
-		idq.dqb_bsoftlimit = mdq->dqb_bsoftlimit;
-		idq.dqb_valid |= QIF_LIMITS;
-	}
-	if (cmd == Q_V2_SETQUOTA || cmd == Q_V2_SETUSE) {
-		idq.dqb_curinodes = mdq->dqb_curinodes;
-		idq.dqb_curspace = mdq->dqb_curspace;
-		idq.dqb_valid |= QIF_USAGE;
-	}
-	return sb->s_qcop->set_dqblk(sb, type, id, &idq);
-}
-
-static void v2_get_stats(struct v2c_dqstats *dst)
-{
-	memcpy(dst, &dqstats_array, sizeof(dqstats_array));
-	dst->version = __DQUOT_NUM_VERSION__;
-}
-#endif
-
-/* Handle requests to old interface */
-static int do_compat_quotactl(struct super_block *sb, int type, int cmd, qid_t id, caddr_t addr)
-{
-	int ret;
-
-	switch (cmd) {
-		case Q_COMP_QUOTAON: {
-			char *pathname;
-
-			if (IS_ERR(pathname = getname(addr)))
-				return PTR_ERR(pathname);
-#ifdef CONFIG_QIFACE_V1
-			ret = sb->s_qcop->quota_on(sb, type, QFMT_VFS_OLD, pathname);
-#else
-			ret = sb->s_qcop->quota_on(sb, type, QFMT_VFS_V0, pathname);
-#endif
-			putname(pathname);
-			return ret;
-		}
-		case Q_COMP_QUOTAOFF:
-			return sb->s_qcop->quota_off(sb, type);
-		case Q_COMP_SYNC:
-			return sb->s_qcop->quota_sync(sb, type);
-#ifdef CONFIG_QIFACE_V1
-		case Q_V1_RSQUASH: {
-			int flag;
-
-			if (copy_from_user(&flag, addr, sizeof(flag)))
-				return -EFAULT;
-			return v1_set_rsquash(sb, type, flag);
-		}
-		case Q_V1_GETQUOTA: {
-			struct v1c_mem_dqblk mdq;
-
-			if ((ret = v1_get_dqblk(sb, type, id, &mdq)))
-				return ret;
-			if (copy_to_user(addr, &mdq, sizeof(mdq)))
-				return -EFAULT;
-			return 0;
-		}
-		case Q_V1_SETQLIM:
-		case Q_V1_SETUSE:
-		case Q_V1_SETQUOTA: {
-			struct v1c_mem_dqblk mdq;
-
-			if (copy_from_user(&mdq, addr, sizeof(mdq)))
-				return -EFAULT;
-			return v1_set_dqblk(sb, type, cmd, id, &mdq);
-		}
-		case Q_V1_GETSTATS: {
-			struct v1c_dqstats dst;
-
-			v1_get_stats(&dst);
-			if (copy_to_user(addr, &dst, sizeof(dst)))
-				return -EFAULT;
-			return 0;
-		}
-#endif
-#ifdef CONFIG_QIFACE_V2
-		case Q_V2_GETINFO: {
-			struct v2c_mem_dqinfo info;
-
-			if ((ret = v2_get_info(sb, type, &info)))
-				return ret;
-			if (copy_to_user(addr, &info, sizeof(info)))
-				return -EFAULT;
-			return 0;
-		}
-		case Q_V2_SETFLAGS:
-		case Q_V2_SETGRACE:
-		case Q_V2_SETINFO: {
-			struct v2c_mem_dqinfo info;
-
-			if (copy_from_user(&info, addr, sizeof(info)))
-				return -EFAULT;
-			
-			return v2_set_info(sb, type, cmd, &info);
-		}
-		case Q_V2_GETQUOTA: {
-			struct v2c_mem_dqblk mdq;
-
-			if ((ret = v2_get_dqblk(sb, type, id, &mdq)))
-				return ret;
-			if (copy_to_user(addr, &mdq, sizeof(mdq)))
-				return -EFAULT;
-			return 0;
-		}
-		case Q_V2_SETUSE:
-		case Q_V2_SETQLIM:
-		case Q_V2_SETQUOTA: {
-			struct v2c_mem_dqblk mdq;
-
-			if (copy_from_user(&mdq, addr, sizeof(mdq)))
-				return -EFAULT;
-			return v2_set_dqblk(sb, type, cmd, id, &mdq);
-		}
-		case Q_V2_GETSTATS: {
-			struct v2c_dqstats dst;
-
-			v2_get_stats(&dst);
-			if (copy_to_user(addr, &dst, sizeof(dst)))
-				return -EFAULT;
-			return 0;
-		}
-#endif
-	}
-	BUG();
-	return 0;
-}
-#endif
-
-/* Macros for short-circuiting the compatibility tests */
-#define NEW_COMMAND(c) ((c) & (0x80 << 16))
-#define XQM_COMMAND(c) (((c) & ('X' << 8)) == ('X' << 8))
-
 /*
  * This is the system call interface. This communicates with
  * the user-level programs. Currently this only supports diskquota
@@ -624,25 +245,11 @@
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
-#ifdef CONFIG_QIFACE_COMPAT
-	if (cmds != Q_V1_GETSTATS && cmds != Q_V2_GETSTATS && IS_ERR(sb = resolve_dev(special))) {
-		ret = PTR_ERR(sb);
-		sb = NULL;
-		goto out;
-	}
-	if (!NEW_COMMAND(cmds) && !XQM_COMMAND(cmds)) {
-		if ((ret = check_compat_quotactl_valid(sb, type, cmds, id)) < 0)
-			goto out;
-		ret = do_compat_quotactl(sb, type, cmds, id, addr);
-		goto out;
-	}
-#else
 	if (IS_ERR(sb = resolve_dev(special))) {
 		ret = PTR_ERR(sb);
 		sb = NULL;
 		goto out;
 	}
-#endif
 	if ((ret = check_quotactl_valid(sb, type, cmds, id)) < 0)
 		goto out;
 	ret = do_quotactl(sb, type, cmds, id, addr);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.17-2-procfix/include/linux/quotacompat.h linux-2.5.17-3-compatfix/include/linux/quotacompat.h
--- linux-2.5.17-2-procfix/include/linux/quotacompat.h	Sat May 25 14:25:34 2002
+++ linux-2.5.17-3-compatfix/include/linux/quotacompat.h	Thu Jan  1 01:00:00 1970
@@ -1,86 +0,0 @@
-/*
- *	Definition of symbols used for backward compatible interface
- */
-
-#ifndef _LINUX_QUOTACOMPAT_
-#define _LINUX_QUOTACOMPAT_
-
-#include <linux/types.h>
-#include <linux/quota.h>
-
-struct v1c_mem_dqblk {
-	__u32 dqb_bhardlimit;	/* absolute limit on disk blks alloc */
-	__u32 dqb_bsoftlimit;	/* preferred limit on disk blks */
-	__u32 dqb_curblocks;	/* current block count */
-	__u32 dqb_ihardlimit;	/* maximum # allocated inodes */
-	__u32 dqb_isoftlimit;	/* preferred inode limit */
-	__u32 dqb_curinodes;	/* current # allocated inodes */
-	time_t dqb_btime;	/* time limit for excessive disk use */
-	time_t dqb_itime;	/* time limit for excessive files */
-};
-
-struct v1c_dqstats {
-	__u32 lookups;
-	__u32 drops;
-	__u32 reads;
-	__u32 writes;
-	__u32 cache_hits;
-	__u32 allocated_dquots;
-	__u32 free_dquots;
-	__u32 syncs;
-};
-
-struct v2c_mem_dqblk {
-	unsigned int dqb_ihardlimit;
-	unsigned int dqb_isoftlimit;
-	unsigned int dqb_curinodes;
-	unsigned int dqb_bhardlimit;
-	unsigned int dqb_bsoftlimit;
-	qsize_t dqb_curspace;
-	__kernel_time_t dqb_btime;
-	__kernel_time_t dqb_itime;
-};
-
-struct v2c_mem_dqinfo {
-	unsigned int dqi_bgrace;
-	unsigned int dqi_igrace;
-	unsigned int dqi_flags;
-	unsigned int dqi_blocks;
-	unsigned int dqi_free_blk;
-	unsigned int dqi_free_entry;
-};
-
-struct v2c_dqstats {
-	__u32 lookups;
-	__u32 drops;
-	__u32 reads;
-	__u32 writes;
-	__u32 cache_hits;
-	__u32 allocated_dquots;
-	__u32 free_dquots;
-	__u32 syncs;
-	__u32 version;
-};
-
-#define Q_COMP_QUOTAON  0x0100	/* enable quotas */
-#define Q_COMP_QUOTAOFF 0x0200	/* disable quotas */
-#define Q_COMP_SYNC     0x0600	/* sync disk copy of a filesystems quotas */
-
-#define Q_V1_GETQUOTA 0x0300	/* get limits and usage */
-#define Q_V1_SETQUOTA 0x0400	/* set limits and usage */
-#define Q_V1_SETUSE   0x0500	/* set usage */
-#define Q_V1_SETQLIM  0x0700	/* set limits */
-#define Q_V1_GETSTATS 0x0800	/* get collected stats */
-#define Q_V1_RSQUASH  0x1000	/* set root_squash option */
-
-#define Q_V2_SETQLIM  0x0700	/* set limits */
-#define Q_V2_GETINFO  0x0900	/* get info about quotas - graces, flags... */
-#define Q_V2_SETINFO  0x0A00	/* set info about quotas */
-#define Q_V2_SETGRACE 0x0B00	/* set inode and block grace */
-#define Q_V2_SETFLAGS 0x0C00	/* set flags for quota */
-#define Q_V2_GETQUOTA 0x0D00	/* get limits and usage */
-#define Q_V2_SETQUOTA 0x0E00	/* set limits and usage */
-#define Q_V2_SETUSE   0x0F00	/* set usage */
-#define Q_V2_GETSTATS 0x1100	/* get collected stats */
-
-#endif
