Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVCDKQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVCDKQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVCDKQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:16:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26245 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262594AbVCDKPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:15:38 -0500
Date: Fri, 4 Mar 2005 11:15:36 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
Subject: [PATCH] Quotactl changes for XFS
Message-ID: <20050304101536.GA5195@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

  Attached patch from Nathan splits the checks done in quotactl() in XFS
and VFS parts (it's mostly just moving of code back and forth). It's
done mainly because XFS guys would like to implement more types of
quotas and I don't want them to slow down the general VFS case.. Please
apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

Separate out the generic quotactl checking from the XFS-specific
code; allows for a compatibility quota mode to be implemented for
XFS (down the track), and makes the code more readable anyway.

Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/fs/quota.c linux-2.6.11-quotactl/fs/quota.c
--- linux-2.6.11/fs/quota.c	2005-03-03 18:58:30.000000000 +0100
+++ linux-2.6.11-quotactl/fs/quota.c	2005-03-04 10:09:16.000000000 +0100
@@ -16,8 +16,8 @@
 #include <linux/syscalls.h>
 #include <linux/buffer_head.h>
 
-/* Check validity of quotactl */
-static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
+/* Check validity of generic quotactl commands */
+static int generic_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
 {
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
@@ -58,6 +58,48 @@ static int check_quotactl_valid(struct s
 			if (sb && !sb->s_qcop->quota_sync)
 				return -ENOSYS;
 			break;
+		default:
+			return -EINVAL;
+	}
+
+	/* Is quota turned on for commands which need it? */
+	switch (cmd) {
+		case Q_GETFMT:
+		case Q_GETINFO:
+		case Q_QUOTAOFF:
+		case Q_SETINFO:
+		case Q_SETQUOTA:
+		case Q_GETQUOTA:
+			/* This is just informative test so we are satisfied without a lock */
+			if (!sb_has_quota_enabled(sb, type))
+				return -ESRCH;
+	}
+
+	/* Check privileges */
+	if (cmd == Q_GETQUOTA) {
+		if (((type == USRQUOTA && current->euid != id) ||
+		     (type == GRPQUOTA && !in_egroup_p(id))) &&
+		    !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+	else if (cmd != Q_GETFMT && cmd != Q_SYNC && cmd != Q_GETINFO)
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+	return 0;
+}
+
+/* Check validity of XFS Quota Manager commands */
+static int xqm_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
+{
+	if (type >= XQM_MAXQUOTAS)
+		return -EINVAL;
+	if (!sb)
+		return -ENODEV;
+	if (!sb->s_qcop)
+		return -ENOSYS;
+
+	switch (cmd) {
 		case Q_XQUOTAON:
 		case Q_XQUOTAOFF:
 		case Q_XQUOTARM:
@@ -80,30 +122,31 @@ static int check_quotactl_valid(struct s
 			return -EINVAL;
 	}
 
-	/* Is quota turned on for commands which need it? */
-	switch (cmd) {
-		case Q_GETFMT:
-		case Q_GETINFO:
-		case Q_QUOTAOFF:
-		case Q_SETINFO:
-		case Q_SETQUOTA:
-		case Q_GETQUOTA:
-			/* This is just informative test so we are satisfied without a lock */
-			if (!sb_has_quota_enabled(sb, type))
-				return -ESRCH;
-	}
 	/* Check privileges */
-	if (cmd == Q_GETQUOTA || cmd == Q_XGETQUOTA) {
-		if (((type == USRQUOTA && current->euid != id) ||
-		     (type == GRPQUOTA && !in_egroup_p(id))) &&
-		    !capable(CAP_SYS_ADMIN))
+	if (cmd == Q_XGETQUOTA) {
+		if (((type == XQM_USRQUOTA && current->euid != id) ||
+		     (type == XQM_GRPQUOTA && !in_egroup_p(id))) &&
+		     !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-	}
-	else if (cmd != Q_GETFMT && cmd != Q_SYNC && cmd != Q_GETINFO && cmd != Q_XGETQSTAT)
+	} else if (cmd != Q_XGETQSTAT) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+	}
+
+	return 0;
+}
+
+static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
+{
+	int error;
 
-	return security_quotactl (cmd, type, id, sb);
+	if (XQM_COMMAND(cmd))
+		error = xqm_quotactl_valid(sb, type, cmd, id);
+	else
+		error = generic_quotactl_valid(sb, type, cmd, id);
+	if (!error)
+		error = security_quotactl(cmd, type, id, sb);
+	return error;
 }
 
 static struct super_block *get_super_to_sync(int type)
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11/include/linux/dqblk_xfs.h linux-2.6.11-quotactl/include/linux/dqblk_xfs.h
--- linux-2.6.11/include/linux/dqblk_xfs.h	2004-10-18 23:54:40.000000000 +0200
+++ linux-2.6.11-quotactl/include/linux/dqblk_xfs.h	2005-03-04 10:09:16.000000000 +0100
@@ -28,6 +28,12 @@
  */
 
 #define XQM_CMD(x)	(('X'<<8)+(x))	/* note: forms first QCMD argument */
+#define XQM_COMMAND(x)	(((x) & (0xff<<8)) == ('X'<<8))	/* test if for XFS */
+
+#define XQM_USRQUOTA	0	/* system call user quota type */
+#define XQM_GRPQUOTA	1	/* system call group quota type */
+#define XQM_MAXQUOTAS	2
+
 #define Q_XQUOTAON	XQM_CMD(1)	/* enable accounting/enforcement */
 #define Q_XQUOTAOFF	XQM_CMD(2)	/* disable accounting/enforcement */
 #define Q_XGETQUOTA	XQM_CMD(3)	/* get disk limits and usage */
