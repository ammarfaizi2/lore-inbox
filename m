Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283698AbRK3QT5>; Fri, 30 Nov 2001 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283697AbRK3QTs>; Fri, 30 Nov 2001 11:19:48 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:35207 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S283696AbRK3QTm>;
	Fri, 30 Nov 2001 11:19:42 -0500
Date: Fri, 30 Nov 2001 17:19:23 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: turveysp@ntlworld.com
Cc: dalecki@evision.ag, linux-kernel@vger.kernel.org
Subject: Re: Generating a function call trace
Message-ID: <20011130171923.A6569@vana.vc.cvut.cz>
In-Reply-To: <001501c179b1$870db7c0$140ba8c0@mistral> <3C07A6E6.45A4AC61@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C07A6E6.45A4AC61@evision-ventures.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 04:33:58PM +0100, Martin Dalecki wrote:
> Simon Turvey wrote:
> > 
> > Is it possible to arbitrarily generate (in a module say) a function call
> > trace?
> > 
> 
> Just insert the dereference of a NULL pointer where you wan't to have
> it.
> The oops gives you what you wan't....
> Or better attach the gdb to /proc/kmem (you will have to compile the
> kernel with
> debugging on in front of this action) and have fun.

I'm using this ia32-only solution, as killing userspace program is not
acceptable under some conditions. Patch below was generated from
my 2.5.0-pre1 tree.
					Petr Vandrovec
					vandrove@vc.cvut.cz


diff -urdN linux/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	Sun Sep 30 19:26:08 2001
+++ linux/arch/i386/kernel/traps.c	Mon Nov 26 15:40:47 2001
@@ -237,6 +237,42 @@
 	printk("\n");
 }	
 
+void printstate(void) {
+	asm volatile (
+		"pushl %%ss\n\t"
+		"pushl %%esp\n\t"
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"call 1f\n"
+		"1:\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%ds\n\t"
+		"pushl %%es\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%ebp\n\t"
+		"pushl %%edi\n\t"
+		"pushl %%esi\n\t"
+		"pushl %%edx\n\t"
+		"pushl %%ecx\n\t"
+		"pushl %%ebx\n\t"
+		"movl %%esp,%%eax\n\t"
+		"pushl %%eax\n\t"
+		"call show_registers\n\t"
+		"addl $4,%%esp\n\t"
+		"popl %%ebx\n\t"
+		"popl %%ecx\n\t"
+		"popl %%edx\n\t"
+		"popl %%esi\n\t"
+		"popl %%edi\n\t"
+		"popl %%ebp\n\t"
+		"popl %%eax\n\t"
+		"popl %%es\n\t"
+		"popl %%ds\n\t"
+		"popl %%eax\n\t"
+		"addl $20,%%esp\n\t"
+		: : : "memory" );
+}
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 void die(const char * str, struct pt_regs * regs, long err)
diff -urdN linux/kernel/ksyms.c linux/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Nov 21 22:07:25 2001
+++ linux/kernel/ksyms.c	Mon Nov 26 15:40:47 2001
@@ -71,6 +71,9 @@
 };
 #endif
 
+extern void printstate(void);
+
+EXPORT_SYMBOL(printstate);
 
 EXPORT_SYMBOL(inter_module_register);
 EXPORT_SYMBOL(inter_module_unregister);
