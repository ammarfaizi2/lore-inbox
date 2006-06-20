Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWFTWem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWFTWem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWFTWeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:34:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59108 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751359AbWFTW3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:02 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 24/25] x86_64 irq: Kill irq compression.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:37 -0600
Message-Id: <1150842527127-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425263761-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com> <11508425253581-git-send-email-ebiederm@xmission.com> <11508425254020-git-send-email-ebiederm@xmission.com> <11508425262259-git-send-email-ebiederm@xmission.com> <11508425263761-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With more irqs in the system we don't need this.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |    5 -----
 arch/x86_64/kernel/mpparse.c |   42 +-----------------------------------------
 include/asm-x86_64/io_apic.h |    1 -
 3 files changed, 1 insertions(+), 47 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index a904ba7..c4be89e 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1722,8 +1722,6 @@ static inline void unlock_ExtINT_logic(v
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-int timer_uses_ioapic_pin_0;
-
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
@@ -1760,9 +1758,6 @@ static inline void check_timer(void)
 	pin2  = ioapic_i8259.pin;
 	apic2 = ioapic_i8259.apic;
 
-	if (pin1 == 0)
-		timer_uses_ioapic_pin_0 = 1;
-
 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n",
 		vector, apic1, pin1, apic2, pin2);
 
diff --git a/arch/x86_64/kernel/mpparse.c b/arch/x86_64/kernel/mpparse.c
index 083da7e..304cef6 100644
--- a/arch/x86_64/kernel/mpparse.c
+++ b/arch/x86_64/kernel/mpparse.c
@@ -910,20 +910,11 @@ void __init mp_config_acpi_legacy_irqs (
 	return;
 }
 
-#define MAX_GSI_NUM	4096
-
 int mp_register_gsi(u32 gsi, int triggering, int polarity)
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
 	int			idx, bit = 0;
-	static int		pci_irq = 16;
-	/*
-	 * Mapping between Global System Interrupts, which
-	 * represent all possible interrupts, to the IRQs
-	 * assigned to actual devices.
-	 */
-	static int		gsi_to_irq[MAX_GSI_NUM];
 
 	if (acpi_irq_model != ACPI_IRQ_MODEL_IOAPIC)
 		return gsi;
@@ -956,42 +947,11 @@ int mp_register_gsi(u32 gsi, int trigger
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return gsi_to_irq[gsi];
+		return gsi;
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-	if (triggering == ACPI_LEVEL_SENSITIVE) {
-		/*
-		 * For PCI devices assign IRQs in order, avoiding gaps
-		 * due to unused I/O APIC pins.
-		 */
-		int irq = gsi;
-		if (gsi < MAX_GSI_NUM) {
-			/*
-			 * Retain the VIA chipset work-around (gsi > 15), but
-			 * avoid a problem where the 8254 timer (IRQ0) is setup
-			 * via an override (so it's not on pin 0 of the ioapic),
-			 * and at the same time, the pin 0 interrupt is a PCI
-			 * type.  The gsi > 15 test could cause these two pins
-			 * to be shared as IRQ0, and they are not shareable.
-			 * So test for this condition, and if necessary, avoid
-			 * the pin collision.
-			 */
-			if (gsi > 15 || (gsi == 0 && !timer_uses_ioapic_pin_0))
-				gsi = pci_irq++;
-			/*
-			 * Don't assign IRQ used by ACPI SCI
-			 */
-			if (gsi == acpi_fadt.sci_int)
-				gsi = pci_irq++;
-			gsi_to_irq[irq] = gsi;
-		} else {
-			printk(KERN_ERR "GSI %u is too high\n", gsi);
-			return gsi;
-		}
-	}
-
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		triggering == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
diff --git a/include/asm-x86_64/io_apic.h b/include/asm-x86_64/io_apic.h
index 06806b1..c5235d6 100644
--- a/include/asm-x86_64/io_apic.h
+++ b/include/asm-x86_64/io_apic.h
@@ -164,7 +164,6 @@ #ifdef CONFIG_ACPI
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
 extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int, int);
-extern int timer_uses_ioapic_pin_0;
 #endif
 
 extern int sis_apic_bug; /* dummy */ 
-- 
1.4.0.gc07e

