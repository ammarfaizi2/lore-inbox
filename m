Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWJQTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJQTaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWJQTaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:30:01 -0400
Received: from gw.goop.org ([64.81.55.164]:52910 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751179AbWJQT37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:29:59 -0400
Message-ID: <4535310C.40708@goop.org>
Date: Tue, 17 Oct 2006 12:37:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> -generic-implementatation-of-bug.patch
> -generic-implementatation-of-bug-fix.patch
> +generic-bug-implementation.patch
>  generic-bug-for-i386.patch
>  generic-bug-for-x86-64.patch
>  uml-add-generic-bug-support.patch
>  use-generic-bug-for-ppc.patch
>  bug-test-1.patch
>
>  Updated generic-BUG-handling patches
>   
I thought the powerpc patch had been given a clean bill of health?  Or 
was there still a problem with it?

    J

--

From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Generic BUG for powerpc

This makes powerpc use the generic BUG machinery.  The biggest
difference from the previous powerpc bug code is that it no longer
reports the function name, since it is redundant with kallsyms, and
not needed in general.

There is an overall reduction of code, since module_32/64 duplicated
several functions.

Unfortunately there's no way to tell gcc that BUG won't return, so the
BUG macro includes a goto loop.  This will generate a real jmp
instruction, which is never used.

BTW, powerpc doesn't seem to be using BUG_OPCODE or
BUG_ILLEGAL_INSTRUCTION for actual BUGs any more (I presume they were
once used).  There are still a couple of uses of those macros
elsewhere (kernel/prom_init.c and kernel/head_64.S); should be
converted to "twi 31,0,0" as well?

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>
Cc: Hugh Dickens <hugh@veritas.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 arch/powerpc/Kconfig              |    5 ++
 arch/powerpc/kernel/module_32.c   |   45 +------------------
 arch/powerpc/kernel/module_64.c   |   45 +------------------
 arch/powerpc/kernel/traps.c       |   47 +++-----------------
 arch/powerpc/kernel/vmlinux.lds.S |    6 --
 arch/powerpc/xmon/xmon.c          |   11 ++--
 include/asm-powerpc/bug.h         |   84 ++++++++++++++++++-------------------
 include/asm-powerpc/module.h      |    2
 8 files changed, 70 insertions(+), 175 deletions(-)

diff -r 19fef64d6aef arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/Kconfig	Tue Oct 17 12:34:09 2006 -0700
@@ -106,6 +106,11 @@ config AUDIT_ARCH
 config AUDIT_ARCH
 	bool
 	default y
+
+config GENERIC_BUG
+	bool
+	default y
+	depends on BUG
 
 config DEFAULT_UIMAGE
 	bool
diff -r 19fef64d6aef arch/powerpc/kernel/module_32.c
--- a/arch/powerpc/kernel/module_32.c	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/kernel/module_32.c	Tue Oct 17 12:34:09 2006 -0700
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/cache.h>
+#include <linux/bug.h>
 
 #if 0
 #define DEBUGP printk
@@ -273,48 +274,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	char *secstrings;
-	unsigned int i;
-
-	me->arch.bug_table = NULL;
-	me->arch.num_bugs = 0;
-
-	/* Find the __bug_table section, if present */
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
-			continue;
-		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
-		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
-		break;
-	}
-
-	/*
-	 * Strictly speaking this should have a spinlock to protect against
-	 * traversals, but since we only traverse on BUG()s, a spinlock
-	 * could potentially lead to deadlock and thus be counter-productive.
-	 */
-	list_add(&me->arch.bug_list, &module_bug_list);
-
-	return 0;
+	return module_bug_finalize(hdr, sechdrs, me);
 }
 
 void module_arch_cleanup(struct module *mod)
 {
-	list_del(&mod->arch.bug_list);
-}
-
-struct bug_entry *module_find_bug(unsigned long bugaddr)
-{
-	struct mod_arch_specific *mod;
-	unsigned int i;
-	struct bug_entry *bug;
-
-	list_for_each_entry(mod, &module_bug_list, bug_list) {
-		bug = mod->bug_table;
-		for (i = 0; i < mod->num_bugs; ++i, ++bug)
-			if (bugaddr == bug->bug_addr)
-				return bug;
-	}
-	return NULL;
-}
+	module_bug_cleanup(mod);
+}
diff -r 19fef64d6aef arch/powerpc/kernel/module_64.c
--- a/arch/powerpc/kernel/module_64.c	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/kernel/module_64.c	Tue Oct 17 12:34:09 2006 -0700
@@ -20,6 +20,7 @@
 #include <linux/moduleloader.h>
 #include <linux/err.h>
 #include <linux/vmalloc.h>
+#include <linux/bug.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
 
