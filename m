Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTAEX7d>; Sun, 5 Jan 2003 18:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbTAEX7c>; Sun, 5 Jan 2003 18:59:32 -0500
Received: from dp.samba.org ([66.70.73.150]:64986 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265480AbTAEX7R>;
	Sun, 5 Jan 2003 18:59:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, davem@redhat.com
Subject: [PATCH] Exception table cleanup
Date: Mon, 06 Jan 2003 11:07:29 +1100
Message-Id: <20030106000753.062ED2C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit.  Linus, please apply (requires LICENSE patch).

DaveM OKed it.  Other archs should be trivial, and the arch
maintainers probably want to know about this change anyway.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: extable cleanup
Author: Rusty Russell
Status: Tested on 2.5.54
Depends: Module/module-license.patch.gz

D: This patch combines the common exception table searching
D: functionality for various architectures, to avoid unneccessary (and
D: currently buggy) duplication, and so that the exception table list
D: and lock can be kept private to module.c.
D:
D: The archs provide "struct exception_table" and "search_extable":
D: the generic infrastructure drives the rest.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/kernel/extable.c .11490-2.5-bk-extable/kernel/extable.c
--- .11490-2.5-bk-extable.pre/kernel/extable.c	2003-01-03 18:55:26.000000000 +1100
+++ .11490-2.5-bk-extable/kernel/extable.c	2003-01-03 18:55:28.000000000 +1100
@@ -16,45 +16,17 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/module.h>
-#include <linux/init.h>
-
-#include <asm/semaphore.h>
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___gpl_ksymtab[];
-extern const struct kernel_symbol __stop___gpl_ksymtab[];
 
-/* Protects extables and symbol tables */
-spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
-
-/* The exception and symbol tables: start with kernel only. */
-LIST_HEAD(extables);
-LIST_HEAD(symbols);
-
-static struct exception_table kernel_extable;
-static struct kernel_symbol_group kernel_symbols;
-static struct kernel_symbol_group kernel_gpl_symbols;
-
-void __init extable_init(void)
+/* Given an address, look for it in the exception tables. */
+const struct exception_table_entry *search_exception_tables(unsigned long addr)
 {
-	/* Add kernel symbols to symbol table */
-	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
-	kernel_symbols.syms = __start___ksymtab;
-	kernel_symbols.gplonly = 0;
-	list_add(&kernel_symbols.list, &symbols);
-	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
-				       - __start___gpl_ksymtab);
-	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
-	kernel_gpl_symbols.gplonly = 1;
-	list_add(&kernel_gpl_symbols.list, &symbols);
+	const struct exception_table_entry *e;
 
-	/* Add kernel exception table to exception tables */
-	kernel_extable.num_entries = (__stop___ex_table -__start___ex_table);
-	kernel_extable.entry = __start___ex_table;
-	list_add(&kernel_extable.list, &extables);
+	e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
+	if (!e)
+		e = search_module_extables(addr);
+	return e;
 }
-
-
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/kernel/module.c .11490-2.5-bk-extable/kernel/module.c
--- .11490-2.5-bk-extable.pre/kernel/module.c	2003-01-03 18:55:26.000000000 +1100
+++ .11490-2.5-bk-extable/kernel/module.c	2003-01-03 18:55:28.000000000 +1100
@@ -51,9 +51,14 @@
 #define symbol_is(literal, string)				\
 	(strcmp(MODULE_SYMBOL_PREFIX literal, (string)) == 0)
 
+/* Protects extables and symbols lists */
+static spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
+
 /* List of modules, protected by module_mutex */
 static DECLARE_MUTEX(module_mutex);
-LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
+LIST_HEAD(modules);  /* FIXME: Accessed w/o lock on oops by some archs */
+static LIST_HEAD(symbols);
+static LIST_HEAD(extables);
 
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
@@ -1425,6 +1430,55 @@ struct seq_operations modules_op = {
 	.show	= m_show
 };
 
