Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWHBQYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWHBQYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWHBQYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:24:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932091AbWHBQYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:24:15 -0400
Date: Wed, 2 Aug 2006 12:24:09 -0400
From: Kimball Murray <kimball.murray@gmail.com>
To: <akpm@digeo.com>
Cc: Kimball Murray <kimball.murray@gmail.com>, <len.brown@intel.com>,
       <ak@suse.de>, <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>
Message-Id: <20060802162210.30097.44577.sendpatchset@dhcp83-86.boston.redhat.com>
Subject: [PATCH] ACPI SCI interrupt source override
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of a patch sent to linux-acpi a few months ago.  Casting it
out to a wider audience now.

The Linux group at Stratus Technologies has come across an
issue with SCI routing under ACPI.  We were bitten by this when we made an
x86_64 platform whose BIOS provides an Interrupt Source Override for the SCI
itself.  Apparently the override has no effect for the System Control
Interrupt, and this appears to be because of the way the SCI is setup
in the ACPI code.  It does not handle the case where busirq != gsi.

The code that sets up the SCI routing assumes that bus irq == global irq.
So there is simply no provision for telling it otherwise.  The attached patch
provides this mechanism.

This patch provided by David Bulkow, was tested on an i386 platform,
which does not use the SCI override, and also on an x86_64 platform which
does use an override.

This patch was generated against Linus' git tree.

Signed-off by: David Bulkow	<david.bulkow@stratus.com>

---------------- snip -----------------------------------------
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 0db6387..efeeaab 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -325,7 +325,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
+static void acpi_sci_ioapic_setup(u32 bus_irq, u32 gsi, u16 polarity, u16 trigger)
 {
        if (trigger == 0)       /* compatible SCI trigger is level */
                trigger = 3;
@@ -345,13 +345,13 @@ static void acpi_sci_ioapic_setup(u32 gs
         * If GSI is < 16, this will update its flags,
         * else it will create a new mp_irqs[] entry.
         */
-       mp_override_legacy_irq(gsi, polarity, trigger, gsi);
+       mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
 
        /*
         * stash over-ride to indicate we've been here
         * and for later update of acpi_fadt
         */
-       acpi_sci_override_gsi = gsi;
+       acpi_sci_override_gsi = bus_irq;
        return;
 }

@@ -369,7 +369,7 @@ acpi_parse_int_src_ovr(acpi_table_entry_
        acpi_table_print_madt_entry(header);
 
        if (intsrc->bus_irq == acpi_fadt.sci_int) {
-               acpi_sci_ioapic_setup(intsrc->global_irq,
+               acpi_sci_ioapic_setup(intsrc->bus_irq, intsrc->global_irq,
                                      intsrc->flags.polarity,
                                      intsrc->flags.trigger);
                return 0;
@@ -793,7 +793,7 @@ static int __init acpi_parse_madt_ioapic
         * pretend we got one so we can set the SCI flags.
         */
        if (!acpi_sci_override_gsi)
-               acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
+               acpi_sci_ioapic_setup(acpi_fadt.sci_int, acpi_fadt.sci_int, 0, 0);
 
        /* Fill in identity legacy mapings where no override */
        mp_config_acpi_legacy_irqs();

