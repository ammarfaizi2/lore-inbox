Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264872AbUFHIEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264872AbUFHIEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbUFHIEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:04:44 -0400
Received: from mail.donpac.ru ([80.254.111.2]:34732 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264872AbUFHIEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:04:24 -0400
Date: Tue, 8 Jun 2004 12:04:17 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040608080417.GD19170@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <20040607124125.GT3776@pazke> <20040607220157.1e67ec39.akpm@osdl.org> <20040608051808.GA19170@pazke> <20040607222513.6bebcbb6.akpm@osdl.org> <20040608063417.GB19170@pazke> <20040607234235.1728f826.akpm@osdl.org> <20040608071828.GC19170@pazke> <20040608002245.04a3de55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <20040608002245.04a3de55.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 160, 06 08, 2004 at 12:22:45AM -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> > 
> >  Do you remember the reason of dropping my previous DMI patchset ? ;) 
> > 
> >  I can do it again, but this conversion will lead to new reject
> >  horrors, due to changes in cursed dmi_blacklist array.
> 
> Not the whole thing.  Just a couple of examples.

Ok, first example attached. Port HP Pavilion irq workaround
to new DMI probing.

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dmi-pciirq

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm2.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc2-mm2/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc2-mm2.vanilla/arch/i386/kernel/dmi_scan.c	2004-06-08 11:51:39.000000000 +0400
+++ linux-2.6.7-rc2-mm2/arch/i386/kernel/dmi_scan.c	2004-06-08 11:29:08.000000000 +0400
@@ -317,23 +317,6 @@ static __init int disable_smbus(struct d
 }
 
 /*
- * Work around broken HP Pavilion Notebooks which assign USB to
- * IRQ 9 even though it is actually wired to IRQ 11
- */
-static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_PCI
-	extern int broken_hp_bios_irq9;
-	if (broken_hp_bios_irq9 == 0)
-	{
-		broken_hp_bios_irq9 = 1;
-		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
  *
@@ -823,14 +806,6 @@ static __initdata struct dmi_blacklist d
 			NO_MATCH, NO_MATCH
 			} },
 	 
-	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
-			MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
-			MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
-			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
-			} },
- 
-
 	/*
 	 *	Generic per vendor APM settings
 	 */
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm2.vanilla/arch/i386/pci/irq.c linux-2.6.7-rc2-mm2/arch/i386/pci/irq.c
--- linux-2.6.7-rc2-mm2.vanilla/arch/i386/pci/irq.c	2004-06-08 10:13:51.000000000 +0400
+++ linux-2.6.7-rc2-mm2/arch/i386/pci/irq.c	2004-06-08 11:28:37.000000000 +0400
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -22,7 +23,7 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
-int broken_hp_bios_irq9;
+static int broken_hp_bios_irq9;
 
 static struct irq_routing_table *pirq_table;
 
@@ -893,6 +894,33 @@ static void __init pcibios_fixup_irqs(vo
 	}
 }
 
+/*
+ * Work around broken HP Pavilion Notebooks which assign USB to
+ * IRQ 9 even though it is actually wired to IRQ 11
+ */
+static int __init fix_broken_hp_bios_irq9(struct dmi_system_id *d)
+{
+	if (!broken_hp_bios_irq9) {
+		broken_hp_bios_irq9 = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
+
+static struct dmi_system_id __initdata pciirq_dmi_table[] = {
+	{
+		.callback = fix_broken_hp_bios_irq9,
+		.ident = "HP Pavilion N5400 Series Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
+			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
+		},
+	},
+	{ }
+};
+
 static int __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
@@ -900,6 +928,8 @@ static int __init pcibios_irq_init(void)
 	if (pcibios_enable_irq || raw_pci_ops == NULL)
 		return 0;
 
+	dmi_check_system(pciirq_dmi_table);
+
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm2.vanilla/arch/i386/pci/visws.c linux-2.6.7-rc2-mm2/arch/i386/pci/visws.c
--- linux-2.6.7-rc2-mm2.vanilla/arch/i386/pci/visws.c	2004-06-08 10:13:51.000000000 +0400
+++ linux-2.6.7-rc2-mm2/arch/i386/pci/visws.c	2004-06-08 11:29:32.000000000 +0400
@@ -15,8 +15,6 @@
 #include "pci.h"
 
 
-int broken_hp_bios_irq9;
-
 extern struct pci_raw_ops pci_direct_conf1;
 
 static int pci_visws_enable_irq(struct pci_dev *dev) { return 0; }

--EXKGNeO8l0xGFBjy--
