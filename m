Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUCXAWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUCXAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:22:20 -0500
Received: from ns.suse.de ([195.135.220.2]:25238 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262941AbUCXAVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:21:51 -0500
Date: Wed, 24 Mar 2004 01:21:49 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-ID: <20040324002149.GT4677@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mingo@redhat.com
References: <20040323231256.GP4677@tpkurt.garloff.de> <20040323154937.1f0dc500.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DMefDzZywwCHZelG"
Content-Disposition: inline
In-Reply-To: <20040323154937.1f0dc500.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DMefDzZywwCHZelG
Content-Type: multipart/mixed; boundary="TPGKQYD3WP7vMswh"
Content-Disposition: inline


--TPGKQYD3WP7vMswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2004 at 03:49:37PM -0800, Andrew Morton wrote:
> This patch propagates the PT_GNU_STACK setting into the vma flags, allowi=
ng
> the architecture to set the stack permissions non-executable if the
> architecture chooses to do that, yes?

Right.

> Which architectures are currently making their pre-page execute permissio=
ns
> depend upon VM_EXEC?  Would additional arch patches be needed for this?

It works on AMD64 (not ia32e), both for 64bit and 32bit binaries.
I have not yet tested other archs.

If the values in the protection_map are different depending on bit 2,
the patch will be effecitve. (OK, the CPU/MMU needs to honour the
setting of course.) Most likely, the values for=20
protection_map[7] is PAGE_COPY_EXEC and of protection_map[3] is
PAGE_COPY.

> This may not get past Linus of course.  It doesn't even get past me with
> that magical undocumented -1/0/+1 value of the executable_stack argument.=
=20
> Please replace that with a proper, commented, #defined-or-enumerated valu=
e,

As you wish, master.
Slightly edited and untested patch attached.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--TPGKQYD3WP7vMswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=noexec_stack5
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.4.EXSTACK/arch/ia64/ia32/binfmt_elf32.c linux-2.6.4.no=
exec2/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.6.4.EXSTACK/arch/ia64/ia32/binfmt_elf32.c	2004-03-23 21:18:35.0=
00000000 +0100
+++ linux-2.6.4.noexec2/arch/ia64/ia32/binfmt_elf32.c	2004-03-24 01:07:35.0=
00000000 +0100
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
+		if (executable_stack =3D=3D EXSTACK_ENABLE_X)
+			mpnt->vm_flags =3D VM_STACK_FLAGS |  VM_EXEC;
+		else if (executable_stack =3D=3D EXSTACK_DISABLE_X)
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
2/arch/ia64/ia32/ia32priv.h
--- linux-2.6.4.EXSTACK/arch/ia64/ia32/ia32priv.h	2004-03-11 03:55:51.00000=
0000 +0100
+++ linux-2.6.4.noexec2/arch/ia64/ia32/ia32priv.h	2004-03-23 22:56:20.00000=
0000 +0100
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
c2/arch/mips/kernel/irixelf.c
--- linux-2.6.4.EXSTACK/arch/mips/kernel/irixelf.c	2004-03-11 03:56:03.0000=
00000 +0100
+++ linux-2.6.4.noexec2/arch/mips/kernel/irixelf.c	2004-03-24 01:08:11.0000=
00000 +0100
@@ -688,7 +688,7 @@ static int load_irix_binary(struct linux
 	 * change some of these later.
 	 */
 	current->mm->rss =3D 0;
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	current->mm->start_stack =3D bprm->p;
=20
 	/* At this point, we assume that the image should be loaded at
diff -uNrp linux-2.6.4.EXSTACK/arch/s390/kernel/binfmt_elf32.c linux-2.6.4.=
noexec2/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6.4.EXSTACK/arch/s390/kernel/binfmt_elf32.c	2004-03-11 03:55:44=
=2E000000000 +0100
+++ linux-2.6.4.noexec2/arch/s390/kernel/binfmt_elf32.c	2004-03-23 22:51:25=
=2E000000000 +0100
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
oexec2/arch/s390/kernel/compat_exec.c
--- linux-2.6.4.EXSTACK/arch/s390/kernel/compat_exec.c	2004-03-23 21:18:35.=
000000000 +0100
+++ linux-2.6.4.noexec2/arch/s390/kernel/compat_exec.c	2004-03-23 22:58:15.=
000000000 +0100
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
6.4.noexec2/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.6.4.EXSTACK/arch/sparc64/kernel/binfmt_aout32.c	2004-03-11 03:5=
5:27.000000000 +0100
+++ linux-2.6.4.noexec2/arch/sparc64/kernel/binfmt_aout32.c	2004-03-24 01:0=
9:55.000000000 +0100
@@ -310,7 +310,7 @@ beyond_if:
 	orig_thr_flags =3D current_thread_info()->flags;
 	current_thread_info()->flags |=3D _TIF_32BIT;
=20
-	retval =3D setup_arg_pages(bprm);
+	retval =3D setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	if (retval < 0) {=20
 		current_thread_info()->flags =3D orig_thr_flags;
=20
diff -uNrp linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_aout.c linux-2.6.4.noe=
xec2/arch/x86_64/ia32/ia32_aout.c
--- linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_aout.c	2004-03-11 03:55:54.00=
0000000 +0100
+++ linux-2.6.4.noexec2/arch/x86_64/ia32/ia32_aout.c	2004-03-24 01:13:31.00=
0000000 +0100
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
+	retval =3D ia32_setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	if (retval < 0) {=20
 		/* Someone check-me: is this error path enough? */=20
 		send_sig(SIGKILL, current, 0);=20
diff -uNrp linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_binfmt.c linux-2.6.4.n=
oexec2/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.4.EXSTACK/arch/x86_64/ia32/ia32_binfmt.c	2004-03-23 22:42:31.=
000000000 +0100
+++ linux-2.6.4.noexec2/arch/x86_64/ia32/ia32_binfmt.c	2004-03-24 01:11:21.=
000000000 +0100
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
+		if (executable_stack =3D=3D EXSTACK_ENABLE_X)
+			mpnt->vm_flags =3D vm_stack_flags32 |  VM_EXEC;
+		else if (executable_stack =3D=3D EXSTACK_DISABLE_X)
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
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_aout.c linux-2.6.4.noexec2/fs/binf=
mt_aout.c
--- linux-2.6.4.EXSTACK/fs/binfmt_aout.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec2/fs/binfmt_aout.c	2004-03-24 01:05:35.000000000 +0100
@@ -413,7 +413,7 @@ beyond_if:
=20
 	set_brk(current->mm->start_brk, current->mm->brk);
=20
-	retval =3D setup_arg_pages(bprm);=20
+	retval =3D setup_arg_pages(bprm, EXSTACK_DEFAULT);=20
 	if (retval < 0) {=20
 		/* Someone check-me: is this error path enough? */=20
 		send_sig(SIGKILL, current, 0);=20
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_elf.c linux-2.6.4.noexec2/fs/binfm=
t_elf.c
--- linux-2.6.4.EXSTACK/fs/binfmt_elf.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec2/fs/binfmt_elf.c	2004-03-24 01:03:32.000000000 +0100
@@ -476,6 +476,7 @@ static int load_elf_binary(struct linux_
   	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
+	int executable_stack =3D EXSTACK_DEFAULT;
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
+				executable_stack =3D EXSTACK_ENABLE_X;
+			else
+				executable_stack =3D EXSTACK_DISABLE_X;
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
diff -uNrp linux-2.6.4.EXSTACK/fs/binfmt_som.c linux-2.6.4.noexec2/fs/binfm=
t_som.c
--- linux-2.6.4.EXSTACK/fs/binfmt_som.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec2/fs/binfmt_som.c	2004-03-24 01:05:55.000000000 +0100
@@ -254,7 +254,7 @@ load_som_binary(struct linux_binprm * bp
=20
 	set_binfmt(&som_format);
 	compute_creds(bprm);
-	setup_arg_pages(bprm);
+	setup_arg_pages(bprm, EXSTACK_DEFAULT);
=20
 	create_som_tables(bprm);
=20
diff -uNrp linux-2.6.4.EXSTACK/fs/exec.c linux-2.6.4.noexec2/fs/exec.c
--- linux-2.6.4.EXSTACK/fs/exec.c	2004-03-23 22:42:31.000000000 +0100
+++ linux-2.6.4.noexec2/fs/exec.c	2004-03-24 01:18:14.000000000 +0100
@@ -342,7 +342,7 @@ out_sig:
 	return;
 }
=20
-int setup_arg_pages(struct linux_binprm *bprm)
+int setup_arg_pages(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
@@ -425,8 +425,16 @@ int setup_arg_pages(struct linux_binprm=20
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D STACK_TOP;
 #endif
-		mpnt->vm_page_prot =3D protection_map[VM_STACK_FLAGS & 0x7];
-		mpnt->vm_flags =3D VM_STACK_FLAGS;
+		/* Adjust stack execute permissions; explicitly enable=20
+		 * for EXSTACK_ENABLE_X, disable for EXSTACK_DISABLE_X
+		 * and leave alone (arch default) otherwise. */
+		if (unlikely(executable_stack =3D=3D EXSTACK_ENABLE_X))
+			mpnt->vm_flags =3D VM_STACK_FLAGS |  VM_EXEC;
+		else if (executable_stack =3D=3D EXSTACK_DISABLE_X)
+			mpnt->vm_flags =3D VM_STACK_FLAGS & ~VM_EXEC;
+		else
+			mpnt->vm_flags =3D VM_STACK_FLAGS;
+		mpnt->vm_page_prot =3D protection_map[mpnt->vm_flags & 0x7];
 		mpnt->vm_ops =3D NULL;
 		mpnt->vm_pgoff =3D mpnt->vm_start >> PAGE_SHIFT;
 		mpnt->vm_file =3D NULL;
diff -uNrp linux-2.6.4.EXSTACK/include/linux/binfmts.h linux-2.6.4.noexec2/=
include/linux/binfmts.h
--- linux-2.6.4.EXSTACK/include/linux/binfmts.h	2004-03-23 22:42:31.0000000=
00 +0100
+++ linux-2.6.4.noexec2/include/linux/binfmts.h	2004-03-24 01:15:09.0000000=
00 +0100
@@ -58,7 +58,10 @@ extern int prepare_binprm(struct linux_b
 extern void remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
-extern int setup_arg_pages(struct linux_binprm * bprm);
+#define EXSTACK_DEFAULT   0
+#define EXSTACK_DISABLE_X 1
+#define EXSTACK_ENABLE_X  2
+extern int setup_arg_pages(struct linux_binprm * bprm, int executable_stac=
k);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_=
binprm *bprm);=20
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *=
bprm);
 extern void compute_creds(struct linux_binprm *binprm);
diff -uNrp linux-2.6.4.EXSTACK/include/linux/elf.h linux-2.6.4.noexec2/incl=
ude/linux/elf.h
--- linux-2.6.4.EXSTACK/include/linux/elf.h	2004-03-23 22:42:31.000000000 +=
0100
+++ linux-2.6.4.noexec2/include/linux/elf.h	2004-03-23 21:18:35.000000000 +=
0100
@@ -35,6 +35,8 @@ typedef __s64	Elf64_Sxword;
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
=20
+#define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+
 /* These constants define the different elf file types */
 #define ET_NONE   0
 #define ET_REL    1

--TPGKQYD3WP7vMswh--

--DMefDzZywwCHZelG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYNScxmLh6hyYd04RAkzzAJ9czl0tBwQZx5tb9Z0En7bXRxjX1ACgohpX
fBHh0q8i5Fy5bDAgSw3Mw2E=
=QMJJ
-----END PGP SIGNATURE-----

--DMefDzZywwCHZelG--
