Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWBFX5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWBFX5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBFX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:57:09 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:14982 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S964880AbWBFX5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:57:08 -0500
Date: Tue, 7 Feb 2006 10:56:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@osdl.org>,
       DaveM <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: [PATCH] compat: add compat functions for *at syscalls
Message-Id: <20060207105631.39a1080c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds compat version of all the remaining *at syscalls
so that the "dfd" arguments can be properly sign extended.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/sparc64/kernel/systbls.S |    6 ++--
 arch/x86_64/ia32/ia32entry.S  |   20 +++++++------
 fs/compat.c                   |   62 +++++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h        |   22 +++++++++++++++
 4 files changed, 97 insertions(+), 13 deletions(-)

I am not sure if sparc64 and x86_64 need these ...  they will be needed
for powerpc.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

02d254f5a4be0abf7e661eba77e8548083d24ddc
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 2881faf..a2cc631 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -77,9 +77,9 @@ sys_call_table32:
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
 	.word compat_sys_mq_timedsend, compat_sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
 /*280*/	.word sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl, compat_sys_openat
-	.word sys_mkdirat, sys_mknodat, sys_fchownat, compat_sys_futimesat, compat_sys_newfstatat
-/*285*/	.word sys_unlinkat, sys_renameat, sys_linkat, sys_symlinkat, sys_readlinkat
-	.word sys_fchmodat, sys_faccessat, compat_sys_pselect6, compat_sys_ppoll
+	.word compat_sys_mkdirat, compat_sys_mknodat, compat_sys_fchownat, compat_sys_futimesat, compat_sys_newfstatat
+/*285*/	.word compat_sys_unlinkat, compat_sys_renameat, compat_sys_linkat, compat_sys_symlinkat, compat_sys_readlinkat
+	.word compat_sys_fchmodat, compat_sys_faccessat, compat_sys_pselect6, compat_sys_ppoll
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index 067c0f4..2fe1c57 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -673,18 +673,18 @@ ia32_sys_call_table:
 	.quad sys_inotify_rm_watch
 	.quad sys_migrate_pages
 	.quad compat_sys_openat		/* 295 */
-	.quad sys_mkdirat
-	.quad sys_mknodat
-	.quad sys_fchownat
+	.quad compat_sys_mkdirat
+	.quad compat_sys_mknodat
+	.quad compat_sys_fchownat
 	.quad compat_sys_futimesat
 	.quad compat_sys_newfstatat	/* 300 */
-	.quad sys_unlinkat
-	.quad sys_renameat
-	.quad sys_linkat
-	.quad sys_symlinkat
-	.quad sys_readlinkat		/* 305 */
-	.quad sys_fchmodat
-	.quad sys_faccessat
+	.quad compat_sys_unlinkat
+	.quad compat_sys_renameat
+	.quad compat_sys_linkat
+	.quad compat_sys_symlinkat
+	.quad compat_sys_readlinkat	/* 305 */
+	.quad compat_sys_fchmodat
+	.quad compat_sys_faccessat
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
diff --git a/fs/compat.c b/fs/compat.c
index 70c5af4..55141a9 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1331,6 +1331,68 @@ compat_sys_openat(unsigned int dfd, cons
 	return do_sys_open(dfd, filename, flags, mode);
 }
 
+asmlinkage long compat_sys_mkdirat(unsigned int dfd,
+		const char __user * pathname, int mode)
+{
+	return sys_mkdirat(dfd, pathname, mode);
+}
+
+asmlinkage long compat_sys_mknodat(unsigned int dfd,
+		const char __user *filename, int mode, unsigned dev)
+{
+	return sys_mknodat(dfd, filename, mode, dev);
+}
+
+asmlinkage long compat_sys_fchownat(unsigned int dfd,
+		const char __user *filename, uid_t user, gid_t group, int flag)
+{
+	return sys_fchownat(dfd, filename, user, group, flag);
+}
+
+asmlinkage long compat_sys_unlinkat(unsigned int dfd,
+		const char __user *pathname, int flag)
+{
+	return sys_unlinkat(dfd, pathname, flag);
+}
+
+asmlinkage long compat_sys_renameat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname)
+{
+	return sys_renameat(olddfd, oldname, newdfd, newname);
+}
+
+asmlinkage long compat_sys_linkat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname)
+{
+	return sys_linkat(olddfd, oldname, newdfd, newname);
+}
+
+asmlinkage long compat_sys_symlinkat(const char __user *oldname,
+		unsigned int newdfd, const char __user *newname)
+{
+	return sys_symlinkat(oldname, newdfd, newname);
+}
+
+asmlinkage long compat_sys_readlinkat(unsigned int dfd,
+		const char __user *path, char __user *buf, int bufsiz)
+{
+	return sys_readlinkat(dfd, path, buf, bufsiz);
+}
+
+asmlinkage long compat_sys_fchmodat(unsigned int dfd,
+		const char __user *filename, mode_t mode)
+{
+	return sys_fchmodat(dfd, filename, mode);
+}
+
+asmlinkage long compat_sys_faccessat(unsigned int dfd,
+		const char __user *filename, int mode)
+{
+	return sys_faccessat(dfd, filename, mode);
+}
+
 /*
  * compat_count() counts the number of arguments/envelopes. It is basically
  * a copy of count() from fs/exec.c, except that it works with 32 bit argv
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 2d7e7f1..b501201 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -168,6 +168,28 @@ asmlinkage long compat_sys_newfstatat(un
 				      int flag);
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
+asmlinkage long compat_sys_mkdirat(unsigned int dfd,
+		const char __user * pathname, int mode);
+asmlinkage long compat_sys_mknodat(unsigned int dfd,
+		const char __user *filename, int mode, unsigned dev);
+asmlinkage long compat_sys_fchownat(unsigned int dfd,
+		const char __user *filename, uid_t user, gid_t group, int flag);
+asmlinkage long compat_sys_unlinkat(unsigned int dfd,
+		const char __user *pathname, int flag);
+asmlinkage long compat_sys_renameat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname);
+asmlinkage long compat_sys_linkat(unsigned int olddfd,
+		const char __user *oldname, unsigned int newdfd,
+		const char __user *newname);
+asmlinkage long compat_sys_symlinkat(const char __user *oldname,
+		unsigned int newdfd, const char __user *newname);
+asmlinkage long compat_sys_readlinkat(unsigned int dfd,
+		const char __user *path, char __user *buf, int bufsiz);
+asmlinkage long compat_sys_fchmodat(unsigned int dfd,
+		const char __user *filename, mode_t mode);
+asmlinkage long compat_sys_faccessat(unsigned int dfd,
+		const char __user *filename, int mode);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
-- 
1.1.5
