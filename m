Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUKYAa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUKYAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUKXXZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:25:53 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:26116
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262945AbUKXXUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:20:36 -0500
Message-Id: <200411242306.iAON6Vbn005403@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Chris Wedgwood <cw@f00f.org>
Subject: [PATCH] UML - unistd.h cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Nov 2004 18:06:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Chris Wedgewood - this removes unnecessary cruft from unistd.h

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/include/asm-um/unistd.h
===================================================================
--- 2.6.9.orig/include/asm-um/unistd.h	2004-11-14 21:50:38.000000000 -0500
+++ 2.6.9/include/asm-um/unistd.h	2004-11-14 21:54:06.000000000 -0500
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2000, 2001  Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2004  Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
 
@@ -41,105 +41,29 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
-#define KERNEL_CALL(ret_t, sys, args...)	\
-	mm_segment_t fs = get_fs();		\
-	ret_t ret;				\
-	set_fs(KERNEL_DS);			\
-	ret = sys(args);			\
-	set_fs(fs);				\
-	if (ret >= 0)				\
-		return ret;			\
-	errno = -(long)ret;			\
-	return -1;
-
-static inline long open(const char *pathname, int flags, int mode) 
-{
-	KERNEL_CALL(int, sys_open, pathname, flags, mode)
-}
-
-static inline long dup(unsigned int fd)
-{
-	KERNEL_CALL(int, sys_dup, fd);
-}
-
-static inline long close(unsigned int fd)
-{
-	KERNEL_CALL(int, sys_close, fd);
-}
-
-static inline int execve(const char *filename, char *const argv[], 
+static inline int execve(const char *filename, char *const argv[],
 			 char *const envp[])
 {
-	KERNEL_CALL(int, um_execve, filename, argv, envp);
-}
+	mm_segment_t fs;
+	int ret;
 
-static inline long waitpid(pid_t pid, unsigned int *status, int options)
-{
-	KERNEL_CALL(pid_t, sys_wait4, pid, status, options, NULL)
-}
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = um_execve(filename, argv, envp);
+	set_fs(fs);
 
-static inline pid_t setsid(void)
-{
-	KERNEL_CALL(pid_t, sys_setsid)
-}
-
-static inline off_t lseek(unsigned int fd, off_t offset, unsigned int whence)
-{
-	KERNEL_CALL(long, sys_lseek, fd, offset, whence)
-}
+	if (ret >= 0)
+		return ret;
 
-static inline int read(unsigned int fd, char * buf, int len)
-{
-	KERNEL_CALL(int, sys_read, fd, buf, len)
-}
-
-static inline int write(unsigned int fd, char * buf, int len)
-{
-	KERNEL_CALL(int, sys_write, fd, buf, len)
+	errno = -(long)ret;
+	return -1;
 }
+  
+int sys_execve(char *file, char **argv, char **env);
 
-long sys_mmap2(unsigned long addr, unsigned long len,
-		unsigned long prot, unsigned long flags,
-		unsigned long fd, unsigned long pgoff);
-long sys_execve(char *file, char **argv, char **env);
-long sys_clone(unsigned long clone_flags, unsigned long newsp,
-		int *parent_tid, int *child_tid);
-long sys_fork(void);
-long sys_vfork(void);
-long sys_pipe(unsigned long *fildes);
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
-
-#endif
-
-/* Save the value of __KERNEL_SYSCALLS__, undefine it, include the underlying
- * arch's unistd.h for the system call numbers, and restore the old 
- * __KERNEL_SYSCALLS__.
- */
-
-#ifdef __KERNEL_SYSCALLS__
-#define __SAVE_KERNEL_SYSCALLS__ __KERNEL_SYSCALLS__
-#endif
+#endif /* __KERNEL_SYSCALLS__ */
 
 #undef __KERNEL_SYSCALLS__
 #include "asm/arch/unistd.h"
 
-#ifdef __KERNEL_SYSCALLS__
-#define __KERNEL_SYSCALLS__ __SAVE_KERNEL_SYSCALLS__
-#endif
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif /* _UM_UNISTD_H_*/

