Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbSIYDSx>; Tue, 24 Sep 2002 23:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261885AbSIYDRw>; Tue, 24 Sep 2002 23:17:52 -0400
Received: from dp.samba.org ([66.70.73.150]:42880 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261888AbSIYDQq>;
	Tue, 24 Sep 2002 23:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 16/20: module_put_return for x86
Date: Wed, 25 Sep 2002 13:19:01 +1000
Message-Id: <20020925032201.7E5FE2C0B8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: module_put_return primitive for x86
Author: Rusty Russell
Status: Experimental
Depends: Module/forceunload.patch.gz

D: This patch implements module_put_return() for x86, which allows a
D: module to control its own reference counts in some cases.  A module
D: must never use module_put() on itself, since this may result in the
D: module being removable immediately: this is the alternative, which
D: atomically decrements the count and returns.
D:
D: Each architecture will need to implement this for preempt.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13134-linux-2.5.38/arch/i386/kernel/module.c .13134-linux-2.5.38.updated/arch/i386/kernel/module.c
--- .13134-linux-2.5.38/arch/i386/kernel/module.c	2002-09-25 02:02:28.000000000 +1000
+++ .13134-linux-2.5.38.updated/arch/i386/kernel/module.c	2002-09-25 02:02:56.000000000 +1000
@@ -28,6 +28,9 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+/* For the magic module return. */
+struct module_percpu module_percpu[NR_CPUS];
+
 static void *alloc_and_zero(unsigned long size)
 {
 	void *ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13134-linux-2.5.38/arch/i386/lib/module.S .13134-linux-2.5.38.updated/arch/i386/lib/module.S
--- .13134-linux-2.5.38/arch/i386/lib/module.S	1970-01-01 10:00:00.000000000 +1000
+++ .13134-linux-2.5.38.updated/arch/i386/lib/module.S	2002-09-25 02:02:56.000000000 +1000
@@ -0,0 +1,33 @@
+/* Icky, icky, return trampoline for dying modules.  Entered with
+   interrupts off.  (C) 2002 Stephen Rothwell, IBM Corporation. */
+
+#include <asm/thread_info.h>
+	
+.text
+.align 4
+.globl __magic_module_return
+
+#define MODULE_PERCPU_SIZE_ORDER 3
+	
+__magic_module_return:	
+	/* Save one working variable */
+	pushl	%eax
+
+	/* Get CPU number from current. */
+	GET_THREAD_INFO(%eax)
+	movl	TI_CPU(%eax), %eax
+
+	/* Push module_percpu[cpu].flags on the stack */
+	shll	$MODULE_PERCPU_SIZE_ORDER, %eax
+	pushl	module_percpu(%eax)
+
+	/* Put module_percpu[cpu].returnaddr into %eax */
+	movl	module_percpu+4(%eax), %eax
+
+	/* Push returnaddr and restore eax */
+	xchgl	%eax, 4(%esp)
+
+	/* Restore interrupts */
+	popf
+	/* Go home */
+	ret
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13134-linux-2.5.38/include/asm-i386/module.h .13134-linux-2.5.38.updated/include/asm-i386/module.h
--- .13134-linux-2.5.38/include/asm-i386/module.h	2002-09-25 02:02:28.000000000 +1000
+++ .13134-linux-2.5.38.updated/include/asm-i386/module.h	2002-09-25 02:02:56.000000000 +1000
@@ -8,4 +8,33 @@ struct mod_arch_specific
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+
+/* Non-preemtible decrement the refcount and return. */
+#define module_put_return(firstarg , ...)				    \
+do {									    \
+	unsigned int cpu;						    \
+	unsigned long flags;						    \
+									    \
+	local_irq_save(flags);						    \
+	if (unlikely(module_put(THIS_MODULE)) {				    \
+		module_percpu[cpu].flags = flags;			    \
+		module_percpu[cpu].returnaddr = ((void **)&(firstarg))[-1]; \
+		((void **)&(firstarg))[-1] = __magic_module_return;	    \
+	} else								    \
+		local_irq_restore(flags);				    \
+	return __VA_ARGS__;						    \
+} while(0)
+
+/* FIXME: Use per-cpu vars --RR */
+struct module_percpu
+{
+	unsigned long flags;
+	void *returnaddr;
+};
+
+extern struct module_percpu module_percpu[NR_CPUS];
+
+/* Restore flags and return to caller. */
+extern void __magic_module_return(void);
+
 #endif /* _ASM_I386_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13134-linux-2.5.38/kernel/module.c .13134-linux-2.5.38.updated/kernel/module.c
--- .13134-linux-2.5.38/kernel/module.c	2002-09-25 02:02:32.000000000 +1000
+++ .13134-linux-2.5.38.updated/kernel/module.c	2002-09-25 02:03:37.000000000 +1000
@@ -267,9 +267,11 @@ sys_delete_module(const char *name_user,
 			goto reanimate;
 
 	/* Since it's not live, count should monotonically decrease. */
-	if (!forced)
+	if (!forced) {
 		bigref_wait_for_zero(&mod->use);
-	else {
+		/* Wait in case they are using module_put_return */
+		synchronize_kernel();
+	} else {
 		printk(KERN_WARNING "Forced removal of %s.\n", mod->name);
 		tainted |= TAINT_FORCED_RMMOD;
 	}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
