Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSLCHOZ>; Tue, 3 Dec 2002 02:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSLCHOY>; Tue, 3 Dec 2002 02:14:24 -0500
Received: from h80ad24dd.async.vt.edu ([128.173.36.221]:31104 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265767AbSLCHOW>; Tue, 3 Dec 2002 02:14:22 -0500
Message-Id: <200212030721.gB37LiDL001297@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 breaks pcmcia cards on (at least) Dell Latitude
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1064295360P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Dec 2002 02:21:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1064295360P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-10644450200"

This is a multipart MIME message.

--==_Exmh_-10644450200
Content-Type: text/plain; charset=us-ascii

2.5.49 found my Xircom Ethernet/Modem card and my wireless card just fine.
2.5.50 totally hosed up, threw errors on the Xircom:

PCI: Device 03:00.0 not available because of resource collisions
PCI: Device 03:00.1 not available because of resource collisions

and the pcmcia support wasn't able to get the wireless card to work either.

I got it working by reverting the 2.5.50 change to drivers/pcmcia/cardbus.c
Patch attached, but probably needs reviewing - I can see why you'd want
the if/continue around the device_register() and pci_insert_device() calls,
but don't understand why the if/continue was move higher in the code.

I've also filed this as bug 134 at bugme.osdl.org.

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-10644450200
Content-Type: application/x-patch ; name="pcmcia.patch"
Content-Description: pcmcia.patch
Content-Disposition: attachment; filename="pcmcia.patch"

--- drivers/pcmcia/cardbus.c.dist	2002-12-03 01:49:29.000000000 -0500
+++ drivers/pcmcia/cardbus.c	2002-12-03 01:50:23.000000000 -0500
@@ -283,8 +283,6 @@
 		dev->hdr_type = hdr & 0x7f;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
@@ -302,6 +300,8 @@
 			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
 		}
 
+		if (pci_enable_device(dev))
+			continue;
 		device_register(&dev->dev);
 		pci_insert_device(dev, bus);
 	}

--==_Exmh_-10644450200--


--==_Exmh_-1064295360P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE97FuIcC3lWbTT17ARAnuHAJ4z3FHzz92Za8y5iuMzB6xhxSqCvgCbBaMw
UNs5hXdt3kF292vxU0Q3dUg=
=3Te5
-----END PGP SIGNATURE-----

--==_Exmh_-1064295360P--