+/* Given an address, look for it in the module exception tables. */
+const struct exception_table_entry *search_module_extables(unsigned long addr)
+{
+	unsigned long flags;
+	const struct exception_table_entry *e = NULL;
+	struct exception_table *i;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	list_for_each_entry(i, &extables, list) {
+		if (i->num_entries == 0)
+			continue;
+				
+		e = search_extable(i->entry, i->entry+i->num_entries-1, addr);
+		if (e)
+			break;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+
+	/* Now, if we found one, we are running inside it now, hence
+           we cannot unload the module, hence no refcnt needed. */
+	return e;
+}
+
+/* Provided by the linker */
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___gpl_ksymtab[];
+extern const struct kernel_symbol __stop___gpl_ksymtab[];
+
+static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
+
+static int __init symbols_init(void)
+{
+	/* Add kernel symbols to symbol table */
+	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
+	kernel_symbols.syms = __start___ksymtab;
+	kernel_symbols.gplonly = 0;
+	list_add(&kernel_symbols.list, &symbols);
+	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
+				       - __start___gpl_ksymtab);
+	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
+	kernel_gpl_symbols.gplonly = 1;
+	list_add(&kernel_gpl_symbols.list, &symbols);
+
+	return 0;
+}
+
+__initcall(symbols_init);
+
 /* Obsolete lvalue for broken code which asks about usage */
 int module_dummy_usage = 1;
 EXPORT_SYMBOL(module_dummy_usage);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/include/linux/module.h .11490-2.5-bk-extable/include/linux/module.h
--- .11490-2.5-bk-extable.pre/include/linux/module.h	2003-01-03 18:55:26.000000000 +1100
+++ .11490-2.5-bk-extable/include/linux/module.h	2003-01-03 18:55:28.000000000 +1100
@@ -43,6 +43,12 @@ struct kernel_symbol
 extern int init_module(void);
 extern void cleanup_module(void);
 
+/* Archs provide a method of finding the correct exception table. */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value);
+
 #ifdef MODULE
 
 /* For replacement modutils, use an alias not a pointer. */
@@ -111,6 +117,9 @@ struct kernel_symbol_group
 	const struct kernel_symbol *syms;
 };
 
