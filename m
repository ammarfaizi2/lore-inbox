Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbVKIEQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbVKIEQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 23:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVKIEQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 23:16:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63167 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030475AbVKIEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 23:16:30 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Subject: [PATCH] fix for Toshiba ohci1394 quirk
Date: Tue, 8 Nov 2005 20:13:02 -0800
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OdXcDt1pYlf2Pfy"
Message-Id: <200511082013.02627.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_OdXcDt1pYlf2Pfy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

After much testing and agony, I've discovered that my previous ohci1394 
quirk for Toshiba laptops is not 100% reliable.  It apparently fails to 
do the interrupt line change either correctly or in time, since in 
about 2 out of 5 boots, the kernel's irqdebug code will *still* disable 
irq 11 when the ohci1394 driver is loaded (at pci_enable_device time I 
think).

This patch switches things around a little in the workaround.  First, it 
removes the mdelay.  I didn't see a need for it and my testing has 
shown that it's not necessary for the quirk to work.

Secondly, instead of trying to change the interrupt line to what ACPI 
tells us it should be, this patch makes the quirk use the value in the 
PCI_INTERRUPT_LINE register.  On this laptop at least, that seems to be 
the right thing to do, though additional testing on other laptops 
and/or with actual firewire devices would be appreciated.

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_OdXcDt1pYlf2Pfy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="toshiba-ohci1394-fixup-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="toshiba-ohci1394-fixup-fix.patch"

diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index 3984226..eeb1b1f 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -433,9 +433,8 @@ static void __devinit pci_post_fixup_tos
 		return; /* only applies to certain Toshibas (so far) */
 
 	/* Restore config space on Toshiba laptops */
-	mdelay(10);
 	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_line_size);
-	pci_write_config_word(dev, PCI_INTERRUPT_LINE, dev->irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, (u8 *)&dev->irq);
 	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0,
 			       pci_resource_start(dev, 0));
 	pci_write_config_dword(dev, PCI_BASE_ADDRESS_1,
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c

--Boundary-00=_OdXcDt1pYlf2Pfy--
