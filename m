Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbULPBxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbULPBxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbULPAzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:55:01 -0500
Received: from alg145.algor.co.uk ([62.254.210.145]:44561 "EHLO
	dmz.algor.co.uk") by vger.kernel.org with ESMTP id S262543AbULPA0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:26:06 -0500
Date: Thu, 16 Dec 2004 00:25:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] PCI early fixup missing bits
Message-ID: <Pine.LNX.4.61.0412152359360.14855@perivale.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.727,
	required 4, AWL, BAYES_00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 A few bits seem to be missing for PCI early fixup to work -- the 
pci_fixup_device() helper ignores fixups of the pci_fixup_early type.  
Also the local class variable needs to be refreshed after performing the 
fixups for they can change dev->class.

 The patch should be obvious.  Checked against 2.6.10-rc3-bk9.  Please 
apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@mips.com>

patch-mips-2.6.10-rc2-20041124-pci_fixup_early-1
diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/probe.c linux-mips-2.6.10-rc2-20041124/drivers/pci/probe.c
--- linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/probe.c	2004-11-22 14:27:03.000000000 +0000
+++ linux-mips-2.6.10-rc2-20041124/drivers/pci/probe.c	2004-12-15 18:45:32.000000000 +0000
@@ -490,6 +490,7 @@ static int pci_setup_device(struct pci_d
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
+	class = dev->class >> 8;
 
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/quirks.c linux-mips-2.6.10-rc2-20041124/drivers/pci/quirks.c
--- linux-mips-2.6.10-rc2-20041124.macro/drivers/pci/quirks.c	2004-11-22 14:27:04.000000000 +0000
+++ linux-mips-2.6.10-rc2-20041124/drivers/pci/quirks.c	2004-12-15 18:36:15.000000000 +0000
@@ -1232,6 +1232,8 @@ static void pci_do_fixups(struct pci_dev
 	}
 }
 
+extern struct pci_fixup __start_pci_fixups_early[];
+extern struct pci_fixup __end_pci_fixups_early[];
 extern struct pci_fixup __start_pci_fixups_header[];
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
@@ -1245,6 +1247,11 @@ void pci_fixup_device(enum pci_fixup_pas
 	struct pci_fixup *start, *end;
 
 	switch(pass) {
+	case pci_fixup_early:
+		start = __start_pci_fixups_early;
+		end = __end_pci_fixups_early;
+		break;
+
 	case pci_fixup_header:
 		start = __start_pci_fixups_header;
 		end = __end_pci_fixups_header;
