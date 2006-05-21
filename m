Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWEUMbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWEUMbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEUMbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:31:53 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:56743 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751541AbWEUMbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:31:53 -0400
Message-ID: <44705DA4.2020807@myri.com>
Date: Sun, 21 May 2006 14:31:32 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il>
In-Reply-To: <20060521121726.GQ30211@mellanox.co.il>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------050307000203030109040209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307000203030109040209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> MSI is an optional feature so things are supposed to work even without MSI - are
> you getting that great a benefit from MSI?
>   

Not great, I would say small.

> All mellanox PCI-X devices have a bridge inside them, so ...
>   

Ok so you really need something for 2.6.17. What about the attached
patch to fix the fact that bus flags are not inherited ?

Signed-off-by: Brice Goglin <brice@myri.com>

> Doesn't seem to work for me:
>
> ib_mthca: Initializing 0000:04:00.0
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 29 (level, low) -> IRQ 185
> ib_mthca 0000:04:00.0: NOP command failed to generate interrupt (IRQ 217),
> aborting.
> ib_mthca 0000:04:00.0: Try again with MSI/MSI-X disabled.
> ACPI: PCI interrupt for device 0000:04:00.0 disabled
> ib_mthca: probe of 0000:04:00.0 failed with error -16
>   

Ok. Do you at least see the quirk message ?

Thanks,
Brice


--------------050307000203030109040209
Content-Type: text/x-patch;
 name="look_at_parent_busses_flags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="look_at_parent_busses_flags.patch"

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-05-21 14:25:53.000000000 +0200
+++ linux-mm/drivers/pci/msi.c	2006-05-21 14:26:56.000000000 +0200
@@ -916,6 +916,7 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
+	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
 	u16 control;
 
@@ -925,8 +926,9 @@
 	if (dev->no_msi)
 		return status;
 
-	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-		return -EINVAL;
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
 
 	temp = dev->irq;
 

--------------050307000203030109040209--
