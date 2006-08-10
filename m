Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWHJUlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWHJUlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWHJUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45291 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932614AbWHJTgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:20 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [59/145] x86_64: Remove MPS table APIC renumbering
Message-Id: <20060810193614.71F7B13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:14 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

The MPS table specification says that the operating system should
renumber the IO-APICs following the table as needed.  However in 
ACPI this is not allowed or neeeded and all x86-64 systems are ACPI 
compliant.

The code was already disabled on some systems because it caused
problems there. Remove it completely now.

CC: mdomsch@dell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/io_apic.c |   71 -------------------------------------------
 1 files changed, 71 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -1283,72 +1283,6 @@ void disable_IO_APIC(void)
 }
 
 /*
- * function to set the IO-APIC physical IDs based on the
- * values stored in the MPC table.
- *
- * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
- */
-
-static void __init setup_ioapic_ids_from_mpc (void)
-{
-	union IO_APIC_reg_00 reg_00;
-	int apic;
-	int i;
-	unsigned char old_id;
-	unsigned long flags;
-
-	/*
-	 * Set the IOAPIC ID to the value stored in the MPC table.
-	 */
-	for (apic = 0; apic < nr_ioapics; apic++) {
-
-		/* Read the register 0 value */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(apic, 0);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-		
-		old_id = mp_ioapics[apic].mpc_apicid;
-
-
-		printk(KERN_INFO "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
-
-
-		/*
-		 * We need to adjust the IRQ routing table
-		 * if the ID changed.
-		 */
-		if (old_id != mp_ioapics[apic].mpc_apicid)
-			for (i = 0; i < mp_irq_entries; i++)
-				if (mp_irqs[i].mpc_dstapic == old_id)
-					mp_irqs[i].mpc_dstapic
-						= mp_ioapics[apic].mpc_apicid;
-
-		/*
-		 * Read the right value from the MPC table and
-		 * write it into the ID register.
-	 	 */
-		apic_printk(APIC_VERBOSE,KERN_INFO "...changing IO-APIC physical APIC ID to %d ...",
-				mp_ioapics[apic].mpc_apicid);
-
-		reg_00.bits.ID = mp_ioapics[apic].mpc_apicid;
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0, reg_00.raw);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-
-		/*
-		 * Sanity check
-		 */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_00.raw = io_apic_read(apic, 0);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
-			printk("could not set ID!\n");
-		else
-			apic_printk(APIC_VERBOSE," ok.\n");
-	}
-}
-
-/*
  * There is a nasty bug in some older SMP boards, their mptable lies
  * about the timer IRQ. We do the following to work around the situation:
  *
@@ -1863,11 +1797,6 @@ void __init setup_IO_APIC(void)
 
 	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
 
-	/*
-	 * Set up the IO-APIC IRQ routing table.
-	 */
-	if (!acpi_ioapic)
-		setup_ioapic_ids_from_mpc();
 	sync_Arb_IDs();
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
