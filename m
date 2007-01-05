Return-Path: <linux-kernel-owner+w=401wt.eu-S1161153AbXAEQ5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbXAEQ5H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbXAEQ5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:57:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41179 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161153AbXAEQ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:57:05 -0500
Date: Fri, 5 Jan 2007 08:49:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Mikael Pettersson <mikpe@it.uu.se>, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701051619.54977.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0701050827290.3661@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <200701051553.04673.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701050757320.3661@woody.osdl.org>
 <200701051619.54977.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2007, Alistair John Strachan wrote:
> 
> (I realise with problems like these it's almost always some sort of obscure 
> hardware problem, but I find that very difficult to believe when I can toggle 
> from 3 years of stability to 6-18 hours crashing by switching compiler. I've 
> also ran extensive stability test programs on the hardware with absolutely no 
> negative results.)

The thing is, I agree with you - it does seem to be compiler-related. But 
at the same time, I'm almost positive that it's not in "pipe_poll()" 
itself, because that function is just too simple, and looking at the 
assembly code, I don't see how what you describe could happen in THAT 
function.

HOWEVER.

I can easily see an NMI coming in, or another interrupt, or something, and 
that one corrupting the stack under it because of a compiler bug (or a 
kernel bug that just needs a specific compiler to trigger). For example, 
we've had problems before with the compiler thinking it owns the stack 
frame for an "asmlinkage" function, and us having no way to tell the 
compiler to keep its hands off - so the compiler ended up touching 
registers that were actually in the "save area" of the interrupt or system 
call, and then returning with corrupted state.

Here's a stupid patch. It just adds more debugging to the oops message, 
and shows all the code pointers it can find on the WHOLE stack.

It also makes the raw stack dumping print out as much of the stack 
contents _under_ the stack pointer as it does above it too.

However, this patch is mostly useless if you have a separate stack for 
IRQ's (since if that happens, any interrupt will be taken on a different 
stack which we don't see any more), so you should NOT enable the 4KSTACKS 
config option if you try this out.

I'm not sure how enlightening any of the output might be, but it is 
probably worth trying.

		Linus

---
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 0efad8a..2359eed 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -243,6 +243,20 @@ void show_trace(struct task_struct *task, struct pt_regs *regs,
 	show_trace_log_lvl(task, regs, stack, "");
 }
 
+static void show_all_stack_addresses(unsigned long *esp)
+{
+	struct thread_info *tinfo = (void *) ((unsigned long)esp & (~(THREAD_SIZE - 1)));
+	unsigned long *stack = (unsigned long *)(tinfo+1);
+
+	printk("All stack code pointers:\n");
+	while (valid_stack_ptr(tinfo, stack)) {
+		unsigned long addr = *stack++;
+		if (__kernel_text_address(addr))
+			print_symbol(" %s", addr);
+	}
+	printk("\n");
+}
+
 static void show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			       unsigned long *esp, char *log_lvl)
 {
@@ -256,8 +270,10 @@ static void show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			esp = (unsigned long *)&esp;
 	}
 
+	show_all_stack_addresses(esp);
 	stack = esp;
-	for(i = 0; i < kstack_depth_to_print; i++) {
+	stack -= kstack_depth_to_print;
+	for(i = 0; i < 2*kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % 8) == 0))
