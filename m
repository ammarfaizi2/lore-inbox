Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFEVHJ>; Wed, 5 Jun 2002 17:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFEVHJ>; Wed, 5 Jun 2002 17:07:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:30704 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S313773AbSFEVHI>; Wed, 5 Jun 2002 17:07:08 -0400
Date: Wed, 5 Jun 2002 17:07:09 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020605170709.F4697@redhat.com>
In-Reply-To: <20020605144357.A4697@redhat.com> <Pine.LNX.4.33.0206051150320.10556-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 11:53:10AM -0700, Linus Torvalds wrote:
> All of the flags should be "sticky one-bits", so just oring them should do 
> the right thing.
> 
> That way we don't have to add nasty BUG checks to the code, and since 
> we're already dirtying both cache-lines the extra overhead should 
> literally be just the cost of doing one locked "orl".

This patch on top of the others should do that.  I've placed a full 
diff from 2.5.20 to the current code at 
http://www.kvack.org/~blah/stack-v2.5.20-A2.diff .

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5.20/v2.5.20-smallstack-A0-A1.diff
diff -urN stackcheck-v2.5.20-A1/arch/i386/kernel/entry.S stack-2.5.20.diff/arch/i386/kernel/entry.S
--- stackcheck-v2.5.20-A1/arch/i386/kernel/entry.S	Wed Jun  5 15:59:12 2002
+++ stack-2.5.20.diff/arch/i386/kernel/entry.S	Wed Jun  5 15:55:09 2002
@@ -365,26 +365,34 @@
 	movl TI_IRQ_STACK(%ebx),%ecx
 	movl TI_TASK(%ebx),%edx
 	movl %esp,%eax
-	leal (THREAD_SIZE-4)(%ecx),%ebx
+	leal (THREAD_SIZE-4)(%ecx),%esi
 	testl %ecx,%ecx			# is there a valid irq_stack?
 
 	# switch to the irq stack
 #ifdef CONFIG_X86_HAVE_CMOV
-	cmovnz %ebx,%esp
-#warning using cmov
+	cmovnz %esi,%esp
 #else
-#warning cannot use cmov
 	jnz 1f
-	mov %ebx,%esp
+	mov %esi,%esp
 1:
 #endif
 
 	# update the task pointer in the irq stack
-	GET_THREAD_INFO(%ebx)
-	movl %edx,TI_TASK(%ebx)
+	GET_THREAD_INFO(%esi)
+	movl %edx,TI_TASK(%esi)
 
 	call do_IRQ
+
 	movl %eax,%esp			# potentially restore non-irq stack
+
+	# copy flags from the irq stack back into the task's thread_info
+	# %esi is saved over the do_IRQ call and contains the irq stack
+	# thread_info pointer
+	# %ebx contains the original thread_info pointer
+	movl TI_FLAGS(%esi),%eax
+	movl $0,TI_FLAGS(%esi)
+	LOCK orl %eax,TI_FLAGS(%ebx)
+
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
diff -urN stackcheck-v2.5.20-A1/arch/i386/kernel/smpboot.c stack-2.5.20.diff/arch/i386/kernel/smpboot.c
--- stackcheck-v2.5.20-A1/arch/i386/kernel/smpboot.c	Wed Jun  5 15:59:08 2002
+++ stack-2.5.20.diff/arch/i386/kernel/smpboot.c	Wed Jun  5 15:12:36 2002
@@ -875,7 +875,13 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (THREAD_SIZE + (char *)idle->thread_info);
+
+	/* The -4 is to correct for the fact that the stack pointer
+	 * is used to find the location of the thread_info structure
+	 * by masking off several of the LSBs.  Without the -4, esp
+	 * is pointing to the page after the one the stack is on.
+	 */
+	stack_start.esp = (void *)(THREAD_SIZE - 4 + (char *)idle->thread_info);
 
 	/*
 	 * This grunge runs the startup process for
diff -urN stackcheck-v2.5.20-A1/include/asm-i386/thread_info.h stack-2.5.20.diff/include/asm-i386/thread_info.h
--- stackcheck-v2.5.20-A1/include/asm-i386/thread_info.h	Wed Jun  5 15:59:08 2002
+++ stack-2.5.20.diff/include/asm-i386/thread_info.h	Wed Jun  5 14:55:04 2002
@@ -57,6 +57,7 @@
  * macros/functions for gaining access to the thread information structure
  */
 #define THREAD_ORDER	0
+#define INIT_THREAD_SIZE	THREAD_SIZE
 
 #ifndef __ASSEMBLY__
 #define init_thread_info	(init_thread_union.thread_info)
