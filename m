Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSGXUAd>; Wed, 24 Jul 2002 16:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGXUAd>; Wed, 24 Jul 2002 16:00:33 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:29701 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317495AbSGXT7b>; Wed, 24 Jul 2002 15:59:31 -0400
Date: Wed, 24 Jul 2002 22:02:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] new module interface
Message-ID: <Pine.LNX.4.44.0207242128030.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below is for 2.4 but it's easily ported to 2.5, beside of this I
think the core is stable and will allow a more flexible module handling
in the future. After updating to 2.5 and updating some more archs I will
submit the patch officially, so any feedback now would be very welcome.
(The patch requires no new modutils, although a new version could avoid
some workarounds, but that can wait.)

This patch implements a new module interface. The most important change is
probably that the usercount is not part of the module structure anymore.
If the module code needs it, it asks the module for it. That count doesn't
has to be accurate, only the return value of the exit functions decides
about the unloading of the module.
This also means no kernel structures have to be polluted with module
pointers, the module structure is basically now private to the module
code, no normal module needs to mess with it. This also means
MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT/MOD_IN_USE are now finally really
obsolete. Modules have to maintain their own usecount, but this usually
less painful than using a module pointer (see fs example below). In other
situation such a count already exists, e.g. a proc like interface could
use the i_count field of the inode (stop() unlinks the entry, exit()
would test if i_count became 1).
Below I converted affs and the fs code to demonstrate the new interface.
So a module is defined like this:

DEFINE_MODULE
	.start =	start_affs_fs,
	.stop =		stop_affs_fs,
	.exit =		exit_affs_fs,
	.usecount =	usecount_affs_fs,
DEFINE_MODULE_END

This defines a structure, which is automatically registered at module
init. A structure is more flexible than lots of function entries. insmod
has to know about all these functions, where as above structure is
automatically initialized when the module is linked. New fields can be
added easily, e.g. new fixup sections can be added without bothering
insmod.
On the other hand the old interfaces still work (even a direct
init_module() call), it's just not possible to unload such modules.

One user visible difference is that /proc/modules now includes builtin
modules. It requires a small kbuild change, as it needs unique module
names. I'm not completely happy with this part yet, but it shows what is
basically possible. More important is the difference between builtin
modules and loaded modules becomes less.

Some more boring implementation details:
- get_kernel_syms syscall is gone, it's not needed by modutils anymore,
  only klogd is still using it, but it can live without it and should
  rather be updated.
- new macros mod_for_each_locked/mod_for_done_locked to iterate over the
  modules list
- __MODULE_STRING is replaced with __stringify
- BKL is replaced with a semaphore
- get_mod_name/put_mod_name is replaced with getname/putname

bye, Roman

Index: Rules.make
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/Rules.make,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 Rules.make
--- Rules.make	2002/03/12 13:09:42	1.1.1.8
+++ Rules.make	2002/07/24 10:06:19
@@ -44,6 +44,7 @@ SUB_DIRS	:= $(subdir-y)
 MOD_SUB_DIRS	:= $(sort $(subdir-m) $(both-m))
 ALL_SUB_DIRS	:= $(sort $(subdir-y) $(subdir-m) $(subdir-n) $(subdir-))

+KBUILD_BASEDIR	:= $(subst /,_,$(subst -,_,$(subst $(TOPDIR)/,,$(shell /bin/pwd))))

 #
 # Common rules
@@ -56,7 +57,7 @@ ALL_SUB_DIRS	:= $(sort $(subdir-y) $(sub
 	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@

 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(KBUILD_BASEDIR)_$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@))),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@))))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
@@ -272,7 +273,7 @@ endif # CONFIG_MODVERSIONS

 ifneq "$(strip $(export-objs))" ""
 $(export-objs): $(export-objs:.o=.c) $(TOPDIR)/include/linux/modversions.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(KBUILD_BASEDIR)_$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB)),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@) -DEXPORT_SYMTAB)))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
Index: arch/i386/kernel/entry.S
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/arch/i386/kernel/entry.S,v
retrieving revision 1.1.1.14
diff -u -p -r1.1.1.14 entry.S
--- arch/i386/kernel/entry.S	2002/03/12 13:09:49	1.1.1.14
+++ arch/i386/kernel/entry.S	2002/07/24 10:06:19
@@ -526,7 +526,7 @@ ENTRY(sys_call_table)
 	.long SYMBOL_NAME(sys_create_module)
 	.long SYMBOL_NAME(sys_init_module)
 	.long SYMBOL_NAME(sys_delete_module)
-	.long SYMBOL_NAME(sys_get_kernel_syms)	/* 130 */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* 130 */		/* old get_kernel_syms syscall */
 	.long SYMBOL_NAME(sys_quotactl)
 	.long SYMBOL_NAME(sys_getpgid)
 	.long SYMBOL_NAME(sys_fchdir)
Index: arch/i386/kernel/traps.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.19
diff -u -p -r1.1.1.19 traps.c
--- arch/i386/kernel/traps.c	2001/10/18 14:09:04	1.1.1.19
+++ arch/i386/kernel/traps.c	2002/07/24 10:06:19
@@ -94,21 +94,19 @@ int kstack_depth_to_print = 24;
  * be the address of a calling routine
  */

