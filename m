Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWEUK7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWEUK7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEUK7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:59:38 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:31394 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932352AbWEUK7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:59:38 -0400
Message-ID: <447047F2.2070607@myri.com>
Date: Sun, 21 May 2006 12:58:58 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Greg KH <gregkh@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il>
In-Reply-To: <20060521101656.GM30211@mellanox.co.il>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------000909030103090909050404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909030103090909050404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> Quoting r. Greg KH <gregkh@suse.de>:
>> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
>>
>> On Mon, May 15, 2006 at 11:11:33PM +0200, Brice Goglin wrote:
>>> Hi Greg,
>>>
>>> While looking at the MSI detection, I noticed that the AMD 8131 quirk
>>> (quirk_amd_8131_ioapic) is defined as FINAL and thus executed after the
>>> PCI hierarchy is scanned. So it looks like the bus_flags won't be
>>> inherited at all. If there's a bridge behind the 8131, then the devices
>>> behind this bridge won't see the bus flags and thus might try to enable
>>> MSI anyway.
>>> I tried to change the AMD 8131 quirk to HEADER so that it is executed
>>> during PCI scanning. But, I don't get its message in dmesg anymore. Any
>>> idea?
>> Michael is the one who added that change, perhaps he can explain how he
>> tested it?
>
> Well, I just re-tested with 2.6.17-rc4 and it does not seem to work.  No idea
> what did I do wrong when testing this patch before posting it :(. Oops.
> I'm sorry.
>
> Given that its late in -rc series, that its a clear regression from 2.6.16, that
> disabling MSI is always safe, and that the patch was intended to enable MSI on
> Tyan motherboard which Roland used to have but doesn't anymore and which no one
> else seems to be bothered to test on either - it seems the best thing is to just
> revert the patch, and go back to using a global flag for now.

I would say that it works for devices that are directly behind the
amd8131. But it won't disable MSI for devices that are behind another
bridge behind the 8131. It is great for us since we have lots of Tyan
motherboards without any device behind the 8131 :) I don't know how many
machines have a bridge behind a 8131, this bug might not hit a lot of
people.

At least, with 2.6.17-rc, we can get MSI on devices that have nothing to
do with the 8131. I consider this a very good progress. Yes, we try to
enable MSI on devices behing a bridge behind the 8131. But, if few
people have such a PCI hierarchy, I am not sure this regression is
important. What happens if you actually enable MSI there ? It fails ? Or
it crashes ? Is it worth than having no MSI at all on any devices on the
machine ?

Anyway, we are working on merging our MSI detection code based on HT
capabilities. And we think we might have to add a couple other quirks
where it will be very important there that the bus flags are inherited.
So I tried to dig more in what we could do to inherit flags properly and
here's what I found:

The amd8131 MSI quirk cannot be EARLY or HEADER because it would be
called before dev->subordinate has been set. So PCI_BUS_FLAGS_NO_MSI
could not be set in the bus flags at this time.
So we need a quirk that is called while the PCI hierarchy is scanned
(ie, before FINAL or ENABLE) and after the pci child bus of the bridge
is created (ie, after EARLY and HEADER).

The attached patch adds a new type of fixup that is called right after
the child bus is created (ie, when dev->subordinate exists). And the
patch moves the amd8131 MSI quirk to use this new quirk type.
I chose the name "bridge header" but I guess somebody will come with a
better name (I am not really familiar with all the PCI terminology).

Signed-off-by: Brice Goglin <brice@myri.com>

Brice


--------------000909030103090909050404
Content-Type: text/x-patch;
 name="fix_amd8131_nomsi_quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_amd8131_nomsi_quirk.patch"

Index: brice-2.6.17-rc4/drivers/pci/quirks.c
===================================================================
--- brice-2.6.17-rc4.orig/drivers/pci/quirks.c	2006-05-17 04:16:26.000000000 -0400
+++ brice-2.6.17-rc4/drivers/pci/quirks.c	2006-05-20 08:29:55.000000000 -0400
@@ -575,12 +575,6 @@
 { 
         unsigned char revid, tmp;
         
-	if (dev->subordinate) {
-		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
-		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-	}
-
         if (nr_ioapics == 0) 
                 return;
 
@@ -594,6 +588,16 @@
 } 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
 
