Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFGM35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 08:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFGM35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 08:29:57 -0400
Received: from dp.samba.org ([66.70.73.150]:57732 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263176AbTFGM3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 08:29:43 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.56616.35782.882995@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 22:40:08 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch moves the definitions of BUG, BUG_ON and WARN_ON from
<linux/kernel.h> to <asm/bug.h> (which <linux/kernel.h> includes), and
supplies a new implementation for PPC which uses a conditional trap
instruction for BUG_ON and WARN_ON, thus avoiding a conditional
branch.  This patch trims over 50kB from the size of the kernel that I
use on powermacs.

With this patch, on PPC we have a __bug_table section in the vmlinux
binary, and also in modules if they use BUG, BUG_ON or WARN_ON.  The
__bug_table section has one entry for each BUG/BUG_ON/WARN_ON, giving
the address of the trap instruction and the corresponding line number,
filename and function name.  This information is used in the exception
handler for the exception that the trap instruction produces.  The
arch-specific module code handles the __bug_table section so that
BUG/BUG_ON/WARN_ON work correctly in modules.

Several architecture maintainers have acked this change.  It should be
completely benign for all of the other architectures (though they may
decide to do something similar if they have a conditional trap
instruction available).

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/boot/ld.script pmac-2.5/arch/ppc/boot/ld.script
--- linux-2.5/arch/ppc/boot/ld.script	2003-05-29 13:45:33.000000000 +1000
+++ pmac-2.5/arch/ppc/boot/ld.script	2003-05-29 21:06:53.000000000 +1000
@@ -81,6 +81,7 @@
   /DISCARD/ : {
     *(__ksymtab)
     *(__ksymtab_strings)
+    *(__bug_table)
   }
 
 }
diff -urN linux-2.5/arch/ppc/kernel/module.c pmac-2.5/arch/ppc/kernel/module.c
--- linux-2.5/arch/ppc/kernel/module.c	2003-05-14 08:22:45.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/module.c	2003-06-07 22:09:49.000000000 +1000
@@ -16,6 +16,7 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
@@ -29,6 +30,8 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+LIST_HEAD(module_bug_list);
+
 void *module_alloc(unsigned long size)
 {
 	if (size == 0)
@@ -267,9 +270,48 @@
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+	char *secstrings;
+	unsigned int i;
+
+	me->arch.bug_table = NULL;
+	me->arch.num_bugs = 0;
+
+	/* Find the __bug_table section, if present */
+	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
+			continue;
+		me->arch.bug_table = (void *) sechdrs[i].sh_addr;
+		me->arch.num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
+		break;
+	}
+
+	/*
+	 * Strictly speaking this should have a spinlock to protect against
+	 * traversals, but since we only traverse on BUG()s, a spinlock
+	 * could potentially lead to deadlock and thus be counter-productive.
+	 */
+	list_add(&me->arch.bug_list, &module_bug_list);
+
 	return 0;
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+	list_del(&mod->arch.bug_list);
+}
+
+struct bug_entry *module_find_bug(unsigned long bugaddr)
+{
+	struct mod_arch_specific *mod;
+	unsigned int i;
+	struct bug_entry *bug;
+
+	list_for_each_entry(mod, &module_bug_list, bug_list) {
+		bug = mod->bug_table;
+		for (i = 0; i < mod->num_bugs; ++i, ++bug)
+			if (bugaddr == bug->bug_addr)
+				return bug;
+	}
+	return NULL;
 }
diff -urN linux-2.5/arch/ppc/kernel/traps.c pmac-2.5/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2003-06-06 08:05:28.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/traps.c	2003-06-07 12:03:26.000000000 +1000
@@ -296,6 +296,56 @@
 	return(retval);
 }
 
