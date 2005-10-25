Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVJYRTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVJYRTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVJYRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:19:24 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:46039 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932215AbVJYRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:19:24 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] ohci1394 PCI fixup for Toshiba laptops
Date: Tue, 25 Oct 2005 10:19:16 -0700
User-Agent: KMail/1.8.91
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, rob@janerob.com, akpm@osdl.org
References: <200510241857.33257.jbarnes@virtuousgeek.org> <435DD86F.3090702@s5r6.in-berlin.de>
In-Reply-To: <435DD86F.3090702@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UkmXDQ5c+h3JGPA"
Message-Id: <200510251019.16727.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_UkmXDQ5c+h3JGPA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, October 25, 2005 12:02 am, Stefan Richter wrote:
> Jesse Barnes wrote:
> > +static void __devinit pci_post_fixup_toshiba_ohci1394(struct
> > pci_dev *dev) +{
> > +	if (dmi_check_system(toshiba_ohci1394_dmi_table))
> > +		return; /* only applies to certain Toshibas (so far) */
> > +
> > +	/* Restore config space on Toshiba laptops */
> > +	mdelay(10);
> > +	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
> > toshiba_line_size);
>
> Shouldn't this read
>
>          if (!dmi_check_system(toshiba_ohci1394_dmi_table))
>                  return;
>              ^ ?
>
> dmi_check_system returns the number of matches.

Doh!  Yes, it should be (I tested an earlier version, then decided to 
reverse the logic and return, oops).

Here's an updated version.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>


--Boundary-00=_UkmXDQ5c+h3JGPA
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

--Boundary-00=_UkmXDQ5c+h3JGPA--
