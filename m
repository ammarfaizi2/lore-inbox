Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSJCSaW>; Thu, 3 Oct 2002 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJCSaW>; Thu, 3 Oct 2002 14:30:22 -0400
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:45506 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261521AbSJCSaV> convert rfc822-to-8bit; Thu, 3 Oct 2002 14:30:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE subsystem issues with 2.4.18/19
Date: Thu, 3 Oct 2002 20:35:46 +0200
User-Agent: KMail/1.4.3
References: <20021004140144.418a8569.Dexter.Filmore@gmx.de>
In-Reply-To: <20021004140144.418a8569.Dexter.Filmore@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210032034.02875.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 14:01, Dexter Filmore wrote:
> Got a motherboard with VIA VT8233 Southbridge (a MSI K7T266 Pro2),
> Slackware 8.1 with a standard kernel (tried .18 as well as .19) patched
> with SGI XFS support, two atapi drives attached with /dev/hdc is Pioneer115
> DVD and /dev/hdd is a Traxdata 24x-writer, both running in scsi emulation.
> Got VIA-support compiled in.
>
> Everythings runs fine: reading DVD, reading CD, writing CD.
> *Apart from*: CD ripping. When trying to read audio CDs, the system locks
> up, can't reproduce the exact error msgs right now, need a running system
> atm. If you like, I'll post them later on.
>
> Tried cdparanoia 9.8-III, cdda2wav - nothing works.
>
> I contacted Vojtech Pavlik, the author of the via82xxx.c code who advised
> me to ask Alan Cox or Andre Hedrick about this, so I thought best write to
> this list.
> Are there any workarounds/patches/voodoo magic for this problem?
>
> Dex


Hi, 

I don't know if it is related to this, but there seems to be general bug in 
the cdrom-ide driver to get the exact size of a CD.
When reading a CD-image using dd, my system also locks up until I eject the CD 
with the cdrom-drive-eject button.

I've already send the following patch to Jens Axboe, but so far he hasn't 
answered yet:

diff -rbBu linux-2.4.19/drivers/ide/ide-cd.c 
linux-2.4.19_mod/drivers/ide/ide-cd.c
--- linux-2.4.19/drivers/ide/ide-cd.c   Sat Aug  3 02:39:44 2002
+++ linux-2.4.19_mod/drivers/ide/ide-cd.c       Mon Sep 30 13:43:35 2002
@@ -1903,7 +1903,7 @@

        stat = cdrom_queue_packet_command(drive, &pc);
        if (stat == 0)
-               *capacity = 1 + be32_to_cpu(capbuf.lba);
+               *capacity = be32_to_cpu(capbuf.lba) - 1;

        return stat;
 }


Please note that I got the correct value of *capacity empirically, since I 
compered several values of the IDE-drive with the ones of my scsi drive. 

Since I don't understand the cdrom_read_capacity() function (would be nice if 
someone could explain me, where "capbuf.lba" gets its values and 
what be32_to_cpu() does), I'm not 100% sure that the patch is correct.


Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut
Abt. Theoretische Chemie
INF 229, 69120 Heidelberg
Tel.: 06221/54-5210
e-mail: 	bernd (dot) schubert (at) pci (dot) uni-heidelberg (dot) de 

