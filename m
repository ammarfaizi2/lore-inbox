Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUGRInz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUGRInz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 04:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUGRInz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 04:43:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63125 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263040AbUGRInq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 04:43:46 -0400
Date: Sun, 18 Jul 2004 10:44:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
Subject: [patch] NX: clean up legacy binary support, 2.6.8-rc2
Message-ID: <20040718084406.GA4766@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch cleans up legacy x86 binary support by introducing a
new personality bit: READ_IMPLIES_EXEC, and implements Linus' suggestion
to add the PROT_EXEC bit on the two affected syscall entry places,
sys_mprotect() and sys_mmap(). If this bit is set then PROT_READ will
also add the PROT_EXEC bit - as expected by legacy x86 binaries. The ELF
loader will automatically set this bit when it encounters a legacy
binary.

This approach avoids the problems the previous ->def_flags solution
caused. In particular this patch fixes the PROT_NONE problem in a
cleaner way (http://lkml.org/lkml/2004/7/12/227), and it should fix the
ia64 PROT_EXEC problem reported by David Mosberger. Also,
mprotect(PROT_READ) done by legacy binaries will do the right thing as
well.

the details:

- the personality bit is added to the personality mask upon exec(), 
  within the ELF loader, but is not cleared (see the exceptions below). 
  This means that if an environment that already has the bit exec()s a
  new-style binary it will still get the old behavior.

- one exception are setuid/setgid binaries: these will reset the
  bit - thus local attackers cannot manually set the bit and circumvent
  NX protection. Legacy setuid binaries will still get the bit through
  the ELF loader. This gives us maximum flexibility in shaping
  compatibility environments.

- selinux also clears the bit when switching SIDs via exec().

- x86 is the only arch making use of READ_IMPLIES_EXEC currently. Other
  arches will have the pre-NX-patch protection setup they always had.

I have booted an old distro [RH 7.2] and two new PT_GNU_STACK distros
[SuSE 9.2 and FC2] on an NX-capable CPU - they work just fine and all
the mapping details are right. I've checked the PROT_NONE test-utility
as well and it works as expected. I have checked various setuid
scenarios as well involving legacy and new-style binaries.

an improved setarch utility can be used to set the personality bit
manually:

	http://redhat.com/~mingo/nx-patches/setarch-1.4-3.tar.gz

the new '-X' flag does it, e.g.:

	./setarch -X linux /bin/cat /proc/self/maps

will trigger the old protection layout even on a new distro.

	Ingo


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-legacy-2.6.8-rc2-A7"


Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/personality.h.orig	
+++ linux/include/linux/personality.h	
@@ -30,6 +30,7 @@ extern int abi_fake_utsname;
  */
 enum {
 	MMAP_PAGE_ZERO =	0x0100000,
+	READ_IMPLIES_EXEC =	0x0400000,
 	ADDR_LIMIT_32BIT =	0x0800000,
 	SHORT_INODE =		0x1000000,
 	WHOLE_SECONDS =		0x2000000,
@@ -38,6 +39,12 @@ enum {
 };
 
 /*
+ * Security-relevant compatibility flags that must be
+ * cleared upon setuid or setgid exec:
+ */
+#define PER_CLEAR_ON_SETID (READ_IMPLIES_EXEC)
+
+/*
  * Personality types.
  *
  * These go in the low byte.  Avoid using the top bit, it will
--- linux/include/asm-i386/elf.h.orig	
+++ linux/include/asm-i386/elf.h	
@@ -117,7 +117,13 @@ typedef struct user_fxsr_struct elf_fpxr
 #define AT_SYSINFO_EHDR		33
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
+
+/*
+ * A legacy binary, when loaded by the ELF loader, will have the
+ * READ_IMPLIES_EXEC personality flag set automatically:
+ */
+#define LEGACY_BINARIES
 
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -140,8 +140,10 @@ static __inline__ int get_order(unsigned
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS \
+	(VM_READ | VM_WRITE | \
+	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
+		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif /* __KERNEL__ */
 
--- linux/fs/exec.c.orig	
+++ linux/fs/exec.c	
@@ -887,8 +887,10 @@ int prepare_binprm(struct linux_binprm *
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID) {
+			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
+		}
 
 		/* Set-gid? */
 		/*
@@ -896,8 +898,10 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
+		}
 	}
 
 	/* fill in binprm security blob */
--- linux/fs/binfmt_elf.c.orig	
+++ linux/fs/binfmt_elf.c	
@@ -627,8 +627,10 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
+#ifdef LEGACY_BINARIES
 	if (i == elf_ex.e_phnum)
-		def_flags |= VM_EXEC | VM_MAYEXEC;
+		current->personality |= READ_IMPLIES_EXEC;
+#endif
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
--- linux/security/selinux/hooks.c.orig	
+++ linux/security/selinux/hooks.c	
@@ -1894,6 +1894,9 @@ static void selinux_bprm_apply_creds(str
 			task_unlock(current);
 		}
 
+		/* Clear any possibly unsafe personality bits on exec: */
+		current->personality &= ~PER_CLEAR_ON_SETID;
+
 		/* Close files for which the new task SID is not authorized. */
 		flush_unauthorized_files(current->files);
 
--- linux/mm/mprotect.c.orig	
+++ linux/mm/mprotect.c	
@@ -17,6 +17,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/mempolicy.h>
+#include <linux/personality.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -205,6 +206,12 @@ sys_mprotect(unsigned long start, size_t
 		return -EINVAL;
 	if (end == start)
 		return 0;
+	/*
+	 * Does the application expect PROT_READ to imply PROT_EXEC:
+	 */
+	if (unlikely((prot & PROT_READ) &&
+			(current->personality & READ_IMPLIES_EXEC)))
+		prot |= PROT_EXEC;
 
 	vm_flags = calc_vm_prot_bits(prot);
 
--- linux/mm/mmap.c.orig	
+++ linux/mm/mmap.c	
@@ -750,6 +750,13 @@ unsigned long do_mmap_pgoff(struct file 
 	int accountable = 1;
 	unsigned long charged = 0;
 
+	/*
+	 * Does the application expect PROT_READ to imply PROT_EXEC:
+	 */
+	if (unlikely((prot & PROT_READ) &&
+			(current->personality & READ_IMPLIES_EXEC)))
+		prot |= PROT_EXEC;
+
 	if (file) {
 		if (is_file_hugepages(file))
 			accountable = 0;
@@ -792,12 +799,6 @@ unsigned long do_mmap_pgoff(struct file 
 	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
-	/*
-	 * mm->def_flags might have VM_EXEC set, which PROT_NONE does NOT want.
-	 */
-	if (prot == PROT_NONE)
-		vm_flags &= ~VM_EXEC;
-
 	if (flags & MAP_LOCKED) {
 		if (!capable(CAP_IPC_LOCK))
 			return -EPERM;

--3V7upXqbjpZ4EhLz--
