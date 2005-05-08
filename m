Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVEHNto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVEHNto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVEHNto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:15312 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262872AbVEHNtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:49:36 -0400
Date: Sun, 8 May 2005 15:49:32 +0200
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, zwane@arm.linux.org.uk,
       len.brown@intel.com, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Message-ID: <20050508134932.GE15724@wotan.suse.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B50@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B50@USRV-EXCH4.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 12:01:22AM -0500, Protasevich, Natalie wrote:
> > > 
> > > This patch disables unique IO_APIC_ID check for xAPIC 
> > systems running in EM64T mode. Xeon-based ES7000s panic 
> > failing this unnecessary check. I added IOAPIC_ID_CHECK 
> > config option and turned it off for Intel processors. Also 
> > added the boot option that overrides default and turnes this 
> > check on/off in case it is needed for some reason. Hope this 
> > is acceptable way to fix the problem.
> > 
> > I think we can turn it off for all x86-64 systems. Near all 
> > EM64T systems have xAPIC. AMD processors don't need it 
> > neither. That would only leave the new IBM summit2 chipset, 
> > but I suppose they also don't need this (James please 
> > complain if I am wrong) 
> > So can you please do a new patch that just removes this code?
> 
> Sure, I will remove the io_apic_get_unique_id() then. Perhaps, it will
> be easy to put it back in if someone implements a chipset that needs it.

I did it myself now.

> 
> Andi, I submitted the patch for i386 a little while ago
> http://www.ussg.iu.edu/hypermail/linux/kernel/0505.0/0195.html (I sent
> it to you also, but just noticed that it was not your usual email
> address - where did I get if from? have no idea...) Genapic in i386 has
> a NO_IOAPIC_CHECK flag that is defined in every subarch, so it was easy
> to fix the problem by making use of it in ACPI boot path just as it was
> used in MP path.

That will not help on the other systems who don't have an own subarchitecture
but still run into problems with the check. 

I think the right strategy for i386 would be to remove this check thing
from the subarchitecture and implement the heuristic described in the
last mail.

-Andi


Remove unique APIC/IO-APIC ID check

It is unnecessary on modern Intel or AMD systems, and that
is all we support on x86-64

Also causes problems on various systems

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -1805,76 +1805,6 @@ device_initcall(ioapic_init_sysfs);
 
 #define IO_APIC_MAX_ID		0xFE
 
-int __init io_apic_get_unique_id (int ioapic, int apic_id)
-{
-	union IO_APIC_reg_00 reg_00;
-	static physid_mask_t apic_id_map;
-	unsigned long flags;
-	int i = 0;
-
-	/*
-	 * The P4 platform supports up to 256 APIC IDs on two separate APIC 
-	 * buses (one for LAPICs, one for IOAPICs), where predecessors only 
-	 * supports up to 16 on one shared APIC bus.
-	 * 
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
-	 */
-
-	if (physids_empty(apic_id_map))
-		apic_id_map = phys_cpu_present_map;
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	reg_00.raw = io_apic_read(ioapic, 0);
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	if (apic_id >= IO_APIC_MAX_ID) {
-		apic_printk(APIC_QUIET, KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.bits.ID);
-		apic_id = reg_00.bits.ID;
-	}
-
-	/*
-	 * Every APIC in a system must have a unique ID or we get lots of nice 
-	 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 */
-	if (physid_isset(apic_id, apic_id_map)) {
-
-		for (i = 0; i < IO_APIC_MAX_ID; i++) {
-			if (!physid_isset(i, apic_id_map))
-				break;
-		}
-
-		if (i == IO_APIC_MAX_ID)
-			panic("Max apic_id exceeded!\n");
-
-		apic_printk(APIC_VERBOSE, KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
-			"trying %d\n", ioapic, apic_id, i);
-
-		apic_id = i;
-	} 
-
-	physid_set(apic_id, apic_id_map);
-
-	if (reg_00.bits.ID != apic_id) {
-		reg_00.bits.ID = apic_id;
-
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic, 0, reg_00.raw);
-		reg_00.raw = io_apic_read(ioapic, 0);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-
-		/* Sanity check */
-		if (reg_00.bits.ID != apic_id)
-			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
-	}
-
-	apic_printk(APIC_VERBOSE,KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
-
-	return apic_id;
-}
-
-
 int __init io_apic_get_version (int ioapic)
 {
 	union IO_APIC_reg_01	reg_01;
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -763,7 +763,7 @@ void __init mp_register_ioapic (
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	mp_ioapics[idx].mpc_apicid = id;
 	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
Index: linux/include/asm-x86_64/io_apic.h
===================================================================
--- linux.orig/include/asm-x86_64/io_apic.h
+++ linux/include/asm-x86_64/io_apic.h
@@ -202,7 +202,6 @@ extern int skip_ioapic_setup;
 #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
 
 #ifdef CONFIG_ACPI_BOOT
-extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
 extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int, int);
