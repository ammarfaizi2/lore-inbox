Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272357AbTGYVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272317AbTGYUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:41:44 -0400
Received: from coruscant.franken.de ([193.174.159.226]:42130 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272316AbTGYUi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:38:26 -0400
Date: Fri, 25 Jul 2003 22:50:55 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] netfilter ip_conntrack_irc parser fix
Message-ID: <20030725205055.GJ3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7HcxP2Wm84z5MHiD"
Content-Disposition: inline
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7HcxP2Wm84z5MHiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave!

This is the 3rd of a set of bugfixes (all tested against 2.4.22-pre7).
You might need to apply them incrementally (didn't test it in a
different order).  You will receive 2.6 merges of those patches soon.


Author: Harald Welte <laforge@netfilter.org>

This patch fixes a bug in the IRC DCC command parser of ip_conntrack_irc

Please apply,

--- linux/net/ipv4/netfilter/ip_conntrack_irc.c.orig	Wed May  7 12:13:55 20=
03
+++ linux/net/ipv4/netfilter/ip_conntrack_irc.c	Wed May  7 13:16:00 2003
@@ -59,7 +59,7 @@
 	{"TSEND ", 6},
 	{"SCHAT ", 6}
 };
-#define MAXMATCHLEN	6
+#define MINMATCHLEN	5
=20
 DECLARE_LOCK(ip_irc_lock);
 struct module *ip_conntrack_irc =3D THIS_MODULE;
@@ -92,9 +92,11 @@
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
@@ -153,13 +155,17 @@
 	}
=20
 	data_limit =3D (char *) data + datalen;
-	while (data < (data_limit - (22 + MAXMATCHLEN))) {
+
+	/* strlen("\1DCC SEND t AAAAAAAA P\1\n")=3D24
+	 *         5+MINMATCHLEN+strlen("t AAAAAAAA P\1\n")=3D14 */
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
 			NIPQUAD(iph->saddr), ntohs(tcph->source),
@@ -174,6 +180,9 @@
=20
 			DEBUGP("DCC %s detected\n", dccprotos[i].match);
 			data +=3D dccprotos[i].matchlen;
+			/* we have at least
+			 * (19+MINMATCHLEN)-5-dccprotos[i].matchlen bytes valid
+			 * data left (=3D=3D 14/13 bytes) */
 			if (parse_dcc((char *) data, data_limit, &dcc_ip,
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

--7HcxP2Wm84z5MHiD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZgvXaXGVTD0i/8RAgzaAKCEXZlW6gVqEmAEgHrRCUycw6bFrACaAouc
uEbnYPIcZ1DhUz01X9AxmdQ=
=7ImP
-----END PGP SIGNATURE-----

--7HcxP2Wm84z5MHiD--
