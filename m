Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313487AbSC2Rib>; Fri, 29 Mar 2002 12:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313489AbSC2RiU>; Fri, 29 Mar 2002 12:38:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313487AbSC2RiQ>;
	Fri, 29 Mar 2002 12:38:16 -0500
Message-ID: <3CA4A61A.A844E21B@zip.com.au>
Date: Fri, 29 Mar 2002 09:36:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Christoph Hellwig <hch@infradead.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <20020329160618.A25410@phoenix.infradead.org> <15524.40817.306204.292158@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> ..
>   Christoph> So your suggestion is to move the other architectures to
>   Christoph> the ia64 prototype or to not have an
>   Christoph> architecture-independand stack-traceback facility at all?
> 
> I haven't done such an investigation.  I believe the ia64 prototype is
> reasonable and probably implementable on all platforms that can unwind
> the stack in the first place, but before making a change to the stable
> kernel API, I'd think someone would have to investigate this a bit
> further.
> 

The way I ended up resolving these sorts of issues was to 
make the generic function

	void dump_stack(void);

under the (hopefully valid) assumption that all architectures
can somehow, in some manner, manage to spit out something
useful.

For a transitional/compatibility think, there's lib/dump_stack.c
which just prints "I'm broken".

Here's the diff.  Comments?


--- 2.4.19-pre4/include/linux/kernel.h~aa-094-dump_stack	Tue Mar 26 23:11:27 2002
+++ 2.4.19-pre4-akpm/include/linux/kernel.h	Tue Mar 26 23:11:27 2002
@@ -106,6 +106,8 @@ extern int oops_in_progress;		/* If set,
 extern int tainted;
 extern const char *print_tainted(void);
 
+extern void dump_stack(void);
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.4.19-pre4-akpm/lib/dump_stack.c	Tue Mar 26 23:11:27 2002
@@ -0,0 +1,13 @@
+/*
+ * Provide a default dump_stack() function for architectures
+ * which don't implement their own.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+void dump_stack(void)
+{
+	printk(KERN_NOTICE
+		"This architecture does not implement dump_stack()\n");
+}
--- 2.4.19-pre4/lib/Makefile~aa-094-dump_stack	Tue Mar 26 23:11:27 2002
+++ 2.4.19-pre4-akpm/lib/Makefile	Tue Mar 26 23:11:27 2002
@@ -10,7 +10,8 @@ L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
+		bust_spinlocks.o rbtree.o dump_stack.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
--- 2.4.19-pre4/kernel/ksyms.c~aa-094-dump_stack	Tue Mar 26 23:11:27 2002
+++ 2.4.19-pre4-akpm/kernel/ksyms.c	Tue Mar 26 23:11:27 2002
@@ -560,3 +560,6 @@ EXPORT_SYMBOL(init_task_union);
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+/* debug */
+EXPORT_SYMBOL(dump_stack);
--- 2.4.19-pre4/arch/i386/kernel/traps.c~aa-094-dump_stack	Tue Mar 26 23:11:27 2002
+++ 2.4.19-pre4-akpm/arch/i386/kernel/traps.c	Tue Mar 26 23:11:27 2002
@@ -186,6 +186,14 @@ void show_stack(unsigned long * esp)
 	show_trace(esp);
 }
 
+/*
+ * The architecture-independent backtrace generator
+ */
+void dump_stack(void)
+{
+	show_stack(0);
+}
+
 void show_registers(struct pt_regs *regs)
 {
 	int i;