+/*
+ * Look through the list of trap instructions that are used for BUG(),
+ * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
+ * that the exception was caused by a trap instruction of some kind.
+ * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
+ * otherwise.
+ */
+extern struct bug_entry __start___bug_table[], __stop___bug_table[];
+
+#ifndef CONFIG_MODULES
+#define module_find_bug(x)	NULL
+#endif
+
+static struct bug_entry *find_bug(unsigned long bugaddr)
+{
+	struct bug_entry *bug;
+
+	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
+		if (bugaddr == bug->bug_addr)
+			return bug;
+	return module_find_bug(bugaddr);
+}
+
+int
+check_bug_trap(struct pt_regs *regs)
+{
+	struct bug_entry *bug;
+	unsigned long addr;
+
+	if (regs->msr & MSR_PR)
+		return 0;	/* not in kernel */
+	addr = regs->nip;	/* address of trap instruction */
+	if (addr < PAGE_OFFSET)
+		return 0;
+	bug = find_bug(regs->nip);
+	if (bug == NULL)
+		return 0;
+	if (bug->line & BUG_WARNING_TRAP) {
+		/* this is a WARN_ON rather than BUG/BUG_ON */
+		printk(KERN_ERR "Badness in %s at %s:%d\n",
+		       bug->function, bug->file,
+		       bug->line & ~BUG_WARNING_TRAP);
+		dump_stack();
+		return 1;
+	}
+	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, bug->line);
+	return 0;
+}
+
 void
 ProgramCheckException(struct pt_regs *regs)
 {
@@ -325,6 +375,10 @@
 		/* trap exception */
 		if (debugger_bpt(regs))
 			return;
+		if (check_bug_trap(regs)) {
+			regs->nip += 4;
+			return;
+		}
 		_exception(SIGTRAP, regs);
 		return;
 	}
diff -urN linux-2.5/arch/ppc/vmlinux.lds.S pmac-2.5/arch/ppc/vmlinux.lds.S
--- linux-2.5/arch/ppc/vmlinux.lds.S	2003-04-14 09:28:41.000000000 +1000
+++ pmac-2.5/arch/ppc/vmlinux.lds.S	2003-05-26 21:58:49.000000000 +1000
@@ -54,6 +54,10 @@
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
 
+  __start___bug_table = .;
+  __bug_table : { *(__bug_table) }
+  __stop___bug_table = .;
+
   /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
   .data    :
diff -urN linux-2.5/include/asm-alpha/bug.h pmac-2.5/include/asm-alpha/bug.h
--- linux-2.5/include/asm-alpha/bug.h	2002-02-25 03:51:44.000000000 +1100
+++ pmac-2.5/include/asm-alpha/bug.h	2003-05-29 19:51:06.000000000 +1000
@@ -9,6 +9,15 @@
   __asm__ __volatile__("call_pal %0  # bugchk\n\t"".long %1\n\t.8byte %2" \
 		       : : "i" (PAL_bugchk), "i"(__LINE__), "i"(__FILE__))
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page)	BUG()
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-arm/bug.h pmac-2.5/include/asm-arm/bug.h
--- linux-2.5/include/asm-arm/bug.h	2003-02-04 19:36:43.000000000 +1100
+++ pmac-2.5/include/asm-arm/bug.h	2003-05-29 19:49:38.000000000 +1000
@@ -18,4 +18,13 @@
 
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-cris/bug.h pmac-2.5/include/asm-cris/bug.h
--- linux-2.5/include/asm-cris/bug.h	2002-01-06 22:46:09.000000000 +1100
+++ pmac-2.5/include/asm-cris/bug.h	2003-05-29 19:49:48.000000000 +1000
@@ -9,4 +9,13 @@
          BUG(); \
 } while (0)
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-h8300/bug.h pmac-2.5/include/asm-h8300/bug.h
--- linux-2.5/include/asm-h8300/bug.h	2003-04-18 05:31:21.000000000 +1000
+++ pmac-2.5/include/asm-h8300/bug.h	2003-05-29 19:50:01.000000000 +1000
@@ -9,4 +9,13 @@
          BUG(); \
 } while (0)
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-i386/bug.h pmac-2.5/include/asm-i386/bug.h
--- linux-2.5/include/asm-i386/bug.h	2003-03-08 14:12:53.000000000 +1100
+++ pmac-2.5/include/asm-i386/bug.h	2003-05-29 19:51:35.000000000 +1000
@@ -19,8 +19,17 @@
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-ia64/bug.h pmac-2.5/include/asm-ia64/bug.h
--- linux-2.5/include/asm-ia64/bug.h	2002-01-06 22:57:28.000000000 +1100
+++ pmac-2.5/include/asm-ia64/bug.h	2003-05-29 19:51:50.000000000 +1000
@@ -7,6 +7,16 @@
 # define ia64_abort()	(*(volatile int *) 0 = 0)
 #endif
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); ia64_abort(); } while (0)
+
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-m68k/bug.h pmac-2.5/include/asm-m68k/bug.h
--- linux-2.5/include/asm-m68k/bug.h	2002-07-26 06:17:16.000000000 +1000
+++ pmac-2.5/include/asm-m68k/bug.h	2003-05-29 19:50:57.000000000 +1000
@@ -21,8 +21,20 @@
 } while (0)
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-m68knommu/bug.h pmac-2.5/include/asm-m68knommu/bug.h
--- linux-2.5/include/asm-m68knommu/bug.h	2003-01-15 22:04:34.000000000 +1100
+++ pmac-2.5/include/asm-m68knommu/bug.h	2003-05-29 19:52:13.000000000 +1000
@@ -5,8 +5,20 @@
   printk("%s(%d): kernel BUG!\n", __FILE__, __LINE__); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
          BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-mips/bug.h pmac-2.5/include/asm-mips/bug.h
