Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbQLEJf1>; Tue, 5 Dec 2000 04:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbQLEJfR>; Tue, 5 Dec 2000 04:35:17 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:58322 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130119AbQLEJfK>; Tue, 5 Dec 2000 04:35:10 -0500
Message-ID: <3A2CB090.7DB94AA6@uow.edu.au>
Date: Tue, 05 Dec 2000 20:08:32 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2.2] 3c556B support for 3c59x.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

could we please slot this into 2.2.18?  Apologies for the timing, but
it can't break anything.

It adds support for the 3c556B Mini-PCI NIC which is appearing
in new IBM Thinkpad A10's and A20's.  This device is also appearing
in HP Omnibooks.  The 2.4 kernel already caters for these devices.

Someone has been playing with the EEPROM handling on this NIC and
we still don't properly support PM resumes - the workaround is
to add ifdown/rmmod/modprobe/ifup to the PM resume script.

I'm getting a sudden influx of email over the 3c556B so I'd recommend
that Linux distributors include this patch in their 2.2 offerings.

If there are any friends@ibm.com listening I would appreciate it if
they could ring around and see if they can hunt down a description
of the EEPROM handling on the Thinkpad's 3c556B Mini-PCI NIC.  Thanks.
(friends@hp.com as well).  Enquiries to 3com haven't worked out - some
folks there tried, but it's a big corp.


Other happenings on the 3c59x front: 3Com are now shipping a device
marked "3c905CX" which appears to be a 3c905C plus random breakage.
3Com's own driver GPL Linux doesn't work with it.

We have determined that the timeout value in the 2.4 driver's
wait_for_completion() function need to be increased vastly (to
2,000,000) to make the driver work.  This is because the
RxReset command is now taking a loooong time to complete.  This
only affects initialisation, so it's not as bad as it sounds. With this
change the driver does apparently work, but there are also questions
over the assignment of transceiver devices.  I need to go shopping
to get to the bottom of this.




--- linux-2.2.18pre24/drivers/net/3c59x.c	Tue Dec  5 19:29:59 2000
+++ linux-akpm/drivers/net/3c59x.c	Tue Dec  5 19:41:06 2000
@@ -60,11 +60,14 @@
     - In vortex_open(), set vp->tx_full to zero (else we get errors if the device was
       closed with a full Tx ring).
 
+	15Sep00 <2.2.18-pre3> andrewm
+	- Added support for the 3c556B Laptop Hurricane (Louis Gerbarg)
+
     - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.2 for more details.
 */
 
 static char version[] =
-"3c59x.c 16Aug00 Donald Becker and others http://www.scyld.com/network/vortex.html\n";
+"3c59x.c 15Sep00 Donald Becker and others http://www.scyld.com/network/vortex.html\n";
 
 /* "Knobs" that adjust features and parameters. */
 /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
@@ -336,6 +339,8 @@
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE, 128, vortex_probe1},
 	{"3c556 10/100 Mini PCI Adapter",	0x10B7, 0x6055, 0xffff,
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_CB_FNS, 128, vortex_probe1},
+	{"3c556B Laptop Hurricane",	0x10B7, 0x6056, 0xffff,
+	 PCI_USES_IO|PCI_USES_MASTER, IS_TORNADO|HAS_CB_FNS, 128, vortex_probe1},
 	{"3c575 Boomerang CardBus",		0x10B7, 0x5057, 0xffff,
 	 PCI_USES_IO|PCI_USES_MASTER, IS_BOOMERANG|HAS_MII, 64, vortex_probe1},
 	{"3CCFE575 Cyclone CardBus",	0x10B7, 0x5157, 0xffff,
@@ -932,6 +937,8 @@
 #else
 		if (pci_tbl[chip_idx].device_id == 0x6055) {
 			outw(0x230 + i, ioaddr + Wn0EepromCmd);
+		} else if (pci_tbl[chip_idx].device_id == 0x6056) {
+			outw(EEPROM_Read + 0x30 + i, ioaddr + Wn0EepromCmd);
 		} else {
 			outw(EEPROM_Read + i, ioaddr + Wn0EepromCmd);
 		}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
