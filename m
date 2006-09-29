Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWI2IRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWI2IRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWI2IRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:17:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23186 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030316AbWI2IRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:17:01 -0400
Subject: [RFC][PATCH] Task watchers and modules (WAS Re: [RFC][PATCH 00/10]
	Task watchers v2 Introduction)
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       menage@google.com, sgrubb@redhat.com, hch@lst.de
In-Reply-To: <20060928194142.cece62bb.pj@sgi.com>
References: <20060929020232.756637000@us.ibm.com>
	 <20060928194142.cece62bb.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 29 Sep 2006 01:16:55 -0700
Message-Id: <1159517815.3286.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 19:41 -0700, Paul Jackson wrote:
> How might this play with Paul Menage's <menage@google.com> patch posted
> earlier today on lkml:
> 
>   [RFC][PATCH 0/4] Generic container system
> 
> My cpuset_exit() call is getting popular - both you guys seem to have
> designs on it.
> 
> Separate question - I guess that your task watcher mechanism, the
> way it uses linker magic now, would not enable a loadable module
> to plug into these various fork/exit/... hooks.  Is that right?

Yes.

> Such an ability for loadable modules to get callouts on fork/exit
> would be useful to some ... it could also be a controversial ability.

	I mentioned that I'm working on a patch to allow modules to watch
tasks.

	It uses a similar technique but does require some list traversal during
notification -- one list_head per event per module. Unlike the current
series using task watchers from a module requires registration. The
[un]registration functions are marked EXPORT_SYMBOL_GPL(). Perhaps that
will dampen the controversy somewhat.

	However the module-enablement patch oopses on boot so I didn't post it.
In case you're curious I've included it below:

From: Matt Helsley <matthltc@us.ibm.com>
Subject: [RFC][PATCH] Enable task watching from modules

Allow modules to watch tasks initialize, clone/fork, exec, change [re][ug]ids,
exit, and free.

Adds a .task_watcher_table ELF section containing a series of arrays. Each array has 0
or more function pointers to the watcher functions. Symbols delineating the boundaries
of the arrays within the ELF section are also created. At module load time we find the
table section and keep a pointer to it. Then, whenever a watchable task event occurs we
go over the list of modules interested in the event and call the functions in the
module's table for that event.

Module task watchers are just like regular task watchers except they require registration
with a call to register_module_task_watchers(THIS_MODULE). This adds the module to the
list (one for each event) of modules interested in watching tasks.

To disable the task watchers the module must call
unregister_module_task_watchers(THIS_MODULE). As with other unregistrations the module
is responsible for calling unregister_module_task_watchers() before being unloaded.

BUGS: oopses on boot inside notify_task_watchers()!

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 include/asm-generic/common.lds.h  |   27 ++++++++
 include/asm-generic/module.lds.S  |   11 +++
 include/asm-generic/vmlinux.lds.h |   23 +------
 include/linux/kernel.h            |    9 ++
 include/linux/module.h            |    5 +
 include/linux/task_watchers.h     |   12 ++-
 kernel/module.c                   |    5 +
 kernel/task_watchers.c            |  119 +++++++++++++++++++++++++++++++++++---
 scripts/Makefile.modpost          |   10 ++-
 scripts/mod/modpost.c             |   21 ++++++
 10 files changed, 209 insertions(+), 33 deletions(-)

Index: linux-2.6.18-mm1/kernel/task_watchers.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/task_watchers.c
+++ linux-2.6.18-mm1/kernel/task_watchers.c
@@ -1,6 +1,10 @@
-#include <linux/task_watchers.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#define for_each_task_event(ev) \
+for ((ev) = 0; (ev) < NUM_WATCH_TASK_EVENTS; (ev)++)
 
 /* Defined in include/asm-generic/common.lds.h */
 extern const task_watcher_fn __start_task_watchers_init[],
 		__start_task_watchers_clone[], __start_task_watchers_exec[],
 		__start_task_watchers_uid[], __start_task_watchers_gid[],
@@ -8,30 +12,129 @@ extern const task_watcher_fn __start_tas
 		__stop_task_watchers_free[];
 
 /*
  *  Tables of ptrs to the first watcher func for WATCH_TASK_*
  */
