Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWBNGGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWBNGGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWBNGGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:06:20 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53163 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030475AbWBNGGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:06:19 -0500
Message-ID: <43F172BA.1020405@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 15:03:38 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: [RFC][PATCH 0/4] PCI legacy I/O port free driver
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

To solve this problem, this series of patches introduces a new
interface pci_set_bar_mask() and pci_set_bar_mask_by_resource() for
PCI device drivers to tell the kernel what regions they really want to
use. Once the driver call pci_set_bar_mask*(), following
pci_enable_device() and pci_request_regions() call handles only the
specific regions. If the driver doesn't use pci_set_bar_mask*(),
pci_enable_device() and pci_request_regions() handle all regions as
they currently are. By using pci_set_bar_mask*(), we can make PCI
drivers legacy I/O port free with very small change.

I'm attaching the following four patches:

    [patch 1/4] Inntroduce pci_set_bar_mask*()
    [patch 2/4] Update Documantion/pci.txt
    [patch 3/4] Make Intel e1000 driver legacy I/O port free
    [patch 4/4] Make Emulex lpfc driver legacy I/O port free

I would very much appreciate giving me any comments and suggestions.

Thanks,
Kenji Kaneshige
