Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRH0Xon>; Mon, 27 Aug 2001 19:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRH0Xod>; Mon, 27 Aug 2001 19:44:33 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:24601 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269778AbRH0XoY>; Mon, 27 Aug 2001 19:44:24 -0400
Date: Tue, 28 Aug 2001 01:44:40 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Pekka Pietikainen <pp@netppl.fi>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] disableapic option
Message-ID: <20010828014440.L12566@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Pekka Pietikainen <pp@netppl.fi>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010827182204.A25212@devserv.devel.redhat.com> <20010828014211.A29068@netppl.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <20010828014211.A29068@netppl.fi>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Aaj1jBvBEV7KRjLi
Content-Type: multipart/mixed; boundary="RNGrj7vazCqBHNw7"
Content-Disposition: inline


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pekka, Linus, Alan,

On Tue, Aug 28, 2001 at 01:42:11AM +0300, Pekka Pietikainen wrote:
> Doesn't VA use one of those Intel boards which have the problem
> with theis BIOS, which is seen as a hang with the adaptec driver?
>=20
> Tried the same work-around? (enabling the APIC)

Here's a patch that allows you to compile the kernel with APIC enabled
always. Some machines need it, but others barf, when they find out that
there is an MP table and an IOAPIC but no APIC on the CPU is found.
(Plug a K6 in a dual Pentium board, e.g.)

Then you may pass the disableapic boot parameter, so you bypass APIC setup
completely and the APIC compiled kernel works like compiled without.
(For people who compile their own kernels, this is irrelevant, except for
 testing. That's not the majority of Linux users anymore, though.)

Another possibility might be to make apic.c:221 fail gracefully instead of
BUG(), BTW.

Linus, Alan, please apply to your trees!

In theory, the compile time option could be removed now, but some people
probably want to be able to save a few bytes.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Description: disableapic-249.diff
Content-Disposition: attachment; filename="50_disableapic.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-244.compile/arch/i386/kernel/io_apic.c.orig	Mon Apr 30 17:12:43 2=
001
+++ linux-244.compile/arch/i386/kernel/io_apic.c	Fri May 11 17:44:37 2001
@@ -182,6 +182,7 @@
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
 int skip_ioapic_setup;
+int disable_apic;
=20
 static int __init ioapic_setup(char *str)
 {
@@ -191,6 +192,15 @@
=20
 __setup("noapic", ioapic_setup);
=20
+static int __init disable_apic_setup(char *str)
+{
+	skip_ioapic_setup =3D 1;
+	disable_apic =3D 1;
+	return 1;
+}
+
+__setup("disableapic", disable_apic_setup);
+
 static int __init ioapic_pirq_setup(char *str)
 {
 	int i, max;
@@ -1605,7 +1615,7 @@
  */
 void IO_APIC_init_uniprocessor (void)
 {
-	if (!smp_found_config)
+	if (!smp_found_config || disable_apic)
 		return;
 	connect_bsp_APIC();
 	setup_local_APIC();

--RNGrj7vazCqBHNw7--

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ittoxmLh6hyYd04RAqTaAKDTsbNBSy/c3uxvnBxAkZEv6s3MqwCgvavL
0kf6ano4OYZCG/Fe++//kAo=
=hAx6
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
