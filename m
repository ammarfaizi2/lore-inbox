Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJIA1M>; Tue, 8 Oct 2002 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSJIA1M>; Tue, 8 Oct 2002 20:27:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26284 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261368AbSJIA1K>;
	Tue, 8 Oct 2002 20:27:10 -0400
Date: Tue, 8 Oct 2002 17:35:17 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Maciej Babinski <maciej@imsa.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 oops on reboot
In-Reply-To: <20021008192623.A1314@imsa.edu>
Message-ID: <Pine.LNX.4.44.0210081734060.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Oct 2002, Maciej Babinski wrote:

> I got this oops when rebooting my fresh 2.5.41 build. reboot failed, and
> there were no other processes running, so this is hand copied.
> 
> 
> ksymoops 2.4.6 on i586 2.4.19.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.5.41/ (specified)
>      -m /kernel/System.map-2.5.41 (specified)
> 
> No modules in ksyms, skipping objects
> CPU:    0
> EIP:    0060:[<c015d448>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: c0205fb7   ebx: 0000005c     ecx: 0000005c       edx: 00000077
> esi: 00000000   edi: c110ece8     ebp: c110ec00       esp: c5475e18
> ds: 0068 es: 0068 ss: 0068
> Stack: c110ec4c c022cc7c c13c3528 c0181523 c110ece8 c0205e7c c110ec4c c110ec4c
>        00000000 c015b863 c110ec4c c022cc7c c110ec00 c110ec00 c02b7654 00000000
>        c015c22b c110ec00 c02b7700 c01b025b c110ec00 c02b7700 00000001 c01ad155
> Call Trace: [<c0181423>] [<c015b863>] [<c015c22b>] [<c01b025b>] [<c01ad155>] [c011ed6c>] [<c011f1b8>] [<c01c64e8>] [<c01c1b6c>] [<c01f05b0>] [<c01f0585>] [<c012b323>] [<c01b9964>] [<c012b323>] [<c014a2ec>] [<c0138bf5>] [<c0137097>] [<c0137105>] [<c0107357>]
> Code: ff 4e 5c 0f 88 5f 02 00 00 8b 5c 24 14 53 8b 4f 04 51 e8 61
> 
> 
> >>EIP; c015d448 <driverfs_remove_file+28/90>   <=====

This has been reported a couple of times, and I posted a patch yesterday 
that should fix this. Could you try this (must more narrow-focused) patch 
and let me know if it fixes the problem?

Thanks

	-pat

ChangeSet@1.696.19.1, 2002-10-07 09:52:31-07:00, mochel@osdl.org
  IDE: only register drives that are present with the driver core.

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
+++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
@@ -986,8 +986,8 @@
 			 "%s","IDE Drive");
 		disk->disk_dev.parent = &hwif->gendev;
 		disk->disk_dev.bus = &ide_bus_type;
-		device_register(&disk->disk_dev);
-
+		if (hwif->drives[unit].present)
+			device_register(&disk->disk_dev);
 		hwif->drives[unit].disk = disk;
 	}
 

