Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSIFLaO>; Fri, 6 Sep 2002 07:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSIFLaO>; Fri, 6 Sep 2002 07:30:14 -0400
Received: from magic.adaptec.com ([208.236.45.80]:40643 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S318460AbSIFLaM>; Fri, 6 Sep 2002 07:30:12 -0400
Message-ID: <A3B9245C291EEF4785A24A1DBE8D852BDA35@rtpexc01.adaptec.com>
From: "Hammer, Jack" <Jack_Hammer@adaptec.com>
To: "'Adrian Bunk'" <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, "Jeffery, David" <David_Jeffery@adaptec.com>
Subject: RE: [patch] fix .text.exit error in drivers/scsi/ips.c 
Date: Fri, 6 Sep 2002 07:32:16 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian ,

Thanks for the info.  We have already been made aware of this mistake and
have corrected this in our current development code which just entered test
last week.  As soon as we get a couple weeks of successful testing under our
belts, we will be updating Linus with a new ips driver for 2.5.   In the
meantime, if anyone needs this and can't wait for the new driver to come
out, your patch should work just fine.  

Thanks again for keeping us posted.

Jack

-----Original Message-----
From: Adrian Bunk [mailto:bunk@fs.tum.de]
Sent: Thursday, September 05, 2002 3:14 PM
To: Jack_Hammer@adaptec.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in drivers/scsi/ips.c 


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
