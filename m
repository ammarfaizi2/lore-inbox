Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSIESNY>; Thu, 5 Sep 2002 14:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSIESNY>; Thu, 5 Sep 2002 14:13:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14039 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317977AbSIESNW>;
	Thu, 5 Sep 2002 14:13:22 -0400
Subject: BUG: PCI driver 64-bit bar size
From: Todd Inglett <tinglett@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Mares <mj@ucw.cz>
Content-Type: multipart/mixed; boundary="=-M99UD5pmdX1SurErmmA3"
X-Mailer: Evolution/1.0.2-5mdk 
Date: 05 Sep 2002 13:16:48 -0500
Message-Id: <1031249810.12740.72.camel@q.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M99UD5pmdX1SurErmmA3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On a PCI adapter that supports a 64-bit base address register the
current implementation of pci_read_bases() appears to mis-compute the
size of the BAR in certain cases.

The code will compute the size of the BAR using the lower 32-bit dword
as usual, and then if the 64-bit bit mem type flag is set it will
further read the upper dword (on 64-bit arches, anyway).

Now the problem is what it does with the upper dword.  The code shifts
it into the upper 32-bits, recomputes the resource end, and then does a
test of the upper 32-bit dword by writing 0xffffff's.  If *any* bits
come back zero in the upper 32-bit dword the code assumes the upper
dword will set the length.

This computation of length is done quite differently to pci_size() on
32-bit BARs.  In pci_size() the length is computed by looking for the
first one bit after writing ffff's.  This will work even if higher bits
are zero.  For example, if after writing ffff's you get 0x00fff000
(after masking flags), the length is 0x1000 (extent 0xfff).  Reading the
PCI spec I'm not entirely sure if this should even happen, but since the
code simply doesn't compute extent as ~sz I assume there is some adapter
out there that does this.

Now in my case, I have an adapter that insists the upper 32-bits of a
64-bit BAR must be zero (don't ask me why -- doesn't make sense to me
either, but they are indeed hard-wired).  So after plugging in ffff's
into both BARs I effectively get 0x00000000fffff000 (again after masking
flags).  I would expect a length of 0x1000 for this (extent 0xfff), but
Linux computes an extent of 0xffffffffffffffff!  Since the spec says the
length is computed from the first one bit I'll assume this is wrong. 
The code should account for the lower dword as well as the upper.

So my fix is attached.  I chose to use pci_size() in the computation of
the upper dword for consistency.  Perhaps there should be a defined mask
for the upper dword in pci.h (i.e. PCI_BASE_ADDRESS_MEM_64_MASK?) rather
than hard coding 0xffffffff.  The patch is against 2.4.20-pre4.

My code only recomputes the BAR size if the lower 32-bits didn't already
establish the size.  Seems to work fine, but I only have this one test
case.

-todd




--=-M99UD5pmdX1SurErmmA3
Content-Disposition: inline; filename=pci.64bit.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; charset=ISO-8859-1

Index: drivers/pci/pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/pci/pci.c,v
retrieving revision 1.15
diff -u -r1.15 pci.c
--- drivers/pci/pci.c	23 Aug 2002 19:17:49 -0000	1.15
+++ drivers/pci/pci.c	4 Sep 2002 18:59:01 -0000
@@ -1040,13 +1040,15 @@
 			next++;
 #if BITS_PER_LONG =3D=3D 64
 			res->start |=3D ((unsigned long) l) << 32;
-			res->end =3D res->start + sz;
-			pci_write_config_dword(dev, reg+4, ~0);
-			pci_read_config_dword(dev, reg+4, &sz);
-			pci_write_config_dword(dev, reg+4, l);
-			if (~sz)
+			if (sz =3D=3D 0xffffffff) {
+				pci_write_config_dword(dev, reg+4, ~0);
+				pci_read_config_dword(dev, reg+4, &sz);
+				pci_write_config_dword(dev, reg+4, l);
+				sz =3D pci_size(sz, 0xffffffff);
 				res->end =3D res->start + 0xffffffff +
-						(((unsigned long) ~sz) << 32);
+					  (((unsigned long) sz) << 32);
+			}
+			res->end =3D res->start + sz;
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n"=
, dev->slot_name);

--=-M99UD5pmdX1SurErmmA3--

