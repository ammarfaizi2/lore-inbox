Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTHBNWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTHBNVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:21:10 -0400
Received: from coruscant.franken.de ([193.174.159.226]:2774 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S263638AbTHBNUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:20:31 -0400
Date: Sat, 2 Aug 2003 15:18:39 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@redhat.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] iptables AH/ESP fix (1/1)
Message-ID: <20030802131839.GI6894@naboo>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQFQLHPkFLmdEfVA"
Content-Disposition: inline
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Pungenday, the 67th day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NQFQLHPkFLmdEfVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Davem!

The below patch (again by Patrick McHardy) is the 2.4 merge of the last
3 2.6 patches I've sent you.  Obviously we cannot use the kernel's
ah/esp structures, since there are none.

Please apply, thanks.

diff -Nru a/net/ipv4/netfilter/ipt_LOG.c b/net/ipv4/netfilter/ipt_LOG.c
--- a/net/ipv4/netfilter/ipt_LOG.c	Mon Jul 21 02:21:23 2003
+++ b/net/ipv4/netfilter/ipt_LOG.c	Mon Jul 21 02:21:23 2003
@@ -3,15 +3,14 @@
  */
 #include <linux/module.h>
 #include <linux/skbuff.h>
-#include <linux/ip.h>
 #include <linux/spinlock.h>
+#include <linux/ip.h>
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
@@ -20,10 +19,20 @@
 #define DEBUGP(format, args...)
 #endif
=20
+/* FIXME: move to ip.h like in 2.5 */
+struct ahhdr {
+	__u8    nexthdr;
+	__u8    hdrlen;
+	__u16   reserved;
+	__u32   spi;
+	__u32   seq_no;
+};
+
 struct esphdr {
 	__u32   spi;
-}; /* FIXME evil kludge */
-       =20
+	__u32   seq_no;
+};
+
 /* Use lock to serialize, so printks don't overlap */
 static spinlock_t log_lock =3D SPIN_LOCK_UNLOCKED;
=20
@@ -58,7 +67,8 @@
 		printk("FRAG:%u ", ntohs(iph->frag_off) & IP_OFFSET);
=20
 	if ((info->logflags & IPT_LOG_IPOPT)
-	    && iph->ihl * 4 !=3D sizeof(struct iphdr)) {
+	    && iph->ihl * 4 !=3D sizeof(struct iphdr)
+	    && iph->ihl * 4 >=3D datalen) {
 		unsigned int i;
=20
 		/* Max length: 127 "OPT (" 15*4*2chars ") " */
@@ -231,13 +241,30 @@
 		break;
 	}
 	/* Max Length */
-	case IPPROTO_AH:
+	case IPPROTO_AH: {
+		struct ahhdr *ah =3D protoh;
+
+		/* Max length: 9 "PROTO=3DAH " */
+		printk("PROTO=3DAH ");
+
+		if (ntohs(iph->frag_off) & IP_OFFSET)
+			break;
+
+		/* Max length: 25 "INCOMPLETE [65535 bytes] " */
+		if (datalen < sizeof (*ah)) {
+			printk("INCOMPLETE [%u bytes] ", datalen);
+			break;
+		}
+
+		/* Length: 15 "SPI=3D0xF1234567 " */
+		printk("SPI=3D0x%x ", ntohl(ah->spi) );
+		break;
+	}
 	case IPPROTO_ESP: {
 		struct esphdr *esph =3D protoh;
-		int esp=3D (iph->protocol=3D=3DIPPROTO_ESP);
=20
 		/* Max length: 10 "PROTO=3DESP " */
-		printk("PROTO=3D%s ",esp? "ESP" : "AH");
+		printk("PROTO=3DESP ");
=20
 		if (ntohs(iph->frag_off) & IP_OFFSET)
 			break;
diff -Nru a/net/ipv4/netfilter/ipt_ah.c b/net/ipv4/netfilter/ipt_ah.c
--- a/net/ipv4/netfilter/ipt_ah.c	Mon Jul 21 02:20:52 2003
+++ b/net/ipv4/netfilter/ipt_ah.c	Mon Jul 21 02:20:52 2003
@@ -15,7 +15,11 @@
 #endif
=20
 struct ahhdr {
+	__u8    nexthdr;
+	__u8    hdrlen;
+	__u16   reserved;
 	__u32   spi;
+	__u32   seq_no;
 };
=20
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
diff -Nru a/net/ipv4/netfilter/ipt_esp.c b/net/ipv4/netfilter/ipt_esp.c
--- a/net/ipv4/netfilter/ipt_esp.c	Mon Jul 21 02:22:20 2003
+++ b/net/ipv4/netfilter/ipt_esp.c	Mon Jul 21 02:22:20 2003
@@ -16,6 +16,7 @@
=20
 struct esphdr {
 	__u32   spi;
+	__u32   seq_no;
 };
=20
 /* Returns 1 if the spi is matched by the range, 0 otherwise */
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--NQFQLHPkFLmdEfVA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K7ovXaXGVTD0i/8RAqzrAJ4v2v+6779cA9pcHXP8H8t8NlWWeACfaImf
9fDIt5BPNcWBq723vgeFMzk=
=T2nQ
-----END PGP SIGNATURE-----

--NQFQLHPkFLmdEfVA--
