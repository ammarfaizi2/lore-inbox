Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270574AbUJUD3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270574AbUJUD3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270565AbUJUD3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:29:39 -0400
Received: from fmr06.intel.com ([134.134.136.7]:40084 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270513AbUJUDVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:21:16 -0400
Subject: [PATCH 1/5]Avoid ACPI assign legacy devices' IRQ for PCI devices
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-RYX4IQ3rVIDiea3EYFU3"
Message-Id: <1098327558.6132.220.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:59:22 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RYX4IQ3rVIDiea3EYFU3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
The patch introduces acpi_penalize_isa_irq, its goal is to avoid PCI
devices use IRQ of legacy PNP devices.

Thanks,
Shaohua


Signed-off-by: Li Shaohua <shaohua.li@intel.com>

===== include/linux/acpi.h 1.36 vs edited =====
--- 1.36/include/linux/acpi.h	2004-06-02 23:02:20 +08:00
+++ edited/include/linux/acpi.h	2004-09-22 10:09:23 +08:00
@@ -439,6 +439,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_penalize_isa_irq(int irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
===== drivers/acpi/pci_link.c 1.31 vs edited =====
--- 1.31/drivers/acpi/pci_link.c	2004-08-05 03:55:16 +08:00
+++ edited/drivers/acpi/pci_link.c	2004-09-22 10:08:09 +08:00
@@ -786,6 +786,11 @@ static int __init acpi_irq_penalty_updat
 	return 1;
 }
 
+void acpi_penalize_isa_irq(int irq)
+{
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
===== arch/i386/pci/irq.c 1.47 vs edited =====
--- 1.47/arch/i386/pci/irq.c	2004-08-02 16:00:43 +08:00
+++ edited/arch/i386/pci/irq.c	2004-09-22 10:27:30 +08:00
@@ -17,6 +17,7 @@
 #include <asm/smp.h>
 #include <asm/io_apic.h>
 #include <asm/hw_irq.h>
+#include <linux/acpi.h>
 
 #include "pci.h"
 
@@ -989,13 +990,24 @@ static int __init pcibios_irq_init(void)
 subsys_initcall(pcibios_irq_init);
 
 
-void pcibios_penalize_isa_irq(int irq)
+static void pirq_penalize_isa_irq(int irq)
 {
 	/*
 	 *  If any ISAPnP device reports an IRQ in its list of possible
 	 *  IRQ's, we try to avoid assigning it to PCI devices.
 	 */
-	pirq_penalty[irq] += 100;
+	if (irq < 16)
+		pirq_penalty[irq] += 100;
+}
+
+void pcibios_penalize_isa_irq(int irq)
+{
+#ifdef CONFIG_ACPI_PCI
+	if (!acpi_noirq)
+		acpi_penalize_isa_irq(irq);
+	else
+#endif
+		pirq_penalize_isa_irq(irq);
 }
 
 int pirq_enable_irq(struct pci_dev *dev)
===== drivers/pnp/pnpbios/rsparser.c 1.4 vs edited =====
--- 1.4/drivers/pnp/pnpbios/rsparser.c	2004-09-14 08:23:17 +08:00
+++ edited/drivers/pnp/pnpbios/rsparser.c	2004-09-22 10:31:09 +08:00
@@ -7,6 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+#include <linux/pci.h>
 
 #include "pnpbios.h"
 
@@ -58,6 +59,7 @@ pnpbios_parse_allocated_irqresource(stru
 		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
+		pcibios_penalize_isa_irq(irq);
 	}
 }
 


--=-RYX4IQ3rVIDiea3EYFU3
Content-Disposition: attachment; filename=irq-isa.patch
Content-Type: text/x-patch; name=irq-isa.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== include/linux/acpi.h 1.36 vs edited =====
--- 1.36/include/linux/acpi.h	2004-06-02 23:02:20 +08:00
+++ edited/include/linux/acpi.h	2004-09-22 10:09:23 +08:00
@@ -439,6 +439,7 @@ extern struct acpi_prt_list	acpi_prt;
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
+void acpi_penalize_isa_irq(int irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
===== drivers/acpi/pci_link.c 1.31 vs edited =====
--- 1.31/drivers/acpi/pci_link.c	2004-08-05 03:55:16 +08:00
+++ edited/drivers/acpi/pci_link.c	2004-09-22 10:08:09 +08:00
@@ -786,6 +786,11 @@ static int __init acpi_irq_penalty_updat
 	return 1;
 }
 
+void acpi_penalize_isa_irq(int irq)
+{
+	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+}
+
 /*
  * Over-ride default table to reserve additional IRQs for use by ISA
  * e.g. acpi_irq_isa=5
===== arch/i386/pci/irq.c 1.47 vs edited =====
--- 1.47/arch/i386/pci/irq.c	2004-08-02 16:00:43 +08:00
+++ edited/arch/i386/pci/irq.c	2004-09-22 10:27:30 +08:00
@@ -17,6 +17,7 @@
 #include <asm/smp.h>
 #include <asm/io_apic.h>
 #include <asm/hw_irq.h>
+#include <linux/acpi.h>
 
 #include "pci.h"
 
@@ -989,13 +990,24 @@ static int __init pcibios_irq_init(void)
 subsys_initcall(pcibios_irq_init);
 
 
-void pcibios_penalize_isa_irq(int irq)
+static void pirq_penalize_isa_irq(int irq)
 {
 	/*
 	 *  If any ISAPnP device reports an IRQ in its list of possible
 	 *  IRQ's, we try to avoid assigning it to PCI devices.
 	 */
-	pirq_penalty[irq] += 100;
+	if (irq < 16)
+		pirq_penalty[irq] += 100;
+}
+
+void pcibios_penalize_isa_irq(int irq)
+{
+#ifdef CONFIG_ACPI_PCI
+	if (!acpi_noirq)
+		acpi_penalize_isa_irq(irq);
+	else
+#endif
+		pirq_penalize_isa_irq(irq);
 }
 
 int pirq_enable_irq(struct pci_dev *dev)
===== drivers/pnp/pnpbios/rsparser.c 1.4 vs edited =====
--- 1.4/drivers/pnp/pnpbios/rsparser.c	2004-09-14 08:23:17 +08:00
+++ edited/drivers/pnp/pnpbios/rsparser.c	2004-09-22 10:31:09 +08:00
@@ -7,6 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/pnp.h>
 #include <linux/pnpbios.h>
+#include <linux/pci.h>
 
 #include "pnpbios.h"
 
@@ -58,6 +59,7 @@ pnpbios_parse_allocated_irqresource(stru
 		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
+		pcibios_penalize_isa_irq(irq);
 	}
 }
 

--=-RYX4IQ3rVIDiea3EYFU3--

