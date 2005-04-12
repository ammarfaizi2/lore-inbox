Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVDLT3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVDLT3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDLT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:29:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:17353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbVDLKcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:18 -0400
Message-Id: <200504121032.j3CAWCkx005532@shell0.pdx.osdl.net>
Subject: [patch 099/198] x86_64: Rewrite exception stack backtracing
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       jbeulich@novell.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Exceptions and hardware interrupts can, to a certain degree, nest, so when
attempting to follow the sequence of stacks used in order to dump their
contents this has to be accounted for.  Also, IST stacks have their tops
stored in the TSS, so there's no need to add the stack size to get to their
ends.

Minor changes from AK.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/traps.c |  147 +++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 68 deletions(-)

diff -puN arch/x86_64/kernel/traps.c~x86_64-rewrite-exception-stack-backtracing arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-rewrite-exception-stack-backtracing	2005-04-12 03:21:26.735072552 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:26.740071792 -0700
@@ -120,95 +120,106 @@ int printk_address(unsigned long address
 } 
 #endif
 
-unsigned long *in_exception_stack(int cpu, unsigned long stack) 
-{ 
-	int k;
+static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
+					unsigned *usedp, const char **idp)
+{
+	static const char ids[N_EXCEPTION_STACKS][8] = {
+		[DEBUG_STACK - 1] = "#DB",
+		[NMI_STACK - 1] = "NMI",
+		[DOUBLEFAULT_STACK - 1] = "#DF",
+		[STACKFAULT_STACK - 1] = "#SS",
+		[MCE_STACK - 1] = "#MC",
+	};
+	unsigned k;
+
 	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		struct tss_struct *tss = &per_cpu(init_tss, cpu);
-		unsigned long start = tss->ist[k] - EXCEPTION_STKSZ;
+		unsigned long end;
 
-		if (stack >= start && stack < tss->ist[k])
-			return (unsigned long *)tss->ist[k];
+		end = per_cpu(init_tss, cpu).ist[k];
+		if (stack >= end)
+			continue;
+		if (stack >= end - EXCEPTION_STKSZ) {
+			if (*usedp & (1U << k))
+				break;
+			*usedp |= 1U << k;
+			*idp = ids[k];
+			return (unsigned long *)end;
+		}
 	}
 	return NULL;
-} 
+}
 
 /*
  * x86-64 can have upto three kernel stacks: 
  * process stack
  * interrupt stack
- * severe exception (double fault, nmi, stack fault) hardware stack
- * Check and process them in order.
+ * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
 void show_trace(unsigned long *stack)
 {
 	unsigned long addr;
-	unsigned long *irqstack, *irqstack_end, *estack_end;
-	const int cpu = safe_smp_processor_id();
+	const unsigned cpu = safe_smp_processor_id();
+	unsigned long *irqstack_end = (unsigned long *)cpu_pda[cpu].irqstackptr;
 	int i;
+	unsigned used = 0;
 
 	printk("\nCall Trace:");
-	i = 0; 
-	
-	estack_end = in_exception_stack(cpu, (unsigned long)stack); 
-	if (estack_end) { 
-		while (stack < estack_end) { 
-			addr = *stack++; 
-			if (__kernel_text_address(addr)) {
-				i += printk_address(addr);
-				i += printk(" "); 
-				if (i > 50) {
-					printk("\n"); 
-					i = 0;
-				}
-			}
+
+#define HANDLE_STACK(cond) \
+	do while (cond) { \
+		addr = *stack++; \
+		if (kernel_text_address(addr)) { \
+			/* \
+			 * If the address is either in the text segment of the \
+			 * kernel, or in the region which contains vmalloc'ed \
+			 * memory, it *may* be the address of a calling \
+			 * routine; if so, print it so that someone tracing \
+			 * down the cause of the crash will be able to figure \
+			 * out the call path that was taken. \
+			 */ \
+			i += printk_address(addr); \
+			if (i > 50) { \
+				printk("\n       "); \
+				i = 0; \
+			} \
+			else \
+				i += printk(" "); \
+		} \
+	} while (0)
+
+	for(i = 0; ; ) {
+		const char *id;
+		unsigned long *estack_end;
+		estack_end = in_exception_stack(cpu, (unsigned long)stack,
+						&used, &id);
+
+		if (estack_end) {
+			i += printk(" <%s> ", id);
+			HANDLE_STACK (stack < estack_end);
+			i += printk(" <EOE> ");
+			stack = (unsigned long *) estack_end[-2];
+			continue;
 		}
-		i += printk(" <EOE> "); 
-		i += 7;
-		stack = (unsigned long *) estack_end[-2]; 
-	}  
-
-	irqstack_end = (unsigned long *) (cpu_pda[cpu].irqstackptr);
-	irqstack = (unsigned long *) (cpu_pda[cpu].irqstackptr - IRQSTACKSIZE + 64);
-
-	if (stack >= irqstack && stack < irqstack_end) {
-		printk("<IRQ> ");  
-		while (stack < irqstack_end) {
-			addr = *stack++;
-			/*
-			 * If the address is either in the text segment of the
-			 * kernel, or in the region which contains vmalloc'ed
-			 * memory, it *may* be the address of a calling
-			 * routine; if so, print it so that someone tracing
-			 * down the cause of the crash will be able to figure
-			 * out the call path that was taken.
-			 */
-			 if (__kernel_text_address(addr)) {
-				 i += printk_address(addr);
-				 i += printk(" "); 
-				 if (i > 50) { 
-					printk("\n       ");
-					 i = 0;
-				 } 
+		if (irqstack_end) {
+			unsigned long *irqstack;
+			irqstack = irqstack_end -
+				(IRQSTACKSIZE - 64) / sizeof(*irqstack);
+
+			if (stack >= irqstack && stack < irqstack_end) {
+				i += printk(" <IRQ> ");
+				HANDLE_STACK (stack < irqstack_end);
+				stack = (unsigned long *) (irqstack_end[-1]);
+				irqstack_end = NULL;
+				i += printk(" <EOI> ");
+				continue;
 			}
-		} 
-		stack = (unsigned long *) (irqstack_end[-1]);
-		printk(" <EOI> ");
-		i += 7;
-	} 
-
-	while (((long) stack & (THREAD_SIZE-1)) != 0) {
-		addr = *stack++;
-		if (__kernel_text_address(addr)) {
-			i += printk_address(addr);
-			i += printk(" "); 
-			if (i > 50) { 
-				printk("\n       ");
-					 i = 0;
-			} 
 		}
+		break;
 	}
+
+	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
+#undef HANDLE_STACK
 	printk("\n");
 }
 
_
