Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVHDAfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVHDAfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVHDAfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:35:15 -0400
Received: from mail02.hansenet.de ([213.191.73.62]:49092 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261662AbVHDAez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:34:55 -0400
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: rusty@rustcorp.com.au
Subject: [PATCH] flush icache early when loading module
Date: Thu, 4 Aug 2005 02:34:49 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040234.49661.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below, created against linux-2.6.12.3, changes the sequence of
operations performed during module loading to flush the instruction cache
before module parameters are processed. If a module has parameters of an
unusual type that cannot be handled using the standard accessor functions
param_set_xxx and param_get_xxx, it has to to provide a set of accessor
functions for this type. This requires module code to be executed during
parameter processing, which is of course only possible after the icache
has been flushed.

Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>





--- linux-2.6.12.3-orig/kernel/module.c	2005-08-04 01:11:32.000000000 +0200
+++ linux-2.6.12.3/kernel/module.c	2005-08-04 02:00:16.000000000 +0200
@@ -1413,6 +1413,7 @@ static struct module *load_module(void _
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
 	struct exception_table_entry *extable;
+	mm_segment_t old_fs;
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -1677,6 +1678,24 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto cleanup;
 
+	/* flush the icache in correct context */
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	/*
+	 * Flush the instruction cache, since we've played with text.
+	 * Do it before processing of module parameters, so the module
+	 * can provide parameter accessor functions of its own.
+	 */
+	if (mod->module_init)
+		flush_icache_range((unsigned long)mod->module_init,
+				   (unsigned long)mod->module_init
+				   + mod->init_size);
+	flush_icache_range((unsigned long)mod->module_core,
+			   (unsigned long)mod->module_core + mod->core_size);
+
+	set_fs(old_fs);
+
 	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
@@ -1758,7 +1777,6 @@ sys_init_module(void __user *umod,
 		const char __user *uargs)
 {
 	struct module *mod;
-	mm_segment_t old_fs = get_fs();
 	int ret = 0;
 
 	/* Must have permission */
@@ -1776,19 +1794,6 @@ sys_init_module(void __user *umod,
 		return PTR_ERR(mod);
 	}
 
-	/* flush the icache in correct context */
-	set_fs(KERNEL_DS);
-
-	/* Flush the instruction cache, since we've played with text */
-	if (mod->module_init)
-		flush_icache_range((unsigned long)mod->module_init,
-				   (unsigned long)mod->module_init
-				   + mod->init_size);
-	flush_icache_range((unsigned long)mod->module_core,
-			   (unsigned long)mod->module_core + mod->core_size);
-
-	set_fs(old_fs);
-
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
 	stop_machine_run(__link_module, mod, NR_CPUS);

-- 
Thomas Koeller
thomas@koeller.dyndns.org
