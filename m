Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbSIYDRp>; Tue, 24 Sep 2002 23:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261904AbSIYDRD>; Tue, 24 Sep 2002 23:17:03 -0400
Received: from dp.samba.org ([66.70.73.150]:42112 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261885AbSIYDQq>;
	Tue, 24 Sep 2002 23:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 19/20: module_bound removal
Date: Wed, 25 Sep 2002 13:19:32 +1000
Message-Id: <20020925032201.8C18A2C0D5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: module_bound removal patch
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Module/extable.patch.gz

D: This removes the mod_bound macro, and its usage in determining
D: whether an address is in the kernel (on some archs).  It is
D: replaced with a module_is_address() function which does the right
D: locking, and finally makes the modules list static to module.c.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/i386/kernel/traps.c .19547-linux-2.5.38.updated/arch/i386/kernel/traps.c
--- .19547-linux-2.5.38/arch/i386/kernel/traps.c	2002-09-25 10:43:21.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/i386/kernel/traps.c	2002-09-25 10:43:44.000000000 +1000
@@ -92,43 +92,15 @@ static int kstack_depth_to_print = 24;
  * be the address of a calling routine
  */
 
-#ifdef CONFIG_MODULES
-
-/* FIXME: Accessed without a lock --RR */
-extern struct list_head modules;
-
 static inline int kernel_text_address(unsigned long addr)
 {
-	int retval = 0;
-	struct module *mod;
-
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
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
+	return module_is_address(addr);
 }
 
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	int i;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/m68k/kernel/traps.c .19547-linux-2.5.38.updated/arch/m68k/kernel/traps.c
--- .19547-linux-2.5.38/arch/m68k/kernel/traps.c	2002-07-25 10:13:02.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/m68k/kernel/traps.c	2002-09-25 10:43:44.000000000 +1000
@@ -820,30 +820,16 @@ asmlinkage void buserr_c(struct frame *f
 
 
 static int kstack_depth_to_print = 48;
-extern struct module kernel_module;
 
 static inline int kernel_text_address(unsigned long addr)
 {
-#ifdef CONFIG_MODULES
-	struct module *mod;
-#endif
 	extern char _stext, _etext;
 
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
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
+	return module_is_address(addr);
 }
 
 void show_trace(unsigned long *stack)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/s390/kernel/traps.c .19547-linux-2.5.38.updated/arch/s390/kernel/traps.c
--- .19547-linux-2.5.38/arch/s390/kernel/traps.c	2002-07-25 10:13:05.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/s390/kernel/traps.c	2002-09-25 10:43:44.000000000 +1000
@@ -70,43 +70,15 @@ static int kstack_depth_to_print = 12;
  */
 extern char _stext, _etext;
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
-	int retval = 0;
-	struct module *mod;
-
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
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
+	return module_is_address(addr);
 }
 
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/s390x/kernel/traps.c .19547-linux-2.5.38.updated/arch/s390x/kernel/traps.c
--- .19547-linux-2.5.38/arch/s390x/kernel/traps.c	2002-07-25 10:13:05.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/s390x/kernel/traps.c	2002-09-25 10:43:44.000000000 +1000
@@ -72,43 +72,15 @@ static int kstack_depth_to_print = 20;
  */
 extern char _stext, _etext;
 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
-	int retval = 0;
-	struct module *mod;
-
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
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
+	return module_is_address(addr);
 }
 
-#endif
-
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/um/kernel/sysrq.c .19547-linux-2.5.38.updated/arch/um/kernel/sysrq.c
--- .19547-linux-2.5.38/arch/um/kernel/sysrq.c	2002-09-18 16:03:56.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/um/kernel/sysrq.c	2002-09-25 10:43:44.000000000 +1000
@@ -16,44 +16,15 @@
   * kernel, or in the vmalloc'ed module regions, it *may* 
   * be the address of a calling routine
   */
- 
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
-	int retval = 0;
-	struct module *mod;
-
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
 
-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
-		/* mod_bound tests for addr being inside the vmalloc'ed
-		 * module area. Of course it'd be better to test only
-		 * for the .text subset... */
-		if (mod_bound(addr, 0, mod)) {
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
+	return module_is_address(addr);
 }
 
