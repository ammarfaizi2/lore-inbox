Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWHJUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWHJUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWHJUOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:50 -0400
Received: from mail.suse.de ([195.135.220.2]:35216 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932340AbWHJTgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:09 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [52/145] x86_64: Remove pirq overwrite support
Message-Id: <20060810193607.096CE13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:06 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

This was an old workaround for broken MP-BIOS. The user could
specify overwrites on the command line.

I've never seen it being used for anything on 64bit. So get
rid of it for now.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/io_apic.c |   55 -------------------------------------------
 1 files changed, 55 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -225,14 +225,6 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
-/*
- * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
- * specific CPU-side IRQs.
- */
-
-#define MAX_PIRQS 8
-static int pirq_entries [MAX_PIRQS];
-static int pirqs_enabled;
 int skip_ioapic_setup;
 int ioapic_force;
 
@@ -370,34 +362,6 @@ void __init check_ioapic(void) 
 	}
 } 
 
-static int __init ioapic_pirq_setup(char *str)
-{
-	int i, max;
-	int ints[MAX_PIRQS+1];
-
-	get_options(str, ARRAY_SIZE(ints), ints);
-
-	for (i = 0; i < MAX_PIRQS; i++)
-		pirq_entries[i] = -1;
-
-	pirqs_enabled = 1;
-	apic_printk(APIC_VERBOSE, "PIRQ redirection, working around broken MP-BIOS.\n");
-	max = MAX_PIRQS;
-	if (ints[0] < MAX_PIRQS)
-		max = ints[0];
-
-	for (i = 0; i < max; i++) {
-		apic_printk(APIC_VERBOSE, "... PIRQ%d -> IRQ %d\n", i, ints[i+1]);
-		/*
-		 * PIRQs are mapped upside down, usually.
-		 */
-		pirq_entries[MAX_PIRQS-i-1] = ints[i+1];
-	}
-	return 1;
-}
-
-__setup("pirq=", ioapic_pirq_setup);
-
 /*
  * Find the IRQ entry number of a certain pin.
  */
@@ -793,22 +757,6 @@ static int pin_2_irq(int idx, int apic, 
 		}
 	}
 	BUG_ON(irq >= NR_IRQS);
-
-	/*
-	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
-	 */
-	if ((pin >= 16) && (pin <= 23)) {
-		if (pirq_entries[pin-16] != -1) {
-			if (!pirq_entries[pin-16]) {
-				apic_printk(APIC_VERBOSE, "disabling PIRQ%d\n", pin-16);
-			} else {
-				irq = pirq_entries[pin-16];
-				apic_printk(APIC_VERBOSE, "using PIRQ%d -> IRQ %d\n",
-						pin-16, irq);
-			}
-		}
-	}
-	BUG_ON(irq >= NR_IRQS);
 	return irq;
 }
 
@@ -1281,9 +1229,6 @@ static void __init enable_IO_APIC(void)
 		irq_2_pin[i].pin = -1;
 		irq_2_pin[i].next = 0;
 	}
-	if (!pirqs_enabled)
-		for (i = 0; i < MAX_PIRQS; i++)
-			pirq_entries[i] = -1;
 
 	/*
 	 * The number of IO-APIC IRQ registers (== #pins):
