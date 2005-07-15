Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263280AbVGOMIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbVGOMIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVGOMIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:08:55 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:45247 "EHLO
	laptop.blackstar.nl") by vger.kernel.org with ESMTP id S263285AbVGOMIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:08:53 -0400
Subject: Re: ATAPI+SATA support in 2.6.13-rc3
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42D7A3D1.5080609@gmx.net>
References: <42D78269.5020809@gmx.net>
	 <1121421557.5110.11.camel@laptop.blackstar.nl>  <42D7A3D1.5080609@gmx.net>
Content-Type: multipart/mixed; boundary="=-tMHQaBemmB7e5UatXxl9"
Date: Fri, 15 Jul 2005 14:08:46 +0200
Message-Id: <1121429327.5110.15.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tMHQaBemmB7e5UatXxl9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-07-15 at 13:53 +0200, Carl-Daniel Hailfinger wrote:
> Bas Vermeulen schrieb:
> > On Fri, 2005-07-15 at 11:31 +0200, Carl-Daniel Hailfinger wrote:
> > 
> >>Hi Jeff,
> >>
> >>I have a Intel ICH6M chipset and am using ata_piix as my
> >>default disk driver. With the SUSE patched 2.6.11.4 kernel
> >>(it has some libata patches) my DVD-RAM drive works, with
> >>2.6.13-rc3 it doesn't work. My .config is nearly identical
> >>for both kernels (except options introduced after 2.6.11).
> >>
> >>I have two suspects: the changed interrupt routing and
> >>libata version differences. Especially strange is the fact
> >>that both kernels seem to disagree with lspci about the
> >>interrupts assigned to the SATA controller.
> >>
> >>Please find dmesg, /proc/interrupts and lspci -v attached
> >>for both kernels.
> >>
> >>Regards,
> >>Carl-Daniel
> > 
> > 
> > You'll need to enable ATAPI support for ata_piix in
> > include/linux/libata.h
> > 
> > Change:
> > #undef ATA_ENABLE_ATAPI
> > 
> > into
> > #define ATA_ENABLE_ATAPI
> > 
> > Suse has probably done that for you, it's disabled by default.
> 
> Thanks, I'll try that.
> 
> Are there any unmerged (in 2.6.13-rc3) libata patches and
> where can I find them?

Not sure about that. I currently use the following patch to make
ata_piix work with my PATA controller (ICH3-M). I think you'll only need
the defines in libata.h, and without the PATA define.

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

--=-tMHQaBemmB7e5UatXxl9
Content-Disposition: attachment; filename=ata_piix.patch
Content-Type: text/x-patch; name=ata_piix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.12/drivers/scsi/ata_piix.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6/drivers/scsi/ata_piix.c	2005-07-08 11:29:48.000000000 +0200
@@ -77,6 +77,8 @@
 static struct pci_device_id piix_pci_tbl[] = {
 #ifdef ATA_ENABLE_PATA
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
+	{ 0x8086, 0x244a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
+	{ 0x8086, 0x248a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
 	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
 	{ 0x8086, 0x25a2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
 #endif
--- linux-2.6.12/include/linux/libata.h	2005-07-11 17:21:08.000000000 +0200
+++ linux-2.6/include/linux/libata.h	2005-07-08 11:32:43.000000000 +0200
@@ -37,8 +37,8 @@
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
-#undef ATA_ENABLE_PATA		/* define to enable PATA support in some
+#define ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
+#define ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 #undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
 

--=-tMHQaBemmB7e5UatXxl9--

