Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTBRExx>; Mon, 17 Feb 2003 23:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTBRExx>; Mon, 17 Feb 2003 23:53:53 -0500
Received: from dp.samba.org ([66.70.73.150]:27795 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267605AbTBRExs>;
	Mon, 17 Feb 2003 23:53:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible? 
In-reply-to: Your message of "Mon, 17 Feb 2003 22:18:37 -0300."
             <20030217221837.Q2092@almesberger.net> 
Date: Tue, 18 Feb 2003 15:54:12 +1100
Message-Id: <20030218050349.44B092C04E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030217221837.Q2092@almesberger.net> you write:
> > failure: if the object is still busy, we just return -EBUSY. This is 
> > simple, but this doesn't work for modules, since during module exit you 
> > can't fail anymore.

Of course, they never could fail module exit.  You could use
can_unload() which was only protected by the BKL, hence so rarely
used: grep 2.4.20 to see all four users.

Having a separate can_unload function means a window between asking
can_unload() and doing the actual unload.  Doing it in the function
itself (ie. cleanup returns an int, or a separate "prepare_to_unload"
kind of function) means you have to deal with the "I started
deregistering my stuff, but then had to re-register them" which leaves
a race where the module is partially unavailable (ie. the spurious
failure problem).

Both these problems are soluble, but they're not trivial.

> That's a modules API problem. And yes, I think modules should
> eventually be able to say that they're busy.

Take a look at the current ip_conntrack code.  It keeps its own
reference count and spins until it hits zero in unload, because
otherwise it would never be unloadable (it attaches a callback to each
packet, so logically it would bump its refcount there).  In 2.5 it can
use try_module_get() and be unloaded with rmmod --wait in this worst
case (I'm slack, patching is on my todo list).

Security modules have the same issues, and Greg Kroah-Hartmann was
telling me USB has it as well.

You can see why I considered deprecating module unloading: it's a hard
problem, and fixing it in general probably means massive changes.
Which I'm happy to leave to someone else.

> By the way, a loong time ago, in the modules thread, I suggested
> a "decrement_module_count_and_return" function [1]. Such a
> construct would be useful in this specific case.

Stephen and I even implemented one, for x86 (see below).  But
implementing the matching "enter and inc" case remains problematic, so
I dropped that idea.

Anyway, good luck!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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
