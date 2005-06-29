Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVF2Nsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVF2Nsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVF2Nsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:48:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19427 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262573AbVF2Nrs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:47:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Wed, 29 Jun 2005 15:42:01 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Zankel <chris@zankel.net>
References: <20050525134933.5c22234a.akpm@osdl.org> <200505272313.20734.arnd@arndb.de> <20050528070714.GB17005@infradead.org>
In-Reply-To: <20050528070714.GB17005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506291542.02618.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünnavend 28 Mai 2005 09:07, Christoph Hellwig wrote:
> On Fri, May 27, 2005 at 11:13:19PM +0200, Arnd Bergmann wrote:
> >
> > Chris, are there any existing binaries that rely on your implementations
> > of old_mmap, sys_fork, sys_vfork, sys_olduname or sys_ipc and need to
> > work with future kernels? Otherwise, you should probably drop these.
> > For sys_ipc, you would need to add the subcalls directly to the table,
> > like parisc does.
> 
> We should do that either way.  If people have existing binaries relying
> on broken thing before submitting ports for review it's their fault.
> 
Hmm, xtensa is now in -rc1, with the obsolete syscalls still in there,
so I guess this about the last chance to correct the ABI. Applying the
patch obviously breaks all sorts of user space binaries and probably
also requires the appropriate changes to be made to libc.

On the other hand, if a decision is made to keep the broken interface,
it should at least be a conscious one instead of an oversight.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

 arch/xtensa/kernel/syscalls.c |  152 ------------------------------------------
 arch/xtensa/kernel/syscalls.h |   57 +++++++--------
 include/asm-xtensa/unistd.h   |   98 ---------------------------
 3 files changed, 30 insertions(+), 277 deletions(-)

Index: linus-2.6/arch/xtensa/kernel/syscalls.c
===================================================================
--- linus-2.6.orig/arch/xtensa/kernel/syscalls.c	2005-06-26 14:18:15.000000000 +0200
+++ linus-2.6/arch/xtensa/kernel/syscalls.c	2005-06-28 23:53:20.291408624 +0200
@@ -46,8 +46,6 @@
 
 extern void do_syscall_trace(void);
 typedef int (*syscall_t)(void *a0,...);
-extern int (*do_syscalls)(struct pt_regs *regs, syscall_t fun,
-				     int narg);
 extern syscall_t sys_call_table[];
 extern unsigned char sys_narg_table[];
 
@@ -72,10 +70,8 @@
 /*
  * Common code for old and new mmaps.
  */
-
-static inline long do_mmap2(unsigned long addr, unsigned long len,
-    			    unsigned long prot, unsigned long flags,
-			    unsigned long fd, unsigned long pgoff)
+long sys_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
+	       unsigned long flags, unsigned long fd, unsigned long pgoff)
 {
 	int error = -EBADF;
 	struct file * file = NULL;
@@ -97,29 +93,6 @@
 	return error;
 }
 
-unsigned long old_mmap(unsigned long addr, size_t len, int prot,
-		       int flags, int fd, off_t offset)
-{
-	return do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
-}
-
-long sys_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
-	       unsigned long flags, unsigned long fd, unsigned long pgoff)
-{
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
-}
-
-int sys_fork(struct pt_regs *regs)
-{
-	return do_fork(SIGCHLD, regs->areg[1], regs, 0, NULL, NULL);
-}
-
-int sys_vfork(struct pt_regs *regs)
-{
-	return do_fork(CLONE_VFORK|CLONE_VM|SIGCHLD, regs->areg[1],
-		       regs, 0, NULL, NULL);
-}
-
 int sys_clone(struct pt_regs *regs)
 {
 	unsigned long clone_flags;
@@ -162,30 +135,6 @@
 	return -EFAULT;
 }
 
