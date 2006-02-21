Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161400AbWBUG3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161400AbWBUG3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbWBUG3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:29:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:33505 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161400AbWBUG3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:29:03 -0500
Message-ID: <43FAB283.8090206@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:26:11 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: ak@suse.de, rmk+lkml@arm.linux.org.uk,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/6] PCI legacy I/O port free driver (take2)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated set of patches for PCI legacy I/O port free drivers
which incorporates feedbacks. Summary of changes from the previous
version are:

   - Added the no_ioport field into struct pci_dev.
   - Added the device_flags field into struct pci_device_id, which is
     used to pass the flags to the kernel through ID table.
   - Removed pci_set_bar_mask() which was introduced in the previous
     version of patch.
   - Removed the bar_mask field from struct pci_dev which was
     introduced in the previous version of patch.
   - Updated the document.
   - Updated the patch for e1000 and lpfc in order to follow the
     above-mentioned change.

I'm attaching the following six patches:

    [patch 1/6] Add no_ioport flag into pci_dev
    [patch 2/6] Fix minor bug in store_new_id()
    [patch 3/6] Add device_flags into pci_device_id
    [patch 4/6] Update Documentation/pci.txt
    [patch 5/6] Make Intel e1000 driver legacy I/O port free
    [patch 6/6] Make Emulex lpfc driver legacy I/O port free

I'm attaching the brief description below about what the problem I'm
trying to solve is.

Thanks,
Kenji Kaneshige


Brief description of the problem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I encountered a problem that some PCI devices don't work on my system
which have huge number of PCI devices.

It is mandatory for all PCI device drivers to enable the device by
calling pci_enable_device() which enables all regions probed from the
device's BARs. If pci_enable_device() failes to enable any regions
probed from BARs, it returns as error. On the large servers, I/O port
resource could not be assigned to all PCI devices because it is
limited (64KB on Intel Architecture[1]) and it would be fragmented
(I/O base register of PCI-to-PCI bridge will usually be aligned to a
4KB boundary[2]). In this case, the devices which have no I/O port
resource assigned don't work because pci_enable_device() for those
devices failes. This is what happened on my machine.
---
[1]: Some machines support 64KB I/O port space per PCI segment.
[2]: Some P2P bridges support optional 1KB aligned I/O base.

Here, there are many PCI devices that provide both I/O port and MMIO
interface, and some of those devices can be handled without using I/O
port interface. The reason why such devices provide I/O port interface
is for compatibility to legacy OSs. So this kind of devices should
work even if enough I/O port resources are not assigned. The "PCI
Local Bus Specification Revision 3.0" also mentions about this topic
(Please see p.44, "IMPLEMENTATION NOTE"). On the current linux,
unfortunately, this kind of devices don't work if I/O port resources
are not assigned, because pci_enable_device() for those devices fails.


