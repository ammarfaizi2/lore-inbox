Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJFCzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJFCzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 22:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJFCzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 22:55:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53996 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750715AbVJFCzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 22:55:10 -0400
Message-ID: <4344920A.3070802@google.com>
Date: Wed, 05 Oct 2005 19:55:06 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IO APIC existence check (2.6.14-rc3-git5)
Content-Type: multipart/mixed;
 boundary="------------030708080300000406090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708080300000406090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(This is a resend of:
http://marc.theaimsgroup.com/?l=acpi4linux&m=111688709515378&w=2 )

Hi,

We've come across some boards where the MADT will list IO APICs that
don't really exist in hardware.

The current 2.6, the kernel will panic in io_apic_get_unique_id because
it will fail to force set the APIC id.

This following patch adds a quick check when registering IO APICs to
make sure they exist. We do this by actually checking to see if the data
register loads the version properly and by examining the index register
to see that it was actually modified from 0xff after the io_apic_read.

Thanks,

Mike Waychison

--------------030708080300000406090106
Content-Type: text/plain;
 name="check_io_apic_existance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_io_apic_existance.patch"

This following patch adds a quick check when registering IO APICs to 
make sure they exist. We do this by actually checking to see if the data
register loads the version properly and by examining the index register
to see that it was actually modified from 0xff after the io_apic_read.

Signed-off-by: Mike Waychison <mikew@google.com>

---

 arch/i386/kernel/io_apic.c |    9 +++++++++
 arch/i386/kernel/mpparse.c |   21 +++++++++++++++++++--
 include/asm-i386/io_apic.h |    1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

Index: linux-2.6/include/asm-i386/io_apic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/io_apic.h	2005-10-05 19:40:57.000000000 -0700
+++ linux-2.6/include/asm-i386/io_apic.h	2005-10-05 19:42:42.000000000 -0700
@@ -196,6 +196,7 @@ extern int skip_ioapic_setup;
 #define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
 
 #ifdef CONFIG_ACPI
+extern unsigned char io_apic_read_index (int ioapic);
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
Index: linux-2.6/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/mpparse.c	2005-10-05 19:40:40.000000000 -0700
+++ linux-2.6/arch/i386/kernel/mpparse.c	2005-10-05 19:47:02.000000000 -0700
@@ -913,18 +913,35 @@ void __init mp_register_ioapic (
 		return;
 	}
 
-	idx = nr_ioapics++;
+	/*
+	 * Probe the IO APIC. Set up the ioapic structures so we can do reads,
+	 * but delay incrementing nr_ioapics in case the probe fails
+	 */
+	idx = nr_ioapics;
 
 	mp_ioapics[idx].mpc_type = MP_IOAPIC;
 	mp_ioapics[idx].mpc_flags = MPC_APIC_USABLE;
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
+	/*
+	 * Probe to see if the io_apic looks good.
+	 * index register should be set as well.
+	 */
+	if (mp_ioapics[idx].mpc_apicver == 0xff) {
+		if (io_apic_read_index(idx) == 0xff) {
+			printk(KERN_ERR "WARNING: Bogus (0x%08x) I/O APIC address"
+				" found in MADT table, skipping!\n", address);
+			return;
+		}
+	}
+	nr_ioapics++;
+
 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 < 15))
 		mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
 	else
 		mp_ioapics[idx].mpc_apicid = id;
-	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
 	
 	/* 
 	 * Build basic GSI lookup table to facilitate gsi->io_apic lookups
Index: linux-2.6/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/io_apic.c	2005-10-05 19:40:40.000000000 -0700
+++ linux-2.6/arch/i386/kernel/io_apic.c	2005-10-05 19:41:49.000000000 -0700
@@ -2499,6 +2499,15 @@ int __init io_apic_get_unique_id (int io
 	return apic_id;
 }
 
+unsigned char __init io_apic_read_index (int ioapic)
+{
+	unsigned long flags;
+	unsigned char index_reg;
+	spin_lock_irqsave(&ioapic_lock, flags);
+	index_reg = *IO_APIC_BASE(ioapic);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	return index_reg;
+}
 
 int __init io_apic_get_version (int ioapic)
 {

--------------030708080300000406090106--
