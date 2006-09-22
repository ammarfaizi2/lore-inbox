Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWIVXKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWIVXKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWIVXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:10:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17301 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964876AbWIVXKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:10:23 -0400
Date: Sat, 23 Sep 2006 00:10:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] fix missing ifdefs in syscall classes hookup for generic targets
Message-ID: <20060922231017.GT29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

several targets have no ....at() family and m32r calls its only chown variant
chown32(), with __NR_chown being undefined.  creat(2) is also absent in some
targets.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---o
[rmk: that should deal with arm, among other things]

 include/asm-generic/audit_change_attr.h |    4 ++++
 include/asm-generic/audit_dir_write.h   |    4 ++++
 lib/audit.c                             |    2 ++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index cb05bf6..5076455 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -1,16 +1,20 @@
 __NR_chmod,
 __NR_fchmod,
+#ifdef __NR_chown
 __NR_chown,
 __NR_fchown,
 __NR_lchown,
+#endif
 __NR_setxattr,
 __NR_lsetxattr,
 __NR_fsetxattr,
 __NR_removexattr,
 __NR_lremovexattr,
 __NR_fremovexattr,
+#ifdef __NR_fchownat
 __NR_fchownat,
 __NR_fchmodat,
+#endif
 #ifdef __NR_chown32
 __NR_chown32,
 __NR_fchown32,
diff --git a/include/asm-generic/audit_dir_write.h b/include/asm-generic/audit_dir_write.h
index 161a7a5..6621bd8 100644
--- a/include/asm-generic/audit_dir_write.h
+++ b/include/asm-generic/audit_dir_write.h
@@ -1,14 +1,18 @@
 __NR_rename,
 __NR_mkdir,
 __NR_rmdir,
+#ifdef __NR_creat
 __NR_creat,
+#endif
 __NR_link,
 __NR_unlink,
 __NR_symlink,
 __NR_mknod,
+#ifdef __NR_mkdirat
 __NR_mkdirat,
 __NR_mknodat,
 __NR_unlinkat,
 __NR_renameat,
 __NR_linkat,
 __NR_symlinkat,
+#endif
diff --git a/lib/audit.c b/lib/audit.c
index 8c21625..3b1289f 100644
--- a/lib/audit.c
+++ b/lib/audit.c
@@ -28,8 +28,10 @@ int audit_classify_syscall(int abi, unsi
 	switch(syscall) {
 	case __NR_open:
 		return 2;
+#ifdef __NR_openat
 	case __NR_openat:
 		return 3;
+#endif
 #ifdef __NR_socketcall
 	case __NR_socketcall:
 		return 4;
-- 
1.4.2.GIT

