Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUA3Bgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUA3Bgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:13276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266518AbUA3BcH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:07 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <1075426309208@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:50 -0800
Message-Id: <10754263101304@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1519, 2004/01/29 15:38:38-08:00, ralf@linux-mips.org

[PATCH] PCI: fix probing for some mips systems


 drivers/pci/probe.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jan 29 17:24:05 2004
+++ b/drivers/pci/probe.c	Thu Jan 29 17:24:05 2004
@@ -337,12 +337,19 @@
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses;
+	u16 bctl;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
 	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n",
 	    pci_name(dev), buses & 0xffffff, pass);
 
+	/* Disable MasterAbortMode during probing to avoid reporting
+	   of bus errors (in some architectures) */ 
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
+			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
+
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
 		unsigned int cmax, busnr;
 		/*
@@ -405,6 +412,8 @@
 		child->subordinate = max;
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
+
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
 	sprintf(child->name, (is_cardbus ? "PCI CardBus #%02x" : "PCI Bus #%02x"), child->number);
 