+/* Given an address, look for it in the exception tables */
+const struct exception_table_entry *search_exception_tables(unsigned long add);
+
 struct exception_table
 {
 	struct list_head list;
@@ -300,11 +309,21 @@ const char *module_address_lookup(unsign
 				  unsigned long *offset,
 				  char **modname);
 
+/* For extable.c to search modules' exception tables. */
+const struct exception_table_entry *search_module_extables(unsigned long addr);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
 #define EXPORT_SYMBOL_NOVERS(sym)
 
+/* Given an address, look for it in the exception tables. */
+static inline const struct exception_table_entry *
+search_module_extables(unsigned long addr)
+{
+	return NULL;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) (&(x))
 #define symbol_put(x) do { } while(0)
@@ -344,10 +363,6 @@ __attribute__((section(".gnu.linkonce.th
 #endif /* KBUILD_MODNAME */
 #endif /* MODULE */
 
-/* For archs to search exception tables */
-extern struct list_head extables;
-extern spinlock_t modlist_lock;
-
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/i386/kernel/traps.c .11490-2.5-bk-extable/arch/i386/kernel/traps.c
--- .11490-2.5-bk-extable.pre/arch/i386/kernel/traps.c	2003-01-02 14:47:57.000000000 +1100
+++ .11490-2.5-bk-extable/arch/i386/kernel/traps.c	2003-01-03 18:55:27.000000000 +1100
@@ -338,7 +338,7 @@ static inline void do_trap(int trapnr, i
 	}
 
 	kernel_trap: {
-		unsigned long fixup;
+		const struct exception_table_entry *fixup;
 #ifdef CONFIG_PNPBIOS
 		if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
 		{
@@ -354,9 +354,9 @@ static inline void do_trap(int trapnr, i
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
@@ -435,10 +435,10 @@ gp_in_vm86:
 
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/i386/mm/extable.c .11490-2.5-bk-extable/arch/i386/mm/extable.c
--- .11490-2.5-bk-extable.pre/arch/i386/mm/extable.c	2003-01-02 12:35:07.000000000 +1100
+++ .11490-2.5-bk-extable/arch/i386/mm/extable.c	2003-01-03 18:55:27.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/i386/mm/fault.c .11490-2.5-bk-extable/arch/i386/mm/fault.c
--- .11490-2.5-bk-extable.pre/arch/i386/mm/fault.c	2003-01-02 12:46:12.000000000 +1100
+++ .11490-2.5-bk-extable/arch/i386/mm/fault.c	2003-01-03 18:55:27.000000000 +1100
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -154,7 +155,7 @@ asmlinkage void do_page_fault(struct pt_
 	struct vm_area_struct * vma;
 	unsigned long address;
 	unsigned long page;
-	unsigned long fixup;
+	const struct exception_table_entry *fixup;
 	int write;
 	siginfo_t info;
 
@@ -310,8 +311,8 @@ bad_area:
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	if ((fixup = search_exception_table(regs->eip)) != 0) {
-		regs->eip = fixup;
+	if ((fixup = search_exception_tables(regs->eip)) != NULL) {
+		regs->eip = fixup->fixup;
 		return;
 	}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/ppc/kernel/traps.c .11490-2.5-bk-extable/arch/ppc/kernel/traps.c
--- .11490-2.5-bk-extable.pre/arch/ppc/kernel/traps.c	2003-01-02 12:27:43.000000000 +1100
+++ .11490-2.5-bk-extable/arch/ppc/kernel/traps.c	2003-01-03 18:55:27.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/ppc/mm/extable.c .11490-2.5-bk-extable/arch/ppc/mm/extable.c
--- .11490-2.5-bk-extable.pre/arch/ppc/mm/extable.c	2003-01-02 12:35:59.000000000 +1100
+++ .11490-2.5-bk-extable/arch/ppc/mm/extable.c	2003-01-03 18:55:27.000000000 +1100
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
@@ -58,41 +60,11 @@ search_one_table(const struct exception_
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
-	unsigned long ret = 0;
-
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-#else
-	unsigned long flags;
-	struct list_head *i;
-
-	/* The kernel is the last "module" -- no need to treat it special. */
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
-#endif
-
-	return ret;
+	return NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/ppc/mm/fault.c .11490-2.5-bk-extable/arch/ppc/mm/fault.c
--- .11490-2.5-bk-extable.pre/arch/ppc/mm/fault.c	2003-01-02 12:27:43.000000000 +1100
+++ .11490-2.5-bk-extable/arch/ppc/mm/fault.c	2003-01-03 18:55:27.000000000 +1100
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/sparc64/kernel/traps.c .11490-2.5-bk-extable/arch/sparc64/kernel/traps.c
--- .11490-2.5-bk-extable.pre/arch/sparc64/kernel/traps.c	2003-01-02 12:34:03.000000000 +1100
+++ .11490-2.5-bk-extable/arch/sparc64/kernel/traps.c	2003-01-03 18:55:27.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/sparc64/kernel/unaligned.c .11490-2.5-bk-extable/arch/sparc64/kernel/unaligned.c
--- .11490-2.5-bk-extable.pre/arch/sparc64/kernel/unaligned.c	2003-01-02 12:30:39.000000000 +1100
+++ .11490-2.5-bk-extable/arch/sparc64/kernel/unaligned.c	2003-01-03 18:55:27.000000000 +1100
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <asm/asi.h>
 #include <asm/ptrace.h>
 #include <asm/pstate.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/sparc64/mm/extable.c .11490-2.5-bk-extable/arch/sparc64/mm/extable.c
--- .11490-2.5-bk-extable.pre/arch/sparc64/mm/extable.c	2003-01-02 12:35:08.000000000 +1100
+++ .11490-2.5-bk-extable/arch/sparc64/mm/extable.c	2003-01-03 18:55:27.000000000 +1100
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
@@ -46,47 +47,29 @@ search_one_table(const struct exception_
 		if (walk->fixup)
 			continue;
 
-		if (walk[0].insn <= value &&
-		    walk[1].insn > value) {
-			*g2 = (value - walk[0].insn) / 4;
-			return walk[1].fixup;
-		}
+		if (walk[0].insn <= value && walk[1].insn > value)
+			return walk;
+
 		walk++;
 	}
 
-        return 0;
+        return NULL;
 }
 
-extern spinlock_t modlist_lock;
-
-unsigned long
-search_exception_table(unsigned long addr, unsigned long *g2)
+/* Special extable search, which handles ranges.  Returns fixup */
+unsigned long search_extables_range(unsigned long addr, unsigned long *g2)
 {
-	unsigned long ret = 0;
+	const struct exception_table_entry *entry;
 
-#ifndef CONFIG_MODULES
-	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table,
-			       __stop___ex_table-1, addr, g2);
-	return ret;
-#else
-	unsigned long flags;
-	struct list_head *i;
+	entry = search_exception_tables(addr);
+	if (!entry)
+		return 0;
 
-	/* The kernel is the last "module" -- no need to treat it special.  */
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each(i, &extables) {
-		struct exception_table *ex =
-			list_entry(i, struct exception_table, list);
-		if (ex->num_entries == 0)
-			continue;
-		ret = search_one_table(ex->entry,
-				       ex->entry + ex->num_entries - 1,
-				       addr, g2);
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/arch/sparc64/mm/fault.c .11490-2.5-bk-extable/arch/sparc64/mm/fault.c
--- .11490-2.5-bk-extable.pre/arch/sparc64/mm/fault.c	2003-01-02 12:30:39.000000000 +1100
+++ .11490-2.5-bk-extable/arch/sparc64/mm/fault.c	2003-01-03 18:55:27.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/mman.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -285,7 +286,7 @@ static void do_kernel_fault(struct pt_re
 	
 		/* Look in asi.h: All _S asis have LS bit set */
 		if ((asi & 0x1) &&
-		    (fixup = search_exception_table (regs->tpc, &g2))) {
+		    (fizup = search_extables_range(regs->tpc, &g2))) {
 			regs->tpc = fixup;
 			regs->tnpc = regs->tpc + 4;
 			regs->u_regs[UREG_G2] = g2;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/include/asm-i386/uaccess.h .11490-2.5-bk-extable/include/asm-i386/uaccess.h
--- .11490-2.5-bk-extable.pre/include/asm-i386/uaccess.h	2003-01-02 14:48:00.000000000 +1100
+++ .11490-2.5-bk-extable/include/asm-i386/uaccess.h	2003-01-03 18:55:27.000000000 +1100
@@ -92,10 +92,6 @@ struct exception_table_entry
 	unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
-
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/include/asm-ppc/uaccess.h .11490-2.5-bk-extable/include/asm-ppc/uaccess.h
--- .11490-2.5-bk-extable.pre/include/asm-ppc/uaccess.h	2003-01-02 12:27:50.000000000 +1100
+++ .11490-2.5-bk-extable/include/asm-ppc/uaccess.h	2003-01-03 18:55:27.000000000 +1100
@@ -56,8 +56,6 @@ struct exception_table_entry
 	unsigned long insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long);
 extern void sort_exception_table(void);
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/include/asm-sparc64/uaccess.h .11490-2.5-bk-extable/include/asm-sparc64/uaccess.h
--- .11490-2.5-bk-extable.pre/include/asm-sparc64/uaccess.h	2003-01-02 12:29:33.000000000 +1100
+++ .11490-2.5-bk-extable/include/asm-sparc64/uaccess.h	2003-01-03 18:55:27.000000000 +1100
@@ -84,8 +84,8 @@ struct exception_table_entry
         unsigned insn, fixup;
 };
 
-/* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_exception_table(unsigned long, unsigned long *);
+/* Special exable search, which handles ranges.  Returns fixup */
+unsigned long search_extables_range(unsigned long addr, unsigned long *g2);
 
 extern void __ret_efault(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11490-2.5-bk-extable.pre/init/main.c .11490-2.5-bk-extable/init/main.c
--- .11490-2.5-bk-extable.pre/init/main.c	2003-01-02 14:48:01.000000000 +1100
+++ .11490-2.5-bk-extable/init/main.c	2003-01-03 18:55:28.000000000 +1100
@@ -61,7 +61,6 @@ extern void init_IRQ(void);
 extern void init_modules(void);
 extern void sock_init(void);
 extern void fork_init(unsigned long);
-extern void extable_init(void);
 extern void mca_init(void);
 extern void sbus_init(void);
 extern void sysctl_init(void);
@@ -391,7 +390,6 @@ asmlinkage void __init start_kernel(void
 		   &__stop___param - &__start___param,
 		   &unknown_bootoption);
 	trap_init();
-	extable_init();
 	rcu_init();
 	init_IRQ();
 	sched_init();
