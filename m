Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbULVKTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbULVKTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 05:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbULVKTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 05:19:51 -0500
Received: from canuck.infradead.org ([205.233.218.70]:10756 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261904AbULVKT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 05:19:27 -0500
Subject: Re: [PATCH] revert- sys_setaltroot
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@odsl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200410261928.i9QJS7h3011015@hera.kernel.org>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
Content-Type: multipart/mixed; boundary="=-MWmdF8dyD+ygmR/+c0B+"
Date: Wed, 22 Dec 2004 10:18:14 +0000
Message-Id: <1103710694.6111.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MWmdF8dyD+ygmR/+c0B+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-26 at 15:22 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2187, 2004/10/26 08:22:01-07:00, akpm@osdl.org
> 
> 	[PATCH] revert- sys_setaltroot	
> 	We decided to do this a different way.

Can you elaborate? We don't have open_exec() in userspace, so I'm
not sure it's possible to do this properly for setuid binaries and
execute-only binaries in userspace without being seriously exploitable.

I assume the problem with it was that you can set the altroot to a
directory containing a bogus /etc/shadow and then 'su' with a password
of your own choosing, or something like that? 

There's no reason to make the user-specified altroot survive across 
exec() though -- and as long it _doesn't_ persist, it should be
perfectly safe to let users set it. I'm working on a patch which puts
sys_setaltroot back but discards it on exec. This allows me to ditch all
the horrid path walking stuff from qemu, and as soon as I make qemu
understand AT_EXECFD it should let me run execute-only i386 binaries on
my ppc box too.

T'would be useful to confirm the original objections to it and that I
haven't missed a viable 'different way' to do it, though.

-- 
dwmw2

--=-MWmdF8dyD+ygmR/+c0B+
Content-Disposition: inline; filename=altroot-3.patch
Content-Type: text/x-patch; name=altroot-3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/entry.S 1.88 vs edited =====
--- 1.88/arch/i386/kernel/entry.S	2004-12-12 18:37:55 +00:00
+++ edited/arch/i386/kernel/entry.S	2004-12-20 13:08:02 +00:00
@@ -861,7 +861,7 @@
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
 	.long sys_waitid
-	.long sys_ni_syscall		/* 285 */ /* available */
+	.long sys_setaltroot		/* 285 */
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
===== arch/ia64/kernel/entry.S 1.69 vs edited =====
--- 1.69/arch/ia64/kernel/entry.S	2004-11-23 20:18:30 +00:00
+++ edited/arch/ia64/kernel/entry.S	2004-12-20 13:08:02 +00:00
@@ -1531,7 +1531,7 @@
 	data8 sys_add_key
 	data8 sys_request_key
 	data8 sys_keyctl
-	data8 sys_ni_syscall
+	data8 sys_setaltroot
 	data8 sys_ni_syscall			// 1275
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
===== arch/ppc/kernel/misc.S 1.63 vs edited =====
--- 1.63/arch/ppc/kernel/misc.S	2004-10-22 10:27:40 +01:00
+++ edited/arch/ppc/kernel/misc.S	2004-12-20 13:08:02 +00:00
@@ -1450,3 +1450,4 @@
 	.long sys_add_key
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
+	.long sys_setaltroot
===== arch/ppc64/kernel/misc.S 1.93 vs edited =====
--- 1.93/arch/ppc64/kernel/misc.S	2004-11-11 08:23:03 +00:00
+++ edited/arch/ppc64/kernel/misc.S	2004-12-20 13:08:02 +00:00
@@ -966,7 +966,8 @@
 	.llong .sys32_add_key
 	.llong .sys32_request_key
 	.llong .compat_sys_keyctl
-
+	.llong .sys_setaltroot
+	
 	.balign 8
 _GLOBAL(sys_call_table)
 	.llong .sys_restart_syscall	/* 0 */
@@ -1241,3 +1242,4 @@
 	.llong .sys_add_key
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
+	.llong .sys_setaltroot
===== arch/sparc/kernel/systbls.S 1.29 vs edited =====
--- 1.29/arch/sparc/kernel/systbls.S	2004-11-08 02:08:03 +00:00
+++ edited/arch/sparc/kernel/systbls.S	2004-12-20 13:08:02 +00:00
@@ -75,7 +75,7 @@
 /*265*/	.long sys_timer_delete, sys_timer_create, sys_nis_syscall, sys_io_setup, sys_io_destroy
 /*270*/	.long sys_io_submit, sys_io_cancel, sys_io_getevents, sys_mq_open, sys_mq_unlink
 /*275*/	.long sys_mq_timedsend, sys_mq_timedreceive, sys_mq_notify, sys_mq_getsetattr, sys_waitid
-/*280*/	.long sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl
+/*280*/	.long sys_setaltroot, sys_add_key, sys_request_key, sys_keyctl
 
 #ifdef CONFIG_SUNOS_EMUL
 	/* Now the SunOS syscall table. */
===== arch/sparc64/kernel/systbls.S 1.66 vs edited =====
--- 1.66/arch/sparc64/kernel/systbls.S	2004-11-11 08:23:03 +00:00
+++ edited/arch/sparc64/kernel/systbls.S	2004-12-20 13:08:02 +00:00
@@ -76,7 +76,7 @@
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
 /*270*/	.word sys32_io_submit, sys_io_cancel, compat_sys_io_getevents, sys32_mq_open, sys_mq_unlink
 	.word sys_mq_timedsend, sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, compat_sys_waitid
-/*280*/	.word sys_ni_syscall, sys_add_key, sys_request_key, sys_keyctl
+/*280*/	.word sys_setaltroot, sys_add_key, sys_request_key, sys_keyctl
 
 #endif /* CONFIG_COMPAT */
 
@@ -142,7 +142,7 @@
 	.word sys_timer_delete, sys_timer_create, sys_ni_syscall, sys_io_setup, sys_io_destroy
 /*270*/	.word sys_io_submit, sys_io_cancel, sys_io_getevents, sys_mq_open, sys_mq_unlink
 	.word sys_mq_timedsend, sys_mq_timedreceive, sys_mq_notify, sys_mq_getsetattr, sys_waitid
-/*280*/	.word sys_nis_syscall, sys_add_key, sys_request_key, sys_keyctl
+/*280*/	.word sys_setaltroot, sys_add_key, sys_request_key, sys_keyctl
 
 #if defined(CONFIG_SUNOS_EMUL) || defined(CONFIG_SOLARIS_EMUL) || \
     defined(CONFIG_SOLARIS_EMUL_MODULE)
===== fs/binfmt_elf.c 1.92 vs edited =====
--- 1.92/fs/binfmt_elf.c	2004-11-16 19:01:21 +00:00
+++ edited/fs/binfmt_elf.c	2004-12-20 13:08:02 +00:00
@@ -37,6 +37,7 @@
 #include <linux/pagemap.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -626,7 +627,7 @@
 			 */
 			SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);
 
