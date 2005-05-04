Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVEDHIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVEDHIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVEDHGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:06:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:3045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262051AbVEDHCY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:24 -0400
Cc: kaneshige.kenji@soft.fujitsu.com
Subject: [PATCH] PCI: 'is_enabled' flag should be set/cleared when the device is actually enabled/disabled
In-Reply-To: <20050504070107.GA17791@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:16 -0700
Message-Id: <1115190136453@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: 'is_enabled' flag should be set/cleared when the device is actually enabled/disabled

I think 'is_enabled' flag in pci_dev structure should be set/cleared
when the device actually enabled/disabled. Especially about
pci_enable_device(), it can be failed. By this change, we will also
get the possibility of refering 'is_enabled' flag from the functions
called through pci_enable_device()/pci_disable_device().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ceb43744cd48a20212e2179e0c7ff2f450a3c97e
tree f9554643bc9d70fe761840a603adce393c0e9f08
parent 8800cea62025a5209d110c5fa5990429239d6eee
author Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com> 1112939611 +0900
committer Greg KH <gregkh@suse.de> 1115189113 -0700

Index: drivers/pci/pci.c
===================================================================
--- 2aa9e4732d7014dcda4c0e80d2e377f52e2262e9/drivers/pci/pci.c  (mode:100644 sha1:bfbff83352688dc99776706033e1bb80b8282946)
+++ f9554643bc9d70fe761840a603adce393c0e9f08/drivers/pci/pci.c  (mode:100644 sha1:fc8cc6c53778b6336e26ef23b1ac3e78eb16c7a2)
@@ -398,10 +398,10 @@
 {
 	int err;
 
-	dev->is_enabled = 1;
 	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
+	dev->is_enabled = 1;
 	return 0;
 }
 
@@ -427,16 +427,15 @@
 {
 	u16 pci_command;
 	
-	dev->is_enabled = 0;
-	dev->is_busmaster = 0;
-
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+	dev->is_busmaster = 0;
 
 	pcibios_disable_device(dev);
+	dev->is_enabled = 0;
 }
 
 /**