-int sys_olduname(struct oldold_utsname * name)
-{
-	int error;
-
-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-
-	error = __copy_to_user(&name->sysname,&system_utsname.sysname,__OLD_UTS_LEN);
-	error -= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->nodename,&system_utsname.nodename,__OLD_UTS_LEN);
-	error -= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->release,&system_utsname.release,__OLD_UTS_LEN);
-	error -= __put_user(0,name->release+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->version,&system_utsname.version,__OLD_UTS_LEN);
-	error -= __put_user(0,name->version+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->machine,&system_utsname.machine,__OLD_UTS_LEN);
-	error -= __put_user(0,name->machine+__OLD_UTS_LEN);
-
-	return error ? -EFAULT : 0;
-}
-
-
 /*
  * Build the string table for the builtin "poor man's strace".
  */
@@ -319,100 +268,3 @@
 	regs->areg[2] = res;
 	do_syscall_trace();
 }
-
-/*
- * sys_ipc() is the de-multiplexer for the SysV IPC calls..
- *
- * This is really horribly ugly.
- */
-
-int sys_ipc (uint call, int first, int second,
-			int third, void __user *ptr, long fifth)
-{
-	int version, ret;
-
-	version = call >> 16; /* hack for backward compatibility */
-	call &= 0xffff;
-	ret = -ENOSYS;
-
-	switch (call) {
-	case SEMOP:
-		ret = sys_semtimedop (first, (struct sembuf __user *)ptr,
-				     second, NULL);
-		break;
-
-	case SEMTIMEDOP:
-		ret = sys_semtimedop (first, (struct sembuf __user *)ptr,
-				      second, (const struct timespec *) fifth);
-		break;
-
-	case SEMGET:
-		ret = sys_semget (first, second, third);
-		break;
-
-	case SEMCTL: {
-		union semun fourth;
-
-		if (ptr && !get_user(fourth.__pad, (void *__user *) ptr))
-			ret = sys_semctl (first, second, third, fourth);
-		break;
-		}
-
-	case MSGSND:
-		ret = sys_msgsnd (first, (struct msgbuf __user*) ptr,
-				  second, third);
-		break;
-
-	case MSGRCV:
-		switch (version) {
-		case 0: {
-			struct ipc_kludge tmp;
-
-			if (ptr && !copy_from_user(&tmp,
-					   (struct ipc_kludge *) ptr,
-					   sizeof (tmp)))
-				ret = sys_msgrcv (first, tmp.msgp, second,
-						  tmp.msgtyp, third);
-			break;
-			}
-
-		default:
-			ret = sys_msgrcv (first, (struct msgbuf __user *) ptr,
-					  second, 0, third);
-			break;
-		}
-		break;
-
-	case MSGGET:
-		ret = sys_msgget ((key_t) first, second);
-		break;
-
-	case MSGCTL:
-		ret = sys_msgctl (first, second, (struct msqid_ds __user*) ptr);
-		break;
-
-	case SHMAT: {
-		ulong raddr;
-		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
-
-		if (!ret)
-			ret = put_user (raddr, (ulong __user *) third);
-
-		break;
-		}
-
-	case SHMDT:
-		ret = sys_shmdt ((char __user *)ptr);
-		break;
-
-	case SHMGET:
-		ret = sys_shmget (first, second, third);
-		break;
-
-	case SHMCTL:
-		ret = sys_shmctl (first, second, (struct shmid_ds __user*) ptr);
-		break;
-	}
-	return ret;
-}
-
Index: linus-2.6/include/asm-xtensa/unistd.h
===================================================================
--- linus-2.6.orig/include/asm-xtensa/unistd.h	2005-06-26 14:18:16.000000000 +0200
+++ linus-2.6/include/asm-xtensa/unistd.h	2005-06-29 00:28:54.407973592 +0200
@@ -13,42 +13,31 @@
 
 #include <linux/linkage.h>
 
-//#define __NR_setup		  0 /* used only by init, to get system going */
 #define __NR_spill		  0
 #define __NR_exit		  1
