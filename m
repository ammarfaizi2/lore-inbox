Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUFQCeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUFQCeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 22:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFQCeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 22:34:36 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:24593 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S264625AbUFQCdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 22:33:50 -0400
Date: Wed, 16 Jun 2004 21:33:43 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040617023343.GA31201@dbz.icequake.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040613171701.1750.70973.Mailman@linux.us.dell.com> <20040614044433.GD27622@dbz.icequake.net> <20040615140659.GC13847@logos.cnet> <20040616115031.GG17330@dbz.icequake.net> <20040616172421.GD8703@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20040616172421.GD8703@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The Netmos patch is working fine on my Netmos 9815 as far as I can tell.

I also attached a patch which addresses some things:
1) Wrong reporting of device and vendors ids.. I have no clue what the
original code was even trying to do
2) Allows PCI parallel port to share an IRQ if possible.  In limited testing
this seems to be ok, but maybe the interrupt handler was not written for
sharing.  Someone else will need to ok this.
3) Adds a prod to get the user to specify an irq if one was probed but
none specified, so if DMA is not being enabled, there is an outward looking
cause for it.
4) Documentation clarification for Documentation/parport.txt

Ryan

On Wed, Jun 16, 2004 at 02:24:22PM -0300, Marcelo Tosatti wrote:
>=20
> Ryan,=20
>=20
> I'm going to release 2.4.27-pre6 in an hour or so with the NetMos patch i=
ncluded.
>=20
> Can you please test it with your card?
>=20
> TI
>=20
>=20
> On Wed, Jun 16, 2004 at 06:50:31AM -0500, Ryan Underwood wrote:
> >=20
> > On Tue, Jun 15, 2004 at 11:06:59AM -0300, Marcelo Tosatti wrote:
> > > > > Willy
> > > >=20
> > > > It's not my patch or my site.  I also wasn't the one who made previ=
ous
> > > > requests for it.  However, I have noticed that multiple requests for
> > > > inclusion were ignored without any reason, so I figured it was just=
 lost
> > > > in the shadow of more important things till now.  It has already be=
en
> > > > included in 2.6 for a long time, btw.
> > >=20
> > > Ryan,
> > >=20
> > > Dont get Willy wrong -- your help bugging the maintainers is much app=
reciated.
> > >=20
> > > Are you sure it has been included in v2.6? It doesnt seem to be the c=
ase last
> > > time I checked v2.6.7-rc3.
> >=20
> > No, I don't think it has.  I remember seeing a patch from Tim Waugh
> > which made me think it had been included, but I guess not, from
> > examining 2.6.7-rc3.
> >=20
> > --=20
> > Ryan Underwood, <nemesis@icequake.net>
>=20
>=20

--=20
Ryan Underwood, <nemesis@icequake.net>

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="parport.diff"
Content-Transfer-Encoding: quoted-printable

--- /tmp/linux-2.4.26/drivers/char/parport_serial.c	2004-06-16 19:56:18.000=
000000 -0500
+++ drivers/char/parport_serial.c	2004-06-16 20:12:59.000000000 -0500
@@ -334,9 +334,9 @@
 		/* TODO: test if sharing interrupts works */
 		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
 			"I/O at %#lx(%#lx)\n",
-			parport_serial_pci_tbl[i].vendor,
-			parport_serial_pci_tbl[i].device, io_lo, io_hi);
-		port =3D parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
+			dev->vendor,
+			dev->device, io_lo, io_hi);
+		port =3D parport_pc_probe_port (io_lo, io_hi, dev->irq,
 					      PARPORT_DMA_NONE, dev);
 		if (port) {
 			priv->port[priv->num_par++] =3D port;
--- /tmp/linux-2.4.26/drivers/parport/parport_pc.c	2004-06-16 19:56:19.0000=
00000 -0500
+++ drivers/parport/parport_pc.c	2004-06-16 21:20:09.000000000 -0500
@@ -2343,8 +2343,9 @@
 	printk ("(,...)");
 #endif /* CONFIG_PARPORT_1284 */
 	printk("]\n");
-	if (probedirq !=3D PARPORT_IRQ_NONE)=20
-		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
+	if (probedirq !=3D PARPORT_IRQ_NONE) {
+		printk(KERN_INFO "%s: irq %d ignored (try irq=3Dauto or irq=3D%d)\n", p-=
>name, probedirq, probedirq);
+	}
 	parport_proc_register(p);
=20
 	request_region (p->base, 3, p->name);
@@ -2355,7 +2356,7 @@
=20
 	if (p->irq !=3D PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
-				 0, p->name, p)) {
+				 ((dev !=3D NULL)? SA_SHIRQ : 0), p->name, p)) {
 			printk (KERN_WARNING "%s: irq %d in use, "
 				"resorting to polled operation\n",
 				p->name, p->irq);
@@ -2890,9 +2891,9 @@
 		/* TODO: test if sharing interrupts works */
 		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
 			"I/O at %#lx(%#lx)\n",
-			parport_pc_pci_tbl[i + last_sio].vendor,
-			parport_pc_pci_tbl[i + last_sio].device, io_lo, io_hi);
-		if (parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
+			dev->vendor,
+			dev->device, io_lo, io_hi);
+		if (parport_pc_probe_port (io_lo, io_hi, dev->irq,
 					   PARPORT_DMA_NONE, dev))
 			count++;
 	}
--- /tmp/linux-2.4.26/Documentation/parport.txt	2001-11-09 16:30:55.0000000=
00 -0600
+++ /usr/src/linux/Documentation/parport.txt	2004-06-16 21:30:03.000000000 =
-0500
@@ -33,7 +33,9 @@
=20
 PCI parallel I/O card support comes from parport_pc.  Base I/O
 addresses should not be specified for supported PCI cards since they
-are automatically detected.
+are automatically detected.  If you have a multi PCI I/O card, try
+to use the parport_serial module if parport_pc does not catch
+all the ports by itself.
=20
=20
 KMod

--KsGdsel6WgEHnImy--

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0QMHIonHnh+67jkRAuYXAKCS2x5xn0Ug5+s84FMotR/gzcFqKQCfbziy
DCTmJ0WVz0mCSZSMZPGnT+U=
=+eQk
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
