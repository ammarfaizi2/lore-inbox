Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbULQQY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbULQQY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbULQQY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:24:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261812AbULQQYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:24:13 -0500
Date: Fri, 17 Dec 2004 16:24:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041217162411.GI7113@parcelfarce.linux.theplanet.co.uk>
References: <200412162224.iBGMOQ52284713@fsgi900.americas.sgi.com> <20041216231519.GA16249@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216231519.GA16249@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 11:15:19PM +0000, Christoph Hellwig wrote:
> I took a very short look and what spring to mind first is that the

Rats, I'd hoped you'd have time to do a more thorough review.  Here's
some more comments:

Don't define your own names for standard PCI config space -- use the
ones in linux/pci.h instead.  This whole section should be deleted:

+/*
+ * PCI Configuration Space Register Address Map, use offset from IOC4 PCI
+ * configuration base such that this can be used for multiple IOC4s
+ */
+#define IOC4_PCI_SCR	   0x4	/* Status/Command */
+#define IOC4_PCI_REV	   0x8	/* Revision */
+#define IOC4_PCI_LAT	   0xC	/* Latency Timer */
+#define IOC4_PCI_BAR0	   0x10	/* IOC4 base address 0 */
+#define IOC4_PCI_SIDV	   0x2c	/* Subsys ID and vendor */
+#define IOC4_PCI_CAP	   0x34	/* Capability pointer */
+#define IOC4_PCI_LATGNTINT 0x3c	/* Max_lat, min_gnt, int_pin, int_line */


Calling a pci_dev a "pci_handle" is confusing; most code uses "pdev".

+	pci_read_config_dword(pci_handle, IOC4_PCI_SCR, &tmp);
+	pci_write_config_dword(pci_handle, IOC4_PCI_SCR,
+			       tmp | PCI_COMMAND_MASTER |
+			       PCI_COMMAND_MEMORY |
+			       PCI_COMMAND_PARITY | PCI_COMMAND_SERR);

You call pci_set_master() before this which takes care of PCI_COMMAND_MASTER.
You also call pci_enable_device() which calls pcibios_enable_device()
which ensures PCI_COMMAND_MEMORY is set if it needs to be.

So the code above should be:

	pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
	pci_write_config_dword(pdev, PCI_COMMAND, cmd | \
			PCI_COMMAND_PARITY | PCI_COMMAND_SERR);

Personally, I believe we should be setting PCI_COMMAND_PARITY and
PCI_COMMAND_SERR on all devices by default in pcibios_enable_device,
if not in pci_enable_device().  But we don't, so it's fine to do it
in your driver for the moment.


You don't need the:

+	if (!ia64_platform_is("sn2"))
+		return -ENODEV;

since this code will only ever be called if someone has an ioc4 in
their system.  If it's not an sn2, something's very strange ;-)


+struct pci_driver ioc4_s_driver = {
+      name	:"IOC4 Serial",
+      id_table	:ioc4_s_id_table,
+      probe	:ioc4_attach,
+};

please use C99 initialisers instead


+    {PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4, PCI_ANY_ID, PCI_ANY_ID, 0,0,0},
you don't need the trailing zeroes


I don't see why you need valid_icount_path().  Everywhere it's called,
you seem to have been handed an ioc4_port back by the kernel core.
Are you just checking for data corruption elsewhere, or is this masking
a bug elsewhere in the driver?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