-#define __NR_fork		  2
 #define __NR_read		  3
 #define __NR_write		  4
 #define __NR_open		  5
 #define __NR_close		  6
-#define __NR_waitpid		  7
 #define __NR_creat		  8
 #define __NR_link		  9
 #define __NR_unlink		 10
 #define __NR_execve		 11
 #define __NR_chdir		 12
-#define __NR_time		 13
 #define __NR_mknod		 14
 #define __NR_chmod		 15
 #define __NR_lchown		 16
 #define __NR_break		 17
-#define __NR_oldstat		 18
 #define __NR_lseek		 19
 #define __NR_getpid		 20
 #define __NR_mount		 21
-#define __NR_oldumount		 22
 #define __NR_setuid		 23
 #define __NR_getuid		 24
-#define __NR_stime		 25
 #define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
 #define __NR_utime		 30
 #define __NR_stty		 31
 #define __NR_gtty		 32
 #define __NR_access		 33
-#define __NR_nice		 34
 #define __NR_ftime		 35
 #define __NR_sync		 36
 #define __NR_kill		 37
@@ -66,24 +55,18 @@
 #define __NR_geteuid		 49
 #define __NR_getegid		 50
 #define __NR_acct		 51
-#define __NR_umount		 52
 #define __NR_lock		 53
 #define __NR_ioctl		 54
 #define __NR_fcntl		 55
-#define __NR_mpx		 56
 #define __NR_setpgid		 57
 #define __NR_ulimit		 58
-#define __NR_oldolduname	 59
 #define __NR_umask		 60
 #define __NR_chroot		 61
 #define __NR_ustat		 62
 #define __NR_dup2		 63
 #define __NR_getppid		 64
-#define __NR_getpgrp		 65
 #define __NR_setsid		 66
 #define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
 #define __NR_setreuid		 70
 #define __NR_setregid		 71
 #define __NR_sigsuspend		 72
@@ -98,13 +81,10 @@
 #define __NR_setgroups		 81
 #define __NR_select		 82
 #define __NR_symlink		 83
-#define __NR_oldlstat		 84
 #define __NR_readlink		 85
 #define __NR_uselib		 86
 #define __NR_swapon		 87
 #define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
 #define __NR_munmap		 91
 #define __NR_truncate		 92
 #define __NR_ftruncate		 93
@@ -116,22 +96,18 @@
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
 #define __NR_ioperm		101
-#define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
 #define __NR_getitimer		105
 #define __NR_stat		106
 #define __NR_lstat		107
 #define __NR_fstat		108
-#define __NR_olduname		109
 #define __NR_iopl		110
 #define __NR_vhangup		111
 #define __NR_idle		112
-#define __NR_vm86		113
 #define __NR_wait4		114
 #define __NR_swapoff		115
 #define __NR_sysinfo		116
-#define __NR_ipc		117
 #define __NR_fsync		118
 #define __NR_sigreturn		119
 #define __NR_clone		120
@@ -140,18 +116,15 @@
 #define __NR_modify_ldt		123
 #define __NR_adjtimex		124
 #define __NR_mprotect		125
-#define __NR_sigprocmask	126
 #define __NR_create_module	127
 #define __NR_init_module	128
 #define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
 #define __NR_bdflush		134
 #define __NR_sysfs		135
 #define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
 #define __NR_setfsuid		138
 #define __NR_setfsgid		139
 #define __NR__llseek		140
@@ -222,8 +195,6 @@
 #define __NR_capset		205
 #define __NR_sigaltstack	206
 #define __NR_sendfile		207
-#define __NR_streams1		208	/* some people actually want it */
-#define __NR_streams2		209	/* some people actually want it */
 #define __NR_mmap2		210
 #define __NR_truncate64		211
 #define __NR_ftruncate64	212
@@ -234,7 +205,6 @@
 #define __NR_mincore		217
 #define __NR_madvise		218
 #define __NR_getdents64		219
