Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270437AbTGPIdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTGPIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:31:44 -0400
Received: from dp.samba.org ([66.70.73.150]:15779 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270437AbTGPI0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:26:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] module.h to use local_t
Date: Wed, 16 Jul 2003 18:40:52 +1000
Message-Id: <20030716084132.377502C226@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  module.h defined local_inc/dec for arch
overriding, now it's generic.

Name: Use local_t for module reference counts
Author: Rusty Russell
Depends: Percpu/local_t.patch.gz
Status: Booted on 2.6.0-test1

D: Uses local_t for module reference counts.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4869-2.5.75-bk3-refcnt_local_t.pre/include/linux/module.h .4869-2.5.75-bk3-refcnt_local_t/include/linux/module.h
--- .4869-2.5.75-bk3-refcnt_local_t.pre/include/linux/module.h	2003-07-03 09:44:00.000000000 +1000
+++ .4869-2.5.75-bk3-refcnt_local_t/include/linux/module.h	2003-07-14 11:32:11.000000000 +1000
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <asm/local.h>
 
 #include <asm/module.h>
 
@@ -171,7 +172,7 @@ void *__symbol_get_gpl(const char *symbo
 
 struct module_ref
 {
-	atomic_t count;
+	local_t count;
 } ____cacheline_aligned;
 
 enum module_state
@@ -283,12 +284,6 @@ void __symbol_put(const char *symbol);
 #define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
 void symbol_put_addr(void *addr);
 
-/* We only need protection against local interrupts. */
-#ifndef __HAVE_ARCH_LOCAL_INC
-#define local_inc(x) atomic_inc(x)
-#define local_dec(x) atomic_dec(x)
-#endif
-
 /* Sometimes we know we already have a refcount, and it's easier not
    to handle the error case (which only happens with rmmod --wait). */
 static inline void __module_get(struct module *module)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4869-2.5.75-bk3-refcnt_local_t.pre/kernel/module.c .4869-2.5.75-bk3-refcnt_local_t/kernel/module.c
--- .4869-2.5.75-bk3-refcnt_local_t.pre/kernel/module.c	2003-07-03 09:44:01.000000000 +1000
+++ .4869-2.5.75-bk3-refcnt_local_t/kernel/module.c	2003-07-14 11:32:11.000000000 +1000
@@ -374,9 +374,9 @@ static void module_unload_init(struct mo
 
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
-		atomic_set(&mod->ref[i].count, 0);
+		local_set(&mod->ref[i].count, 0);
 	/* Hold reference count during initialization. */
-	atomic_set(&mod->ref[smp_processor_id()].count, 1);
+	local_set(&mod->ref[smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
 	mod->waiter = current;
 }
@@ -599,7 +599,7 @@ unsigned int module_refcount(struct modu
 	unsigned int i, total = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		total += atomic_read(&mod->ref[i].count);
+		total += local_read(&mod->ref[i].count);
 	return total;
 }
 EXPORT_SYMBOL(module_refcount);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
