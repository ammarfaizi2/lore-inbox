Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbTAFKbG>; Mon, 6 Jan 2003 05:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbTAFKbG>; Mon, 6 Jan 2003 05:31:06 -0500
Received: from dp.samba.org ([66.70.73.150]:10983 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266555AbTAFKa4>;
	Mon, 6 Jan 2003 05:30:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mkp@mkp.net,
       willy@debian.org, Jeff Dike <jdike@karaya.com>, ak@suse.de,
       srf@canb.auug.org.au
Subject: [PATCH] Remove mod_bound macro and unify kernel_text_address().
Date: Mon, 06 Jan 2003 21:37:35 +1100
Message-Id: <20030106103933.677BF2C0A0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Various archs (i386, m68k, s390, s390x, m68k, parisc, um, x86_64)
implement kernel_text_address.  Put this in kernel/extable.c, and the
module iteration inside module.c.

Other than cleanliness, this finally allows the module list and lock
to be static to kernel/module.c (you didn't think I actually cared
about those archs did you?)

It also drops the module->init_size to zero when it's discarded, so
bounds checking is simplified (and the /proc/modules size statistic
will be more accurate, too).

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: module_bound removal patch
Author: Rusty Russell
Status: Tested on 2.5.54
Depends: Module/extable.patch.gz

D: This removes the mod_bound macro, and its usage in determining
D: whether an address is in the kernel (on some archs).  It is
D: replaced with a general kernel_text_address() function, and finally
D: makes the modules list static to module.c.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/i386/kernel/traps.c working-2.5-bk-module-bound-removal/arch/i386/kernel/traps.c
--- working-2.5-bk-test/arch/i386/kernel/traps.c	Mon Jan  6 16:39:20 2003
+++ working-2.5-bk-module-bound-removal/arch/i386/kernel/traps.c	Mon Jan  6 16:56:32 2003
@@ -87,50 +87,6 @@ asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
 
-
-/*
- * If the address is either in the .text section of the
- * kernel, or in the vmalloc'ed module regions, it *may* 
- * be the address of a calling routine
- */
-
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	int retval = 0;
-	struct module *mod;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-	list_for_each_entry(mod, &modules, list) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound((void *)addr, 0, mod)) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	int i;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/m68k/kernel/traps.c working-2.5-bk-module-bound-removal/arch/m68k/kernel/traps.c
--- working-2.5-bk-test/arch/m68k/kernel/traps.c	Thu Jan  2 14:47:57 2003
+++ working-2.5-bk-module-bound-removal/arch/m68k/kernel/traps.c	Mon Jan  6 16:56:32 2003
@@ -821,42 +821,6 @@ asmlinkage void buserr_c(struct frame *f
 
 static int kstack_depth_to_print = 48;
 
-extern char _stext, _etext;
-
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	struct module *mod;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-	list_for_each_entry(mod, &modules, list) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound((void *)addr, 0, mod))
-			return 1;
-	}
-
-	return 0;
-}
-
-#else // !CONFIG_MODULES
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif // !CONFIG_MODULES
-
 void show_trace(unsigned long *stack)
 {
 	unsigned long *endstack;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/parisc/kernel/traps.c working-2.5-bk-module-bound-removal/arch/parisc/kernel/traps.c
--- working-2.5-bk-test/arch/parisc/kernel/traps.c	Thu Jan  2 12:32:35 2003
+++ working-2.5-bk-module-bound-removal/arch/parisc/kernel/traps.c	Mon Jan  6 16:58:50 2003
@@ -123,31 +123,6 @@ void dump_stack(void)
 
 
 static int kstack_depth_to_print = 48;
-extern struct module kernel_module;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-#ifdef CONFIG_MODULES
-	struct module *mod;
-#endif
-	extern char _stext, _etext;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-#ifdef CONFIG_MODULES
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod))
-			return 1;
-	}
-#endif
-
-	return 0;
-}
 
 void show_stack(unsigned long *sp)
 {
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/s390/kernel/traps.c working-2.5-bk-module-bound-removal/arch/s390/kernel/traps.c
--- working-2.5-bk-test/arch/s390/kernel/traps.c	Thu Jan  2 12:35:59 2003
+++ working-2.5-bk-module-bound-removal/arch/s390/kernel/traps.c	Mon Jan  6 16:56:32 2003
@@ -63,50 +63,6 @@ static ext_int_info_t ext_int_pfault;
 
 static int kstack_depth_to_print = 12;
 
-/*
- * If the address is either in the .text section of the
- * kernel, or in the vmalloc'ed module regions, it *may* 
- * be the address of a calling routine
- */
-extern char _stext, _etext;
-
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	int retval = 0;
-	struct module *mod;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-	list_for_each_entry(mod, &modules, list) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound((void*)addr, 0, mod)) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/s390x/kernel/traps.c working-2.5-bk-module-bound-removal/arch/s390x/kernel/traps.c
--- working-2.5-bk-test/arch/s390x/kernel/traps.c	Thu Jan  2 12:35:59 2003
+++ working-2.5-bk-module-bound-removal/arch/s390x/kernel/traps.c	Mon Jan  6 16:56:32 2003
@@ -65,50 +65,6 @@ static ext_int_info_t ext_int_pfault;
 
 static int kstack_depth_to_print = 20;
 