-#define __NR_vfork		220
 
 /* Keep this last; should always equal the last valid call number. */
 #define __NR_Linux_syscalls     220
@@ -448,55 +418,7 @@
 
 
 #ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/syscalls.h>
-
-/*
- * we need this inline - forking from kernel space will result
- * in NO COPY ON WRITE (!!!), until an execve is executed. This
- * is no problem, but for the stack. This is handled by not letting
- * main() use the stack at all after fork(). Thus, no function
- * calls - which means inline code for fork too, as otherwise we
- * would use the stack upon exit from 'fork()'.
- *
- * Actually only pause and fork are needed inline, so that there
- * won't be any messing with the stack from main(), but we define
- * some others too.
- */
-
-#define __NR__exit __NR_exit
-
-static __inline__ _syscall0(int,pause)
-//static __inline__ _syscall1(int,setup,int,magic) FIXME
-static __inline__ _syscall0(int,sync)
-static __inline__ _syscall0(pid_t,setsid)
-static __inline__ _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static __inline__ _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static __inline__ _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static __inline__ _syscall1(int,dup,int,fd)
 static __inline__ _syscall3(int,execve,const char*,file,char**,argv,char**,envp)
-static __inline__ _syscall3(int,open,const char *,file,int,flag,int,mode)
-static __inline__ _syscall1(int,close,int,fd)
-static __inline__ _syscall1(int,_exit,int,exitcode)
-static __inline__ _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static __inline__ _syscall1(int,delete_module,const char *,name)
-
-struct stat;
-static __inline__ _syscall2(int,fstat,int,fd,struct stat *,buf)
-static __inline__ _syscall0(pid_t,getpid)
-static __inline__ _syscall2(int,kill,int,pid,int,sig)
-static __inline__ _syscall2(int,stat,const char *, path,struct stat *,buf)
-static __inline__ _syscall1(int,unlink,char *,pathname)
-
-
-
-extern pid_t waitpid(int, int*, int );
-static __inline__ pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 #endif
 
 /*
@@ -508,30 +430,10 @@
 #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
 
 #ifdef __KERNEL__
-#define __ARCH_WANT_IPC_PARSE_VERSION
-#define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYS_ALARM
-#define __ARCH_WANT_SYS_GETHOSTNAME
-#define __ARCH_WANT_SYS_PAUSE
-#define __ARCH_WANT_SYS_SGETMASK
-#define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_WAITPID
-#define __ARCH_WANT_SYS_SOCKETCALL
-#define __ARCH_WANT_SYS_FADVISE64
-#define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
-#define __ARCH_WANT_SYS_NICE
-#define __ARCH_WANT_SYS_OLD_GETRLIMIT
-#define __ARCH_WANT_SYS_OLDUMOUNT
-#define __ARCH_WANT_SYS_SIGPENDING
-#define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
-
-
 #endif	/* _XTENSA_UNISTD_H */
Index: linus-2.6/arch/xtensa/kernel/syscalls.h
===================================================================
--- linus-2.6.orig/arch/xtensa/kernel/syscalls.h	2005-06-28 23:53:14.458295392 +0200
+++ linus-2.6/arch/xtensa/kernel/syscalls.h	2005-06-29 00:11:34.759024256 +0200
@@ -25,20 +25,19 @@
  */
 
 SYSCALL(0, 0)		                /* 00 */
-
 SYSCALL(sys_exit, 1)
-SYSCALL(sys_fork, 0)
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_read, 3)
 SYSCALL(sys_write, 3)
 SYSCALL(sys_open, 3)			/* 05 */
 SYSCALL(sys_close, 1)
-SYSCALL(sys_waitpid, 3)
+SYSCALL(sys_ni_syscall, 3)
 SYSCALL(sys_creat, 2)
 SYSCALL(sys_link, 2)
 SYSCALL(sys_unlink, 1)			/* 10 */
 SYSCALL(sys_execve, 0)
 SYSCALL(sys_chdir, 1)
