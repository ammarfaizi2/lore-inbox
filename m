Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbUK0BEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUK0BEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUKZXy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:54:58 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263116AbUKZTpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:45:12 -0500
Subject: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
From: Len Brown <len.brown@intel.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <41A4CF1C.6090503@aknet.ru>
References: <41990138.7080008@aknet.ru> <1101190148.19999.394.camel@d845pe>
	 <41A4CF1C.6090503@aknet.ru>
Content-Type: multipart/mixed; boundary="=-OU5Ryky+TwpiPsLFjJkv"
Organization: 
Message-Id: <1101336267.20008.5326.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Nov 2004 17:44:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OU5Ryky+TwpiPsLFjJkv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-11-24 at 13:12, Stas Sergeev wrote:
> Hello.
> 
> Len Brown wrote:

> > Did 2.6.9 work correctly?
> Yes!

> > Any difference with CONFIG_PNP=n?
> Yes. The difference is that the problem
> disappears.

CONFIG_PNP_ACPI=n should workaround it too then, I expect.

Please apply this debug patch to the failing kernel
and send along the dmesg.  It will tell us how we
messed up the irq penalties and improperly chose
IRQ15 for a PCI device on this system.

thanks,
-Len


--=-OU5Ryky+TwpiPsLFjJkv
Content-Disposition: attachment; filename=link.patch
Content-Type: text/plain; name=link.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/pci_link.c 1.36 vs edited =====
--- 1.36/drivers/acpi/pci_link.c	2004-11-23 00:02:39 -05:00
+++ edited/drivers/acpi/pci_link.c	2004-11-24 17:41:15 -05:00
@@ -468,6 +468,17 @@
 			/* >IRQ15 */
 };
 
+void
+acpi_irq_penalty_dump(char *string)
+{
+	int i;
+
+	printk("ACPI %s: ", string);
+	for (i = 0; i < ACPI_MAX_ISA_IRQ; ++i) {
+		printk("%X ", acpi_irq_penalty[i]);
+	}
+	printk("\n");
+}
 int __init
 acpi_irq_penalty_init(void)
 {
@@ -476,6 +487,7 @@
 	int			i = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_irq_penalty_init");
+	acpi_irq_penalty_dump("enter init");
 
 	/*
 	 * Update penalties to facilitate IRQ balancing.
@@ -507,6 +519,7 @@
 	/* Add a penalty for the SCI */
 	acpi_irq_penalty[acpi_fadt.sci_int] += PIRQ_PENALTY_PCI_USING;
 
+	acpi_irq_penalty_dump("exit init");
 	return_VALUE(0);
 }
 
@@ -547,6 +560,7 @@
 		irq = link->irq.possible[link->irq.possible_count - 1];
 	}
 
+acpi_irq_penalty_dump("allocate");
 	if (acpi_irq_balance || !link->irq.active) {
 		/*
 		 * Select the best IRQ.  This is done in reverse to promote
@@ -570,6 +584,7 @@
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
+acpi_irq_penalty_dump("allocated");
 	}
 
 	link->irq.initialized = 1;
@@ -789,6 +804,7 @@
 void acpi_penalize_isa_irq(int irq)
 {
 	acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
+acpi_irq_penalty_dump("isa");
 }
 
 /*

--=-OU5Ryky+TwpiPsLFjJkv--

