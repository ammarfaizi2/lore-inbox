Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSGLWjv>; Fri, 12 Jul 2002 18:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318051AbSGLWjJ>; Fri, 12 Jul 2002 18:39:09 -0400
Received: from holomorphy.com ([66.224.33.161]:35999 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318044AbSGLWiC>;
	Fri, 12 Jul 2002 18:38:02 -0400
Date: Fri, 12 Jul 2002 15:39:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: NUMA-Q breakage 3/7 irqbalance stuffs unreachable cpu's in IO-APICS
Message-ID: <20020712223950.GA25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irqbalance stuffs unreachable cpus' APIC ID's into the IO-APICs.
This cannot be done generically, as the cpu's that can be reached
from a given IO-APIC depend on the subarch. The net effect of the bug
is deadlocking while waiting for interrupts to come back from devices,
i.e. booting is impossible.

Fix (due to Matt Dobson) below.


Cheers,
Bill


diff -Nur linux-2.5.23-vanilla/arch/i386/kernel/io_apic.c linux-2.5.23-patched/arch/i386/kernel/io_apic.c
--- linux-2.5.23-vanilla/arch/i386/kernel/io_apic.c	Tue Jun 18 19:11:52 2002
+++ linux-2.5.23-patched/arch/i386/kernel/io_apic.c	Thu Jun 27 14:28:51 2002
@@ -247,7 +247,7 @@
 
 static inline void balance_irq(int irq)
 {
-#if CONFIG_SMP
+#if (CONFIG_SMP && !CONFIG_MULTIQUAD)
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
