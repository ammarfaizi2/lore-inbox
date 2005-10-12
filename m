Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVJLWRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVJLWRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJLWRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:17:03 -0400
Received: from fmr22.intel.com ([143.183.121.14]:24714 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932482AbVJLWRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:17:02 -0400
Date: Wed, 12 Oct 2005 15:16:42 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <thomas.schaefer@kontron.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PCIe hotplug on far PCIe switch ports
Message-ID: <20051012151639.A29756@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <D9F0B2AD4531B0449D51C1F09199D4840E0DAE@mail.kom-saarbruecken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <D9F0B2AD4531B0449D51C1F09199D4840E0DAE@mail.kom-saarbruecken.com>; from thomas.schaefer@kontron.com on Wed, Oct 12, 2005 at 07:07:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:07:19PM +0200, Thomas Schäfer wrote:
> 
> When pressing the attention button, the driver of the network adapter is unloaded and the adapter is properly removed from the PCI tree. But when pressing the attention button again, reinsertion of the network adapter in the PCI tree works, but loading the driver fails:
> 
<snip>
>    PCI: Device 0000:06:00.0 not available because of resource collisions
>    tg3: Cannot enable PCI device, aborting.
>    tg3: probe of 0000:06:00.0 failed with error -22
> 
I think the kernel is flagging a bogus resource collision error
for the disabled rom on the hot-added device. lspci output after
boot shows that the device has a disabled ROM.
> 
>    [root@amceval ~]# lspci -vx -s 6:0.0
>    06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
>            Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express
>            Flags: bus master, fast devsel, latency 0, IRQ 16
>            Memory at fe9f0000 (64-bit, non-prefetchable) [size=64K]
>            Expansion ROM at fe9e0000 [disabled] [size=64K]
>            Capabilities: [48] Power Management version 2
>            Capabilities: [50] Vital Product Data
>            Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
>            Capabilities: [d0] Express Endpoint IRQ 0
>    00: e4 14 59 16 06 00 10 00 11 00 00 02 10 00 00 00
>    10: 04 00 9f fe 00 00 00 00 00 00 00 00 00 00 00 00
>    20: 00 00 00 00 00 00 00 00 07 00 00 00 e4 14 59 16
>    30: 00 00 9e fe 48 00 00 00 00 00 00 00 0a 01 00 00
> 
> 
When attempting the hot-add, the pciehp driver clobbers the rom
base address to 0. When pciehp later calls pci_scan_slot() ->
pci_read_bases(), the device's resource structure records a
0 rom base address but a non-zero size. This in turn causes
the kernel to believe this was done to flag a resource conflict.

Does this patch fix the problem?

Signed-off-by: rajesh.shah@intel.com

 arch/i386/pci/i386.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.14-rc4/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/i386/pci/i386.c
+++ linux-2.6.14-rc4/arch/i386/pci/i386.c
@@ -221,6 +221,9 @@ int pcibios_enable_resources(struct pci_
 			continue;
 
 		r = &dev->resource[idx];
+		if ((idx == PCI_ROM_RESOURCE) &&
+				(!(r->flags & IORESOURCE_ROM_ENABLE)))
+			continue;
 		if (!r->start && r->end) {
 			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
 			return -EINVAL;
@@ -230,8 +233,6 @@ int pcibios_enable_resources(struct pci_
 		if (r->flags & IORESOURCE_MEM)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		cmd |= PCI_COMMAND_MEMORY;
 	if (cmd != old_cmd) {
 		printk("PCI: Enabling device %s (%04x -> %04x)\n", pci_name(dev), old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
