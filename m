Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136336AbREGQ5Y>; Mon, 7 May 2001 12:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136375AbREGQ5P>; Mon, 7 May 2001 12:57:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49157 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S136336AbREGQ5F>; Mon, 7 May 2001 12:57:05 -0400
Date: Mon, 7 May 2001 18:56:48 +0200
From: Jan Kara <jack@ucw.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Update of quota patches
Message-ID: <20010507185648.B3429@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello.

  I'm sending you update of my quota patches. There are fixed some
syscall issues on ia64, sparc64 and s390x architectures. There's
also one small bugfix (or maybe new feature :)) - general users
are now allowed to get information about quota files. The incremental
patch is attached. Patch with whole new quota format stuff can be found at
(to be applied after quota-fix-2.4.3-1.diff.gz):
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-patch-2.4.3-2.diff.gz

									Honza


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-patch-2.4.3-2i.diff"

--- linux/fs/dquot.c.orig	Thu May  3 16:28:40 2001
+++ linux/fs/dquot.c	Tue May  1 18:07:12 2001
@@ -2027,6 +2027,7 @@
 	switch (cmds) {
 		case Q_SYNC:
 		case Q_GETSTATS:
+		case Q_GETINFO:
 			break;
 		case Q_GETQUOTA:
 			if (((type == USRQUOTA && current->euid != id) ||
--- linux/arch/ia64/ia32/sys_ia32.c.orig	Thu May  3 17:07:26 2001
+++ linux/arch/ia64/ia32/sys_ia32.c	Thu May  3 17:20:13 2001
@@ -2711,26 +2711,26 @@
 	return sys_ioperm((unsigned long)from, (unsigned long)num, on);
 }
 
-struct dqblk32 {
-    __u32 dqb_bhardlimit;
-    __u32 dqb_bsoftlimit;
-    __u32 dqb_curblocks;
+struct mem_dqblk32 {
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
+    __u32 dqb_bhardlimit;
+    __u32 dqb_bsoftlimit;
+    __u64 dqb_curspace;
     __kernel_time_t32 dqb_btime;
     __kernel_time_t32 dqb_itime;
 };
                                 
 extern asmlinkage long sys_quotactl(int cmd, const char *special, int id,
-				   caddr_t addr);
+				   __kernel_caddr_t addr);
 
 asmlinkage long
 sys32_quotactl(int cmd, const char *special, int id, unsigned long addr)
 {
 	int cmds = cmd >> SUBCMDSHIFT;
 	int err;
-	struct dqblk d;
+	struct mem_dqblk d;
 	mm_segment_t old_fs;
 	char *spec;
 	
@@ -2740,33 +2740,35 @@
 	case Q_SETQUOTA:
 	case Q_SETUSE:
 	case Q_SETQLIM:
-		if (copy_from_user (&d, (struct dqblk32 *)addr,
-				    sizeof (struct dqblk32)))
+		if (copy_from_user (&d, (struct mem_dqblk32 *)addr,
+				    sizeof (struct mem_dqblk32)))
 			return -EFAULT;
-		d.dqb_itime = ((struct dqblk32 *)&d)->dqb_itime;
-		d.dqb_btime = ((struct dqblk32 *)&d)->dqb_btime;
+		d.dqb_itime = ((struct mem_dqblk32 *)&d)->dqb_itime;
+		d.dqb_btime = ((struct mem_dqblk32 *)&d)->dqb_btime;
 		break;
 	default:
 		return sys_quotactl(cmd, special,
-				    id, (caddr_t)addr);
+				    id, (__kernel_caddr_t)addr);
 	}
 	spec = getname32 (special);
 	err = PTR_ERR(spec);
 	if (IS_ERR(spec)) return err;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (caddr_t)&d);
+	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
 	set_fs (old_fs);
 	putname (spec);
+	if (err)
+		return err;
 	if (cmds == Q_GETQUOTA) {
 		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct dqblk32 *)&d)->dqb_itime = i;
-		((struct dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct dqblk32 *)addr, &d,
-				  sizeof (struct dqblk32)))
+		((struct mem_dqblk32 *)&d)->dqb_itime = i;
+		((struct mem_dqblk32 *)&d)->dqb_btime = b;
+		if (copy_to_user ((struct mem_dqblk32 *)addr, &d,
+				  sizeof (struct mem_dqblk32)))
 			return -EFAULT;
 	}
-	return err;
+	return 0;
 }
 
 extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