-			interpreter = open_exec(elf_interpreter);
+			interpreter = open_exec(elf_interpreter, LOOKUP_NOALT);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
===== fs/binfmt_em86.c 1.8 vs edited =====
--- 1.8/fs/binfmt_em86.c	2004-05-10 12:25:55 +01:00
+++ edited/fs/binfmt_em86.c	2004-12-20 13:08:02 +00:00
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/errno.h>
+#include <linux/namei.h>
 
 
 #define EM86_INTERP	"/usr/bin/em86"
@@ -82,7 +83,7 @@
 	 * Note that we use open_exec() as the name is now in kernel
 	 * space, and we don't need to copy it.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, LOOKUP_NOALT);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
===== fs/binfmt_flat.c 1.11 vs edited =====
--- 1.11/fs/binfmt_flat.c	2004-10-19 06:26:36 +01:00
+++ edited/fs/binfmt_flat.c	2004-12-20 13:08:02 +00:00
@@ -36,6 +36,7 @@
 #include <linux/personality.h>
 #include <linux/init.h>
 #include <linux/flat.h>
+#include <linux/namei.h>
 
 #include <asm/byteorder.h>
 #include <asm/system.h>
@@ -774,7 +775,7 @@
 
 	/* Open the file up */
 	bprm.filename = buf;
-	bprm.file = open_exec(bprm.filename);
+	bprm.file = open_exec(bprm.filename, LOOKUP_NOALT);
 	res = PTR_ERR(bprm.file);
 	if (IS_ERR(bprm.file))
 		return res;
===== fs/binfmt_misc.c 1.30 vs edited =====
--- 1.30/fs/binfmt_misc.c	2004-06-29 15:43:10 +01:00
+++ edited/fs/binfmt_misc.c	2004-12-20 13:08:02 +00:00
@@ -179,7 +179,7 @@
 
 	bprm->interp = iname;	/* for binfmt_script */
 
