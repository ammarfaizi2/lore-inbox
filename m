Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTJPWVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJPWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 18:21:34 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:50741 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263173AbTJPWVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 18:21:33 -0400
Subject: "reserved" regions in iomem_resource are in the way
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s5vm0dCBblL6yqeA+UT6"
Organization: Linux Networx
Message-Id: <1066342629.4331.64.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 Oct 2003 16:17:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s5vm0dCBblL6yqeA+UT6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"reserved" resources in iomem are in the way when a driver needs to
reserve the same range.

arch/i386/kernel/setup.c:register_memory() queries the BIOS e820 and
marks certain "suggested" ranges as being "reserved".  These resource
ranges then have the IORESOURCE_BUSY flag set and are registered in
iomem_resource using request_resource().  No handle for the "reserved"
resources is kept.

These "reserved" resources, suggested by the BIOS, are not always
correct.  The BIOS may or may not be correct when listing reserved
ranges.  Arguably, the BIOS does things that are convenient for it - not
necessarily convenient for the OS.  This means that the BIOS may mark
incorrect ranges or ranges that a driver may be capable of using.  Once
a range is marked by register_memory() as "reserved" then it becomes
unobtainable by everything else - nothing can register it even if it can
use the range.

The MTD map drivers (drivers/mtd/maps/{ich2rom,amd76xrom}.c) need to
reserve resources for reading and writing the BIOS flash chip (you do
want to update your BIOS from Linux w/o scrounging for a DOS floppy?).=20
Some BIOSes reserve the memory ranges where the FLASH chip is located.=20
This makes it impossible for the map drivers to register the memory
range - even though the map drivers are perfectly capable of using the
memory.

I have experimented with a couple solutions:

1) Don't reserve any of the e820 reserved regions.  I know of BIOSes
that don't mark any reserved regions - even though there are some - and
Linux functions just fine.  This would be as simple as removing the case
for reserved in setup.c.

2) Mark the reserved regions in a way so that a driver that knows better
than the BIOS can claim the regions.  I have a preliminary patch for
this (http://plug.org/~thayne/files/reserve_resources-2.4.20-1.patch).

Fixing the reserved region problem will make it so that MTDs, APICs and
other things can be registered with iomem_resource making things more
correct and complete.



--=-s5vm0dCBblL6yqeA+UT6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/jxjlfsBPTKE6HMkRAprSAJ9q9/s+qHBGQE9bN58f/65IsdEJkACeLh3E
O6y3tuK0Z8SDOx9Jxt2CEF4=
=fbJX
-----END PGP SIGNATURE-----

--=-s5vm0dCBblL6yqeA+UT6--