-static const task_watcher_fn *twtable[] = {
+static const task_watcher_fn *twtable[]
+__attribute__((section(".task_watchers_table"))) = {
 	__start_task_watchers_init,
 	__start_task_watchers_clone,
 	__start_task_watchers_exec,
 	__start_task_watchers_uid,
 	__start_task_watchers_gid,
 	__start_task_watchers_exit,
 	__start_task_watchers_free,
 	__stop_task_watchers_free,
 };
 
-int notify_task_watchers(unsigned int ev, unsigned long val,
-			 struct task_struct *tsk)
+static DEFINE_MUTEX(module_tw_list_mutex);
+static struct list_head module_task_watchers[NUM_WATCH_TASK_EVENTS];
+
+void init_task_watching_list_heads(struct list_head *lh_arr)
+{
+	unsigned int ev;
+
+	for_each_task_event(ev)
+		INIT_LIST_HEAD(&lh_arr[ev]);
+}
+
+static int __init init_tw_lists(void)
+{
+	init_task_watching_list_heads(module_task_watchers);
+	return 0;
+}
+core_initcall(init_tw_lists);
+
+static inline int __notify_tw_table(const task_watcher_fn *first,
+				    const task_watcher_fn *end,
+			       	    unsigned long val,
+			  	    struct task_struct *tsk,
+		   		    int ret_err)
 {
 	const task_watcher_fn *tw_call;
-	int ret_err = 0, err;
+	int err;
 
-	/* Call all of the watchers, report the first error */
-	for (tw_call = twtable[ev]; tw_call < twtable[ev + 1]; tw_call++) {
+	/* Call the watchers. Return the first error (but continue) */
+	for (tw_call = first; tw_call < end; tw_call++) {
 		err = (*tw_call)(val, tsk);
-		if (unlikely((err < 0) && (ret_err == NOTIFY_OK)))
+		if (unlikely((err < 0) && (ret_err == 0)))
 			ret_err = err;
 	}
 	return ret_err;
 }
+
+
+int notify_task_watchers(unsigned int ev, unsigned long val,
+			 struct task_struct *tsk)
+{
+	int ret_err = 0;
+	struct list_head *elem, *next;
+
+	/* last +1 of table == start of next table */
+	ret_err = __notify_tw_table(twtable[ev], twtable[ev + 1],
+				    val, tsk, ret_err);
+
+	/* Call the module functions watching this event */
+	rcu_read_lock();
+	list_for_each_safe_rcu(elem, next, &(module_task_watchers[ev])) {
+		struct module *mod;
+
+		mod = container_of(array_of(elem, ev), struct module,
+				   task_watching_modules);
+		rcu_read_unlock();
+
+		/* this call makes unload of this mod unsafe */
+		ret_err = __notify_tw_table(mod->twtable[ev],
+					    mod->twtable[ev + 1],
+				   	    val, tsk, ret_err);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+	return ret_err;
+}
+
+#define tw_table_empty(twtable, ev) ({ ((twtable[ev + 1] - twtable[ev]) == 0) ? 1 : 0; })
+
+int register_module_task_watchers(struct module *mod)
+{
+	unsigned int ev;
+
+	if (mod == NULL)
+		return 0; /* no need to register when linked to kernel */
+	mutex_lock(&module_tw_list_mutex);
+	for_each_task_event(ev) {
+		/* list-emptying initialization must precede registration */
+		BUG_ON(!list_empty(&mod->task_watching_modules[ev]));
+		if (tw_table_empty(mod->twtable, ev))
+			continue; /* module has no watchers for event */
+		mod->unsafe |= 1; /* notify_task_watchers() uses mod funcs */
+		list_add_tail_rcu(&mod->task_watching_modules[ev],
+				  &module_task_watchers[ev]);
+		__module_get(mod); /* prevent module removal before unreg */
+	}
+	mutex_unlock(&module_tw_list_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_module_task_watchers);
+
+int unregister_module_task_watchers(struct module *mod)
+{
+	unsigned int ev;
+
+	if (mod == NULL)
+		return 0;
+	mutex_lock(&module_tw_list_mutex);
+	for_each_task_event(ev) {
+		/* exactly one registration must precede this unregistration */
+		BUG_ON(list_empty(&mod->task_watching_modules[ev]) &&
+		       !tw_table_empty(mod->twtable, ev));
+		if (list_empty(&mod->task_watching_modules[ev]))
+			continue;
+		list_del_rcu(&mod->task_watching_modules[ev]);
+		module_put(mod);
+	}
+	mutex_unlock(&module_tw_list_mutex);
+	synchronize_rcu(); /* wait for list_del_rcu'd list heads to be unused */
+	init_task_watching_list_heads(mod->task_watching_modules);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unregister_module_task_watchers);
Index: linux-2.6.18-mm1/include/linux/task_watchers.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/task_watchers.h
+++ linux-2.6.18-mm1/include/linux/task_watchers.h
@@ -9,23 +9,25 @@
 #define WATCH_TASK_GID   4
 #define WATCH_TASK_EXIT  5
 #define WATCH_TASK_FREE  6
 #define NUM_WATCH_TASK_EVENTS 7
 
-#ifndef MODULE
+
 typedef int (*task_watcher_fn)(unsigned long, struct task_struct*);
 
 /*
  * Watch for events occuring within a task and call the supplied function
  * when (and only when) the given event happens.
- * Only non-modular kernel code may register functions as task_watchers.
  */
 #define task_watcher_func(ev, fn) \
 static task_watcher_fn __task_watcher_##ev##_##fn __attribute_used__ \
 	__attribute__ ((__section__ (".task_watchers." #ev))) = fn
-#else
-#error "task_watcher() macro may not be used in modules."
-#endif
 
 extern int notify_task_watchers(unsigned int ev_idx, unsigned long val,
 				struct task_struct *tsk);
+
+#include <linux/module.h>
+extern void init_task_watching_list_heads(struct list_head *lh_arr);
+
+int register_module_task_watchers(struct module *);
+int unregister_module_task_watchers(struct module *);
 #endif /*  _TASK_WATCHERS_H */
Index: linux-2.6.18-mm1/kernel/module.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/module.c
+++ linux-2.6.18-mm1/kernel/module.c
@@ -1483,10 +1483,11 @@ static struct module *load_module(void _
 	unsigned int i;
 	unsigned int symindex = 0;
 	unsigned int strindex = 0;
 	unsigned int setupindex;
 	unsigned int exindex;
+	unsigned int twindex;
 	unsigned int exportindex;
 	unsigned int modindex;
 	unsigned int obsparmindex;
 	unsigned int infoindex;
 	unsigned int gplindex;
@@ -1588,10 +1589,11 @@ static struct module *load_module(void _
 	gplfuturecrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl_future");
 	unusedcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_unused");
 	unusedgplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_unused_gpl");
 	setupindex = find_sec(hdr, sechdrs, secstrings, "__param");
 	exindex = find_sec(hdr, sechdrs, secstrings, "__ex_table");
+	twindex = find_sec(hdr, sechdrs, secstrings, ".task_watchers_table");
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
 	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
 	pcpuindex = find_pcpusec(hdr, sechdrs, secstrings);
 #ifdef ARCH_UNWIND_SECTION_NAME
@@ -1837,10 +1839,13 @@ static struct module *load_module(void _
 			 / sizeof(struct kernel_param),
 			 NULL);
 	if (err < 0)
 		goto arch_cleanup;
 
+	mod->twtable = (void*)sechdrs[twindex].sh_addr;
+	init_task_watching_list_heads(mod->task_watching_modules);
+
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
 			      sechdrs[setupindex].sh_addr,
 			      sechdrs[setupindex].sh_size
 			      / sizeof(struct kernel_param));
Index: linux-2.6.18-mm1/scripts/Makefile.modpost
===================================================================
--- linux-2.6.18-mm1.orig/scripts/Makefile.modpost
+++ linux-2.6.18-mm1/scripts/Makefile.modpost
@@ -40,10 +40,18 @@ include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 kernelsymfile := $(objtree)/Module.symvers
 modulesymfile := $(KBUILD_EXTMOD)/Module.symvers
 
+# Step 0), make sure the supplemental module linker script has been made
+moduleldscript := include/asm-generic/module.lds
+quiet_cmd_cpp_lds_S = LDS     $@
+      cmd_cpp_lds_S = $(CPP) $(cpp_flags) -C -P -D__ASSEMBLY__ -o $@ $<
+
+%.lds: %.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
 
 _modpost: $(modules)
@@ -93,11 +101,11 @@ targets += $(modules:.ko=.mod.o)
 # Step 6), final link of the modules
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
 			  $(filter-out FORCE,$^)
 
-$(modules): %.ko :%.o %.mod.o FORCE
+$(modules): %.ko : %.o %.mod.o $(moduleldscript) FORCE
 	$(call if_changed,ld_ko_o)
 
 targets += $(modules)
 
 
Index: linux-2.6.18-mm1/include/asm-generic/module.lds.S
===================================================================
--- /dev/null
+++ linux-2.6.18-mm1/include/asm-generic/module.lds.S
@@ -0,0 +1,11 @@
+#include <asm-generic/common.lds.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+
+SECTIONS
+{
+	.text : {
+		*(.text*)
+	}
+	TWTABLE
+}
Index: linux-2.6.18-mm1/include/asm-generic/common.lds.h
===================================================================
--- /dev/null
+++ linux-2.6.18-mm1/include/asm-generic/common.lds.h
@@ -0,0 +1,27 @@
+#ifndef LOAD_OFFSET
+#define LOAD_OFFSET 0
+#endif
+
+#ifndef VMLINUX_SYMBOL
+#define VMLINUX_SYMBOL(_sym_) _sym_
+#endif
+
+#define TWTABLE								\
+	.task_watchers_table : AT(ADDR(.task_watchers_table) - LOAD_OFFSET) { \
+		*(.task_watchers_table)					\
+		VMLINUX_SYMBOL(__start_task_watchers_init) = .;		\
+		*(.task_watchers.init)				\
+		VMLINUX_SYMBOL(__start_task_watchers_clone) = .;	\
+		*(.task_watchers.clone)					\
+		VMLINUX_SYMBOL(__start_task_watchers_exec) = .;		\
+		*(.task_watchers.exec)					\
+		VMLINUX_SYMBOL(__start_task_watchers_uid) = .;		\
+		*(.task_watchers.uid)					\
+		VMLINUX_SYMBOL(__start_task_watchers_gid) = .;		\
+		*(.task_watchers.gid)					\
+		VMLINUX_SYMBOL(__start_task_watchers_exit) = .;		\
+		*(.task_watchers.exit)					\
+		VMLINUX_SYMBOL(__start_task_watchers_free) = .;		\
+		*(.task_watchers.free)					\
+		VMLINUX_SYMBOL(__stop_task_watchers_free) = .;		\
+	}
Index: linux-2.6.18-mm1/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-2.6.18-mm1.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6.18-mm1/include/asm-generic/vmlinux.lds.h
@@ -1,5 +1,7 @@
+#include <asm-generic/common.lds.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
 
 #ifndef VMLINUX_SYMBOL
@@ -42,29 +44,10 @@
 		VMLINUX_SYMBOL(__start_rio_route_ops) = .;		\
 		*(.rio_route_ops)					\
 		VMLINUX_SYMBOL(__end_rio_route_ops) = .;		\
 	}								\
 									\
-	.task_watchers_table : AT(ADDR(.task_watchers_table) - LOAD_OFFSET) { \
-		*(.task_watchers_table)					\
-		VMLINUX_SYMBOL(__start_task_watchers_init) = .;		\
-		*(.task_watchers.init)					\
-		VMLINUX_SYMBOL(__start_task_watchers_clone) = .;	\
-		*(.task_watchers.clone)					\
-		VMLINUX_SYMBOL(__start_task_watchers_exec) = .;		\
-		*(.task_watchers.exec)					\
-		VMLINUX_SYMBOL(__start_task_watchers_uid) = .;		\
-		*(.task_watchers.uid)					\
-		VMLINUX_SYMBOL(__start_task_watchers_gid) = .;		\
-		*(.task_watchers.gid)					\
-		VMLINUX_SYMBOL(__start_task_watchers_exit) = .;		\
-		*(.task_watchers.exit)					\
-		VMLINUX_SYMBOL(__start_task_watchers_free) = .;		\
-		*(.task_watchers.free)					\
-		VMLINUX_SYMBOL(__stop_task_watchers_free) = .;		\
-	}								\
-									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
 		*(__ksymtab)						\
 		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
@@ -136,10 +119,12 @@
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
 	}								\
 									\
+	TWTABLE								\
+									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
 		VMLINUX_SYMBOL(__start___param) = .;			\
 		*(__param)						\
 		VMLINUX_SYMBOL(__stop___param) = .;			\
Index: linux-2.6.18-mm1/include/linux/module.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/module.h
+++ linux-2.6.18-mm1/include/linux/module.h
@@ -15,10 +15,11 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
+#include <linux/task_watchers.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
 
 /* Not Yet Implemented */
@@ -291,10 +292,14 @@ struct module
 
 	/* Exception table */
 	unsigned int num_exentries;
 	const struct exception_table_entry *extable;
 
+	/* Task watcher list elems and fn ptr table */
+	struct list_head task_watching_modules[NUM_WATCH_TASK_EVENTS];
+	const task_watcher_fn **twtable;
+
 	/* Startup function. */
 	int (*init)(void);
 
 	/* If this is non-NULL, vfree after init() returns */
 	void *module_init;
Index: linux-2.6.18-mm1/scripts/mod/modpost.c
===================================================================
--- linux-2.6.18-mm1.orig/scripts/mod/modpost.c
+++ linux-2.6.18-mm1/scripts/mod/modpost.c
@@ -1178,10 +1178,11 @@ static void check_exports(struct module 
 static void add_header(struct buffer *b, struct module *mod)
 {
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
+	buf_printf(b, "#include <linux/task_watchers.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "struct module __this_module\n");
 	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
@@ -1190,10 +1191,30 @@ static void add_header(struct buffer *b,
 		buf_printf(b, " .init = init_module,\n");
 	if (mod->has_cleanup)
 		buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n"
 			      " .exit = cleanup_module,\n"
 			      "#endif\n");
+	buf_printf(b, "};\n\n");
+	buf_printf(b, "/* Defined in include/asm-generic/common.lds.h */\n");
+	buf_printf(b, "extern const task_watcher_fn __start_task_watchers_init[],\n");
+	buf_printf(b, "\t__start_task_watchers_clone[],\n");
+	buf_printf(b, "\t__start_task_watchers_exec[],\n");
+	buf_printf(b, "\t__start_task_watchers_uid[],\n");
+	buf_printf(b, "\t__start_task_watchers_gid[],\n");
+	buf_printf(b, "\t__start_task_watchers_exit[],\n");
+	buf_printf(b, "\t__start_task_watchers_free[],\n");
+	buf_printf(b, "\t__stop_task_watchers_free[];\n\n");
+	buf_printf(b, "static const task_watcher_fn *twtable[]\n");
+	buf_printf(b, "__attribute_used__ __attribute__((section(\".task_watchers_table\"), used)) = {\n");
+	buf_printf(b, "\t__start_task_watchers_init,\n");
+	buf_printf(b, "\t__start_task_watchers_clone,\n");
+	buf_printf(b, "\t__start_task_watchers_exec,\n");
+	buf_printf(b, "\t__start_task_watchers_uid,\n");
+	buf_printf(b, "\t__start_task_watchers_gid,\n");
+	buf_printf(b, "\t__start_task_watchers_exit,\n");
+	buf_printf(b, "\t__start_task_watchers_free,\n");
+	buf_printf(b, "\t__stop_task_watchers_free,\n");
 	buf_printf(b, "};\n");
 }
 
 /**
  * Record CRCs for unresolved symbols
Index: linux-2.6.18-mm1/include/linux/kernel.h
===================================================================
--- linux-2.6.18-mm1.orig/include/linux/kernel.h
+++ linux-2.6.18-mm1/include/linux/kernel.h
@@ -298,10 +298,19 @@ static inline int __attribute__ ((format
  */
 #define container_of(ptr, type, member) ({			\
         const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
         (type *)( (char *)__mptr - offsetof(type,member) );})
 
+/**
+ * array_of - cast an element of an array out to the containing array
+ * @ptr:	the pointer to the element.
+ * @i:		the index within the array.
+ *
+ */
+#define array_of(ptr, i) \
+	({ const typeof(*(ptr)) *__mptr = (ptr); __mptr -= (i); __mptr; })
+
 /*
  * Check at compile time that something is of a particular type.
  * Always evaluates to 1 so you may use it easily in comparisons.
  */
 #define typecheck(type,x) \


