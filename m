Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286299AbRLJQUO>; Mon, 10 Dec 2001 11:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286301AbRLJQUG>; Mon, 10 Dec 2001 11:20:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:39428 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S286299AbRLJQTw>; Mon, 10 Dec 2001 11:19:52 -0500
Date: Mon, 10 Dec 2001 19:19:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.5.1-pre8: kernel mode syscalls wrapper
Message-ID: <20011210191938.A5002@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent stuff in init/do_mounts.c broke alpha, because
it seems to be the only platform which doesn't allow syscalls
from kernel mode. Fixed with kernel space _syscallN macros.

Ivan.

--- 2.5.1p8/include/asm-alpha/unistd.h	Mon Dec 10 13:50:30 2001
+++ linux/include/asm-alpha/unistd.h	Mon Dec 10 16:43:29 2001
@@ -319,7 +319,7 @@
 #define __NR_readahead			379
 #define __NR_security			380 /* syscall for security modules */
 
-#if defined(__GNUC__)
+#if defined(__GNUC__) && !defined(__KERNEL_SYSCALLS__)
 
 #define _syscall_return(type)						\
 	return (_sc_err ? errno = _sc_ret, _sc_ret = -1L : 0), (type) _sc_ret
@@ -499,60 +499,89 @@ type name (type1 arg1,type2 arg2,type3 a
 	_syscall_return(type);						\
 }
 
-#endif /* __LIBRARY__ && __GNUC__ */
+#endif /* __LIBRARY__ && __GNUC__ && !__KERNEL_SYSCALLS__ */
 
 #ifdef __KERNEL_SYSCALLS__
 
 #include <linux/string.h>
 #include <linux/signal.h>
 
-extern void sys_idle(void);
-static inline void idle(void)
-{
-	sys_idle();
-}
+extern void *sys_call_table[];
 
-extern long sys_open(const char *, int, int);
-static inline long open(const char * name, int mode, int flags)
-{
-	return sys_open(name, mode, flags);
+#define _syscall0(type,name)						\
+type name(void)								\
+{									\
+	type (*syscall_ptr)(void) = sys_call_table[__NR_##name];	\
+	return syscall_ptr();						\
 }
 
-extern long sys_dup(int);
-static inline long dup(int fd)
-{
-	return sys_dup(fd);
+#define _syscall1(type,name,type1,arg1)					\
+type name(type1 arg1)							\
+{									\
+	type (*syscall_ptr)(type1);					\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1);					\
 }
 
-static inline long close(int fd)
-{
-	return sys_close(fd);
+#define _syscall2(type,name,type1,arg1,type2,arg2)			\
+type name(type1 arg1, type2 arg2)					\
+{									\
+	type (*syscall_ptr)(type1, type2);				\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1, arg2);					\
 }
 
-extern off_t sys_lseek(int, off_t, int);
-static inline off_t lseek(int fd, off_t off, int whense)
-{
-	return sys_lseek(fd, off, whense);
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
+type name(type1 arg1, type2 arg2, type3 arg3)				\
+{									\
+	type (*syscall_ptr)(type1, type2, type3);			\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1, arg2, arg3);				\
 }
 
-extern long sys_exit(int);
-static inline long _exit(int value)
-{
-	return sys_exit(value);
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4)		\
+{									\
+	type (*syscall_ptr)(type1, type2, type3, type4);		\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1, arg2, arg3, arg4);			\
 }
 
-#define exit(x) _exit(x)
-
-extern long sys_write(int, const char *, int);
-static inline long write(int fd, const char * buf, int nr)
-{
-	return sys_write(fd, buf, nr);
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,\
+		  type5,arg5)						\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
+{									\
+	type (*syscall_ptr)(type1, type2, type3, type4, type5);		\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1, arg2, arg3, arg4, arg5);		\
 }
 
-extern long sys_read(int, char *, int);
-static inline long read(int fd, char * buf, int nr)
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,\
+		  type5,arg5,type6,arg6)				\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5,	\
+	  type6 arg6)							\
+{									\
+	type (*syscall_ptr)(type1, type2, type3, type4, type5, type6);	\
+	syscall_ptr = sys_call_table[__NR_##name];			\
+	return syscall_ptr(arg1, arg2, arg3, arg4, arg5, arg6);		\
+}
+
+#define __NR__exit __NR_exit
+static inline _syscall0(int,sync)
+static inline _syscall0(pid_t,setsid)
+static inline _syscall3(long,write,int,fd,const char *,buf,off_t,count)
+static inline _syscall3(long,read,int,fd,char *,buf,off_t,count)
+static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
+static inline _syscall1(int,dup,int,fd)
+static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
+static inline _syscall1(int,close,int,fd)
+static inline _syscall1(long,_exit,int,exitcode)
+static inline _syscall1(long,delete_module,const char *,name)
+
+extern void sys_idle(void);
+static inline void idle(void)
 {
-	return sys_read(fd, buf, nr);
+	sys_idle();
 }
 
 extern int __kernel_execve(char *, char **, char **, struct pt_regs *);
@@ -563,18 +592,6 @@ static inline long execve(char * file, c
 	return __kernel_execve(file, argvp, envp, &regs);
 }
 
-extern long sys_setsid(void);
-static inline long setsid(void)
-{
-	return sys_setsid();
-}
-
-extern long sys_sync(void);
-static inline long sync(void)
-{
-	return sys_sync();
-}
-
 static inline pid_t waitpid(int pid, int * wait_stat, int flags)
 {
 	return sys_wait4(pid, wait_stat, flags, NULL);
@@ -583,12 +600,6 @@ static inline pid_t waitpid(int pid, int
 static inline pid_t wait(int * wait_stat)
 {
 	return waitpid(-1,wait_stat,0);
-}
-
-extern long sys_delete_module(const char *name);
-static inline long delete_module(const char *name)
-{
-	return sys_delete_module(name);
 }
 
 #endif
--- 2.5.1p8/arch/alpha/kernel/alpha_ksyms.c	Mon Dec 10 13:43:18 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Mon Dec 10 16:50:47 2001
@@ -152,15 +152,7 @@ EXPORT_SYMBOL(alpha_write_fp_reg_s);
 
 /* In-kernel system calls.  */
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(sys_open);
-EXPORT_SYMBOL(sys_dup);
-EXPORT_SYMBOL(sys_exit);
-EXPORT_SYMBOL(sys_write);
-EXPORT_SYMBOL(sys_read);
-EXPORT_SYMBOL(sys_lseek);
 EXPORT_SYMBOL(__kernel_execve);
-EXPORT_SYMBOL(sys_setsid);
-EXPORT_SYMBOL(sys_sync);
 EXPORT_SYMBOL(sys_wait4);
 
 /* Networking helper routines. */
