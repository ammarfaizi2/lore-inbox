Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSLEQbo>; Thu, 5 Dec 2002 11:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSLEQaO>; Thu, 5 Dec 2002 11:30:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42234 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264001AbSLEQ3u>;
	Thu, 5 Dec 2002 11:29:50 -0500
Message-ID: <3DEF8046.8A0C5ED9@mvista.com>
Date: Thu, 05 Dec 2002 08:35:18 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@ccur.com
CC: Linus Torvalds <torvalds@transmeta.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212042009340.11869-100000@home.transmeta.com> <3DEF20E2.5AEE3E78@mvista.com> <3DEF6FC9.AFF1EB0B@ccur.com>
Content-Type: multipart/mixed;
 boundary="------------8A6C43A0A86963BB30A45970"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------8A6C43A0A86963BB30A45970
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jim Houston wrote:
> 
> Hi Linus, George,
> 
> I like the direction that this ERESTART_RESTARTBLOCK patch is
> going.
> 
> It might be nice to clear the restart_block.fun in handle_signal()
> in the ERESTART_RESTARTBLOCK path which returns -EINTR.  This eliminates
> the chance of a stale restart.

How is this?

Note that we do leave tracks in user land when this happens
as the return array is set on the restart exit.  Since we
don't know what it was AND the standard says NOTHING about
it being set (or not set) if there is no error, I don't
think this is a problem.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------8A6C43A0A86963BB30A45970
Content-Type: text/plain; charset=us-ascii;
 name="regs-fix-2.5.50-bk4.1.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regs-fix-2.5.50-bk4.1.1.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.50-bk4-kb/arch/i386/kernel/entry.S	Wed Dec  4 23:28:20 2002
+++ linux/arch/i386/kernel/entry.S	Wed Dec  4 23:48:49 2002
@@ -769,6 +769,7 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
+	.long sys_restart_syscall
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/arch/i386/kernel/signal.c linux/arch/i386/kernel/signal.c
--- linux-2.5.50-bk4-kb/arch/i386/kernel/signal.c	Thu Oct  3 10:41:57 2002
+++ linux/arch/i386/kernel/signal.c	Thu Dec  5 08:16:30 2002
@@ -506,6 +506,8 @@
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
 		switch (regs->eax) {
+		        case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fun = NULL;
 			case -ERESTARTNOHAND:
 				regs->eax = -EINTR;
 				break;
@@ -589,6 +591,10 @@
 		    regs->eax == -ERESTARTSYS ||
 		    regs->eax == -ERESTARTNOINTR) {
 			regs->eax = regs->orig_eax;
+			regs->eip -= 2;
+		}
+		if (regs->eax == -ERESTART_RESTARTBLOCK){
+			regs->eax = __NR_restart_syscall;
 			regs->eip -= 2;
 		}
 	}
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/include/asm-i386/thread_info.h linux/include/asm-i386/thread_info.h
--- linux-2.5.50-bk4-kb/include/asm-i386/thread_info.h	Mon Sep  9 10:35:03 2002
+++ linux/include/asm-i386/thread_info.h	Thu Dec  5 01:07:23 2002
@@ -20,6 +20,12 @@
  * - if the contents of this structure are changed, the assembly constants must also be changed
  */
 #ifndef __ASSEMBLY__
+struct restart_block {
+	int (*fun)(void *);
+	long arg0;
+	long arg1;
+};
+
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
@@ -31,6 +37,7 @@
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct restart_block    restart_block;
 
 	__u8			supervisor_stack[0];
 };
@@ -44,6 +51,7 @@
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
+#define TI_RESTART_BLOCK 0x0000018
 
 #endif
 
@@ -63,6 +71,9 @@
 	.cpu		= 0,			\
 	.preempt_count	= 1,			\
 	.addr_limit	= KERNEL_DS,		\
+	.restart_block = {                      \
+		.fun = 0,                       \
+	},		                        \
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.50-bk4-kb/include/asm-i386/unistd.h	Wed Nov 27 15:49:22 2002
+++ linux/include/asm-i386/unistd.h	Wed Dec  4 23:48:46 2002
@@ -263,7 +263,7 @@
 #define __NR_sys_epoll_wait	256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
-
+#define __NR_restart_syscall    259
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/include/linux/errno.h linux/include/linux/errno.h
--- linux-2.5.50-bk4-kb/include/linux/errno.h	Mon Sep  9 10:35:15 2002
+++ linux/include/linux/errno.h	Wed Dec  4 23:53:21 2002
@@ -10,6 +10,7 @@
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
+#define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/kernel/signal.c linux/kernel/signal.c
--- linux-2.5.50-bk4-kb/kernel/signal.c	Wed Dec  4 23:27:02 2002
+++ linux/kernel/signal.c	Thu Dec  5 01:18:20 2002
@@ -1351,6 +1351,15 @@
  * System call entry points.
  */
 
+asmlinkage long
+sys_restart_syscall( void *parm)
+{
+	if ( ! current_thread_info()->restart_block.fun){
+		return current_thread_info()->restart_block.fun(&parm);
+	}
+	return -ENOSYS;
+}
+
 /*
  * We don't need to get the kernel lock - this is all local to this
  * particular thread.. (and that's good, because this is _heavily_
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk4-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.50-bk4-kb/kernel/timer.c	Wed Dec  4 23:27:02 2002
+++ linux/kernel/timer.c	Thu Dec  5 01:16:03 2002
@@ -1020,19 +1020,39 @@
 	return current->pid;
 }
 
+struct nano_sleep_call {
+	struct timespec *rqtp; 
+	struct timespec *rmtp;
+};
+
+asmlinkage long sys_nanosleep_restart( struct nano_sleep_call * parms);
+
 asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
 {
 	struct timespec t;
 	unsigned long expire;
+	struct  restart_block *restart_block;
 
-	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
-		return -EFAULT;
-
-	if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
-		return -EINVAL;
+	if (rqtp) {
+		if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
+			return -EFAULT;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+		if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
+			return -EINVAL;
+		expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
 
+	}else{
+		restart_block = &current_thread_info()->restart_block;
+		if( restart_block->fun != 
+		    (int (*)(void *))sys_nanosleep_restart ||
+		    ! restart_block->arg0){
+			return  -EFAULT;
+		}
+		restart_block->fun = NULL;
+		expire = restart_block->arg0 - jiffies;
+		if (expire < 0)
+			return 0;
+	}
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
@@ -1042,10 +1062,19 @@
 			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
 				return -EFAULT;
 		}
-		return -EINTR;
+		restart_block = &current_thread_info()->restart_block;
+		restart_block->fun = (int (*)(void *))sys_nanosleep_restart;
+		restart_block->arg0 = jiffies + expire;
+		return -ERESTART_RESTARTBLOCK;
 	}
 	return 0;
 }
+
+asmlinkage long sys_nanosleep_restart( struct nano_sleep_call * parms)
+{
+	return sys_nanosleep(NULL, parms->rmtp);
+}
+
 
 /*
  * sys_sysinfo - fill in sysinfo struct
Binary files linux-2.5.50-bk4-kb/scripts/lxdialog/lxdialog and linux/scripts/lxdialog/lxdialog differ
Binary files linux-2.5.50-bk4-kb/usr/gen_init_cpio and linux/usr/gen_init_cpio differ
Binary files linux-2.5.50-bk4-kb/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------8A6C43A0A86963BB30A45970--

