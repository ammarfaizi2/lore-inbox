Return-Path: <linux-kernel-owner+w=401wt.eu-S1947516AbWLHX6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947516AbWLHX6J (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947523AbWLHX6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:58:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60356 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947516AbWLHX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:57:43 -0500
Message-Id: <20061208235953.152433000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Len Brown <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: [patch 09/32] Revert "ACPI: SCI interrupt source override"
Content-Disposition: inline; filename=revert-acpi-sci-interrupt-source-override.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Len Brown <len.brown@intel.com>

This reverts commit 281ea49b0c294649a6de47a6f8fbe5611137726b,
which broke ACPI Interrupt source overrides that move
the SCI from one IRQ in PIC mode to another in IOAPIC mode.

If the SCI shared an interrupt line with another device,
this would result in a "irq 18: nobody cared" type failure.

http://bugzilla.kernel.org/show_bug.cgi?id=7601

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/acpi/boot.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.19.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.19/arch/i386/kernel/acpi/boot.c
@@ -333,7 +333,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 bus_irq, u32 gsi, u16 polarity, u16 trigger)
+static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 {
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;
@@ -353,13 +353,13 @@ static void acpi_sci_ioapic_setup(u32 bu
 	 * If GSI is < 16, this will update its flags,
 	 * else it will create a new mp_irqs[] entry.
 	 */
-	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
+	mp_override_legacy_irq(gsi, polarity, trigger, gsi);
 
 	/*
 	 * stash over-ride to indicate we've been here
 	 * and for later update of acpi_fadt
 	 */
-	acpi_sci_override_gsi = bus_irq;
+	acpi_sci_override_gsi = gsi;
 	return;
 }
 
@@ -377,7 +377,7 @@ acpi_parse_int_src_ovr(acpi_table_entry_
 	acpi_table_print_madt_entry(header);
 
 	if (intsrc->bus_irq == acpi_fadt.sci_int) {
-		acpi_sci_ioapic_setup(intsrc->bus_irq, intsrc->global_irq,
+		acpi_sci_ioapic_setup(intsrc->global_irq,
 				      intsrc->flags.polarity,
 				      intsrc->flags.trigger);
 		return 0;
@@ -880,7 +880,7 @@ static int __init acpi_parse_madt_ioapic
 	 * pretend we got one so we can set the SCI flags.
 	 */
 	if (!acpi_sci_override_gsi)
-		acpi_sci_ioapic_setup(acpi_fadt.sci_int, acpi_fadt.sci_int, 0, 0);
+		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
 
 	/* Fill in identity legacy mapings where no override */
 	mp_config_acpi_legacy_irqs();

--
