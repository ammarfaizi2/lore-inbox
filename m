Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTCYBwN>; Mon, 24 Mar 2003 20:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbTCYBwN>; Mon, 24 Mar 2003 20:52:13 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:36615 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261364AbTCYBwI>; Mon, 24 Mar 2003 20:52:08 -0500
Date: Tue, 25 Mar 2003 02:03:16 +0000
From: John Levon <levon@movementarian.org>
To: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH 1/2] Module load notification take 3
Message-ID: <20030325020316.GA95492@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18xdmW-000K2J-00*2SbKMSnknuo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implement a module load notifier for the benefit of OProfile, tested
with .66 on UP.

This patch (1/2) provides the general support for registering notifiers,
and calls the notifier when a module is loaded.

Please apply.

john


diff -X dontdiff -Naur linux-linus/include/linux/module.h linux-cvs/include/linux/module.h
--- linux-linus/include/linux/module.h	2003-03-25 01:38:51.000000000 +0000
+++ linux-cvs/include/linux/module.h	2003-03-25 01:34:42.000000000 +0000
@@ -138,6 +138,7 @@
 	const struct exception_table_entry *entry;
 };
 
+struct notifier_block;
 
 #ifdef CONFIG_MODULES
 
@@ -348,6 +349,9 @@
 /* For extable.c to search modules' exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr);
 
+int register_module_notifier(struct notifier_block * nb);
+int unregister_module_notifier(struct notifier_block * nb);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -392,6 +396,18 @@
 {
 	return NULL;
 }
+
+static inline int register_module_notifier(struct notifier_block * nb)
+{
+	/* no events will happen anyway, so this can always succeed */
+	return 0;
+}
+
+static inline int unregister_module_notifier(struct notifier_block * nb)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef MODULE
diff -X dontdiff -Naur linux-linus/kernel/module.c linux-cvs/kernel/module.c
--- linux-linus/kernel/module.c	2003-03-17 21:44:21.000000000 +0000
+++ linux-cvs/kernel/module.c	2003-03-25 01:31:40.000000000 +0000
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
+#include <linux/notifier.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -61,6 +62,29 @@
 static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block * module_notify_list;
+
+int register_module_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_register(&module_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(register_module_notifier);
+
+int unregister_module_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_unregister(&module_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(unregister_module_notifier);
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -1368,6 +1392,10 @@
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
+	up(&notify_mutex);
+
 	/* Start the module */
 	ret = mod->init();
 	if (ret < 0) {

