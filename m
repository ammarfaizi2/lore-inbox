Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTDGXjP (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTDGXhg (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:37:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27009
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263866AbTDGX1W (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:27:22 -0400
Date: Tue, 8 Apr 2003 01:46:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080046.h380kIYG009378@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: make vm86 machine independant using new headers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/kernel/vm86.c linux-2.5.67-ac1/arch/i386/kernel/vm86.c
--- linux-2.5.67/arch/i386/kernel/vm86.c	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/i386/kernel/vm86.c	2003-04-03 16:48:45.000000000 +0100
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
@@ -725,7 +726,7 @@
 void release_x86_irqs(struct task_struct *task)
 {
 	int i;
-	for (i=3; i<16; i++)
+	for (i = FIRST_VM86_IRQ ; i <= LAST_VM86_IRQ; i++)
 	    if (vm86_irqs[i].tsk == task)
 		free_vm86_irq(i);
 }
@@ -735,7 +736,7 @@
 	int bit;
 	unsigned long flags;
 	
-	if ( (irqnumber<3) || (irqnumber>15) ) return 0;
+	if (invalid_vm86_irq(irqnumber)) return 0;
 	if (vm86_irqs[irqnumber].tsk != current) return 0;
 	spin_lock_irqsave(&irqbits_lock, flags);	
 	bit = irqbits & (1 << irqnumber);
@@ -760,7 +761,7 @@
 			int irq = irqnumber & 255;
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
-			if ( (irq<3) || (irq>15) ) return -EPERM;
+			if (invalid_vm86_irq(irq)) return -EPERM;
 			if (vm86_irqs[irq].tsk) return -EPERM;
 			ret = request_irq(irq, &irq_handler, 0, VM86_IRQNAME, 0);
 			if (ret) return ret;
@@ -769,7 +770,7 @@
 			return irq;
 		}
 		case  VM86_FREE_IRQ: {
-			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
+			if (invalid_vm86_irq(irqnumber)) return -EPERM;
 			if (!vm86_irqs[irqnumber].tsk) return 0;
 			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
 			free_vm86_irq(irqnumber);