--- linux/arch/s390x/kernel/linux32.c.orig	Thu May  3 16:59:51 2001
+++ linux/arch/s390x/kernel/linux32.c	Thu May  3 17:20:55 2001
@@ -897,18 +897,18 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-struct dqblk32 {
-    __u32 dqb_bhardlimit;
-    __u32 dqb_bsoftlimit;
-    __u32 dqb_curblocks;
+struct mem_dqblk32 {
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
+    __u32 dqb_bhardlimit;
+    __u32 dqb_bsoftlimit;
+    __u64 dqb_curspace;
     __kernel_time_t32 dqb_btime;
     __kernel_time_t32 dqb_itime;
 };
                                 
-extern asmlinkage int sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
+extern asmlinkage long sys_quotactl(int cmd, const char *special, int id, __kernel_caddr_t addr);
 
 asmlinkage int sys32_quotactl(int cmd, const char *special, int id, unsigned long addr)
 {
@@ -924,33 +924,35 @@
 	case Q_SETQUOTA:
 	case Q_SETUSE:
 	case Q_SETQLIM:
-		if (copy_from_user (&d, (struct dqblk32 *)addr,
-				    sizeof (struct dqblk32)))
+		if (copy_from_user (&d, (struct mem_dqblk32 *)addr,
+				    sizeof (struct mem_dqblk32)))
 			return -EFAULT;
-		d.dqb_itime = ((struct dqblk32 *)&d)->dqb_itime;
-		d.dqb_btime = ((struct dqblk32 *)&d)->dqb_btime;
+		d.dqb_itime = ((struct mem_dqblk32 *)&d)->dqb_itime;
+		d.dqb_btime = ((struct mem_dqblk32 *)&d)->dqb_btime;
 		break;
 	default:
 		return sys_quotactl(cmd, special,
-				    id, (caddr_t)addr);
+				    id, (__kernel_caddr_t)addr);
 	}
 	spec = getname (special);
 	err = PTR_ERR(spec);
 	if (IS_ERR(spec)) return err;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (caddr_t)&d);
+	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
 	set_fs (old_fs);
 	putname (spec);
+	if (err)
+		return err;
 	if (cmds == Q_GETQUOTA) {
 		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct dqblk32 *)&d)->dqb_itime = i;
-		((struct dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct dqblk32 *)addr, &d,
-				  sizeof (struct dqblk32)))
+		((struct mem_dqblk32 *)&d)->dqb_itime = i;
+		((struct mem_dqblk32 *)&d)->dqb_btime = b;
+		if (copy_to_user ((struct mem_dqblk32 *)addr, &d,
+				  sizeof (struct mem_dqblk32)))
 			return -EFAULT;
 	}
-	return err;
+	return 0;
 }
 
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
--- linux/arch/sparc64/kernel/sys_sparc32.c.orig	Thu May  3 17:16:10 2001
+++ linux/arch/sparc64/kernel/sys_sparc32.c	Thu May  3 17:28:25 2001
@@ -887,24 +887,24 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-struct dqblk32 {
-    __u32 dqb_bhardlimit;
-    __u32 dqb_bsoftlimit;
-    __u32 dqb_curblocks;
+struct mem_dqblk32 {
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
+    __u32 dqb_bhardlimit;
+    __u32 dqb_bsoftlimit;
+    __u64 dqb_curspace;
     __kernel_time_t32 dqb_btime;
     __kernel_time_t32 dqb_itime;
 };
                                 
-extern asmlinkage int sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
+extern asmlinkage long sys_quotactl(int cmd, const char *special, int id, __kernel_caddr_t addr);
 
 asmlinkage int sys32_quotactl(int cmd, const char *special, int id, unsigned long addr)
 {
 	int cmds = cmd >> SUBCMDSHIFT;
 	int err;
-	struct dqblk d;
+	struct mem_dqblk d;
 	mm_segment_t old_fs;
 	char *spec;
 	
@@ -914,33 +914,35 @@
 	case Q_SETQUOTA:
 	case Q_SETUSE:
 	case Q_SETQLIM:
-		if (copy_from_user (&d, (struct dqblk32 *)addr,
-				    sizeof (struct dqblk32)))
+		if (copy_from_user (&d, (struct mem_dqblk32 *)addr,
+				    sizeof (struct mem_dqblk32)))
 			return -EFAULT;
-		d.dqb_itime = ((struct dqblk32 *)&d)->dqb_itime;
-		d.dqb_btime = ((struct dqblk32 *)&d)->dqb_btime;
+		d.dqb_itime = ((struct mem_dqblk32 *)&d)->dqb_itime;
+		d.dqb_btime = ((struct mem_dqblk32 *)&d)->dqb_btime;
 		break;
 	default:
 		return sys_quotactl(cmd, special,
-				    id, (caddr_t)addr);
+				    id, (__kernel_caddr_t)addr);
 	}
 	spec = getname (special);
 	err = PTR_ERR(spec);
 	if (IS_ERR(spec)) return err;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (caddr_t)&d);
+	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
 	set_fs (old_fs);
 	putname (spec);
+	if (err)
+		return err;
 	if (cmds == Q_GETQUOTA) {
 		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct dqblk32 *)&d)->dqb_itime = i;
-		((struct dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct dqblk32 *)addr, &d,
-				  sizeof (struct dqblk32)))
+		((struct mem_dqblk32 *)&d)->dqb_itime = i;
+		((struct mem_dqblk32 *)&d)->dqb_btime = b;
+		if (copy_to_user ((struct mem_dqblk32 *)addr, &d,
+				  sizeof (struct mem_dqblk32)))
 			return -EFAULT;
 	}
-	return err;
+	return 0;
 }
 
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)

--d6Gm4EdcadzBjdND--