-SYSCALL(sys_time, 1)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_mknod, 3)
 SYSCALL(sys_chmod, 2)			/* 15 */
 SYSCALL(sys_lchown, 3)
@@ -47,19 +46,19 @@
 SYSCALL(sys_lseek, 3)
 SYSCALL(sys_getpid, 0)			/* 20 */
 SYSCALL(sys_mount, 5)
-SYSCALL(sys_oldumount, 1)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_setuid, 1)
 SYSCALL(sys_getuid, 0)
-SYSCALL(sys_stime, 1)			/* 25 */
+SYSCALL(sys_ni_syscall, 1)		/* 25 */
 SYSCALL(sys_ptrace, 4)
-SYSCALL(sys_alarm, 1)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_fstat, 2)
-SYSCALL(sys_pause, 0)
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_utime, 2)			/* 30 */
 SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_access, 2)
-SYSCALL(sys_nice, 1)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_ni_syscall, 0)		/* 35 */
 SYSCALL(sys_sync, 0)
 SYSCALL(sys_kill, 2)
@@ -73,7 +72,7 @@
 SYSCALL(sys_brk, 1)			/* 45 */
 SYSCALL(sys_setgid, 1)
 SYSCALL(sys_getgid, 0)
-SYSCALL(sys_ni_syscall, 0)		/* was signal(2) */
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_geteuid, 0)
 SYSCALL(sys_getegid, 0)			/* 50 */
 SYSCALL(sys_acct, 1)
@@ -84,21 +83,21 @@
 SYSCALL(sys_ni_syscall, 2)
 SYSCALL(sys_setpgid, 2)
 SYSCALL(sys_ni_syscall, 0)
-SYSCALL(sys_olduname, 1)
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_umask, 1)			/* 60 */
 SYSCALL(sys_chroot, 1)
 SYSCALL(sys_ustat, 2)
 SYSCALL(sys_dup2, 2)
 SYSCALL(sys_getppid, 0)
-SYSCALL(sys_getpgrp, 0)			/* 65 */
+SYSCALL(sys_ni_syscall, 0)		/* 65 */
 SYSCALL(sys_setsid, 0)
 SYSCALL(sys_sigaction, 3)
-SYSCALL(sys_sgetmask, 0)
-SYSCALL(sys_ssetmask, 1)
+SYSCALL(sys_ni_syscall, 0)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_setreuid, 2)		/* 70 */
 SYSCALL(sys_setregid, 2)
 SYSCALL(sys_sigsuspend, 0)
-SYSCALL(sys_sigpending, 1)
+SYSCALL(sys_ni_syscall, 1)
 SYSCALL(sys_sethostname, 2)
 SYSCALL(sys_setrlimit, 2)		/* 75 */
 SYSCALL(sys_getrlimit, 2)
@@ -107,15 +106,15 @@
 SYSCALL(sys_settimeofday, 2)
 SYSCALL(sys_getgroups, 2)		/* 80 */
 SYSCALL(sys_setgroups, 2)
-SYSCALL(sys_ni_syscall, 0)		 /* old_select */
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_symlink, 2)
 SYSCALL(sys_lstat, 2)
 SYSCALL(sys_readlink, 3)		/* 85 */
 SYSCALL(sys_uselib, 1)
 SYSCALL(sys_swapon, 2)
 SYSCALL(sys_reboot, 3)
-SYSCALL(old_readdir, 3)
-SYSCALL(old_mmap, 6)			/* 90 */
+SYSCALL(sys_ni_syscall, 3)
+SYSCALL(sys_ni_syscall, 6)		/* 90 */
 SYSCALL(sys_munmap, 2)
 SYSCALL(sys_truncate, 2)
 SYSCALL(sys_ftruncate, 2)
