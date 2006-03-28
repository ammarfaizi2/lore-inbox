Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWC1W7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWC1W7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWC1W7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:17 -0500
Received: from [198.99.130.12] ([198.99.130.12]:23747 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964789AbWC1W7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:04 -0500
Message-Id: <200603282300.k2SN0E7Z022992@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 7/10] UML - Sparse cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

uml: misc sparse annotations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/drivers/harddog_kern.c         |    8 +++--
 arch/um/drivers/hostaudio_kern.c       |    8 +++--
 arch/um/drivers/slirp_kern.c           |    2 +
 arch/um/include/line.h                 |   18 ++++--------
 arch/um/include/sysdep-i386/checksum.h |    5 ++-
 arch/um/kernel/exec_kern.c             |    4 +--
 arch/um/kernel/process_kern.c          |    2 +
 arch/um/kernel/ptrace.c                |   24 +++++++---------
 arch/um/kernel/syscall_kern.c          |    4 +--
 arch/um/kernel/trap_kern.c             |    6 ++--
 arch/um/sys-i386/ptrace.c              |    2 +
 arch/um/sys-i386/signal.c              |   48 +++++++++++++++++---------------
 arch/um/sys-i386/syscalls.c            |    2 +
 include/asm-um/ptrace-generic.h        |    2 +
 include/asm-um/thread_info.h           |   16 +++++------
 include/asm-um/uaccess.h               |    2 +
 16 files changed, 73 insertions(+), 80 deletions(-)

