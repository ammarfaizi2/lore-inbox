Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWDTXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWDTXOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDTXOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:14:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751261AbWDTXOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:14:44 -0400
Date: Thu, 20 Apr 2006 19:14:33 -0400
From: Kimball Murray <kimball.murray@gmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: Kimball Murray <kimball.murray@gmail.com>, <akpm@digeo.com>, <ak@suse.de>,
       <kmurray@redhat.com>, <natalie.protasevich@unisys.com>,
       <len.brown@intel.com>, <linux-acpi@vger.kernel.org>
Message-Id: <20060420230931.10317.38083.sendpatchset@dhcp83-97.boston.redhat.com>
Subject: [git Patch 1/1] avoid IRQ0 ioapic pin collision
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm working on an x86_64 platfrom, where I've hit a problem that appears to
be caused by a patch that went into 2.6.13 some time ago.  (git details are
below).  Basically, that patch introduced a work-around for a VIA chipset
limitation (only 4 bits to store a PCI interrupt).  And that work-around
causes an unfortunate pin collision on our ioapic.

Our system uses an ACPI Interrupt Source Override to inform the OS that the
8254 timer (IRQ0) is on pin 1 of the ioapic.  On that same ioapic, pin 0
handles an interrupt from a PCI device.  The work-around for the VIA chipset
now causes pin 0 to get IRQ0 on our platform, which the timer also claims.
The sad result is both pins 0 and 1 drive IRQ0, but pins 0 and 1 have
different triggering characterists (and polarity), so time learches forward
in an IRQ0 interrupt storm.

I brought this up with Natalie, who provided the VIA patch.  What we came up
with is a means of keeping the VIA work-around, but at the same time, avoiding
the IRQ0 collision.  What I'm doing here is creating a flag in io_apic.c
(timer_uses_ioapic_pin_0), which is checked in mpparse.c.  If the timer is
not using pin 0, and we find a PCI-type interrupt for gsi 0, then I bump
the gsi up to the current value of pci_irq.  Otherwise, it behaves as before.

For reference, here are the git details for the patch that works around the
VIA issue.

--------- original git patch (2.6.13) --------------------

[PATCH] x86: avoid wasting IRQs patch update

The patch addresses a problem with ACPI SCI interrupt entry, which gets
re-used, and the IRQ is assigned to another unrelated device.  The patch
corrects the code such that SCI IRQ is skipped and duplicate entry is
avoided.  Second issue came up with VIA chipset, the problem was caused by
original patch assigning IRQs starting 16 and up.  The VIA chipset uses
4-bit IRQ register for internal interrupt routing, and therefore cannot
handle IRQ numbers assigned to its devices.  The patch corrects this
problem by allowing PCI IRQs below 16.

Signed-off by: Natalie Protasevich <Natalie.Protasevich@unisys.com>

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
commit e1afc3f522ed088405fc8932110d338330db82bb
tree 944b79bef5f73bfe1ea7fc5e89cb9e36562d0929
parent 80625942094b114d85811e5ff1fbc9e06dabe0ff
author Natalie.Protasevich@unisys.com <Natalie.Protasevich@unisys.com> 
Fri, 29 Jul 2005 14:03:32 -0700
committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 29 Jul 2005 15:01:13 
-0700

 arch/i386/kernel/mpparse.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
index af917f6..ce838ab 100644
--- a/arch/i386/kernel/mpparse.c
+++ b/arch/i386/kernel/mpparse.c
@@ -1116,7 +1116,15 @@ int mp_register_gsi (u32 gsi, int edge_l
                 */
                int irq = gsi;
                if (gsi < MAX_GSI_NUM) {
-                       gsi = pci_irq++;
+                       if (gsi > 15)
+                               gsi = pci_irq++;
+#ifdef CONFIG_ACPI_BUS
+                       /*
+                        * Don't assign IRQ used by ACPI SCI
+                        */
+                       if (gsi == acpi_fadt.sci_int)
+                               gsi = pci_irq++;
+#endif
                        gsi_to_irq[irq] = gsi;
                } else {
                        printk(KERN_ERR "GSI %u is too high\n", gsi);

--------- end of original git patch (2.6.13) ----------



And finally, here is my proposed patch for both i386 and x86_64,
generated from Linus' git tree.

----------------- snip -----------------------------------
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index f8f132a..d70f2ad 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2238,6 +2238,8 @@ static inline void unlock_ExtINT_logic(v
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+int timer_uses_ioapic_pin_0;
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
@@ -2274,6 +2276,9 @@ static inline void check_timer(void)
 	pin2  = ioapic_i8259.pin;
 	apic2 = ioapic_i8259.apic;
 
+	if (pin1 == 0)
+		timer_uses_ioapic_pin_0 = 1;
+
 	printk(KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n",
 		vector, apic1, pin1, apic2, pin2);
 
diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
index 34d21e2..412c1f7 100644
--- a/arch/i386/kernel/mpparse.c
+++ b/arch/i386/kernel/mpparse.c
@@ -1130,7 +1130,18 @@ int mp_register_gsi (u32 gsi, int trigge
 		 */
 		int irq = gsi;
 		if (gsi < MAX_GSI_NUM) {
-			if (gsi > 15)
+			extern int timer_uses_ioapic_pin_0;
+			/*
+			 * Retain the VIA chipset work-around (gsi > 15), but
+			 * avoid a problem where the 8254 timer (IRQ0) is setup
+			 * via an override (so it's not on pin 0 of the ioapic),
+			 * and at the same time, the pin 0 interrupt is a PCI
+			 * type.  The gsi > 15 test could cause these two pins
+			 * to be shared as IRQ0, and they are not shareable.
+			 * So test for this condition, and if necessary, avoid
+			 * the pin collision.
+			 */
+			if (gsi > 15 || (gsi == 0 && !timer_uses_ioapic_pin_0))
 				gsi = pci_irq++;
 			/*
 			 * Don't assign IRQ used by ACPI SCI
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 77b4c60..0de3ea9 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1777,6 +1777,8 @@ static inline void unlock_ExtINT_logic(v
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+int timer_uses_ioapic_pin_0;
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
@@ -1814,6 +1816,9 @@ static inline void check_timer(void)
 	pin2  = ioapic_i8259.pin;
 	apic2 = ioapic_i8259.apic;
 
+	if (pin1 == 0)
+		timer_uses_ioapic_pin_0 = 1;
+
 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n",
 		vector, apic1, pin1, apic2, pin2);
 
diff --git a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
index b17cf3e..63cac4d 100644
--- a/arch/x86_64/kernel/mpparse.c
+++ b/arch/x86_64/kernel/mpparse.c
@@ -968,7 +968,18 @@ int mp_register_gsi(u32 gsi, int trigger
 		 */
 		int irq = gsi;
 		if (gsi < MAX_GSI_NUM) {
-			if (gsi > 15)
+			extern int timer_uses_ioapic_pin_0;
+			/*
+			 * Retain the VIA chipset work-around (gsi > 15), but
+			 * avoid a problem where the 8254 timer (IRQ0) is setup
+			 * via an override (so it's not on pin 0 of the ioapic),
+			 * and at the same time, the pin 0 interrupt is a PCI
+			 * type.  The gsi > 15 test could cause these two pins
+			 * to be shared as IRQ0, and they are not shareable.
+			 * So test for this condition, and if necessary, avoid
+			 * the pin collision.
+			 */
+			if (gsi > 15 || (gsi == 0 && !timer_uses_ioapic_pin_0))
 				gsi = pci_irq++;
 			/*
 			 * Don't assign IRQ used by ACPI SCI
