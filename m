Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWBNBNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWBNBNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWBNBNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:13:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27779
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030328AbWBNBNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:13:23 -0500
Date: Mon, 13 Feb 2006 17:13:21 -0800 (PST)
Message-Id: <20060213.171321.126221906.davem@davemloft.net>
To: gregkh@suse.de
CC: linux-kernel@vger.kernel.org
Subject: PCI probe leaves master abort disabled in PCI_BRIDGE_CONTROL
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In drivers/pci/probe.c:pci_scan_bridge(), if this is not the first
pass (pass != 0) we don't restore the PCI_BRIDGE_CONTROL_REGISTER and
thus leave PCI_BRIDGE_CTL_MASTER_ABORT off:

int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
{
 ...
	/* Disable MasterAbortMode during probing to avoid reporting
	   of bus errors (in some architectures) */ 
	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 ...
	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
		unsigned int cmax, busnr;
		/*
		 * Bus already configured by firmware, process it in the first
		 * pass and just note the configuration.
		 */
		if (pass)
			return max;
 ...
	}

	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 ...

This doesn't seem intentional.
