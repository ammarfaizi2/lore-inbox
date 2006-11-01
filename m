Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946532AbWKAFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946532AbWKAFnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946540AbWKAFnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:43:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52699 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946523AbWKAFmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:42:35 -0500
Message-Id: <20061101054208.865563000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:18 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Al Viro <viro@ftp.linux.org.uk>,
       Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 38/61] Audit: fix missing ifdefs in syscall classes hookup for generic targets
Content-Disposition: inline; filename=audit-fix-missing-ifdefs-in-syscall-classes-hookup-for-generic-targets.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@ftp.linux.org.uk>

[PATCH] fix missing ifdefs in syscall classes hookup for generic targets

several targets have no ....at() family and m32r calls its only chown variant
chown32(), with __NR_chown being undefined.  creat(2) is also absent in some
targets.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/asm-generic/audit_change_attr.h |    4 ++++
 include/asm-generic/audit_dir_write.h   |    4 ++++
 lib/audit.c                             |    2 ++
 3 files changed, 10 insertions(+)

--- linux-2.6.18.1.orig/include/asm-generic/audit_change_attr.h
+++ linux-2.6.18.1/include/asm-generic/audit_change_attr.h
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
--- linux-2.6.18.1.orig/include/asm-generic/audit_dir_write.h
+++ linux-2.6.18.1/include/asm-generic/audit_dir_write.h
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
--- linux-2.6.18.1.orig/lib/audit.c
+++ linux-2.6.18.1/lib/audit.c
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
