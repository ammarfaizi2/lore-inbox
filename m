Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWFNJkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWFNJkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWFNJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:40:31 -0400
Received: from ex001a.cxnet.dk ([195.135.216.13]:56995 "EHLO
	comxexch01.comx.local") by vger.kernel.org with ESMTP
	id S932236AbWFNJk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:40:29 -0400
Subject: [PATCH 1/2] NET: Accurate packet scheduling for ATM/ADSL (kernel)
From: Jesper Dangaard Brouer <hawk@comx.dk>
To: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl
Cc: russell-tcatm@stuart.id.au, hawk@comx.dk, hawk@diku.dk,
       linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QO461N9TV4q38ivuqQkl"
Organization: ComX Networks A/S
Date: Wed, 14 Jun 2006 11:40:28 +0200
Message-Id: <1150278028.26182.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 14 Jun 2006 09:40:28.0364 (UTC) FILETIME=[91FAD8C0:01C68F96]
X-TM-AS-Product-Ver: SMEX-7.0.0.1345-3.52.1006-14506.002
X-TM-AS-Result: No--0.850000-8.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QO461N9TV4q38ivuqQkl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The Linux traffic's control engine inaccurately calculates
transmission times for packets sent over ADSL links.  For
some packet sizes the error rises to over 50%.  This occurs
because ADSL uses ATM as its link layer transport, and ATM
transmits packets in fixed sized 53 byte cells.

This changes the kernel rate table lookup, to be able to lookup
packet transmission times over all ATM links, including ADSL,
with perfect accuracy. The accuracy is dependent on the rate
table that is calculated in userspace by iproute2 command tc.

A longer presentation of the patch, its rational, what it
does and how to use it can be found here:
   http://www.stuart.id.au/russell/files/tc/tc-atm/

A earlier version of the patch, and a _detailed_ empirical
investigation of its effects can be found here:
   http://www.adsl-optimizer.dk/

Signed-off-by: Jesper Dangaard Brouer <hawk@comx.dk>
Signed-off-by: Russell Stuart <russell-tcatm@stuart.id.au>
---

diff -Nurp kernel-source-2.6.16.orig/include/linux/pkt_sched.h kernel-sourc=
e-2.6.16/include/linux/pkt_sched.h
--- kernel-source-2.6.16.orig/include/linux/pkt_sched.h	2006-03-20 15:53:29=
.000000000 +1000
+++ kernel-source-2.6.16/include/linux/pkt_sched.h	2006-06-13 11:42:12.0000=
00000 +1000
@@ -77,8 +77,9 @@ struct tc_ratespec
 {
 	unsigned char	cell_log;
 	unsigned char	__reserved;
-	unsigned short	feature;
-	short		addend;
+	unsigned short	feature;	/* Always 0 in pre-atm patch kernels */
+	char		cell_align;	/* Always 0 in pre-atm patch kernels */
+	unsigned char	__unused;
 	unsigned short	mpu;
 	__u32		rate;
 };
diff -Nurp kernel-source-2.6.16.orig/include/net/sch_generic.h kernel-sourc=
e-2.6.16/include/net/sch_generic.h
--- kernel-source-2.6.16.orig/include/net/sch_generic.h	2006-03-20 15:53:29=
.000000000 +1000
+++ kernel-source-2.6.16/include/net/sch_generic.h	2006-06-13 11:42:12.0000=
00000 +1000
@@ -307,4 +307,18 @@ drop:
 	return NET_XMIT_DROP;
 }
=20
+/* Lookup a qdisc_rate_table to determine how long it will take to send a
+   packet given its size.
+ */
+static inline u32 qdisc_l2t(struct qdisc_rate_table* rtab, int pktlen)
+{
+	int slot =3D pktlen + rtab->rate.cell_align;
+	if (slot < 0)
+	  	slot =3D 0;
+	slot >>=3D rtab->rate.cell_log;
+	if (slot > 255)
+		return rtab->data[255] + 1;
+	return rtab->data[slot];
+}
+
 #endif
