Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031748AbWLAUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031748AbWLAUfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031759AbWLAUfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:35:33 -0500
Received: from mx2.mail.ru ([194.67.23.122]:5494 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1031748AbWLAUfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:35:32 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: alan@lxorguk.ukuu.org.uk
Subject: 2.6.19: ALi M5229 - CD-ROM not found with pata_ali
Date: Fri, 1 Dec 2006 23:35:28 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200606220004.30863.arvidjaar@mail.ru>
In-Reply-To: <200606220004.30863.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612012335.29179.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 22 June 2006 00:04, Andrey Borzenkov wrote:
> Just in case you have missed this on LKML :)
>
> Alan Cox wrote:
> > http://zeniv.linux.org.uk/~alan/IDE
> >
> > This is basically a resync versus 2.6.17, the head of the PATA tree is
> > now built against Jeffs tree with revised error handling and the like.
>
> Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
> Notice "ata2: command 0xa0 timeout" below.
>

Still the same in 2.6.19 + suspend pata_ali patch. The only way I can get 
CD-ROM is with

options pata_ali atapi_max_xfer_mask=0x7f

and patch

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 1d695df..a0b9e49 100644
- --- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -329,6 +329,16 @@ static void ali_lock_sectors(struct ata_
        adev->max_sectors = 255;
 }

+static unsigned long atapi_max_xfer_mask = ~0;
+module_param(atapi_max_xfer_mask, ulong, 644);
+
+static unsigned long ali_mode_filter(const struct ata_port *ap, struct 
ata_devi
ce *adev, unsigned long xfer_mask)
+{
+       if (adev->class == ATA_DEV_ATAPI)
+               xfer_mask &= atapi_max_xfer_mask;
+       return ata_pci_default_filter(ap, adev, xfer_mask);
+}
+
 static struct scsi_host_template ali_sht = {
        .module                 = THIS_MODULE,
        .name                   = DRV_NAME,
@@ -428,7 +438,7 @@ static struct ata_port_operations ali_c2
        .port_disable   = ata_port_disable,
        .set_piomode    = ali_set_piomode,
        .set_dmamode    = ali_set_dmamode,
- -       .mode_filter    = ata_pci_default_filter,
+       .mode_filter    = ali_mode_filter,
        .tf_load        = ata_tf_load,
        .tf_read        = ata_tf_read,
        .check_status   = ata_check_status,

allowing even MWDMA results in the same timeouts and CD-ROM not found.


> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
> ata1: dev 0 cfg 49:0f00 82:746b 83:49a8 84:4003 85:f469 86:0808 87:4003
> 88:103f
> ata1: dev 0 ATA-5, max UDMA/100, 39070080 sectors: LBA
> ata1: dev 0 configured for UDMA/33
> scsi0 : ali
>   Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
> ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
> 88:0407
> ata2: dev 0 ATAPI, max UDMA/33
> ata2: dev 0 configured for UDMA/33
> scsi1 : ali
> ata2: command 0xa0 timeout, stat 0x58 host_stat 0x21
> ata2: translated ATA stat/err 0x58/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2
> sd 0:0:0:0: Attached scsi disk sda
>
> Otherwise I am pretty much impressed.
>
> 00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev
> 01)
> 00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
> 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> 00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
> 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
> Controller Audio Device (rev 01)
> 00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
> 00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
> 00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
> (rev 08)
> 00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
> Controller (rev 01)
> 00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to
> Cardbus Bridge with ZV Support (rev 32)
> 00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to
> Cardbus Bridge with ZV Support (rev 32)
> 00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller
> (rev 03)
> 01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1
> (rev 82)
>
>
> And running "classical" IDE:
>
> {pts/0}% sudo cat /proc/ide/hdc/model
> TOSHIBA DVD-ROM SD-C2502
> {pts/0}% sudo cat /proc/ide/hdc/identify
> 85c0 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 3031 3030 3230 3839 3338 2020
> 2020 2020 2020 2020 0000 0100 0000 3133
> 3133 2020 2020 544f 5348 4942 4120 4456
> 442d 524f 4d20 5344 2d43 3235 3032 2020
> 2020 2020 2020 2020 2020 2020 2020 0000
> 0000 0f00 0000 0400 0200 0006 0000 0000
> 0000 0000 0000 0000 0000 0000 0007 0007
> 0003 0078 0078 0078 0078 0000 0000 0000
> 0000 0004 0009 0000 0000 0000 0000 0000
> 003c 0013 0000 0000 0000 0000 0000 0000
> 0407 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
>
> -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcJIRR6LMutpd94wRAsqXAJ4w1VBxw02K3T34jKMZwUg9MYGC9ACgxdvC
j1aeeIhuPpqSj2cnOrCiArQ=
=RXGM
-----END PGP SIGNATURE-----
