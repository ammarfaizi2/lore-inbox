Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWCQADM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWCQADM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWCQADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:03:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:33438 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964900AbWCQADL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:03:11 -0500
Subject: [PATCH] i386: run BIOS PCI detection before direct
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, gregkh@suse.de,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 16 Mar 2006 16:03:03 -0800
Message-Id: <20060317000303.13252107@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


from 2.6.16-rc3-mm1 through at least 2.6.16-rc6-mm1 a patch from
Andi Kleen, titled

        x86_64-i386-pci-ordering.patch

which is now called:

	gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch

has caused a 4-way PIII Xeon (non-NUMA) to stop detecting its SCSI
card.  I believe this is also the issue keeping -mm from booting
on "elm3b67" from http://test.kernel.org/. 

The following patch reverts the ordering of the PCI detection code
to always run the BIOS initialization, first.  As far as I can
tell, this was the original behavior, and it makes my machine boot
again.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/arch/i386/pci/init.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/i386/pci/init.c~run-bios-first-take2 arch/i386/pci/init.c
--- work/arch/i386/pci/init.c~run-bios-first-take2	2006-03-16 15:55:00.000000000 -0800
+++ work-dave/arch/i386/pci/init.c	2006-03-16 15:55:47.000000000 -0800
@@ -12,13 +12,13 @@ static __init int pci_access_init(void)
 #endif
 	if (raw_pci_ops)
 		return 0;
-#ifdef CONFIG_PCI_DIRECT
-	pci_direct_init();
+#ifdef CONFIG_PCI_BIOS
+	pci_pcbios_init();
 #endif
 	if (raw_pci_ops)
 		return 0;
-#ifdef CONFIG_PCI_BIOS
-	pci_pcbios_init();
+#ifdef CONFIG_PCI_DIRECT
+	pci_direct_init();
 #endif
 	return 0;
 }
_
