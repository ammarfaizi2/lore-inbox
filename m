Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWCXFd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWCXFd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWCXFd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:33:26 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:27591 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1423148AbWCXFdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:33:25 -0500
Message-ID: <442382F1.2050300@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 14:26:09 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.16-mm1 0/4] PCI legacy I/O port free driver (take 6)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I've updated the series of patches for PCI legacy I/O port free driver
to be applied to 2.6.16-mm1. The previous version of patches conflicts
with some changes to e1000 driver. I also confirmed the updated one
can be applied to 2.6.16-git7 though I got some warnings.

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
