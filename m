Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSEVCzM>; Tue, 21 May 2002 22:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSEVCzL>; Tue, 21 May 2002 22:55:11 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:4767 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S316836AbSEVCzJ>;
	Tue, 21 May 2002 22:55:09 -0400
Date: Wed, 22 May 2002 11:55:08 +0900 (JST)
Message-Id: <200205220255.g4M2t8J17807@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: linux-kernel@vger.kernel.org
Subject: gUSA: Simple User space atomicity emulation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I considered the implementation of atomicity.h of GNU C library
(for SuperH processor), I got an idea.  I named it "gUSA", where g
stands for generic (it can be applied to other processors) and general
(other OS).

gUSA is user space atomicity emulation for uniprocessor system which
doesn't have support of memory lock operation such as ll/sc.

The idea is quite simple.  When kernel preempts the critical region
(or sends a signal when it's in critical region), we let the control
go back to reentrance point.  To do that, we need to define ABI of
critical region, and modify kernel slightly (in case of Linux,
handle_signal and reschedule).

SuperH ABI is:
    Stack pointer (r15) < 0 means control is in the critical region.
	r0:	end point
	r1:	saved stack pointer
	r0 + r15 - 2 = re-enterance point #1 (signal)
	r0 + r15 = re-entrance point #2 (preemption)

Here is an implementation of exchange_and_add:
----------------------------
static inline int
__attribute__ ((unused))
exchange_and_add (volatile uint32_t *mem, int val)
{
  register unsigned long end_r0 __asm__ ("r0");
  register unsigned long ssp_r1 __asm__ ("r1");
  unsigned long dummy;
  int result;

  __asm__ (".align 2\n\t"
       "mova	1f,%0\n\t"
       "mov	r15,%1\n\t"
       "mov	#-6,r15		! critical region start: reentrance point #1\n"
   "0:	mov.l	@%4,%2		! reentrance point #2\n\t"
       "add	%2,%3\n\t"
       "mov.l	%3,@%5\n"
   "1:	mov	%1,r15		! critical region end"
	   : "=&r" (end_r0), "=&r" (ssp_r1), "=&r" (result), "=r" (dummy)
	   : "r" (mem), "3" (val)
	   : "memory");

  return result;
}
----------------------------

On rescheduling, if kernel finds it's in the critical region and
regs->pc < r0, it sets regs->pc = r0+r15 (re-entrance point #2).
On signaling, if kernel finds it's in the critical region, and
regs->pc < r0, it sets regs->r15 = r1 (saved stack pointer)
and regs->pc = r0 + r15 -2 (re-entrance point #1) before the
setting of signal frame (so that it goes re-entrance point #1
after signal handler).

Here's a patch for kernel enhancement for SuperH (against our 2.4.18-sh).

I think that this scheme is useful for other processors.

Comments are welcome.

Please see for full patch of GNU C library:
	http://sources.redhat.com/ml/libc-hacker/2002-05/msg00029.html


2002-05-22  NIIBE Yutaka  <gniibe@m17n.org>

	gUSA ("g" User Space Atomicity) support.
	* arch/sh/kernel/signal.c (handle_signal): Added gUSA handling.
	* arch/sh/kernel/entry.S (reschedule): Added gUSA handling.

Index: arch/sh/kernel/entry.S
===================================================================
RCS file: /cvsroot/linuxsh/linux/arch/sh/kernel/entry.S,v
retrieving revision 1.1.1.1.2.4
diff -u -3 -p -r1.1.1.1.2.4 entry.S
--- arch/sh/kernel/entry.S	10 May 2002 17:58:54 -0000	1.1.1.1.2.4
+++ arch/sh/kernel/entry.S	22 May 2002 02:15:26 -0000
@@ -94,6 +94,7 @@ OFF_R5         =  20     	/* New ABI: ar
 OFF_R6         =  24     	/* New ABI: arg2 */
 OFF_R7         =  28     	/* New ABI: arg3 */
 OFF_SP	   =  (15*4)
+OFF_PC	   =  (16*4)
 OFF_SR	   =  (16*4+8)
 OFF_TRA    =  (16*4+6*4)
 
@@ -455,12 +456,24 @@ __INV_IMASK:
 
 	.align	2
 reschedule:
-	mova	SYMBOL_NAME(ret_from_syscall), r0
-	mov.l	1f, r1
-	jmp	@r1
+	! gUSA handling
+	mov.l	@(OFF_SP,r15), r1	! get user space stack pointer
+	cmp/pz	r1
+	bt/s	1f
+	 mov.l	2f, r4
+	mov	#OFF_PC, r0
+	mov.l	@(r0,r15), r2		! get user space PC (program counter)
+	mov.l	@(OFF_R0,r15), r3	! end point
+	cmp/hs	r3, r2			! r2 >= r3? 
+	bt	1f
+	add	r2, r1			! reentrance point #2
+	mov.l	r1, @(r0,r15)		! reset PC to reentrance point #2
+	!
+1:	mova	SYMBOL_NAME(ret_from_syscall), r0
+	jmp	@r4
 	 lds	r0, pr
 	.align	2
-1:	.long	SYMBOL_NAME(schedule)
+2:	.long	SYMBOL_NAME(schedule)
 
 ret_from_irq:
 ret_from_exception:
Index: arch/sh/kernel/signal.c
===================================================================
RCS file: /cvsroot/linuxsh/linux/arch/sh/kernel/signal.c,v
retrieving revision 1.1.1.1.2.1
diff -u -3 -p -r1.1.1.1.2.1 signal.c
--- arch/sh/kernel/signal.c	29 Mar 2002 00:01:07 -0000	1.1.1.1.2.1
+++ arch/sh/kernel/signal.c	22 May 2002 02:15:26 -0000
@@ -533,6 +533,17 @@ handle_signal(unsigned long sig, struct 
 			case -ERESTARTNOINTR:
 				regs->pc -= 2;
 		}
+	} else {
+		/* gUSA handling */
+		if (regs->regs[15] >= 0x80000000) {
+			int offset = (int)regs->regs[15];
+
+			/* Reset stack pointer: clear critical region mark */
+			regs->regs[15] = regs->regs[1];
+			if (regs->pc < regs->regs[0])
+				/* Go to reentrance point #1 */
+				regs->pc = regs->regs[0] + offset - 2;
+		}
 	}
 
 	/* Set up the stack frame */
