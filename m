Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030537AbVKWXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537AbVKWXtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKWXrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:33986 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751336AbVKWXqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:35 -0500
Date: Wed, 23 Nov 2005 15:44:59 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rajesh.shah@intel.com
Subject: [patch 11/22] PCI: remove bogus resource collision error
Message-ID: <20051123234459.GL527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-remove-bogus-resource-collision-error.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Shah <rajesh.shah@intel.com>

When attempting to hotadd a PCI card with a bridge on it, I saw
the kernel reporting resource collision errors even when there were
really no collisions. The problem is that the code doesn't skip
over "invalid" resources with their resource type flag not set.
Others have reported similar problems at boot time and for
non-bridge PCI card hotplug too, where the code flags a
resource collision for disabled ROMs. This patch fixes both
problems.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/i386/pci/i386.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- usb-2.6.orig/arch/i386/pci/i386.c
+++ usb-2.6/arch/i386/pci/i386.c
@@ -221,6 +221,11 @@ int pcibios_enable_resources(struct pci_
 			continue;
 
 		r = &dev->resource[idx];
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
 		if (!r->start && r->end) {
 			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
 			return -EINVAL;
@@ -230,8 +235,6 @@ int pcibios_enable_resources(struct pci_
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);

--
