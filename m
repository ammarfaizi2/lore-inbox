Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVBOQ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVBOQ04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVBOQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:26:55 -0500
Received: from atlas.fs.tum.de ([129.187.202.11]:40588 "EHLO atlas.fs.tum.de")
	by vger.kernel.org with ESMTP id S261772AbVBOQ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:26:24 -0500
Date: Wed, 16 Feb 2005 17:26:22 +0100 (CET)
From: Andreas Deresch <aderesch@fs.tum.de>
Reply-To: Andreas Deresch <aderesch@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: panic during IO-APIC detection
Message-ID: <Pine.LNX.4.62.0502161701300.10460@Magrathea>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml,

my notebook (Acer Aspire 1691WLMi, chipset: Intel 915PM) hangs during
IO-APIC detection. I am currently using 2.6.11-rc4-bk1, but this should be
the same for other versions.

Reason:
ACPI MADT contains info on 2 IO-APICs.
io_apic_get_unique_id panics due to being unable to assign an id to the
second one (the memory location reads as all ones). The chipset spec
(specifically: ICH6-M) is only talking about one IO-APIC, so most likely the
MADT is in error.

The question is, should io_apic_get_unique_id be more fault tolerant, or
where else should this be fixed?

TIA,
ad

For the moment I did the following:

diff -rbBu linux-2.6.11.orig/arch/i386/kernel/io_apic.c linux-2.6.11/arch/i386/kernel/io_apic.c
--- linux-2.6.11.orig/arch/i386/kernel/io_apic.c	2005-02-15 20:50:11.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/io_apic.c	2005-02-14 23:49:04.000000000 +0100
@@ -2449,8 +2449,10 @@
  		spin_unlock_irqrestore(&ioapic_lock, flags);

  		/* Sanity check */
-		if (reg_00.bits.ID != apic_id)
-			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+		if (reg_00.bits.ID != apic_id) {
+			printk("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+			return -1;
+		}
  	}

  	apic_printk(APIC_VERBOSE, KERN_INFO
diff -rbBu linux-2.6.11.orig/arch/i386/kernel/mpparse.c linux-2.6.11/arch/i386/kernel/mpparse.c
--- linux-2.6.11.orig/arch/i386/kernel/mpparse.c	2005-02-15 20:50:11.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/mpparse.c	2005-02-14 23:49:23.000000000 +0100
@@ -895,6 +895,7 @@
  	u32			gsi_base)
  {
  	int			idx = 0;
+	int			tmpid = 0;

  	if (nr_ioapics >= MAX_IO_APICS) {
  		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
@@ -914,7 +915,11 @@
  	mp_ioapics[idx].mpc_apicaddr = address;

  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	if ((tmpid = io_apic_get_unique_id(idx, id)) == -1) {
+		nr_ioapics--;
+		return;
+	}
+	mp_ioapics[idx].mpc_apicid = (u8)(tmpid);
  	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);

  	/*
