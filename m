Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSLUWDE>; Sat, 21 Dec 2002 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLUWDE>; Sat, 21 Dec 2002 17:03:04 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:25354 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265092AbSLUWCx>; Sat, 21 Dec 2002 17:02:53 -0500
Date: Sat, 21 Dec 2002 22:58:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] How not to break everything at once II
Message-ID: <Pine.LNX.4.44.0212211913590.12298-100000@spit.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is another patch, which demonstrates that it was not necessary to
break compatibility with modutils. The patch adds back the query_module
and create_module syscall, so that modutils works nicely again (even the
arguments).
Rusty, could you please explain, why it was necessary to completely break
everything? The old interface was certainly limited, but it was not
broken. It was possible to gradually replace one part with another and it
had not been necessary to frantically fix up everything after breaking it
and too much is still broken:
- no modinfo
- modversion
- tainting/licence info
- ksymoops
This is certainly all fixable, but it was working nicely before. What
improvements will we get, when everything works again? So far I only see
more and more bloat.
Slowly it should be clear that shoving the loader into the kernel, does
not magically solve all problems. You still need a userspace interface, so
you use now /proc/modules instead of query_module. ksymoops still needs
the kernel symbols. Module loading/unloading needs dependency information.
All this information can be kept in userspace and I see absolutely no
reason to bloat the kernel with this.
Rusty, I would be nice if you would start defending your work. I posted
now enough criticism and alternative suggestion and there were exactly
zero responses from you. I would prefer to work together with you on this,
but if it continues like this, the next patch will just remove all the
bloat and return the modules into a working state.

bye, Roman

diff -ur -X /home/roman/nodiff linux-2.5.52.org/arch/i386/kernel/entry.S linux-2.5.52/arch/i386/kernel/entry.S
--- linux-2.5.52.org/arch/i386/kernel/entry.S	2002-12-16 03:07:50.000000000 +0100
+++ linux-2.5.52/arch/i386/kernel/entry.S	2002-12-21 02:57:36.000000000 +0100
@@ -611,7 +611,7 @@
 	.long sys_adjtimex
 	.long sys_mprotect	/* 125 */
 	.long sys_sigprocmask
-	.long sys_ni_syscall	/* old "create_module" */
+	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
 	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
@@ -651,7 +651,7 @@
 	.long sys_setresuid16
 	.long sys_getresuid16	/* 165 */
 	.long sys_vm86
-	.long sys_ni_syscall	/* Old sys_query_module */
+	.long sys_query_module
 	.long sys_poll
 	.long sys_nfsservctl
 	.long sys_setresgid16	/* 170 */
diff -ur -X /home/roman/nodiff linux-2.5.52.org/arch/um/kernel/sys_call_table.c linux-2.5.52/arch/um/kernel/sys_call_table.c
--- linux-2.5.52.org/arch/um/kernel/sys_call_table.c	2002-12-21 02:37:43.000000000 +0100
+++ linux-2.5.52/arch/um/kernel/sys_call_table.c	2002-12-20 18:52:29.000000000 +0100
@@ -127,6 +127,7 @@
 extern syscall_handler_t sys_adjtimex;
 extern syscall_handler_t sys_mprotect;
 extern syscall_handler_t sys_sigprocmask;
+extern syscall_handler_t sys_create_module;
 extern syscall_handler_t sys_init_module;
 extern syscall_handler_t sys_delete_module;
 extern syscall_handler_t sys_quotactl;
@@ -162,6 +163,7 @@
 extern syscall_handler_t sys_setresuid16;
 extern syscall_handler_t sys_getresuid16;
 extern syscall_handler_t sys_ni_syscall;
+extern syscall_handler_t sys_query_module;
 extern syscall_handler_t sys_poll;
 extern syscall_handler_t sys_nfsservctl;
 extern syscall_handler_t sys_setresgid16;
@@ -384,7 +386,7 @@
 	[ __NR_adjtimex ] = sys_adjtimex,
 	[ __NR_mprotect ] = sys_mprotect,
 	[ __NR_sigprocmask ] = sys_sigprocmask,
-	[ __NR_create_module ] = sys_ni_syscall,
+	[ __NR_create_module ] = sys_create_module,
 	[ __NR_init_module ] = sys_init_module,
 	[ __NR_delete_module ] = sys_delete_module,
 	[ __NR_get_kernel_syms ] = sys_ni_syscall,
