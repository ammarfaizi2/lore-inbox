Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSGUU6C>; Sun, 21 Jul 2002 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSGUU6C>; Sun, 21 Jul 2002 16:58:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19389 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317345AbSGUU5z>;
	Sun, 21 Jul 2002 16:57:55 -0400
Date: Sun, 21 Jul 2002 22:59:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: [patch] "big IRQ lock" removal, 2.5.27-A7
In-Reply-To: <Pine.LNX.4.44.0207212249070.26468-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207212255130.27964-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the arch/i386/kernel/vm86.c hacks are fixed now as well:

      http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A7

this was relatively simple, the irqbits global variable needed to be
protected by a global spinlock. I found no other global locking assumption
in the code. In fact there was even a small bug in the code - if
free_vm86_irq()  was called outside of the global IRQ lock then there's a
irqbits corruption window in free_vm87_irq() - this is true even though
that particular IRQ source will not interfere - it's other IRQ sources
that might change the irqbits variable. The patch fixes this.

this was the last remaining x86 usage of cli()/sti().

	Ingo

--- linux/arch/i386/kernel/vm86.c.orig	Sun Jun  9 07:27:22 2002
+++ linux/arch/i386/kernel/vm86.c	Sun Jul 21 22:55:57 2002
@@ -571,6 +571,8 @@
 	struct task_struct *tsk;
 	int sig;
 } vm86_irqs[16];
+
+static spinlock_t irqbits_lock = SPIN_LOCK_UNLOCKED;
 static int irqbits;
 
 #define ALLOWED_SIGS ( 1 /* 0 = don't send a signal */ \
@@ -580,9 +582,8 @@
 static void irq_handler(int intno, void *dev_id, struct pt_regs * regs) {
 	int irq_bit;
 	unsigned long flags;
-	
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(&irqbits_lock, flags);	
 	irq_bit = 1 << intno;
 	if ((irqbits & irq_bit) || ! vm86_irqs[intno].tsk)
 		goto out;
@@ -591,14 +592,19 @@
 		send_sig(vm86_irqs[intno].sig, vm86_irqs[intno].tsk, 1);
 	/* else user will poll for IRQs */
 out:
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irqbits_lock, flags);	
 }
 
 static inline void free_vm86_irq(int irqnumber)
 {
+	unsigned long flags;
+
 	free_irq(irqnumber,0);
 	vm86_irqs[irqnumber].tsk = 0;
+
+	spin_lock_irqsave(&irqbits_lock, flags);	
 	irqbits &= ~(1 << irqnumber);
+	spin_unlock_irqrestore(&irqbits_lock, flags);	
 }
 
 static inline int task_valid(struct task_struct *tsk)
@@ -635,11 +641,10 @@
 	
 	if ( (irqnumber<3) || (irqnumber>15) ) return 0;
 	if (vm86_irqs[irqnumber].tsk != current) return 0;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&irqbits_lock, flags);	
 	bit = irqbits & (1 << irqnumber);
 	irqbits &= ~bit;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irqbits_lock, flags);	
 	return bit;
 }
 

