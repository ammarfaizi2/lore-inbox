Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUEQOV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUEQOV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEQOV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:21:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35496 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261236AbUEQOVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:21:52 -0400
Date: Mon, 17 May 2004 16:19:31 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
In-Reply-To: <Pine.GSO.4.58.0405171308580.19405@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0405171545490.19405@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
 <20040514150900.GA19315@lists.us.dell.com> <40A4ED87.20608@pobox.com>
 <Pine.GSO.4.58.0405171308580.19405@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004, Geert Uytterhoeven wrote:
> On Fri, 14 May 2004, Jeff Garzik wrote:
> > Matt Domsch wrote:
> > > On Fri, May 14, 2004 at 03:11:00PM +0200, Geert Uytterhoeven wrote:
> > >
> > >>I'm trying to install Linux on a SATA disk in a Dell PowerEdge 750, which has
> > >>an Intel 82875P chipset with an Intel 6300ESB SATA Storage Controller.
> > >
> > >
> > > [snip]
> > >
> > >
> > >>I looked at ata_piix.c, and apparently the driver decides whether a port is
> > >>disabled by checking a bit in PCI config space, so this looks like a BIOS setup
> > >>problem to me. But the BIOS has the first SATA port enabled (`AUTO', and it
> > >>does see a 80 GB disk there), while the PATA and second SATA ports are marked
> > >>`OFF'.
> > >
> > >
> > > Right.  At present you need to enable the second SATA  port in the
> > > BIOS.  Disabling it also disables the first port from being
> > > recognized by the driver.  It's a figment of the "compatability mode"
> > > that the PE750 runs in.  I believe Stuart Hayes sent Jeff a patch to
> > > address this, but I can't find it handy...
> >
> >
> > That _should_ have been fixed in the last update to ata_piix.  If you
> > could get Stuart to re-test and re-submit that patch if necessary, that
> > would be useful.
> >
> > Geert, two things to try:
> > 1) Try the latest kernel
>
> Thanks! I'll try that one...

And so I did. But 2.6.6-bk4 still gives:

| Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
| ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| ide1: I/O resource 0x170-0x177 not free.
| ide1: ports already in use, skipping probe
| ata_piix: combined mode detected
| ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFEA0 irq 14
| ata1: port disabled. ignoring.
| scsi0 : ata_piix
| ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
| ata2: port disabled. ignoring.
| scsi1 : ata_piix

If I disable CONFIG_SCSI_SATA, IDE works, but very slow (no DMA).

If I try to work around the problem by applying this patch:

--- linux-2.6.6-bk4/drivers/scsi/ata_piix.c.orig	2004-05-17 20:02:25.000000000 +0200
+++ linux-2.6.6-bk4/drivers/scsi/ata_piix.c	2004-05-17 20:59:15.000000000 +0200
@@ -330,8 +330,8 @@
 	if (!pci_test_config_bits(ap->host_set->pdev,
 				  &piix_enable_bits[ap->port_no])) {
 		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
+		//printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		printk(KERN_INFO "ata%u: port disabled. NOT IGNORING!\n", ap->id);
 	}

 	if (!piix_sata_probe(ap)) {

everything works fine, even if I disable the second SATA port in the BIOS:

| Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
| ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
| ide1: I/O resource 0x170-0x177 not free.
| ide1: ports already in use, skipping probe
| ata_piix: combined mode detected
| ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFEA0 irq 14
| ata1: port disabled. ignoring.
| scsi0 : ata_piix
| ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
| ata2: port disabled. NOT IGNORING!
| ata2: dev 0 ATA, max UDMA/133, 156250000 sectors:
| ata2: dev 0 configured for UDMA/133
| scsi1 : ata_piix
|   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: 1.02
|   Type:   Direct-Access                      ANSI SCSI revision: 05
| SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
| SCSI device sda: drive cache: write through
|  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
| Attached scsi disk sda at scsi1, channel 0, id 0, lun 0

... and I'm a happy man (for now ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
