Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbTIKSnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbTIKSnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:43:01 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:58779 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261442AbTIKSmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:42:21 -0400
Date: Thu, 11 Sep 2003 14:42:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200309111842.h8BIg9u19549@devserv.devel.redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (1/7): s390 base.
In-Reply-To: <mailman.1063301221.16770.linux-kernel2news@redhat.com>
References: <mailman.1063301221.16770.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the following is not going to print useful enough stacks,
I tried &(task->thread.ksp) before. It prints short stacks which
are no good track lockups.

> diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
> --- linux-2.6/arch/s390/kernel/traps.c	Mon Sep  8 21:50:01 2003
> +++ linux-2.6-s390/arch/s390/kernel/traps.c	Thu Sep 11 19:21:05 2003
> @@ -83,7 +83,7 @@
>  	unsigned long backchain, low_addr, high_addr, ret_addr;
>  
>  	if (!stack)
> -		stack = *stack_pointer;
> +		stack = (task == NULL) ? *stack_pointer : &(task->thread.ksp);
>  
>  	printk("Call Trace:\n");
>  	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
> @@ -120,8 +120,12 @@
>  	// debugging aid: "show_stack(NULL);" prints the
>  	// back trace for this cpu.
>  
> -	if(sp == NULL)
> -		sp = *stack_pointer;
> +	if (!sp) {
> +		if (task)
> +			sp = (unsigned long *) task->thread.ksp;
> +		else
> +			sp = *stack_pointer;
> +	}
>  
>  	stack = sp;
>  	for (i = 0; i < kstack_depth_to_print; i++) {

For 2.4 I came up with this:

diff -ur linux-2.4.21-notrap/arch/s390/kernel/traps.c linux-2.4.21-newtrap/arch/s390/kernel/traps.c
--- linux-2.4.21-notrap/arch/s390/kernel/traps.c	Fri Jul 18 19:28:11 2003
+++ linux-2.4.21-newtrap/arch/s390/kernel/traps.c	Fri Jul 18 19:30:20 2003
@@ -108,14 +108,71 @@
 
 #endif
 
+/*
+ * Return the kernel stack for the current or interrupted thread,
+ * considering that the async stack is useless for purposes of sysrq.
+ * All this acrobatics would not be needed if struct pt_regs pointer
+ * was available when softirq is run, because that is where we printk.
+ * Alas, it's not feasible.
+ */
+static unsigned long *discover_kernel_stack(void)
+{
+	unsigned long sp;
+	unsigned long asp;
+	unsigned long ksp;
+	struct pt_regs *regs;
+
+	/*
+	 * First, check if we are on a thread stack or async stack.
+	 * In case the sp value is returned, we must get actual sp,
+	 * not an approximate value. Unlike the x86, we do not scan,
+	 * we unwind. Thus the "sp = &sp" trick cannot be used.
+	 */
+	asm ( "    lr %0,15\n" : "=r" (sp) );
+
+	ksp = S390_lowcore.kernel_stack;
+	asp = S390_lowcore.async_stack;
+/* P3 */ printk("SP=%08lx AsS=%08lx KS=%08lx\n", sp, asp, ksp);
+	if (sp >= asp - 2*PAGE_SIZE && sp < asp) {
+		/*
+		 * We are on the async stack. Get the kernel stack
+		 * from the top frame, structure of which is defined
+		 * by the SAVE_ALL macro in entry.S.
+		 * Mind that SP_SIZE is aligned to nearest 8.
+		 */
+		regs = (struct pt_regs *) (asp - 144);
+/* P3 */ printk("REGS=%08lx\n", (long)regs);
+		if (regs->psw.mask & PSW_PROBLEM_STATE)
+			return 0;
+		sp = regs->gprs[15];
+/* P3 */ printk("SP=%08lx\n", sp);
+	} else {
+		/*
+		 * We are on kernel stack, or somewhere unknown.
+		 * In both cases, just return whatever we found.
+		 * The worst may happen would be an obviously short trace.
+		 */
+		;
+	}
+	return (unsigned long *)sp;
+}
+
 void show_trace(unsigned long * stack)
 {
 	static char buffer[512];
 	unsigned long backchain, low_addr, high_addr, ret_addr;
 	int i;
 
-	if (!stack)
-		stack = (unsigned long*)&stack;
+	if ((unsigned long)stack < PAGE_SIZE) {
+		/*
+		 * Should not happen in our current kernel, because we
+		 * add have checks or use tsk->thread.ksp in all callers,
+		 * but guard against careless changes and/or accidentially
+		 * backed out patches.
+		 */
+		printk("Null stack\n");
+		return;
+	}
 
 	low_addr = ((unsigned long) stack) & PSW_ADDR_MASK;
 	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
@@ -123,11 +180,15 @@
 	backchain = *((unsigned long *) low_addr) & PSW_ADDR_MASK;
 	/* Print up to 20 lines */
 	for (i = 0; i < 20; i++) {
-		if (backchain < low_addr || backchain >= high_addr)
+		if (backchain < low_addr || backchain >= high_addr) {
+			printk("[<->] (0x%lx)\n", backchain);
 			break;
+		}
 		ret_addr = *((unsigned long *) (backchain+56)) & PSW_ADDR_MASK;
-		if (!kernel_text_address(ret_addr))
+		if (!kernel_text_address(ret_addr)) {
+			printk("[<%08lx>] -\n", ret_addr);
 			break;
+		}
 		lookup_symbol(ret_addr, buffer, 512);
 		printk("[<%08lx>] %s (0x%lx)\n", ret_addr,buffer,backchain+56);
 		low_addr = backchain;
@@ -156,9 +217,12 @@
 
 	// debugging aid: "show_stack(NULL);" prints the
 	// back trace for this cpu.
-
-	if(sp == NULL)
-		sp = (unsigned long*) &sp;
+	if (sp == NULL) {
+		if ((sp = discover_kernel_stack()) == NULL) {
+			printk("User mode stack\n");
+			return;
+		}
+	}
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
diff -ur linux-2.4.21-notrap/arch/s390x/kernel/traps.c linux-2.4.21-newtrap/arch/s390x/kernel/traps.c
--- linux-2.4.21-notrap/arch/s390x/kernel/traps.c	Fri Jul 18 19:28:11 2003
+++ linux-2.4.21-newtrap/arch/s390x/kernel/traps.c	Fri Jul 18 19:30:20 2003
@@ -110,6 +110,55 @@
 
 #endif
 
+/*
+ * Return the kernel stack for the current or interrupted thread,
+ * considering that the async stack is useless for purposes of sysrq.
+ * All this acrobatics would not be needed if struct pt_regs pointer
+ * was available when softirq is run, because that is where we printk.
+ * Alas, it's not feasible.
+ */
+static unsigned long *discover_kernel_stack(void)
+{
+	unsigned long sp;
+	unsigned long asp;
+	unsigned long ksp;
+	struct pt_regs *regs;
+
+	/*
+	 * First, check if we are on a thread stack or async stack.
+	 * In case the sp value is returned, we must get actual sp,
+	 * not an approximate value. Unlike the x86, we do not scan,
+	 * we unwind. Thus the "sp = &sp" trick cannot be used.
+	 */
+	asm ( "    lgr %0,15\n" : "=r" (sp) );
+
+	ksp = S390_lowcore.kernel_stack;
+	asp = S390_lowcore.async_stack;
+/* P3 */ printk("SP=%016lx AsS=%016lx KS=%016lx\n", sp, asp, ksp);
+	if (sp >= asp - 2*PAGE_SIZE && sp < asp) {
+		/*
+		 * We are on the async stack. Get the kernel stack
+		 * from the top frame, structure of which is defined
+		 * by the SAVE_ALL macro in entry.S.
+		 * Mind that SP_SIZE is aligned to nearest 8.
+		 */
+		regs = (struct pt_regs *) (asp - 224);
+/* P3 */ printk("REGS=%016lx\n", (long)regs);
+		if (regs->psw.mask & PSW_PROBLEM_STATE)
+			return 0;
+		sp = regs->gprs[15];
+/* P3 */ printk("SP=%016lx\n", sp);
+	} else {
+		/*
+		 * We are on kernel stack, or somewhere unknown.
+		 * In both cases, just return whatever we found.
+		 * The worst may happen would be an obviously short trace.
+		 */
+		;
+	}
+	return (unsigned long *)sp;
+}
+
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
@@ -117,8 +166,16 @@
 	/* static to not take up stackspace; if we race here too bad */
 	static char buffer[512];
 
-	if (!stack)
-		stack = (unsigned long*)&stack;
+	if ((unsigned long)stack < PAGE_SIZE) {
+		/*
+		 * Should not happen in our current kernel, because we
+		 * add have checks or use tsk->thread.ksp in all callers,
+		 * but guard against careless changes and/or accidentially
+		 * backed out patches.
+		 */
+		printk("Null stack\n");
+		return;
+	}
 
 	low_addr = ((unsigned long) stack) & PSW_ADDR_MASK;
 	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
@@ -126,11 +183,15 @@
 	backchain = *((unsigned long *) low_addr) & PSW_ADDR_MASK;
 	/* Print up to 20 lines */
 	for (i = 0; i < 20; i++) {
-		if (backchain < low_addr || backchain >= high_addr)
+		if (backchain < low_addr || backchain >= high_addr) {
+			printk("[<->] (0x%lx)\n", backchain);
 			break;
+		}
 		ret_addr = *((unsigned long *) (backchain+112)) & PSW_ADDR_MASK;
-		if (!kernel_text_address(ret_addr))
+		if (!kernel_text_address(ret_addr)) {
+			printk("[<%016lx>] -\n", ret_addr);
 			break;
+		}
 		lookup_symbol(ret_addr, buffer, 512);
 		printk("[<%016lx>] %s (0x%lx)\n", ret_addr, buffer, backchain+112);
 		low_addr = backchain;
@@ -160,8 +221,12 @@
 	// debugging aid: "show_stack(NULL);" prints the
 	// back trace for this cpu.
 
-	if (sp == NULL)
-		sp = (unsigned long*) &sp;
+	if (sp == NULL) {
+		if ((sp = discover_kernel_stack()) == NULL) {
+			printk("User mode stack\n");
+			return;
+		}
+	}
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {

Your use of asm("la %0,0(15)" : "=&d" (sp)) is very nifty
in the way it uses the same assembly for both 31 and 64 bit modes.
The extra indirection looks suspect though. I'd be surprised
if gcc worked it out that piping through memory was not needed.
Why not to do:

static inline void *get_stack_pointer(void)
{
	void *sp;
	asm("la %0,0(15)" : "=r" (sp));
	return sp;
}

-- Pete