@@ -127,7 +126,7 @@
 SYSCALL(sys_statfs, 2)
 SYSCALL(sys_fstatfs, 2)			/* 100 */
 SYSCALL(sys_ni_syscall, 3)
-SYSCALL(sys_socketcall, 2)
+SYSCALL(sys_ni_syscall, 2)
 SYSCALL(sys_syslog, 3)
 SYSCALL(sys_setitimer, 3)
 SYSCALL(sys_getitimer, 2)		/* 105 */
@@ -137,32 +136,32 @@
 SYSCALL(sys_uname, 1)
 SYSCALL(sys_ni_syscall, 0)		/* 110 */
 SYSCALL(sys_vhangup, 0)
-SYSCALL(sys_ni_syscall, 0)		/* was sys_idle() */
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_wait4, 4)
 SYSCALL(sys_swapoff, 1)			/* 115 */
 SYSCALL(sys_sysinfo, 1)
-SYSCALL(sys_ipc, 5)   			/* 6 really, but glibc uses only 5) */
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_fsync, 1)
 SYSCALL(sys_sigreturn, 0)
 SYSCALL(sys_clone, 0)			/* 120 */
 SYSCALL(sys_setdomainname, 2)
 SYSCALL(sys_newuname, 1)
-SYSCALL(sys_ni_syscall, 0) 		/* sys_modify_ldt */
+SYSCALL(sys_ni_syscall, 0) 
 SYSCALL(sys_adjtimex, 1)
 SYSCALL(sys_mprotect, 3)		/* 125 */
-SYSCALL(sys_sigprocmask, 3)
-SYSCALL(sys_ni_syscall, 2)		/* old sys_create_module */
+SYSCALL(sys_ni_syscall, 3)
+SYSCALL(sys_ni_syscall, 2)
 SYSCALL(sys_init_module, 2)
 SYSCALL(sys_delete_module, 1)
-SYSCALL(sys_ni_syscall, 1)		/* old sys_get_kernel_sysm */	/* 130 */
+SYSCALL(sys_ni_syscall, 1)		/* 130 */
 SYSCALL(sys_quotactl, 0)
 SYSCALL(sys_getpgid, 1)
 SYSCALL(sys_fchdir, 1)
 SYSCALL(sys_bdflush, 2)
 SYSCALL(sys_sysfs, 3)			/* 135 */
 SYSCALL(sys_personality, 1)
-SYSCALL(sys_ni_syscall, 0)		/* for afs_syscall */
+SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_setfsuid, 1)
 SYSCALL(sys_setfsgid, 1)
 SYSCALL(sys_llseek, 5)			/* 140 */
@@ -212,7 +211,7 @@
 SYSCALL(sys_socketpair, 4)
 SYSCALL(sys_setresuid, 3)		/* 185 */
 SYSCALL(sys_getresuid, 3)
-SYSCALL(sys_ni_syscall, 5)		/* old sys_query_module */
+SYSCALL(sys_ni_syscall, 5)
 SYSCALL(sys_poll, 3)
 SYSCALL(sys_nfsservctl, 3)
 SYSCALL(sys_setresgid, 3)		/* 190 */
@@ -235,7 +234,7 @@
 SYSCALL(sys_sendfile, 4)
 SYSCALL(sys_ni_syscall, 0)
 SYSCALL(sys_ni_syscall, 0)
-SYSCALL(sys_mmap2, 6)			/* 210 */
+SYSCALL(sys_mmap, 6)			/* 210 */
 SYSCALL(sys_truncate64, 2)
 SYSCALL(sys_ftruncate64, 2)
 SYSCALL(sys_stat64, 2)
@@ -245,4 +244,4 @@
 SYSCALL(sys_mincore, 3)
 SYSCALL(sys_madvise, 3)
 SYSCALL(sys_getdents64, 3)
-SYSCALL(sys_vfork, 0)			/* 220 */
+SYSCALL(sys_ni_syscall, 0)		/* 220 */