-/*
- * If the address is either in the .text section of the
- * kernel, or in the vmalloc'ed module regions, it *may* 
- * be the address of a calling routine
- */
-extern char _stext, _etext;
-
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	int retval = 0;
-	struct module *mod;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-	list_for_each_entry(mod, &modules, list) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound((void*)addr, 0, mod)) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/um/kernel/sysrq.c working-2.5-bk-module-bound-removal/arch/um/kernel/sysrq.c
--- working-2.5-bk-test/arch/um/kernel/sysrq.c	Thu Jan  2 14:47:58 2003
+++ working-2.5-bk-module-bound-removal/arch/um/kernel/sysrq.c	Mon Jan  6 16:56:32 2003
@@ -11,49 +11,6 @@
 #include "sysrq.h"
 #include "user_util.h"
 
- /*
-  * If the address is either in the .text section of the
-  * kernel, or in the vmalloc'ed module regions, it *may* 
-  * be the address of a calling routine
-  */
- 
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	int retval = 0;
-	struct module *mod;
-
-	if (addr >= (unsigned long) &_stext &&
-	    addr <= (unsigned long) &_etext)
-		return 1;
-
-	list_for_each_entry(mod, &modules, list) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound((void *) addr, 0, mod)) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-	return (addr >= (unsigned long) &_stext &&
-		addr <= (unsigned long) &_etext);
-}
-
-#endif
-
 void show_trace(unsigned long * stack)
 {
         int i;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/arch/x86_64/kernel/traps.c working-2.5-bk-module-bound-removal/arch/x86_64/kernel/traps.c
--- working-2.5-bk-test/arch/x86_64/kernel/traps.c	Mon Jan  6 16:39:24 2003
+++ working-2.5-bk-module-bound-removal/arch/x86_64/kernel/traps.c	Mon Jan  6 16:56:32 2003
@@ -104,44 +104,6 @@ int printk_address(unsigned long address
 } 
 #endif
 
-
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
-static inline int kernel_text_address(unsigned long addr)
-{
-   int retval = 0;
-   struct module *mod;
-
-   if (addr >= (unsigned long) &_stext &&
-       addr <= (unsigned long) &_etext)
-       return 1;
-
-   list_for_each_entry(mod, &modules, list) { 	
-       /* mod_bound tests for addr being inside the vmalloc'ed
-        * module area. Of course it'd be better to test only
-        * for the .text subset... */
-       if (mod_bound((void *)addr, 0, mod)) {
-           retval = 1;
-           break;
-       }
-   }
-
-   return retval;
-}
-
-#else
-
-static inline int kernel_text_address(unsigned long addr)
-{
-   return (addr >= (unsigned long) &_stext &&
-       addr <= (unsigned long) &_etext);
-}
-
-#endif
-
 static inline unsigned long *in_exception_stack(int cpu, unsigned long stack) 
 { 
 	int k;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/include/linux/kernel.h working-2.5-bk-module-bound-removal/include/linux/kernel.h
--- working-2.5-bk-test/include/linux/kernel.h	Mon Jan  6 16:39:32 2003
+++ working-2.5-bk-module-bound-removal/include/linux/kernel.h	Mon Jan  6 16:56:32 2003
@@ -84,6 +84,7 @@ extern unsigned long long memparse(char 
 extern void dev_probe_lock(void);
 extern void dev_probe_unlock(void);
 
+extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
 asmlinkage int printk(const char * fmt, ...)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/include/linux/module.h working-2.5-bk-module-bound-removal/include/linux/module.h
--- working-2.5-bk-test/include/linux/module.h	Mon Jan  6 16:39:32 2003
+++ working-2.5-bk-module-bound-removal/include/linux/module.h	Mon Jan  6 16:56:32 2003
@@ -234,6 +234,9 @@ static inline int module_is_live(struct 
 	return mod->state != MODULE_STATE_GOING;
 }
 
+/* Is this address in a module? */
+int module_text_address(unsigned long addr);
+
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
@@ -324,6 +327,12 @@ search_module_extables(unsigned long add
 	return NULL;
 }
 
+/* Is this address in a module? */
+static int module_text_address(unsigned long addr)
+{
+	return 0;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) (&(x))
 #define symbol_put(x) do { } while(0)
@@ -420,14 +429,6 @@ extern int module_dummy_usage;
 #define GET_USE_COUNT(module) (module_dummy_usage)
 #define MOD_IN_USE 0
 #define __MODULE_STRING(x) __stringify(x)
-#define __mod_between(a_start, a_len, b_start, b_len)		\
-(((a_start) >= (b_start) && (a_start) <= (b_start)+(b_len))	\
- || ((a_start)+(a_len) >= (b_start)				\
-     && (a_start)+(a_len) <= (b_start)+(b_len)))
-#define mod_bound(p, n, m)					\
-(((m)->module_init						\
-  && __mod_between((p),(n),(m)->module_init,(m)->init_size))	\
- || __mod_between((p),(n),(m)->module_core,(m)->core_size))
 
 /*
  * The exception and symbol tables, and the lock
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/kernel/extable.c working-2.5-bk-module-bound-removal/kernel/extable.c
--- working-2.5-bk-test/kernel/extable.c	Mon Jan  6 16:39:33 2003
+++ working-2.5-bk-module-bound-removal/kernel/extable.c	Mon Jan  6 16:56:32 2003
@@ -19,6 +19,7 @@
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
+extern char _stext[], _etext[];
 
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
@@ -29,4 +30,13 @@ const struct exception_table_entry *sear
 	if (!e)
 		e = search_module_extables(addr);
 	return e;
+}
+
+int kernel_text_address(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext &&
+	    addr <= (unsigned long)_etext)
+		return 1;
+
+	return module_text_address(addr);
 }
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal working-2.5-bk-test/kernel/module.c working-2.5-bk-module-bound-removal/kernel/module.c
--- working-2.5-bk-test/kernel/module.c	Mon Jan  6 21:04:48 2003
+++ working-2.5-bk-module-bound-removal/kernel/module.c	Mon Jan  6 17:42:54 2003
@@ -54,9 +54,9 @@
 /* Protects extables and symbols lists */
 static spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
 
-/* List of modules, protected by module_mutex */
+/* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
-LIST_HEAD(modules);  /* FIXME: Accessed w/o lock on oops by some archs */
+static LIST_HEAD(modules);
 static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
@@ -754,8 +754,8 @@ unsigned long find_symbol_internal(Elf_S
 static void free_module(struct module *mod)
 {
 	/* Delete from various lists */
-	list_del(&mod->list);
 	spin_lock_irq(&modlist_lock);
+	list_del(&mod->list);
 	list_del(&mod->symbols.list);
 	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
@@ -1290,7 +1293,7 @@ sys_init_module(void *umod,
 	list_add(&mod->extable.list, &extables);
 	list_add_tail(&mod->symbols.list, &symbols);
 	list_add_tail(&mod->gpl_symbols.list, &symbols);
-	spin_unlock_irq(&modlist_lock);
 	list_add(&mod->list, &modules);
+	spin_unlock_irq(&modlist_lock);
 
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
@@ -1321,28 +1321,17 @@ sys_init_module(void *umod,
 	mod->state = MODULE_STATE_LIVE;
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
+	mod->init_size = 0;
 
 	return 0;
 }
 
-#ifdef CONFIG_KALLSYMS
-static inline int inside_init(struct module *mod, unsigned long addr)
-{
-	if (mod->module_init
-	    && (unsigned long)mod->module_init <= addr
-	    && (unsigned long)mod->module_init + mod->init_size > addr)
-		return 1;
-	return 0;
-}
-
-static inline int inside_core(struct module *mod, unsigned long addr)
+static inline int within(unsigned long addr, void *start, unsigned long size)
 {
-	if ((unsigned long)mod->module_core <= addr
-	    && (unsigned long)mod->module_core + mod->core_size > addr)
-		return 1;
-	return 0;
+	return ((void *)addr >= start && (void *)addr < start + size);
 }
 
+#ifdef CONFIG_KALLSYMS
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,
 			       unsigned long *size,
@@ -1352,7 +1341,7 @@ static const char *get_ksymbol(struct mo
 	unsigned long nextval;
 
 	/* At worse, next value is at end of module */
-	if (inside_core(mod, addr))
+	if (within(addr, mod->module_init, mod->init_size))
 		nextval = (unsigned long)mod->module_core+mod->core_size;
 	else 
 		nextval = (unsigned long)mod->module_init+mod->init_size;
@@ -1390,7 +1379,8 @@ const char *module_address_lookup(unsign
 	struct module *mod;
 
 	list_for_each_entry(mod, &modules, list) {
-		if (inside_core(mod, addr) || inside_init(mod, addr)) {
+		if (within(addr, mod->module_init, mod->init_size)
+		    || within(addr, mod->module_core, mod->core_size)) {
 			*modname = mod->name;
 			return get_ksymbol(mod, addr, size, offset);
 		}
@@ -1472,6 +1462,18 @@ const struct exception_table_entry *sear
 	/* Now, if we found one, we are running inside it now, hence
            we cannot unload the module, hence no refcnt needed. */
 	return e;
+}
+
+/* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
+int module_text_address(unsigned long addr)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list)
+		if (within(addr, mod->module_init, mod->init_size)
+		    || within(addr, mod->module_core, mod->core_size))
+			return 1;
+	return 0;
 }
 
 /* Provided by the linker */
