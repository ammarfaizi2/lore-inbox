Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUCWXNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUCWXNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:13:33 -0500
Received: from ns.suse.de ([195.135.220.2]:31964 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262898AbUCWXM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:12:57 -0500
Date: Wed, 24 Mar 2004 00:12:56 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Subject: Non-Exec stack patches
Message-ID: <20040323231256.GP4677@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WKQ7zUpzoH2KEHMN"
Content-Disposition: inline
X-Operating-System: Linux 2.6.4-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WKQ7zUpzoH2KEHMN
Content-Type: multipart/mixed; boundary="Y9o+fgG4MNl0mnzl"
Content-Disposition: inline


--Y9o+fgG4MNl0mnzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

find attached a patch to parse the elf binaries for a PT_GNU_STACK
section to set the stack non-executable if possible.
Most parts have been shamelessly stolen from Ingo Molnar's more
ambitious stackshield
http://people.redhat.com/mingo/exec-shield/exec-shield-2.6.4-C9

The toolchain has meainwhile support for marking the binaries with a
PT_GNU_STACK section with ot without x bit as needed.

If no such section is found, we leave the stack to whatever the=20
arch defaults to. If there is one, we explicitly disabled the VM_EXEC=20
bit if no x bit is found, otherwise explicitly enable.

I believe this part should be merged into official mainstream kernels.
Ingo, what do you think?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--Y9o+fgG4MNl0mnzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=noexec_stack4
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.4.EXSTACK/arch/ia64/ia32/binfmt_elf32.c linux-2.6.4.no=
exec/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.6.4.EXSTACK/arch/ia64/ia32/binfmt_elf32.c	2004-03-23 21:18:35.0=
00000000 +0100
+++ linux-2.6.4.noexec/arch/ia64/ia32/binfmt_elf32.c	2004-03-23 22:48:31.00=
0000000 +0100
@@ -35,7 +35,7 @@ extern void ia64_elf32_init (struct pt_r
=20
 static void elf32_set_personality (void);
=20
-#define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
+#define setup_arg_pages(bprm,exec)		ia32_setup_arg_pages(bprm,exec)
 #define elf_map				elf32_map
=20
 #undef SET_PERSONALITY
@@ -152,7 +152,7 @@ ia64_elf32_init (struct pt_regs *regs)
 }
=20
 int
-ia32_setup_arg_pages (struct linux_binprm *bprm)
+ia32_setup_arg_pages (struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -181,8 +181,14 @@ ia32_setup_arg_pages (struct linux_binpr
 		mpnt->vm_mm =3D current->mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D IA32_STACK_TOP;
-		mpnt->vm_page_prot =3D PAGE_COPY;
-		mpnt->vm_flags =3D VM_STACK_FLAGS;
+		if (executable_stack > 0)
+			mpnt->vm_flags =3D VM_STACK_FLAGS |  VM_EXEC;
+		else if (executable_stack < 0)
+			mpnt->vm_flags =3D VM_STACK_FLAGS & ~VM_EXEC;
+		else
+			mpnt->vm_flags =3D VM_STACK_FLAGS;
+		mpnt->vm_page_prot =3D (mpnt->vm_flags & VM_EXEC)?
+					PAGE_COPY_EXEC: PAGE_COPY;
 		mpnt->vm_ops =3D NULL;
 		mpnt->vm_pgoff =3D mpnt->vm_start >> PAGE_SHIFT;
 		mpnt->vm_file =3D NULL;
@@ -197,7 +203,7 @@ ia32_setup_arg_pages (struct linux_binpr
 		struct page *page =3D bprm->page[i];
 		if (page) {
 			bprm->page[i] =3D NULL;
-			put_dirty_page(current, page, stack_base, PAGE_COPY, mpnt);
+			put_dirty_page(current, page, stack_base, mpnt->vm_page_prot, mpnt);
 		}
 		stack_base +=3D PAGE_SIZE;
 	}
diff -uNrp linux-2.6.4.EXSTACK/arch/ia64/ia32/ia32priv.h linux-2.6.4.noexec=
/arch/ia64/ia32/ia32priv.h
--- linux-2.6.4.EXSTACK/arch/ia64/ia32/ia32priv.h	2004-03-11 03:55:51.00000=
0000 +0100
+++ linux-2.6.4.noexec/arch/ia64/ia32/ia32priv.h	2004-03-23 22:56:20.000000=
000 +0100
@@ -494,7 +494,7 @@ struct ia32_user_desc {
 struct linux_binprm;
=20
 extern void ia32_init_addr_space (struct pt_regs *regs);
-extern int ia32_setup_arg_pages (struct linux_binprm *bprm);
+extern int ia32_setup_arg_pages (struct linux_binprm *bprm, int exec_stack=
);
 extern unsigned long ia32_do_mmap (struct file *, unsigned long, unsigned =
long, int, int, loff_t);
 extern void ia32_load_segment_descriptors (struct task_struct *task);
=20
diff -uNrp linux-2.6.4.EXSTACK/arch/mips/kernel/irixelf.c linux-2.6.4.noexe=
c/arch/mips/kernel/irixelf.c
--- linux-2.6.4.EXSTACK/arch/mips/kernel/irixelf.c	2004-03-11 03:56:03.0000=
00000 +0100
+++ linux-2.6.4.noexec/arch/mips/kernel/irixelf.c	2004-03-23 22:56:42.00000=
0000 +0100
@@ -688,7 +688,7 @@ static int load_irix_binary(struct linux
 	 * change some of these later.
 	 */
 	current->mm->rss =3D 0;
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, 0);
 	current->mm->start_stack =3D bprm->p;
=20
 	/* At this point, we assume that the image should be loaded at
diff -uNrp linux-2.6.4.EXSTACK/arch/s390/kernel/binfmt_elf32.c linux-2.6.4.=
noexec/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6.4.EXSTACK/arch/s390/kernel/binfmt_elf32.c	2004-03-11 03:55:44=
=2E000000000 +0100
+++ linux-2.6.4.noexec/arch/s390/kernel/binfmt_elf32.c	2004-03-23 22:51:25.=
000000000 +0100
@@ -114,7 +114,7 @@ typedef s390_regs32 elf_gregset_t;
 #include <linux/binfmts.h>
 #include <linux/compat.h>
=20
-int setup_arg_pages32(struct linux_binprm *bprm);
+int setup_arg_pages32(struct linux_binprm *bprm, int executable_stack);
=20
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
@@ -165,7 +165,7 @@ struct elf_prpsinfo32
=20
 #undef start_thread
 #define start_thread                    start_thread31=20
-#define setup_arg_pages(bprm)           setup_arg_pages32(bprm)
+#define setup_arg_pages(bprm, exec)     setup_arg_pages32(bprm, exec)
 #define elf_map				elf_map32
=20
 MODULE_DESCRIPTION("Binary format loader for compatibility with 32bit Linu=
x for S390 binaries,"
diff -uNrp linux-2.6.4.EXSTACK/arch/s390/kernel/compat_exec.c linux-2.6.4.n=
oexec/arch/s390/kernel/compat_exec.c
--- linux-2.6.4.EXSTACK/arch/s390/kernel/compat_exec.c	2004-03-23 21:18:35.=
000000000 +0100
+++ linux-2.6.4.noexec/arch/s390/kernel/compat_exec.c	2004-03-23 22:58:15.0=
00000000 +0100
@@ -37,7 +37,7 @@
 #undef STACK_TOP
 #define STACK_TOP TASK31_SIZE
=20
-int setup_arg_pages32(struct linux_binprm *bprm)
+int setup_arg_pages32(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -66,6 +66,7 @@ int setup_arg_pages32(struct linux_binpr
 		mpnt->vm_mm =3D mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D STACK_TOP;
+		/* executable stack setting would be applied here */
 		mpnt->vm_page_prot =3D PAGE_COPY;
 		mpnt->vm_flags =3D VM_STACK_FLAGS;
 		mpnt->vm_ops =3D NULL;
diff -uNrp linux-2.6.4.EXSTACK/arch/sparc64/kernel/binfmt_aout32.c linux-2.=
6.4.noexec/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.6.4.EXSTACK/arch/sparc64/kernel/binfmt_aout32.c	2004-03-11 03:5=
5:27.000000000 +0100
+++ linux-2.6.4.noexec/arch/sparc64/kernel/binfmt_aout32.c	2004-03-23 22:49=
:50.000000000 +0100
@@ -310,7 +310,7 @@ beyond_if:
 	orig_thr_flags =3D current_thread_info()->flags;
 	current_thread_info()->flags |=3D _TIF_32BIT;
=20
-	retval =3D setup_arg_pages(bprm);
+	retval =3D setup_arg_pages(bprm, 0);
 	if (retval < 0) {=20
 		current_thread_info()->flags =3D orig_thr_flags;
=20
diff -uNrp linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_aout.c linux-2.6.4.noe=
xec/arch/x86_64/ia32/ia32_aout.c
--- linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_aout.c	2004-03-11 03:55:54.00=
0000000 +0100
+++ linux-2.6.4.noexec/arch/x86_64/ia32/ia32_aout.c	2004-03-23 22:59:47.000=
000000 +0100
@@ -35,7 +35,7 @@
 #undef WARN_OLD
 #undef CORE_DUMP /* probably broken */
=20
-extern int ia32_setup_arg_pages(struct linux_binprm *bprm);
+extern int ia32_setup_arg_pages(struct linux_binprm *bprm, int exec_stack);
=20
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
@@ -395,7 +395,7 @@ beyond_if:
=20
 	set_brk(current->mm->start_brk, current->mm->brk);
=20
-	retval =3D ia32_setup_arg_pages(bprm);=20
+	retval =3D ia32_setup_arg_pages(bprm, 0);
 	if (retval < 0) {=20
 		/* Someone check-me: is this error path enough? */=20
 		send_sig(SIGKILL, current, 0);=20
diff -uNrp linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.4.n=
oexec/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_binfmt.c	2004-03-23 22:42:31.=
000000000 +0100
+++ linux-2.6.4.noexec/arch/x86_64/ia32/ia32_binfmt.c	2004-03-23 21:18:35.0=
00000000 +0100
@@ -272,8 +272,8 @@ do {							\
 #define load_elf_binary load_elf32_binary
=20
 #define ELF_PLAT_INIT(r, load_addr)	elf32_init(r)
-#define setup_arg_pages(bprm)		ia32_setup_arg_pages(bprm)
-int ia32_setup_arg_pages(struct linux_binprm *bprm);
+#define setup_arg_pages(bprm, exec_stack)	ia32_setup_arg_pages(bprm, exec_=
stack)
+int ia32_setup_arg_pages(struct linux_binprm *bprm, int executable_stack);
=20
 #undef start_thread
 #define start_thread(regs,new_rip,new_rsp) do { \
@@ -325,7 +325,7 @@ static void elf32_init(struct pt_regs *r
 	me->thread.es =3D __USER_DS;
 }
=20
-int setup_arg_pages(struct linux_binprm *bprm)
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -354,7 +354,12 @@ int setup_arg_pages(struct linux_binprm=20
 		mpnt->vm_mm =3D mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D IA32_STACK_TOP;
-		mpnt->vm_flags =3D vm_stack_flags32;=20
+		if (executable_stack > 0)
+			mpnt->vm_flags =3D vm_stack_flags32 |  VM_EXEC;
+		else if (executable_stack < 0)
+			mpnt->vm_flags =3D vm_stack_flags32 & ~VM_EXEC;
+		else
+			mpnt->vm_flags =3D vm_stack_flags32;
  		mpnt->vm_page_prot =3D (mpnt->vm_flags & VM_EXEC) ?=20
  			PAGE_COPY_EXEC : PAGE_COPY;
 		mpnt->vm_ops =3D NULL;
@@ -373,7 +378,7 @@ int setup_arg_pages(struct linux_binprm=20
 		struct page *page =3D bprm->page[i];
 		if (page) {
 			bprm->page[i] =3D NULL;
-			put_dirty_page(current,page,stack_base,PAGE_COPY_EXEC, mpnt);
+			put_dirty_page(current,page,stack_base,mpnt->vm_page_prot,mpnt);
 		}
 		stack_base +=3D PAGE_SIZE;
 	}
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_aout.c linux-2.6.4.noexec/fs/binfm=
t_aout.c
--- linux-2.6.4.EXSTACK/fs/binfmt_aout.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec/fs/binfmt_aout.c	2004-03-23 21:18:35.000000000 +0100
@@ -413,7 +413,7 @@ beyond_if:
=20
 	set_brk(current->mm->start_brk, current->mm->brk);
=20
-	retval =3D setup_arg_pages(bprm);=20
+	retval =3D setup_arg_pages(bprm, 0);=20
 	if (retval < 0) {=20
 		/* Someone check-me: is this error path enough? */=20
 		send_sig(SIGKILL, current, 0);=20
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_elf.c linux-2.6.4.noexec/fs/binfmt=
_elf.c
--- linux-2.6.4.EXSTACK/fs/binfmt_elf.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec/fs/binfmt_elf.c	2004-03-23 21:18:35.000000000 +0100
@@ -476,6 +476,7 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
+	int executable_stack =3D 0; 	/* Don't touch */
 =09
 	/* Get the exec-header */
 	elf_ex =3D *((struct elfhdr *) bprm->buf);
@@ -599,6 +600,15 @@ static int load_elf_binary(struct linux_
 		elf_ppnt++;
 	}
=20
+	elf_ppnt =3D elf_phdata;
+	for (i =3D 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+		if (elf_ppnt->p_type =3D=3D PT_GNU_STACK) {
+			if (elf_ppnt->p_flags & PF_X)
+				executable_stack =3D  1;
+			else
+				executable_stack =3D -1;
+		}
+
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type =3D INTERPRETER_ELF | INTERPRETER_AOUT;
@@ -674,7 +684,7 @@ static int load_elf_binary(struct linux_
 	   change some of these later */
 	current->mm->rss =3D 0;
 	current->mm->free_area_cache =3D TASK_UNMAPPED_BASE;
-	retval =3D setup_arg_pages(bprm);
+	retval =3D setup_arg_pages(bprm, executable_stack);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_som.c linux-2.6.4.noexec/fs/binfmt=
_som.c
--- linux-2.6.4.EXSTACK/fs/binfmt_som.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec/fs/binfmt_som.c	2004-03-23 21:18:35.000000000 +0100
@@ -254,7 +254,7 @@ load_som_binary(struct linux_binprm * bp
=20
 	set_binfmt(&som_format);
 	compute_creds(bprm);
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, 0);
=20
 	create_som_tables(bprm);
=20
diff -uNrp linux-2.6.4.EXSTACK/fs/exec.c linux-2.6.4.noexec/fs/exec.c
--- linux-2.6.4.EXSTACK/fs/exec.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec/fs/exec.c	2004-03-23 21:18:35.000000000 +0100
@@ -342,7 +342,7 @@ out_sig:
 	return;
 }
=20
-int setup_arg_pages(struct linux_binprm *bprm)
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -425,8 +425,13 @@ int setup_arg_pages(struct linux_binprm=20
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D STACK_TOP;
 #endif
-		mpnt->vm_page_prot =3D protection_map[VM_STACK_FLAGS & 0x7];
-		mpnt->vm_flags =3D VM_STACK_FLAGS;
+		if (executable_stack > 0)
+			mpnt->vm_flags =3D VM_STACK_FLAGS |  VM_EXEC;
+		else if (executable_stack < 0)
+			mpnt->vm_flags =3D VM_STACK_FLAGS & ~VM_EXEC;
+		else
+			mpnt->vm_flags =3D VM_STACK_FLAGS;
+		mpnt->vm_page_prot =3D protection_map[mpnt->vm_flags & 0x7];
 		mpnt->vm_ops =3D NULL;
 		mpnt->vm_pgoff =3D mpnt->vm_start >> PAGE_SHIFT;
 		mpnt->vm_file =3D NULL;
diff -uNrp linux-2.6.4.EXSTACK/include/linux/binfmts.h linux-2.6.4.noexec/i=
nclude/linux/binfmts.h
--- linux-2.6.4.EXSTACK/include/linux/binfmts.h	2004-03-23 22:42:31.0000000=
00 +0100
+++ linux-2.6.4.noexec/include/linux/binfmts.h	2004-03-23 21:18:35.00000000=
0 +0100
@@ -58,7 +58,7 @@ extern int prepare_binprm(struct linux_b
 extern void remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
-extern int setup_arg_pages(struct linux_binprm * bprm);
+extern int setup_arg_pages(struct linux_binprm * bprm, int executable_stac=
k);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_=
binprm *bprm);=20
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *=
bprm);
 extern void compute_creds(struct linux_binprm *binprm);
diff -uNrp linux-2.6.4.EXSTACK/include/linux/elf.h linux-2.6.4.noexec/inclu=
de/linux/elf.h
--- linux-2.6.4.EXSTACK/include/linux/elf.h	2004-03-23 22:42:31.000000000 +=
0100
+++ linux-2.6.4.noexec/include/linux/elf.h	2004-03-23 21:18:35.000000000 +0=
100
@@ -35,6 +35,8 @@ typedef __s64	Elf64_Sxword;
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
=20
+#define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+
 /* These constants define the different elf file types */
 #define ET_NONE   0
 #define ET_REL    1

--Y9o+fgG4MNl0mnzl--

--WKQ7zUpzoH2KEHMN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYMR3xmLh6hyYd04RAjEOAJ9GYk8cFdyq82QRRdPB7NEkj4ZhgwCgnBb1
n8OGf84cgyPM7P33EO4In2U=
=qO6Q
-----END PGP SIGNATURE-----

--WKQ7zUpzoH2KEHMN--
