Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbSLRJCF>; Wed, 18 Dec 2002 04:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSLRJCF>; Wed, 18 Dec 2002 04:02:05 -0500
Received: from dp.samba.org ([66.70.73.150]:4549 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267213AbSLRJCC>;
	Wed, 18 Dec 2002 04:02:02 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/modules format change
Date: Wed, 18 Dec 2002 20:04:50 +1100
Message-Id: <20021218091001.CFECD2C062@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New extensible format uses comma-separated dependencies or "-":

ipaq 6360 0 -
usbserial 22621 1 ipaq,
usbcore 53148 2 ipaq,usbserial,

Name: /proc/modules rework
Author: Rusty Russell
Status: Tested on 2.5.52

D: This changes the dependency list in /proc/modules to be one field,
D: rather than a space-separated set of dependencies, and makes sure
D: the contents are there even if CONFIG_MODULE_UNLOAD is off.
D:
D: This allows us to append fields (eg. the module address for
D: oprofile, and the module status) without breaking userspace.
D: module-init-tools already handles this format (which you can detect
D: by the presence of "-" or "," in the fourth field).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/kernel/module.c working-2.5.52-procmodules/kernel/module.c
--- linux-2.5.52/kernel/module.c	Tue Dec 17 08:11:03 2002
+++ working-2.5.52-procmodules/kernel/module.c	Wed Dec 18 19:04:59 2002
@@ -464,19 +464,29 @@ sys_delete_module(const char *name_user,
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
 
-	if (!mod->exit)
-		seq_printf(m, " [permanent]");
+	if (!mod->exit) {
+		printed_something = 1;
+		seq_printf(m, "[permanent],");
+	}
 
-	seq_printf(m, "\n");
+	if (!printed_something)
+		seq_printf(m, "-");
 }
 
 void __symbol_put(const char *symbol)
@@ -517,7 +527,8 @@ EXPORT_SYMBOL_GPL(symbol_put_addr);
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
-	seq_printf(m, "\n");
+	/* We don't know the usage count, or what modules are using. */
+	seq_printf(m, " - -");
 }
 
 static inline void module_unload_free(struct module *mod)
@@ -1400,6 +1411,7 @@ static int m_show(struct seq_file *m, vo
 	seq_printf(m, "%s %lu",
 		   mod->name, mod->init_size + mod->core_size);
 	print_unload_info(m, mod);
+	seq_printf(m, "\n");
 	return 0;
 }
 struct seq_operations modules_op = {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
