Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTIISa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTIISa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:30:27 -0400
Received: from fmr06.intel.com ([134.134.136.7]:56288 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264285AbTIISa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:30:26 -0400
Date: Tue, 9 Sep 2003 08:39:37 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200309091539.h89FdbfK023026@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org
Subject: MSI fix for buggy PCI/PCI-X hardware
Cc: greg@kroah.com, jgarzik@pobox.com, jun.nakajima@intel.com,
       tom.l.nguyen@intel.com, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest patches that enable MSI in the Linux kernel were 
sent out a few weeks ago on lkml.  These patches will enable 
MSI support if users rebuild the kernel with CONFIG_PCI_MSI 
set to 'Y'. Option one (default option) enables MSI on 
specific individual PCI/PCI-X MSI-capable devices listed in 
the boot parameter "device_msi=". Users may choose option 
two, which enables MSI on all PCI/PCI-X MSI-capable devices, 
by setting CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES to 'N'. 
Depending on if either option one or option two is selected, 
the kernel detects and enables MSI on requested PCI/PCI-X 
MSI-capable devices. 
 
During testing we have found many currently shipping 
PCI/PCI-X MSI-capable devices have silicon bugs specific to 
MSI support. Most of these will cause system failures when 
MSI is enabled. To filter out MSI buggy hardware requires the 
kernel to detect and disable the MSI support on specific hardware. 
 
The proposed solution is to provide a new API, named "int 
disable_msi(struct pci_dev *dev)", to allow IHV's who have 
shipped PCI/PCI-X hardware that does not work in MSI mode to update 
their software drivers to request the kernel to switch the 
interrupt mode from MSI mode back to IRQ pin-assertion mode. 
There are some reasons to justify this as below:

1) According to the PCI spec 3.0 or latest, the software 
driver is prohibited from directly interfacing with its 
device to switch MSI mode to IRQ pin-assertion mode. 
Consequently, a kernel interface is required since the kernel 
is the only entity permitted to change modes.
 
2) All PCI-Express endpoints require MSI support. These 
endpoints should have MSI enabled automatically by default. 
For PCI/PCI-X hardware that can't use MSI due to hardware bugs,
it is the IHVs' responsibility to update their software drivers to 
request the kernel to disable MSI so the HW can function with MSI 
enabled for all other devices.
 
3) Some PCI/PCI-X MSI-capable hardware devices out there work with 
this patch without requiring any changes to their existing software 
drivers.

I'd appreciate any feedback you have on this proposed solution. 

Thanks,
Long 
