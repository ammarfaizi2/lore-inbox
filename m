Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVAJRsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVAJRsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAJRqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:46:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27537 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262353AbVAJRVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:04 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <1105377657239@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <11053776574174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.8, 2004/12/17 13:44:31-08:00, macro@mips.com

[PATCH] PCI: Don't touch BARs of host bridges

 BARs of host bridges often have special meaning and AFAIK are best left
to be setup by the firmware or system-specific startup code and kept
intact by the generic resource handler.  For example a couple of host
bridges used for MIPS processors interpret BARs as target-mode decoders
for accessing host memory by PCI masters (which is quite reasonable).
For them it's desirable to keep their decoded address range overlapping
with the host RAM for simplicity if nothing else (I can imagine running
out of address space with lots of memory and 32-bit PCI with no DAC
support in the participating devices).

 This is already the case with the i386 and ppc platform-specific PCI
resource allocators.  Please consider the following change for the generic
allocator.  Currently we have a pile of hacks implemented for host bridges
to be left untouched and I'd be pleased to remove them.

From: "Maciej W. Rozycki" <macro@mips.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/setup-bus.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	2005-01-10 09:02:52 -08:00
+++ b/drivers/pci/setup-bus.c	2005-01-10 09:02:52 -08:00
@@ -57,8 +57,13 @@
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
-		if (class == PCI_CLASS_DISPLAY_VGA
-				|| class == PCI_CLASS_NOT_DEFINED_VGA)
+		/* Don't touch classless devices and host bridges.  */
+		if (class == PCI_CLASS_NOT_DEFINED ||
+		    class == PCI_CLASS_BRIDGE_HOST)
+			continue;
+
+		if (class == PCI_CLASS_DISPLAY_VGA ||
+		    class == PCI_CLASS_NOT_DEFINED_VGA)
 			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 
 		pdev_sort_resources(dev, &head);

