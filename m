Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUECXLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUECXLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUECXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:11:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30858 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264154AbUECXKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:10:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Allen Martin" <AMartin@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Tue, 4 May 2004 01:11:01 +0200
User-Agent: KMail/1.5.3
Cc: "Ross Dickson" <ross@datscreative.com.au>,
       "Len Brown" <len.brown@intel.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405040111.01514.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 of May 2004 00:09, Allen Martin wrote:
> I'm happy to be able to make this information public to the Linux
> community.  This information has been previously released to BIOS /
> board vendors as an appnote, but in the interest of getting a workaround
> into the hands of users the quickest we're making it public for possible
> inclusion into the Linux kernel.

This is a great news!  Below is an untested patch to address this issue.

Cheers.


[PATCH] fixup for C1 Halt Disconnect problem on nForce2 chipsets

Based on information provided by "Allen Martin" <AMartin@nvidia.com>.

 linux-2.6.6-rc3-bk2-bzolnier/arch/i386/pci/fixup.c |   39 +++++++++++++++++++++
 1 files changed, 39 insertions(+)

diff -puN arch/i386/pci/fixup.c~nforce2_fix arch/i386/pci/fixup.c
--- linux-2.6.6-rc3-bk2/arch/i386/pci/fixup.c~nforce2_fix	2004-05-04 00:27:18.114421672 +0200
+++ linux-2.6.6-rc3-bk2-bzolnier/arch/i386/pci/fixup.c	2004-05-04 01:02:29.821393416 +0200
@@ -187,6 +187,39 @@ static void __devinit pci_fixup_transpar
 		dev->transparent = 1;
 }
 
+/*
+ * Fixup for C1 Halt Disconnect problem on nForce2 systems.
+ *
+ * From information provided by "Allen Martin" <AMartin@nvidia.com>:
+ *
+ * A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
+ * sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to 80 ns.
+ * This allows the state-machine and timer to return to a proper state within
+ * 80 ns of the CONNECT and probe appearing together.  Since the CPU will not
+ * issue another HALT within 80 ns of the initial HALT, the failure condition
+ * is avoided.
+ */
+static void __devinit pci_fixup_nforce2(struct pci_dev *dev)
+{
+	u32 val, fixed_val;
+	u8 rev;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+	/*
+	 * Chip  Old value   New value
+	 * C17   0x1F01FF01  0x1F0FFF01
+	 * C18D  0x9F01FF01  0x9F0FFF01
+	 */
+	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
+
+	pci_read_config_dword(dev, 0x6c, &val);
+	if (val != fixed_val) {
+		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnet fixup\n");
+		pci_write_config_dword(dev, 0x6c, fixed_val);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{
 		.pass		= PCI_FIXUP_HEADER,
@@ -290,5 +323,11 @@ struct pci_fixup pcibios_fixups[] = {
 		.device		= PCI_ANY_ID,
 		.hook		= pci_fixup_transparent_bridge
 	},
+	{
+		.pass		= PCI_FIXUP_HEADER,
+		.vendor		= PCI_VENDOR_ID_NVIDIA,
+		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
+		.hook		= pci_fixup_nforce2
+	},
 	{ .pass = 0 }
 };

_

