Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbTAFBcs>; Sun, 5 Jan 2003 20:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTAFBcs>; Sun, 5 Jan 2003 20:32:48 -0500
Received: from dp.samba.org ([66.70.73.150]:40357 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265683AbTAFBcm>;
	Sun, 5 Jan 2003 20:32:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/modules change
Date: Mon, 06 Jan 2003 12:40:56 +1100
Message-Id: <20030106014118.51F0F2C133@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This changes /proc/modules to have fixed space-separated format,
independent of CONFIG options or how many module dependencies there
are.

Old format: modname modsize [refcount [dep1] [dep2] ...]
New format: modname modsize refcount deps1,[dep2,]...

The module-init-tools have understood this format for over a month
now.  This change allows us to add new fields, ie. module state,
module address, etc.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: /proc/modules rework
Author: Rusty Russell
Status: Tested on 2.5.54

D: This changes the dependency list in /proc/modules to be one field,
D: rather than a space-separated set of dependencies, and makes sure
D: the contents are there even if CONFIG_MODULE_UNLOAD is off, etc.
D:
D: This allows us to append fields (eg. the module address for
D: oprofile, and the module status) without breaking userspace.
D: module-init-tools already handles this format (which you can detect
D: by the presence of "-" or "," in the fourth field).
D:
D: Old format: modname modsize [refcount [dep1] [dep2] ...]
D: New format: modname modsize refcount deps1,[dep2,]...

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21499-linux-2.5-bk/kernel/module.c .21499-linux-2.5-bk.updated/kernel/module.c
--- .21499-linux-2.5-bk/kernel/module.c	2003-01-02 14:48:01.000000000 +1100
+++ .21499-linux-2.5-bk.updated/kernel/module.c	2003-01-06 12:39:40.000000000 +1100
@@ -481,19 +481,29 @@ sys_delete_module(const char *name_user,
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
 	struct module_use *use;
+	int printed_something = 0;
 
-	seq_printf(m, " %u", module_refcount(mod));
+	seq_printf(m, " %u ", module_refcount(mod));
 
-	list_for_each_entry(use, &mod->modules_which_use_me, list)
-		seq_printf(m, " %s", use->module_which_uses->name);
+	/* Always include a trailing , so userspace can differentiate
+           between this and the old multi-field proc format. */
+	list_for_each_entry(use, &mod->modules_which_use_me, list) {
+		printed_something = 1;
+		seq_printf(m, "%s,", use->module_which_uses->name);
+	}
 
-	if (mod->unsafe)
-		seq_printf(m, " [unsafe]");
+	if (mod->unsafe) {
+		printed_something = 1;
+		seq_printf(m, "[unsafe],");
+	}
 
-	if (mod->init != init_module && mod->exit == cleanup_module)
-		seq_printf(m, " [permanent]");
+	if (mod->init != init_module && mod->exit == cleanup_module) {
+		printed_something = 1;
+		seq_printf(m, "[permanent],");
+	}
 
-	seq_printf(m, "\n");
+	if (!printed_something)
+		seq_printf(m, "-");
 }
 
 void __symbol_put(const char *symbol)
@@ -534,7 +544,8 @@ EXPORT_SYMBOL_GPL(symbol_put_addr);
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
-	seq_printf(m, "\n");
+	/* We don't know the usage count, or what modules are using. */
+	seq_printf(m, " - -");
 }
 
 static inline void module_unload_free(struct module *mod)
@@ -1370,8 +1381,15 @@ static int m_show(struct seq_file *m, vo
 	seq_printf(m, "%s %lu",
 		   mod->name, mod->init_size + mod->core_size);
 	print_unload_info(m, mod);
+	seq_printf(m, "\n");
 	return 0;
 }
+
+/* Format: modulename size refcount deps
+
+   Where refcount is a number or -, and deps is a comma-separated list
+   of depends or -.
+*/
 struct seq_operations modules_op = {
 	.start	= m_start,
 	.next	= m_next,
