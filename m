Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbTFWJHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbTFWJHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:07:10 -0400
Received: from dp.samba.org ([66.70.73.150]:12721 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265177AbTFWJGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:06:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH 3/3] Allow arbitrary number of init funcs in modules
Date: Mon, 23 Jun 2003 19:19:48 +1000
Message-Id: <20030623092028.2B5272C2FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch requires some explanation, see description fields below.

Thanks to Andrew for prodding, and DaveM for the hard questions.

Feedback is extremely welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Allow Arbitrary Number of Init and Exit Functions
Author: Rusty Russell
Status: Tested on 2.5.73
Depends: Misc/unique_id.patch.gz

D: One longstanding complaint is that modules can only have one
D: module_init, and one module_exit (builtin code can have multiple
D: __initcall however).  This means, for example, that it is not
D: possible to write a "module_proc_entry(name, readfn)" function
D: which can be used like so:
D: 
D:   module_init(myinitfn);
D:   module_cleanup(myinitfn);
D:   module_proc_entry("some/path/foo", read_foo);
D: 
D: The reason we don't allow multiple init functions in modules: if
D: one fails, we won't know what to do.  The solution is to explicitly
D: pair them, hence module_init_exit(), with a priority arg.
D: 
D: If the module fails to load the exit function will be called
D: corresponding to each init function which was called, in backwards
D: order.  All exit functions are called on module removal.
D: 
D: For non-modules, the exit arg is discarded, and the initcalls are
D: run in priority order at boot (order within priorities is still
D: controlled by linking, as previously).  This means we can also get
D: rid of the initcall levels at link time and simply use priorities.
D: 
D: This patch also uses kallsyms to print function names when 
D: "initcall_debug" is set.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15772-linux-2.5.73/arch/i386/vmlinux.lds.S .15772-linux-2.5.73.updated/arch/i386/vmlinux.lds.S
--- .15772-linux-2.5.73/arch/i386/vmlinux.lds.S	2003-06-15 11:29:47.000000000 +1000
+++ .15772-linux-2.5.73.updated/arch/i386/vmlinux.lds.S	2003-06-23 18:10:41.000000000 +1000
@@ -69,13 +69,7 @@ SECTIONS
   __stop___param = .;
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	*(.initcall.init) 
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15772-linux-2.5.73/include/linux/init.h .15772-linux-2.5.73.updated/include/linux/init.h
--- .15772-linux-2.5.73/include/linux/init.h	2003-06-15 11:30:08.000000000 +1000
+++ .15772-linux-2.5.73.updated/include/linux/init.h	2003-06-23 18:17:22.000000000 +1000
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H
 
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -65,34 +66,48 @@ typedef void (*exitcall_t)(void);
 
 extern initcall_t __con_initcall_start, __con_initcall_end;
 extern initcall_t __security_initcall_start, __security_initcall_end;
+
+struct module_init_exit
+{
+	int prio;
+	initcall_t init;
+	exitcall_t exit;
+};
+
+struct kernel_init
+{
+	int prio;
+	initcall_t init;
+};
 #endif
-  
+
 #ifndef MODULE
 
 #ifndef __ASSEMBLY__
+/* Suppress unused warning on exitfn, and test type. */
+#define __exitcall(fn)							\
+static inline exitcall_t __unique_id(exit_test)(void) { return fn; }
 
-/* initcalls are now grouped by functionality into separate 
- * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatibility, initcall() puts the call in 
- * the device init subsection.
- */
-
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
-
-#define core_initcall(fn)		__define_initcall("1",fn)
-#define postcore_initcall(fn)		__define_initcall("2",fn)
-#define arch_initcall(fn)		__define_initcall("3",fn)
-#define subsys_initcall(fn)		__define_initcall("4",fn)
-#define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+/* Pair of calls: one called at boot, one at exit (ie. never, when not
+   a module).  Unlike module_init, you can have any number of these.
+   prio controls ordering: negative runs before module_init, positive after.
+   Within a priority, link order rules.
+*/
+#define module_init_exit(prio, initfn, exitfn)			\
+	__exitcall(exitfn);					\
+	static struct kernel_init __initcall_##initfn		\
+	 __attribute__((unused,__section__ (".initcall.init")))	\
+	= { prio, initfn }
 
-#define __initcall(fn) device_initcall(fn)
+#define core_initcall(fn)		module_init_exit(-5000, fn, NULL)
+#define postcore_initcall(fn)		module_init_exit(-4000, fn, NULL)
+#define arch_initcall(fn)		module_init_exit(-3000, fn, NULL)
+#define subsys_initcall(fn)		module_init_exit(-2000, fn, NULL)
+#define fs_initcall(fn)			module_init_exit(-1000, fn, NULL)
+#define device_initcall(fn)		module_init_exit(0, fn, NULL)
+#define late_initcall(fn)		module_init_exit(1000, fn, NULL)
 
