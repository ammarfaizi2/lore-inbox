Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSKTUZ4>; Wed, 20 Nov 2002 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKTUZ4>; Wed, 20 Nov 2002 15:25:56 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:27396 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S262395AbSKTUZy>; Wed, 20 Nov 2002 15:25:54 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB196F@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Miguel S Filipe'" <m3thos@netcabo.pt>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Disk Performance Issues [AMD Viper plus IDE chipset problems.
	 (wrong udma "autodetection")]
Date: Wed, 20 Nov 2002 12:32:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just do the following:

replace 

if ((id->dma_ultra & 0x0020) && (udma_66) && (udma_100)) {
~                speed = XFER_UDMA_5;

with

if (( (id->dma_ultra & 0x0020) || (id->dma_ultra & 0x0010) || (id->dma_ultra
& 0x0008) ) && (udma_66) && (udma_100)) {
~                speed = XFER_UDMA_5;

Note that u should do the same for UDMA 4. In the 2.4.19 driver, I have seen
that UDMA 5 is not supported and so it defaults to UDMA 4. try with and
without the above change to udma 4 but make it for udma 5 ...

Thanks


-----Original Message-----
From: Miguel S Filipe [mailto:m3thos@netcabo.pt]
Sent: Wednesday, November 20, 2002 12:11 PM
To: Manish Lachwani
Cc: 'Alan Cox'; Linux Kernel Mailing List
Subject: Re: Disk Performance Issues [AMD Viper plus IDE chipset
problems. (wrong udma "autodetection")]


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Manish Lachwani wrote:
| I have noticed something with the IDE drivers especially with the Seagate
| drives. The promise driver (eg 20277) detects the UDMA 5 mode correctly.
|
| This is what it does:
|
|         byte ultra_66           = ((id->dma_ultra & 0x0010) ||
|                                    (id->dma_ultra & 0x0008)) ? 1 : 0;
|         byte ultra_100          = ((id->dma_ultra & 0x0020) ||
|                                    (ultra_66)) ? 1 : 0;
|         byte ultra_133          = ((id->dma_ultra & 0x0040) ||
|                                    (ultra_100)) ? 1 : 0;
|
| Now, lets take a PIIX driver
|
| 	 int ultra100            = ((dev->device ==
| PCI_DEVICE_ID_INTEL_82801BA_8) ||
|                                    (dev->device ==
| PCI_DEVICE_ID_INTEL_82801BA_9) ||
|                                    (dev->device ==
| PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
|         int ultra66             = ((ultra100) ||
|                                    (dev->device ==
| PCI_DEVICE_ID_INTEL_82801AA_1) ||
|                                    (dev->device ==
| PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
|
|         if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
|                 speed = XFER_UDMA_5;
|
| where ultra100 and ultra66 is not or'ed with 0x0010 and 0x0008. The final
| check is only with 0x0020. I have found this issues with other IDE drivers
| like amd74xx.c, serverworks.c etc. SO, make the above changes in the
drivers
| and u should see UDMA 5 on those seagate drives on startup ...
|
| Thanks
| Manish
Okay, now, i've been looking in  drivers/ide/amd74xx.c
and
config_chipset_for_dma(ide_drive_t)
has:
byte udma_66            = eighty_ninty_three(drive);
byte udma_100           = ((dev->device==PCI_DEVICE_ID_AMD_VIPER_7411)||

(dev->device==PCI_DEVICE_ID_AMD_VIPER_7441)) ? 1 : 0;

and.. also.. like you've said:
if ((id->dma_ultra & 0x0020) && (udma_66) && (udma_100)) {
~                speed = XFER_UDMA_5;

now.. my lame question is:
should I put:
byte udma66 = (eighty_ninty_three(drive) & 0x0010 ||
	       eighty_ninty_three(drive) & 0x0008) ? 1 : 0;
or eighty_ninty_three (ide_drive_t *drive), or even some other thing be
the one that should be changed for a proper fix. (if this is really the
way to solve it)


One other thing...
in config_chipset_for_dma() right after the declarations we have:

if(udma_100)
	udma_66 = eighty_ninty_three(drive);

is this really needed, since udma_66 is declared and initialized with
that same value?

Sorry if this are lame questions, just trying to learn... :-\

Thanks
Miguel Sousa Filipe

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE92+w8YBjDU2rJcrARAolPAJ4xi1LIpGcNUTUlGY+Qg9ZlzABxSQCcDBzl
Q/y4q7IiE0O5HllvTD877ZU=
=RBMC
-----END PGP SIGNATURE-----
