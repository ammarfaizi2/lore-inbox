Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUKOXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUKOXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKOXfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:35:24 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62738 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261643AbUKOXdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:33:03 -0500
Date: Mon, 15 Nov 2004 23:33:00 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <4198EFE5.5010003@aknet.ru>
Message-ID: <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
 <4198EFE5.5010003@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Stas Sergeev wrote:

> But there is still something strange.
> Previously, in 2.6.10-rc1 (and in -mm2
> either I think) the NMI watchdog was
> working in both LAPIC and IO-APIC modes.
> Now - only in LAPIC mode.
> nmi_watchdog=1 still doesn't work.
> Any ideas about this?

 Interesting -- your local APIC seems to be disabled by the firmware
(otherwise it would work even without my fix), so how can an I/O APIC
work?  Bringing it up requires a set of tables in memory describing its
configuration to have been prepared by the firmware by means of either the
MPS or the ACPI standard.  Disabling the local APIC likely implies no 
explicit support for APICs is present in the firmware, so such tables 
should be absent.

> Just trying to make sure that everything
> is correct.

 With no APIC messages at all it's hard to decide whether it's correct or 
not.

> And btw, dmesg is still silent about a
> LAPIC. This makes me nervous when I am
> trying to figure out whether it works or
> not:) Would be nice to get those prominent
> messages back, as per 2.6.8.

 Someone wasn't as much fond of them as you are and they were removed by
default.  I'm pissed off, too, but my opinion doesn't matter -- others
seem to have better skills with their crystal balls.  Please try "debug
apic=debug" on your command line together with the following patch (the
"apic=" parameter suffers from the same problem "lapic" and "nolapic"  
do, but IMO it would be an overkill to move it to parse_cmdline_early()).

 If you send me the bootstrap log back I may have a look to see what's 
wrong about the I/O APIC.

  Maciej

patch-2.6.10-rc1-mm5-i386-apic_printk-0
diff -up --recursive --new-file linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/apic.c linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c
--- linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/apic.c	2004-11-14 16:01:48.000000000 +0000
+++ linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c	2004-11-15 00:55:22.000000000 +0000
@@ -760,9 +760,8 @@ static int __init detect_init_APIC (void
 		 * APIC only if "lapic" specified.
 		 */
 		if (enable_local_apic <= 0) {
-			apic_printk(APIC_VERBOSE,
-				    "Local APIC disabled by BIOS -- "
-				    "you can enable it with \"lapic\"\n");
+			printk("Local APIC disabled by BIOS -- "
+			       "you can enable it with \"lapic\"\n");
 			return -1;
 		}
 		/*
@@ -773,8 +772,7 @@ static int __init detect_init_APIC (void
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
-			apic_printk(APIC_VERBOSE, "Local APIC disabled "
-					"by BIOS -- reenabling.\n");
+			printk("Local APIC disabled by BIOS -- reenabling.\n");
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
@@ -801,7 +799,7 @@ static int __init detect_init_APIC (void
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
-	apic_printk(APIC_VERBOSE, "Found and enabled local APIC!\n");
+	printk("Found and enabled local APIC!\n");
 
 	apic_pm_activate();
 
@@ -828,8 +826,8 @@ void __init init_apic_mappings(void)
 		apic_phys = mp_lapic_addr;
 
 	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
-	apic_printk(APIC_DEBUG, "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
-			apic_phys);
+	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
+	       apic_phys);
 
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
@@ -847,21 +845,23 @@ void __init init_apic_mappings(void)
 			if (smp_found_config) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
 				if (!ioapic_phys) {
-					printk(KERN_ERR "WARNING: bogus zero IO-APIC address found in MPTABLE, disabling IO/APIC support!\n");
-
+					printk(KERN_ERR
+					       "WARNING: bogus zero IO-APIC "
+					       "address found in MPTABLE, "
+					       "disabling IO/APIC support!\n");
 					smp_found_config = 0;
 					skip_ioapic_setup = 1;
 					goto fake_ioapic_page;
 				}
 			} else {
 fake_ioapic_page:
-				ioapic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+				ioapic_phys = (unsigned long)
+					      alloc_bootmem_pages(PAGE_SIZE);
 				ioapic_phys = __pa(ioapic_phys);
 			}
 			set_fixmap_nocache(idx, ioapic_phys);
-			apic_printk(APIC_DEBUG, "mapped IOAPIC to "
-					"%08lx (%08lx)\n",
-					__fix_to_virt(idx), ioapic_phys);
+			printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
+			       __fix_to_virt(idx), ioapic_phys);
 			idx++;
 		}
 	}