+static void __init quirk_amd_8131_nomsi(struct pci_dev *dev)
+{ 
+	if (dev->subordinate) {
+		printk(KERN_WARNING "PCI: MSI quirk detected. "
+		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
+		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+	}
+}
+DECLARE_PCI_FIXUP_BRIDGE_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_nomsi);
+
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
 	pci_msi_quirk = 1;
@@ -1407,6 +1411,8 @@
 extern struct pci_fixup __end_pci_fixups_early[];
 extern struct pci_fixup __start_pci_fixups_header[];
 extern struct pci_fixup __end_pci_fixups_header[];
+extern struct pci_fixup __start_pci_fixups_bridge_header[];
+extern struct pci_fixup __end_pci_fixups_bridge_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
 extern struct pci_fixup __end_pci_fixups_final[];
 extern struct pci_fixup __start_pci_fixups_enable[];
@@ -1428,6 +1434,11 @@
 		end = __end_pci_fixups_header;
 		break;
 
+	case pci_fixup_bridge_header:
+		start = __start_pci_fixups_bridge_header;
+		end = __end_pci_fixups_bridge_header;
+		break;
+
 	case pci_fixup_final:
 		start = __start_pci_fixups_final;
 		end = __end_pci_fixups_final;
Index: brice-2.6.17-rc4/drivers/pci/probe.c
===================================================================
--- brice-2.6.17-rc4.orig/drivers/pci/probe.c	2006-05-17 04:16:29.000000000 -0400
+++ brice-2.6.17-rc4/drivers/pci/probe.c	2006-05-20 08:20:30.000000000 -0400
@@ -367,6 +367,7 @@
 		child->resource[i]->name = child->name;
 	}
 	bridge->subordinate = child;
+	pci_fixup_device(pci_fixup_bridge_header, bridge);
 
 	return child;
 }
Index: brice-2.6.17-rc4/include/asm-generic/vmlinux.lds.h
===================================================================
--- brice-2.6.17-rc4.orig/include/asm-generic/vmlinux.lds.h	2006-05-12 16:49:03.000000000 -0400
+++ brice-2.6.17-rc4/include/asm-generic/vmlinux.lds.h	2006-05-20 08:39:42.000000000 -0400
@@ -29,6 +29,9 @@
 		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
 		*(.pci_fixup_header)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_bridge_header) = .;	\
+		*(.pci_fixup_bridge_header)				\
+		VMLINUX_SYMBOL(__end_pci_fixups_bridge_header) = .;	\
 		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
 		*(.pci_fixup_final)					\
 		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
Index: brice-2.6.17-rc4/include/linux/pci.h
===================================================================
--- brice-2.6.17-rc4.orig/include/linux/pci.h	2006-05-17 04:19:53.000000000 -0400
+++ brice-2.6.17-rc4/include/linux/pci.h	2006-05-20 08:01:24.000000000 -0400
@@ -750,6 +750,7 @@
 enum pci_fixup_pass {
 	pci_fixup_early,	/* Before probing BARs */
 	pci_fixup_header,	/* After reading configuration header */
+	pci_fixup_bridge_header,	/* After setting up the bridge subordinate */
 	pci_fixup_final,	/* Final phase of device fixups */
 	pci_fixup_enable,	/* pci_enable_device() time */
 };
@@ -764,6 +765,9 @@
 #define DECLARE_PCI_FIXUP_HEADER(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,			\
 			vendor##device##hook, vendor, device, hook)
+#define DECLARE_PCI_FIXUP_BRIDGE_HEADER(vendor, device, hook)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_bridge_header,		\
+			vendor##device##hook, vendor, device, hook)
 #define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
 			vendor##device##hook, vendor, device, hook)

--------------000909030103090909050404--
