Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSLFJLX>; Fri, 6 Dec 2002 04:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSLFJLX>; Fri, 6 Dec 2002 04:11:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21486 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262875AbSLFJLT>;
	Fri, 6 Dec 2002 04:11:19 -0500
Message-ID: <3DF06B15.1F6ECD5D@mvista.com>
Date: Fri, 06 Dec 2002 01:17:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212050846100.27298-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------15AF3EBDB38456A9B4BDB001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------15AF3EBDB38456A9B4BDB001
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Thu, 5 Dec 2002, george anzinger wrote:
> >
> > I think this covers all the bases.  It builds boots and
> > runs.  I haven't tested nano_sleep to see if it does the
> > right thing yet...
> 
> Well, it definitely doesn't, since at least this test is the wrong way
> around (as well as being against the coding style whitespace rules ;-p):
> 
> +       if ( ! current_thread_info()->restart_block.fun){
> +               return current_thread_info()->restart_block.fun(&parm);
> 
> Also, I would suggest against having a NULL pointer, and instead just
> initializing it with a function that sets it to an error return (don't use
> ENOSYS, since the system call _does_ exist, and ENOSYS is what old kernels
> would return if you do it by hand by mistake. I'd suggest -EINTR, since
> that will "DoTheRightThing(tm)" if we somehow get confused).
> 
>                 Linus
Ok, all the changes are in this version.  It build, runs AND
passes my clock_nanosleep test (when combined with the posix
timers patch).  I "annoy" the sleep with SIGSTOP and friends
and test the times against expected.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------15AF3EBDB38456A9B4BDB001
Content-Type: text/plain; charset=us-ascii;
 name="reg-fix-2.5.50-bk5-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reg-fix-2.5.50-bk5-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.50-bk5-kb/arch/i386/kernel/entry.S	Thu Dec  5 12:28:15 2002
+++ linux/arch/i386/kernel/entry.S	Thu Dec  5 12:28:52 2002
@@ -769,6 +769,7 @@
 	.long sys_epoll_wait
  	.long sys_remap_file_pages
  	.long sys_set_tid_address
+	.long sys_restart_syscall
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/arch/i386/kernel/signal.c linux/arch/i386/kernel/signal.c
--- linux-2.5.50-bk5-kb/arch/i386/kernel/signal.c	Thu Oct  3 10:41:57 2002
+++ linux/arch/i386/kernel/signal.c	Thu Dec  5 12:28:52 2002
@@ -506,6 +506,9 @@
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
 		switch (regs->eax) {
+		        case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fun = 
+					do_no_restart_syscall;
 			case -ERESTARTNOHAND:
 				regs->eax = -EINTR;
 				break;
@@ -589,6 +592,10 @@
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
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/include/asm-i386/thread_info.h linux/include/asm-i386/thread_info.h
--- linux-2.5.50-bk5-kb/include/asm-i386/thread_info.h	Mon Sep  9 10:35:03 2002
+++ linux/include/asm-i386/thread_info.h	Thu Dec  5 12:28:53 2002
@@ -11,6 +11,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
+#include <linux/linkage.h>
 #endif
 
 /*
@@ -20,6 +21,12 @@
  * - if the contents of this structure are changed, the assembly constants must also be changed
  */
 #ifndef __ASSEMBLY__
+struct restart_block {
+	long (*fun)(void *);
+	long arg0;
+	long arg1;
+};
+
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
@@ -31,6 +38,7 @@
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
+	struct restart_block    restart_block;
 
 	__u8			supervisor_stack[0];
 };
@@ -44,6 +52,7 @@
 #define TI_CPU		0x0000000C
 #define TI_PRE_COUNT	0x00000010
 #define TI_ADDR_LIMIT	0x00000014
+#define TI_RESTART_BLOCK 0x0000018
 
 #endif
 
@@ -55,6 +64,12 @@
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
 #ifndef __ASSEMBLY__
+/*
+ * We need this to do the initialization, but we don't want to clutter up
+ * things with the signal.h which is where it should be...
+ */
+extern asmlinkage long do_no_restart_syscall( void *parm);
+
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.task		= &tsk,			\
@@ -63,6 +78,9 @@
 	.cpu		= 0,			\
 	.preempt_count	= 1,			\
 	.addr_limit	= KERNEL_DS,		\
+	.restart_block = {                      \
+		.fun = do_no_restart_syscall,   \
+	},		                        \
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.5.50-bk5-kb/include/asm-i386/unistd.h	Wed Nov 27 15:49:22 2002
+++ linux/include/asm-i386/unistd.h	Thu Dec  5 12:28:53 2002
@@ -263,7 +263,7 @@
 #define __NR_sys_epoll_wait	256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258
-
+#define __NR_restart_syscall    259
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/include/linux/errno.h linux/include/linux/errno.h
--- linux-2.5.50-bk5-kb/include/linux/errno.h	Mon Sep  9 10:35:15 2002
+++ linux/include/linux/errno.h	Thu Dec  5 12:28:54 2002
@@ -10,6 +10,7 @@
 #define ERESTARTNOINTR	513
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
+#define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.5.50-bk5-kb/include/linux/signal.h	Mon Sep  9 10:35:04 2002
+++ linux/include/linux/signal.h	Thu Dec  5 12:28:54 2002
@@ -219,6 +219,7 @@
 }
 
 extern long do_sigpending(void *, unsigned long);
