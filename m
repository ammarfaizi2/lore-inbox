Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264083AbRFKXzc>; Mon, 11 Jun 2001 19:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264086AbRFKXzW>; Mon, 11 Jun 2001 19:55:22 -0400
Received: from ppp71-3-70.miem.edu.ru ([194.226.32.70]:51204 "EHLO yahoo.com")
	by vger.kernel.org with ESMTP id <S264083AbRFKXzK>;
	Mon, 11 Jun 2001 19:55:10 -0400
From: Stas Sergeev <stas_orel@yahoo.com>
Reply-To: stas.orel@mailcity.com
To: linux-kernel@vger.kernel.org
Subject: [patch] do proper cleanups before requesting irq
Date: Tue, 12 Jun 2001 03:53:57 +0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01061202405801.06615@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As nobody responded to my previous posting
( http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.1/0219.html )
I had no other options than to try to solve a problem myself.
The problem was that linux fails to do a cleanup if a program does
vm86()/VM86_REQUEST_IRQ without VM86_FREE_IRQ (see test program
in my previous posting), so that I have to reboot my machine before I can
start the program again.

I have made a patch that solves a problem (it is not necessary to reboot now
if dosemu crashes).
The problem is that there are comparisons of pointers to task_struct when
deciding if the task is alive. If one task dies and other one starts, it is
possible (is it?) that the task structure of the newly created task resides
at the very address where was the dead one's, so comparing pointers is not
reliable. This patch changes it to comparisons of task's pids.
Can anyone, please, atleast tell me if this patch is correct?
I understand that noone here is interested in fixing vm86() syscall, but there
are a few people in the world that still need it.


----------------------------------------------------
--- linux/arch/i386/kernel/vm86.c	Sat May  5 06:31:51 2001
+++ linux/arch/i386/kernel/vm86.c	Mon Jun 11 19:05:35 2001
@@ -569,7 +569,7 @@
 #define VM86_IRQNAME		"vm86irq"
 
 static struct vm86_irqs {
-	struct task_struct *tsk;
+	pid_t tsk_pid;
 	int sig;
 } vm86_irqs[16] = {{0},}; 
 static int irqbits=0;
@@ -581,16 +581,18 @@
 static void irq_handler(int intno, void *dev_id, struct pt_regs * regs) {
 	int irq_bit;
 	unsigned long flags;
+	struct task_struct *tsk;
 	
 	lock_kernel();
 	save_flags(flags);
 	cli();
+	tsk = find_task_by_pid(vm86_irqs[intno].tsk_pid);
 	irq_bit = 1 << intno;
-	if ((irqbits & irq_bit) || ! vm86_irqs[intno].tsk)
+	if ((irqbits & irq_bit) || ! vm86_irqs[intno].tsk_pid || ! tsk)
 		goto out;
 	irqbits |= irq_bit;
 	if (vm86_irqs[intno].sig)
-		send_sig(vm86_irqs[intno].sig, vm86_irqs[intno].tsk, 1);
+		send_sig(vm86_irqs[intno].sig, tsk, 1);
 	/* else user will poll for IRQs */
 out:
 	restore_flags(flags);
@@ -600,18 +602,18 @@
 static inline void free_vm86_irq(int irqnumber)
 {
 	free_irq(irqnumber,0);
-	vm86_irqs[irqnumber].tsk = 0;
+	vm86_irqs[irqnumber].tsk_pid = 0;
 	irqbits &= ~(1 << irqnumber);
 }
 
-static inline int task_valid(struct task_struct *tsk)
+static inline int task_valid(pid_t tsk_pid)
 {
 	struct task_struct *p;
 	int ret = 0;
 
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
-		if ((p == tsk) && (p->sig)) {
+		if ((p->pid == tsk_pid) && (p->sig)) {
 			ret = 1;
 			break;
 		}
@@ -624,8 +626,8 @@
 {
 	int i;
 	for (i=3; i<16; i++) {
-		if (vm86_irqs[i].tsk) {
-			if (task_valid(vm86_irqs[i].tsk)) continue;
+		if (vm86_irqs[i].tsk_pid) {
+			if (task_valid(vm86_irqs[i].tsk_pid)) continue;
 			free_vm86_irq(i);
 		}
 	}
@@ -637,7 +639,7 @@
 	unsigned long flags;
 	
 	if ( (irqnumber<3) || (irqnumber>15) ) return 0;
-	if (vm86_irqs[irqnumber].tsk != current) return 0;
+	if (vm86_irqs[irqnumber].tsk_pid != current->pid) return 0;
 	save_flags(flags);
 	cli();
 	bit = irqbits & (1 << irqnumber);
@@ -664,18 +666,18 @@
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
 			if ( (irq<3) || (irq>15) ) return -EPERM;
-			if (vm86_irqs[irq].tsk) return -EPERM;
+			if (vm86_irqs[irq].tsk_pid) return -EPERM;
 			ret = request_irq(irq, &irq_handler, 0, VM86_IRQNAME, 0);
 			if (ret) return ret;
 			vm86_irqs[irq].sig = sig;
-			vm86_irqs[irq].tsk = current;
+			vm86_irqs[irq].tsk_pid = current->pid;
 			return irq;
 		}
 		case  VM86_FREE_IRQ: {
 			handle_irq_zombies();
 			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
-			if (!vm86_irqs[irqnumber].tsk) return 0;
-			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
+			if (!vm86_irqs[irqnumber].tsk_pid) return 0;
+			if (vm86_irqs[irqnumber].tsk_pid != current->pid) return -EPERM;
 			free_vm86_irq(irqnumber);
 			return 0;
 		}
