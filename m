Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUKOBfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUKOBfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKOBdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:33:45 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:36880 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261394AbUKOBcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:32:15 -0500
Date: Mon, 15 Nov 2004 01:32:13 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: apic_printk() used before initialized
Message-ID: <Pine.LNX.4.58L.0411150122160.22313@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Both detect_init_APIC() and init_apic_mappings() it's called from are 
invoked early, before the command line has been processed.  Therefore its 
meaningless to call apic_printk() from them as that depends on 
apic_verbosity which is initialized from the command line.

 I could move apic_verbosity initialization to parse_cmdline_early(), but 
I think that would be an overkill, the point being we are initerested in 
feedback from detect_init_APIC() anyway.  Without that it's hard to tell 
what's really going on as it's been the case with the recent report of the 
local APIC being non-functional despite the whole setup being apparently 
correct.  So I converted these calls to ordinary printk() invocations.  
The init_apic_mappings() are less interesting, so I've made them output at 
the debug level.

 While at it I've made some obvious nearby formatting clean-up.

 The changes have been successfully tested at the run-time on my system.  
Andrew, please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

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
