Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272361AbTGYU6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272343AbTGYUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:43:52 -0400
Received: from coruscant.franken.de ([193.174.159.226]:52626 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272326AbTGYUjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:39:51 -0400
Date: Fri, 25 Jul 2003 22:52:22 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] netfilter ip_conntrack_irc parser fix
Message-ID: <20030725205222.GB3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B1+FeH9/zg1Fgdnk"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B1+FeH9/zg1Fgdnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 3rd of my 2.6 merge of the recent bugfixes (all tested
against 2.4.22-pre7).  You might need to apply them incrementally
(didn't test it in a different order).  You will receive 2.6 merges of
those patches soon.

Author: Harald Welte <laforge@netfilter.org>

This patch fixes a bug in the IRC DCC command parser of ip_conntrack_irc

Please apply,

--- linux-2.6.0-test1/net/ipv4/netfilter/ip_conntrack_irc.c	2003-07-14 05:3=
6:48.000000000 +0200
+++ linux-2.6.0-test1-nftest2/net/ipv4/netfilter/ip_conntrack_irc.c	2003-07=
-19 11:41:49.000000000 +0200
@@ -54,7 +54,7 @@
 #endif
=20
 static char *dccprotos[] =3D { "SEND ", "CHAT ", "MOVE ", "TSEND ", "SCHAT=
 " };
-#define MAXMATCHLEN	6
+#define MINMATCHLEN	5
=20
 DECLARE_LOCK(ip_irc_lock);
 struct module *ip_conntrack_irc =3D THIS_MODULE;
@@ -87,9 +87,11 @@
 	*ip =3D simple_strtoul(data, &data, 10);
=20
 	/* skip blanks between ip and port */
-	while (*data =3D=3D ' ')
+	while (*data =3D=3D ' ') {
+		if (data >=3D data_end)=20
+			return -1;
 		data++;
-
+	}
=20
 	*port =3D simple_strtoul(data, &data, 10);
 	*ad_end_p =3D data;
@@ -139,13 +141,17 @@
=20
 	data =3D irc_buffer;
 	data_limit =3D irc_buffer + skb->len - dataoff;
-	while (data < (data_limit - (22 + MAXMATCHLEN))) {
+
+	/* strlen("\1DCC SENT t AAAAAAAA P\1\n")=3D24
+	 * 5+MINMATCHLEN+strlen("t AAAAAAAA P\1\n")=3D14 */
+	while (data < (data_limit - (19 + MINMATCHLEN))) {
 		if (memcmp(data, "\1DCC ", 5)) {
 			data++;
 			continue;
 		}
=20
 		data +=3D 5;
+		/* we have at least (19+MINMATCHLEN)-5 bytes valid data left */
=20
 		DEBUGP("DCC found in master %u.%u.%u.%u:%u %u.%u.%u.%u:%u...\n",
 			NIPQUAD(iph->saddr), ntohs(tcph.source),
@@ -159,6 +165,9 @@
=20
 			DEBUGP("DCC %s detected\n", dccprotos[i]);
 			data +=3D strlen(dccprotos[i]);
+			/* we have at least=20
+			 * (19+MINMATCHLEN)-5-dccprotos[i].matchlen bytes valid
+			 * data left (=3D=3D 14/13 bytes) */
 			if (parse_dcc((char *)data, data_limit, &dcc_ip,
 				       &dcc_port, &addr_beg_p, &addr_end_p)) {
 				/* unable to parse */
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--B1+FeH9/zg1Fgdnk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZiGXaXGVTD0i/8RAs90AJ4/r2SKIoQBBHDN4i+6K+3H0K6y0ACfYXvT
Bdf1xcPF2kaZzIk2StWcGL0=
=+Br5
-----END PGP SIGNATURE-----

--B1+FeH9/zg1Fgdnk--
