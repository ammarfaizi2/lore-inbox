Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269022AbRG3RP1>; Mon, 30 Jul 2001 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269023AbRG3RPR>; Mon, 30 Jul 2001 13:15:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1037 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269020AbRG3RPG>; Mon, 30 Jul 2001 13:15:06 -0400
Date: Mon, 30 Jul 2001 19:15:11 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: s390x bugfix for quotactl()
Message-ID: <20010730191511.A1751@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  Hello,

  I found out that in 2.4.7 there's a bug in s390x wrapper around quotactl() call
(part of patch from -ac kernel migrated to your kernel but this part alone makes
call not even compile). Following patch should fix it.

									Honza

--------------------------------------------------------------------------------
--- linux-2.4.7/arch/s390x/kernel/linux32.c	Fri Jul 27 20:57:13 2001
+++ linux-2.4.7/arch/s390x/kernel/linux32.c	Fri May 11 23:18:09 2001
@@ -897,24 +897,24 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-struct mem_dqblk32 {
+struct dqblk32 {
+    __u32 dqb_bhardlimit;
+    __u32 dqb_bsoftlimit;
+    __u32 dqb_curblocks;
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
-    __u32 dqb_bhardlimit;
-    __u32 dqb_bsoftlimit;
-    __u64 dqb_curspace;
     __kernel_time_t32 dqb_btime;
     __kernel_time_t32 dqb_itime;
 };
                                 
-extern asmlinkage long sys_quotactl(int cmd, const char *special, int id, __kernel_caddr_t addr);
+extern asmlinkage int sys_quotactl(int cmd, const char *special, int id, caddr_t addr);
 
 asmlinkage int sys32_quotactl(int cmd, const char *special, int id, unsigned long addr)
 {
 	int cmds = cmd >> SUBCMDSHIFT;
 	int err;
-	struct mem_dqblk d;
+	struct dqblk d;
 	mm_segment_t old_fs;
 	char *spec;
 	
@@ -924,35 +924,33 @@
 	case Q_SETQUOTA:
 	case Q_SETUSE:
 	case Q_SETQLIM:
-		if (copy_from_user (&d, (struct mem_dqblk32 *)addr,
-				    sizeof (struct mem_dqblk32)))
+		if (copy_from_user (&d, (struct dqblk32 *)addr,
+				    sizeof (struct dqblk32)))
 			return -EFAULT;
-		d.dqb_itime = ((struct mem_dqblk32 *)&d)->dqb_itime;
-		d.dqb_btime = ((struct mem_dqblk32 *)&d)->dqb_btime;
+		d.dqb_itime = ((struct dqblk32 *)&d)->dqb_itime;
+		d.dqb_btime = ((struct dqblk32 *)&d)->dqb_btime;
 		break;
 	default:
 		return sys_quotactl(cmd, special,
-				    id, (__kernel_caddr_t)addr);
+				    id, (caddr_t)addr);
 	}
 	spec = getname (special);
 	err = PTR_ERR(spec);
 	if (IS_ERR(spec)) return err;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
-	err = sys_quotactl(cmd, (const char *)spec, id, (__kernel_caddr_t)&d);
+	err = sys_quotactl(cmd, (const char *)spec, id, (caddr_t)&d);
 	set_fs (old_fs);
 	putname (spec);
-	if (err)
-		return err;
 	if (cmds == Q_GETQUOTA) {
 		__kernel_time_t b = d.dqb_btime, i = d.dqb_itime;
-		((struct mem_dqblk32 *)&d)->dqb_itime = i;
-		((struct mem_dqblk32 *)&d)->dqb_btime = b;
-		if (copy_to_user ((struct mem_dqblk32 *)addr, &d,
-				  sizeof (struct mem_dqblk32)))
+		((struct dqblk32 *)&d)->dqb_itime = i;
+		((struct dqblk32 *)&d)->dqb_btime = b;
+		if (copy_to_user ((struct dqblk32 *)addr, &d,
+				  sizeof (struct dqblk32)))
 			return -EFAULT;
 	}
-	return 0;
+	return err;
 }
 
 static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)