-	interp_file = open_exec (iname);
+	interp_file = open_exec (iname, LOOKUP_NOALT);
 	retval = PTR_ERR (interp_file);
 	if (IS_ERR (interp_file))
 		goto _error;
===== fs/binfmt_script.c 1.9 vs edited =====
--- 1.9/fs/binfmt_script.c	2004-06-29 22:35:34 +01:00
+++ edited/fs/binfmt_script.c	2004-12-20 13:08:03 +00:00
@@ -85,9 +85,14 @@
 	/*
 	 * OK, now restart the process with the interpreter's dentry.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
+
+	/* If we had an altroot (which may be untrusted) we can reset it
+	   to the default for the personality now that we've got the 
+	   script's interpreter itself open. */
+	set_fs_altroot();
 
 	bprm->file = file;
 	retval = prepare_binprm(bprm);
===== fs/compat.c 1.47 vs edited =====
--- 1.47/fs/compat.c	2004-12-10 17:57:46 +00:00
+++ edited/fs/compat.c	2004-12-20 13:08:03 +00:00
@@ -1393,7 +1393,7 @@
 		goto out_ret;
 	memset(bprm, 0, sizeof(*bprm));
 
-	file = open_exec(filename);
+	file = open_exec(filename, 0);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_kfree;
@@ -1447,6 +1447,7 @@
 		free_arg_pages(bprm);
 
 		/* execve success */
+		set_fs_altroot();
 		security_bprm_free(bprm);
 		kfree(bprm);
 		return retval;
===== fs/exec.c 1.146 vs edited =====
--- 1.146/fs/exec.c	2004-12-10 17:57:46 +00:00
+++ edited/fs/exec.c	2004-12-20 13:08:03 +00:00
@@ -473,14 +473,14 @@
 
 #endif /* CONFIG_MMU */
 
-struct file *open_exec(const char *name)
+struct file *open_exec(const char *name, int flags)
 {
 	struct nameidata nd;
 	int err;
 	struct file *file;
 
 	nd.intent.open.flags = FMODE_READ;
-	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN|flags, &nd);
 	file = ERR_PTR(err);
 
 	if (!err) {
@@ -1007,7 +1007,7 @@
 
 	        loader = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
 
-		file = open_exec("/sbin/loader");
+		file = open_exec("/sbin/loader", LOOKUP_NOALT);
 		retval = PTR_ERR(file);
 		if (IS_ERR(file))
 			return retval;
@@ -1100,7 +1100,7 @@
 		goto out_ret;
 	memset(bprm, 0, sizeof(*bprm));
 
-	file = open_exec(filename);
+	file = open_exec(filename, 0);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_kfree;
@@ -1155,6 +1155,7 @@
 		free_arg_pages(bprm);
 
 		/* execve success */
+		set_fs_altroot();
 		security_bprm_free(bprm);
 		kfree(bprm);
 		return retval;
===== fs/namei.c 1.115 vs edited =====
--- 1.115/fs/namei.c	2004-10-28 08:39:57 +01:00
+++ edited/fs/namei.c	2004-12-20 13:08:03 +00:00
@@ -913,20 +913,20 @@
 	return 1;
 }
 
