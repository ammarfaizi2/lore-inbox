Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVAVOEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVAVOEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 09:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAVOEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 09:04:41 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:41873 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262719AbVAVOEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 09:04:32 -0500
Subject: Re: Linux 2.6.11-rc2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050121223247.65c544f8@laptop.hypervisor.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
	 <20050121223247.65c544f8@laptop.hypervisor.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kPnfIPeFEFeNcP504it5"
Date: Sat, 22 Jan 2005 15:04:29 +0100
Message-Id: <1106402669.20995.23.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kPnfIPeFEFeNcP504it5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-21 at 22:32 -0800, Udo A. Steinberg wrote:
> On Fri, 21 Jan 2005 18:13:55 -0800 (PST) Linus Torvalds (LT) wrote:
>=20
> LT> Ok, trying to calm things down again for a 2.6.11 release.
>=20
> Connection tracking does not compile...
>=20
>  CC      net/ipv4/netfilter/ip_conntrack_standalone.o
> In file included from net/ipv4/netfilter/ip_conntrack_standalone.c:34:
> include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: "struct ip_conn=
track" declared inside parameter list
> include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: its scope is on=
ly this definition or declaration, which is probably not what you want
> include/linux/netfilter_ipv4/ip_conntrack.h:305: warning: "enum ip_nat_ma=
nip_type" declared inside parameter list
> include/linux/netfilter_ipv4/ip_conntrack.h:306: error: parameter `manip'=
 has incomplete type
> include/linux/netfilter_ipv4/ip_conntrack.h: In function `ip_nat_initiali=
zed':
> include/linux/netfilter_ipv4/ip_conntrack.h:307: error: `IP_NAT_MANIP_SRC=
' undeclared (first use in this function)
> include/linux/netfilter_ipv4/ip_conntrack.h:307: error: (Each undeclared =
identifier is reported only once
> include/linux/netfilter_ipv4/ip_conntrack.h:307: error: for each function=
 it appears in.)

The problem is when compiling without NAT...
The patch below should fix it, I can compile both with and without NAT
now.

diff -X /home/gandalf/dontdiff.ny -urNp linux-2.6.11-rc2.orig/include/linux=
/netfilter_ipv4/ip_conntrack.h linux-2.6.11-rc2/include/linux/netfilter_ipv=
4/ip_conntrack.h
--- linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack.h	2005-=
01-22 12:17:39.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack.h	2005-01-22=
 13:55:25.000000000 +0100
@@ -122,33 +122,6 @@ do {									\
 #define IP_NF_ASSERT(x)
 #endif
=20
-struct ip_conntrack_expect
-{
-	/* Internal linked list (global expectation list) */
-	struct list_head list;
-
-	/* We expect this tuple, with the following mask */
-	struct ip_conntrack_tuple tuple, mask;
-=20
-	/* Function to call after setup and insertion */
-	void (*expectfn)(struct ip_conntrack *new,
-			 struct ip_conntrack_expect *this);
-
-	/* The conntrack of the master connection */
-	struct ip_conntrack *master;
-
-	/* Timer function; deletes the expectation. */
-	struct timer_list timeout;
-
-#ifdef CONFIG_IP_NF_NAT_NEEDED
-	/* This is the original per-proto part, used to map the
-	 * expected connection the way the recipient expects. */
-	union ip_conntrack_manip_proto saved_proto;
-	/* Direction relative to the master connection. */
-	enum ip_conntrack_dir dir;
-#endif
-};
-
 struct ip_conntrack_counter
 {
 	u_int64_t packets;
@@ -206,6 +179,33 @@ struct ip_conntrack
 	struct ip_conntrack_tuple_hash tuplehash[IP_CT_DIR_MAX];
 };
=20
+struct ip_conntrack_expect
+{
+	/* Internal linked list (global expectation list) */
+	struct list_head list;
+
+	/* We expect this tuple, with the following mask */
+	struct ip_conntrack_tuple tuple, mask;
+=20
+	/* Function to call after setup and insertion */
+	void (*expectfn)(struct ip_conntrack *new,
+			 struct ip_conntrack_expect *this);
+
+	/* The conntrack of the master connection */
+	struct ip_conntrack *master;
+
+	/* Timer function; deletes the expectation. */
+	struct timer_list timeout;
+
+#ifdef CONFIG_IP_NF_NAT_NEEDED
+	/* This is the original per-proto part, used to map the
+	 * expected connection the way the recipient expects. */
+	union ip_conntrack_manip_proto saved_proto;
+	/* Direction relative to the master connection. */
+	enum ip_conntrack_dir dir;
+#endif
+};
+
 static inline struct ip_conntrack *
 tuplehash_to_ctrack(const struct ip_conntrack_tuple_hash *hash)
 {
@@ -301,6 +301,7 @@ struct ip_conntrack_stat
=20
 #define CONNTRACK_STAT_INC(count) (__get_cpu_var(ip_conntrack_stat).count+=
+)
=20
+#ifdef CONFIG_IP_NF_NAT_NEEDED
 static inline int ip_nat_initialized(struct ip_conntrack *conntrack,
 				     enum ip_nat_manip_type manip)
 {
@@ -308,5 +309,7 @@ static inline int ip_nat_initialized(str
 		return test_bit(IPS_SRC_NAT_DONE_BIT, &conntrack->status);
 	return test_bit(IPS_DST_NAT_DONE_BIT, &conntrack->status);
 }
+#endif /* CONFIG_IP_NF_NAT_NEEDED */
+
 #endif /* __KERNEL__ */
 #endif /* _IP_CONNTRACK_H */
diff -X /home/gandalf/dontdiff.ny -urNp linux-2.6.11-rc2.orig/net/ipv4/netf=
ilter/ipt_CLUSTERIP.c linux-2.6.11-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c
--- linux-2.6.11-rc2.orig/net/ipv4/netfilter/ipt_CLUSTERIP.c	2005-01-22 12:=
17:40.000000000 +0100
+++ linux-2.6.11-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c	2005-01-22 13:55:49=
.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_CLUSTERIP.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
+#include <linux/netfilter_ipv4/lockhelp.h>
=20
 #define CLUSTERIP_VERSION "0.6"
=20


--=20
/Martin

--=-kPnfIPeFEFeNcP504it5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB8l1tWm2vlfa207ERAui2AJ4tBRhWXu/hZRH4UqFoTtO0kJgZqgCbBzEa
xulGzm6IQZAi1727iJJvHHQ=
=rgep
-----END PGP SIGNATURE-----

--=-kPnfIPeFEFeNcP504it5--
