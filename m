Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTEaLjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTEaLjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:39:35 -0400
Received: from ns.suse.de ([213.95.15.193]:55558 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264284AbTEaLjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:39:31 -0400
Date: Sat, 31 May 2003 13:52:52 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@digeo.com
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] More irq balance fixes
Message-ID: <20030531115252.GA10245@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Stultz noticed that kirqd didn't start because of another logic error,
which broke irq balancing.  This was still a fallout from the generic 
subarchitecture changes.

Actually it still refuses to balance anything on my test box, but perhaps
I'm just not able to generate enough interrupts.

Anyways, with this patch the thread is running again at least.

-Andi


Index: linux/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/io_apic.c,v
retrieving revision 1.72
diff -u -u -r1.72 io_apic.c
--- linux/arch/i386/kernel/io_apic.c	30 May 2003 20:11:58 -0000	1.72
+++ linux/arch/i386/kernel/io_apic.c	31 May 2003 10:24:18 -0000
@@ -352,16 +352,8 @@
 	unsigned long allowed_mask;
 	unsigned int new_cpu;
 		
-	if (irqbalance_disabled == IRQBALANCE_CHECK_ARCH)
-		irqbalance_disabled = NO_BALANCE_IRQ;
-	if (irqbalance_disabled) { 
-		static int warned;
-		if (warned == 0) {
-			printk("irqbalance disabled\n");
-			warned = 1;
-		} 
+	if (irqbalance_disabled)
 		return; 
-	} 
 
 	allowed_mask = cpu_online_map & irq_affinity[irq];
 	new_cpu = move(cpu, allowed_mask, now, 1);
@@ -620,6 +612,9 @@
 	struct cpuinfo_x86 *c;
 
         c = &boot_cpu_data;
+	/* When not overwritten by the command line ask subarchitecture. */
+	if (irqbalance_disabled == IRQBALANCE_CHECK_ARCH)
+		irqbalance_disabled = NO_BALANCE_IRQ;
 	if (irqbalance_disabled)
 		return 0;
 	

