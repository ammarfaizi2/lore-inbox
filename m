Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKOCRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKOCRK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUKOCQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:16:06 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:39661 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261417AbUKOCM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:12:29 -0500
Date: Sun, 14 Nov 2004 18:11:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
       Blaisorblade <blaisorblade_spam@yahoo.it>, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] - UML - cleanup include/asm-um/unistd.h
Message-ID: <20041115021159.GA11373@taniwha.stupidest.org>
References: <200411142304.iAEN4YbV013371@ccure.user-mode-linux.org> <200411150008.51110.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411150008.51110.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 12:08:49AM +0100, Arnd Bergmann wrote:

> Speaking of dead code: I think you should be able to mostly get rid
> of the KERNEL_CALL hack in include/asm-um/unistd.h, since all kernel
> syscalls except execve are now gone.

This from my quilt patches directory (just refreshed and tested (TT
only) again just now).  This might be a line or two large than it
otherwise should be due to whitespace changes...



Index: cw-current/include/asm-um/unistd.h
===================================================================
--- cw-current.orig/include/asm-um/unistd.h	2004-11-14 17:54:19.360054284 -0800
+++ cw-current/include/asm-um/unistd.h	2004-11-14 17:58:04.457939393 -0800
@@ -42,106 +42,29 @@
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
-
-static inline pid_t setsid(void)
-{
-	KERNEL_CALL(pid_t, sys_setsid)
-}
-
-static inline long lseek(unsigned int fd, off_t offset, unsigned int whence)
-{
-	KERNEL_CALL(long, sys_lseek, fd, offset, whence)
-}
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = um_execve(filename, argv, envp);
+	set_fs(fs);
 
-static inline int read(unsigned int fd, char * buf, int len)
-{
-	KERNEL_CALL(int, sys_read, fd, buf, len)
-}
+	if (ret >= 0)
+		return ret;
 
-static inline int write(unsigned int fd, char * buf, int len)
-{
-	KERNEL_CALL(int, sys_write, fd, buf, len)
+	errno = -(long)ret;
+	return -1;
 }
 
-long sys_mmap2(unsigned long addr, unsigned long len,
-		unsigned long prot, unsigned long flags,
-		unsigned long fd, unsigned long pgoff);
 int sys_execve(char *file, char **argv, char **env);
-long sys_clone(unsigned long clone_flags, unsigned long newsp,
-		int *parent_tid, int *child_tid);
-long sys_fork(void);
-long sys_vfork(void);
-int sys_pipe(unsigned long *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
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
+
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