+extern asmlinkage long do_no_restart_syscall( void *parm);
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/kernel/signal.c linux/kernel/signal.c
--- linux-2.5.50-bk5-kb/kernel/signal.c	Thu Dec  5 11:48:53 2002
+++ linux/kernel/signal.c	Thu Dec  5 12:28:54 2002
@@ -1351,6 +1351,19 @@
  * System call entry points.
  */
 
+asmlinkage long
+sys_restart_syscall( void *parm)
+{
+	return current_thread_info()->restart_block.fun(&parm);
+}
+
+asmlinkage long
+do_no_restart_syscall( void *parm)
+{
+	return -EINTR;
+}
+
+
 /*
  * We don't need to get the kernel lock - this is all local to this
  * particular thread.. (and that's good, because this is _heavily_
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.50-bk5-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.50-bk5-kb/kernel/timer.c	Thu Dec  5 11:48:53 2002
+++ linux/kernel/timer.c	Thu Dec  5 12:48:54 2002
@@ -1020,21 +1020,50 @@
 	return current->pid;
 }
 
+struct nano_sleep_call {
+	struct timespec *rqtp; 
+	struct timespec *rmtp;
+};
+
+asmlinkage long sys_nanosleep_restart( struct nano_sleep_call * parms);
+
+
 long do_nanosleep(struct timespec *t)
 {
 	unsigned long expire;
+	struct  restart_block *restart_block = 
+		&current_thread_info()->restart_block;
 
-	if ((t->tv_nsec >= 1000000000L) || (t->tv_nsec < 0) || (t->tv_sec < 0))
-		return -EINVAL;
+	if( restart_block->fun == (int (*)(void *))sys_nanosleep_restart){
+		/*
+		 * Interrupted by a non-delivered signal, pick up remaining
+		 * time and continue.
+		 */
+		restart_block->fun = do_no_restart_syscall;
+		if(!restart_block->arg0)
+			return  -EINTR;
+
+		expire = restart_block->arg0 - jiffies;
+		if(expire <= 0)
+			return 0;
+	}else{
+		if ((t->tv_nsec >= 1000000000L) || 
+		    (t->tv_nsec < 0) || 
+		    (t->tv_sec < 0))
+			return -EINVAL;
 
-	expire = timespec_to_jiffies(t) + (t->tv_sec || t->tv_nsec);
+		expire = timespec_to_jiffies(t) + (t->tv_sec || t->tv_nsec);
+	}
 
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
 	if (expire) {
 		jiffies_to_timespec(expire, t);
-		return -EINTR;
+		restart_block = &current_thread_info()->restart_block;
+		restart_block->fun = (int (*)(void *))sys_nanosleep_restart;
+		restart_block->arg0 = jiffies + expire;
+		return -ERESTART_RESTARTBLOCK;
 	}
 	return 0;
 }
@@ -1048,11 +1077,16 @@
 		return -EFAULT;
 
 	ret = do_nanosleep(&t);
-	if (rmtp && (ret == -EINTR)) {
+	if (rmtp && (ret == -ERESTART_RESTARTBLOCK)) {
 		if (copy_to_user(rmtp, &t, sizeof(t)))
 			return -EFAULT;
 	}
 	return ret;
+}
+
+asmlinkage long sys_nanosleep_restart( struct nano_sleep_call * parms)
+{
+	return sys_nanosleep(parms->rqtp, parms->rmtp);
 }
 
 /*

--------------15AF3EBDB38456A9B4BDB001--

