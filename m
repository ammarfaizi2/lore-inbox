Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbULKWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbULKWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbULKWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 17:05:29 -0500
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:38629 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S262025AbULKWDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 17:03:15 -0500
Date: Sat, 11 Dec 2004 17:03:08 -0500
From: Jim Paris <jim@jtan.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: PCI IRQ problems -- update
Message-ID: <20041211220307.GA23848@jim.sh>
References: <20041211173538.GA21216@jim.sh> <1102783555.7267.37.camel@localhost.localdomain> <20041211202314.GA22731@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211202314.GA22731@jim.sh>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ICH3-M datasheet says offset 0x09 is the Programming Interface
> register.  Default value is 0x8A (legacy on both), value here is 0x8E
> (legacy on primary, native on secondary).  This mixed-mode setting
> is noted as a disallowed combination in the datasheet.
> 
> So it looks like my BIOS is screwing me.  Where could/should I fix
> this up?

I added a quirk for this case.  This is against 2.6.10-rc3, and it
makes all of my problems go away cleanly.  Is this reasonable?

-jim

--- a/drivers/pci/quirks.c	2004-12-10 19:18:50.000000000 -0500
+++ b/drivers/pci/quirks.c	2004-12-11 16:32:41.000000000 -0500
@@ -717,6 +717,26 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
 
+/*
+ *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
+ */
+static void __init quirk_ide_samemode(struct pci_dev *pdev)
+{
+	u8 prog;
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+	if ( ((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1)) )
+	{
+		printk(KERN_INFO
+		       "PCI: IDE mode mismatch; forcing legacy mode\n");
+		prog &= ~5;
+		pdev->class &= ~5;
+		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+		/* need to re-assign BARs for compat mode */
+		quirk_ide_bases(pdev);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */
