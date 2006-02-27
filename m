Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWB0E4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWB0E4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWB0E4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:56:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6331 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750884AbWB0E4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:56:05 -0500
Message-ID: <44028502.4000108@soft.fujitsu.com>
Date: Mon, 27 Feb 2006 13:50:10 +0900
From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated set of patches for PCI legacy I/O port free drivers
which incorporates feedbacks. Summary of changes from the previous
version are:

    - Removed the device_flags field from struct pci_device_id, which
      was introduced in the previous version of patch

    - Changed e1000 driver to use the driver_data field in struct
      pci_device_id to see if the device needs I/O port regions.

    - Added proper messages instead of WARN_ON() at the error.

    - Updated the Documentation/pci.txt

I'm attaching the following four patches:

    [patch 1/4] Add no_ioport flag into pci_dev
    [patch 2/4] Update Documentation/pci.txt
    [patch 3/4] Make Intel e1000 driver legacy I/O port free
    [patch 4/4] Make Emulex lpfc driver legacy I/O port free

I'm attaching the brief description below about what the problem I'm
trying to solve is.

Thanks,
Kenji Kaneshige


Brief Description
~~~~~~~~~~~~~~~~~
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


