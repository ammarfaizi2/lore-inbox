Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVJQPOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVJQPOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVJQPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:14:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751390AbVJQPOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:14:39 -0400
Date: Mon, 17 Oct 2005 08:14:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
In-Reply-To: <20051017044606.GA1266@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
> CONFIG_SCSI_SATA is truly a boolean option, not a tristate.
> Since the Kconfig dependencies are insufficient to describe this (2.4
> had dep_mbool), we need to resort to 'if'.

Two problems:

 - this is ugly as hell

   First, you change SCSI_SATA to be boolean, then you change the 
   depends-on to be "if". Which makes no sense. Once SCSI_SATA is a 
   boolean, then the "depends on" works fine, since SCSI_SATA can no 
   longer be "m" anyway (ie your comment about "dep_mbool" doesn't make 
   sense).

   Second, if you want "dep_mbool", then you can have dep_mbool in Kconfig 
   too. Just do

	depends on (XYZ != n)

   which gets you what you want (ie if XYZ is "m", then the inequality 
   will be "y")

   So you might as well have just done something like

	 config SCSI_SATA
	-       tristate "Serial ATA (SATA) support"
	-       depends on SCSI
	+       bool "Serial ATA (SATA) support"
	+       depends on SCSI != n

   and then just added SCSI to the "depends on" lines to get the "m" 
   config. No "if" needed.

 - anything that depends on a module had better only be _inside_ that 
   module. Ie the "dep_mbool" kind of behaviour should _not_ affect 
   anything outside the module. The reason? Maybe you build the module 
   _later_, and maybe you don't ever load it.

   So it appears that your dependence on quirk_intel_ide_combined() is 
   fundamentally broken for the "m" case _anyway_.

Anyway, the second thing means that the whole configuration is somewhat 
broken, but on the whole, why not this _much_ more trivial patch?

It's still broken, exactly because it depends on the modules being defined 
when compiling the whole kernel, but hey, we probably have other cases 
like that.

My suggestion being that we should make it unconditional, but maybe that 
breaks the case where we don't actually load the SATA module?

		Linus

---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 11ca443..cec631b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1233,7 +1233,7 @@ static void __init quirk_alder_ioapic(st
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
+#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -1310,7 +1310,7 @@ static void __devinit quirk_intel_ide_co
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
-#endif /* CONFIG_SCSI_SATA */
+#endif /* CONFIG_SCSI_SATA[_MODULE] */
 
 
 int pcie_mch_quirk;
