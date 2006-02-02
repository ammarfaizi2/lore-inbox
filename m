Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWBBFMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWBBFMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWBBFMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:12:46 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:26262 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1161121AbWBBFMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:12:45 -0500
Date: Thu, 2 Feb 2006 16:11:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>, linux-arch@vger.kernel.org
Subject: [PATCH] compat: fix compat_sys_openat and friends
Message-Id: <20060202161151.58839ffd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the 64 bit architectures will zero extend the first argument to
compat_sys_{openat,newfstatat,futimesat} which will fail if the 32 bit
syscall was passed AT_FDCWD (which is a small negative number).  Declare
the first argument to be an unsigned int which will force the correct
sign extension when the internal functions are called in each case.

Also, do some small white space cleanups in fs/compat.c.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 fs/compat.c              |   12 ++++++------
 include/linux/syscalls.h |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

This has been built on powerpc (and does the neede sign extension)
but not tested as we have yet to wire up the syscalls there.

Also, we will need compat wrappers for the other *at syscalls for
the same reason (sign extension of the first argument).

Also, I am wondering if we should move the declarations of the compat
syscalls to linux/compat.h (where all previous compat syscalls are
declated).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

13be12a8986f1e178e20f80b94e2fab7c46bc5fe
diff --git a/fs/compat.c b/fs/compat.c
index cc58a20..70c5af4 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -73,17 +73,17 @@ asmlinkage long compat_sys_utime(char __
 	return do_utimes(AT_FDCWD, filename, t ? tv : NULL);
 }
 
-asmlinkage long compat_sys_futimesat(int dfd, char __user *filename, struct compat_timeval __user *t)
+asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename, struct compat_timeval __user *t)
 {
 	struct timeval tv[2];
 
-	if (t) { 
+	if (t) {
 		if (get_user(tv[0].tv_sec, &t[0].tv_sec) ||
 		    get_user(tv[0].tv_usec, &t[0].tv_usec) ||
 		    get_user(tv[1].tv_sec, &t[1].tv_sec) ||
 		    get_user(tv[1].tv_usec, &t[1].tv_usec))
-			return -EFAULT; 
-	} 
+			return -EFAULT;
+	}
 	return do_utimes(dfd, filename, t ? tv : NULL);
 }
 
@@ -114,7 +114,7 @@ asmlinkage long compat_sys_newlstat(char
 	return error;
 }
 
-asmlinkage long compat_sys_newfstatat(int dfd, char __user *filename,
+asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user *filename,
 		struct compat_stat __user *statbuf, int flag)
 {
 	struct kstat stat;
@@ -1326,7 +1326,7 @@ compat_sys_open(const char __user *filen
  * O_LARGEFILE flag.
  */
 asmlinkage long
-compat_sys_openat(int dfd, const char __user *filename, int flags, int mode)
+compat_sys_openat(unsigned int dfd, const char __user *filename, int flags, int mode)
 {
 	return do_sys_open(dfd, filename, flags, mode);
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fdbd436..3877209 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -559,12 +559,12 @@ asmlinkage long sys_newfstatat(int dfd, 
 			       struct stat __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
-asmlinkage long compat_sys_futimesat(int dfd, char __user *filename,
+asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
 				     struct compat_timeval __user *t);
-asmlinkage long compat_sys_newfstatat(int dfd, char __user * filename,
+asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user * filename,
 				      struct compat_stat __user *statbuf,
 				      int flag);
-asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
+asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
 
 #endif
-- 
1.1.5
