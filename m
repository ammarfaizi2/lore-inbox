Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVAVVId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVAVVId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVAVVEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:04:37 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:50115 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262743AbVAVU6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:58:50 -0500
Date: Sat, 22 Jan 2005 12:57:59 -0800
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.11-rc2
Message-ID: <20050122125759.7d597594@laptop.hypervisor.org>
In-Reply-To: <1106402669.20995.23.camel@tux.rsn.bth.se>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
	<20050121223247.65c544f8@laptop.hypervisor.org>
	<1106402669.20995.23.camel@tux.rsn.bth.se>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Sat__22_Jan_2005_12_57_59_-0800_4CeFowjGjTeb9/WA";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Sat__22_Jan_2005_12_57_59_-0800_4CeFowjGjTeb9/WA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jan 2005 15:04:29 +0100 Martin Josefsson (MJ) wrote:

MJ> On Fri, 2005-01-21 at 22:32 -0800, Udo A. Steinberg wrote:
MJ> > 
MJ> > Connection tracking does not compile...

MJ> The problem is when compiling without NAT...
MJ> The patch below should fix it, I can compile both with and without NAT
MJ> now.

Thanks, this fixes my problem, too.

Linus, please apply the following patch from Martin.

-Udo.

diff -X /home/gandalf/dontdiff.ny -urNp linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack.h linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack.h
--- linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack.h	2005-01-22 12:17:39.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack.h	2005-01-22 13:55:25.000000000 +0100
@@ -122,33 +122,6 @@ do {									\
 #define IP_NF_ASSERT(x)
 #endif
 
-struct ip_conntrack_expect
-{
-	/* Internal linked list (global expectation list) */
-	struct list_head list;
-
-	/* We expect this tuple, with the following mask */
-	struct ip_conntrack_tuple tuple, mask;
- 
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
 
+struct ip_conntrack_expect
+{
+	/* Internal linked list (global expectation list) */
+	struct list_head list;
+
+	/* We expect this tuple, with the following mask */
+	struct ip_conntrack_tuple tuple, mask;
+ 
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
 
 #define CONNTRACK_STAT_INC(count) (__get_cpu_var(ip_conntrack_stat).count++)
 
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
diff -X /home/gandalf/dontdiff.ny -urNp linux-2.6.11-rc2.orig/net/ipv4/netfilter/ipt_CLUSTERIP.c linux-2.6.11-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c
--- linux-2.6.11-rc2.orig/net/ipv4/netfilter/ipt_CLUSTERIP.c	2005-01-22 12:17:40.000000000 +0100
+++ linux-2.6.11-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c	2005-01-22 13:55:49.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_CLUSTERIP.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
+#include <linux/netfilter_ipv4/lockhelp.h>
 
 #define CLUSTERIP_VERSION "0.6"

--Signature_Sat__22_Jan_2005_12_57_59_-0800_4CeFowjGjTeb9/WA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFB8r5dnhRzXSM7nSkRAizsAJ0Vk7PHEEqp1flEbGnJlEZ0rNEXWgCeOrnI
RK89EfMFTHRPPWbYFcOsqWw=
=QENN
-----END PGP SIGNATURE-----

--Signature_Sat__22_Jan_2005_12_57_59_-0800_4CeFowjGjTeb9/WA--
