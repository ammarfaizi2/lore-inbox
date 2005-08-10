Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVHJTSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVHJTSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVHJTSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:18:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46551 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030211AbVHJTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:18:49 -0400
Date: Wed, 10 Aug 2005 15:18:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix regression in pci_enable_device_bars
Message-ID: <Pine.LNX.4.44L0.0508101516220.4485-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch (as552) fixes yet another small problem recently added.  If an 
attempt to put a PCI device back into D0 fails because the device doesn't 
support PCI PM, it shouldn't count as error.  Without this patch the UHCI 
controllers on my Intel motherboard don't work.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: usb-2.6/drivers/pci/pci.c
===================================================================
--- usb-2.6.orig/drivers/pci/pci.c
+++ usb-2.6/drivers/pci/pci.c
@@ -441,7 +441,7 @@ pci_enable_device_bars(struct pci_dev *d
 	int err;
 
 	err = pci_set_power_state(dev, PCI_D0);
-	if (err)
+	if (err < 0 && err != -EIO)
 		return err;
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)

