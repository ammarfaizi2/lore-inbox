Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUJSLkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUJSLkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUJSLkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 07:40:07 -0400
Received: from webapps.arcom.com ([194.200.159.168]:37388 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268185AbUJSLWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 07:22:50 -0400
Message-ID: <4174F909.1040804@arcom.com>
Date: Tue, 19 Oct 2004 12:22:49 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: greg@kroah.com
Subject: [patch] PCI: Add is_bridge to pci_dev to allow fixups to disable
 bridge functionality.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2004 11:22:59.0656 (UTC) FILETIME=[FD584480:01C4B5CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch allows device fixups to force the PCI subsystem to ignore 
bridges and hence not allocate resources to them.

I have an IXP425 (ARM) board with a CardBus controller on it (of which 
only the PC card interfaces are used).  The problem is that the PCI 
memory window is too small to fit in all the bridge resources and the 
rest of the PCI devices and up being unconfigured.  With this patch, and 
a fixup to clear is_bridge, this doesn't happen.

The plan was to make the CardBus driver (drivers/pcmcia/yenta_socket.c) 
honour the is_bridge flag and not bother with CardBus stuff if it's cleared.

2004-10-19  David Vrabel <dvrabel@arcom.com>

	* Add is_bridge to struct pci_dev to allow PCI device fixups to
	disable bridge functionality.

Index: linux-2.6-armbe/drivers/pci/probe.c
===================================================================
--- linux-2.6-armbe.orig/drivers/pci/probe.c	2004-10-14 
11:26:38.000000000 +0100
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
--- linux-2.6-armbe.orig/include/linux/pci.h	2004-10-14 
11:26:38.000000000 +0100
+++ linux-2.6-armbe/include/linux/pci.h	2004-10-14 11:43:24.000000000 +0100
@@ -532,6 +532,7 @@
  	/* These fields are used by common fixups */
  	unsigned int	transparent:1;	/* Transparent PCI bridge */
  	unsigned int	multifunction:1;/* Part of multi-function device */
+	unsigned int	is_bridge:1;	/* A PCI or CardBus bridge */
  	/* keep track of device state */
  	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
  	unsigned int	is_busmaster:1; /* device is busmaster */
