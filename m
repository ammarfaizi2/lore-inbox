Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSJNLnF>; Mon, 14 Oct 2002 07:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJNLnF>; Mon, 14 Oct 2002 07:43:05 -0400
Received: from coruscant.franken.de ([193.174.159.226]:32479 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261569AbSJNLnD>; Mon, 14 Oct 2002 07:43:03 -0400
Date: Mon, 14 Oct 2002 13:47:35 +0200
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: netfilter-devel@lists.netfilter.org, toml@internode.on.net,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Fw: PROBLEM: Conntrack/NAT bug
Message-ID: <20021014134735.S13233@sunbeam.de.gnumonks.org>
References: <20021010.062046.47003148.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neJKo2vCRXM/Q6OJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20021010.062046.47003148.davem@redhat.com>; from davem@redhat.com on Thu, Oct 10, 2002 at 06:20:46AM -0700
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Setting Orange, the 56th day of Bureaucracy in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neJKo2vCRXM/Q6OJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2002 at 06:20:46AM -0700, Tom Lanyon wrote:

> [1.] One line summary of the problem:   Some sort of coding problem in
> conntrack.

It's not a bug in the code, it's a bug in the debugging ASSERT macros, as=
=20
correctly pointed out by Martin Josefsson. =20

The issue is that we are nesting readlocks, because ip_ct_find_proto()
grabs itself a readlock on ip_conntrack_lock.

The patch below now exports the non-locking __ip_ct_find_proto() function,
thus no more grabbing a nested readlock.

I wanted to go for a different solution, since exporting __ functions is
not exactly clean coding style - but due to the circumstances other solutio=
ns
look even more ugly.

Dave, please apply the following fix (again by Martin Josefsson), Thanks.


diff -x '*.orig' -urN linux-2.4.20-pre8-ac3.orig/include/linux/netfilter_ip=
v4/ip_conntrack_core.h linux-2.4.20-pre8-ac3/include/linux/netfilter_ipv4/i=
p_conntrack_core.h
--- linux-2.4.20-pre8-ac3.orig/include/linux/netfilter_ipv4/ip_conntrack_co=
re.h	2002-10-10 15:41:55.000000000 +0200
+++ linux-2.4.20-pre8-ac3/include/linux/netfilter_ipv4/ip_conntrack_core.h	=
2002-10-10 16:07:16.000000000 +0200
@@ -17,7 +17,7 @@
 struct ip_conntrack_protocol;
 extern struct ip_conntrack_protocol *ip_ct_find_proto(u_int8_t protocol);
 /* Like above, but you already have conntrack read lock. */
-extern struct ip_conntrack_protocol *__find_proto(u_int8_t protocol);
+extern struct ip_conntrack_protocol *__ip_ct_find_proto(u_int8_t protocol);
 extern struct list_head protocol_list;
=20
 /* Returns conntrack if it dealt with ICMP, and filled in skb->nfct */
diff -x '*.orig' -urN linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_conn=
track_core.c linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_conntrack_core.c	2002-=
10-10 15:41:57.000000000 +0200
+++ linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_conntrack_core.c	2002-10-10=
 16:07:16.000000000 +0200
@@ -74,7 +74,7 @@
 	return protocol =3D=3D curr->proto;
 }
=20
-struct ip_conntrack_protocol *__find_proto(u_int8_t protocol)
+struct ip_conntrack_protocol *__ip_ct_find_proto(u_int8_t protocol)
 {
 	struct ip_conntrack_protocol *p;
=20
@@ -92,7 +92,7 @@
 	struct ip_conntrack_protocol *p;
=20
 	READ_LOCK(&ip_conntrack_lock);
-	p =3D __find_proto(protocol);
+	p =3D __ip_ct_find_proto(protocol);
 	READ_UNLOCK(&ip_conntrack_lock);
 	return p;
 }
diff -x '*.orig' -urN linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_conn=
track_standalone.c linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_conntrack_st=
andalone.c
--- linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_conntrack_standalone.c=
	2002-10-10 15:41:57.000000000 +0200
+++ linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_conntrack_standalone.c	2002=
-10-10 16:07:16.000000000 +0200
@@ -71,7 +71,7 @@
 	len +=3D sprintf(buffer + len, "use=3D%u proto=3D%u ",
 		      atomic_read(&expect->use), expect->tuple.dst.protonum);
 	len +=3D print_tuple(buffer + len, &expect->tuple,
-			   __find_proto(expect->tuple.dst.protonum));
+			   __ip_ct_find_proto(expect->tuple.dst.protonum));
 	len +=3D sprintf(buffer + len, "\n");
 	return len;
 }
@@ -81,7 +81,7 @@
 {
 	unsigned int len;
 	struct ip_conntrack_protocol *proto
-		=3D __find_proto(conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
+		=3D __ip_ct_find_proto(conntrack->tuplehash[IP_CT_DIR_ORIGINAL]
 			       .tuple.dst.protonum);
=20
 	len =3D sprintf(buffer, "%-8s %u %lu ",
@@ -361,6 +361,7 @@
 EXPORT_SYMBOL(ip_ct_selective_cleanup);
 EXPORT_SYMBOL(ip_ct_refresh);
 EXPORT_SYMBOL(ip_ct_find_proto);
+EXPORT_SYMBOL(__ip_ct_find_proto);
 EXPORT_SYMBOL(ip_ct_find_helper);
 EXPORT_SYMBOL(ip_conntrack_expect_related);
 EXPORT_SYMBOL(ip_conntrack_change_expect);
diff -x '*.orig' -urN linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_nat_=
core.c linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.20-pre8-ac3.orig/net/ipv4/netfilter/ip_nat_core.c	2002-10-10 =
16:10:49.000000000 +0200
+++ linux-2.4.20-pre8-ac3/net/ipv4/netfilter/ip_nat_core.c	2002-10-10 16:10=
:36.000000000 +0200
@@ -739,7 +739,7 @@
 	int ret =3D 1;
=20
 	MUST_BE_READ_LOCKED(&ip_conntrack_lock);
-	proto =3D ip_ct_find_proto((*pskb)->nh.iph->protocol);
+	proto =3D __ip_ct_find_proto((*pskb)->nh.iph->protocol);
 	if (proto->exp_matches_pkt)
 		ret =3D proto->exp_matches_pkt(exp, pskb);
=20

> Thanks for your help

Thanks for your help (i mean it!).

> Tom Lanyon
> toml@internode.on.net

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--neJKo2vCRXM/Q6OJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9qq7XXaXGVTD0i/8RAsGYAJ9QAPQ/C0wG8uRdILF/Q7rhWGq1ugCfWPIi
PL+101dV+iKbq7iCDvOlsnQ=
=MvaZ
-----END PGP SIGNATURE-----

--neJKo2vCRXM/Q6OJ--