-#endif
-
 void show_trace(unsigned long * stack)
 {
         int i;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/arch/x86_64/kernel/traps.c .19547-linux-2.5.38.updated/arch/x86_64/kernel/traps.c
--- .19547-linux-2.5.38/arch/x86_64/kernel/traps.c	2002-07-25 10:13:05.000000000 +1000
+++ .19547-linux-2.5.38.updated/arch/x86_64/kernel/traps.c	2002-09-25 10:43:44.000000000 +1000
@@ -111,44 +111,15 @@ int printk_address(unsigned long address
 } 
 #endif
 
-
-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
-   int retval = 0;
-   struct module *mod;
-
-   if (addr >= (unsigned long) &_stext &&
-       addr <= (unsigned long) &_etext)
-       return 1;
-
-   for (mod = module_list; mod != &kernel_module; mod = mod->next) {
-       /* mod_bound tests for addr being inside the vmalloc'ed
-        * module area. Of course it'd be better to test only
-        * for the .text subset... */
-       if (mod_bound(addr, 0, mod)) {
-           retval = 1;
-           break;
-       }
-   }
-
-   return retval;
-}
-
-#else
+	if (addr >= (unsigned long) &_stext &&
+	    addr <= (unsigned long) &_etext)
+		return 1;
 
-static inline int kernel_text_address(unsigned long addr)
-{
-   return (addr >= (unsigned long) &_stext &&
-       addr <= (unsigned long) &_etext);
+	return module_is_address(addr);
 }
 
-#endif
-
 /*
  * These constants are for searching for possible module text
  * segments. MODULE_RANGE is a guess of how much space is likely
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/include/linux/module.h .19547-linux-2.5.38.updated/include/linux/module.h
--- .19547-linux-2.5.38/include/linux/module.h	2002-09-25 10:43:21.000000000 +1000
+++ .19547-linux-2.5.38.updated/include/linux/module.h	2002-09-25 10:43:44.000000000 +1000
@@ -244,6 +244,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 /* Free memory returned from module_core_alloc/module_init_alloc */
 void module_free(struct module *mod, void *module_region);
 
+/* Is this address in a module? */
+int module_is_address(unsigned long addr);
+
 #ifdef CONFIG_MODULE_UNLOAD
 #define symbol_put(x) __put_symbol(#x)
 
@@ -311,6 +314,12 @@ search_exception_tables(unsigned long ad
 			      add);
 }
 
+/* Is this address in a module? */
+static inline int module_is_address(unsigned long addr)
+{
+	return 0;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ((typeof(&x))(0))
 
@@ -354,14 +363,6 @@ extern int module_dummy_usage;
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
 
 #ifdef __GENKSYMS__
 /* We want the EXPORT_SYMBOL tag left intact for recognition.  */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19547-linux-2.5.38/kernel/module.c .19547-linux-2.5.38.updated/kernel/module.c
--- .19547-linux-2.5.38/kernel/module.c	2002-09-25 10:43:21.000000000 +1000
+++ .19547-linux-2.5.38.updated/kernel/module.c	2002-09-25 10:44:55.000000000 +1000
@@ -54,9 +54,9 @@ static struct exception_table kernel_ext
 static struct kernel_symbol_group kernel_symbols;
 static struct kernel_symbol_group kernel_gpl_symbols;
 
-/* List of modules, protected by module_mutex */
+/* List of modules, protected by module_mutex AND module_lock */
 static DECLARE_MUTEX(module_mutex);
-LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
+static LIST_HEAD(modules);
 
 /* Convenient structure for holding init and core sizes */
 struct sizes
@@ -583,8 +583,8 @@ unsigned long find_symbol_internal(Elf_S
 static void free_module(struct module *mod)
 {
 	/* Delete from various lists */
-	list_del(&mod->list);
 	spin_lock_irq(&module_lock);
+	list_del(&mod->list);
 	list_del(&mod->symbols.list);
 	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
@@ -1174,8 +1174,8 @@ sys_init_module(void *umod,
 	spin_lock_irq(&module_lock);
 	list_add(&mod->symbols.list, &kernel_symbols.list);
 	list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
-	spin_unlock_irq(&module_lock);
 	list_add(&mod->list, &modules);
+	spin_unlock_irq(&module_lock);
 
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
@@ -1213,6 +1213,31 @@ const struct exception_table_entry *sear
 	return found;
 }
 
+/* Is this a valid kernel address? */
+int module_is_address(unsigned long addr)
+{
+	unsigned long flags;
+	struct module *mod;
+	int ret = 0;
+
+	spin_lock_irqsave(&module_lock, flags);
+	list_for_each_entry(mod, &modules, list) {
+		if (mod->module_init
+		    && (void *)addr >= mod->module_init
+		    && (void *)addr < mod->module_init + mod->init_size) {
+			ret = 1;
+			break;
+		}
+		if ((void *)addr >= mod->module_core
+		    && (void *)addr < mod->module_core + mod->core_size) {
+			ret = 1;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&module_lock, flags);
+	return ret;
+}
+
 /* Called by the /proc file system to return a current list of
    modules.  Al Viro came up with this interface as an "improvement".
    God save us from any more such interface improvements. */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
