Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbSLEWVJ>; Thu, 5 Dec 2002 17:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbSLEWVI>; Thu, 5 Dec 2002 17:21:08 -0500
Received: from holomorphy.com ([66.224.33.161]:38028 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267536AbSLEWU6>;
	Thu, 5 Dec 2002 17:20:58 -0500
Date: Thu, 05 Dec 2002 14:28:20 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, davej@suse.de
Subject: [vm86] [2/2] remove handle_irq_zombies()
Message-ID: <0212051428.vasbFbfaTddaEcBdrdmcidBaxc3c1afb3769@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212051428.zaFdjcIa~c7dpasbvdjcrc9dZbEdSaVb3769@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, suggested by manfred, removes handle_irq_zombies() and
task_valid(). The procedure of comparing stored task structure
pointers to tasklist elements is incorrect; the task structures
are reused. Reaping the vm86 IRQ's in release_x86_irq() suffices.

===== arch/i386/kernel/vm86.c 1.14 vs edited =====
--- 1.14/arch/i386/kernel/vm86.c	Fri Nov 15 14:32:24 2002
+++ edited/arch/i386/kernel/vm86.c	Thu Dec  5 11:15:44 2002
@@ -708,23 +708,6 @@
 	spin_unlock_irqrestore(&irqbits_lock, flags);	
 }
 
-static inline int task_valid(struct task_struct *tsk)
-{
-	struct task_struct *g, *p;
-	int ret = 0;
-
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p)
-		if ((p == tsk) && (p->sig)) {
-			ret = 1;
-			goto out;
-		}
-	while_each_thread(g, p);
-out:
-	read_unlock(&tasklist_lock);
-	return ret;
-}
-
 void release_x86_irqs(struct task_struct *task)
 {
 	int i;
@@ -733,17 +716,6 @@
 		free_vm86_irq(i);
 }
 
-static inline void handle_irq_zombies(void)
-{
-	int i;
-	for (i=3; i<16; i++) {
-		if (vm86_irqs[i].tsk) {
-			if (task_valid(vm86_irqs[i].tsk)) continue;
-			free_vm86_irq(i);
-		}
-	}
-}
-
 static inline int get_and_reset_irq(int irqnumber)
 {
 	int bit;
@@ -772,7 +744,6 @@
 		case VM86_REQUEST_IRQ: {
 			int sig = irqnumber >> 8;
 			int irq = irqnumber & 255;
-			handle_irq_zombies();
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
 			if ( (irq<3) || (irq>15) ) return -EPERM;
@@ -784,7 +755,6 @@
 			return irq;
 		}
 		case  VM86_FREE_IRQ: {
-			handle_irq_zombies();
 			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
 			if (!vm86_irqs[irqnumber].tsk) return 0;
 			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