@@ -424,7 +426,7 @@
 	[ __NR_setresuid ] = sys_setresuid16,
 	[ __NR_getresuid ] = sys_getresuid16,
 	[ __NR_vm86 ] = sys_ni_syscall,
-	[ __NR_query_module ] = sys_ni_syscall,
+	[ __NR_query_module ] = sys_query_module,
 	[ __NR_poll ] = sys_poll,
 	[ __NR_nfsservctl ] = NFSSERVCTL,
 	[ __NR_setresgid ] = sys_setresgid16,
diff -ur -X /home/roman/nodiff linux-2.5.52.org/include/linux/init.h linux-2.5.52/include/linux/init.h
--- linux-2.5.52.org/include/linux/init.h	2002-12-16 03:07:43.000000000 +0100
+++ linux-2.5.52/include/linux/init.h	2002-12-20 23:13:10.000000000 +0100
@@ -147,12 +147,14 @@
 #define module_init(initfn)					\
 	static inline initcall_t __inittest(void)		\
 	{ return initfn; }					\
+	int init_module(void) __attribute__((alias(#initfn)));	\
 	int __initfn(void) __attribute__((alias(#initfn)));

 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __exittest(void)		\
 	{ return exitfn; }					\
+	void cleanup_module(void) __attribute__((alias(#exitfn))); \
 	void __exitfn(void) __attribute__((alias(#exitfn)));


diff -ur -X /home/roman/nodiff linux-2.5.52.org/include/linux/module.h linux-2.5.52/include/linux/module.h
--- linux-2.5.52.org/include/linux/module.h	2002-12-16 03:08:14.000000000 +0100
+++ linux-2.5.52/include/linux/module.h	2002-12-21 01:50:27.000000000 +0100
@@ -40,6 +40,12 @@
 	char name[MODULE_NAME_LEN];
 };

+struct module_symbol
+{
+	unsigned long value;
+	const char *name;
+};
+
 #ifdef MODULE

 #ifdef KBUILD_MODNAME
@@ -80,7 +86,7 @@
 	struct module *owner;

 	unsigned int num_syms;
-	const struct kernel_symbol *syms;
+	const struct module_symbol *syms;
 };

 struct exception_table
@@ -99,11 +105,13 @@
 #define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))

 /* For every exported symbol, place a struct in the __ksymtab section */
-#define EXPORT_SYMBOL(sym)				\
-	const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab")))		\
-	= { (unsigned long)&sym, MODULE_SYMBOL_PREFIX #sym }
-
+#define __EXPORT_SYMBOL(sym, str)			\
+static const char __kstrtab_##sym[]			\
+__attribute__((section(".kstrtab"))) = str;		\
+const struct module_symbol __ksymtab_##sym		\
+__attribute__((section("__ksymtab"))) =			\
+{ (unsigned long)&sym, __kstrtab_##sym }
+#define EXPORT_SYMBOL(var) __EXPORT_SYMBOL(var, __stringify(var))
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)

@@ -117,6 +125,7 @@
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+	MODULE_STATE_CREATE,
 };

 struct module
@@ -310,7 +319,8 @@
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type };
+{ __stringify(var), type };	\
+const char __module_parm_##var[] __attribute__((section(".modinfo"))) = "parm_" __MODULE_STRING(var) "=" type

 #else
 #define MODULE_PARM(var,type)
@@ -345,8 +355,8 @@
 /* Old-style "I'll just call it init_module and it'll be run at
    insert".  Use module_init(myroutine) instead. */
 #ifdef MODULE
-#define init_module(voidarg) __initfn(void)
-#define cleanup_module(voidarg) __exitfn(void)
+//#define init_module(voidarg) __initfn(void)
+//#define cleanup_module(voidarg) __exitfn(void)
 #endif

 /*
@@ -365,4 +375,10 @@
 extern const void *inter_module_get_request(const char *, const char *);
 extern void inter_module_put(const char *);

+#ifdef MODULE
+#include <linux/version.h>
+static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
+"kernel_version=" UTS_RELEASE;
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff -ur -X /home/roman/nodiff linux-2.5.52.org/include/linux/moduleparam.h linux-2.5.52/include/linux/moduleparam.h
--- linux-2.5.52.org/include/linux/moduleparam.h	2002-12-16 03:07:55.000000000 +0100
+++ linux-2.5.52/include/linux/moduleparam.h	2002-12-21 02:09:15.000000000 +0100
@@ -53,8 +53,13 @@
 	param_check_##type(name, &(value));				   \
 	module_param_call(name, param_set_##type, param_get_##type, &value, perm)

+#define __module_const_int "i"
+
 #define module_param(name, type, perm)				\
-	module_param_named(name, name, type, perm)
+	module_param_named(name, name, type, perm);		\
+	const char __module_parm_##name[]			\
+	__attribute__((section(".modinfo"))) =			\
+	"parm_" __stringify(name) "=" __module_const_##type

 /* Actually copy string: maxlen param is usually sizeof(string). */
 #define module_param_string(name, string, len, perm)			\
diff -ur -X /home/roman/nodiff linux-2.5.52.org/kernel/extable.c linux-2.5.52/kernel/extable.c
--- linux-2.5.52.org/kernel/extable.c	2002-12-16 03:07:52.000000000 +0100
+++ linux-2.5.52/kernel/extable.c	2002-12-20 17:21:18.000000000 +0100
@@ -33,7 +33,7 @@
 LIST_HEAD(symbols);

 static struct exception_table kernel_extable;
-static struct kernel_symbol_group kernel_symbols;
+struct kernel_symbol_group kernel_symbols;

 void __init extable_init(void)
 {
diff -ur -X /home/roman/nodiff linux-2.5.52.org/kernel/module.c linux-2.5.52/kernel/module.c
--- linux-2.5.52.org/kernel/module.c	2002-12-16 03:08:13.000000000 +0100
+++ linux-2.5.52/kernel/module.c	2002-12-21 00:51:12.000000000 +0100
@@ -1221,6 +1221,9 @@
 	else return ptr;
 }

+struct module_old;
+static struct module *sys_init_module_old(const char *name_user, struct module_old *mod_user);
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void *umod,
@@ -1228,7 +1231,7 @@
 		const char *uargs)
 {
 	struct module *mod;
-	int ret;
+	int ret, tmp;

 	/* Must have permission */
 	if (!capable(CAP_SYS_MODULE))
@@ -1238,6 +1241,15 @@
 	if (down_interruptible(&module_mutex) != 0)
 		return -EINTR;

+	if (!get_user(tmp, (int *)umod) && memcmp(&tmp, ELFMAG, 4)) {
+		mod = sys_init_module_old((const char *)umod, (struct module_old *)len);
+		if (IS_ERR(mod)) {
+			up(&module_mutex);
+			return PTR_ERR(mod);
+		}
+		goto cont_load;
+	}
+
 	/* Do all the hard work */
 	mod = load_module(umod, len, uargs);
 	if (IS_ERR(mod)) {
@@ -1250,6 +1262,8 @@
 		flush_icache_range((unsigned long)mod->module_init,
 				   (unsigned long)mod->module_init
 				   + mod->init_size);
+	list_add(&mod->list, &modules);
+cont_load:
 	flush_icache_range((unsigned long)mod->module_core,
 			   (unsigned long)mod->module_core + mod->core_size);

@@ -1259,7 +1273,6 @@
 	list_add(&mod->extable.list, &extables);
 	list_add_tail(&mod->symbols.list, &symbols);
 	spin_unlock_irq(&modlist_lock);
-	list_add(&mod->list, &modules);

 	/* Drop lock so they can recurse */
 	up(&module_mutex);
@@ -1412,3 +1425,352 @@
 /* Obsolete lvalue for broken code which asks about usage */
 int module_dummy_usage = 1;
 EXPORT_SYMBOL(module_dummy_usage);
+
+#define MOD_UNINITIALIZED	0
+#define MOD_RUNNING		1
+#define MOD_DELETED		2
+#define MOD_AUTOCLEAN		4
+#define MOD_VISITED		8
+#define MOD_USED_ONCE		16
+#define MOD_JUST_FREED		32
+#define MOD_INITIALIZING	64
+
+#define QM_MODULES	1
+#define QM_DEPS		2
+#define QM_REFS		3
+#define QM_SYMBOLS	4
+#define QM_INFO		5
+
+struct module_ref_old
+{
+	struct module_old *dep;	/* "parent" pointer */
+	struct module_old *ref;	/* "child" pointer */
+	struct module_ref_old *next_ref;
+};
+
+struct module_old
+{
+	unsigned long size_of_struct;	/* == sizeof(module) */
+	struct module_old *next;
+	const char *name;
+	unsigned long size;
+
+	union
+	{
+		atomic_t usecount;
+		long pad;
+	} uc;				/* Needs to keep its size - so says rth */
+
+	unsigned long flags;		/* AUTOCLEAN et al */
+
+	unsigned nsyms;
+	unsigned ndeps;
+
+	struct module_symbol *syms;
+	struct module_ref_old *deps;
+	struct module_ref_old *refs;
+	int (*init)(void);
+	void (*cleanup)(void);
+	const struct exception_table_entry *ex_table_start;
+	const struct exception_table_entry *ex_table_end;
+#ifdef __alpha__
+	unsigned long gp;
+#endif
+	/* Members past this point are extensions to the basic
+	   module support and are optional.  Use mod_member_present()
+	   to examine them.  */
+	const struct module_persist *persist_start;
+	const struct module_persist *persist_end;
+	int (*can_unload)(void);
+	int runsize;			/* In modutils, not currently used */
+	const char *kallsyms_start;	/* All symbols for kernel debugging */
+	const char *kallsyms_end;
+	const char *archdata_start;	/* arch specific data for module */
+	const char *archdata_end;
+	const char *kernel_data;	/* Reserved for kernel internal use */
+};
+
+struct module_info
+{
+	unsigned long addr;
+	unsigned long size;
+	unsigned long flags;
+	long usecount;
+};
+
+static int qm_modules(char *buf, size_t bufsize, size_t *ret)
+{
+	struct module *mod;
+	size_t nmod, space, len;
+	int res = 0;
+
+	nmod = space = 0;
+	list_for_each_entry(mod, &modules, list) {
+		nmod++;
+		len = strlen(mod->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -ENOSPC;
+			continue;
+		}
+		if (copy_to_user(buf, mod->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+	}
+	return put_user(res ? space : nmod, ret) ? -EFAULT : res;
+}
+
+static int qm_deps(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	struct module *mod2;
+	size_t ndeps, space, len;
+	int res = 0;
+
+	ndeps = space = 0;
+	list_for_each_entry(mod2, &modules, list) {
+		if (!already_uses(mod, mod2))
+			continue;
+		len = strlen(mod2->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -EFAULT;
+			continue;
+		}
+		if (copy_to_user(buf, mod2->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+		ndeps++;
+	}
+	return put_user(res ? space : ndeps, ret) ? -EFAULT : res;
+}
+
+static int qm_refs(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	size_t nrefs, space, len;
+	struct module_use *use;
+	int res = 0;
+
+	if (!mod)
+		return -EINVAL;
+
+	nrefs = space = 0;
+	list_for_each_entry(use, &mod->modules_which_use_me, list) {
+		len = strlen(use->module_which_uses->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -EFAULT;
+			continue;
+		}
+		if (copy_to_user(buf, use->module_which_uses->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+		nrefs++;
+	}
+	return put_user(res ? space : nrefs, ret) ? -EFAULT : res;
+}
+
+static int qm_symbols(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	extern struct kernel_symbol_group kernel_symbols;
+	struct kernel_symbol_group *syms;
+	const struct module_symbol *s;
+	char *strings;
+	unsigned long *vals;
+	size_t space, len;
+	int i, res = 0;
+
+	syms = mod ? &mod->symbols : &kernel_symbols;
+	space = syms->num_syms * 2 * sizeof(void *);
+
+	vals = (unsigned long *)buf;
+	strings = buf + space;
+	if (space > bufsize) {
+		res = -ENOSPC;
+		bufsize = 0;
+	} else
+		bufsize -= space;
+
+	for (s = syms->syms, i = 0; i < syms->num_syms; s++, i++) {
+		len = strlen(s->name) + 1;
+		if (len > bufsize) {
+			space += len;
+			bufsize = 0;
+			res = -ENOSPC;
+			continue;
+		}
+		if (copy_to_user(strings, s->name, len)
+		    || put_user(s->value, vals)
+		    || put_user(space, vals + 1))
+			return -EFAULT;
+		space += len;
+		strings += len;
+		vals += 2;
+		bufsize -= len;
+	}
+	return put_user(res ? space : i, ret) ? -EFAULT : res;
+}
+
+static int qm_info(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	int res = 0;
+
+	if (!mod)
+		return -EINVAL;
+
+	if (sizeof(struct module_info) <= bufsize) {
+		struct module_info info;
+		info.addr = (unsigned long)mod->module_core;
+		info.size = mod->core_size;
+		switch (mod->state) {
+		case MODULE_STATE_LIVE:
+			info.flags = MOD_RUNNING;
+			break;
+		case MODULE_STATE_COMING:
+			info.flags = MOD_UNINITIALIZED;
+			break;
+		case MODULE_STATE_GOING:
+			info.flags = MOD_DELETED;
+			break;
+		case MODULE_STATE_CREATE:
+			info.flags = MOD_INITIALIZING;
+			break;
+		}
+		info.usecount = module_refcount(mod);
+		if (copy_to_user(buf, &info, sizeof(struct module_info)))
+			return -EFAULT;
+	} else
+		res = -ENOSPC;
+
+	return put_user(sizeof(struct module_info), ret) ? -EFAULT : res;
+}
+
+int sys_query_module(const char *name_user, int which, char *buf,
+		     size_t bufsize, size_t *ret)
+{
+	struct module *mod = NULL;
+	char name[MODULE_NAME_LEN] = "";
+	int res;
+
+	down(&module_mutex);
+	if (name_user) {
+		if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0) {
+			res = -EFAULT;
+			goto out;
+		}
+		name[MODULE_NAME_LEN-1] = '\0';
+
+		mod = find_module(name);
+		if (!mod) {
+			res = -ENOENT;
+			goto out;
+		}
+	}
+
+	switch (which) {
+	case 0:
+		res = 0;
+		break;
+	case QM_MODULES:
+		res = qm_modules(buf, bufsize, ret);
+		break;
+	case QM_DEPS:
+		res = qm_deps(mod, buf, bufsize, ret);
+		break;
+	case QM_REFS:
+		res = qm_refs(mod, buf, bufsize, ret);
+		break;
+	case QM_SYMBOLS:
+		res = qm_symbols(mod, buf, bufsize, ret);
+		break;
+	case QM_INFO:
+		res = qm_info(mod, buf, bufsize, ret);
+		break;
+	default:
+		res = -EINVAL;
+	}
+out:
+	up(&module_mutex);
+	return res;
+}
+
+unsigned long sys_create_module(const char *name_user, size_t size)
+{
+	char name[MODULE_NAME_LEN];
+	struct module *mod;
+	char *data = NULL;
+	int res = 0;
+
+	if (!capable(CAP_SYS_MODULE))
+		return -EPERM;
+	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
+		return -EFAULT;
+	name[MODULE_NAME_LEN-1] = '\0';
+
+	down(&module_mutex);
+	mod = find_module(name);
+	if (mod) {
+		res = -EEXIST;
+		goto out;
+	}
+	data = module_alloc(sizeof(*mod) + size);
+	if (!data) {
+		res = -ENOMEM;
+		goto out;
+	}
+	mod = (struct module *)(data + size);
+	memset(mod, 0, sizeof(*mod));
+	module_unload_init(mod);
+	mod->state = MODULE_STATE_CREATE;
+	strcpy(mod->name, name);
+	mod->module_core = data;
+	mod->core_size = size;
+
+	list_add(&mod->list, &modules);
+out:
+	up(&module_mutex);
+
+	return res ? res : (unsigned long)data;
+}
+
+static struct module *sys_init_module_old(const char *name_user, struct module_old *mod_user)
+{
+	char name[MODULE_NAME_LEN];
+	struct module *mod;
+	struct module_old *oldmod;
+	struct module_ref_old *dep;
+	int i;
+
+	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
+		return ERR_PTR(-EFAULT);
+	name[MODULE_NAME_LEN-1] = '\0';
+
+	mod = find_module(name);
+	if (!mod)
+		return ERR_PTR(-ENOENT);
+
+	if (copy_from_user(mod->module_core, mod_user, mod->core_size))
+		return ERR_PTR(-EFAULT);
+
+	oldmod = mod->module_core;
+	oldmod->size = mod->core_size;
+	mod->init = oldmod->init;
+	mod->exit = oldmod->cleanup;
+	mod->extable.entry = oldmod->ex_table_start;
+	mod->extable.num_entries = oldmod->ex_table_end - oldmod->ex_table_start;
+	mod->symbols.num_syms = oldmod->nsyms;
+	mod->symbols.syms = oldmod->syms;
+	mod->state = MODULE_STATE_COMING;
+
+	for (i = 0, dep = oldmod->deps; i < oldmod->ndeps; ++i, ++dep) {
+		struct module *mod2 = (struct module *)((char *)dep->dep + dep->dep->size);
+		use_module(mod, mod2);
+	}
+
+	return mod;
+}

