Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUEEMKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUEEMKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUEEMKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:10:51 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:6289 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S264625AbUEEMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:10:15 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Allen Martin" <AMartin@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 5 May 2004 22:14:38 +1000
User-Agent: KMail/1.5.1
Cc: "Len Brown" <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405040111.01514.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405040111.01514.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405052214.38855.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 May 2004 09:11, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 04 of May 2004 00:09, Allen Martin wrote:
> > I'm happy to be able to make this information public to the Linux
> > community.  This information has been previously released to BIOS /
> > board vendors as an appnote, but in the interest of getting a workaround
> > into the hands of users the quickest we're making it public for possible
> > inclusion into the Linux kernel.
> 
> This is a great news!  Below is an untested patch to address this issue.
> 
> Cheers.
> 
> 
> [PATCH] fixup for C1 Halt Disconnect problem on nForce2 chipsets
> 
> Based on information provided by "Allen Martin" <AMartin@nvidia.com>.
> 
>  linux-2.6.6-rc3-bk2-bzolnier/arch/i386/pci/fixup.c |   39 +++++++++++++++++++++
>  1 files changed, 39 insertions(+)
> 
> diff -puN arch/i386/pci/fixup.c~nforce2_fix arch/i386/pci/fixup.c
> --- linux-2.6.6-rc3-bk2/arch/i386/pci/fixup.c~nforce2_fix	2004-05-04 00:27:18.114421672 +0200
> +++ linux-2.6.6-rc3-bk2-bzolnier/arch/i386/pci/fixup.c	2004-05-04 01:02:29.821393416 +0200
> @@ -187,6 +187,39 @@ static void __devinit pci_fixup_transpar
>  		dev->transparent = 1;
>  }
>  
> +/*
> + * Fixup for C1 Halt Disconnect problem on nForce2 systems.
> + *
> + * From information provided by "Allen Martin" <AMartin@nvidia.com>:
> + *
> + * A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
> + * sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to 80 ns.
> + * This allows the state-machine and timer to return to a proper state within
> + * 80 ns of the CONNECT and probe appearing together.  Since the CPU will not
> + * issue another HALT within 80 ns of the initial HALT, the failure condition
> + * is avoided.
> + */
> +static void __devinit pci_fixup_nforce2(struct pci_dev *dev)
> +{
> +	u32 val, fixed_val;
> +	u8 rev;
> +
> +	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
> +
> +	/*
> +	 * Chip  Old value   New value
> +	 * C17   0x1F01FF01  0x1F0FFF01
> +	 * C18D  0x9F01FF01  0x9F0FFF01
> +	 */
> +	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
> +
> +	pci_read_config_dword(dev, 0x6c, &val);
> +	if (val != fixed_val) {
> +		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnet fixup\n");
> +		pci_write_config_dword(dev, 0x6c, fixed_val);
> +	}
> +}
> +
>  struct pci_fixup pcibios_fixups[] = {
>  	{
>  		.pass		= PCI_FIXUP_HEADER,
> @@ -290,5 +323,11 @@ struct pci_fixup pcibios_fixups[] = {
>  		.device		= PCI_ANY_ID,
>  		.hook		= pci_fixup_transparent_bridge
>  	},
> +	{
> +		.pass		= PCI_FIXUP_HEADER,
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
> +		.hook		= pci_fixup_nforce2
> +	},
>  	{ .pass = 0 }
>  };
> 
> _
> 
> 
> 
> 

Minor typo 
printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnet fixup\n");
should be
printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");

For 2.4.26 follows a rediffed patch. 
Note as per other postings this 
+static void __devinit pci_fixup_nforce2(struct pci_dev *dev)
should be
+static void __init pci_fixup_nforce2(struct pci_dev *dev)
which would match other 2.4 fixups e.g.
static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)

Works well for 2.4.26 on my epox 8rga+. Yet to try on my albatron KM18G-pros.

To my knowledge the only thing left to sort out for the normal kernel
distro is what to do about the timer_ack issue in check_timer().

We need it off for nforce2 to get nmi_watchdog=1 working with ioapic
8254 timer pin0  timer override patch routing. I vote to revisit Maciej's
patch that was dropped by Linus after appearing in 2.6.3-mm3. 
For those with problems of clock skew with the timer into pin0 routing, 
that patch gave a virtual wire timer routing which worked well for those
users.

It also works around problems for ibm users.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html

That patch is last posted here (Maciej please correct me if i'm wrong)
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html

Here is rediffed nforce2 patch for 2.4.26

--- linux-2.4.26/arch/i386/kernel/pci-pc.c.orig 2003-11-29 04:26:19.000000000 +1000
+++ linux/arch/i386/kernel/pci-pc.c     2004-05-04 22:54:32.000000000 +1000
@@ -1326,10 +1326,43 @@ static void __init pci_fixup_transparent
        if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
            (dev->device & 0xff00) == 0x2400)
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
+       u32 val, fixed_val;
+       u8 rev;
+
+       pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+       /*
+       * Chip  Old value       New value
+       * C17   0x1F01FF01      0x1F0FFF01
+       * C18D  0x9F01FF01      0x9F0FFF01
+       */
+       fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
+
+       pci_read_config_dword(dev, 0x6c, &val);
+       if (val != fixed_val) {
+               printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
+               pci_write_config_dword(dev, 0x6c, fixed_val);
+       }
+}
+
 struct pci_fixup pcibios_fixups[] = {
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82451NX,    pci_fixup_i450nx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82454GX,    pci_fixup_i450gx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_UMC,      PCI_DEVICE_ID_UMC_UM8886BF,     pci_fixup_umc_ide },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5513,          pci_fixup_ide_trash },
@@ -1341,10 +1374,11 @@ struct pci_fixup pcibios_fixups[] = {
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8622,         pci_fixup_via_northbridge_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8361,         pci_fixup_via_northbridge_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8367_0,       pci_fixup_via_northbridge_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_NCR,      PCI_DEVICE_ID_NCR_53C810,       pci_fixup_ncr53c810 },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,                     pci_fixup_transparent_bridge },
+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_NVIDIA,   PCI_DEVICE_ID_NVIDIA_NFORCE2,   pci_fixup_nforce2},
        { 0 }
 };
 
 /*
  *  Called after each bus is probed, but before its children


Regards
Ross.





