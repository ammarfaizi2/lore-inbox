Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272320AbTGYUnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272329AbTGYUn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:43:27 -0400
Received: from coruscant.franken.de ([193.174.159.226]:54162 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272320AbTGYUj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:39:58 -0400
Date: Fri, 25 Jul 2003 22:52:30 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] netfilter ipt_recent Configure.help fix
Message-ID: <20030725205229.GD3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YMoJtYXQBeUqimUz"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YMoJtYXQBeUqimUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 5th of my 2.6 merge of recent bugfixes (all tested against
2.6.0-test7).  You might need to apply them incrementally (didn't test
it in a different order).

Author: Adrian Bunk <bunk@fs.tum.de>, Harald Welte <laforge@netfilter.org>

Add the missing Configure.help entry for ipt_recent

Please apply,

diff -Nru --exclude .depend --exclude '*.o' --exclude '*.ko' --exclude '*.v=
er' --exclude '.*.flags' --exclude '*.orig' --exclude '*.rej' --exclude '*.=
cmd' --exclude '*.mod.c' --exclude '*~' linux-2.6.0-test1-nftest4/net/ipv4/=
netfilter/ip_conntrack_core.c linux-2.6.0-test1-nftest5/net/ipv4/netfilter/=
ip_conntrack_core.c
--- linux-2.6.0-test1-nftest4/net/ipv4/netfilter/ip_conntrack_core.c	2003-0=
7-14 05:28:52.000000000 +0200
+++ linux-2.6.0-test1-nftest5/net/ipv4/netfilter/ip_conntrack_core.c	2003-0=
7-19 16:36:58.000000000 +0200
@@ -251,7 +251,7 @@
 }
=20
 /* delete all unconfirmed expectations for this conntrack */
-static void remove_expectations(struct ip_conntrack *ct)
+static void remove_expectations(struct ip_conntrack *ct, int drop_refcount)
 {
 	struct list_head *exp_entry, *next;
 	struct ip_conntrack_expect *exp;
@@ -266,8 +266,11 @@
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
@@ -292,7 +295,7 @@
 		    &ct->tuplehash[IP_CT_DIR_REPLY]);
=20
 	/* Destroy all un-established, pending expectations */
-	remove_expectations(ct);
+	remove_expectations(ct, 1);
 }
=20
 static void
@@ -1117,7 +1120,7 @@
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

--YMoJtYXQBeUqimUz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZiNXaXGVTD0i/8RAlyUAJ9HjL7I19kkSoG9ogXYvZQGuELUygCgrgO+
WaUKe7E3vLw3ogF66JxN7jo=
=tk62
-----END PGP SIGNATURE-----

--YMoJtYXQBeUqimUz--
