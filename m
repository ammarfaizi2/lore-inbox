Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTC0EEY>; Wed, 26 Mar 2003 23:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbTC0EEY>; Wed, 26 Mar 2003 23:04:24 -0500
Received: from dp.samba.org ([66.70.73.150]:2755 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262806AbTC0EET>;
	Wed, 26 Mar 2003 23:04:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor module cleanup 3/3
Date: Thu, 27 Mar 2003 15:14:42 +1100
Message-Id: <20030327041533.52FD62C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This gets rid of the separate extable list, which is 1:1 with modules
anyway: now all accesses to it are inside module.c, this cleanup is
trivial.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Extable list removal
Author: Rusty Russell
Status: Tested on 2.5.66-bk2
Depends: Module/symbol-list.patch.gz

D: This removes the extable list, and the struct exception_table, in
D: favour of just iterating through the modules.  Now all iteration is
D: within kernel/module.c, this is a fairly trivial cleanup.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21085-2.5.60-bk3-extable-list.pre/include/linux/module.h .21085-2.5.60-bk3-extable-list/include/linux/module.h
--- .21085-2.5.60-bk3-extable-list.pre/include/linux/module.h	2003-02-14 23:30:39.000000000 +1100
+++ .21085-2.5.60-bk3-extable-list/include/linux/module.h	2003-02-14 23:30:39.000000000 +1100
@@ -18,7 +18,6 @@
 #include <linux/stringify.h>
 
 #include <asm/module.h>
-#include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
 #define MODULE_AUTHOR(name)
@@ -51,6 +50,8 @@ extern int init_module(void);
 extern void cleanup_module(void);
 
 /* Archs provide a method of finding the correct exception table. */
+struct exception_table_entry;
+
 const struct exception_table_entry *
 search_extable(const struct exception_table_entry *first,
 	       const struct exception_table_entry *last,
@@ -116,15 +117,6 @@ extern const struct gtype##_id __mod_##g
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
@@ -205,8 +197,9 @@ struct module
 	unsigned int num_gpl_syms;
 	const unsigned long *gpl_crcs;
 
-	/* Exception tables */
-	struct exception_table extable;
+	/* Exception table */
+	unsigned int num_exentries;
+	const struct exception_table_entry *extable;
 
 	/* Startup function. */
 	int (*init)(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21085-2.5.60-bk3-extable-list.pre/kernel/extable.c .21085-2.5.60-bk3-extable-list/kernel/extable.c
--- .21085-2.5.60-bk3-extable-list.pre/kernel/extable.c	2003-02-14 23:30:39.000000000 +1100
+++ .21085-2.5.60-bk3-extable-list/kernel/extable.c	2003-02-14 23:30:39.000000000 +1100
@@ -16,6 +16,7 @@
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 #include <linux/module.h>
+#include <asm/uaccess.h>
 
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21085-2.5.60-bk3-extable-list.pre/kernel/module.c .21085-2.5.60-bk3-extable-list/kernel/module.c
--- .21085-2.5.60-bk3-extable-list.pre/kernel/module.c	2003-02-14 23:30:39.000000000 +1100
+++ .21085-2.5.60-bk3-extable-list/kernel/module.c	2003-02-14 23:30:39.000000000 +1100
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
@@ -845,7 +841,6 @@ static void free_module(struct module *m
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
-	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
 	/* Module unload stuff */
@@ -1312,14 +1308,9 @@ static struct module *load_module(void *
 	}
 #endif
 
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
@@ -1421,7 +1411,6 @@ sys_init_module(void *umod,
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
-	list_add(&mod->extable.list, &extables);
 	list_add(&mod->list, &modules);
 	spin_unlock_irq(&modlist_lock);
 
@@ -1584,14 +1573,16 @@ const struct exception_table_entry *sear
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
