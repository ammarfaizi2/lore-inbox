Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbSITJXv>; Fri, 20 Sep 2002 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbSITJXv>; Fri, 20 Sep 2002 05:23:51 -0400
Received: from dp.samba.org ([66.70.73.150]:6101 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262017AbSITJXr>;
	Fri, 20 Sep 2002 05:23:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       mingo@redhat.com, davem@redhat.com, sfr@canb.auug.org.au
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Thu, 19 Sep 2002 21:32:36 MST."
             <20020920043236.GA19637@kroah.com> 
Date: Fri, 20 Sep 2002 19:25:47 +1000
Message-Id: <20020920092853.777582C0F5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020920043236.GA19637@kroah.com> you write:
> On Fri, Sep 20, 2002 at 11:22:08AM +1000, Rusty Russell wrote:
> > In message <20020919183843.GA16568@kroah.com> you write:
> > > On Thu, Sep 19, 2002 at 03:54:40PM +0200, Roman Zippel wrote:
> > > > I already said often enough, a module has only to answer the simple
> > > > question: Is it safe to unload the module?
> > > 
> > > And with a LSM module, how can it answer that?  There's no way, unless
> > > we count every time someone calls into our module.  And if you do that,
> > > no one will even want to use your module, given the number of hooks, and
> > > the paths those hooks are on (the speed hit would be horrible.)
> > 
> > Well, it's up to you.  You *could* implement:
> 
> <snip>
> 
> Ok, now that's just sick and twisted enough that it might just work.  I
> really don't want to use a macro for the security functions, but this
> provides type safety, and... well...  I'm at a loss of words, and just
> amazed...

Then you'll love this.

This allows modules to safely look after their own reference counts
even with preemption and without requiring rcu-like scheduler changes
(synchronize_kernel here simple schedules itself on each CPU in turn).

Thanks to Stephen Rothwell for the Intel asm (ie. the tricky bit).

[ Roman: I'm not really serious about this, but it maybe someone will
  really want to control their own counts... ]

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: module_put_return primitive for x86
Author: Rusty Russell
Status: Experimental
Depends: Module/modbase-try-i386.patch.gz

D: This patch implements module_put_return() for x86, which allows a
D: module to control its own reference counts.  A module must never
D: use module_put() on itself, since this may result in the module
D: being removable immediately: this is the alternative, which
D: atomically decrements the count and returns.
D:
D: Each architecture would need to implement this.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.36-modbase-try-i386/arch/i386/kernel/module.c working-2.5.36-modbase-try-i386-decandret/arch/i386/kernel/module.c
--- working-2.5.36-modbase-try-i386/arch/i386/kernel/module.c	2002-09-20 13:32:20.000000000 +1000
+++ working-2.5.36-modbase-try-i386-decandret/arch/i386/kernel/module.c	2002-09-20 14:24:35.000000000 +1000
@@ -28,6 +28,9 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+/* For the magic module return. */
+struct module_percpu module_percpu[NR_CPUS];
+
 static void *alloc_and_zero(unsigned long size)
 {
 	void *ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.36-modbase-try-i386/arch/i386/lib/module.S working-2.5.36-modbase-try-i386-decandret/arch/i386/lib/module.S
--- working-2.5.36-modbase-try-i386/arch/i386/lib/module.S	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5.36-modbase-try-i386-decandret/arch/i386/lib/module.S	2002-09-20 13:50:37.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.36-modbase-try-i386/include/asm-i386/module.h working-2.5.36-modbase-try-i386-decandret/include/asm-i386/module.h
--- working-2.5.36-modbase-try-i386/include/asm-i386/module.h	2002-09-20 13:32:20.000000000 +1000
+++ working-2.5.36-modbase-try-i386-decandret/include/asm-i386/module.h	2002-09-20 14:24:07.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.36-modbase-try-i386/kernel/module.c working-2.5.36-modbase-try-i386-decandret/kernel/module.c
--- working-2.5.36-modbase-try-i386/kernel/module.c	2002-09-20 13:32:20.000000000 +1000
+++ working-2.5.36-modbase-try-i386-decandret/kernel/module.c	2002-09-20 14:35:10.000000000 +1000
@@ -229,6 +229,9 @@ sys_delete_module(const char *name_user,
 	/* Since it's not live, this should monotonically decrease. */
 	bigref_wait_for_zero(&mod->use);
 
+	/* Wait in case doing own refcounts and using module_put_return */
+	synchronize_kernel();
+
 	/* Final destruction now noone is using it. */
 	mod->exit();
 	free_module(mod);