--- linux-2.5/include/asm-mips/bug.h	2002-01-06 22:57:49.000000000 +1100
+++ pmac-2.5/include/asm-mips/bug.h	2003-05-29 19:52:26.000000000 +1000
@@ -3,6 +3,14 @@
 #define __ASM_BUG_H
 
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-mips64/bug.h pmac-2.5/include/asm-mips64/bug.h
--- linux-2.5/include/asm-mips64/bug.h	2002-01-06 22:51:12.000000000 +1100
+++ pmac-2.5/include/asm-mips64/bug.h	2003-05-29 19:52:32.000000000 +1000
@@ -2,6 +2,14 @@
 #define _ASM_BUG_H
 
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *(int *)0=0; } while (0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) do {  BUG(); } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-parisc/bug.h pmac-2.5/include/asm-parisc/bug.h
--- linux-2.5/include/asm-parisc/bug.h	2003-03-20 09:07:22.000000000 +1100
+++ pmac-2.5/include/asm-parisc/bug.h	2003-05-29 19:52:43.000000000 +1000
@@ -10,8 +10,20 @@
 	dump_stack(); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-ppc/bug.h pmac-2.5/include/asm-ppc/bug.h
--- linux-2.5/include/asm-ppc/bug.h	2003-05-29 13:45:33.000000000 +1000
+++ pmac-2.5/include/asm-ppc/bug.h	2003-05-29 21:23:54.000000000 +1000
@@ -1,11 +1,48 @@
 #ifndef _PPC_BUG_H
 #define _PPC_BUG_H
 
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".long 0x0"); \
+struct bug_entry {
+	unsigned long	bug_addr;
+	int		line;
+	const char	*file;
+	const char	*function;
+};
+
+/*
+ * If this bit is set in the line number it means that the trap
+ * is for WARN_ON rather than BUG or BUG_ON.
+ */
+#define BUG_WARNING_TRAP	0x1000000
+
+#define BUG() do {							 \
+	__asm__ __volatile__(						 \
+		"1:	twi 31,0,0\n"					 \
+		".section __bug_table,\"a\"\n\t"			 \
+		"	.long 1b,%0,%1,%2\n"				 \
+		".previous"						 \
+		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
+} while (0)
+
+#define BUG_ON(x) do {						\
+	__asm__ __volatile__(					\
+		"1:	twnei %0,0\n"				\
+		".section __bug_table,\"a\"\n\t"		\
+		"	.long 1b,%1,%2,%3\n"			\
+		".previous"					\
+		: : "r" (x), "i" (__LINE__), "i" (__FILE__),	\
+		    "i" (__FUNCTION__));			\
 } while (0)
 
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
+#define WARN_ON(x) do {						\
+	__asm__ __volatile__(					\
+		"1:	twnei %0,0\n"				\
+		".section __bug_table,\"a\"\n\t"		\
+		"	.long 1b,%1,%2,%3\n"			\
+		".previous"					\
+		: : "r" (x), "i" (__LINE__ + BUG_WARNING_TRAP),	\
+		    "i" (__FILE__), "i" (__FUNCTION__));	\
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-ppc/module.h pmac-2.5/include/asm-ppc/module.h
--- linux-2.5/include/asm-ppc/module.h	2003-01-03 07:26:42.000000000 +1100
+++ pmac-2.5/include/asm-ppc/module.h	2003-06-07 17:47:56.000000000 +1000
@@ -2,6 +2,9 @@
 #define _ASM_PPC_MODULE_H
 /* Module stuff for PPC.  (C) 2001 Rusty Russell */
 
+#include <linux/list.h>
+#include <asm/bug.h>
+
 /* Thanks to Paul M for explaining this.
 
    PPC can only do rel jumps += 32MB, and often the kernel and other
@@ -20,8 +23,15 @@
 {
 	/* Indices of PLT sections within module. */
 	unsigned int core_plt_section, init_plt_section;
