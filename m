Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTHBNUq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHBNUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:20:46 -0400
Received: from coruscant.franken.de ([193.174.159.226]:214 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S263590AbTHBNU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:20:27 -0400
Date: Sat, 2 Aug 2003 14:57:59 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] iptables AH/ESP fix (1/3)
Message-ID: <20030802125759.GF6894@naboo>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="83Y2sXKo4f/n2njO"
Content-Disposition: inline
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Pungenday, the 67th day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--83Y2sXKo4f/n2njO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Davem!

The below patch fixes logging of AH SPI's in the iptables LOG target.
It is the first of a series of three patches related to AH/ESP in
iptables. (you'll receive 2.4 updates later on)

Please apply, thanks.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1535  -> 1.1536=20
#	net/ipv4/netfilter/ipt_LOG.c	1.7     -> 1.8   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/21	kaber@trash.net	1.1536
# [NETFILTER]: Fix logging of AH spis
# --------------------------------------------
#
diff -Nru a/net/ipv4/netfilter/ipt_LOG.c b/net/ipv4/netfilter/ipt_LOG.c
--- a/net/ipv4/netfilter/ipt_LOG.c	Thu May 22 01:36:54 2003
+++ b/net/ipv4/netfilter/ipt_LOG.c	Mon Jul 21 01:30:34 2003
@@ -2,16 +2,15 @@
  * This is a module which is used for logging packets.
  */
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
-#include <linux/spinlock.h>
 #include <net/icmp.h>
 #include <net/udp.h>
 #include <net/tcp.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
-
-struct in_device;
 #include <net/route.h>
+
+#include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_LOG.h>
=20
 #if 0
@@ -20,10 +19,6 @@
 #define DEBUGP(format, args...)
 #endif
=20
-struct esphdr {
-	__u32   spi;
-}; /* FIXME evil kludge */
-       =20
 /* Use lock to serialize, so printks don't overlap */
 static spinlock_t log_lock =3D SPIN_LOCK_UNLOCKED;
=20
@@ -256,13 +251,31 @@
 		break;
 	}
 	/* Max Length */
-	case IPPROTO_AH:
+	case IPPROTO_AH: {
+		struct ip_auth_hdr ah;
+
+		if (ntohs(iph.frag_off) & IP_OFFSET)
+			break;
+	=09
+		/* Max length: 9 "PROTO=3DAH " */
+		printk("PROTO=3DAH ");
+
+		/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+		if (skb_copy_bits(skb, iphoff+iph.ihl*4, &ah, sizeof(ah)) < 0) {
+			printk("INCOMPLETE [%u bytes] ",
+			       skb->len - iphoff - iph.ihl*4);
+			break;
+		}
+
+		/* Length: 15 "SPI=3D0xF1234567 " */
+		printk("SPI=3D0x%x ", ntohl(ah.spi));
+		break;
+	}
 	case IPPROTO_ESP: {
-		struct esphdr esph;
-		int esp =3D (iph.protocol=3D=3DIPPROTO_ESP);
+		struct ip_esp_hdr esph;
=20
 		/* Max length: 10 "PROTO=3DESP " */
-		printk("PROTO=3D%s ",esp? "ESP" : "AH");
+		printk("PROTO=3DESP ");
=20
 		if (ntohs(iph.frag_off) & IP_OFFSET)
 			break;
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--83Y2sXKo4f/n2njO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K7VXXaXGVTD0i/8RAlUZAKCIeNT/j/W8RCr6oAKzFPjuadGebQCdEjyI
hETsv0Twm+SyZPwNLdhHOq0=
=jcuP
-----END PGP SIGNATURE-----

--83Y2sXKo4f/n2njO--
