Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVKQRvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVKQRvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVKQRvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:51:52 -0500
Received: from fmr24.intel.com ([143.183.121.16]:55210 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932443AbVKQRvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:51:51 -0500
Date: Thu, 17 Nov 2005 09:51:28 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>, akpm@osdl.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: PCI: remove bogus resource collision error
Message-ID: <20051117095128.A21488@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051116170622.A10589@unix-os.sc.intel.com> <20051117010535.GA15440@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051117010535.GA15440@suse.de>; from gregkh@suse.de on Wed, Nov 16, 2005 at 05:05:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 05:05:35PM -0800, Greg KH wrote:
> 
> Is the type_mask variable really needed here?  Can't we just test:
> 	if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
> instead?
> 
That'll work too. Here's the updated patch.

When attempting to hotadd a PCI card with a bridge on it, I saw
the kernel reporting resource collision errors even when there were
really no collisions. The problem is that the code doesn't skip
over "invalid" resources with their resource type flag not set.
Others have reported similar problems at boot time and for
non-bridge PCI card hotplug too, where the code flags a
resource collision for disabled ROMs. This patch fixes both
problems. 

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>


 arch/i386/pci/i386.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc1/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.15-rc1.orig/arch/i386/pci/i386.c
+++ linux-2.6.15-rc1/arch/i386/pci/i386.c
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