diff -Nurp kernel-source-2.6.16.orig/net/sched/act_police.c kernel-source-2=
.6.16/net/sched/act_police.c
--- kernel-source-2.6.16.orig/net/sched/act_police.c	2006-03-20 15:53:29.00=
0000000 +1000
+++ kernel-source-2.6.16/net/sched/act_police.c	2006-06-13 11:42:12.0000000=
00 +1000
@@ -33,8 +33,8 @@
 #include <net/sock.h>
 #include <net/act_api.h>
=20
-#define L2T(p,L)   ((p)->R_tab->data[(L)>>(p)->R_tab->rate.cell_log])
-#define L2T_P(p,L) ((p)->P_tab->data[(L)>>(p)->P_tab->rate.cell_log])
+#define L2T(p,L)   qdisc_l2t((p)->R_tab,L)
+#define L2T_P(p,L) qdisc_l2t((p)->P_tab,L)
 #define PRIV(a) ((struct tcf_police *) (a)->priv)
=20
 /* use generic hash table */
diff -Nurp kernel-source-2.6.16.orig/net/sched/sch_cbq.c kernel-source-2.6.=
16/net/sched/sch_cbq.c
--- kernel-source-2.6.16.orig/net/sched/sch_cbq.c	2006-03-20 15:53:29.00000=
0000 +1000
+++ kernel-source-2.6.16/net/sched/sch_cbq.c	2006-06-13 11:42:12.000000000 =
+1000
@@ -193,7 +193,7 @@ struct cbq_sched_data
 };
=20
=20
-#define L2T(cl,len)	((cl)->R_tab->data[(len)>>(cl)->R_tab->rate.cell_log])
+#define L2T(cl,len)	qdisc_l2t((cl)->R_tab,len)
=20
=20
 static __inline__ unsigned cbq_hash(u32 h)
diff -Nurp kernel-source-2.6.16.orig/net/sched/sch_htb.c kernel-source-2.6.=
16/net/sched/sch_htb.c
--- kernel-source-2.6.16.orig/net/sched/sch_htb.c	2006-03-20 15:53:29.00000=
0000 +1000
+++ kernel-source-2.6.16/net/sched/sch_htb.c	2006-06-13 11:42:12.000000000 =
+1000
@@ -206,12 +206,10 @@ struct htb_class
 static __inline__ long L2T(struct htb_class *cl,struct qdisc_rate_table *r=
ate,
 	int size)
 {=20
-    int slot =3D size >> rate->rate.cell_log;
-    if (slot > 255) {
+    long result =3D qdisc_l2t(rate, size);
+    if (result > rate->data[255])
 	cl->xstats.giants++;
-	slot =3D 255;
-    }
-    return rate->data[slot];
+    return result;
 }
=20
 struct htb_sched
diff -Nurp kernel-source-2.6.16.orig/net/sched/sch_tbf.c kernel-source-2.6.=
16/net/sched/sch_tbf.c
--- kernel-source-2.6.16.orig/net/sched/sch_tbf.c	2006-03-20 15:53:29.00000=
0000 +1000
+++ kernel-source-2.6.16/net/sched/sch_tbf.c	2006-06-13 11:42:12.000000000 =
+1000
@@ -132,8 +132,8 @@ struct tbf_sched_data
 	struct Qdisc	*qdisc;		/* Inner qdisc, default - bfifo queue */
 };
=20
-#define L2T(q,L)   ((q)->R_tab->data[(L)>>(q)->R_tab->rate.cell_log])
-#define L2T_P(q,L) ((q)->P_tab->data[(L)>>(q)->P_tab->rate.cell_log])
+#define L2T(q,L)   qdisc_l2t((q)->R_tab,L)
+#define L2T_P(q,L) qdisc_l2t((q)->P_tab,L)
=20
 static int tbf_enqueue(struct sk_buff *skb, struct Qdisc* sch)
 {



--=-QO461N9TV4q38ivuqQkl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj9mMwuVH+NB3fZkRAhQLAJ9OlfirfFqQHBvq+QRZo2/mK3rGFwCfYpXt
N8dsHB3SVmjZZrCLDSysPvQ=
=HSRO
-----END PGP SIGNATURE-----

--=-QO461N9TV4q38ivuqQkl--