@@ -416,48 +417,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 int module_finalize(const Elf_Ehdr *hdr,
 		const Elf_Shdr *sechdrs, struct module *me)
 {
-	char *secstrings;
-	unsigned int i;
-
-	me->arch.bug_table = NULL;
-	me->arch.num_bugs = 0;
-
-	/* Find the __bug_table section, if present */
-	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
-			continue;
-		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
-		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
-		break;
-	}
-
-	/*
-	 * Strictly speaking this should have a spinlock to protect against
-	 * traversals, but since we only traverse on BUG()s, a spinlock
-	 * could potentially lead to deadlock and thus be counter-productive.
-	 */
-	list_add(&me->arch.bug_list, &module_bug_list);
-
-	return 0;
+	return module_bug_finalize(hdr, sechdrs, me);
 }
 
 void module_arch_cleanup(struct module *mod)
 {
-	list_del(&mod->arch.bug_list);
-}
-
-struct bug_entry *module_find_bug(unsigned long bugaddr)
-{
-	struct mod_arch_specific *mod;
-	unsigned int i;
-	struct bug_entry *bug;
-
-	list_for_each_entry(mod, &module_bug_list, bug_list) {
-		bug = mod->bug_table;
-		for (i = 0; i < mod->num_bugs; ++i, ++bug)
-			if (bugaddr == bug->bug_addr)
-				return bug;
-	}
-	return NULL;
-}
+	module_bug_cleanup(mod);
+}
diff -r 19fef64d6aef arch/powerpc/kernel/traps.c
--- a/arch/powerpc/kernel/traps.c	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/kernel/traps.c	Tue Oct 17 12:34:09 2006 -0700
@@ -32,6 +32,7 @@
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
 #include <linux/backlight.h>
+#include <linux/bug.h>
 
 #include <asm/kdebug.h>
 #include <asm/pgtable.h>
