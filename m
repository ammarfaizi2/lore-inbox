Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSIETJO>; Thu, 5 Sep 2002 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSIETJO>; Thu, 5 Sep 2002 15:09:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40407 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318123AbSIETJL>; Thu, 5 Sep 2002 15:09:11 -0400
Date: Thu, 5 Sep 2002 21:13:42 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jack_Hammer@adaptec.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in drivers/scsi/ips.c 
Message-ID: <Pine.NEB.4.44.0209052109320.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

your recent "ServeRAID driver update" patch to Linux 2.4.20-pre removed
the __devexit_p from the pointer to the __devexit function
ips_remove_device and added two other pointers to this function that don't
use __devexit_p. This results in the following compile error when
compiling the driver statically into a kernel without support for
hot-plugging:

<--  snip  -->

...
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o(.data+0xc3f4): undefined reference to `local
symbols in discarded section .text.exit'
drivers/scsi/scsidrv.o(.data+0xc434): undefined reference to `local
symbols in discarded section .text.exit'
drivers/scsi/scsidrv.o(.data+0xc474): undefined reference to `local
symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

<--  snip  -->


The fix is simple:

--- drivers/scsi/ips.c.old	2002-09-05 19:38:13.000000000 +0200
+++ drivers/scsi/ips.c	2002-09-05 19:38:57.000000000 +0200
@@ -305,21 +305,21 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };

 #endif


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

