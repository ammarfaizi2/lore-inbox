Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268937AbRHBOHA>; Thu, 2 Aug 2001 10:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268935AbRHBOGv>; Thu, 2 Aug 2001 10:06:51 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:56836 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S268936AbRHBOGg>; Thu, 2 Aug 2001 10:06:36 -0400
Date: Thu, 2 Aug 2001 16:06:43 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hugh Dickins <hugh@veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] show_trace() module_end = 0?
Message-ID: <Pine.LNX.4.33.0108021553500.7060-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jul 2001, Linus Torvalds wrote:

> On Thu, 12 Jul 2001, Hugh Dickins wrote:
> >
> > show_trace() contains an erroneous line, introduced in 2.4.6-pre4,
> > which disables trace on module text: appears to be from temporary
> > testing, since code and comments for tracing module text remain.
> 
> It as actually disabled on purpose.
> 
> It's there because without it the backtrace is sometimes so full of crud
> that it is almost impossible to read.
> 
> I chose to disable the module back-trace, because what we should _really_
> do is to walk the vmalloc space and verify whether it's a valid address or
> not. But as I don't use modules myself, I didn't have much incentive to do
> so, or to test that it worked.
> 
> The simple "disable module backtraces" approach at least makes the normal
> backtraces possible to read sanely (well, you still have the issue that
> gcc often ends up leaving tons of empty stackslots around and those can
> contain stale information, but that can't be fixed as easily).

As I need module back traces once in a while, I was not really happy with 
the current approach. I coded a patch which will reenable printing a call 
trace including addresses in modules.

I'm not sure if this an approach you would accept. The code makes sure
that only addresses within a vmalloc'ed module area are printed, not
everything between VMALLOC_START and _END. However, we don't distinguish
between module .text as opposed to .data, .bss... Doing so seems a lot
harder to implement.

The other, minor problem is that we should walk the module_list under 
lock_kernel() only, but I wasn't brave enough to add this to the 
show_trace() code path.

Comments?

--Kai

diff -ur linux-2.4.7/arch/i386/kernel/traps.c linux-2.4.7.work/arch/i386/kernel/traps.c
--- linux-2.4.7/arch/i386/kernel/traps.c	Wed Jun 20 22:59:44 2001
+++ linux-2.4.7.work/arch/i386/kernel/traps.c	Thu Aug  2 14:44:44 2001
@@ -48,6 +48,7 @@
 #endif
 
 #include <linux/irq.h>
+#include <linux/module.h>
 
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
@@ -89,36 +90,60 @@
 int kstack_depth_to_print = 24;
 
 /*
- * These constants are for searching for possible module text
- * segments.
+ * If the address is either in the .text section of the
+ * kernel, or in the vmalloc'ed module regions, it *may* 
+ * be the address of a calling routine
  */
+#ifdef CONFIG_MODULES
+
+extern struct module *module_list;
+extern struct module kernel_module;
+
+static inline int kernel_text_address(unsigned long addr)
+{
+	int retval = 0;
+	struct module *mod;
+
+	if (addr >= (unsigned long) &_stext &&
+	    addr <= (unsigned long) &_etext)
+		return 1;
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		/* mod_bound tests for addr being inside the vmalloc'ed
+		 * module area. Of course it'd be better to test only
+		 * for the .text subset... */
+		if (mod_bound(addr, 0, mod)) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
+#else
+
+static inline int kernel_text_address(unsigned long addr)
+{
+	return (addr >= (unsigned long) &_stext &&
+		addr <= (unsigned long) &_etext);
+}
+
+#endif
 
 void show_trace(unsigned long * stack)
 {
 	int i;
-	unsigned long addr, module_start, module_end;
+	unsigned long addr;
 
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
 	printk("Call Trace: ");
 	i = 1;
-	module_start = VMALLOC_START;
-	module_end = VMALLOC_END;
-	module_end = 0;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
-		/*
-		 * If the address is either in the text segment of the
-		 * kernel, or in the region which contains vmalloc'ed
-		 * memory, it *may* be the address of a calling
-		 * routine; if so, print it so that someone tracing
-		 * down the cause of the crash will be able to figure
-		 * out the call path that was taken.
-		 */
-		if (((addr >= (unsigned long) &_stext) &&
-		     (addr <= (unsigned long) &_etext)) ||
-		    ((addr >= module_start) && (addr <= module_end))) {
+		if (kernel_text_address(addr)) {
 			if (i && ((i % 8) == 0))
 				printk("\n       ");
 			printk("[<%08lx>] ", addr);
diff -ur linux-2.4.7/kernel/module.c linux-2.4.7.work/kernel/module.c
--- linux-2.4.7/kernel/module.c	Wed May  2 01:05:00 2001
+++ linux-2.4.7.work/kernel/module.c	Thu Aug  2 13:44:19 2001
@@ -39,7 +39,7 @@
 extern const char __start___kallsyms[] __attribute__ ((weak));
 extern const char __stop___kallsyms[] __attribute__ ((weak));
 
-static struct module kernel_module =
+struct module kernel_module =
 {
 	size_of_struct:		sizeof(struct module),
 	name: 			"",

