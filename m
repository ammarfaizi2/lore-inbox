Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWJMCmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWJMCmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 22:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWJMCmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 22:42:23 -0400
Received: from uni20mr.unity.ncsu.edu ([152.1.2.39]:42140 "EHLO
	uni20mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S1751267AbWJMCmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 22:42:22 -0400
Subject: [PATCH] Readability improvement of open_exec()
From: Casey Dahlin <cjdahlin@ncsu.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 12 Oct 2006 22:42:13 -0400
Message-Id: <1160707333.3230.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.2.0.264296, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.10.12.190442
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A fairly trivial patch that simply improves the readability of the
open_exec() function. It no longer executes primarily inside nested ifs
or has 5 levels of indentation :) Logically it should be no different
from the original. Patch applies to stock 2.6.18 kernel.


Signed-off-by: Casey Dahlin <cjdahlin@ncsu.edu>

---

diff -up exec.c.bak exec.c
--- exec.c.bak	2006-09-19 23:42:06.000000000 -0400
+++ exec.c	2006-10-12 21:42:01.000000000 -0400
@@ -474,36 +474,43 @@ static inline void free_arg_pages(struct
 struct file *open_exec(const char *name)
 {
 	struct nameidata nd;
-	int err;
+	struct inode *inode;
+	int err, perm_err;
 	struct file *file;
 
 	err = path_lookup_open(AT_FDCWD, name, LOOKUP_FOLLOW, &nd, FMODE_READ|
FMODE_EXEC);
 	file = ERR_PTR(err);
 
-	if (!err) {
-		struct inode *inode = nd.dentry->d_inode;
-		file = ERR_PTR(-EACCES);
-		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
-		    S_ISREG(inode->i_mode)) {
-			int err = vfs_permission(&nd, MAY_EXEC);
-			file = ERR_PTR(err);
-			if (!err) {
-				file = nameidata_to_filp(&nd, O_RDONLY);
-				if (!IS_ERR(file)) {
-					err = deny_write_access(file);
-					if (err) {
-						fput(file);
-						file = ERR_PTR(err);
-					}
-				}
-out:
-				return file;
-			}
-		}
-		release_open_intent(&nd);
-		path_release(&nd);
-	}
+	if (err)
+		goto out;
+
+	inode = nd.dentry->d_inode;
+	file = ERR_PTR(-EACCES);
+	if ((nd.mnt->mnt_flags & MNT_NOEXEC) ||
+	    !S_ISREG(inode->i_mode))
+		goto cleanup;
+
+	perm_err = vfs_permission(&nd, MAY_EXEC);
+	file = ERR_PTR(perm_err);
+	if (perm_err)
+		goto cleanup;
+
+	file = nameidata_to_filp(&nd, O_RDONLY);
+	if (IS_ERR(file))
+		goto out;
+
+	perm_err = deny_write_access(file);
+	if (perm_err) {
+		fput(file);
+		file = ERR_PTR(err);
+	}	
 	goto out;
+
+cleanup:
+	release_open_intent(&nd);
+	path_release(&nd);
+out:
+	return file;
 }
 
 EXPORT_SYMBOL(open_exec);