Index: linux-2.6.16-mm/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/harddog_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/harddog_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -104,7 +104,7 @@ static int harddog_release(struct inode 
 
 extern int ping_watchdog(int fd);
 
-static ssize_t harddog_write(struct file *file, const char *data, size_t len,
+static ssize_t harddog_write(struct file *file, const char __user *data, size_t len,
 			     loff_t *ppos)
 {
 	/*
@@ -118,6 +118,7 @@ static ssize_t harddog_write(struct file
 static int harddog_ioctl(struct inode *inode, struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
+	void __user *argp= (void __user *)arg;
 	static struct watchdog_info ident = {
 		WDIOC_SETTIMEOUT,
 		0,
@@ -127,13 +128,12 @@ static int harddog_ioctl(struct inode *i
 		default:
 			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
-			if(copy_to_user((struct harddog_info *)arg, &ident,
-					sizeof(ident)))
+			if(copy_to_user(argp, &ident, sizeof(ident)))
 				return -EFAULT;
 			return 0;
 		case WDIOC_GETSTATUS:
 		case WDIOC_GETBOOTSTATUS:
-			return put_user(0,(int *)arg);
+			return put_user(0,(int __user *)argp);
 		case WDIOC_KEEPALIVE:
 			return(ping_watchdog(harddog_out_fd));
 	}
Index: linux-2.6.16-mm/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/hostaudio_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -67,8 +67,8 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
 
 /* /dev/dsp file operations */
 
-static ssize_t hostaudio_read(struct file *file, char *buffer, size_t count, 
-			      loff_t *ppos)
+static ssize_t hostaudio_read(struct file *file, char __user *buffer,
+			      size_t count, loff_t *ppos)
 {
         struct hostaudio_state *state = file->private_data;
 	void *kbuf;
@@ -94,7 +94,7 @@ static ssize_t hostaudio_read(struct fil
 	return(err);
 }
 
-static ssize_t hostaudio_write(struct file *file, const char *buffer, 
+static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *ppos)
 {
         struct hostaudio_state *state = file->private_data;
@@ -152,7 +152,7 @@ static int hostaudio_ioctl(struct inode 
 	case SNDCTL_DSP_CHANNELS:
 	case SNDCTL_DSP_SUBDIVIDE:
 	case SNDCTL_DSP_SETFRAGMENT:
-		if(get_user(data, (int *) arg))
+		if(get_user(data, (int __user *) arg))
 			return(-EFAULT);
 		break;
 	default:
@@ -168,7 +168,7 @@ static int hostaudio_ioctl(struct inode 
 	case SNDCTL_DSP_CHANNELS:
 	case SNDCTL_DSP_SUBDIVIDE:
 	case SNDCTL_DSP_SETFRAGMENT:
-		if(put_user(data, (int *) arg))
+		if(put_user(data, (int __user *) arg))
 			return(-EFAULT);
 		break;
 	default:
Index: linux-2.6.16-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/slirp_kern.c	2006-03-28 17:32:46.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/slirp_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -77,7 +77,7 @@ static int slirp_setup(char *str, char *
 	int i=0;
 
 	*init = ((struct slirp_init)
-		{ argw :		{ { "slirp", NULL  } } });
+		{ .argw = { { "slirp", NULL  } } });
 
 	str = split_if_spec(str, mac_out, NULL);
 
Index: linux-2.6.16-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.16-mm.orig/arch/um/include/line.h	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/include/line.h	2006-03-28 17:46:58.000000000 -0500
@@ -58,23 +58,17 @@ struct line {
 };
 
 #define LINE_INIT(str, d) \
-	{ init_str :	str, \
-	  init_pri :	INIT_STATIC, \
-	  valid :	1, \
-	  throttled :	0, \
-	  lock :	SPIN_LOCK_UNLOCKED, \
-	  buffer :	NULL, \
-	  head :	NULL, \
-	  tail :	NULL, \
-	  sigio :	0, \
-	  driver :	d, \
-	  have_irq :	0 }
+	{ .init_str =	str, \
+	  .init_pri =	INIT_STATIC, \
+	  .valid =	1, \
+	  .lock =	SPIN_LOCK_UNLOCKED, \
+	  .driver =	d }
 
 struct lines {
 	int num;
 };
 
-#define LINES_INIT(n) {  num :		n }
+#define LINES_INIT(n) {  .num =	n }
 
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty);
Index: linux-2.6.16-mm/arch/um/include/sysdep-i386/checksum.h
===================================================================
--- linux-2.6.16-mm.orig/arch/um/include/sysdep-i386/checksum.h	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/include/sysdep-i386/checksum.h	2006-03-28 17:33:51.000000000 -0500
@@ -48,7 +48,8 @@ unsigned int csum_partial_copy_nocheck(c
  */
 
 static __inline__
-unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
+unsigned int csum_partial_copy_from_user(const unsigned char __user *src,
+					 unsigned char *dst,
 					 int len, int sum, int *err_ptr)
 {
 	if(copy_from_user(dst, src, len)){
@@ -192,7 +193,7 @@ static __inline__ unsigned short int csu
  */
 #define HAVE_CSUM_COPY_USER
 static __inline__ unsigned int csum_and_copy_to_user(const unsigned char *src,
-						     unsigned char *dst,
+						     unsigned char __user *dst,
 						     int len, int sum, int *err_ptr)
 {
 	if (access_ok(VERIFY_WRITE, dst, len)){
Index: linux-2.6.16-mm/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/exec_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/exec_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -58,14 +58,14 @@ long um_execve(char *file, char __user *
 	return(err);
 }
 
-long sys_execve(char *file, char __user *__user *argv,
+long sys_execve(char __user *file, char __user *__user *argv,
 		char __user *__user *env)
 {
 	long error;
 	char *filename;
 
 	lock_kernel();
-	filename = getname((char __user *) file);
+	filename = getname(file);
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename)) goto out;
 	error = execve1(filename, argv, env);
Index: linux-2.6.16-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/process_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/process_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -407,7 +407,7 @@ static int proc_read_sysemu(char *buf, c
 	return strlen(buf);
 }
 
-static int proc_write_sysemu(struct file *file,const char *buf, unsigned long count,void *data)
+static int proc_write_sysemu(struct file *file,const char __user *buf, unsigned long count,void *data)
 {
 	char tmp[2];
 
Index: linux-2.6.16-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/ptrace.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/ptrace.c	2006-03-28 17:51:59.000000000 -0500
@@ -46,6 +46,7 @@ extern int poke_user(struct task_struct 
 long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	int i, ret;
+	unsigned long __user *p = (void __user *)(unsigned long)data;
 
 	switch (request) {
 		/* when I and D space are separate, these will need to be fixed. */
@@ -58,7 +59,7 @@ long arch_ptrace(struct task_struct *chi
 		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied != sizeof(tmp))
 			break;
-		ret = put_user(tmp, (unsigned long __user *) data);
+		ret = put_user(tmp, p);
 		break;
 	}
 
@@ -136,15 +137,13 @@ long arch_ptrace(struct task_struct *chi
 
 #ifdef PTRACE_GETREGS
 	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
-	  	if (!access_ok(VERIFY_WRITE, (unsigned long *)data, 
-			       MAX_REG_OFFSET)) {
+		if (!access_ok(VERIFY_WRITE, p, MAX_REG_OFFSET)) {
 			ret = -EIO;
 			break;
 		}
 		for ( i = 0; i < MAX_REG_OFFSET; i += sizeof(long) ) {
-			__put_user(getreg(child, i),
-				   (unsigned long __user *) data);
-			data += sizeof(long);
+			__put_user(getreg(child, i), p);
+			p++;
 		}
 		ret = 0;
 		break;
@@ -153,15 +152,14 @@ long arch_ptrace(struct task_struct *chi
 #ifdef PTRACE_SETREGS
 	case PTRACE_SETREGS: { /* Set all gp regs in the child. */
 		unsigned long tmp = 0;
-	  	if (!access_ok(VERIFY_READ, (unsigned *)data, 
-			       MAX_REG_OFFSET)) {
+		if (!access_ok(VERIFY_READ, p, MAX_REG_OFFSET)) {
 			ret = -EIO;
 			break;
 		}
 		for ( i = 0; i < MAX_REG_OFFSET; i += sizeof(long) ) {
-			__get_user(tmp, (unsigned long __user *) data);
+			__get_user(tmp, p);
 			putreg(child, i, tmp);
-			data += sizeof(long);
+			p++;
 		}
 		ret = 0;
 		break;
@@ -188,13 +186,12 @@ long arch_ptrace(struct task_struct *chi
 		break;
 #endif
 	case PTRACE_FAULTINFO: {
-                /* Take the info from thread->arch->faultinfo,
-                 * but transfer max. sizeof(struct ptrace_faultinfo).
-                 * On i386, ptrace_faultinfo is smaller!
-                 */
-                ret = copy_to_user((unsigned long __user *) data,
-                                   &child->thread.arch.faultinfo,
-                                   sizeof(struct ptrace_faultinfo));
+		/* Take the info from thread->arch->faultinfo,
+		 * but transfer max. sizeof(struct ptrace_faultinfo).
+		 * On i386, ptrace_faultinfo is smaller!
+		 */
+		ret = copy_to_user(p, &child->thread.arch.faultinfo,
+				   sizeof(struct ptrace_faultinfo));
 		if(ret)
 			break;
 		break;
@@ -204,8 +201,7 @@ long arch_ptrace(struct task_struct *chi
 	case PTRACE_LDT: {
 		struct ptrace_ldt ldt;
 
-		if(copy_from_user(&ldt, (unsigned long __user *) data,
-				  sizeof(ldt))){
+		if(copy_from_user(&ldt, p, sizeof(ldt))){
 			ret = -EIO;
 			break;
 		}
Index: linux-2.6.16-mm/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/syscall_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/syscall_kern.c	2006-03-28 17:33:51.000000000 -0500
@@ -104,7 +104,7 @@ long sys_pipe(unsigned long __user * fil
 }
 
 
-long sys_uname(struct old_utsname * name)
+long sys_uname(struct old_utsname __user * name)
 {
 	long err;
 	if (!name)
@@ -115,7 +115,7 @@ long sys_uname(struct old_utsname * name
 	return err?-EFAULT:0;
 }
 
-long sys_olduname(struct oldold_utsname * name)
+long sys_olduname(struct oldold_utsname __user * name)
 {
 	long error;
 
Index: linux-2.6.16-mm/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/kernel/trap_kern.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/kernel/trap_kern.c	2006-03-28 17:49:59.000000000 -0500
@@ -198,7 +198,7 @@ unsigned long segv(struct faultinfo fi, 
 		si.si_signo = SIGBUS;
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
-		si.si_addr = (void *)address;
+		si.si_addr = (void __user *)address;
                 current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
 	} else if (err == -ENOMEM) {
@@ -207,7 +207,7 @@ unsigned long segv(struct faultinfo fi, 
 	} else {
 		BUG_ON(err != -EFAULT);
 		si.si_signo = SIGSEGV;
-		si.si_addr = (void *) address;
+		si.si_addr = (void __user *) address;
                 current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGSEGV, &si, current);
 	}
@@ -220,8 +220,8 @@ void bad_segv(struct faultinfo fi, unsig
 
 	si.si_signo = SIGSEGV;
 	si.si_code = SEGV_ACCERR;
-        si.si_addr = (void *) FAULT_ADDRESS(fi);
-        current->thread.arch.faultinfo = fi;
+	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
+	current->thread.arch.faultinfo = fi;
 	force_sig_info(SIGSEGV, &si, current);
 }
 
Index: linux-2.6.16-mm/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/ptrace.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/ptrace.c	2006-03-28 17:51:09.000000000 -0500
@@ -124,22 +124,22 @@ unsigned long getreg(struct task_struct 
 int peek_user(struct task_struct *child, long addr, long data)
 {
 /* read the word at location addr in the USER area. */
-        unsigned long tmp;
+	unsigned long tmp;
 
-        if ((addr & 3) || addr < 0)
-                return -EIO;
+	if ((addr & 3) || addr < 0)
+		return -EIO;
 
-        tmp = 0;  /* Default return condition */
-        if(addr < MAX_REG_OFFSET){
-                tmp = getreg(child, addr);
-        }
-        else if((addr >= offsetof(struct user, u_debugreg[0])) &&
-                (addr <= offsetof(struct user, u_debugreg[7]))){
-                addr -= offsetof(struct user, u_debugreg[0]);
-                addr = addr >> 2;
-                tmp = child->thread.arch.debugregs[addr];
-        }
-        return put_user(tmp, (unsigned long *) data);
+	tmp = 0;  /* Default return condition */
+	if(addr < MAX_REG_OFFSET){
+		tmp = getreg(child, addr);
+	}
+	else if((addr >= offsetof(struct user, u_debugreg[0])) &&
+		(addr <= offsetof(struct user, u_debugreg[7]))){
+		addr -= offsetof(struct user, u_debugreg[0]);
+		addr = addr >> 2;
+		tmp = child->thread.arch.debugregs[addr];
+	}
+	return put_user(tmp, (unsigned long __user *) data);
 }
 
 struct i387_fxsave_struct {
Index: linux-2.6.16-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/signal.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/signal.c	2006-03-28 17:33:51.000000000 -0500
@@ -19,7 +19,7 @@
 #include "skas.h"
 
 static int copy_sc_from_user_skas(struct pt_regs *regs,
-				  struct sigcontext *from)
+				  struct sigcontext __user *from)
 {
   	struct sigcontext sc;
 	unsigned long fpregs[HOST_FP_SIZE];
@@ -57,7 +57,7 @@ static int copy_sc_from_user_skas(struct
 	return(0);
 }
 
-int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
+int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate __user *to_fp,
                          struct pt_regs *regs, unsigned long sp)
 {
   	struct sigcontext sc;
@@ -92,7 +92,7 @@ int copy_sc_to_user_skas(struct sigconte
 		       "errno = %d\n", err);
 		return(1);
 	}
-	to_fp = (to_fp ? to_fp : (struct _fpstate *) (to + 1));
+	to_fp = (to_fp ? to_fp : (struct _fpstate __user *) (to + 1));
 	sc.fpstate = to_fp;
 
 	if(err)
@@ -113,10 +113,11 @@ int copy_sc_to_user_skas(struct sigconte
  * saved pointer is in the kernel, but the sigcontext is in userspace, so we
  * copy_to_user it.
  */
-int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
+int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext __user *from,
 			 int fpsize)
 {
-	struct _fpstate *to_fp, *from_fp;
+	struct _fpstate *to_fp;
+	struct _fpstate __user *from_fp;
 	unsigned long sigs;
 	int err;
 
@@ -131,13 +132,14 @@ int copy_sc_from_user_tt(struct sigconte
 	return(err);
 }
 
-int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
+int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate __user *fp,
 		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
-	struct _fpstate *to_fp, *from_fp;
+	struct _fpstate __user *to_fp;
+	struct _fpstate *from_fp;
 	int err;
 
-	to_fp =	(fp ? fp : (struct _fpstate *) (to + 1));
+	to_fp =	(fp ? fp : (struct _fpstate __user *) (to + 1));
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
 
@@ -165,7 +167,7 @@ static int copy_sc_from_user(struct pt_r
 	return(ret);
 }
 
-static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp,
+static int copy_sc_to_user(struct sigcontext *to, struct _fpstate __user *fp,
 			   struct pt_regs *from, unsigned long sp)
 {
 	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
@@ -173,7 +175,7 @@ static int copy_sc_to_user(struct sigcon
                            copy_sc_to_user_skas(to, fp, from, sp)));
 }
 
-static int copy_ucontext_to_user(struct ucontext *uc, struct _fpstate *fp,
+static int copy_ucontext_to_user(struct ucontext __user *uc, struct _fpstate __user *fp,
 				 sigset_t *set, unsigned long sp)
 {
 	int err = 0;
@@ -188,7 +190,7 @@ static int copy_ucontext_to_user(struct 
 
 struct sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
 	struct _fpstate fpstate;
@@ -198,10 +200,10 @@ struct sigframe
 
 struct rt_sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
 	struct _fpstate fpstate;
@@ -213,16 +215,16 @@ int setup_signal_stack_sc(unsigned long 
 			  sigset_t *mask)
 {
 	struct sigframe __user *frame;
-	void *restorer;
+	void __user *restorer;
 	unsigned long save_sp = PT_REGS_SP(regs);
 	int err = 0;
 
 	stack_top &= -8UL;
-	frame = (struct sigframe *) stack_top - 1;
+	frame = (struct sigframe __user *) stack_top - 1;
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return 1;
 
-	restorer = (void *) frame->retcode;
+	restorer = frame->retcode;
 	if(ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -278,16 +280,16 @@ int setup_signal_stack_si(unsigned long 
 			  siginfo_t *info, sigset_t *mask)
 {
 	struct rt_sigframe __user *frame;
-	void *restorer;
+	void __user *restorer;
 	unsigned long save_sp = PT_REGS_SP(regs);
 	int err = 0;
 
 	stack_top &= -8UL;
-	frame = (struct rt_sigframe *) stack_top - 1;
+	frame = (struct rt_sigframe __user *) stack_top - 1;
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return 1;
 
-	restorer = (void *) frame->retcode;
+	restorer = frame->retcode;
 	if(ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
@@ -333,7 +335,7 @@ err:
 long sys_sigreturn(struct pt_regs regs)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
-	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
+	struct sigframe __user *frame = (struct sigframe __user *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
 	unsigned long __user *oldmask = &sc->oldmask;
@@ -365,8 +367,8 @@ long sys_sigreturn(struct pt_regs regs)
 
 long sys_rt_sigreturn(struct pt_regs regs)
 {
-	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
-	struct rt_sigframe __user *frame = (struct rt_sigframe *) (sp - 4);
+	unsigned long sp = PT_REGS_SP(&current->thread.regs);
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *) (sp - 4);
 	sigset_t set;
 	struct ucontext __user *uc = &frame->uc;
 	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
Index: linux-2.6.16-mm/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/syscalls.c	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/syscalls.c	2006-03-28 17:33:51.000000000 -0500
@@ -104,7 +104,7 @@ long sys_ipc (uint call, int first, int 
 		union semun fourth;
 		if (!ptr)
 			return -EINVAL;
-		if (get_user(fourth.__pad, (void **) ptr))
+		if (get_user(fourth.__pad, (void __user * __user *) ptr))
 			return -EFAULT;
 		return sys_semctl (first, second, third, fourth);
 	}
Index: linux-2.6.16-mm/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.16-mm.orig/include/asm-um/ptrace-generic.h	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/include/asm-um/ptrace-generic.h	2006-03-28 17:33:51.000000000 -0500
@@ -28,7 +28,7 @@ struct pt_regs {
 	union uml_pt_regs regs;
 };
 
-#define EMPTY_REGS { regs : EMPTY_UML_PT_REGS }
+#define EMPTY_REGS { .regs = EMPTY_UML_PT_REGS }
 
 #define PT_REGS_IP(r) UPT_IP(&(r)->regs)
 #define PT_REGS_SP(r) UPT_SP(&(r)->regs)
Index: linux-2.6.16-mm/include/asm-um/thread_info.h
===================================================================
--- linux-2.6.16-mm.orig/include/asm-um/thread_info.h	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/include/asm-um/thread_info.h	2006-03-28 17:33:51.000000000 -0500
@@ -27,14 +27,14 @@ struct thread_info {
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	task:		&tsk,			\
-	exec_domain:	&default_exec_domain,	\
-	flags:		0,			\
-	cpu:		0,			\
-	preempt_count:	1,			\
-	addr_limit:	KERNEL_DS,		\
-	restart_block:  {			\
-		fn:  do_no_restart_syscall,	\
+	.task =		&tsk,			\
+	.exec_domain =	&default_exec_domain,	\
+	.flags =		0,		\
+	.cpu =		0,			\
+	.preempt_count =	1,		\
+	.addr_limit =	KERNEL_DS,		\
+	.restart_block =  {			\
+		.fn =  do_no_restart_syscall,	\
 	},					\
 }
 
Index: linux-2.6.16-mm/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.16-mm.orig/include/asm-um/uaccess.h	2006-03-28 17:28:24.000000000 -0500
+++ linux-2.6.16-mm/include/asm-um/uaccess.h	2006-03-28 17:33:51.000000000 -0500
@@ -57,7 +57,7 @@
 ({ \
         const __typeof__((*(ptr))) __user *private_ptr = (ptr); \
         (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
-	 __get_user(x, private_ptr) : ((x) = 0, -EFAULT)); \
+	 __get_user(x, private_ptr) : ((x) = (__typeof__(*ptr))0, -EFAULT)); \
 })
 
 #define __put_user(x, ptr) \

