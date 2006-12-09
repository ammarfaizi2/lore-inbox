Return-Path: <linux-kernel-owner+w=401wt.eu-S1030642AbWLIMEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWLIMEF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWLIMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:04:05 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:54317 "EHLO
	bizon.gios.gov.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967817AbWLIMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:04:01 -0500
Date: Sat, 9 Dec 2006 13:03:56 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
In-Reply-To: <20061129153921.1c27e19d@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612091259160.17215@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
 <20061125160342.4e9ddef0@localhost.localdomain> <Pine.LNX.4.64.0611251718210.2557@bizon.gios.gov.pl>
 <20061129153921.1c27e19d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-2206153-1165665836=:17215"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-2206153-1165665836=:17215
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 29 Nov 2006, Alan wrote:

> Does this fix it
>
> --- drivers/ata/pata_via.c~=092006-11-29 15:16:10.961387472 +0000
> +++ drivers/ata/pata_via.c=092006-11-29 15:17:08.784597008 +0000
> @@ -60,7 +60,7 @@
> #include <linux/libata.h>
>
> #define DRV_NAME "pata_via"
> -#define DRV_VERSION "0.2.0"
> +#define DRV_VERSION "0.2.1"
>
> /*
>  *=09The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
> @@ -159,10 +159,13 @@
> =09=09=09return -ENOENT;
> =09}
>
> -=09if ((config->flags & VIA_UDMA) >=3D VIA_UDMA_66)
> +=09if ((config->flags & VIA_UDMA) >=3D VIA_UDMA_100)
> =09=09ap->cbl =3D via_cable_detect(ap);
> -=09else
> +=09/* The UDMA66 series has no cable detect so do drive side detect */
> +=09else if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
> =09=09ap->cbl =3D ATA_CBL_PATA40;
> +
> +
> =09return ata_std_prereset(ap);
> }

Yes and no - UDMA66 gets enabled, but with both 80-wire and 40-wire=20
cables.

* With 80-wire cable:
pata_via 0000:00:07.1: version 0.1.14
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : pata_via
ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/66
scsi1 : pata_via
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MPF3204A 0031 PQ: 0 ANSI: =
5
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 0:0:0:0: Attached scsi disk sda
(...)

* With 40-wire cable:
pata_via 0000:00:07.1: version 0.1.14
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : pata_via
ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/66
scsi1 : pata_via
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MPF3204A 0031 PQ: 0 ANSI: =
5
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x10 stat 0x51 err 0x84 (ATA bus error)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x10 stat 0x51 err 0x84 (ATA bus error)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x10 stat 0x51 err 0x84 (ATA bus error)
ata1: soft resetting port
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: limiting speed to UDMA/44
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x10 stat 0x51 err 0x84 (ATA bus error)
ata1: soft resetting port
ata1.00: configured for UDMA/44
ata1: EH complete
  sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 0:0:0:0: Attached scsi disk sda



Besr regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-2206153-1165665836=:17215--
