Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUBZXRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUBZXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:16:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261231AbUBZXP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:15:59 -0500
Date: Thu, 26 Feb 2004 23:15:50 +0000
From: Matthew Wilcox <willy@debian.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Go Taniguchi <go@turbolinux.co.jp>, willy@debian.org,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
Message-ID: <20040226231550.GY25779@parcelfarce.linux.theplanet.co.uk>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <1077668801.2857.63.camel@cog.beaverton.ibm.com> <20040224170645.392abcff.akpm@osdl.org> <403E0563.9050007@turbolinux.co.jp> <1077830762.2857.164.camel@cog.beaverton.ibm.com> <1077836576.2857.168.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077836576.2857.168.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 03:02:56PM -0800, john stultz wrote:
> On Thu, 2004-02-26 at 13:26, john stultz wrote:
> > On Thu, 2004-02-26 at 06:40, Go Taniguchi wrote:
> > > Hi,
> > > 
> > > Andrew Morton wrote:
> > > > john stultz <johnstul@us.ibm.com> wrote:
> > > >>I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> > > >>there as well. 
> > > 
> > > Problem patch is expanded-pci-config-space.patch.
> > > x440 can not enable acpi by dmi_scan.
> > > expanded-pci-config-space.patch need acpi support.
> > > So, kernel can not get x440's xAPIC interrupt.
> > 
> > Wow, thanks for that analysis Go! I'll test it here to confirm. 
> 
> Yep, I've confirmed that backing out the expanded-pci-config-space patch
> solves it. Thanks again, Go, for hunting that down! 
> 
> Matthew, any ideas why the patch fails if the system has an ACPI
> blacklist entry?

Hrm.  I was just asked to break out some of the ACPI code rearrangement
from the rest of the patch.  Can you try this patch instead of the
expanded-pci-config-space.patch and tell me whether it continues to fail
for you?

I don't understand why it should make a difference though.  It looks
to me like the current code will also fail to call the HPET code if the
bios is blacklisted.

Index: arch/i386/kernel/acpi/boot.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/acpi/boot.c,v
retrieving revision 1.10
diff -u -p -r1.10 boot.c
--- a/arch/i386/kernel/acpi/boot.c	17 Feb 2004 12:51:46 -0000	1.10
+++ b/arch/i386/kernel/acpi/boot.c	26 Feb 2004 16:34:12 -0000
@@ -398,55 +398,10 @@ acpi_find_rsdp (void)
 	return rsdp_phys;
 }
 
-/*
- * acpi_boot_init()
- *  called from setup_arch(), always.
- *	1. maps ACPI tables for later use
- *	2. enumerates lapics
- *	3. enumerates io-apics
- *
- * side effects:
- *	acpi_lapic = 1 if LAPIC found
- *	acpi_ioapic = 1 if IOAPIC found
- *	if (acpi_lapic && acpi_ioapic) smp_found_config = 1;
- *	if acpi_blacklisted() acpi_disabled = 1;
- *	acpi_irq_model=...
- *	...
- *
- * return value: (currently ignored)
- *	0: success
- *	!0: failure
- */
 
-int __init
-acpi_boot_init (void)
+static int acpi_apic_setup(void)
 {
-	int			result = 0;
-
-	if (acpi_disabled && !acpi_ht)
-		 return 1;
-
-	/*
-	 * The default interrupt routing model is PIC (8259).  This gets
-	 * overriden if IOAPICs are enumerated (below).
-	 */
-	acpi_irq_model = ACPI_IRQ_MODEL_PIC;
-
-	/* 
-	 * Initialize the ACPI boot-time table parser.
-	 */
-	result = acpi_table_init();
-	if (result) {
-		acpi_disabled = 1;
-		return result;
-	}
-
-	result = acpi_blacklisted();
-	if (result) {
-		printk(KERN_WARNING PREFIX "BIOS listed in blacklist, disabling ACPI support\n");
-		acpi_disabled = 1;
-		return result;
-	}
+	int result;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
@@ -506,24 +461,17 @@ acpi_boot_init (void)
 
 	acpi_lapic = 1;
 
-#endif /*CONFIG_X86_LOCAL_APIC*/
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)
 
 	/* 
 	 * I/O APIC 
-	 * --------
 	 */
 
-	/*
-	 * ACPI interpreter is required to complete interrupt setup,
-	 * so if it is off, don't enumerate the io-apics with ACPI.
-	 * If MPS is present, it will handle them,
-	 * otherwise the system will stay in PIC mode
-	 */
-	if (acpi_disabled || acpi_noirq) {
+	if (acpi_noirq) {
 		return 1;
-        }
+	}
 
 	/*
  	 * if "noapic" boot option, don't look for IO-APICs
@@ -538,8 +486,7 @@ acpi_boot_init (void)
 	if (!result) {
 		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
 		return -ENODEV;
-	}
-	else if (result < 0) {
+	} else if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing IOAPIC entry\n");
 		return result;
 	}
@@ -576,9 +523,71 @@ acpi_boot_init (void)
 	}
 #endif
 
+	return 0;
+}
+
+/*
+ * acpi_boot_init()
+ *  called from setup_arch(), always.
+ *	1. maps ACPI tables for later use
+ *	2. enumerates lapics
+ *	3. enumerates io-apics
+ *
+ * side effects:
+ *	acpi_lapic = 1 if LAPIC found
+ *	acpi_ioapic = 1 if IOAPIC found
+ *	if (acpi_lapic && acpi_ioapic) smp_found_config = 1;
+ *	if acpi_blacklisted() acpi_disabled = 1;
+ *	acpi_irq_model=...
+ *	...
+ *
+ * return value: (currently ignored)
+ *	0: success
+ *	!0: failure
+ */
+
+int __init
+acpi_boot_init (void)
+{
+	int result, error;
+
+	if (acpi_disabled && !acpi_ht)
+		 return 1;
+
+	/*
+	 * The default interrupt routing model is PIC (8259).  This gets
+	 * overriden if IOAPICs are enumerated (below).
+	 */
+	acpi_irq_model = ACPI_IRQ_MODEL_PIC;
+
+	/* 
+	 * Initialize the ACPI boot-time table parser.
+	 */
+	result = acpi_table_init();
+	if (result) {
+		acpi_disabled = 1;
+		return result;
+	}
+
+	result = acpi_blacklisted();
+	if (result) {
+		printk(KERN_WARNING PREFIX "BIOS listed in blacklist, disabling ACPI support\n");
+		acpi_disabled = 1;
+		return result;
+	}
+
+	error = acpi_apic_setup();
+
 #ifdef CONFIG_HPET_TIMER
-	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
+	result = acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
+	if (result < 0) {
+		printk(KERN_ERR PREFIX "Error %d parsing HPET\n", result);
+		if (!error)
+			error = result;
+	} else if (result > 1) {
+		printk(KERN_WARNING PREFIX "Multiple HPET tables exist\n");
+	}
 #endif
 
-	return 0;
+	return error;
 }

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
