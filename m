Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUDMSk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbUDMSk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:40:59 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:49078 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263676AbUDMSku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:40:50 -0400
Subject: [PATCH 2.6.5-mm4] sys_access race fix
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wB3qSxg+MOB5PIeacROY"
Message-Id: <1081881778.5585.16.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 13 Apr 2004 20:43:01 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx016.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wB3qSxg+MOB5PIeacROY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	I'm trying to remove the race in sys_access code.
AFAICS, fsuid is checked in "permission" level so I pushed real fsuid
capture forward.At that state, I can task_lock (which was impossible
before user_walk).Could you tell me if I can improve this one ?

Regards,
Fabian

--=-wB3qSxg+MOB5PIeacROY
Content-Disposition: attachment; filename=open1.diff
Content-Type: text/x-patch; name=open1.diff; charset=
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/open.c edited/fs/open.c
--- orig/fs/open.c	2004-04-12 19:52:14.000000000 +0200
+++ edited/fs/open.c	2004-04-13 20:30:07.000000000 +0200
@@ -463,8 +463,8 @@
 
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
- * We do this by temporarily clearing all FS-related capabilities and
- * switching the fsuid/fsgid around to the real ones.
+ * We do this under task_lock by temporarily clearing all FS-related 
+ * capabilities and switching the fsuid/fsgid around to the real ones.
  */
 asmlinkage long sys_access(const char __user * filename, int mode)
 {
@@ -476,40 +476,31 @@
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
-	old_fsuid = current->fsuid;
-	old_fsgid = current->fsgid;
-	old_cap = current->cap_effective;
-
-	current->fsuid = current->uid;
-	current->fsgid = current->gid;
-
-	/*
-	 * Clear the capabilities if we switch to a non-root user
-	 *
-	 * FIXME: There is a race here against sys_capset.  The
-	 * capabilities can change yet we will restore the old
-	 * value below.  We should hold task_capabilities_lock,
-	 * but we cannot because user_path_walk can sleep.
-	 */
-	if (current->uid)
-		cap_clear(current->cap_effective);
-	else
-		current->cap_effective = current->cap_permitted;
-
 	res = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
 	if (!res) {
+		task_lock(current);
+		old_fsuid = current->fsuid;
+		old_fsgid = current->fsgid;
+		old_cap = current->cap_effective;
+		current->fsuid = current->uid;
+		current->fsgid = current->gid;
+
+		if (current->uid)
+			cap_clear(current->cap_effective);
+		else
+			current->cap_effective = current->cap_permitted;
+
 		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
 		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
 		   && !special_file(nd.dentry->d_inode->i_mode))
 			res = -EROFS;
 		path_release(&nd);
+		current->fsuid = old_fsuid;
+		current->fsgid = old_fsgid;
+		current->cap_effective = old_cap;
+		task_unlock(current);
 	}
-
-	current->fsuid = old_fsuid;
-	current->fsgid = old_fsgid;
-	current->cap_effective = old_cap;
-
 	return res;
 }
 

--=-wB3qSxg+MOB5PIeacROY--

