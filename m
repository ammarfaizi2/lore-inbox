Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272317AbTGYVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272336AbTGYUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:41:10 -0400
Received: from coruscant.franken.de ([193.174.159.226]:42898 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272317AbTGYUi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:28 -0400
Date: Fri, 25 Jul 2003 22:50:58 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter ipt_helper locking fix
Message-ID: <20030725205058.GK3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IQcO73Bte+RllADJ"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IQcO73Bte+RllADJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 4th of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.

Author: Patrick McHardy <kaber@trash.net>

Fix locking of ipt_helper.

Please apply,

diff -Nru a/net/ipv4/netfilter/ipt_helper.c b/net/ipv4/netfilter/ipt_helper=
=2Ec
--- a/net/ipv4/netfilter/ipt_helper.c	Sat Jul 12 04:57:37 2003
+++ b/net/ipv4/netfilter/ipt_helper.c	Sat Jul 12 04:57:37 2003
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
+#include <linux/netfilter_ipv4/ip_conntrack_core.h>
 #include <linux/netfilter_ipv4/ip_conntrack_helper.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_helper.h>
@@ -36,6 +37,7 @@
 	struct ip_conntrack_expect *exp;
 	struct ip_conntrack *ct;
 	enum ip_conntrack_info ctinfo;
+	int ret =3D 0;
 =09
 	ct =3D ip_conntrack_get((struct sk_buff *)skb, &ctinfo);
 	if (!ct) {
@@ -49,23 +51,27 @@
 	}
=20
 	exp =3D ct->master;
+	READ_LOCK(&ip_conntrack_lock);
 	if (!exp->expectant) {
 		DEBUGP("ipt_helper: expectation %p without expectant !?!\n",=20
 			exp);
-		return 0;
+		goto out_unlock;
 	}
=20
 	if (!exp->expectant->helper) {
 		DEBUGP("ipt_helper: master ct %p has no helper\n",=20
 			exp->expectant);
-		return 0;
+		goto out_unlock;
 	}
=20
 	DEBUGP("master's name =3D %s , info->name =3D %s\n",=20
 		exp->expectant->helper->name, info->name);
=20
-	return !strncmp(exp->expectant->helper->name, info->name,=20
-			strlen(exp->expectant->helper->name)) ^ info->invert;
+	ret =3D !strncmp(exp->expectant->helper->name, info->name,=20
+	               strlen(exp->expectant->helper->name)) ^ info->invert;
+out_unlock:
+	READ_UNLOCK(&ip_conntrack_lock);
+	return ret;
 }
=20
 static int check(const char *tablename,
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--IQcO73Bte+RllADJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZgyXaXGVTD0i/8RAsCTAJ43d9Cpk6y/Z21KkrTg3HlmonSHQwCgsyNh
/FBTgvynP4UQ7mNw4UjooK8=
=aGnj
-----END PGP SIGNATURE-----

--IQcO73Bte+RllADJ--
