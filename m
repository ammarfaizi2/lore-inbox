Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWGGWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWGGWFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGGWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:05:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56217 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932337AbWGGWFO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:05:14 -0400
Message-Id: <200607072205.k67M5B9W003595@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6 libata stupid question...
In-Reply-To: Your message of "Fri, 07 Jul 2006 22:51:36 BST."
             <1152309096.23012.0.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu> <1152288721.20883.12.camel@localhost.localdomain> <200607072122.k67LMjfL004124@turing-police.cc.vt.edu>
            <1152309096.23012.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152309911_2990P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 18:05:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152309911_2990P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jul 2006 22:51:36 BST, Alan Cox said:
> Ar Gwe, 2006-07-07 am 17:22 -0400, ysgrifennodd Valdis.Kletnieks@vt.edu:
> >         ap->cbl = ATA_CBL_PATA40;
> > 
> > Guess that explains that, unless the chipset actually *can* do 80-pin
> > and has an 80-pin cable (which would be surprising because apparently
> > none of the other piix variants can...)
> 
> Thats a bug.  ich_pata_100: 3  should have port_ops of ich_port_ops. Try
> with that fixed.

OK, now it thinks there is indeed an 80-pin there:

[    8.447302] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[    8.447959] scsi0 : ata_piix
[    8.448598] in ich_pata_cbl_detect
[    8.448912] controller has 80c support
[    8.449256] ... and we found an 80-pin cable
[    8.756113] ata1.00: configured for UDMA/33
[    8.908139] ata1.01: configured for UDMA/33
[    8.908657]   Vendor: ATA       Model: FUJITSU MHV2060A  Rev: 0000
[    8.909770]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    8.913676]   Vendor: TOSHIBA   Model: CDRW/DVD SDR2102  Rev: 1D13
[    8.914795]   Type:   CD-ROM                             ANSI SCSI revision: 05

so we're slowly getting there...

(If I get ambitious, I'll go back and see what the IDE speed detection issue
was...)

--- linux-2.6.17-mm6/drivers/scsi/ata_piix.c.cable	2006-07-07 12:30:38.000000000 -0400
+++ linux-2.6.17-mm6/drivers/scsi/ata_piix.c	2006-07-07 17:43:32.000000000 -0400
@@ -432,7 +432,7 @@ static struct ata_port_info piix_port_in
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x06, /* mwdma1-2 */
 		.udma_mask	= 0x3f, /* udma0-5 */
-		.port_ops	= &piix_pata_ops,
+		.port_ops	= &ich_pata_ops,
 	},
 
 	/* ich_pata_133: 4 	ICH with full UDMA6 */
@@ -536,20 +536,24 @@ static void ich_pata_cbl_detect(struct a
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 tmp, mask;
 
+printk(KERN_INFO "in ich_pata_cbl_detect\n");
 	/* no 80c support in host controller? */
 	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
 		goto cbl40;
 
+printk(KERN_INFO "controller has 80c support\n");
 	/* check BIOS cable detect results */
 	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
 
+printk(KERN_INFO "... and we found an 80-pin cable\n");
 	ap->cbl = ATA_CBL_PATA80;
 	return;
 
 cbl40:
+printk(KERN_INFO "... and we defaulted to 40-pin\n");
 	ap->cbl = ATA_CBL_PATA40;
 }
 


--==_Exmh_1152309911_2990P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErtqXcC3lWbTT17ARAh1BAJ9D1G8I0M6tE8Px8APfG6f9hFeZRQCeKlK8
zToCRGdwm8RiiHLGZRdm/Go=
=DXas
-----END PGP SIGNATURE-----

--==_Exmh_1152309911_2990P--
