Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVARBmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVARBmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVARBmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:42:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:55991 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262925AbVARBTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:19:48 -0500
Date: Tue, 18 Jan 2005 02:22:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 06/11] Get rid of verify_area() - arch/mips/.
Message-ID: <Pine.LNX.4.61.0501180150400.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
arch/mips/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixelf.c linux-2.6.11-rc1-bk4/arch/mips/kernel/irixelf.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixelf.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/irixelf.c	2005-01-16 23:51:09.000000000 +0100
@@ -885,12 +885,11 @@ unsigned long irix_mapelf(int fd, struct
 
 	/* First get the verification out of the way. */
 	hp = user_phdrp;
-	retval = verify_area(VERIFY_READ, hp, (sizeof(struct elf_phdr) * cnt));
-	if(retval) {
+	if (!access_ok(VERIFY_READ, hp, (sizeof(struct elf_phdr) * cnt))) {
 #ifdef DEBUG_ELF
-		printk("irix_mapelf: verify_area fails!\n");
+		printk("irix_mapelf: access_ok fails!\n");
 #endif
-		return retval;
+		return -EFAULT;
 	}
 
 #ifdef DEBUG_ELF
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixinv.c linux-2.6.11-rc1-bk4/arch/mips/kernel/irixinv.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixinv.c	2004-12-24 22:33:51.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/irixinv.c	2005-01-16 23:52:00.000000000 +0100
@@ -38,8 +38,8 @@ int dump_inventory_to_user (void *userbu
 	inventory_t *user = userbuf;
 	int v;
 
-	if ((v = verify_area (VERIFY_WRITE, userbuf, size)))
-		return v;
+	if (!access_ok(VERIFY_WRITE, userbuf, size))
+		return -EFAULT;
 
 	for (v = 0; v < inventory_items; v++){
 		inv = &inventory [v];
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixsig.c linux-2.6.11-rc1-bk4/arch/mips/kernel/irixsig.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/irixsig.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/irixsig.c	2005-01-17 00:07:42.000000000 +0100
@@ -312,7 +312,7 @@ irix_sigaction(int sig, const struct sig
 #endif
 	if (act) {
 		sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags))
 			return -EFAULT;
@@ -331,7 +331,7 @@ irix_sigaction(int sig, const struct sig
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags))
 			return -EFAULT;
@@ -350,12 +350,10 @@ asmlinkage int irix_sigpending(irix_sigs
 asmlinkage int irix_sigprocmask(int how, irix_sigset_t *new, irix_sigset_t *old)
 {
 	sigset_t oldbits, newbits;
-	int error;
 
 	if (new) {
-		error = verify_area(VERIFY_READ, new, sizeof(*new));
-		if (error)
-			return error;
+		if (!access_ok(VERIFY_READ, new, sizeof(*new)))
+			return -EFAULT;
 		__copy_from_user(&newbits, new, sizeof(unsigned long)*4);
 		sigdelsetmask(&newbits, ~_BLOCKABLE);
 
@@ -385,9 +383,8 @@ asmlinkage int irix_sigprocmask(int how,
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 	if(old) {
-		error = verify_area(VERIFY_WRITE, old, sizeof(*old));
-		if(error)
-			return error;
+		if (!access_ok(VERIFY_WRITE, old, sizeof(*old)))
+			return -EFAULT;
 		__copy_to_user(old, &current->blocked, sizeof(unsigned long)*4);
 	}
 
@@ -469,12 +466,13 @@ asmlinkage int irix_sigpoll_sys(unsigned
 #endif
 
 	/* Must always specify the signal set. */
-	if(!set)
+	if (!set)
 		return -EINVAL;
 
-	error = verify_area(VERIFY_READ, set, sizeof(kset));
-	if (error)
+	if (!access_ok(VERIFY_READ, set, sizeof(kset))) {
+		error = -EFAULT;
 		goto out;
+	}
 
 	__copy_from_user(&kset, set, sizeof(set));
 	if (error)
@@ -485,11 +483,10 @@ asmlinkage int irix_sigpoll_sys(unsigned
 		goto out;
 	}
 
-	if(tp) {
-		error = verify_area(VERIFY_READ, tp, sizeof(*tp));
-		if(error)
-			return error;
-		if(!tp->tv_sec && !tp->tv_nsec) {
+	if (tp) {
+		if (!access_ok(VERIFY_READ, tp, sizeof(*tp)))
+			return -EFAULT;
+		if (!tp->tv_sec && !tp->tv_nsec) {
 			error = -EINVAL;
 			goto out;
 		}
@@ -564,13 +561,15 @@ asmlinkage int irix_waitsys(int type, in
 		retval = -EINVAL;
 		goto out;
 	}
-	retval = verify_area(VERIFY_WRITE, info, sizeof(*info));
-	if(retval)
+	if (!access_ok(VERIFY_WRITE, info, sizeof(*info))) {
+		retval = -EFAULT;
 		goto out;
+	}
 	if (ru) {
-		retval = verify_area(VERIFY_WRITE, ru, sizeof(*ru));
-		if(retval)
+		if (!access_ok(VERIFY_WRITE, ru, sizeof(*ru))) {
+			retval = -EFAULT;
 			goto out;
+		}
 	}
 	if (options & ~(W_MASK)) {
 		retval = -EINVAL;
@@ -690,7 +689,7 @@ struct irix5_context {
 
 asmlinkage int irix_getcontext(struct pt_regs *regs)
 {
-	int error, i, base = 0;
+	int i, base = 0;
 	struct irix5_context *ctx;
 	unsigned long flags;
 
@@ -703,9 +702,9 @@ asmlinkage int irix_getcontext(struct pt
 	       current->comm, current->pid, ctx);
 #endif
 
-	error = verify_area(VERIFY_WRITE, ctx, sizeof(*ctx));
-	if(error)
-		goto out;
+	if (!access_ok(VERIFY_WRITE, ctx, sizeof(*ctx)))
+		return -EFAULT;
+
 	__put_user(current->thread.irix_oldctx, &ctx->link);
 
 	__copy_to_user(&ctx->sigmask, &current->blocked, sizeof(irix_sigset_t));
@@ -725,17 +724,15 @@ asmlinkage int irix_getcontext(struct pt
 	__put_user(regs->cp0_epc, &ctx->regs[35]);
 
 	flags = 0x0f;
-	if(!current->used_math) {
+	if (!current->used_math) {
 		flags &= ~(0x08);
 	} else {
 		/* XXX wheee... */
 		printk("Wheee, no code for saving IRIX FPU context yet.\n");
 	}
 	__put_user(flags, &ctx->flags);
-	error = 0;
 
-out:
-	return error;
+	return 0;
 }
 
 asmlinkage unsigned long irix_setcontext(struct pt_regs *regs)
@@ -752,9 +749,10 @@ asmlinkage unsigned long irix_setcontext
 	       current->comm, current->pid, ctx);
 #endif
 
-	error = verify_area(VERIFY_READ, ctx, sizeof(*ctx));
-	if (error)
+	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx))) {
+		error = -EFAULT;
 		goto out;
+	}
 
 	if (ctx->flags & 0x02) {
 		/* XXX sigstack garbage, todo... */
@@ -787,21 +785,19 @@ struct irix_sigstack { unsigned long sp;
 
 asmlinkage int irix_sigstack(struct irix_sigstack *new, struct irix_sigstack *old)
 {
-	int error;
+	int error = -EFAULT;
 
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigstack(%p,%p)\n",
 	       current->comm, current->pid, new, old);
 #endif
 	if(new) {
-		error = verify_area(VERIFY_READ, new, sizeof(*new));
-		if(error)
+		if (!access_ok(VERIFY_READ, new, sizeof(*new)))
 			goto out;
 	}
 
 	if(old) {
-		error = verify_area(VERIFY_WRITE, old, sizeof(*old));
-		if(error)
+		if (!access_ok(VERIFY_WRITE, old, sizeof(*old)))
 			goto out;
 	}
 	error = 0;
@@ -815,21 +811,19 @@ struct irix_sigaltstack { unsigned long 
 asmlinkage int irix_sigaltstack(struct irix_sigaltstack *new,
 				struct irix_sigaltstack *old)
 {
-	int error;
+	int error = -EFAULT;
 
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigaltstack(%p,%p)\n",
 	       current->comm, current->pid, new, old);
 #endif
 	if (new) {
-		error = verify_area(VERIFY_READ, new, sizeof(*new));
-		if(error)
+		if (!access_ok(VERIFY_READ, new, sizeof(*new)))
 			goto out;
 	}
 
 	if (old) {
-		error = verify_area(VERIFY_WRITE, old, sizeof(*old));
-		if(error)
+		if (!access_ok(VERIFY_WRITE, old, sizeof(*old)))
 			goto out;
 	}
 	error = 0;
@@ -848,9 +842,10 @@ asmlinkage int irix_sigsendset(struct ir
 {
 	int error;
 
-	error = verify_area(VERIFY_READ, pset, sizeof(*pset));
-	if(error)
+	if (!access_ok(VERIFY_READ, pset, sizeof(*pset))) {
+		error = -EFAULT;
 		goto out;
+	}
 #ifdef DEBUG_SIG
 	printk("[%s:%d] irix_sigsendset([%d,%d,%d,%d,%d],%d)\n",
 	       current->comm, current->pid,
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/linux32.c linux-2.6.11-rc1-bk4/arch/mips/kernel/linux32.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/linux32.c	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/linux32.c	2005-01-17 00:23:33.000000000 +0100
@@ -239,7 +239,7 @@ put_rusage (struct rusage32 *ru, struct 
 {
 	int err;
 
-	if (verify_area(VERIFY_WRITE, ru, sizeof *ru))
+	if (!access_ok(VERIFY_WRITE, ru, sizeof *ru))
 		return -EFAULT;
 
 	err = __put_user (r->ru_utime.tv_sec, &ru->ru_utime.tv_sec);
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/sysirix.c linux-2.6.11-rc1-bk4/arch/mips/kernel/sysirix.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/sysirix.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/sysirix.c	2005-01-17 00:19:06.000000000 +0100
@@ -289,9 +289,10 @@ asmlinkage int irix_syssgi(struct pt_reg
 		struct task_struct *p;
 		char tcomm[sizeof(current->comm)];
 
-		retval = verify_area(VERIFY_WRITE, buf, sizeof(tcomm));
-		if (retval)
+		if (!access_ok(VERIFY_WRITE, buf, sizeof(tcomm))) {
+			retval = -EFAULT;
 			break;
+		}
 		read_lock(&tasklist_lock);
 		p = find_task_by_pid(pid);
 		if (!p) {
@@ -313,9 +314,10 @@ asmlinkage int irix_syssgi(struct pt_reg
 		char *buf = (char *) regs->regs[base+6];
 		char *value;
 		return -EINVAL;	/* til I fix it */
-		retval = verify_area(VERIFY_WRITE, buf, 128);
-		if (retval)
+		if (!access_ok(VERIFY_WRITE, buf, 128)) {
+			retval = -EFAULT;
 			break;
+		}
 		value = prom_getenv(name);	/* PROM lock?  */
 		if (!value) {
 			retval = -EINVAL;
@@ -472,9 +474,8 @@ asmlinkage int irix_syssgi(struct pt_reg
 		pmd_t *pmdp;
 		pte_t *ptep;
 
-		retval = verify_area(VERIFY_WRITE, pageno, sizeof(int));
-		if (retval)
-			return retval;
+		if (!access_ok(VERIFY_WRITE, pageno, sizeof(int)))
+			return -EFAULT;
 
 		down_read(&mm->mmap_sem);
 		pgdp = pgd_offset(mm, addr);
@@ -727,9 +728,10 @@ asmlinkage int irix_statfs(const char *p
 		error = -EINVAL;
 		goto out;
 	}
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statfs));
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statfs))) {
+		error = -EFAULT;
 		goto out;
+	}
 	error = user_path_walk(path, &nd);
 	if (error)
 		goto out;
@@ -763,9 +765,10 @@ asmlinkage int irix_fstatfs(unsigned int
 	struct file *file;
 	int error, i;
 
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statfs));
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statfs))) {
+		error = -EFAULT;
 		goto out;
+	}
 	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
@@ -816,9 +819,8 @@ asmlinkage int irix_times(struct tms * t
 	int err = 0;
 
 	if (tbuf) {
-		err = verify_area(VERIFY_WRITE,tbuf,sizeof *tbuf);
-		if (err)
-			return err;
+		if (!access_ok(VERIFY_WRITE,tbuf,sizeof *tbuf)) 
+			return -EFAULT;
 		err |= __put_user(current->utime, &tbuf->tms_utime);
 		err |= __put_user(current->stime, &tbuf->tms_stime);
 		err |= __put_user(current->signal->cutime, &tbuf->tms_cutime);
@@ -919,9 +921,8 @@ asmlinkage int irix_getdomainname(char *
 {
 	int error;
 
-	error = verify_area(VERIFY_WRITE, name, len);
-	if (error)
-		return error;
+	if (!access_ok(VERIFY_WRITE, name, len))
+		return -EFAULT;
 
 	down_read(&uts_sem);
 	if (len > __NEW_UTS_LEN)
@@ -1050,7 +1051,7 @@ asmlinkage int irix_gettimeofday(struct 
 	long nsec, seq;
 	int err;
 
-	if (verify_area(VERIFY_WRITE, tv, sizeof(struct timeval)))
+	if (!access_ok(VERIFY_WRITE, tv, sizeof(struct timeval)))
 		return -EFAULT;
 
 	do {
@@ -1396,9 +1397,10 @@ asmlinkage int irix_statvfs(char *fname,
 
 	printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
 	       current->comm, current->pid, fname, buf);
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs))) {
+		error = -EFAULT;
 		goto out;
+	}
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
@@ -1443,9 +1445,10 @@ asmlinkage int irix_fstatvfs(int fd, str
 	printk("[%s:%d] Wheee.. irix_fstatvfs(%d,%p)\n",
 	       current->comm, current->pid, fd, buf);
 
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs))) {
+		error = -EFAULT;
 		goto out;
+	}
 	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
@@ -1537,16 +1540,18 @@ asmlinkage int irix_mmap64(struct pt_reg
 	prot = regs->regs[base + 6];
 	if (!base) {
 		flags = regs->regs[base + 7];
-		error = verify_area(VERIFY_READ, sp, (4 * sizeof(unsigned long)));
-		if(error)
+		if (!access_ok(VERIFY_READ, sp, (4 * sizeof(unsigned long)))) {
+			error = -EFAULT;
 			goto out;
+		}
 		fd = sp[0];
 		__get_user(off1, &sp[1]);
 		__get_user(off2, &sp[2]);
 	} else {
-		error = verify_area(VERIFY_READ, sp, (5 * sizeof(unsigned long)));
-		if(error)
+		if (!access_ok(VERIFY_READ, sp, (5 * sizeof(unsigned long)))) {
+			error = -EFAULT;
 			goto out;
+		}
 		__get_user(flags, &sp[0]);
 		__get_user(fd, &sp[1]);
 		__get_user(off1, &sp[2]);
@@ -1650,9 +1655,10 @@ asmlinkage int irix_statvfs64(char *fnam
 
 	printk("[%s:%d] Wheee.. irix_statvfs(%s,%p)\n",
 	       current->comm, current->pid, fname, buf);
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs64));
-	if(error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs64))) {
+		error = -EFAULT;
 		goto out;
+	}
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
@@ -1697,9 +1703,10 @@ asmlinkage int irix_fstatvfs64(int fd, s
 	printk("[%s:%d] Wheee.. irix_fstatvfs(%d,%p)\n",
 	       current->comm, current->pid, fd, buf);
 
-	error = verify_area(VERIFY_WRITE, buf, sizeof(struct irix_statvfs));
-	if (error)
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(struct irix_statvfs))) {
+		error = -EFAULT;
 		goto out;
+	}
 	if (!(file = fget(fd))) {
 		error = -EBADF;
 		goto out;
@@ -1735,13 +1742,12 @@ out:
 
 asmlinkage int irix_getmountid(char *fname, unsigned long *midbuf)
 {
-	int err;
+	int err = 0;
 
 	printk("[%s:%d] irix_getmountid(%s, %p)\n",
 	       current->comm, current->pid, fname, midbuf);
-	err = verify_area(VERIFY_WRITE, midbuf, (sizeof(unsigned long) * 4));
-	if (err)
-		return err;
+	if (!access_ok(VERIFY_WRITE, midbuf, (sizeof(unsigned long) * 4)))
+		return -EFAULT;
 
 	/*
 	 * The idea with this system call is that when trying to determine
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/unaligned.c linux-2.6.11-rc1-bk4/arch/mips/kernel/unaligned.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/kernel/unaligned.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/kernel/unaligned.c	2005-01-17 00:22:39.000000000 +0100
@@ -143,7 +143,7 @@ static inline int emulate_load_store_ins
 	 * The remaining opcodes are the ones that are really of interest.
 	 */
 	case lh_op:
-		if (verify_area(VERIFY_READ, addr, 2))
+		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
 		__asm__ __volatile__ (".set\tnoat\n"
@@ -176,7 +176,7 @@ static inline int emulate_load_store_ins
 		break;
 
 	case lw_op:
-		if (verify_area(VERIFY_READ, addr, 4))
+		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
 		__asm__ __volatile__ (
@@ -206,7 +206,7 @@ static inline int emulate_load_store_ins
 		break;
 
 	case lhu_op:
-		if (verify_area(VERIFY_READ, addr, 2))
+		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
 		__asm__ __volatile__ (
@@ -248,7 +248,7 @@ static inline int emulate_load_store_ins
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_READ, addr, 4))
+		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
 		__asm__ __volatile__ (
@@ -292,7 +292,7 @@ static inline int emulate_load_store_ins
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_READ, addr, 8))
+		if (!access_ok(VERIFY_READ, addr, 8))
 			goto sigbus;
 
 		__asm__ __volatile__ (
@@ -326,7 +326,7 @@ static inline int emulate_load_store_ins
 		goto sigill;
 
 	case sh_op:
-		if (verify_area(VERIFY_WRITE, addr, 2))
+		if (!access_ok(VERIFY_WRITE, addr, 2))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
@@ -362,7 +362,7 @@ static inline int emulate_load_store_ins
 		break;
 
 	case sw_op:
-		if (verify_area(VERIFY_WRITE, addr, 4))
+		if (!access_ok(VERIFY_WRITE, addr, 4))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
@@ -400,7 +400,7 @@ static inline int emulate_load_store_ins
 		 * would blow up, so for now we don't handle unaligned 64-bit
 		 * instructions on 32-bit kernels.
 		 */
-		if (verify_area(VERIFY_WRITE, addr, 8))
+		if (!access_ok(VERIFY_WRITE, addr, 8))
 			goto sigbus;
 
 		value = regs->regs[insn.i_format.rt];
diff -urp linux-2.6.11-rc1-bk4-orig/arch/mips/math-emu/dsemul.c linux-2.6.11-rc1-bk4/arch/mips/math-emu/dsemul.c
--- linux-2.6.11-rc1-bk4-orig/arch/mips/math-emu/dsemul.c	2004-12-24 22:33:52.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/mips/math-emu/dsemul.c	2005-01-16 23:46:56.000000000 +0100
@@ -95,7 +95,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	fr = (struct emuframe *) dsemul_insns;
 
 	/* Verify that the stack pointer is not competely insane */
-	if (unlikely(verify_area(VERIFY_WRITE, fr, sizeof(struct emuframe))))
+	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
 		return SIGBUS;
 
 	err = __put_user(ir, &fr->emul);
@@ -128,7 +128,7 @@ int do_dsemulret(struct pt_regs *xcp)
 	 * If we can't even access the area, something is very wrong, but we'll
 	 * leave that to the default handling
 	 */
-	if (verify_area(VERIFY_READ, fr, sizeof(struct emuframe)))
+	if (!access_ok(VERIFY_READ, fr, sizeof(struct emuframe)))
 		return 0;
 
 	/*
@@ -142,7 +142,6 @@ int do_dsemulret(struct pt_regs *xcp)
 
 	if (unlikely(err || (insn != BADINST) || (cookie != BD_COOKIE))) {
 		fpuemuprivate.stats.errors++;
-
 		return 0;
 	}
 



