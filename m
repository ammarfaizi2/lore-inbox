Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbVLODlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVLODlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbVLODlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:41:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:21418 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161009AbVLODlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:41:51 -0500
Subject: MSI and driver APIs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 14:38:12 +1100
Message-Id: <1134617893.16880.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at MSI/MSI-X support on POWER platforms, both under
hypervisor or directly on machines like the new G5s and I found out that
the current code in drivers/pci isn't nearly as generic as it claims to
be and cannot really be re-used as is.

So I want to start looking into separate implementation for powerpc, and
based on what I come up with, find the commonalities and split the
generic code. However, there is at least one assumption that annoys me:

Currently, we assume that MSIs are disabled upon discovery of a device.
That is, a driver probe() routine is called with MSIs off.

This is annoying on platforms with "intelligent" firmwares like POWER
with hypervisor, as the firmware will have already configured MSIs for
the full system & assigned them to devices.

The current scenario basically means that I have to walk through all
devices, disable MSI if it was enabled by the firmware, and re-assign
MSIs later on upon driver request. In addition to that, the firmware
goes at lenght to guarantee that at least one MSI can be allocated per
device. If the OS releases those MSIs by disabling them, however, they
are returned to a global pool. When we later on request MSIs again from
that pool, there is no guarantee we don't run out and thus no guarantee
we succeed in allocating those MSIs.

Thus I would very much like to change the semantics so that a driver can
be entered with MSIs already assigned and enabled, though it has the
capability to request more MSIs and/or to disable them if the chipset is
buggy. That could be done either by adding a callback to check if MSIs
are enabled for a given device for example...

Another solution would be for me to implement a "trick" at the
architecture level. Since MSIs assigned to a device will have different
interrupt numbers than it's legacy PCI interrupt, I could leave the MSIs
enabled at probe() time, and only disable them once the driver does a
request_irq() on the legacy interrupt (since MSI and old style
interrupts are exclusive on a given device).

Of course, a subsequent pci_enable_msi/x() would re-enable/re-allocate
them, but I don't expect drivers to do that _and_ request the legacy
interrupt...

Or maybe somebody has better ideas ?

Regards,
Ben.


