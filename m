Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbTCRPtA>; Tue, 18 Mar 2003 10:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbTCRPtA>; Tue, 18 Mar 2003 10:49:00 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:29446 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262509AbTCRPs6>; Tue, 18 Mar 2003 10:48:58 -0500
Date: Tue, 18 Mar 2003 15:59:54 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] module load notification try 2
Message-ID: <20030318155953.GA97463@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18vJVK-0009Bg-00*JJT9gnkijMM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty, any happier with this one ?

The below implements a module load notification for oprofile's benefit.
The oprofile part is not attached here, but seems to work OK.

regards
john


diff -Naur -X dontdiff linux-linus/include/linux/module.h up/include/linux/module.h
--- linux-linus/include/linux/module.h	2003-03-17 21:44:38.000000000 +0000
+++ up/include/linux/module.h	2003-03-18 14:34:07.000000000 +0000
@@ -142,6 +142,7 @@
 	const struct exception_table_entry *entry;
 };
 
+struct notifier_block;
 
 #ifdef CONFIG_MODULES
 
@@ -352,6 +353,9 @@
 /* For extable.c to search modules' exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr);
 
+int register_module_notifier(struct notifier_block * nb);
+int unregister_module_notifier(struct notifier_block * nb);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -396,6 +400,17 @@
 {
 	return NULL;
 }
+
+static inline int register_module_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
+
+static inline int unregister_module_notifier(struct notifier_block * nb)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef MODULE
diff -Naur -X dontdiff linux-linus/kernel/module.c up/kernel/module.c
--- linux-linus/kernel/module.c	2003-03-17 21:44:21.000000000 +0000
+++ up/kernel/module.c	2003-03-18 15:42:56.000000000 +0000
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