@@ -731,54 +732,9 @@ static int emulate_instruction(struct pt
 	return -EINVAL;
 }
 
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-static int check_bug_trap(struct pt_regs *regs)
-{
-	struct bug_entry *bug;
-	unsigned long addr;
-
-	if (regs->msr & MSR_PR)
-		return 0;	/* not in kernel */
-	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
-		return 0;
-	bug = find_bug(regs->nip);
-	if (bug == NULL)
-		return 0;
-	if (bug->line & BUG_WARNING_TRAP) {
-		/* this is a WARN_ON rather than BUG/BUG_ON */
-		printk(KERN_ERR "Badness in %s at %s:%ld\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-		dump_stack();
-		return 1;
-	}
-	printk(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
-	       bug->function, bug->file, bug->line);
-
-	return 0;
+int is_valid_bugaddr(unsigned long addr)
+{
+	return is_kernel_addr(addr);
 }
 
 void __kprobes program_check_exception(struct pt_regs *regs)
@@ -812,7 +768,9 @@ void __kprobes program_check_exception(s
 			return;
 		if (debugger_bpt(regs))
 			return;
-		if (check_bug_trap(regs)) {
+
+		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
+		    report_bug(regs->nip) == BUG_TRAP_TYPE_WARN) {
 			regs->nip += 4;
 			return;
 		}
diff -r 19fef64d6aef arch/powerpc/kernel/vmlinux.lds.S
--- a/arch/powerpc/kernel/vmlinux.lds.S	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/kernel/vmlinux.lds.S	Tue Oct 17 12:34:09 2006 -0700
@@ -61,11 +61,7 @@ SECTIONS
 		__stop___ex_table = .;
 	}
 
-	__bug_table : {
-		__start___bug_table = .;
-		*(__bug_table)
-		__stop___bug_table = .;
-	}
+	BUG_TABLE
 
 /*
  * Init sections discarded at runtime
diff -r 19fef64d6aef arch/powerpc/xmon/xmon.c
--- a/arch/powerpc/xmon/xmon.c	Tue Oct 17 12:26:34 2006 -0700
+++ b/arch/powerpc/xmon/xmon.c	Tue Oct 17 12:34:35 2006 -0700
@@ -22,6 +22,7 @@
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/bug.h>
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
@@ -35,7 +36,6 @@
 #include <asm/cputable.h>
 #include <asm/rtas.h>
 #include <asm/sstep.h>
-#include <asm/bug.h>
 #include <asm/irq_regs.h>
 
 #ifdef CONFIG_PPC64
@@ -1332,7 +1332,7 @@ static void backtrace(struct pt_regs *ex
 
 static void print_bug_trap(struct pt_regs *regs)
 {
-	struct bug_entry *bug;
+	const struct bug_entry *bug;
 	unsigned long addr;
 
 	if (regs->msr & MSR_PR)
@@ -1343,11 +1343,11 @@ static void print_bug_trap(struct pt_reg
 	bug = find_bug(regs->nip);
 	if (bug == NULL)
 		return;
-	if (bug->line & BUG_WARNING_TRAP)
+	if (is_warning_bug(bug))
 		return;
 
-	printf("kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, (unsigned int)bug->line);
+	printf("kernel BUG at %s:%u!\n",
+	       bug->file, bug->line);
 }
 
 void excprint(struct pt_regs *fp)
diff -r 19fef64d6aef include/asm-powerpc/bug.h
--- a/include/asm-powerpc/bug.h	Tue Oct 17 12:26:34 2006 -0700
+++ b/include/asm-powerpc/bug.h	Tue Oct 17 12:34:09 2006 -0700
@@ -13,22 +13,25 @@
 
 #ifndef __ASSEMBLY__
 
-struct bug_entry {
-	unsigned long	bug_addr;
-	long		line;
-	const char	*file;
-	const char	*function;
-};
+#ifdef CONFIG_BUG
 
-struct bug_entry *find_bug(unsigned long bugaddr);
-
-/*
- * If this bit is set in the line number it means that the trap
- * is for WARN_ON rather than BUG or BUG_ON.
- */
-#define BUG_WARNING_TRAP	0x1000000
-
-#ifdef CONFIG_BUG
+/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
+   sizeof(struct bug_entry), respectively */
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define _EMIT_BUG_ENTRY				\
+	".section __bug_table,\"a\"\n"		\
+	"2:\t" PPC_LONG "1b, %0\n"		\
+	"\t.short %1, %2\n"			\
+	".org 2b+%3\n"				\
+	".previous\n"
+#else
+#define _EMIT_BUG_ENTRY				\
+	".section __bug_table,\"a\"\n"		\
+	"2:\t" PPC_LONG "1b\n"			\
+	"\t.short %2\n"				\
+	".org 2b+%3\n"				\
+	".previous\n"
+#endif
 
 /*
  * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
@@ -36,14 +39,13 @@ struct bug_entry *find_bug(unsigned long
  * some compiler versions may not produce optimal results.
  */
 
-#define BUG() do {							 \
-	__asm__ __volatile__(						 \
-		"1:	twi 31,0,0\n"					 \
-		".section __bug_table,\"a\"\n"				 \
-		"\t"PPC_LONG"	1b,%0,%1,%2\n"				 \
-		".previous"						 \
-		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
-} while (0)
+#define BUG() do {							\
+		__asm__ __volatile__(					\
+			"1:	twi 31,0,0\n"				\
+			_EMIT_BUG_ENTRY					\
+			: : "i" (__FILE__), "i" (__LINE__), "i" (0));	\
+		for(;;) ;						\
+	} while (0)
 
 #define BUG_ON(x) do {						\
 	if (__builtin_constant_p(x)) {				\
@@ -51,23 +53,22 @@ struct bug_entry *find_bug(unsigned long
 			BUG();					\
 	} else {						\
 		__asm__ __volatile__(				\
-		"1:	"PPC_TLNEI"	%0,0\n"			\
-		".section __bug_table,\"a\"\n"			\
-		"\t"PPC_LONG"	1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" ((long)(x)), "i" (__LINE__),		\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
+		"1:	"PPC_TLNEI"	%4,0\n"			\
+		_EMIT_BUG_ENTRY					\
+		: : "i" (__FILE__), "i" (__LINE__), "i" (0),	\
+		  "i" (sizeof(struct bug_entry)),		\
+		  "r" ((long)(x)));				\
+		for(;;) ;					\
 	}							\
 } while (0)
 
 #define __WARN() do {						\
 	__asm__ __volatile__(					\
 		"1:	twi 31,0,0\n"				\
-		".section __bug_table,\"a\"\n"			\
-		"\t"PPC_LONG"	1b,%0,%1,%2\n"			\
-		".previous"					\
-		: : "i" (__LINE__ + BUG_WARNING_TRAP),		\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
+		_EMIT_BUG_ENTRY					\
+		: : "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (BUGFLAG_WARNING),			\
+		  "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
 #define WARN_ON(x) ({						\
@@ -77,13 +78,12 @@ struct bug_entry *find_bug(unsigned long
 			__WARN();				\
 	} else {						\
 		__asm__ __volatile__(				\
-		"1:	"PPC_TLNEI"	%0,0\n"			\
-		".section __bug_table,\"a\"\n"			\
-		"\t"PPC_LONG"	1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" (__ret_warn_on),			\
-		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
+		"1:	"PPC_TLNEI"	%4,0\n"			\
+		_EMIT_BUG_ENTRY					\
+		: : "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (BUGFLAG_WARNING),			\
+		  "i" (sizeof(struct bug_entry)),		\
+		  "r" (__ret_warn_on));				\
 	}							\
 	unlikely(__ret_warn_on);				\
 })
diff -r 19fef64d6aef include/asm-powerpc/module.h
--- a/include/asm-powerpc/module.h	Tue Oct 17 12:26:34 2006 -0700
+++ b/include/asm-powerpc/module.h	Tue Oct 17 12:34:09 2006 -0700
@@ -45,8 +45,6 @@ struct mod_arch_specific {
 	struct bug_entry *bug_table;
 	unsigned int num_bugs;
 };
-
-extern struct bug_entry *module_find_bug(unsigned long bugaddr);
 
 /*
  * Select ELF headers.

