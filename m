Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbSIYD1w>; Tue, 24 Sep 2002 23:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbSIYD1W>; Tue, 24 Sep 2002 23:27:22 -0400
Received: from dp.samba.org ([66.70.73.150]:46976 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261903AbSIYDQs>;
	Tue, 24 Sep 2002 23:16:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 18/20: exception table arch cleanup
Date: Wed, 25 Sep 2002 13:19:18 +1000
Message-Id: <20020925032201.D495E2C151@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: extable cleanup
Author: Rusty Russell
Status: Experimental
Depends: Module/fini.patch.gz

D: This patch combines the common exception table searching
D: functionality for various architectures, to avoid unneccessary (and
D: currently buggy) duplication, and so that the exception table list
D: and lock can be kept private to module.c.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/i386/kernel/traps.c .17925-linux-2.5.38.updated/arch/i386/kernel/traps.c
--- .17925-linux-2.5.38/arch/i386/kernel/traps.c	2002-09-25 02:07:36.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/i386/kernel/traps.c	2002-09-25 02:08:05.000000000 +1000
@@ -329,7 +329,7 @@ static void inline do_trap(int trapnr, i
 	}
 
 	kernel_trap: {
-		unsigned long fixup;
+		const struct exception_table_entry *fixup;
 #ifdef CONFIG_PNPBIOS
 		if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
 		{
@@ -345,9 +345,9 @@ static void inline do_trap(int trapnr, i
 		}
 #endif	
 		
-		fixup = search_exception_table(regs->eip);
+		fixup = search_exception_tables(regs->eip);
 		if (fixup)
-			regs->eip = fixup;
+			regs->eip = fixup->fixup;
 		else	
 			die(str, regs, error_code);
 		return;
@@ -426,10 +426,10 @@ gp_in_vm86:
 
 gp_in_kernel:
 	{
-		unsigned long fixup;
-		fixup = search_exception_table(regs->eip);
+		const struct exception_table_entry *fixup;
+		fixup = search_exception_tables(regs->eip);
 		if (fixup) {
-			regs->eip = fixup;
+			regs->eip = fixup->fixup;
 			return;
 		}
 		die("general protection fault", regs, error_code);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/i386/mm/extable.c .17925-linux-2.5.38.updated/arch/i386/mm/extable.c
--- .17925-linux-2.5.38/arch/i386/mm/extable.c	2002-09-25 02:07:36.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/i386/mm/extable.c	2002-09-25 02:09:40.000000000 +1000
@@ -7,13 +7,11 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-extern const struct exception_table_entry __start___ex_table[];
-extern const struct exception_table_entry __stop___ex_table[];
-
-static inline unsigned long
-search_one_table(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 unsigned long value)
+/* Simple binary search */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
 {
         while (first <= last) {
 		const struct exception_table_entry *mid;
@@ -22,43 +20,11 @@ search_one_table(const struct exception_
 		mid = (last - first) / 2 + first;
 		diff = mid->insn - value;
                 if (diff == 0)
-                        return mid->fixup;
+                        return mid;
                 else if (diff < 0)
                         first = mid+1;
                 else
                         last = mid-1;
         }
-        return 0;
-}
-
-extern spinlock_t modlist_lock;
-
-unsigned long
-search_exception_table(unsigned long addr)
-{
-	unsigned long ret = 0;
-	
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	return ret;
-#else
-	unsigned long flags;
-	struct list_head *i;
-
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each(i, &extables) {
-		struct exception_table *ex
-			= list_entry(i, struct exception_table, list);
-		if (ex->num_entries == 0)
-			continue;
-		ret = search_one_table(ex->entry,
-				       ex->entry + ex->num_entries - 1, addr);
-		if (ret)
-			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	return ret;
-#endif
+        return NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/i386/mm/fault.c .17925-linux-2.5.38.updated/arch/i386/mm/fault.c
--- .17925-linux-2.5.38/arch/i386/mm/fault.c	2002-08-28 09:29:40.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/i386/mm/fault.c	2002-09-25 02:08:05.000000000 +1000
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -148,7 +149,7 @@ asmlinkage void do_page_fault(struct pt_
 	struct vm_area_struct * vma;
 	unsigned long address;
 	unsigned long page;
-	unsigned long fixup;
+	const struct exception_table_entry *fixup;
 	int write;
 	siginfo_t info;
 
@@ -304,8 +305,8 @@ bad_area:
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	if ((fixup = search_exception_table(regs->eip)) != 0) {
-		regs->eip = fixup;
+	if ((fixup = search_exception_tables(regs->eip)) != NULL) {
+		regs->eip = fixup->fixup;
 		return;
 	}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/ppc/kernel/traps.c .17925-linux-2.5.38.updated/arch/ppc/kernel/traps.c
--- .17925-linux-2.5.38/arch/ppc/kernel/traps.c	2002-09-21 13:55:09.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/ppc/kernel/traps.c	2002-09-25 02:08:05.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/module.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -115,7 +116,7 @@ void
 MachineCheckException(struct pt_regs *regs)
 {
 #ifdef CONFIG_ALL_PPC
-	unsigned long fixup;
+	const struct exception_table_entry *entry;
 #endif /* CONFIG_ALL_PPC */
 	unsigned long msr = regs->msr;
 
@@ -148,7 +149,7 @@ MachineCheckException(struct pt_regs *re
 	 *  -- paulus.
 	 */
 	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
-	    && (fixup = search_exception_table(regs->nip)) != 0) {
+	    && (entry = search_exception_tables(regs->nip)) != NULL) {
 		/*
 		 * Check that it's a sync instruction, or somewhere
 		 * in the twi; isync; nop sequence that inb/inw/inl uses.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/ppc/mm/extable.c .17925-linux-2.5.38.updated/arch/ppc/mm/extable.c
--- .17925-linux-2.5.38/arch/ppc/mm/extable.c	2002-09-21 13:55:09.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/ppc/mm/extable.c	2002-09-25 02:08:05.000000000 +1000
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 extern struct exception_table_entry __start___ex_table[];
@@ -40,16 +41,17 @@ sort_ex_table(struct exception_table_ent
 	}
 }
 
-void
+void __init
 sort_exception_table(void)
 {
 	sort_ex_table(__start___ex_table, __stop___ex_table);
 }
 
-static inline unsigned long
-search_one_table(const struct exception_table_entry *first,
-		 const struct exception_table_entry *last,
-		 unsigned long value)
+/* Simple binary search */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
 {
         while (first <= last) {
 		const struct exception_table_entry *mid;
@@ -58,36 +60,11 @@ search_one_table(const struct exception_
 		mid = (last - first) / 2 + first;
 		diff = mid->insn - value;
                 if (diff == 0)
-                        return mid->fixup;
+                        return mid;
                 else if (diff < 0)
                         first = mid+1;
                 else
                         last = mid-1;
         }
-        return 0;
-}
-
-unsigned long
-search_exception_table(unsigned long addr)
-{
-	unsigned long ret;
-
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	if (ret) return ret;
-#else
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	struct module *mp;
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL)
-			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr);
-		if (ret)
-			return ret;
-	}
-#endif
-
-	return 0;
+        return NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/ppc/mm/fault.c .17925-linux-2.5.38.updated/arch/ppc/mm/fault.c
--- .17925-linux-2.5.38/arch/ppc/mm/fault.c	2002-09-21 13:55:09.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/ppc/mm/fault.c	2002-09-25 02:08:05.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
+#include <linux/module.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -263,12 +264,11 @@ void
 bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
 	extern void die(const char *,struct pt_regs *,long);
-
-	unsigned long fixup;
+	const struct exception_table_entry *entry;
 
 	/* Are we prepared to handle this fault?  */
-	if ((fixup = search_exception_table(regs->nip)) != 0) {
-		regs->nip = fixup;
+	if ((entry = search_exception_tables(regs->nip)) != NULL) {
+		regs->nip = entry->fixup;
 		return;
 	}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/sparc64/kernel/traps.c .17925-linux-2.5.38.updated/arch/sparc64/kernel/traps.c
--- .17925-linux-2.5.38/arch/sparc64/kernel/traps.c	2002-09-21 13:55:12.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/sparc64/kernel/traps.c	2002-09-25 02:08:05.000000000 +1000
@@ -149,17 +149,17 @@ void data_access_exception (struct pt_re
 
 	if (regs->tstate & TSTATE_PRIV) {
 		/* Test if this comes from uaccess places. */
-		unsigned long fixup, g2;
+		const struct exception_table_entry *entry;
+		unsigned long g2 = regs->u_regs[UREG_G2];
 
-		g2 = regs->u_regs[UREG_G2];
-		if ((fixup = search_exception_table (regs->tpc, &g2))) {
+		if ((entry = search_extables_range(regs->tpc, &g2))) {
 			/* Ouch, somebody is trying ugly VM hole tricks on us... */
 #ifdef DEBUG_EXCEPTIONS
 			printk("Exception: PC<%016lx> faddr<UNKNOWN>\n", regs->tpc);
 			printk("EX_TABLE: insn<%016lx> fixup<%016lx> "
-			       "g2<%016lx>\n", regs->tpc, fixup, g2);
+			       "g2<%016lx>\n", regs->tpc, entry->fixup, g2);
 #endif
-			regs->tpc = fixup;
+			regs->tpc = entry->fixup;
 			regs->tnpc = regs->tpc + 4;
 			regs->u_regs[UREG_G2] = g2;
 			return;
@@ -1370,7 +1370,7 @@ void cheetah_deferred_handler(struct pt_
 			recoverable = 1;
 		} else {
 			unsigned long g2 = regs->u_regs[UREG_G2];
-			unsigned long fixup = search_exception_table(regs->tpc, &g2);
+			unsigned long fixup = search_extables_range(regs->tpc, &g2);
 
 			if (fixup != 0UL) {
 				/* OK, kernel access to userspace. */
@@ -1390,8 +1390,8 @@ void cheetah_deferred_handler(struct pt_
 				/* Only perform fixup if we still have a
 				 * recoverable condition.
 				 */
-				if (fixup != 0UL && recoverable) {
-					regs->tpc = fixup;
+				if (entry && recoverable) {
+					regs->tpc = entry->fixup;
 					regs->tnpc = regs->tpc + 4;
 					regs->u_regs[UREG_G2] = g2;
 				}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/sparc64/kernel/unaligned.c .17925-linux-2.5.38.updated/arch/sparc64/kernel/unaligned.c
--- .17925-linux-2.5.38/arch/sparc64/kernel/unaligned.c	2002-08-11 15:31:33.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/sparc64/kernel/unaligned.c	2002-09-25 02:08:05.000000000 +1000
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <asm/asi.h>
 #include <asm/ptrace.h>
 #include <asm/pstate.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/sparc64/mm/extable.c .17925-linux-2.5.38.updated/arch/sparc64/mm/extable.c
--- .17925-linux-2.5.38/arch/sparc64/mm/extable.c	2002-02-20 17:55:22.000000000 +1100
+++ .17925-linux-2.5.38.updated/arch/sparc64/mm/extable.c	2002-09-25 02:08:05.000000000 +1000
@@ -9,10 +9,11 @@
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 
-static unsigned long
-search_one_table(const struct exception_table_entry *start,
-		 const struct exception_table_entry *end,
-		 unsigned long value, unsigned long *g2)
+/* Caller knows they are in a range if ret->fixup == 0 */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *start,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
 {
 	const struct exception_table_entry *walk;
 
@@ -38,7 +39,7 @@ search_one_table(const struct exception_
 		}
 
 		if (walk->insn == value)
-			return walk->fixup;
+			return walk;
 	}
 
 	/* 2. Try to find a range match. */
@@ -46,43 +47,28 @@ search_one_table(const struct exception_
 		if (walk->fixup)
 			continue;
 
-		if (walk[0].insn <= value &&
-		    walk[1].insn > value) {
-			*g2 = (value - walk[0].insn) / 4;
-			return walk[1].fixup;
-		}
+		if (walk[0].insn <= value && walk[1].insn > value)
+			return walk;
 		walk++;
 	}
 
-        return 0;
+        return NULL;
 }
 
-extern spinlock_t modlist_lock;
-
-unsigned long
-search_exception_table(unsigned long addr, unsigned long *g2)
+/* Special exable search, which handles ranges.  Returns fixup */
+unsigned long search_extables_range(unsigned long addr, unsigned long *g2)
 {
-	unsigned long ret = 0, flags;
+	const struct exception_table_entry *entry;
 
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table,
-			       __stop___ex_table-1, addr, g2);
-	return ret;
-#else
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	struct module *mp;
+	entry = search_exception_tables(addr);
+	if (!entry)
+		return 0;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
-			continue;
-		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end-1, addr, g2);
-		if (ret)
-			break;
+	/* Inside range?  Fix g2 and return correct fixup */
+	if (!entry->fixup) {
+		*g2 = (addr - entry->insn) / 4;
+		return (entry + 1)->fixup;
 	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
-	return ret;
-#endif
+
+	return entry->fixup;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/arch/sparc64/mm/fault.c .17925-linux-2.5.38.updated/arch/sparc64/mm/fault.c
--- .17925-linux-2.5.38/arch/sparc64/mm/fault.c	2002-09-21 13:55:12.000000000 +1000
+++ .17925-linux-2.5.38.updated/arch/sparc64/mm/fault.c	2002-09-25 02:08:05.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/mman.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -282,10 +283,10 @@ static void do_kernel_fault(struct pt_re
 			else
 				asi = (insn >> 5);
 		}
-	
+
 		/* Look in asi.h: All _S asis have LS bit set */
 		if ((asi & 0x1) &&
-		    (fixup = search_exception_table (regs->tpc, &g2))) {
+		    (fizup = search_extables_range(regs->tpc, &g2))) {
 			regs->tpc = fixup;
 			regs->tnpc = regs->tpc + 4;
 			regs->u_regs[UREG_G2] = g2;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/include/asm-i386/uaccess.h .17925-linux-2.5.38.updated/include/asm-i386/uaccess.h
--- .17925-linux-2.5.38/include/asm-i386/uaccess.h	2002-05-24 15:20:31.000000000 +1000
+++ .17925-linux-2.5.38.updated/include/asm-i386/uaccess.h	2002-09-25 02:08:05.000000000 +1000
@@ -84,10 +84,6 @@ struct exception_table_entry
 	unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
-
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/include/asm-ppc/uaccess.h .17925-linux-2.5.38.updated/include/asm-ppc/uaccess.h
--- .17925-linux-2.5.38/include/asm-ppc/uaccess.h	2002-09-21 13:55:18.000000000 +1000
+++ .17925-linux-2.5.38.updated/include/asm-ppc/uaccess.h	2002-09-25 02:08:05.000000000 +1000
@@ -56,8 +56,6 @@ struct exception_table_entry
 	unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
 extern void sort_exception_table(void);
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/include/asm-sparc64/uaccess.h .17925-linux-2.5.38.updated/include/asm-sparc64/uaccess.h
--- .17925-linux-2.5.38/include/asm-sparc64/uaccess.h	2002-05-24 15:20:33.000000000 +1000
+++ .17925-linux-2.5.38.updated/include/asm-sparc64/uaccess.h	2002-09-25 02:08:05.000000000 +1000
@@ -84,8 +84,9 @@ struct exception_table_entry
         unsigned insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long, unsigned long *);
+/* Special exable search, which handles ranges.  Returns fixup */
+extern unsigned long search_exception_tables_sparc(unsigned long addr,
+						   unsigned long *g2);
 
 extern void __ret_efault(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/include/linux/module.h .17925-linux-2.5.38.updated/include/linux/module.h
--- .17925-linux-2.5.38/include/linux/module.h	2002-09-25 02:07:40.000000000 +1000
+++ .17925-linux-2.5.38.updated/include/linux/module.h	2002-09-25 02:10:11.000000000 +1000
@@ -25,6 +25,12 @@
 #define MODULE_DEVICE_TABLE(type,name)
 #define MODULE_PARM_DESC(var,desc)
 
+/* Archs provide a method of finding the correct exception table. */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value);
+
 #ifdef MODULE
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */
@@ -119,6 +125,9 @@ struct kernel_symbol_group
 	const struct kernel_symbol *syms;
 };
 
+/* Given an address, look for it in the exception tables */
+const struct exception_table_entry *search_exception_tables(unsigned long add);
+
 struct exception_table
 {
 	struct list_head list;
@@ -287,6 +296,19 @@ static inline int module_put(struct modu
 #define EXPORT_SYMBOL(sym) 0
 #define EXPORT_SYMBOL_GPL(sym) 0
 
+extern const struct exception_table_entry __start___ex_table[];
+extern const struct exception_table_entry __stop___ex_table[];
+
+/* Given an address, look for it in the exception tables. */
+static inline const struct exception_table_entry *
+search_exception_tables(unsigned long add)
+{
+	/* There is only one, and it doesn't change */
+	return search_extable(__start___ex_table,
+			      __stop___ex_table - 1,
+			      add);
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ((typeof(&x))(0))
 
@@ -296,10 +318,6 @@ static inline int module_put(struct modu
 #define __unsafe(mod)
 #endif /* CONFIG_MODULES */
 
-/* For archs to search exception tables */
-extern struct list_head extables;
-extern spinlock_t modlist_lock;
-
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
 #define __MOD_INC_USE_COUNT(mod) \
 	do { try_module_get(mod); __unsafe(mod); } while(0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17925-linux-2.5.38/kernel/module.c .17925-linux-2.5.38.updated/kernel/module.c
--- .17925-linux-2.5.38/kernel/module.c	2002-09-25 02:07:40.000000000 +1000
+++ .17925-linux-2.5.38.updated/kernel/module.c	2002-09-25 02:11:50.000000000 +1000
@@ -44,10 +44,10 @@ extern const struct kernel_symbol __star
 extern const struct kernel_symbol __stop_gpl_ksymtab[];
 
 /* Protects extables and symbol tables */
-spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t module_lock = SPIN_LOCK_UNLOCKED;
 
 /* The exception and symbol tables: start with kernel only. */
-LIST_HEAD(extables);
+static LIST_HEAD(extables);
 static LIST_HEAD(symbols);
 
 static struct exception_table kernel_extable;
@@ -240,10 +240,10 @@ sys_delete_module(const char *name_user,
 	}
 
 	/* Remove symbols so module count can't increase from symbol_get() */
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	list_del_init(&mod->symbols.list);
 	list_del_init(&mod->gpl_symbols.list);
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 
 	/* Mark it as non-live. */
 	mod->live = 0;
@@ -292,10 +292,10 @@ sys_delete_module(const char *name_user,
  reanimate:
 	mod->live = 1;
 	try_module_get(mod); /* Can't fail */
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	list_add(&mod->symbols.list, &kernel_symbols.list);
 	list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 	ret = -EWOULDBLOCK;
 	goto out;
 }
@@ -339,11 +339,11 @@ void __symbol_put(const char *symbol)
 	struct kernel_symbol_group *ksg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	spin_lock_irqsave(&module_lock, flags);
 	if (!__find_symbol(symbol, &ksg, 1))
 		BUG();
 	module_put(ksg->owner);
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	spin_unlock_irqrestore(&module_lock, flags);
 }
 EXPORT_SYMBOL(__symbol_put);
 
@@ -568,14 +568,14 @@ unsigned long find_symbol_internal(Elf_S
 		return ret;
 	}
 	/* Look in other modules... */
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	ret = __find_symbol(name, ksg, module_is_gpl(mod));
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
 		if (!use_module(mod, (*ksg)->owner))
 			ret = 0;
 	}
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 	return ret;
 }
 
@@ -588,11 +588,11 @@ static void free_module(struct module *m
 
 	/* Delete from various lists */
 	list_del(&mod->list);
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	list_del(&mod->symbols.list);
 	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 
 	/* Module unload stuff */
 	module_unload_free(mod);
@@ -606,11 +606,11 @@ void *__symbol_get(const char *symbol)
 	struct kernel_symbol_group *ksg;
 	unsigned long value, flags;
 
-	spin_lock_irqsave(&modlist_lock, flags);
+	spin_lock_irqsave(&module_lock, flags);
 	value = __find_symbol(symbol, &ksg, 1);
 	if (value && !try_module_get(ksg->owner))
 		value = 0;
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	spin_unlock_irqrestore(&module_lock, flags);
 
 	return (void *)value;
 }
@@ -1147,9 +1147,9 @@ sys_init_module(void *umod,
 			   (unsigned long)mod->module_core + mod->core_size);
 
 	/* Now sew it into exception list (just in case...). */
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	list_add(&mod->extable.list, &extables);
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 
 	/* Start the module */
 	ret = mod->init();
@@ -1167,10 +1167,10 @@ sys_init_module(void *umod,
 	}
 
 	/* Now it's a first class citizen! */
-	spin_lock_irq(&modlist_lock);
+	spin_lock_irq(&module_lock);
 	list_add(&mod->symbols.list, &kernel_symbols.list);
 	list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
-	spin_unlock_irq(&modlist_lock);
+	spin_unlock_irq(&module_lock);
 	list_add(&mod->list, &modules);
 
 	module_free(mod, mod->module_init);
@@ -1182,6 +1182,33 @@ sys_init_module(void *umod,
 	return 0;
 }
 
+/* Given an address, look for it in the exception tables.  If we used
+   a single linked list, we could get rid of the lock here if
+   !CONFIG_MODULE_UNLOAD, but who cares enough? */
+const struct exception_table_entry *search_exception_tables(unsigned long addr)
+{
+	struct list_head *i;
+	unsigned long flags;
+	const struct exception_table_entry *found = NULL;
+
+	spin_lock_irqsave(&module_lock, flags);
+	list_for_each(i, &extables) {
+		struct exception_table *t
+			= list_entry(i, struct exception_table, list);
+		if (t->num_entries > 0) {
+			found = search_extable(t->entry,
+					       t->entry + t->num_entries-1,
+					       addr);
+			if (found) break;
+		}
+	}
+	spin_unlock_irqrestore(&module_lock, flags);
+
+	/* Now, if we found one, we are running inside it now, hence
+           we cannot unload the module, hence no refcnt needed. */
+	return found;
+}
+
 /* Called by the /proc file system to return a current list of
    modules.  Al Viro came up with this interface as an "improvement".
    God save us from any more such interface improvements. */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
