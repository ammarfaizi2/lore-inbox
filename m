Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272319AbTGYUke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTGYUk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:40:26 -0400
Received: from coruscant.franken.de ([193.174.159.226]:45202 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272319AbTGYUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:35 -0400
Date: Fri, 25 Jul 2003 22:51:06 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter refcount fix
Message-ID: <20030725205106.GN3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GSe1yqLCWMTKXEPF"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GSe1yqLCWMTKXEPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 7th of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.


Author: Patrick McHardy <kaber@trash.net>

Drop reference to conntrack after removing confirmed expectation


Please apply,


diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.4.22-pre7-plain/net/ipv4/ne=
tfilter/ip_conntrack_core.c linux-2.4.22-pre7-nfsubm/net/ipv4/netfilter/ip_=
conntrack_core.c
--- linux-2.4.22-pre7-plain/net/ipv4/netfilter/ip_conntrack_core.c	2003-07-=
19 10:12:19.000000000 +0200
+++ linux-2.4.22-pre7-nfsubm/net/ipv4/netfilter/ip_conntrack_core.c	2003-07=
-19 10:37:17.000000000 +0200
@@ -257,7 +257,7 @@
 }
=20
 /* delete all unconfirmed expectations for this conntrack */
-static void remove_expectations(struct ip_conntrack *ct)
+static void remove_expectations(struct ip_conntrack *ct, int drop_refcount)
 {
 	struct list_head *exp_entry, *next;
 	struct ip_conntrack_expect *exp;
@@ -272,8 +272,11 @@
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sib=
ling, ct);
-			/* Indicate that this expectations parent is dead */
-			exp->expectant =3D NULL;
+			if (drop_refcount) {
+				/* Indicate that this expectations parent is dead */
+				ip_conntrack_put(exp->expectant);
+				exp->expectant =3D NULL;
+			}
 			continue;
 		}
=20
@@ -298,7 +301,7 @@
 		    &ct->tuplehash[IP_CT_DIR_REPLY]);
=20
 	/* Destroy all un-established, pending expectations */
-	remove_expectations(ct);
+	remove_expectations(ct, 1);
 }
=20
 static void
@@ -1140,7 +1143,7 @@
 {
 	if (i->ctrack->helper =3D=3D me) {
 		/* Get rid of any expected. */
-		remove_expectations(i->ctrack);
+		remove_expectations(i->ctrack, 0);
 		/* And *then* set helper to NULL */
 		i->ctrack->helper =3D NULL;
 	}
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--GSe1yqLCWMTKXEPF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZg6XaXGVTD0i/8RAi7eAJ4kr82J78rXzj02FD48MnPz/VYhXwCfY0w+
ku3gA3mH8XA29580TNA7m5M=
=RQOt
-----END PGP SIGNATURE-----

--GSe1yqLCWMTKXEPF--
