Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267887AbTAMF63>; Mon, 13 Jan 2003 00:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTAMF62>; Mon, 13 Jan 2003 00:58:28 -0500
Received: from dp.samba.org ([66.70.73.150]:9434 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267915AbTAMF6S>;
	Mon, 13 Jan 2003 00:58:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup 2/2: Remove extable list
Date: Mon, 13 Jan 2003 16:59:53 +1100
Message-Id: <20030113060707.AC6952C0E9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same thing, but for extable lists.  They have a 1:1 correlation to
modules (the kernel one is handled in extable.c), so remove the
extable list.

Also removes asm/uaccess.h from module.h in favour of a struct
pre-declaration.

Name: Extable list removal
Author: Rusty Russell
Status: Tested on 2.5.56
Depends: Module/symbol-list.patch.gz

D: This removes the extable list, and the struct exception_table, in
D: favour of just iterating through the modules.  Now all iteration is
D: within kernel/module.c, this is a fairly trivial cleanup.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16441-linux-2.5-bk/include/linux/module.h .16441-linux-2.5-bk.updated/include/linux/module.h
--- .16441-linux-2.5-bk/include/linux/module.h	2003-01-13 16:53:59.000000000 +1100
+++ .16441-linux-2.5-bk.updated/include/linux/module.h	2003-01-13 16:54:28.000000000 +1100
@@ -18,7 +18,6 @@
 #include <linux/stringify.h>
 
 #include <asm/module.h>
-#include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
 #define MODULE_AUTHOR(name)
@@ -44,6 +43,8 @@ extern int init_module(void);
 extern void cleanup_module(void);
 
 /* Archs provide a method of finding the correct exception table. */
+struct exception_table_entry;
+
 const struct exception_table_entry *
 search_extable(const struct exception_table_entry *first,
 	       const struct exception_table_entry *last,
@@ -109,15 +110,6 @@ extern const struct gtype##_id __mod_##g
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 
-struct exception_table
-{
-	struct list_head list;
-
-	unsigned int num_entries;
-	const struct exception_table_entry *entry;
-};
-
-
 #ifdef CONFIG_MODULES
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
@@ -167,8 +159,9 @@ struct module
 	const struct kernel_symbol *gpl_syms;
 	unsigned int num_gpl_syms;
 
-	/* Exception tables */
-	struct exception_table extable;
+	/* Exception table */
+	unsigned int num_exentries;
+	const struct exception_table_entry *extable;
 
 	/* Startup function. */
 	int (*init)(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16441-linux-2.5-bk/kernel/extable.c .16441-linux-2.5-bk.updated/kernel/extable.c
--- .16441-linux-2.5-bk/kernel/extable.c	2003-01-13 16:53:59.000000000 +1100
+++ .16441-linux-2.5-bk.updated/kernel/extable.c	2003-01-13 16:54:28.000000000 +1100
@@ -16,6 +16,7 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/module.h>
+#include <asm/uaccess.h>
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16441-linux-2.5-bk/kernel/module.c .16441-linux-2.5-bk.updated/kernel/module.c
--- .16441-linux-2.5-bk/kernel/module.c	2003-01-13 16:53:59.000000000 +1100
+++ .16441-linux-2.5-bk.updated/kernel/module.c	2003-01-13 16:54:28.000000000 +1100
@@ -51,13 +51,12 @@
 #define symbol_is(literal, string)				\
 	(strcmp(MODULE_SYMBOL_PREFIX literal, (string)) == 0)
 
-/* Protects extables and symbols lists */
+/* Protects module list */
 static spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
 
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
-static LIST_HEAD(extables);
 
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
@@ -764,7 +763,6 @@ static void free_module(struct module *m
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
-	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
 	/* Module unload stuff */
@@ -1190,14 +1188,9 @@ static struct module *load_module(void *
 	mod->num_gpl_syms = sechdrs[gplindex].sh_size / sizeof(*mod->gpl_syms);
 	mod->gpl_syms = (void *)sechdrs[gplindex].sh_addr;
 
-	/* Set up exception table */
-	if (exindex) {
-		/* FIXME: Sort exception table. */
-		mod->extable.num_entries = (sechdrs[exindex].sh_size
-					    / sizeof(struct
-						     exception_table_entry));
-		mod->extable.entry = (void *)sechdrs[exindex].sh_addr;
-	}
+  	/* Set up exception table */
+	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
+	mod->extable = (void *)sechdrs[exindex].sh_addr;
 
 	/* Now handle each section. */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1291,7 +1284,6 @@ sys_init_module(void *umod,
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
-	list_add(&mod->extable.list, &extables);
 	list_add(&mod->list, &modules);
 	spin_unlock_irq(&modlist_lock);
 
@@ -1445,14 +1437,16 @@ const struct exception_table_entry *sear
 {
 	unsigned long flags;
 	const struct exception_table_entry *e = NULL;
-	struct exception_table *i;
+	struct module *mod;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each_entry(i, &extables, list) {
-		if (i->num_entries == 0)
+	list_for_each_entry(mod, &modules, list) {
+		if (mod->num_exentries == 0)
 			continue;
 				
-		e = search_extable(i->entry, i->entry+i->num_entries-1, addr);
+		e = search_extable(mod->extable,
+				   mod->extable + mod->num_exentries - 1,
+				   addr);
 		if (e)
 			break;
 	}
@@ -1471,8 +1465,8 @@ struct module *module_text_address(unsig
 	list_for_each_entry(mod, &modules, list)
 		if (within(addr, mod->module_init, mod->init_size)
 		    || within(addr, mod->module_core, mod->core_size))
-			return 1;
-	return 0;
+			return mod;
+	return NULL;
 }
 
 /* Obsolete lvalue for broken code which asks about usage */


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
