Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbUKCCIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUKCCIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKCCIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:08:01 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28428 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261319AbUKCCHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:07:48 -0500
Date: Wed, 3 Nov 2004 02:07:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9: Only handle system NMIs on the BSP
Message-ID: <Pine.LNX.4.58L.0411030125340.32079@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 While discussing races in the NMI handler's trailer fiddling with RTC
registers, I've discovered we incorrectly attempt to handle NMIs coming
from the system (memory errors, IOCHK# assertions, etc.) with all
processors even though the interrupts are only routed to the bootstrap
processor.  If one of these events coincides with a NMI watchdog tick it
may even be handled multiple times in parallel.

 Here is a fix that makes application processors ignore these events.  
They no longer access the NMI status bits at I/O port 0x61 which has also
the advantage of removing the contention on the port when the I/O APIC NMI
watchdog makes all processors arrive at the handler at the same time.

 For both the i386 and the x86_64.  Please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-2.6.9-nmi-bsp-1
diff -up --recursive --new-file linux-2.6.9.macro/arch/i386/kernel/traps.c linux-2.6.9/arch/i386/kernel/traps.c
--- linux-2.6.9.macro/arch/i386/kernel/traps.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9/arch/i386/kernel/traps.c	2004-11-03 01:04:13.000000000 +0000
@@ -598,7 +598,11 @@ void die_nmi (struct pt_regs *regs, cons
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = get_nmi_reason();
+	unsigned char reason = 0;
+
+	/* Only the BSP gets external NMIs from the system.  */
+	if (!smp_processor_id())
+		reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
diff -up --recursive --new-file linux-2.6.9.macro/arch/x86_64/kernel/traps.c linux-2.6.9/arch/x86_64/kernel/traps.c
--- linux-2.6.9.macro/arch/x86_64/kernel/traps.c	2004-10-12 23:57:12.000000000 +0000
+++ linux-2.6.9/arch/x86_64/kernel/traps.c	2004-11-03 01:04:27.000000000 +0000
@@ -565,8 +565,12 @@ static void unknown_nmi_error(unsigned c
 
 asmlinkage void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason = 0;
 
+	/* Only the BSP gets external NMIs from the system.  */
+	if (!smp_processor_id())
+		reason = inb(0x61);
+ 
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
 								== NOTIFY_STOP)