-void set_fs_altroot(void)
+int __set_fs_altroot(const char *altroot)
 {
-	char *emul = __emul_prefix();
 	struct nameidata nd;
 	struct vfsmount *mnt = NULL, *oldmnt;
 	struct dentry *dentry = NULL, *olddentry;
 	int err;
-
-	if (!emul)
+	if (!altroot)
 		goto set_it;
-	err = path_lookup(emul, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
+	err = path_lookup(altroot, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
 	if (!err) {
 		mnt = nd.mnt;
 		dentry = nd.dentry;
+	} else {
+		return err;
 	}
 set_it:
 	write_lock(&current->fs->lock);
@@ -939,6 +939,58 @@
 		dput(olddentry);
 		mntput(oldmnt);
 	}
+	return 0;
+}
+
+void set_fs_altroot(void)
+{
+	char *emul = __emul_prefix();
+
+	__set_fs_altroot(emul);
+}
+
+asmlinkage long sys_setaltroot(const char __user * altroot)
+{
+	char *emul = NULL;
+	int ret;
+
+	if (altroot) {
+		emul = getname(altroot);
+		if (IS_ERR(emul)) {
+			ret = PTR_ERR(emul);
+			goto out;
+		}
+	}
+
+	if (atomic_read(&current->fs->count) != 1) {
+		struct fs_struct *fsp, *ofsp;
+
+		fsp = copy_fs_struct(current->fs);
+		if (fsp == NULL) {
+			ret = -ENOMEM;
+			goto out_putname;
+		}
+
+		task_lock(current);
+		ofsp = current->fs;
+		current->fs = fsp;
+		task_unlock(current);
+
+		put_fs_struct(ofsp);
+	}
+
+	/*
+	 * At that point we are guaranteed to be the sole owner of
+	 * current->fs.
+	 */
+
+	ret = __set_fs_altroot(emul);
+
+out_putname:
+	if (emul)
+		putname(emul);
+out:
+	return ret;
 }
 
 int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
===== include/asm-i386/unistd.h 1.43 vs edited =====
--- 1.43/include/asm-i386/unistd.h	2004-10-24 11:32:46 +01:00
+++ edited/include/asm-i386/unistd.h	2004-12-20 13:08:41 +00:00
@@ -290,7 +290,7 @@
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
 #define __NR_waitid		284
-/* #define __NR_sys_setaltroot	285 */
+#define __NR_setaltroot		285
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
===== include/asm-ia64/unistd.h 1.53 vs edited =====
--- 1.53/include/asm-ia64/unistd.h	2004-11-23 20:18:59 +00:00
+++ edited/include/asm-ia64/unistd.h	2004-12-20 13:08:03 +00:00
@@ -263,6 +263,7 @@
 #define __NR_add_key			1271
 #define __NR_request_key		1272
 #define __NR_keyctl			1273
+#define __NR_setaltroot			1274
 
 #ifdef __KERNEL__
 
===== include/asm-ppc/unistd.h 1.34 vs edited =====
--- 1.34/include/asm-ppc/unistd.h	2004-10-22 10:27:40 +01:00
+++ edited/include/asm-ppc/unistd.h	2004-12-20 13:08:03 +00:00
@@ -276,8 +276,9 @@
 #define __NR_add_key		269
 #define __NR_request_key	270
 #define __NR_keyctl		271
+#define __NR_setaltroot		272
 
-#define __NR_syscalls		272
+#define __NR_syscalls		273
 
 #define __NR(n)	#n
 
===== include/asm-ppc64/unistd.h 1.36 vs edited =====
--- 1.36/include/asm-ppc64/unistd.h	2004-11-16 03:29:08 +00:00
+++ edited/include/asm-ppc64/unistd.h	2004-12-20 13:08:03 +00:00
@@ -282,8 +282,9 @@
 #define __NR_add_key		269
 #define __NR_request_key	270
 #define __NR_keyctl		271
+#define __NR_setaltroot		272
 
-#define __NR_syscalls		272
+#define __NR_syscalls		273
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
===== include/asm-sparc64/unistd.h 1.36 vs edited =====
--- 1.36/include/asm-sparc64/unistd.h	2004-10-24 10:47:46 +01:00
+++ edited/include/asm-sparc64/unistd.h	2004-12-20 13:09:06 +00:00
@@ -298,7 +298,7 @@
 #define __NR_mq_notify		277
 #define __NR_mq_getsetattr	278
 #define __NR_waitid		279
-/*#define __NR_sys_setaltroot	280 available (was setaltroot) */
+#define __NR_setaltroot		280
 #define __NR_add_key		281
 #define __NR_request_key	282
 #define __NR_keyctl		283
===== include/linux/fs.h 1.362 vs edited =====
--- 1.362/include/linux/fs.h	2004-10-29 09:14:03 +01:00
+++ edited/include/linux/fs.h	2004-12-20 13:08:03 +00:00
@@ -1376,7 +1376,7 @@
 extern int may_open(struct nameidata *, int, int);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
-extern struct file * open_exec(const char *);
+extern struct file * open_exec(const char *, int);
  
 /* fs/dcache.c -- generic fs support functions */
 extern int is_subdir(struct dentry *, struct dentry *);
===== include/linux/syscalls.h 1.17 vs edited =====
--- 1.17/include/linux/syscalls.h	2004-10-24 10:47:46 +01:00
+++ edited/include/linux/syscalls.h	2004-12-20 13:08:03 +00:00
@@ -490,6 +490,7 @@
 				void __user *res);
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
 asmlinkage long sys_uselib(const char __user *library);
+asmlinkage long sys_setaltroot(const char __user *altroot);
 asmlinkage long sys_ni_syscall(void);
 
 asmlinkage long sys_add_key(const char __user *_type,

--=-MWmdF8dyD+ygmR/+c0B+--