-#ifdef CONFIG_MODULES
-
-extern struct module *module_list;
-extern struct module kernel_module;
-
 static inline int kernel_text_address(unsigned long addr)
 {
 	int retval = 0;
+#ifdef CONFIG_MODULES
 	struct module *mod;
+#endif

 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;

-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+#ifdef CONFIG_MODULES
+	mod_for_each_locked(mod) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
 		 * module area. Of course it'd be better to test only
 		 * for the .text subset... */
@@ -116,20 +114,11 @@ static inline int kernel_text_address(un
 			retval = 1;
 			break;
 		}
-	}
+	} mod_for_done_locked
+#endif

 	return retval;
 }
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

 void show_trace(unsigned long * stack)
 {
Index: arch/i386/mm/extable.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/arch/i386/mm/extable.c,v
retrieving revision 1.1.1.4
diff -u -p -r1.1.1.4 extable.c
--- arch/i386/mm/extable.c	2001/10/18 13:38:54	1.1.1.4
+++ arch/i386/mm/extable.c	2002/07/24 10:06:19
@@ -15,7 +15,7 @@ search_one_table(const struct exception_
 		 const struct exception_table_entry *last,
 		 unsigned long value)
 {
-        while (first <= last) {
+        while (first < last) {
 		const struct exception_table_entry *mid;
 		long diff;

@@ -31,32 +31,24 @@ search_one_table(const struct exception_
         return 0;
 }

-extern spinlock_t modlist_lock;
-
 unsigned long
 search_exception_table(unsigned long addr)
 {
-	unsigned long ret = 0;

 #ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
-	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
-	return ret;
+	return search_one_table(__start___ex_table, __stop___ex_table, addr);
 #else
-	unsigned long flags;
-	/* The kernel is the last "module" -- no need to treat it special.  */
+	unsigned long ret = 0;
 	struct module *mp;

-	spin_lock_irqsave(&modlist_lock, flags);
-	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (mp->ex_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
-			continue;
+	mod_for_each_locked(mp) {
 		ret = search_one_table(mp->ex_table_start,
-				       mp->ex_table_end - 1, addr);
+				       mp->ex_table_end, addr);
 		if (ret)
 			break;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	} mod_for_done_locked
+
 	return ret;
 #endif
 }
Index: fs/dnotify.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/fs/dnotify.c,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 dnotify.c
--- fs/dnotify.c	2000/12/05 11:46:49	1.1.1.2
+++ fs/dnotify.c	2002/07/24 10:06:19
@@ -13,6 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  */
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/dnotify.h>
Index: fs/fcntl.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/fs/fcntl.c,v
retrieving revision 1.1.1.10
diff -u -p -r1.1.1.10 fcntl.c
--- fs/fcntl.c	2001/10/18 13:40:46	1.1.1.10
+++ fs/fcntl.c	2002/07/24 10:06:19
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */

+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/file.h>
Index: fs/locks.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/fs/locks.c,v
retrieving revision 1.1.1.13
diff -u -p -r1.1.1.13 locks.c
--- fs/locks.c	2001/10/24 09:03:18	1.1.1.13
+++ fs/locks.c	2002/07/24 10:06:19
@@ -115,6 +115,7 @@
  *  Stephen Rothwell <sfr@canb.auug.org.au>, June, 2000.
  */

+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/smp_lock.h>
Index: fs/super.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/fs/super.c,v
retrieving revision 1.1.1.24
diff -u -p -r1.1.1.24 super.c
--- fs/super.c	2002/03/12 13:11:52	1.1.1.24
+++ fs/super.c	2002/07/24 10:06:19
@@ -73,14 +73,12 @@ static rwlock_t file_systems_lock = RW_L
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
 {
-	if (fs->owner)
-		__MOD_INC_USE_COUNT(fs->owner);
+	atomic_inc(&fs->usecount);
 }

 static void put_filesystem(struct file_system_type *fs)
 {
-	if (fs->owner)
-		__MOD_DEC_USE_COUNT(fs->owner);
+	atomic_dec(&fs->usecount);
 }

 static struct file_system_type **find_filesystem(const char *name)
@@ -187,8 +185,10 @@ static int fs_name(unsigned int index, c

 	read_lock(&file_systems_lock);
 	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
-		if (index <= 0 && try_inc_mod_count(tmp->owner))
-				break;
+		if (index <= 0) {
+			get_filesystem(tmp);
+			break;
+		}
 	read_unlock(&file_systems_lock);
 	if (!tmp)
 		return -EINVAL;
@@ -258,14 +258,14 @@ struct file_system_type *get_fs_type(con

 	read_lock(&file_systems_lock);
 	fs = *(find_filesystem(name));
-	if (fs && !try_inc_mod_count(fs->owner))
-		fs = NULL;
+	if (fs)
+		get_filesystem(fs);
 	read_unlock(&file_systems_lock);
 	if (!fs && (request_module(name) == 0)) {
 		read_lock(&file_systems_lock);
 		fs = *(find_filesystem(name));
-		if (fs && !try_inc_mod_count(fs->owner))
-			fs = NULL;
+		if (fs)
+			get_filesystem(fs);
 		read_unlock(&file_systems_lock);
 	}
 	return fs;
Index: fs/affs/super.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/fs/affs/super.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 super.c
--- fs/affs/super.c	2002/03/12 13:11:52	1.1.1.8
+++ fs/affs/super.c	2002/07/24 11:42:41
@@ -492,20 +492,35 @@ affs_statfs(struct super_block *sb, stru

 static DECLARE_FSTYPE_DEV(affs_fs_type, "affs", affs_read_super);

-static int __init init_affs_fs(void)
+static int __init start_affs_fs(void)
 {
 	return register_filesystem(&affs_fs_type);
 }

-static void __exit exit_affs_fs(void)
+static int stop_affs_fs(void)
 {
-	unregister_filesystem(&affs_fs_type);
+	return unregister_filesystem(&affs_fs_type);
 }

+static int __exit exit_affs_fs(void)
+{
+	return atomic_read(&affs_fs_type.usecount) ? -EBUSY : 0;
+}
+
+static int usecount_affs_fs(void)
+{
+	return atomic_read(&affs_fs_type.usecount);
+}
+
+DEFINE_MODULE
+	.start =	start_affs_fs,
+	.stop =		stop_affs_fs,
+	.exit =		exit_affs_fs,
+	.usecount =	usecount_affs_fs,
+DEFINE_MODULE_END
+
 EXPORT_NO_SYMBOLS;

 MODULE_DESCRIPTION("Amiga filesystem support for Linux");
 MODULE_LICENSE("GPL");

-module_init(init_affs_fs)
-module_exit(exit_affs_fs)
Index: include/linux/fs.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/include/linux/fs.h,v
retrieving revision 1.1.1.30
diff -u -p -r1.1.1.30 fs.h
--- include/linux/fs.h	2002/03/12 13:13:10	1.1.1.30
+++ include/linux/fs.h	2002/07/24 10:14:18
@@ -951,7 +951,7 @@ struct file_system_type {
 	const char *name;
 	int fs_flags;
 	struct super_block *(*read_super) (struct super_block *, void *, int);
-	struct module *owner;
+	atomic_t usecount;
 	struct file_system_type * next;
 	struct list_head fs_supers;
 };
@@ -961,7 +961,7 @@ struct file_system_type var = { \
 	name:		type, \
 	read_super:	read, \
 	fs_flags:	flags, \
-	owner:		THIS_MODULE, \
+	usecount:	ATOMIC_INIT(0), \
 }

 #define DECLARE_FSTYPE_DEV(var,type,read) \
Index: include/linux/init.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/include/linux/init.h,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 init.h
--- include/linux/init.h	2002/01/08 13:14:55	1.1.1.8
+++ include/linux/init.h	2002/07/24 10:06:20
@@ -88,29 +88,6 @@ extern struct kernel_param __setup_start
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"

-/**
- * module_init() - driver initialization entry point
- * @x: function to be run at kernel boot time or module insertion
- *
- * module_init() will add the driver initialization routine in
- * the "__initcall.int" code segment if the driver is checked as
- * "y" or static, or else it will wrap the driver initialization
- * routine with init_module() which is used by insmod and
- * modprobe when the driver is used as a module.
- */
-#define module_init(x)	__initcall(x);
-
-/**
- * module_exit() - driver exit entry point
- * @x: function to be run when driver is removed
- *
- * module_exit() will wrap the driver clean-up code
- * with cleanup_module() when used with rmmod when
- * the driver is a module.  If the driver is statically
- * compiled into the kernel, module_exit() has no effect.
- */
-#define module_exit(x)	__exitcall(x);
-
 #else	/* MODULE */

 #define __init
@@ -122,22 +99,6 @@ extern struct kernel_param __setup_start
 #define __INIT
 #define __FINIT
 #define __INITDATA
-
-/* These macros create a dummy inline: gcc 2.9x does not count alias
- as usage, hence the `unused function' warning when __init functions
- are declared static. We use the dummy __*_module_inline functions
- both to kill the warning and check the type of the init/cleanup
- function. */
-typedef int (*__init_module_func_t)(void);
-typedef void (*__cleanup_module_func_t)(void);
-#define module_init(x) \
-	int init_module(void) __attribute__((alias(#x))); \
-	static inline __init_module_func_t __init_module_inline(void) \
-	{ return x; }
-#define module_exit(x) \
-	void cleanup_module(void) __attribute__((alias(#x))); \
-	static inline __cleanup_module_func_t __cleanup_module_inline(void) \
-	{ return x; }

 #define __setup(str,func) /* nothing */

Index: include/linux/module.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/include/linux/module.h,v
retrieving revision 1.1.1.11
diff -u -p -r1.1.1.11 module.h
--- include/linux/module.h	2001/11/23 09:32:36	1.1.1.11
+++ include/linux/module.h	2002/07/24 10:06:20
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/stringify.h>

 #ifdef __GENKSYMS__
 #  define _set_ver(sym) sym
@@ -50,11 +51,11 @@ struct module_ref
 /* TBD */
 struct module_persist;

-struct module
+struct old_module
 {
 	unsigned long size_of_struct;	/* == sizeof(module) */
 	struct module *next;
-	const char *name;
+	char *name;
 	unsigned long size;

 	union
@@ -71,7 +72,7 @@ struct module
 	struct module_symbol *syms;
 	struct module_ref *deps;
 	struct module_ref *refs;
-	int (*init)(void);
+	int (*init)(struct module *);
 	void (*cleanup)(void);
 	const struct exception_table_entry *ex_table_start;
 	const struct exception_table_entry *ex_table_end;
@@ -92,6 +93,41 @@ struct module
 	const char *kernel_data;	/* Reserved for kernel internal use */
 };

+struct module
+{
+	struct list_head list;
+	char *name;
+	unsigned long size;
+	unsigned long flags;
+
+	atomic_t ref_cnt;
+	struct old_module *old;
+
+	struct module_symbol *syms;
+	unsigned nsyms;
+	struct module_ref *deps;
+	unsigned ndeps;
+	struct module_ref *refs;
+
+	int (*init)(void);
+	int (*exit)(void);
+	int (*start)(void);
+	int (*stop)(void);
+	int (*usecount)(void);
+
+	const struct exception_table_entry *ex_table_start;
+	const struct exception_table_entry *ex_table_end;
+#ifdef __alpha__
+	unsigned long gp;
+#endif
+	const struct module_persist *persist_start;
+	const struct module_persist *persist_end;
+	const char *kallsyms_start;	/* All symbols for kernel debugging */
+	const char *kallsyms_end;
+	const char *archdata_start;	/* arch specific data for module */
+	const char *archdata_end;
+};
+
 struct module_info
 {
 	unsigned long addr;
@@ -102,14 +138,20 @@ struct module_info

 /* Bits of module.flags.  */

-#define MOD_UNINITIALIZED	0
-#define MOD_RUNNING		1
-#define MOD_DELETED		2
-#define MOD_AUTOCLEAN		4
-#define MOD_VISITED  		8
-#define MOD_USED_ONCE		16
-#define MOD_JUST_FREED		32
-#define MOD_INITIALIZING	64
+#define MOD_LOCKED		0
+#define MOD_LOADED		1
+#define MOD_INITIALIZED		2
+#define MOD_RUNNING		3
+#define MOD_BUILTIN		4
+#define MOD_AUTOCLEAN		5
+#define MOD_ALLOCED		6
+#define MOD_OLDSTYLE		7
+
+#define OLD_MOD_RUNNING		1
+#define OLD_MOD_DELETED		2
+#define OLD_MOD_AUTOCLEAN	4
+#define OLD_MOD_USED_ONCE	16
+#define OLD_MOD_INITIALIZING	64

 /* Values for query_module's which.  */

@@ -119,16 +161,11 @@ struct module_info
 #define QM_SYMBOLS	4
 #define QM_INFO		5

-/* Can the module be queried? */
-#define MOD_CAN_QUERY(mod) (((mod)->flags & (MOD_RUNNING | MOD_INITIALIZING)) && !((mod)->flags & MOD_DELETED))
-
 /* When struct module is extended, we must test whether the new member
    is present in the header received from insmod before we can use it.
    This function returns true if the member is present.  */

-#define mod_member_present(mod,member) 					\
-	((unsigned long)(&((struct module *)0L)->member + 1)		\
-	 <= (mod)->size_of_struct)
+#define mod_member_present(mod,member) 1

 /*
  * Ditto for archdata.  Assumes mod->archdata_start and mod->archdata_end
@@ -138,31 +175,22 @@ struct module_info
 	(((unsigned long)(&((type *)0L)->member) +			\
 	  sizeof(((type *)0L)->member)) <=				\
 	 ((mod)->archdata_end - (mod)->archdata_start))
-

+
 /* Check if an address p with number of entries n is within the body of module m */
-#define mod_bound(p, n, m) ((unsigned long)(p) >= ((unsigned long)(m) + ((m)->size_of_struct)) && \
-	         (unsigned long)((p)+(n)) <= (unsigned long)(m) + (m)->size)
+#define mod_bound(p, n, m) ((unsigned long)(p) >= ((unsigned long)(m)->old + (sizeof(struct module))) && \
+	         (unsigned long)((p)+(n)) < (unsigned long)(m)->old + (m)->size)

 /* Backwards compatibility definition.  */

-#define GET_USE_COUNT(module)	(atomic_read(&(module)->uc.usecount))
+#define GET_USE_COUNT(module)	(-1)

 /* Poke the use count of a module.  */
-
-#define __MOD_INC_USE_COUNT(mod)					\
-	(atomic_inc(&(mod)->uc.usecount), (mod)->flags |= MOD_VISITED|MOD_USED_ONCE)
-#define __MOD_DEC_USE_COUNT(mod)					\
-	(atomic_dec(&(mod)->uc.usecount), (mod)->flags |= MOD_VISITED)
-#define __MOD_IN_USE(mod)						\
-	(mod_member_present((mod), can_unload) && (mod)->can_unload	\
-	 ? (mod)->can_unload() : atomic_read(&(mod)->uc.usecount))

-/* Indirect stringification.  */
+#define __MOD_INC_USE_COUNT(mod)	((void)0)
+#define __MOD_DEC_USE_COUNT(mod)	((void)0)
+#define __MOD_IN_USE(mod)		(-1)

-#define __MODULE_STRING_1(x)	#x
-#define __MODULE_STRING(x)	__MODULE_STRING_1(x)
-
 /* Generic inter module communication.
  *
  * NOTE: This interface is intended for small amounts of data that are
@@ -192,8 +220,32 @@ struct inter_module_entry {
 	struct module *owner;
 	const void *userdata;
 };
+
+#define try_inc_mod_count(mod)	(1)
+
+#define ___concat(x, y)		x ## y
+#define __concat(x, y)		___concat(x, y)

-extern int try_inc_mod_count(struct module *mod);
+#define __THIS_MODULE		__concat(__this_module_, KBUILD_BASENAME)
+extern struct module __THIS_MODULE;
+
+extern int init_module_hack(struct module *, struct module *);
+
+#define mod_for_each_locked(mod)				\
+{								\
+	unsigned long flags;					\
+	struct list_head *list;					\
+								\
+	spin_lock_irqsave(&modlist_lock, flags);		\
+	list_for_each(list, &module_list) {			\
+		mod = list_entry(list, struct module, list);	\
+		if (!test_bit(MOD_LOADED, &mod->flags))		\
+			continue;
+#define mod_for_done_locked					\
+	}							\
+	spin_unlock_irqrestore(&modlist_lock, flags);		\
+}
+
 #endif /* __KERNEL__ */

 #if defined(MODULE) && !defined(__GENKSYMS__)
@@ -232,12 +284,12 @@ const char __module_device[] __attribute
 #define MODULE_PARM(var,type)			\
 const char __module_parm_##var[]		\
 __attribute__((section(".modinfo"))) =		\
-"parm_" __MODULE_STRING(var) "=" type
+"parm_" __stringify(var) "=" type

 #define MODULE_PARM_DESC(var,desc)		\
 const char __module_parm_desc_##var[]		\
 __attribute__((section(".modinfo"))) =		\
-"parm_desc_" __MODULE_STRING(var) "=" desc
+"parm_desc_" __stringify(var) "=" desc

 /*
  * MODULE_DEVICE_TABLE exports information about devices
@@ -287,9 +339,24 @@ static const char __module_license[] __a
 "license=" license

 /* Define the module variable, and usage macros.  */
-extern struct module __this_module;
+extern struct old_module __this_module;

-#define THIS_MODULE		(&__this_module)
+#define DEFINE_MODULE				\
+int __init init_module(struct module *m)	\
+{ return init_module_hack(m, THIS_MODULE); }	\
+struct module __THIS_MODULE = {			\
+	.old =		&__this_module,
+#define DEFINE_MODULE_END \
+};
+
+#define module_init(x)	 			\
+DEFINE_MODULE					\
+	.flags =	(1 << MOD_OLDSTYLE),	\
+	.init =		x,			\
+DEFINE_MODULE_END
+#define module_exit(x)
+
+#define THIS_MODULE		(&__THIS_MODULE)
 #define MOD_INC_USE_COUNT	__MOD_INC_USE_COUNT(THIS_MODULE)
 #define MOD_DEC_USE_COUNT	__MOD_DEC_USE_COUNT(THIS_MODULE)
 #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
@@ -323,11 +390,31 @@ static const struct gtype##_id * __modul
 #ifndef __GENKSYMS__

 #define THIS_MODULE		NULL
-#define MOD_INC_USE_COUNT	do { } while (0)
-#define MOD_DEC_USE_COUNT	do { } while (0)
+#define MOD_INC_USE_COUNT	((void)0)
+#define MOD_DEC_USE_COUNT	((void)0)
 #define MOD_IN_USE		1
+
+extern int init_builtin_module(struct module *mod);
+
+#define DEFINE_MODULE \
+static int __init __init_module(void)			\
+{ return init_builtin_module(&__THIS_MODULE); }		\
+__initcall(__init_module);				\
+struct module __THIS_MODULE = {				\
+	.name =		__stringify(KBUILD_BASENAME),	\
+	.flags =	(1 << MOD_OLDSTYLE),
+#define DEFINE_MODULE_END \
+};

-extern struct module *module_list;
+#define module_init(x)		\
+DEFINE_MODULE			\
+	.init =		x,	\
+DEFINE_MODULE_END
+#define module_exit(x)
+
+extern struct list_head module_list;
+extern spinlock_t modlist_lock;
+extern struct semaphore modlist_readlock;

 #endif /* !__GENKSYMS__ */

@@ -387,14 +474,14 @@ __attribute__((section("__ksymtab"))) =
 { (unsigned long)&sym, __kstrtab_##sym }

 #if defined(MODVERSIONS) || !defined(CONFIG_MODVERSIONS)
-#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
-#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL_GPL(var, __MODULE_STRING(var))
+#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __stringify(var))
+#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL_GPL(var, __stringify(var))
 #else
-#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
-#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
+#define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __stringify(__VERSIONED_SYMBOL(var)))
+#define EXPORT_SYMBOL_GPL(var)  __EXPORT_SYMBOL(var, __stringify(__VERSIONED_SYMBOL(var)))
 #endif

-#define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
+#define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __stringify(var))

 #endif /* __GENKSYMS__ */

Index: init/main.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/init/main.c,v
retrieving revision 1.1.1.25
diff -u -p -r1.1.1.25 main.c
--- init/main.c	2002/03/12 13:13:33	1.1.1.25
+++ init/main.c	2002/07/24 10:06:20
@@ -12,6 +12,7 @@
 #define __KERNEL_SYSCALLS__

 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/unistd.h>
Index: kernel/ksyms.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/kernel/ksyms.c,v
retrieving revision 1.1.1.30
diff -u -p -r1.1.1.30 ksyms.c
--- kernel/ksyms.c	2002/03/12 13:13:33	1.1.1.30
+++ kernel/ksyms.c	2002/07/24 10:06:20
@@ -78,7 +78,7 @@ EXPORT_SYMBOL(inter_module_unregister);
 EXPORT_SYMBOL(inter_module_get);
 EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);
-EXPORT_SYMBOL(try_inc_mod_count);
+EXPORT_SYMBOL(init_module_hack);

 /* process memory management */
 EXPORT_SYMBOL(do_mmap_pgoff);
Index: kernel/module.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/kernel/module.c,v
retrieving revision 1.1.1.11
diff -u -p -r1.1.1.11 module.c
--- kernel/module.c	2001/11/23 09:32:47	1.1.1.11
+++ kernel/module.c	2002/07/24 10:06:20
@@ -42,18 +42,17 @@ extern const char __stop___kallsyms[] __

 struct module kernel_module =
 {
-	size_of_struct:		sizeof(struct module),
-	name: 			"",
-	uc:	 		{ATOMIC_INIT(1)},
-	flags:			MOD_RUNNING,
-	syms:			__start___ksymtab,
-	ex_table_start:		__start___ex_table,
-	ex_table_end:		__stop___ex_table,
-	kallsyms_start:		__start___kallsyms,
-	kallsyms_end:		__stop___kallsyms,
+	.name =			"kernel",
+	.ref_cnt =	 	ATOMIC_INIT(1),
+	.flags =		(1 << MOD_BUILTIN) | (1 << MOD_LOADED) | (1 << MOD_INITIALIZED) | (1 << MOD_RUNNING),
+	.syms =			__start___ksymtab,
+	.ex_table_start =	__start___ex_table,
+	.ex_table_end =		__stop___ex_table,
+	.kallsyms_start =	__start___kallsyms,
+	.kallsyms_end =		__stop___kallsyms,
 };

-struct module *module_list = &kernel_module;
+LIST_HEAD(module_list);

 #endif	/* defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS) */

@@ -64,20 +63,30 @@ struct module *module_list = &kernel_mod
  */

 static struct list_head ime_list = LIST_HEAD_INIT(ime_list);
-static spinlock_t ime_lock = SPIN_LOCK_UNLOCKED;
 static int kmalloc_failed;

 /*
- *	This lock prevents modifications that might race the kernel fault
- *	fixups. It does not prevent reader walks that the modules code
- *	does. The kernel lock does that.
- *
- *	Since vmalloc fault fixups occur in any context this lock is taken
- *	irqsave at all times.
+ *	modlist_lock prevents modifications that might race the kernel fault
+ *	fixups. It does not prevent other list operations, modlist_readlock
+ *	has to be used for for this.
  */
-
+
+DECLARE_MUTEX(modlist_readlock);
 spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;

+void free_module(struct module *);
+
+static inline void get_module(struct module *mod)
+{
+	atomic_inc(&mod->ref_cnt);
+}
+
+static inline void put_module(struct module *mod)
+{
+	if (atomic_dec_and_test(&mod->ref_cnt))
+		free_module(mod);
+}
+
 /**
  * inter_module_register - register a new set of inter module data.
  * @im_name: an arbitrary string to identify the data, must be unique
@@ -106,19 +115,21 @@ void inter_module_register(const char *i
 	ime_new->owner = owner;
 	ime_new->userdata = userdata;

-	spin_lock(&ime_lock);
+	down(&modlist_readlock);
 	list_for_each(tmp, &ime_list) {
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
-			spin_unlock(&ime_lock);
+			up(&modlist_readlock);
 			kfree(ime_new);
 			/* Program logic error, fatal */
 			printk(KERN_ERR "inter_module_register: duplicate im_name '%s'", im_name);
 			BUG();
 		}
 	}
+	if (owner)
+		get_module(owner);
 	list_add(&(ime_new->list), &ime_list);
-	spin_unlock(&ime_lock);
+	up(&modlist_readlock);
 }

 /**
@@ -134,17 +145,19 @@ void inter_module_unregister(const char
 	struct list_head *tmp;
 	struct inter_module_entry *ime;

-	spin_lock(&ime_lock);
+	down(&modlist_readlock);
 	list_for_each(tmp, &ime_list) {
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
+			if (ime->owner)
+				put_module(ime->owner);
 			list_del(&(ime->list));
-			spin_unlock(&ime_lock);
+			up(&modlist_readlock);
 			kfree(ime);
 			return;
 		}
 	}
-	spin_unlock(&ime_lock);
+	up(&modlist_readlock);
 	if (kmalloc_failed) {
 		printk(KERN_ERR
 			"inter_module_unregister: no entry for '%s', "
@@ -173,16 +186,17 @@ const void *inter_module_get(const char
 	struct inter_module_entry *ime;
 	const void *result = NULL;

-	spin_lock(&ime_lock);
+	down(&modlist_readlock);
 	list_for_each(tmp, &ime_list) {
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
-			if (try_inc_mod_count(ime->owner))
-				result = ime->userdata;
+			if (ime->owner)
+				get_module(ime->owner);
+			result = ime->userdata;
 			break;
 		}
 	}
-	spin_unlock(&ime_lock);
+	up(&modlist_readlock);
 	return(result);
 }

@@ -215,17 +229,17 @@ void inter_module_put(const char *im_nam
 	struct list_head *tmp;
 	struct inter_module_entry *ime;

-	spin_lock(&ime_lock);
+	down(&modlist_readlock);
 	list_for_each(tmp, &ime_list) {
 		ime = list_entry(tmp, struct inter_module_entry, list);
 		if (strcmp(ime->im_name, im_name) == 0) {
 			if (ime->owner)
-				__MOD_DEC_USE_COUNT(ime->owner);
-			spin_unlock(&ime_lock);
+				put_module(ime->owner);
+			up(&modlist_readlock);
 			return;
 		}
 	}
-	spin_unlock(&ime_lock);
+	up(&modlist_readlock);
 	printk(KERN_ERR "inter_module_put: no entry for '%s'", im_name);
 	BUG();
 }
@@ -233,55 +247,125 @@ void inter_module_put(const char *im_nam

 #if defined(CONFIG_MODULES)	/* The rest of the source */

-static long get_mod_name(const char *user_name, char **buf);
-static void put_mod_name(char *buf);
-struct module *find_module(const char *name);
-void free_module(struct module *, int tag_freed);
+int register_module(struct module *);
+void unregister_module(struct module *);

-
 /*
- * Called at boot time
+ * Look for a module by name.
  */

-void __init init_modules(void)
+static struct module *find_module(const char *name)
 {
-	kernel_module.nsyms = __stop___ksymtab - __start___ksymtab;
+	struct module *mod;
+	struct list_head *list;

-	arch_init_modules(&kernel_module);
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
+		mod = list_entry(list, struct module, list);
+		if (!strcmp(name, mod->name)) {
+			get_module(mod);
+			goto found;
+		}
+	}
+	mod = NULL;
+found:
+	up(&modlist_readlock);
+
+	return mod;
+}
+
+static inline int lock_module(struct module *mod)
+{
+	return test_and_set_bit(MOD_LOCKED, &mod->flags);
+}
+
+static inline void unlock_module(struct module *mod)
+{
+	clear_bit(MOD_LOCKED, &mod->flags);
+}
+
+static inline int init_module(struct module *mod)
+{
+	int res = 0;
+
+	//printk("init_module(%p,%lx):", mod, mod->flags);
+	if (!mod->init || !(res = mod->init()))
+		set_bit(MOD_INITIALIZED, &mod->flags);
+	//printk(" %d\n", res);
+	return res;
+}
+
+static inline int exit_module(struct module *mod)
+{
+	int res = 0;
+
+	//printk("exit_module(%p,%lx):", mod, mod->flags);
+	if (!mod->exit || !(res = mod->exit()))
+		clear_bit(MOD_INITIALIZED, &mod->flags);
+	//printk(" %d\n", res);
+	return res;
+}
+
+static inline int start_module(struct module *mod)
+{
+	int res = 0;
+
+	//printk("start_module(%p,%lx):", mod, mod->flags);
+	if (!mod->start || !(res = mod->start()))
+		set_bit(MOD_RUNNING, &mod->flags);
+	//printk(" %d\n", res);
+	return res;
 }

+static inline int stop_module(struct module *mod)
+{
+	int res = 0;
+
+	//printk("stop_module(%p,%lx):", mod, mod->flags);
+	if (!mod->stop || !(res = mod->stop()))
+		clear_bit(MOD_RUNNING, &mod->flags);
+	//printk(" %d\n", res);
+	return res;
+}
+
+static inline int usecount_module(struct module *mod)
+{
+	int res = 0;
+
+	if (mod->usecount)
+		res = mod->usecount();
+	return res;
+}
+
 /*
- * Copy the name of a module from user space.
+ * Called at boot time
  */

-static inline long
-get_mod_name(const char *user_name, char **buf)
+void __init init_modules(void)
 {
-	unsigned long page;
-	long retval;
+	kernel_module.nsyms = __stop___ksymtab - __start___ksymtab;

-	page = __get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	retval = strncpy_from_user((char *)page, user_name, PAGE_SIZE);
-	if (retval > 0) {
-		if (retval < PAGE_SIZE) {
-			*buf = (char *)page;
-			return retval;
-		}
-		retval = -ENAMETOOLONG;
-	} else if (!retval)
-		retval = -EINVAL;
+	list_add_tail(&kernel_module.list, &module_list);

-	free_page(page);
-	return retval;
+	arch_init_modules(&kernel_module);
 }

-static inline void
-put_mod_name(char *buf)
+int __init init_builtin_module(struct module *mod)
 {
-	free_page((unsigned long)buf);
+	int res;
+
+	set_bit(MOD_BUILTIN, &mod->flags);
+	atomic_set(&mod->ref_cnt, 1);
+	list_add_tail(&mod->list, &module_list);
+
+	set_bit(MOD_LOADED, &mod->flags);
+	res = init_module(mod);
+	if (!res) {
+		res = start_module(mod);
+		if (res)
+			exit_module(mod);
+	}
+	return res;
 }

 /*
@@ -294,47 +378,50 @@ sys_create_module(const char *name_user,
 	char *name;
 	long namelen, error;
 	struct module *mod;
-	unsigned long flags;
+	struct old_module *old;

 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
-	lock_kernel();
-	if ((namelen = get_mod_name(name_user, &name)) < 0) {
-		error = namelen;
-		goto err0;
-	}
-	if (size < sizeof(struct module)+namelen) {
-		error = -EINVAL;
-		goto err1;
-	}
-	if (find_module(name) != NULL) {
+
+	name = getname(name_user);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+	namelen = strlen(name);
+
+	mod = find_module(name);
+	if (mod) {
+		put_module(mod);
 		error = -EEXIST;
-		goto err1;
+		goto err0;
 	}
-	if ((mod = (struct module *)module_map(size)) == NULL) {
+
+	old = (struct old_module *)module_map(size);
+	if (!old) {
 		error = -ENOMEM;
-		goto err1;
+		goto err0;
 	}

+	mod = kmalloc(sizeof(struct module) + namelen + 1, GFP_KERNEL);
+	if (!mod) {
+		module_unmap(old);
+		error = -ENOMEM;
+		goto err0;
+	}
 	memset(mod, 0, sizeof(*mod));
-	mod->size_of_struct = sizeof(*mod);
-	mod->name = (char *)(mod + 1);
+	atomic_set(&mod->ref_cnt, 1);
+	mod->flags = (1 << MOD_LOCKED) | (1 << MOD_ALLOCED);
+	mod->name = (char *)mod + size;
 	mod->size = size;
-	memcpy((char*)(mod+1), name, namelen+1);
-
-	put_mod_name(name);
+	mod->old = old;
+	strcpy(mod->name, name);

-	spin_lock_irqsave(&modlist_lock, flags);
-	mod->next = module_list;
-	module_list = mod;	/* link it in */
-	spin_unlock_irqrestore(&modlist_lock, flags);
-
-	error = (long) mod;
-	goto err0;
-err1:
-	put_mod_name(name);
+	error = register_module(mod);
+	unlock_module(mod);
+	if (!error)
+		error = (long)old;
+	put_module(mod);
 err0:
-	unlock_kernel();
+	putname(name);
 	return error;
 }

@@ -345,256 +432,220 @@ err0:
 asmlinkage long
 sys_init_module(const char *name_user, struct module *mod_user)
 {
-	struct module mod_tmp, *mod;
-	char *name, *n_name, *name_tmp = NULL;
-	long namelen, n_namelen, i, error;
-	unsigned long mod_user_size;
-	struct module_ref *dep;
+	struct module *mod, *mod2;
+	char *name;
+	int namelen, error, i;
+	struct module_ref *ref;
+	struct list_head *list;

 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
-	lock_kernel();
-	if ((namelen = get_mod_name(name_user, &name)) < 0) {
-		error = namelen;
-		goto err0;
-	}
-	if ((mod = find_module(name)) == NULL) {
+
+	name = getname(name_user);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+	namelen = strlen(name);
+
+	mod = find_module(name);
+	if (!mod) {
 		error = -ENOENT;
-		goto err1;
+		goto err0;
 	}

-	/* Check module header size.  We allow a bit of slop over the
-	   size we are familiar with to cope with a version of insmod
-	   for a newer kernel.  But don't over do it. */
-	if ((error = get_user(mod_user_size, &mod_user->size_of_struct)) != 0)
-		goto err1;
-	if (mod_user_size < (unsigned long)&((struct module *)0L)->persist_start
-	    || mod_user_size > sizeof(struct module) + 16*sizeof(void*)) {
-		printk(KERN_ERR "init_module: Invalid module header size.\n"
-		       KERN_ERR "A new version of the modutils is likely "
-				"needed.\n");
-		error = -EINVAL;
+	if (lock_module(mod)) {
+		error = -EBUSY;
 		goto err1;
 	}

-	/* Hold the current contents while we play with the user's idea
-	   of righteousness.  */
-	mod_tmp = *mod;
-	name_tmp = kmalloc(strlen(mod->name) + 1, GFP_KERNEL);	/* Where's kstrdup()? */
-	if (name_tmp == NULL) {
-		error = -ENOMEM;
-		goto err1;
+	if (test_bit(MOD_LOADED, &mod->flags)) {
+		error = -EEXIST;
+		goto err2;
 	}
-	strcpy(name_tmp, mod->name);

-	error = copy_from_user(mod, mod_user, mod_user_size);
+	error = copy_from_user(mod->old, mod_user, mod->size);
 	if (error) {
 		error = -EFAULT;
 		goto err2;
 	}

-	/* Sanity check the size of the module.  */
-	error = -EINVAL;
+	if (mod->old->flags & OLD_MOD_AUTOCLEAN)
+		set_bit(MOD_AUTOCLEAN, &mod->flags);
+	mod->name = mod->old->name;
+	mod->syms = mod->old->syms;
+	mod->nsyms = mod->old->nsyms;
+	mod->deps = mod->old->deps;
+	mod->ndeps = mod->old->ndeps;
+	mod->ex_table_start = mod->old->ex_table_start;
+	mod->ex_table_end = mod->old->ex_table_end;

-	if (mod->size > mod_tmp.size) {
-		printk(KERN_ERR "init_module: Size of initialized module "
-				"exceeds size of created module.\n");
-		goto err2;
-	}
+	/* Sanity check the module's dependents */
+	down(&modlist_readlock);
+	for (i = 0, ref = mod->deps; i < mod->ndeps; ++i, ++ref) {
+		struct module *dep = ref->dep;

-	/* Make sure all interesting pointers are sane.  */
+		/* Make sure the indicated dependencies are really modules.  */
+		if (dep == mod) {
+			up(&modlist_readlock);
+			printk(KERN_ERR "init_module: self-referential "
+					"dependency in mod->deps.\n");
+			error = -EINVAL;
+			goto err2;
+		}

-	if (!mod_bound(mod->name, namelen, mod)) {
-		printk(KERN_ERR "init_module: mod->name out of bounds.\n");
-		goto err2;
-	}
-	if (mod->nsyms && !mod_bound(mod->syms, mod->nsyms, mod)) {
-		printk(KERN_ERR "init_module: mod->syms out of bounds.\n");
-		goto err2;
-	}
-	if (mod->ndeps && !mod_bound(mod->deps, mod->ndeps, mod)) {
-		printk(KERN_ERR "init_module: mod->deps out of bounds.\n");
-		goto err2;
-	}
-	if (mod->init && !mod_bound(mod->init, 0, mod)) {
-		printk(KERN_ERR "init_module: mod->init out of bounds.\n");
-		goto err2;
-	}
-	if (mod->cleanup && !mod_bound(mod->cleanup, 0, mod)) {
-		printk(KERN_ERR "init_module: mod->cleanup out of bounds.\n");
-		goto err2;
-	}
-	if (mod->ex_table_start > mod->ex_table_end
-	    || (mod->ex_table_start &&
-		!((unsigned long)mod->ex_table_start >= ((unsigned long)mod + mod->size_of_struct)
-		  && ((unsigned long)mod->ex_table_end
-		      < (unsigned long)mod + mod->size)))
-	    || (((unsigned long)mod->ex_table_start
-		 - (unsigned long)mod->ex_table_end)
-		% sizeof(struct exception_table_entry))) {
-		printk(KERN_ERR "init_module: mod->ex_table_* invalid.\n");
-		goto err2;
-	}
-	if (mod->flags & ~MOD_AUTOCLEAN) {
-		printk(KERN_ERR "init_module: mod->flags invalid.\n");
-		goto err2;
-	}
-	if (mod_member_present(mod, can_unload)
-	    && mod->can_unload && !mod_bound(mod->can_unload, 0, mod)) {
-		printk(KERN_ERR "init_module: mod->can_unload out of bounds.\n");
-		goto err2;
-	}
-	if (mod_member_present(mod, kallsyms_end)) {
-	    if (mod->kallsyms_end &&
-		(!mod_bound(mod->kallsyms_start, 0, mod) ||
-		 !mod_bound(mod->kallsyms_end, 0, mod))) {
-		printk(KERN_ERR "init_module: mod->kallsyms out of bounds.\n");
-		goto err2;
-	    }
-	    if (mod->kallsyms_start > mod->kallsyms_end) {
-		printk(KERN_ERR "init_module: mod->kallsyms invalid.\n");
-		goto err2;
-	    }
-	}
-	if (mod_member_present(mod, archdata_end)) {
-	    if (mod->archdata_end &&
-		(!mod_bound(mod->archdata_start, 0, mod) ||
-		 !mod_bound(mod->archdata_end, 0, mod))) {
-		printk(KERN_ERR "init_module: mod->archdata out of bounds.\n");
-		goto err2;
-	    }
-	    if (mod->archdata_start > mod->archdata_end) {
-		printk(KERN_ERR "init_module: mod->archdata invalid.\n");
+		/* Scan the current modules for this dependency */
+		list_for_each(list, &module_list) {
+			if (list_entry(list, struct module, list) == dep)
+				goto found;
+		}
+		up(&modlist_readlock);
+		printk(KERN_ERR "init_module: found dependency that is "
+			"(no longer?) a module.\n");
+		error = -EINVAL;
 		goto err2;
-	    }
-	}
-	if (mod_member_present(mod, kernel_data) && mod->kernel_data) {
-	    printk(KERN_ERR "init_module: mod->kernel_data must be zero.\n");
-	    goto err2;
+	found:
+		;
 	}

-	/* Check that the user isn't doing something silly with the name.  */
+	/* Update module references.  */
+	for (i = 0, ref = mod->deps; i < mod->ndeps; ++i, ++ref) {
+		struct module *dep = ref->dep;

-	if ((n_namelen = get_mod_name(mod->name - (unsigned long)mod
-				      + (unsigned long)mod_user,
-				      &n_name)) < 0) {
-		printk(KERN_ERR "init_module: get_mod_name failure.\n");
-		error = n_namelen;
-		goto err2;
-	}
-	if (namelen != n_namelen || strcmp(n_name, mod_tmp.name) != 0) {
-		printk(KERN_ERR "init_module: changed module name to "
-				"`%s' from `%s'\n",
-		       n_name, mod_tmp.name);
-		goto err3;
+		ref->ref = mod;
+		ref->next_ref = dep->refs;
+		dep->refs = ref;
 	}

-	/* Ok, that's about all the sanity we can stomach; copy the rest.  */
-
-	if (copy_from_user((char *)mod+mod_user_size,
-			   (char *)mod_user+mod_user_size,
-			   mod->size-mod_user_size)) {
-		error = -EFAULT;
-		goto err3;
-	}
+	error = module_arch_init(mod);
+	if (error)
+		goto err2;

-	if (module_arch_init(mod))
-		goto err3;
+	up(&modlist_readlock);

 	/* On some machines it is necessary to do something here
 	   to make the I and D caches consistent.  */
 	flush_icache_range((unsigned long)mod, (unsigned long)mod + mod->size);

-	mod->next = mod_tmp.next;
-	mod->refs = NULL;
+	set_bit(MOD_LOADED, &mod->flags);

-	/* Sanity check the module's dependents */
-	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
-		struct module *o, *d = dep->dep;
-
-		/* Make sure the indicated dependencies are really modules.  */
-		if (d == mod) {
-			printk(KERN_ERR "init_module: self-referential "
-					"dependency in mod->deps.\n");
-			goto err3;
-		}
-
-		/* Scan the current modules for this dependency */
-		for (o = module_list; o != &kernel_module && o != d; o = o->next)
-			;
-
-		if (o != d) {
-			printk(KERN_ERR "init_module: found dependency that is "
-				"(no longer?) a module.\n");
-			goto err3;
-		}
+	if (!mod->old->init) {
+		error = -EINVAL;
+		goto err2;
 	}
-
-	/* Update module references.  */
-	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
-		struct module *d = dep->dep;
+	error = mod->old->init(mod);
+	if (error)
+		goto err2;

-		dep->ref = mod;
-		dep->next_ref = d->refs;
-		d->refs = dep;
-		/* Being referenced by a dependent module counts as a
-		   use as far as kmod is concerned.  */
-		d->flags |= MOD_USED_ONCE;
-	}
+	mod2 = find_module(name);
+	if (!mod2 || !test_bit(MOD_LOCKED, &mod2->flags))
+		BUG();

-	/* Free our temporary memory.  */
-	put_mod_name(n_name);
-	put_mod_name(name);
+	if (mod == mod2)
+		set_bit(MOD_OLDSTYLE, &mod->flags);
+	unlock_module(mod);
+	put_module(mod);
+	mod = mod2;

 	/* Initialize the module.  */
-	atomic_set(&mod->uc.usecount,1);
-	mod->flags |= MOD_INITIALIZING;
-	if (mod->init && (error = mod->init()) != 0) {
-		atomic_set(&mod->uc.usecount,0);
-		mod->flags &= ~MOD_INITIALIZING;
-		if (error > 0)	/* Buggy module */
-			error = -EBUSY;
-		goto err0;
+	error = init_module(mod);
+	if (!error) {
+		error = start_module(mod);
+		if (error)
+			exit_module(mod);
 	}
-	atomic_dec(&mod->uc.usecount);

-	/* And set it running.  */
-	mod->flags = (mod->flags | MOD_RUNNING) & ~MOD_INITIALIZING;
-	error = 0;
-	goto err0;
-
-err3:
-	put_mod_name(n_name);
+	if (error && !test_bit(MOD_INITIALIZED, &mod->flags))
+		unregister_module(mod);
 err2:
-	*mod = mod_tmp;
-	strcpy((char *)mod->name, name_tmp);	/* We know there is room for this */
+	unlock_module(mod);
 err1:
-	put_mod_name(name);
+	put_module(mod);
 err0:
-	unlock_kernel();
-	kfree(name_tmp);
+	putname(name);
 	return error;
 }

-static spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
-int try_inc_mod_count(struct module *mod)
+int init_module_hack(struct module *tmp_mod, struct module *mod)
 {
-	int res = 1;
-	if (mod) {
-		spin_lock(&unload_lock);
-		if (mod->flags & MOD_DELETED)
-			res = 0;
-		else
-			__MOD_INC_USE_COUNT(mod);
-		spin_unlock(&unload_lock);
+	int i;
+
+	down(&modlist_readlock);
+
+	lock_module(mod);
+	if (test_bit(MOD_AUTOCLEAN, &mod->flags))
+		set_bit(MOD_AUTOCLEAN, &mod->flags);
+	set_bit(MOD_LOADED, &mod->flags);
+	atomic_set(&mod->ref_cnt, 1);
+	mod->size = tmp_mod->size;
+	mod->name = tmp_mod->name;
+	mod->syms = tmp_mod->syms;
+	mod->nsyms = tmp_mod->nsyms;
+	mod->deps = tmp_mod->deps;
+	mod->ndeps = tmp_mod->ndeps;
+	mod->ex_table_start = tmp_mod->ex_table_start;
+	mod->ex_table_end = tmp_mod->ex_table_end;
+
+	tmp_mod->old = NULL;
+	tmp_mod->ndeps = 0;
+
+	for (i = 0; i < mod->ndeps; ++i)
+		mod->deps[i].ref = mod;
+
+	spin_lock_irq(&modlist_lock);
+	list_add_tail(&mod->list, &module_list);
+	list_del_init(&tmp_mod->list);
+	spin_unlock_irq(&modlist_lock);
+
+	/* "unregister" temporary module structure */
+	put_module(tmp_mod);
+
+	up(&modlist_readlock);
+
+	return 0;
+}
+
+static int try_unregister_module(struct module *mod)
+{
+	int res = 0;
+
+	if (lock_module(mod))
+		return -EBUSY;
+
+	if (test_bit(MOD_BUILTIN, &mod->flags) ||
+	    test_bit(MOD_OLDSTYLE, &mod->flags)) {
+		res = -EBUSY;
+		goto out;
+	}
+
+	if (mod->refs || usecount_module(mod)) {
+		res = -EBUSY;
+		goto out;
+	}
+
+	if (test_bit(MOD_RUNNING, &mod->flags)) {
+		res = stop_module(mod);
+		if (res)
+			goto out;
+	}
+
+	if (test_bit(MOD_INITIALIZED, &mod->flags)) {
+		res = exit_module(mod);
+		if (res) {
+			start_module(mod);
+			goto out;
+		}
 	}
+
+	unregister_module(mod);
+out:
+	unlock_module(mod);
 	return res;
 }

 asmlinkage long
 sys_delete_module(const char *name_user)
 {
-	struct module *mod, *next;
+	struct module *mod;
+	struct list_head *list;
 	char *name;
 	long error;
 	int something_changed;
@@ -602,70 +653,40 @@ sys_delete_module(const char *name_user)
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;

-	lock_kernel();
 	if (name_user) {
-		if ((error = get_mod_name(name_user, &name)) < 0)
-			goto out;
-		error = -ENOENT;
-		if ((mod = find_module(name)) == NULL) {
-			put_mod_name(name);
-			goto out;
-		}
-		put_mod_name(name);
-		error = -EBUSY;
-		if (mod->refs != NULL)
-			goto out;
-
-		spin_lock(&unload_lock);
-		if (!__MOD_IN_USE(mod)) {
-			mod->flags |= MOD_DELETED;
-			spin_unlock(&unload_lock);
-			free_module(mod, 0);
-			error = 0;
-		} else {
-			spin_unlock(&unload_lock);
-		}
-		goto out;
+		name = getname(name_user);
+		if (IS_ERR(name))
+			return PTR_ERR(name);
+
+		mod = find_module(name);
+		putname(name);
+		if (!mod)
+			return -ENOENT;
+
+		error = try_unregister_module(mod);
+		put_module(mod);
+		if (error)
+			return error;
 	}

 	/* Do automatic reaping */
 restart:
 	something_changed = 0;
-
-	for (mod = module_list; mod != &kernel_module; mod = next) {
-		next = mod->next;
-		spin_lock(&unload_lock);
-		if (mod->refs == NULL
-		    && (mod->flags & MOD_AUTOCLEAN)
-		    && (mod->flags & MOD_RUNNING)
-		    && !(mod->flags & MOD_DELETED)
-		    && (mod->flags & MOD_USED_ONCE)
-		    && !__MOD_IN_USE(mod)) {
-			if ((mod->flags & MOD_VISITED)
-			    && !(mod->flags & MOD_JUST_FREED)) {
-				spin_unlock(&unload_lock);
-				mod->flags &= ~MOD_VISITED;
-			} else {
-				mod->flags |= MOD_DELETED;
-				spin_unlock(&unload_lock);
-				free_module(mod, 1);
-				something_changed = 1;
-			}
-		} else {
-			spin_unlock(&unload_lock);
-		}
+
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
+		mod = list_entry(list, struct module, list);
+		if (!test_bit(MOD_AUTOCLEAN, &mod->flags))
+			continue;
+		if (!try_unregister_module(mod))
+			something_changed = 1;
 	}
-
+	up(&modlist_readlock);
+
 	if (something_changed)
 		goto restart;
-
-	for (mod = module_list; mod != &kernel_module; mod = mod->next)
-		mod->flags &= ~MOD_JUST_FREED;
-
-	error = 0;
-out:
-	unlock_kernel();
-	return error;
+
+	return 0;
 }

 /* Query various bits about modules.  */
@@ -674,78 +695,66 @@ static int
 qm_modules(char *buf, size_t bufsize, size_t *ret)
 {
 	struct module *mod;
+	struct list_head *list;
 	size_t nmod, space, len;
+	int res = 0;

 	nmod = space = 0;

-	for (mod=module_list; mod != &kernel_module; mod=mod->next, ++nmod) {
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
+		mod = list_entry(list, struct module, list);
+		if (test_bit(MOD_BUILTIN, &mod->flags))
+			continue;
+
+		nmod++;
 		len = strlen(mod->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, mod->name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, mod->name, len)) {
+				up(&modlist_readlock);
+				return -EFAULT;
+			}
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
+	up(&modlist_readlock);

-	if (put_user(nmod, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while ((mod = mod->next) != &kernel_module)
-		space += strlen(mod->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : nmod, ret))
+		res = -EFAULT;
+	return res;
 }

 static int
 qm_deps(struct module *mod, char *buf, size_t bufsize, size_t *ret)
 {
 	size_t i, space, len;
-
-	if (mod == &kernel_module)
-		return -EINVAL;
-	if (!MOD_CAN_QUERY(mod))
-		if (put_user(0, ret))
-			return -EFAULT;
-		else
-			return 0;
+	int res = 0;

 	space = 0;
 	for (i = 0; i < mod->ndeps; ++i) {
 		const char *dep_name = mod->deps[i].dep->name;

 		len = strlen(dep_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, dep_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, dep_name, len))
+				return -EFAULT;
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
-
-	if (put_user(i, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while (++i < mod->ndeps)
-		space += strlen(mod->deps[i].dep->name)+1;

-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : i, ret))
+		res = -EFAULT;
+	return res;
 }

 static int
@@ -753,43 +762,28 @@ qm_refs(struct module *mod, char *buf, s
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
-
-	if (mod == &kernel_module)
-		return -EINVAL;
-	if (!MOD_CAN_QUERY(mod))
-		if (put_user(0, ret))
-			return -EFAULT;
-		else
-			return 0;
+	int res = 0;

 	space = 0;
 	for (nrefs = 0, ref = mod->refs; ref ; ++nrefs, ref = ref->next_ref) {
 		const char *ref_name = ref->ref->name;

 		len = strlen(ref_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, ref_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, ref_name, len))
+				return -EFAULT;
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
-
-	if (put_user(nrefs, ret))
-		return -EFAULT;
-	else
-		return 0;

-calc_space_needed:
-	space += len;
-	while ((ref = ref->next_ref) != NULL)
-		space += strlen(ref->ref->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : nrefs, ret))
+		res = -EFAULT;
+	return res;
 }

 static int
@@ -799,20 +793,15 @@ qm_symbols(struct module *mod, char *buf
 	struct module_symbol *s;
 	char *strings;
 	unsigned long *vals;
-
-	if (!MOD_CAN_QUERY(mod))
-		if (put_user(0, ret))
-			return -EFAULT;
-		else
-			return 0;
+	int res = 0;

-	space = mod->nsyms * 2*sizeof(void *);
+	space = mod->nsyms * 2 * sizeof(void *);

 	i = len = 0;
 	s = mod->syms;

 	if (space > bufsize)
-		goto calc_space_needed;
+		bufsize = 0;

 	if (!access_ok(VERIFY_WRITE, buf, space))
 		return -EFAULT;
@@ -823,31 +812,24 @@ qm_symbols(struct module *mod, char *buf

 	for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
 		len = strlen(s->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
+		if (len <= bufsize) {
+			if (copy_to_user(strings, s->name, len)
+			    || __put_user(s->value, vals+0)
+			    || __put_user(space, vals+1))
+				return -EFAULT;

-		if (copy_to_user(strings, s->name, len)
-		    || __put_user(s->value, vals+0)
-		    || __put_user(space, vals+1))
-			return -EFAULT;
-
-		strings += len;
-		bufsize -= len;
+			strings += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
-	if (put_user(i, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	for (; i < mod->nsyms; ++i, ++s)
-		space += strlen(s->name)+1;

-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : i, ret))
+		res = -EFAULT;
+	return res;
 }

 static int
@@ -860,14 +842,21 @@ qm_info(struct module *mod, char *buf, s

 	if (sizeof(struct module_info) <= bufsize) {
 		struct module_info info;
+
 		info.addr = (unsigned long)mod;
 		info.size = mod->size;
-		info.flags = mod->flags;
-
-		/* usecount is one too high here - report appropriately to
-		   compensate for locking */
-		info.usecount = (mod_member_present(mod, can_unload)
-				 && mod->can_unload ? -1 : atomic_read(&mod->uc.usecount)-1);
+		info.flags = 0;
+		if (test_bit(MOD_RUNNING, &mod->flags))
+			info.flags |= OLD_MOD_RUNNING;
+		else if (!test_bit(MOD_LOADED, &mod->flags))
+			info.flags |= OLD_MOD_DELETED;
+		else
+			info.flags |= OLD_MOD_INITIALIZING;
+		if (test_bit(MOD_AUTOCLEAN, &mod->flags))
+			info.flags |= OLD_MOD_AUTOCLEAN;
+		if (mod->refs || usecount_module(mod))
+			info.flags |= OLD_MOD_USED_ONCE;
+		info.usecount = usecount_module(mod);

 		if (copy_to_user(buf, &info, sizeof(struct module_info)))
 			return -EFAULT;
@@ -887,29 +876,22 @@ sys_query_module(const char *name_user,
 	struct module *mod;
 	int err;

-	lock_kernel();
-	if (name_user == NULL)
-		mod = &kernel_module;
-	else {
-		long namelen;
+	if (name_user) {
 		char *name;

-		if ((namelen = get_mod_name(name_user, &name)) < 0) {
-			err = namelen;
-			goto out;
-		}
-		err = -ENOENT;
-		if ((mod = find_module(name)) == NULL) {
-			put_mod_name(name);
-			goto out;
-		}
-		put_mod_name(name);
+		name = getname(name_user);
+		if (IS_ERR(name))
+			return PTR_ERR(name);
+
+		mod = find_module(name);
+		putname(name);
+		if (!mod)
+			return -ENOENT;
+	} else {
+		mod = &kernel_module;
+		get_module(mod);
 	}

-	/* __MOD_ touches the flags. We must avoid that */
-
-	atomic_inc(&mod->uc.usecount);
-
 	switch (which)
 	{
 	case 0:
@@ -934,92 +916,47 @@ sys_query_module(const char *name_user,
 		err = -EINVAL;
 		break;
 	}
-	atomic_dec(&mod->uc.usecount);
-
-out:
-	unlock_kernel();
+	put_module(mod);
+
 	return err;
 }

-/*
- * Copy the kernel symbol table to user space.  If the argument is
- * NULL, just return the size of the table.
- *
- * This call is obsolete.  New programs should use query_module+QM_SYMBOLS
- * which does not arbitrarily limit the length of symbols.
- */
-
-asmlinkage long
-sys_get_kernel_syms(struct kernel_sym *table)
+int register_module(struct module *mod)
 {
-	struct module *mod;
-	int i;
-	struct kernel_sym ksym;
-
-	lock_kernel();
-	for (mod = module_list, i = 0; mod; mod = mod->next) {
-		/* include the count for the module name! */
-		i += mod->nsyms + 1;
-	}
-
-	if (table == NULL)
-		goto out;
-
-	/* So that we don't give the user our stack content */
-	memset (&ksym, 0, sizeof (ksym));
-
-	for (mod = module_list, i = 0; mod; mod = mod->next) {
-		struct module_symbol *msym;
-		unsigned int j;
-
-		if (!MOD_CAN_QUERY(mod))
-			continue;
-
-		/* magic: write module info as a pseudo symbol */
-		ksym.value = (unsigned long)mod;
-		ksym.name[0] = '#';
-		strncpy(ksym.name+1, mod->name, sizeof(ksym.name)-1);
-		ksym.name[sizeof(ksym.name)-1] = '\0';
-
-		if (copy_to_user(table, &ksym, sizeof(ksym)) != 0)
-			goto out;
-		++i, ++table;
+	struct module *mod2;
+	struct list_head *list;
+	int res = -EEXIST;
+
+	//printk("register_module: %p\n", mod);
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
+		mod2 = list_entry(list, struct module, list);
+		if (!strcmp(mod2->name, mod->name))
+			goto exists;
+	}
+	lock_module(mod);
+	get_module(mod);
+
+	spin_lock_irq(&modlist_lock);
+	list_add_tail(&mod->list, &module_list);
+	spin_unlock_irq(&modlist_lock);
+
+	res = 0;
+exists:
+	up(&modlist_readlock);

-		if (mod->nsyms == 0)
-			continue;
-
-		for (j = 0, msym = mod->syms; j < mod->nsyms; ++j, ++msym) {
-			ksym.value = msym->value;
-			strncpy(ksym.name, msym->name, sizeof(ksym.name));
-			ksym.name[sizeof(ksym.name)-1] = '\0';
-
-			if (copy_to_user(table, &ksym, sizeof(ksym)) != 0)
-				goto out;
-			++i, ++table;
-		}
-	}
-out:
-	unlock_kernel();
-	return i;
+	return res;
 }

-/*
- * Look for a module by name, ignoring modules marked for deletion.
- */
-
-struct module *
-find_module(const char *name)
+void unregister_module(struct module *mod)
 {
-	struct module *mod;
-
-	for (mod = module_list; mod ; mod = mod->next) {
-		if (mod->flags & MOD_DELETED)
-			continue;
-		if (!strcmp(mod->name, name))
-			break;
-	}
+	if (!(mod->flags & (1 << MOD_LOCKED)))
+		BUG();
+	if (mod->flags & ((1 << MOD_RUNNING) | (1 << MOD_INITIALIZED) | (1 << MOD_BUILTIN)))
+		BUG();

-	return mod;
+	//printk("unregister_module: %p\n", mod);
+	put_module(mod);
 }

 /*
@@ -1027,48 +964,39 @@ find_module(const char *name)
  */

 void
-free_module(struct module *mod, int tag_freed)
+free_module(struct module *mod)
 {
 	struct module_ref *dep;
-	unsigned i;
-	unsigned long flags;
-
-	/* Let the module clean up.  */
+	int i;

-	if (mod->flags & MOD_RUNNING)
-	{
-		if(mod->cleanup)
-			mod->cleanup();
-		mod->flags &= ~MOD_RUNNING;
+	//printk("free_module: %p\n", mod);
+	down(&modlist_readlock);
+	if (atomic_read(&mod->ref_cnt)) {
+		up(&modlist_readlock);
+		return;
 	}

 	/* Remove the module from the dependency lists.  */
-
 	for (i = 0, dep = mod->deps; i < mod->ndeps; ++i, ++dep) {
 		struct module_ref **pp;
 		for (pp = &dep->dep->refs; *pp != dep; pp = &(*pp)->next_ref)
 			continue;
 		*pp = dep->next_ref;
-		if (tag_freed && dep->dep->refs == NULL)
-			dep->dep->flags |= MOD_JUST_FREED;
 	}

 	/* And from the main module list.  */
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (mod == module_list) {
-		module_list = mod->next;
-	} else {
-		struct module *p;
-		for (p = module_list; p->next != mod; p = p->next)
-			continue;
-		p->next = mod->next;
-	}
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	spin_lock_irq(&modlist_lock);
+	list_del(&mod->list);
+	spin_unlock_irq(&modlist_lock);
+	up(&modlist_readlock);

 	/* And free the memory.  */
-
-	module_unmap(mod);
+	if (test_bit(MOD_ALLOCED, &mod->flags)) {
+		if (mod->old)
+			module_unmap(mod->old);
+		kfree(mod);
+	} else
+		module_unmap(mod->old);
 }

 /*
@@ -1081,8 +1009,10 @@ int get_module_list(char *p)
 	struct module *mod;
 	char tmpstr[64];
 	struct module_ref *ref;
+	struct list_head *list;

-	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
 		long len;
 		const char *q;

@@ -1094,6 +1024,7 @@ int get_module_list(char *p)
 		} while (0)
 #define safe_copy_cstr(str)	safe_copy_str(str, sizeof(str)-1)

+		mod = list_entry(list, struct module, list);
 		len = strlen(mod->name);
 		safe_copy_str(mod->name, len);

@@ -1108,24 +1039,18 @@ int get_module_list(char *p)
 		len = sprintf(tmpstr, "%8lu", mod->size);
 		safe_copy_str(tmpstr, len);

-		if (mod->flags & MOD_RUNNING) {
-			len = sprintf(tmpstr, "%4ld",
-				      (mod_member_present(mod, can_unload)
-				       && mod->can_unload
-				       ? -1L : (long)atomic_read(&mod->uc.usecount)));
-			safe_copy_str(tmpstr, len);
-		}
+		len = sprintf(tmpstr, "%4ld",
+			      (long)atomic_read(&mod->ref_cnt));
+		safe_copy_str(tmpstr, len);

-		if (mod->flags & MOD_DELETED)
-			safe_copy_cstr(" (deleted)");
-		else if (mod->flags & MOD_RUNNING) {
-			if (mod->flags & MOD_AUTOCLEAN)
-				safe_copy_cstr(" (autoclean)");
-			if (!(mod->flags & MOD_USED_ONCE))
+		if (test_bit(MOD_RUNNING, &mod->flags)) {
+			if (!usecount_module(mod) && !mod->refs)
 				safe_copy_cstr(" (unused)");
 		}
-		else if (mod->flags & MOD_INITIALIZING)
-			safe_copy_cstr(" (initializing)");
+		else if (test_bit(MOD_INITIALIZED, &mod->flags))
+			safe_copy_cstr(" (initialized)");
+		else if (test_bit(MOD_LOADED, &mod->flags))
+			safe_copy_cstr(" (loaded)");
 		else
 			safe_copy_cstr(" (uninitialized)");

@@ -1150,6 +1075,7 @@ int get_module_list(char *p)
 	}

 fini:
+	up(&modlist_readlock);
 	return PAGE_SIZE - left;
 }

@@ -1167,20 +1093,23 @@ struct mod_sym {
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
 	struct mod_sym *p = kmalloc(sizeof(*p), GFP_KERNEL);
-	struct module *v;
+	struct list_head *list;
+	struct module *mod;
 	loff_t n = *pos;

 	if (!p)
 		return ERR_PTR(-ENOMEM);
-	lock_kernel();
-	for (v = module_list, n = *pos; v; n -= v->nsyms, v = v->next) {
-		if (n < v->nsyms) {
-			p->mod = v;
+	down(&modlist_readlock);
+	list_for_each(list, &module_list) {
+		mod = list_entry(list, struct module, list);
+		if (n < mod->nsyms) {
+			p->mod = mod;
 			p->index = n;
 			return p;
 		}
+		n -= mod->nsyms;
 	}
-	unlock_kernel();
+	up(&modlist_readlock);
 	kfree(p);
 	return NULL;
 }
@@ -1188,16 +1117,19 @@ static void *s_start(struct seq_file *m,
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	struct mod_sym *v = p;
+	struct module *mod = v->mod;
+
 	(*pos)++;
-	if (++v->index >= v->mod->nsyms) {
+	if (++v->index >= mod->nsyms) {
 		do {
-			v->mod = v->mod->next;
-			if (!v->mod) {
-				unlock_kernel();
+			if (mod->list.next == &module_list) {
+				up(&modlist_readlock);
 				kfree(p);
 				return NULL;
 			}
-		} while (!v->mod->nsyms);
+			mod = list_entry(mod->list.next, struct module, list);
+		} while (!mod->nsyms);
+		v->mod = mod;
 		v->index = 0;
 	}
 	return p;
@@ -1206,7 +1138,7 @@ static void *s_next(struct seq_file *m,
 static void s_stop(struct seq_file *m, void *p)
 {
 	if (p && !IS_ERR(p)) {
-		unlock_kernel();
+		up(&modlist_readlock);
 		kfree(p);
 	}
 }
@@ -1216,8 +1148,6 @@ static int s_show(struct seq_file *m, vo
 	struct mod_sym *v = p;
 	struct module_symbol *sym;

-	if (!MOD_CAN_QUERY(v->mod))
-		return 0;
 	sym = &v->mod->syms[v->index];
 	if (*v->mod->name)
 		seq_printf(m, "%0*lx %s\t[%s]\n", (int)(2*sizeof(void*)),
@@ -1267,17 +1197,6 @@ sys_query_module(const char *name_user,
 		return 0;

 	return -ENOSYS;
-}
-
-asmlinkage long
-sys_get_kernel_syms(struct kernel_sym *table)
-{
-	return -ENOSYS;
-}
-
-int try_inc_mod_count(struct module *mod)
-{
-	return 1;
 }

 #endif	/* CONFIG_MODULES */
Index: kernel/user.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/kernel/user.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 user.c
--- kernel/user.c	2001/01/11 12:09:28	1.1.1.3
+++ kernel/user.c	2002/07/24 10:06:20
@@ -8,6 +8,7 @@
  * able to have per-user limits for system resources.
  */

+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
Index: mm/vmscan.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/mm/vmscan.c,v
retrieving revision 1.1.1.27
diff -u -p -r1.1.1.27 vmscan.c
--- mm/vmscan.c	2002/03/12 13:13:34	1.1.1.27
+++ mm/vmscan.c	2002/07/24 10:06:20
@@ -11,6 +11,7 @@
  *  Multiqueue VM started 5.8.00, Rik van Riel.
  */

+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
Index: net/ipv4/af_inet.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.4/net/ipv4/af_inet.c,v
retrieving revision 1.1.1.12
diff -u -p -r1.1.1.12 af_inet.c
--- net/ipv4/af_inet.c	2002/01/08 13:15:11	1.1.1.12
+++ net/ipv4/af_inet.c	2002/07/24 10:06:20
@@ -64,6 +64,7 @@
  */

 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>

