Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280647AbRKFWlI>; Tue, 6 Nov 2001 17:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280653AbRKFWk7>; Tue, 6 Nov 2001 17:40:59 -0500
Received: from t2.redhat.com ([199.183.24.243]:31737 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280647AbRKFWkv>; Tue, 6 Nov 2001 17:40:51 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011106123427.A11351@hazard.jcu.cz> 
In-Reply-To: <20011106123427.A11351@hazard.jcu.cz>  <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz> 
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 22:40:49 +0000
Message-ID: <23001.1005086449@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux@hazard.jcu.cz said:
>  The last message I got from kernel is:  request_irq: desc->handler->
> startup(irq)

> Then problem is in the spin_unlock_irqrestore()???

> Any ideas, recomendations, suggestions?

It's dying in an IRQ storm. Something is permanently asserting IRQ 11, and 
unless you can work out what's doing it and make it stop, the machine will 
die whenever you enable that IRQ.

Try this hack, just to make sure:

Index: arch/i386/kernel/irq.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/irq.c,v
retrieving revision 1.4.2.29
diff -u -r1.4.2.29 irq.c
--- arch/i386/kernel/irq.c	2001/06/21 09:33:54	1.4.2.29
+++ arch/i386/kernel/irq.c	2001/08/15 16:50:01
@@ -552,6 +552,8 @@
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+static unsigned int stormcount[NR_IRQS];
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -576,6 +578,15 @@
 	unsigned int status;
 
 	kstat.irqs[cpu][irq]++;
+	if (++stormcount[irq] > 200) {
+		printk(KERN_CRIT "IRQ storm detected on IRQ %d. Disabling\n", irq);
+		disable_irq(irq);
+	}
+	if(irq==0) {
+		int i; 
+		for (i=0; i<NR_IRQS; i++)
+			stormcount[i] = 0;
+	}
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*




--
dwmw2


