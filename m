Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVCBGee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVCBGee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVCBGec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:34:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52421 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262190AbVCBGe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:34:26 -0500
Message-ID: <42255E5D.1030908@pobox.com>
Date: Wed, 02 Mar 2005 01:34:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       vojtech@suse.cz, giovanni@sudfr.com, andre@linux-ide.org,
       dake@staszic.waw.pl
Subject: Re: via 6420 pata/sata controller
References: <42213771.5060809@seznam.cz>
In-Reply-To: <42213771.5060809@seznam.cz>
Content-Type: multipart/mixed;
 boundary="------------020308060205040301050601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308060205040301050601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If I had to guess, I would try the attached patch.  The via82cxxx.c 
driver is a bit annoying in that, here we do not talk to the ISA bridge 
but to the PCI device 0x4149 itself.

If this doesn't work, I could probably whip together a quick PATA driver 
for libata that works on this hardware.

	Jeff



--------------020308060205040301050601
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/ide/pci/via82cxxx.c 1.27 vs edited =====
--- 1.27/drivers/ide/pci/via82cxxx.c	2005-02-03 02:24:29 -05:00
+++ edited/drivers/ide/pci/via82cxxx.c	2005-03-02 01:28:26 -05:00
@@ -79,6 +79,7 @@
 	u8 rev_max;
 	u16 flags;
 } via_isa_bridges[] = {
+	{ "vt6420",	0x4149,			    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
@@ -635,9 +636,10 @@
 }
 
 static struct pci_device_id via_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ 0, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x4149) },
+	{ },	/* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
 

--------------020308060205040301050601--
