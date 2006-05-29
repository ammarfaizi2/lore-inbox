Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWE2Vmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWE2Vmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWE2VYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9656 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751334AbWE2VXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:49 -0400
Date: Mon, 29 May 2006 23:24:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 13/61] lock validator: x86_64: document stack frame internals
Message-ID: <20060529212409.GM3155@elte.hu>
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

document stack frame nesting internals some more.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/traps.c |   64 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -134,8 +134,9 @@ void printk_address(unsigned long addres
 }
 #endif
 
-static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
-					unsigned *usedp, const char **idp)
+unsigned long *
+in_exception_stack(unsigned cpu, unsigned long stack, unsigned *usedp,
+		   const char **idp)
 {
 	static char ids[][8] = {
 		[DEBUG_STACK - 1] = "#DB",
@@ -149,10 +150,22 @@ static unsigned long *in_exception_stack
 	};
 	unsigned k;
 
+	/*
+	 * Iterate over all exception stacks, and figure out whether
+	 * 'stack' is in one of them:
+	 */
 	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
 		unsigned long end;
 
+		/*
+		 * set 'end' to the end of the exception stack.
+		 */
 		switch (k + 1) {
+		/*
+		 * TODO: this block is not needed i think, because
+		 * setup64.c:cpu_init() sets up t->ist[DEBUG_STACK]
+		 * properly too.
+		 */
 #if DEBUG_STKSZ > EXCEPTION_STKSZ
 		case DEBUG_STACK:
 			end = cpu_pda(cpu)->debugstack + DEBUG_STKSZ;
@@ -162,19 +175,43 @@ static unsigned long *in_exception_stack
 			end = per_cpu(init_tss, cpu).ist[k];
 			break;
 		}
+		/*
+		 * Is 'stack' above this exception frame's end?
+		 * If yes then skip to the next frame.
+		 */
 		if (stack >= end)
 			continue;
+		/*
+		 * Is 'stack' above this exception frame's start address?
+		 * If yes then we found the right frame.
+		 */
 		if (stack >= end - EXCEPTION_STKSZ) {
+			/*
+			 * Make sure we only iterate through an exception
+			 * stack once. If it comes up for the second time
+			 * then there's something wrong going on - just
+			 * break out and return NULL:
+			 */
 			if (*usedp & (1U << k))
 				break;
 			*usedp |= 1U << k;
 			*idp = ids[k];
 			return (unsigned long *)end;
 		}
+		/*
+		 * If this is a debug stack, and if it has a larger size than
+		 * the usual exception stacks, then 'stack' might still
+		 * be within the lower portion of the debug stack:
+		 */
 #if DEBUG_STKSZ > EXCEPTION_STKSZ
 		if (k == DEBUG_STACK - 1 && stack >= end - DEBUG_STKSZ) {
 			unsigned j = N_EXCEPTION_STACKS - 1;
 
+			/*
+			 * Black magic. A large debug stack is composed of
+			 * multiple exception stack entries, which we
+			 * iterate through now. Dont look:
+			 */
 			do {
 				++j;
 				end -= EXCEPTION_STKSZ;
@@ -206,6 +243,11 @@ void show_trace(unsigned long *stack)
 
 	printk("\nCall Trace:\n");
 
+	/*
+	 * Print function call entries within a stack. 'cond' is the
+	 * "end of stackframe" condition, that the 'stack++'
+	 * iteration will eventually trigger.
+	 */
 #define HANDLE_STACK(cond) \
 	do while (cond) { \
 		unsigned long addr = *stack++; \
@@ -223,6 +265,11 @@ void show_trace(unsigned long *stack)
 		} \
 	} while (0)
 
+	/*
+	 * Print function call entries in all stacks, starting at the
+	 * current stack address. If the stacks consist of nested
+	 * exceptions
+	 */
 	for ( ; ; ) {
 		const char *id;
 		unsigned long *estack_end;
@@ -233,6 +280,11 @@ void show_trace(unsigned long *stack)
 			printk(" <%s>", id);
 			HANDLE_STACK (stack < estack_end);
 			printk(" <EOE>");
+			/*
+			 * We link to the next stack via the
+			 * second-to-last pointer (index -2 to end) in the
+			 * exception stack:
+			 */
 			stack = (unsigned long *) estack_end[-2];
 			continue;
 		}
@@ -244,6 +296,11 @@ void show_trace(unsigned long *stack)
 			if (stack >= irqstack && stack < irqstack_end) {
 				printk(" <IRQ>");
 				HANDLE_STACK (stack < irqstack_end);
+				/*
+				 * We link to the next stack (which would be
+				 * the process stack normally) the last
+				 * pointer (index -1 to end) in the IRQ stack:
+				 */
 				stack = (unsigned long *) (irqstack_end[-1]);
 				irqstack_end = NULL;
 				printk(" <EOI>");
@@ -253,6 +310,9 @@ void show_trace(unsigned long *stack)
 		break;
 	}
 
+	/*
+	 * This prints the process stack:
+	 */
 	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
 
