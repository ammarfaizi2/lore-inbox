Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbUKAK7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUKAK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 05:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKAK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 05:59:24 -0500
Received: from webapps.arcom.com ([194.200.159.168]:6668 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261753AbUKAK7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 05:59:14 -0500
Message-ID: <41861701.3020008@arcom.com>
Date: Mon, 01 Nov 2004 10:59:13 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI: Add is_bridge to pci_dev to allow fixups to disable
 bridge functionality.
References: <4174F909.1040804@arcom.com> <20041030032357.GA1441@kroah.com>
In-Reply-To: <20041030032357.GA1441@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------050305010301080306040407"
X-OriginalArrivalTime: 01 Nov 2004 10:59:53.0953 (UTC) FILETIME=[EAC58510:01C4C001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305010301080306040407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Tue, Oct 19, 2004 at 12:22:49PM +0100, David Vrabel wrote:
> 
>>The plan was to make the CardBus driver (drivers/pcmcia/yenta_socket.c) 
>>honour the is_bridge flag and not bother with CardBus stuff if it's cleared.
> 
> But why can't any code that wants to check this, just look at the
> dev->hdr_type instead?  I don't think we need to add a new bit for this
> because of that, right?

Using the is_bridge flag allows PCI device fixups to disable the CardBus 
portion of the driver.  And you obviously can't tweak the hdr_type since 
the device header is still a CardBus/bridge type header.

e.g., I have:

static void __devinit pci_fixup_mercury_pci1520(struct pci_dev *dev)
{
         if (!machine_is_arcom_mercury())
                 return;

         dev->is_bridge = 0;
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520, 
pci_fixup_mercury_pci1520);

> Also, your patch was linewrapped :(

Hmm.  Looks fine here.  I've attached it instead this time.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------050305010301080306040407
Content-Type: text/plain;
 name="pci-allow-is_bridge-fixup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-allow-is_bridge-fixup"

Index: linux-2.6-armbe/drivers/pci/probe.c
===================================================================
--- linux-2.6-armbe.orig/drivers/pci/probe.c	2004-10-14 11:26:38.000000000 +0100
+++ linux-2.6-armbe/drivers/pci/probe.c	2004-10-19 12:00:00.000000000 +0100
@@ -610,6 +610,8 @@
 	dev->devfn = devfn;
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
+	dev->is_bridge = (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE
+			  || dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 	dev->cfg_size = pci_cfg_space_size(dev);
@@ -718,8 +720,7 @@
 	pcibios_fixup_bus(bus);
 	for (pass=0; pass < 2; pass++)
 		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			if  (dev->is_bridge)
 				max = pci_scan_bridge(bus, dev, max, pass);
 		}
 
Index: linux-2.6-armbe/include/linux/pci.h
===================================================================
--- linux-2.6-armbe.orig/include/linux/pci.h	2004-10-14 11:26:38.000000000 +0100
+++ linux-2.6-armbe/include/linux/pci.h	2004-10-14 11:43:24.000000000 +0100
@@ -532,6 +532,7 @@
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
+	unsigned int	is_bridge:1;	/* A PCI or CardBus bridge */
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */

--------------050305010301080306040407--
