Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262925AbTCSFDg>; Wed, 19 Mar 2003 00:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262926AbTCSFDg>; Wed, 19 Mar 2003 00:03:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:38770
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262925AbTCSFDe>; Wed, 19 Mar 2003 00:03:34 -0500
Date: Wed, 19 Mar 2003 00:11:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH][2.5] Fail setup_irq for unconfigured IRQs
Message-ID: <Pine.LNX.4.50.0303182259280.25200-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes us bail out in case we may have an interrupt which 
couldn't be associated with an interrupt controller. Without this we allow 
unconfigured interrupts to be assigned and then later on we get 
"unexpected IRQ trap at vector xx" during the ack phase.

scenario:
This can occur if we fail irq setup during setup_IO_APIC_irqs for some 
reason or other and then miss getting assigned a vector. Later on we then 
get assigned no_irq_type as our handler.

Patch for i386 and x86_64

Index: linux-2.5.65-numaq/arch/i386/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.5.65-numaq/arch/i386/kernel/irq.c	17 Mar 2003 23:08:54 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/i386/kernel/irq.c	19 Mar 2003 04:11:35 -0000
@@ -744,6 +744,8 @@ int setup_irq(unsigned int irq, struct i
 	struct irqaction *old, **p;
 	irq_desc_t *desc = irq_desc + irq;
 
+	if (desc->handler == &no_irq_type)
+		return -ENOSYS;
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
 	 * so we have to be careful not to interfere with a
Index: linux-2.5.65-numaq/arch/x86_64/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.65/arch/x86_64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.5.65-numaq/arch/x86_64/kernel/irq.c	17 Mar 2003 23:09:50 -0000	1.1.1.1
+++ linux-2.5.65-numaq/arch/x86_64/kernel/irq.c	19 Mar 2003 04:46:11 -0000
@@ -732,6 +732,9 @@ int setup_irq(unsigned int irq, struct i
 	struct irqaction *old, **p;
 	irq_desc_t *desc = irq_desc + irq;
 
+	if (desc->handler == &no_irq_type)
+		return -ENOSYS;
+
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
 	 * so we have to be careful not to interfere with a

-- 
function.linuxpower.ca
