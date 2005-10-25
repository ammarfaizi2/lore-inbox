Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVJYR2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVJYR2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVJYR2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:28:49 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:23017 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932224AbVJYR2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:28:49 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ohci1394 PCI fixup for Toshiba laptops
Date: Tue, 25 Oct 2005 10:28:42 -0700
User-Agent: KMail/1.8.91
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       rob@janerob.com, akpm@osdl.org
References: <200510241857.33257.jbarnes@virtuousgeek.org> <200510251019.16727.jbarnes@virtuousgeek.org> <20051025172254.GA20644@kroah.com>
In-Reply-To: <20051025172254.GA20644@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LtmXDDsiL0o0L+s"
Message-Id: <200510251028.43158.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LtmXDDsiL0o0L+s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, October 25, 2005 10:22 am, Greg KH wrote:
> Care to resend with the full changelog information too, so I can apply
> it?

This is a fix for a bug I see on my Toshiba laptop, where the ohci1394 
controller gets initialized improperly.  The patch adds two PCI fixups 
to arch/i386/pci/fixup.c, one that happens early on to cache the value 
of the PCI_CACHE_LINE_SIZE config register, and another that later 
restores the value, along with a valid IRQ number and some BAR values.  
I've tested it on my laptop, and it prevents me from running into what 
I consider to be a major bug: IRQ 11 is disabled by the IRQ debug code, 
causing my wireless to break.

Thanks to Rob for the original patch to ohci1394.c and Stefan for lots 
of proofreading (and a last minute bug caught in review!) and additional 
information collection.  I think the DMI system list is correct, but we 
may need to add some more PCI IDs to the PCI_FIXUP macros over time.

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_LtmXDDsiL0o0L+s
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="toshiba-ohci1394-fixup-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="toshiba-ohci1394-fixup-2.patch"

diff -Naur -X linux-2.6.14-rc5/Documentation/dontdiff linux-2.6.14-rc5.orig/arch/i386/pci/fixup.c linux-2.6.14-rc5/arch/i386/pci/fixup.c
--- linux-2.6.14-rc5.orig/arch/i386/pci/fixup.c	2005-10-19 23:23:05.000000000 -0700
+++ linux-2.6.14-rc5/arch/i386/pci/fixup.c	2005-10-24 18:40:15.000000000 -0700
@@ -2,6 +2,8 @@
  * Exceptions for specific devices. Usually work-arounds for fatal design flaws.
  */
 
+#include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include "pci.h"
@@ -384,3 +386,60 @@
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
+
+/*
+ * Some Toshiba laptops need extra code to enable their TI TSB43AB22/A.
+ *
+ * We pretend to bring them out of full D3 state, and restore the proper
+ * IRQ, PCI cache line size, and BARs, otherwise the device won't function
+ * properly.  In some cases, the device will generate an interrupt on
+ * the wrong IRQ line, causing any devices sharing the the line it's
+ * *supposed* to use to be disabled by the kernel's IRQ debug code.
+ */
+static u16 toshiba_line_size;
+
+static struct dmi_system_id __devinit toshiba_ohci1394_dmi_table[] = {
+	{
+		.ident = "Toshiba PS5 based laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "PS5"),
+		},
+	},
+	{
+		.ident = "Toshiba PSM4 based laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "PSM4"),
+		},
+	},
+	{ }
+};
+
+static void __devinit pci_pre_fixup_toshiba_ohci1394(struct pci_dev *dev)
+{
+	if (!dmi_check_system(toshiba_ohci1394_dmi_table))
+		return; /* only applies to certain Toshibas (so far) */
+
+	dev->current_state = PCI_D3cold;
+	pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_line_size);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0x8032,
+			 pci_pre_fixup_toshiba_ohci1394);
+
+static void __devinit pci_post_fixup_toshiba_ohci1394(struct pci_dev *dev)
+{
+	if (!dmi_check_system(toshiba_ohci1394_dmi_table))
+		return; /* only applies to certain Toshibas (so far) */
+
+	/* Restore config space on Toshiba laptops */
+	mdelay(10);
+	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_line_size);
+	pci_write_config_word(dev, PCI_INTERRUPT_LINE, dev->irq);
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0,
+			       pci_resource_start(dev, 0));
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_1,
+			       pci_resource_start(dev, 1));
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_TI, 0x8032,
+			 pci_post_fixup_toshiba_ohci1394);

--Boundary-00=_LtmXDDsiL0o0L+s--