-#define __exitcall(fn)							\
-	static exitcall_t __exitcall_##fn __exit_call = fn
+#define __initcall(fn)			device_initcall(fn)
 
 #define console_initcall(fn) \
 	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
@@ -112,8 +127,6 @@ struct obs_kernel_param {
 		 __attribute__((unused,__section__ (".init.setup")))	\
 		= { __setup_str_##fn, fn }
 
-#endif /* __ASSEMBLY__ */
-
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -135,6 +148,7 @@ struct obs_kernel_param {
  * There can only be one per module.
  */
 #define module_exit(x)	__exitcall(x);
+#endif /* __ASSEMBLY__ */
 
 #else /* MODULE */
 
@@ -149,25 +163,27 @@ struct obs_kernel_param {
 
 #define security_initcall(fn)		module_init(fn)
 
-/* These macros create a dummy inline: gcc 2.9x does not count alias
- as usage, hence the `unused function' warning when __init functions
- are declared static. We use the dummy __*_module_inline functions
- both to kill the warning and check the type of the init/cleanup
- function. */
-
-/* Each module must use one module_init(), or one no_module_init */
-#define module_init(initfn)					\
-	static inline initcall_t __inittest(void)		\
-	{ return initfn; }					\
-	int init_module(void) __attribute__((alias(#initfn)));
+/* Each module can have one module_init(). */
+#define module_init(initfn)						\
+	static struct module_init_exit module_init			\
+	 __attribute__ ((unused,__section__ ("__initexit")))	\
+	= { 0, initfn, NULL };
 
-/* This is only required if you want to be unloadable. */
-#define module_exit(exitfn)					\
-	static inline exitcall_t __exittest(void)		\
-	{ return exitfn; }					\
-	void cleanup_module(void) __attribute__((alias(#exitfn)));
+/* If you have a module_init, and want to be unloadable, you need this too. */
+#define module_exit(exitfn)						\
+	static struct module_init_exit module_exit			\
+	 __attribute__ ((unused,__section__ ("__initexit")))	\
+	= { 0, NULL, exitfn };
 
 #define __setup(str,func) /* nothing */
+
+/* Pair of calls: one called at init, one at exit.  Unlike
+   module_init/module_exit, you can have any number of these: ordering is
+   controlled by priority, in ascending order: module_init is 0. */
+#define module_init_exit(prio, initfn, exitfn)				\
+	static struct module_init_exit __unique_id(mie)			\
+	 __attribute__ ((unused,__section__ ("__initexit")))		\
+	= { prio, initfn, exitfn }
 #endif
 
 /* Data marked not to be saved by software_suspend() */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15772-linux-2.5.73/include/linux/module.h .15772-linux-2.5.73.updated/include/linux/module.h
--- .15772-linux-2.5.73/include/linux/module.h	2003-06-23 17:29:39.000000000 +1000
+++ .15772-linux-2.5.73.updated/include/linux/module.h	2003-06-23 17:29:42.000000000 +1000
@@ -203,9 +203,6 @@ struct module
 	unsigned int num_exentries;
 	const struct exception_table_entry *extable;
 
-	/* Startup function. */
-	int (*init)(void);
-
 	/* If this is non-NULL, vfree after init() returns */
 	void *module_init;
 
@@ -224,6 +221,10 @@ struct module
 	/* Am I GPL-compatible */
 	int license_gplok;
 
+	/* Pairs of init/exit functions. */
+	struct module_init_exit *ie_pairs;
+	unsigned int num_ie_pairs;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
@@ -233,9 +234,6 @@ struct module
 
 	/* Who is waiting for us to be unloaded */
 	struct task_struct *waiter;
-
-	/* Destruction function. */
-	void (*exit)(void);
 #endif
 
 #ifdef CONFIG_KALLSYMS
@@ -449,10 +447,6 @@ extern struct module __this_module;
 struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
-	.init = init_module,
-#ifdef CONFIG_MODULE_UNLOAD
-	.exit = cleanup_module,
-#endif
 };
 #endif /* KBUILD_MODNAME */
 #endif /* MODULE */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15772-linux-2.5.73/init/main.c .15772-linux-2.5.73.updated/init/main.c
--- .15772-linux-2.5.73/init/main.c	2003-06-17 16:57:33.000000000 +1000
+++ .15772-linux-2.5.73.updated/init/main.c	2003-06-23 18:51:34.000000000 +1000
@@ -38,6 +38,7 @@
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -478,34 +479,67 @@ __setup("initcall_debug", initcall_debug
 
 struct task_struct *child_reaper = &init_task;
 
-extern initcall_t __initcall_start, __initcall_end;
-
-static void __init do_initcalls(void)
+static void do_initcall(initcall_t call)
 {
-	initcall_t *call;
+	char *msg = NULL;
+	char buf[128];
+	char *m;
+	unsigned long d;
 	int count = preempt_count();
 
-	for (call = &__initcall_start; call < &__initcall_end; call++) {
-		char *msg;
+	if (initcall_debug)
+		printk("calling initcall 0x%p %s\n", *call,
+		       kallsyms_lookup((long)call, &d, &d, &m, buf) ?: "");
+	call();
 
-		if (initcall_debug)
-			printk("calling initcall 0x%p\n", *call);
+	if (preempt_count() != count) {
+		msg = "preemption imbalance";
+		preempt_count() = count;
+	}
+	if (irqs_disabled()) {
+		msg = "disabled interrupts";
+		local_irq_enable();
+	}
+	if (msg) {
+		printk("error in initcall at 0x%p %s: "
+		       "returned with %s\n", *call,
+		       kallsyms_lookup((long)call, &d, &d, &m, buf) ?: "",
+		       msg);
+	}
+}
 
-		(*call)();
+/* Defined by linker magic. */
+extern struct kernel_init __initcall_start[], __initcall_end[];
 
-		msg = NULL;
-		if (preempt_count() != count) {
-			msg = "preemption imbalance";
-			preempt_count() = count;
-		}
-		if (irqs_disabled()) {
-			msg = "disabled interrupts";
-			local_irq_enable();
-		}
-		if (msg) {
-			printk("error in initcall at 0x%p: "
-				"returned with %s\n", *call, msg);
+/* Find first initfunc minimally >= this prio level. */
+static struct kernel_init *find_next_prio(int min_prio_todo)
+{
+	struct kernel_init *i, *best;
+
+	best = NULL;
+	for (i = __initcall_start; i < __initcall_end; i++) {
+		if (i->prio >= min_prio_todo
+		    && (!best || i->prio < best->prio))
+			best = i;
+	}
+	return best;
+}
+
+static void __init do_initcalls(void)
+{
+	struct kernel_init *next, *i;
+	int min_prio_todo = INT_MIN;
+
+	/* This is O(num calls * num levels), which is OK. */
+	while ((next = find_next_prio(min_prio_todo)) != NULL) {
+		if (initcall_debug)
+			printk("Doing priority %i initcalls:\n", next->prio);
+		/* Now call all at that priority. */
+		for (i = next; i < __initcall_end; i++) {
+			if (i->prio == next->prio)
+				do_initcall(i->init);
 		}
+		min_prio_todo = next->prio+1;
 	}
 
 	/* Make sure there is no pending stuff from the initcall sequence */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15772-linux-2.5.73/kernel/module.c .15772-linux-2.5.73.updated/kernel/module.c
--- .15772-linux-2.5.73/kernel/module.c	2003-06-15 11:30:11.000000000 +1000
+++ .15772-linux-2.5.73.updated/kernel/module.c	2003-06-23 17:29:42.000000000 +1000
@@ -91,13 +91,6 @@ static inline int strong_try_module_get(
 	return try_module_get(mod);
 }
 
-/* Stub function for modules which don't have an initfn */
-int init_module(void)
-{
-	return 0;
-}
-EXPORT_SYMBOL(init_module);
-
 /* Find a module section: 0 means not found. */
 static unsigned int find_sec(Elf_Ehdr *hdr,
 			     Elf_Shdr *sechdrs,
@@ -619,11 +612,16 @@ static inline int try_force(unsigned int
 }
 #endif /* CONFIG_MODULE_FORCE_UNLOAD */
 
-/* Stub function for modules which don't have an exitfn */
-void cleanup_module(void)
+/* Need as many exits as inits to unload. */
+static int can_unload(unsigned int num_pairs, struct module_init_exit *pairs)
 {
+	int i, balance = 0;
+
+	for (i = 0; i < num_pairs; i++)
+		balance += (pairs->init ? 1 : 0) - (pairs->exit ? 1 : 0);
+
+	return balance == 0;
 }
-EXPORT_SYMBOL(cleanup_module);
 
 static void wait_for_zero_refcount(struct module *mod)
 {
@@ -645,6 +643,7 @@ sys_delete_module(const char __user *nam
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
+	unsigned int i;
 	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE))
@@ -678,9 +677,8 @@ sys_delete_module(const char __user *nam
 		goto out;
 	}
 
-	/* If it has an init func, it must have an exit func to unload */
-	if ((mod->init != init_module && mod->exit == cleanup_module)
-	    || mod->unsafe) {
+	/* Init and exit functions must balance to unload. */
+	if (!can_unload(mod->num_ie_pairs, mod->ie_pairs) || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -713,8 +711,10 @@ sys_delete_module(const char __user *nam
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
 
-	/* Final destruction now noone is using it. */
-	mod->exit();
+	/* Final destruction now noone is using it, reverse priority order. */
+	for (i = mod->num_ie_pairs - 1; i >= 0; i--)
+		if (mod->ie_pairs[i].exit)
+			mod->ie_pairs[i].exit();
 	free_module(mod);
 
  out:
@@ -741,7 +741,7 @@ static void print_unload_info(struct seq
 		seq_printf(m, "[unsafe],");
 	}
 
-	if (mod->init != init_module && mod->exit == cleanup_module) {
+	if (!can_unload(mod->num_ie_pairs, mod->ie_pairs)) {
 		printed_something = 1;
 		seq_printf(m, "[permanent],");
 	}
@@ -1351,6 +1351,23 @@ static void add_kallsyms(struct module *
 }
 #endif
 
+/* Order init_exit pairs in ascending priority.  num is small. */
+static void sort_ie_pairs(struct module_init_exit *ie_pairs, unsigned int num)
+{
+	unsigned int i, j;
+	struct module_init_exit tmp;
+
+	for (i = 0; i < num; i++) {
+		for (j = i; j+1 < num; j++) {
+			if (ie_pairs[j].prio > ie_pairs[j+1].prio) {
+				tmp = ie_pairs[j];
+				ie_pairs[j] = ie_pairs[j+1];
+				ie_pairs[j+1] = tmp;
+			}
+		}
+	}
+}
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void __user *umod,
@@ -1362,7 +1379,7 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex;
+		crcindex, gplcrcindex, versindex, pcpuindex, iepairindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1437,6 +1454,7 @@ static struct module *load_module(void _
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
+	iepairindex = find_sec(hdr, sechdrs, secstrings, "__initexit");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
 
 	/* Don't keep modinfo section */
@@ -1587,6 +1605,12 @@ static struct module *load_module(void _
 	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
 	mod->extable = (void *)sechdrs[exindex].sh_addr;
 
+	/* Set up init/exit pair table, and sort into prio order. */
+	mod->num_ie_pairs = sechdrs[iepairindex].sh_size
+		/ sizeof(struct module_init_exit);
+	mod->ie_pairs = (void *)sechdrs[iepairindex].sh_addr;
+	sort_ie_pairs(mod->ie_pairs, mod->num_ie_pairs);
+
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;
@@ -1661,7 +1685,7 @@ sys_init_module(void __user *umod,
 		const char __user *uargs)
 {
 	struct module *mod;
-	int ret;
+	int i, ret;
 
 	/* Must have permission */
 	if (!capable(CAP_SYS_MODULE))
@@ -1700,22 +1724,13 @@ sys_init_module(void __user *umod,
 	up(&notify_mutex);
 
 	/* Start the module */
-	ret = mod->init();
-	if (ret < 0) {
-		/* Init routine failed: abort.  Try to protect us from
-                   buggy refcounters. */
-		mod->state = MODULE_STATE_GOING;
-		synchronize_kernel();
-		if (mod->unsafe)
-			printk(KERN_ERR "%s: module is now stuck!\n",
-			       mod->name);
-		else {
-			module_put(mod);
-			down(&module_mutex);
-			free_module(mod);
-			up(&module_mutex);
+	for (i = 0; i < mod->num_ie_pairs; i++) {
+		ret = mod->ie_pairs[i].init();
+		if (ret != 0) {
+			DEBUGP("%s: init/exit pair init=%p failed: %i\n",
+			       mod->name, mod->ie_pairs[i].init, ret);
+			goto unwind_iepairs;
 		}
-		return ret;
 	}
 
 	/* Now it's a first class citizen! */
@@ -1729,6 +1744,25 @@ sys_init_module(void __user *umod,
 	up(&module_mutex);
 
 	return 0;
+
+unwind_iepairs:
+	/* Init routine failed: abort.  Try to protect us from
+	   buggy refcounters. */
+	mod->state = MODULE_STATE_GOING;
+	module_put(mod);
+	synchronize_kernel();
+	if (module_refcount(mod)) {
+		printk(KERN_ERR "%s: module is now stuck!\n", mod->name);
+		return ret;
+	}
+
+	down(&module_mutex);
+	while (--i >= 0)
+		if (mod->ie_pairs[i].exit)
+			mod->ie_pairs[i].exit();
+	free_module(mod);
+	up(&module_mutex);
+	return ret;
 }
 
 static inline int within(unsigned long addr, void *start, unsigned long size)
