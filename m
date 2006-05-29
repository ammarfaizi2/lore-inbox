Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWE2Vpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWE2Vpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWE2Vo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:44:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:8376 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751316AbWE2VXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:45 -0400
Date: Mon, 29 May 2006 23:24:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 12/61] lock validator: beautify x86_64 stacktraces
Message-ID: <20060529212405.GL3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

beautify x86_64 stacktraces to be more readable.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/traps.c  |   55 ++++++++++++++++++++------------------------
 include/asm-x86_64/kdebug.h |    2 -
 2 files changed, 27 insertions(+), 30 deletions(-)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -108,28 +108,30 @@ static inline void preempt_conditional_c
 static int kstack_depth_to_print = 10;
 
 #ifdef CONFIG_KALLSYMS
-#include <linux/kallsyms.h> 
-int printk_address(unsigned long address)
-{ 
+# include <linux/kallsyms.h>
+void printk_address(unsigned long address)
+{
 	unsigned long offset = 0, symsize;
 	const char *symname;
 	char *modname;
-	char *delim = ":"; 
+	char *delim = ":";
 	char namebuf[128];
 
-	symname = kallsyms_lookup(address, &symsize, &offset, &modname, namebuf); 
-	if (!symname) 
-		return printk("[<%016lx>]", address);
-	if (!modname) 
+	symname = kallsyms_lookup(address, &symsize, &offset, &modname, namebuf);
+	if (!symname) {
+		printk(" [<%016lx>]", address);
+		return;
+	}
+	if (!modname)
 		modname = delim = ""; 		
-        return printk("<%016lx>{%s%s%s%s%+ld}",
-		      address, delim, modname, delim, symname, offset); 
-} 
+	printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx",
+		address, delim, modname, delim, symname, offset, symsize);
+}
 #else
-int printk_address(unsigned long address)
-{ 
-	return printk("[<%016lx>]", address);
-} 
+void printk_address(unsigned long address)
+{
+	printk(" [<%016lx>]", address);
+}
 #endif
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
@@ -200,21 +202,14 @@ void show_trace(unsigned long *stack)
 {
 	const unsigned cpu = safe_smp_processor_id();
 	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
-	int i;
 	unsigned used = 0;
 
-	printk("\nCall Trace:");
+	printk("\nCall Trace:\n");
 
 #define HANDLE_STACK(cond) \
 	do while (cond) { \
 		unsigned long addr = *stack++; \
 		if (kernel_text_address(addr)) { \
-			if (i > 50) { \
-				printk("\n       "); \
-				i = 0; \
-			} \
-			else \
-				i += printk(" "); \
 			/* \
 			 * If the address is either in the text segment of the \
 			 * kernel, or in the region which contains vmalloc'ed \
@@ -223,20 +218,21 @@ void show_trace(unsigned long *stack)
 			 * down the cause of the crash will be able to figure \
 			 * out the call path that was taken. \
 			 */ \
-			i += printk_address(addr); \
+			printk_address(addr); \
+			printk("\n"); \
 		} \
 	} while (0)
 
-	for(i = 11; ; ) {
+	for ( ; ; ) {
 		const char *id;
 		unsigned long *estack_end;
 		estack_end = in_exception_stack(cpu, (unsigned long)stack,
 						&used, &id);
 
 		if (estack_end) {
-			i += printk(" <%s>", id);
+			printk(" <%s>", id);
 			HANDLE_STACK (stack < estack_end);
-			i += printk(" <EOE>");
+			printk(" <EOE>");
 			stack = (unsigned long *) estack_end[-2];
 			continue;
 		}
@@ -246,11 +242,11 @@ void show_trace(unsigned long *stack)
 				(IRQSTACKSIZE - 64) / sizeof(*irqstack);
 
 			if (stack >= irqstack && stack < irqstack_end) {
-				i += printk(" <IRQ>");
+				printk(" <IRQ>");
 				HANDLE_STACK (stack < irqstack_end);
 				stack = (unsigned long *) (irqstack_end[-1]);
 				irqstack_end = NULL;
-				i += printk(" <EOI>");
+				printk(" <EOI>");
 				continue;
 			}
 		}
@@ -259,6 +255,7 @@ void show_trace(unsigned long *stack)
 
 	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
+
 	printk("\n");
 }
 
Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h
+++ linux/include/asm-x86_64/kdebug.h
@@ -49,7 +49,7 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&die_chain, val, &args);
 } 
 
-extern int printk_address(unsigned long address);
+extern void printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);
 extern void __die(const char *,struct pt_regs *,long);
 extern void show_registers(struct pt_regs *regs);
