Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUFAQLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUFAQLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbUFAQIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:08:02 -0400
Received: from linux.us.dell.com ([143.166.224.162]:61905 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265094AbUFAQFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:05:03 -0400
Date: Tue, 1 Jun 2004 11:04:57 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: intel-agp: skip non-AGP devices
Message-ID: <20040601160457.GA11437@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dave,=20

On our PowerEdge 2600 system, which has an Intel E7501 Memroy
Controller Hub, the intel-agp probe code is reporting, at KERN_ERR no less:

agpgart: Unsupported Intel chipset (device id 254c)

Now, of course it says this, as this device does not present itself as
AGP-capable:

00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [1105]


agp_intel_probe()  calls pci_find_capability(PCI_CAP_ID_AGP)
but doesn't check the return value (should be zero in this case) prior
to moving into the switch.


The patch below checks for a valid cap_ptr prior to printing the
message, now at KERN_WARNING level (it's not really an error, is it?)

Thoughts?

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- intel-agp.c.orig	Tue Jun  1 10:45:59 2004
+++ intel-agp.c	Tue Jun  1 11:02:56 2004
@@ -1382,8 +1382,9 @@ static int __devinit agp_intel_probe(str
 		name =3D "E7205";
 		break;
 	default:
-		printk(KERN_ERR PFX "Unsupported Intel chipset (device id: %04x)\n",
-			    pdev->device);
+		if (cap_ptr)
+			printk(KERN_WARNING PFX "Unsupported Intel chipset (device id: %04x)\n",
+			       pdev->device);
 		return -ENODEV;
 	};
=20

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAvKkpIavu95Lw/AkRAhgbAJ4jaZaR1Fp7McB0X/p5ZB8yUZWq5QCfUBwA
BNRSV8O/IcONmZ/o6M1tTZ0=
=4t4z
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
