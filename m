Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUFHQSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUFHQSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUFHQSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:18:00 -0400
Received: from lists.us.dell.com ([143.166.224.162]:31129 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265236AbUFHQRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:17:55 -0400
Date: Tue, 8 Jun 2004 11:17:45 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040608161745.GA13973@lists.us.dell.com>
References: <20040601160457.GA11437@lists.us.dell.com> <20040601162058.GA20983@infradead.org> <20040601163100.GC1265@redhat.com> <20040608160027.GA13214@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20040608160027.GA13214@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2004 at 11:00:27AM -0500, Matt Domsch wrote:
> On Tue, Jun 01, 2004 at 05:31:00PM +0100, Dave Jones wrote:
> > On Tue, Jun 01, 2004 at 05:20:58PM +0100, Christoph Hellwig wrote:
> >=20
> >  > > The patch below checks for a valid cap_ptr prior to printing the
> >  > > message, now at KERN_WARNING level (it's not really an error, is i=
t?)
> >  >=20
> >  > The real problem is that agpgart doesn't properly fill in the pci_id
> >  > table but claims all devices and then does it's own probing internal=
ly.
> >  > This also breaks hotplug in a funny way.
> >=20
> > This is fixed in agpgart-bk / -mm.  Andi went through all the drivers
> > adding their id's.  Should be going to Linus soon.
> >=20
> > 		Dave
>=20
> FWIW, sworks-agp.c has the same issue in mainline yet today.
> agpgart: Unsupported Serverworks chipset (device id: 0011)=20
> agpgart: Unsupported Serverworks chipset (device id: 0201)=20
>=20
> I'll look at -mm to verify it's fixed there.

agpgart-bk and -mm didn't add proper PCI ID lists to sworks-agp.c (yet
I assume).  Patch below does the same for this as I submitted for
Intel previously.  It only prints a warning now if the device is AGP
capable but unrecognized.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D drivers/char/agp/sworks-agp.c 1.41 vs edited =3D=3D=3D=3D=3D
--- 1.41/drivers/char/agp/sworks-agp.c	Tue Jun  1 02:50:11 2004
+++ edited/drivers/char/agp/sworks-agp.c	Tue Jun  8 11:13:38 2004
@@ -447,6 +447,7 @@
 	struct agp_bridge_data *bridge;
 	struct pci_dev *bridge_dev;
 	u32 temp, temp2;
+	u8 cap_ptr =3D 0;
=20
 	/* Everything is on func 1 here so we are hardcoding function one */
 	bridge_dev =3D pci_find_slot((unsigned int)pdev->bus->number,
@@ -457,6 +458,8 @@
 		return -ENODEV;
 	}
=20
+	cap_ptr =3D pci_find_capability(pdev, PCI_CAP_ID_AGP);
+
 	switch (pdev->device) {
 	case 0x0006:
 		/* ServerWorks CNB20HE
@@ -470,8 +473,9 @@
 		break;
=20
 	default:
-		printk(KERN_ERR PFX "Unsupported Serverworks chipset "
-				"(device id: %04x)\n", pdev->device);
+		if (cap_ptr)
+			printk(KERN_WARNING PFX "Unsupported Serverworks chipset "
+			       "(device id: %04x)\n", pdev->device);
 		return -ENODEV;
 	}
=20

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxeapIavu95Lw/AkRApMmAJ4i4to9+E5RJQSxACqfrc/LO7lAEQCfQleJ
FrV0s1OHE/ZC2PKuY8gteY4=
=qDQQ
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
