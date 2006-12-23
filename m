Return-Path: <linux-kernel-owner+w=401wt.eu-S1752288AbWLWFlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWLWFlW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 00:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWLWFlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 00:41:22 -0500
Received: from hera.kernel.org ([140.211.167.34]:48617 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbWLWFlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 00:41:21 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: Section mismatch on current git head
Date: Sat, 23 Dec 2006 00:40:27 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <458BEAA9.6010503@m3y3r.de>
In-Reply-To: <458BEAA9.6010503@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612230040.28898.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> WARNING: vmlinux - Section mismatch: reference to 
> .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at 
> offset 0xc010e020) and 'acpi_unmap_lsapic'
> WARNING: vmlinux - Section mismatch: reference to 
> .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at 
> offset 0xc010e04a) and 'acpi_unmap_lsapic'
> WARNING: vmlinux - Section mismatch: reference to 
> .init.text:mp_override_legacy_irq from .text between 
> 'acpi_sci_ioapic_setup' (at offset 0xc010e062) and 'acpi_unmap_lsapic'
> WARNING: vmlinux - Section mismatch: reference to 
> .init.data:acpi_sci_override_gsi from .text between 
> 'acpi_sci_ioapic_setup' (at offset 0xc010e068) and 'acpi_unmap_lsapic'

The acpi_sci_ioapic_setup ones should go away with the patch below, but do no harm in the mean-time.
cheers,
-Len

commit 0351a612f7a46995c28d4ef6189229b5d1dfc6c3
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 21 01:29:59 2006 -0500

    ACPI: fix section mis-match build warning
    
    Dunno why this pops out in only in the allmodconfig build.
    Though the warning is accurate, all the callers of the flagged
    non __init function are __init, this is not a functional change.
    
    WARNING: vmlinux - Section mismatch: reference to .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at offset 0xc010f0a
    6) and 'acpi_gsi_to_irq'                                                                                                                   WARNING: vmlinux - Section mismatch: reference to .init.text:mp_override_legacy_irq from .text between 'acpi_sci_ioapic_setup' (at offset 0
    xc010f0de) and 'acpi_gsi_to_irq'                                                                                                           WARNING: vmlinux - Section mismatch: reference to .init.data:acpi_sci_override_gsi from .text between 'acpi_sci_ioapic_setup' (at offset 0x
    c010f0e4) and 'acpi_gsi_to_irq'
    
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index c8f96cf..45cffbf 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -333,7 +333,7 @@ acpi_parse_ioapic(acpi_table_entry_header * header, const unsigned long end)
 /*
  * Parse Interrupt Source Override for the ACPI SCI
  */
-static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
+static void __init acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
 {
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;