+
+	/* List of BUG addresses, source line numbers and filenames */
+	struct list_head bug_list;
+	struct bug_entry *bug_table;
+	unsigned int num_bugs;
 };
 
+extern struct bug_entry *module_find_bug(unsigned long bugaddr);
+
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
diff -urN linux-2.5/include/asm-ppc64/bug.h pmac-2.5/include/asm-ppc64/bug.h
--- linux-2.5/include/asm-ppc64/bug.h	2003-01-15 20:38:42.000000000 +1100
+++ pmac-2.5/include/asm-ppc64/bug.h	2003-05-29 19:55:29.000000000 +1000
@@ -27,7 +27,16 @@
 } while (0)
 #endif
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
 #endif
diff -urN linux-2.5/include/asm-s390/bug.h pmac-2.5/include/asm-s390/bug.h
--- linux-2.5/include/asm-s390/bug.h	2002-01-06 22:53:36.000000000 +1100
+++ pmac-2.5/include/asm-s390/bug.h	2003-05-29 19:55:38.000000000 +1000
@@ -6,8 +6,20 @@
         __asm__ __volatile__(".long 0"); \
 } while (0)                                       
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
         BUG(); \
 } while (0)                      
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-sh/bug.h pmac-2.5/include/asm-sh/bug.h
--- linux-2.5/include/asm-sh/bug.h	2002-01-06 22:54:51.000000000 +1100
+++ pmac-2.5/include/asm-sh/bug.h	2003-05-29 21:25:48.000000000 +1000
@@ -9,8 +9,20 @@
 	asm volatile("nop"); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-sparc/bug.h pmac-2.5/include/asm-sparc/bug.h
--- linux-2.5/include/asm-sparc/bug.h	2003-05-23 07:41:16.000000000 +1000
+++ pmac-2.5/include/asm-sparc/bug.h	2003-05-29 19:55:49.000000000 +1000
@@ -12,8 +12,20 @@
 #define BUG()		__builtin_trap()
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-sparc64/bug.h pmac-2.5/include/asm-sparc64/bug.h
--- linux-2.5/include/asm-sparc64/bug.h	2003-01-16 07:58:55.000000000 +1100
+++ pmac-2.5/include/asm-sparc64/bug.h	2003-05-29 19:55:55.000000000 +1000
@@ -13,8 +13,20 @@
 #define BUG()		__builtin_trap()
 #endif
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/asm-um/bug.h pmac-2.5/include/asm-um/bug.h
--- linux-2.5/include/asm-um/bug.h	2003-01-17 02:42:26.000000000 +1100
+++ pmac-2.5/include/asm-um/bug.h	2003-05-29 19:56:08.000000000 +1000
@@ -7,10 +7,22 @@
 	panic("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 } while (0)
 
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) \
+		BUG(); \
+} while(0)
+
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 extern int foo;
 
 #endif
diff -urN linux-2.5/include/asm-v850/bug.h pmac-2.5/include/asm-v850/bug.h
--- linux-2.5/include/asm-v850/bug.h	2003-02-18 13:41:09.000000000 +1100
+++ pmac-2.5/include/asm-v850/bug.h	2003-05-29 19:56:18.000000000 +1000
@@ -18,4 +18,13 @@
 #define BUG()		__bug()
 #define PAGE_BUG(page)	__bug()
 
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif /* __V850_BUG_H__ */
diff -urN linux-2.5/include/asm-x86_64/bug.h pmac-2.5/include/asm-x86_64/bug.h
--- linux-2.5/include/asm-x86_64/bug.h	2003-01-17 06:36:26.000000000 +1100
+++ pmac-2.5/include/asm-x86_64/bug.h	2003-05-29 19:56:32.000000000 +1000
@@ -18,7 +18,15 @@
 #define BUG() \
 	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
 		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #define PAGE_BUG(page) BUG()
 void out_of_line_bug(void);
 
+#define WARN_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
+		dump_stack(); \
+	} \
+} while (0)
+
 #endif
diff -urN linux-2.5/include/linux/kernel.h pmac-2.5/include/linux/kernel.h
--- linux-2.5/include/linux/kernel.h	2003-05-23 07:41:16.000000000 +1000
+++ pmac-2.5/include/linux/kernel.h	2003-05-29 19:48:39.000000000 +1000
@@ -228,14 +228,6 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
-#define WARN_ON(condition) do { \
-	if (unlikely((condition)!=0)) { \
-		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
-		dump_stack(); \
-	} \
-} while (0)
-
 extern void BUILD_BUG(void);
 #define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
 
