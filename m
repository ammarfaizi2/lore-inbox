Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWFTWhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWFTWhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWFTWf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:35:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58340 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751355AbWFTW3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:01 -0400
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
Subject: [PATCH 23/25] x86_64 irq: Kill gsi_irq_sharing.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:36 -0600
Message-Id: <11508425263761-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425262259-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com> <11508425253581-git-send-email-ebiederm@xmission.com> <11508425254020-git-send-email-ebiederm@xmission.com> <11508425262259-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After raising the number of irqs the system supports this
function is no longer necessary.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/acpi/boot.c |    5 +--
 arch/x86_64/kernel/io_apic.c |   62 ------------------------------------------
 2 files changed, 1 insertions(+), 66 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 6e7edc0..74fd53c 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -42,7 +42,6 @@ #ifdef	CONFIG_X86_64
 
 extern void __init clustered_apic_check(void);
 
-extern int gsi_irq_sharing(int gsi);
 #include <asm/proto.h>
 
 static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id) { return 0; }
@@ -55,8 +54,6 @@ #include <mach_apic.h>
 #include <mach_mpparse.h>
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
-static inline int gsi_irq_sharing(int gsi) { return gsi; }
-
 #endif				/* X86 */
 
 #define BAD_MADT_ENTRY(entry, end) (					    \
@@ -459,7 +456,7 @@ void __init acpi_pic_sci_set_trigger(uns
 
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	*irq = gsi_irq_sharing(gsi);
+	*irq = gsi;
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index f818d64..a904ba7 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -164,8 +164,6 @@ static void set_ioapic_affinity_irq(unsi
 }
 #endif
 
-static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };
-
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -721,64 +719,6 @@ static inline int irq_trigger(int idx)
 	return MPBIOS_trigger(idx);
 }
 
-static int next_irq = 16;
-
-/*
- * gsi_irq_sharing -- Name overload!  "irq" can be either a legacy IRQ
- * in the range 0-15, a linux IRQ in the range 0-223, or a GSI number
- * from ACPI, which can reach 800 in large boxen.
- *
- * Compact the sparse GSI space into a sequential IRQ series and reuse
- * vectors if possible.
- */
-int gsi_irq_sharing(int gsi)
-{
-	int i, tries, vector;
-
-	BUG_ON(gsi >= NR_IRQ_VECTORS);
-
-	if (platform_legacy_irq(gsi))
-		return gsi;
-
-	if (gsi_2_irq[gsi] != 0xFF)
-		return (int)gsi_2_irq[gsi];
-
-	tries = NR_IRQS;
-  try_again:
-	vector = assign_irq_vector(gsi, TARGET_CPUS);
-
-	/*
-	 * Sharing vectors means sharing IRQs, so scan irq_vectors for previous
-	 * use of vector and if found, return that IRQ.  However, we never want
-	 * to share legacy IRQs, which usually have a different trigger mode
-	 * than PCI.
-	 */
-	for (i = 0; i < NR_IRQS; i++)
-		if (IO_APIC_VECTOR(i) == vector)
-			break;
-	if (platform_legacy_irq(i)) {
-		if (--tries >= 0) {
-			IO_APIC_VECTOR(i) = 0;
-			goto try_again;
-		}
-		panic("gsi_irq_sharing: didn't find an IRQ using vector 0x%02X for GSI %d", vector, gsi);
-	}
-	if (i < NR_IRQS) {
-		gsi_2_irq[gsi] = i;
-		printk(KERN_INFO "GSI %d sharing vector 0x%02X and IRQ %d\n",
-				gsi, vector, i);
-		return i;
-	}
-
-	i = next_irq++;
-	BUG_ON(i >= NR_IRQS);
-	gsi_2_irq[gsi] = i;
-	IO_APIC_VECTOR(i) = vector;
-	printk(KERN_INFO "GSI %d assigned vector 0x%02X and IRQ %d\n",
-			gsi, vector, i);
-	return i;
-}
-
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;
@@ -808,7 +748,6 @@ static int pin_2_irq(int idx, int apic, 
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
-			irq = gsi_irq_sharing(irq);
 			break;
 		}
 		default:
@@ -2202,7 +2141,6 @@ int io_apic_set_pci_routing (int ioapic,
 		return -EINVAL;
 	}
 
-	irq = gsi_irq_sharing(irq);
 	/*
 	 * IRQs < 16 are already in the irq_2_pin[] map
 	 */
-- 
1.4.0.gc07e

