Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWFNJkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWFNJkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWFNJko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:40:44 -0400
Received: from ex001a.cxnet.dk ([195.135.216.13]:60067 "EHLO
	comxexch01.comx.local") by vger.kernel.org with ESMTP
	id S932259AbWFNJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:40:42 -0400
Subject: [PATCH 2/2] NET: Accurate packet scheduling for ATM/ADSL
	(userspace)
From: Jesper Dangaard Brouer <hawk@comx.dk>
To: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl
Cc: russell-tcatm@stuart.id.au, hawk@comx.dk, hawk@diku.dk,
       linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7IT4k+pTt2geUIR4Mfxf"
Organization: ComX Networks A/S
Date: Wed, 14 Jun 2006 11:40:40 +0200
Message-Id: <1150278040.26181.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 14 Jun 2006 09:40:40.0647 (UTC) FILETIME=[994D1570:01C68F96]
X-TM-AS-Product-Ver: SMEX-7.0.0.1345-3.52.1006-14506.002
X-TM-AS-Result: No--4.150000-8.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7IT4k+pTt2geUIR4Mfxf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The Linux traffic's control engine inaccurately calculates
transmission times for packets sent over ADSL links.  For
some packet sizes the error rises to over 50%.  This occurs
because ADSL uses ATM as its link layer transport, and ATM
transmits packets in fixed sized 53 byte cells.

This changes the userspace tool iproute2/tc by adding an
option to calculate traffic transmission times (rate table)
over all ATM links, including ADSL, with perfect accuracy.

A longer presentation of the patch, its rational, what it
does and how to use it can be found here:
   http://www.stuart.id.au/russell/files/tc/tc-atm/

A earlier version of the patch, and a _detailed_ empirical
investigation of its effects can be found here:
   http://www.adsl-optimizer.dk/

Signed-off-by: Jesper Dangaard Brouer <hawk@comx.dk>
Signed-off-by: Russell Stuart <russell-tcatm@stuart.id.au>
---

diff -Nurp iproute2.orig/include/linux/pkt_sched.h iproute2/include/linux/p=
kt_sched.h
--- iproute2.orig/include/linux/pkt_sched.h	2005-12-10 09:27:44.000000000 +=
1000
+++ iproute2/include/linux/pkt_sched.h	2006-06-13 11:53:27.000000000 +1000
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
diff -Nurp iproute2.orig/tc/m_police.c iproute2/tc/m_police.c
--- iproute2.orig/tc/m_police.c	2005-01-19 08:11:58.000000000 +1000
+++ iproute2/tc/m_police.c	2006-06-13 11:53:27.000000000 +1000
@@ -35,7 +35,7 @@ struct action_util police_action_util =3D=20
 static void explain(void)
 {
 	fprintf(stderr, "Usage: ... police rate BPS burst BYTES[/BYTES] [ mtu BYT=
ES[/BYTES] ]\n");
-	fprintf(stderr, "                [ peakrate BPS ] [ avrate BPS ]\n");
+	fprintf(stderr, "                [ peakrate BPS ] [ avrate BPS ] [ overhe=
ad OVERHEAD ] [ atm ]\n");
 	fprintf(stderr, "                [ ACTIONTERM ]\n");
 	fprintf(stderr, "Old Syntax ACTIONTERM :=3D action <EXCEEDACT>[/NOTEXCEED=
ACT] \n");=20
 	fprintf(stderr, "New Syntax ACTIONTERM :=3D conform-exceed <EXCEEDACT>[/N=
OTEXCEEDACT] \n");=20
@@ -134,7 +134,10 @@ int act_parse_police(struct action_util=20
 	__u32 ptab[256];
 	__u32 avrate =3D 0;
 	int presult =3D 0;
-	unsigned buffer=3D0, mtu=3D0, mpu=3D0;
+	unsigned buffer=3D0, mtu=3D0;
+	__u8 mpu=3D0;
+	__s8 overhead=3D0;
+	int atm=3D0;
 	int Rcell_log=3D-1, Pcell_log =3D -1;=20
 	struct rtattr *tail;
=20
@@ -184,7 +187,7 @@ int act_parse_police(struct action_util=20
 				fprintf(stderr, "Double \"mpu\" spec\n");
 				return -1;
 			}
-			if (get_size(&mpu, *argv)) {
+			if (get_u8(&mpu, *argv, 10)) {
 				explain1("mpu");
 				return -1;
 			}
@@ -198,6 +201,18 @@ int act_parse_police(struct action_util=20
 				explain1("rate");
 				return -1;
 			}
+		} else if (strcmp(*argv, "overhead") =3D=3D 0) {
+			NEXT_ARG();
+			if (p.rate.rate) {
+				fprintf(stderr, "Double \"overhead\" spec\n");
+				return -1;
+			}
+			if (get_s8(&overhead, *argv, 10)) {
+				explain1("overhead");
+				return -1;
+			}
+		} else if (strcmp(*argv, "atm") =3D=3D 0) {
+		  	atm =3D 1;
 		} else if (strcmp(*argv, "avrate") =3D=3D 0) {
 			NEXT_ARG();
 			if (avrate) {
@@ -264,22 +279,12 @@ int act_parse_police(struct action_util=20
 	}
=20
 	if (p.rate.rate) {
-		if ((Rcell_log =3D tc_calc_rtable(p.rate.rate, rtab, Rcell_log, mtu, mpu=
)) < 0) {
-			fprintf(stderr, "TBF: failed to calculate rate table.\n");
-			return -1;
-		}
+	  	tc_calc_ratespec(&p.rate, rtab, p.rate.rate, Rcell_log, mtu, mpu, atm,=
 overhead);
 		p.burst =3D tc_calc_xmittime(p.rate.rate, buffer);
-		p.rate.cell_log =3D Rcell_log;
-		p.rate.mpu =3D mpu;
 	}
 	p.mtu =3D mtu;
 	if (p.peakrate.rate) {
-		if ((Pcell_log =3D tc_calc_rtable(p.peakrate.rate, ptab, Pcell_log, mtu,=
 mpu)) < 0) {
-			fprintf(stderr, "POLICE: failed to calculate peak rate table.\n");
-			return -1;
-		}
-		p.peakrate.cell_log =3D Pcell_log;
-		p.peakrate.mpu =3D mpu;
+	  	tc_calc_ratespec(&p.peakrate, ptab, p.peakrate.rate, Pcell_log, mtu, m=
pu, atm, overhead);
 	}
=20
 	tail =3D NLMSG_TAIL(n);
diff -Nurp iproute2.orig/tc/q_cbq.c iproute2/tc/q_cbq.c
--- iproute2.orig/tc/q_cbq.c	2005-07-06 08:37:15.000000000 +1000
+++ iproute2/tc/q_cbq.c	2006-06-13 11:53:27.000000000 +1000
@@ -32,6 +32,7 @@ static void explain_class(void)
 	fprintf(stderr, "               [ prio NUMBER ] [ cell BYTES ] [ ewma LOG=
 ]\n");
 	fprintf(stderr, "               [ estimator INTERVAL TIME_CONSTANT ]\n");
 	fprintf(stderr, "               [ split CLASSID ] [ defmap MASK/CHANGE ]\=
n");
+	fprintf(stderr, "               [ overhead BYTES ] [ atm ]\n");
 }
=20
 static void explain(void)
@@ -52,7 +53,10 @@ static int cbq_parse_opt(struct qdisc_ut
 	struct tc_ratespec r;
 	struct tc_cbq_lssopt lss;
 	__u32 rtab[256];
-	unsigned mpu=3D0, avpkt=3D0, allot=3D0;
+	unsigned avpkt=3D0, allot=3D0;
+	__u8 mpu=3D0;
+	__s8 overhead=3D0;
+	int atm=3D0;
 	int cell_log=3D-1;=20
 	int ewma_log=3D-1;
 	struct rtattr *tail;
@@ -102,7 +106,7 @@ static int cbq_parse_opt(struct qdisc_ut
 			}
 		} else if (strcmp(*argv, "mpu") =3D=3D 0) {
 			NEXT_ARG();
-			if (get_size(&mpu, *argv)) {
+			if (get_u8(&mpu, *argv, 10)) {
 				explain1("mpu");
 				return -1;
 			}
@@ -113,6 +117,14 @@ static int cbq_parse_opt(struct qdisc_ut
 				explain1("allot");
 				return -1;
 			}
+		} else if (strcmp(*argv, "overhead") =3D=3D 0) {
+			NEXT_ARG();
+			if (get_s8(&overhead, *argv, 10)) {
+				explain1("overhead");
+				return -1;
+			}
+		} else if (strcmp(*argv, "atm") =3D=3D 0) {
+		  	atm =3D 1;
 		} else if (strcmp(*argv, "help") =3D=3D 0) {
 			explain();
 			return -1;
@@ -137,12 +149,7 @@ static int cbq_parse_opt(struct qdisc_ut
 	if (allot < (avpkt*3)/2)
 		allot =3D (avpkt*3)/2;
=20
-	if ((cell_log =3D tc_calc_rtable(r.rate, rtab, cell_log, allot, mpu)) < 0=
) {
-		fprintf(stderr, "CBQ: failed to calculate rate table.\n");
-		return -1;
-	}
-	r.cell_log =3D cell_log;
-	r.mpu =3D mpu;
+	tc_calc_ratespec(&r, rtab, r.rate, cell_log, allot, mpu, atm, overhead);
=20
 	if (ewma_log < 0)
 		ewma_log =3D TC_CBQ_DEF_EWMA;
@@ -175,7 +182,9 @@ static int cbq_parse_class_opt(struct qd
 	struct tc_cbq_fopt fopt;
 	struct tc_cbq_ovl ovl;
 	__u32 rtab[256];
-	unsigned mpu=3D0;
+	__u8 mpu=3D0;
+	__s8 overhead =3D 0;
+	int atm =3D 0;
 	int cell_log=3D-1;=20
 	int ewma_log=3D-1;
 	unsigned bndw =3D 0;
@@ -289,10 +298,18 @@ static int cbq_parse_class_opt(struct qd
 			lss.change |=3D TCF_CBQ_LSS_AVPKT;
 		} else if (strcmp(*argv, "mpu") =3D=3D 0) {
 			NEXT_ARG();
-			if (get_size(&mpu, *argv)) {
+			if (get_u8(&mpu, *argv, 10)) {
 				explain1("mpu");
 				return -1;
 			}
+		} else if (strcmp(*argv, "overhead") =3D=3D 0) {
+			NEXT_ARG();
+			if (get_s8(&overhead, *argv, 10)) {
+				explain1("overhead");
+				return -1;
+			}
+		} else if (strcmp(*argv, "atm") =3D=3D 0) {
+		  	atm =3D 1;
 		} else if (strcmp(*argv, "weight") =3D=3D 0) {
 			NEXT_ARG();
 			if (get_size(&wrr.weight, *argv)) {
@@ -336,12 +353,7 @@ static int cbq_parse_class_opt(struct qd
 		unsigned pktsize =3D wrr.allot;
 		if (wrr.allot < (lss.avpkt*3)/2)
 			wrr.allot =3D (lss.avpkt*3)/2;
-		if ((cell_log =3D tc_calc_rtable(r.rate, rtab, cell_log, pktsize, mpu)) =
< 0) {
-			fprintf(stderr, "CBQ: failed to calculate rate table.\n");
-			return -1;
-		}
-		r.cell_log =3D cell_log;
-		r.mpu =3D mpu;
+		tc_calc_ratespec(&r, rtab, r.rate, cell_log, pktsize, mpu, atm, overhead=
);
 	}
 	if (ewma_log < 0)
 		ewma_log =3D TC_CBQ_DEF_EWMA;
@@ -463,8 +475,12 @@ static int cbq_print_opt(struct qdisc_ut
 		fprintf(f, "rate %s ", buf);
 		if (show_details) {
 			fprintf(f, "cell %ub ", 1<<r->cell_log);
-			if (r->mpu)
-				fprintf(f, "mpu %ub ", r->mpu);
+			if (r->mpu & 0xff)
+				fprintf(f, "mpu %ub ", (__u8)r->mpu);
+			if ((r->mpu >> 8))
+				fprintf(f, "overhead %db ", (__s8)(r->mpu >> 8));
+			if (r->feature & 0x0001)
+				fprintf(f, "atm ");
 		}
 	}
 	if (lss && lss->flags) {
diff -Nurp iproute2.orig/tc/q_htb.c iproute2/tc/q_htb.c
--- iproute2.orig/tc/q_htb.c	2005-01-19 08:11:58.000000000 +1000
+++ iproute2/tc/q_htb.c	2006-06-13 11:53:27.000000000 +1000
@@ -34,14 +34,14 @@ static void explain(void)
 		" default  minor id of class to which unclassified packets are sent {0}\=
n"
 		" r2q      DRR quantums are computed as rate in Bps/r2q {10}\n"
 		" debug    string of 16 numbers each 0-3 {0}\n\n"
-		"... class add ... htb rate R1 [burst B1] [mpu B] [overhead O]\n"
+		"... class add ... htb rate R1 [burst B1] [mpu B] [overhead O] [atm]\n"
 		"                      [prio P] [slot S] [pslot PS]\n"
 		"                      [ceil R2] [cburst B2] [mtu MTU] [quantum Q]\n"
 		" rate     rate allocated to this class (class can still borrow)\n"
 		" burst    max bytes burst which can be accumulated during idle period {=
computed}\n"
 		" mpu      minimum packet size used in rate computations\n"
 		" overhead per-packet size overhead used in rate computations\n"
-
+		" atm      include atm cell tax in rate computations\n"
 		" ceil     definite upper class rate (no borrows) {rate}\n"
 		" cburst   burst but for ceil {computed}\n"
 		" mtu      max packet size we create rate map for {1600}\n"
@@ -107,8 +107,10 @@ static int htb_parse_class_opt(struct qd
 	__u32 rtab[256],ctab[256];
 	unsigned buffer=3D0,cbuffer=3D0;
 	int cell_log=3D-1,ccell_log =3D -1;
-	unsigned mtu, mpu;
-	unsigned char mpu8 =3D 0, overhead =3D 0;
+	unsigned mtu;
+	__u8 mpu8=3D0;
+	__s8 overhead=3D0;
+	int atm=3D0;
 	struct rtattr *tail;
=20
 	memset(&opt, 0, sizeof(opt)); mtu =3D 1600; /* eth packet len */
@@ -132,9 +134,11 @@ static int htb_parse_class_opt(struct qd
 			}
 		} else if (matches(*argv, "overhead") =3D=3D 0) {
 			NEXT_ARG();
-			if (get_u8(&overhead, *argv, 10)) {
+			if (get_s8(&overhead, *argv, 10)) {
 				explain1("overhead"); return -1;
 			}
+		} else if (matches(*argv, "atm") =3D=3D 0) {
+			atm =3D 1;
 		} else if (matches(*argv, "quantum") =3D=3D 0) {
 			NEXT_ARG();
 			if (get_u32(&opt.quantum, *argv, 10)) {
@@ -206,23 +210,11 @@ static int htb_parse_class_opt(struct qd
 	if (!buffer) buffer =3D opt.rate.rate / get_hz() + mtu;
 	if (!cbuffer) cbuffer =3D opt.ceil.rate / get_hz() + mtu;
=20
-/* encode overhead and mpu, 8 bits each, into lower 16 bits */
-	mpu =3D (unsigned)mpu8 | (unsigned)overhead << 8;
-	opt.ceil.mpu =3D mpu; opt.rate.mpu =3D mpu;
-
-	if ((cell_log =3D tc_calc_rtable(opt.rate.rate, rtab, cell_log, mtu, mpu)=
) < 0) {
-		fprintf(stderr, "htb: failed to calculate rate table.\n");
-		return -1;
-	}
+	/* encode overhead and mpu, 8 bits each, into lower 16 bits */
+	tc_calc_ratespec(&opt.rate, rtab, opt.rate.rate, cell_log, mtu, mpu8, atm=
, overhead);
+	tc_calc_ratespec(&opt.ceil, ctab, opt.ceil.rate, cell_log, mtu, mpu8, atm=
, overhead);
 	opt.buffer =3D tc_calc_xmittime(opt.rate.rate, buffer);
-	opt.rate.cell_log =3D cell_log;
-=09
-	if ((ccell_log =3D tc_calc_rtable(opt.ceil.rate, ctab, cell_log, mtu, mpu=
)) < 0) {
-		fprintf(stderr, "htb: failed to calculate ceil rate table.\n");
-		return -1;
-	}
 	opt.cbuffer =3D tc_calc_xmittime(opt.ceil.rate, cbuffer);
-	opt.ceil.cell_log =3D ccell_log;
=20
 	tail =3D NLMSG_TAIL(n);
 	addattr_l(n, 1024, TCA_OPTIONS, NULL, 0);
@@ -267,12 +259,16 @@ static int htb_print_opt(struct qdisc_ut
 			sprint_size(buffer, b1),
 			1<<hopt->rate.cell_log,
 			sprint_size(hopt->rate.mpu&0xFF, b2),
-			sprint_size((hopt->rate.mpu>>8)&0xFF, b3));
+			sprint_size((__s8)(hopt->rate.mpu>>8), b3));
+		if (hopt->rate.feature & 0x0001)
+			fprintf(f, "atm ");
 		fprintf(f, "cburst %s/%u mpu %s overhead %s ",
 			sprint_size(cbuffer, b1),
 			1<<hopt->ceil.cell_log,
 			sprint_size(hopt->ceil.mpu&0xFF, b2),
-			sprint_size((hopt->ceil.mpu>>8)&0xFF, b3));
+			sprint_size((__s8)(hopt->ceil.mpu>>8), b3));
+		if (hopt->ceil.feature & 0x0001)
+			fprintf(f, "atm ");
 		fprintf(f, "level %d ", (int)hopt->level);
 	    } else {
 		fprintf(f, "burst %s ", sprint_size(buffer, b1));
diff -Nurp iproute2.orig/tc/q_tbf.c iproute2/tc/q_tbf.c
--- iproute2.orig/tc/q_tbf.c	2005-01-19 08:11:58.000000000 +1000
+++ iproute2/tc/q_tbf.c	2006-06-13 11:53:27.000000000 +1000
@@ -26,7 +26,7 @@
 static void explain(void)
 {
 	fprintf(stderr, "Usage: ... tbf limit BYTES burst BYTES[/BYTES] rate KBPS=
 [ mtu BYTES[/BYTES] ]\n");
-	fprintf(stderr, "               [ peakrate KBPS ] [ latency TIME ]\n");
+	fprintf(stderr, "               [ peakrate KBPS ] [ latency TIME ] [ over=
head OVERHEAD ] [ atm ]\n");
 }
=20
 static void explain1(char *arg)
@@ -43,7 +43,10 @@ static int tbf_parse_opt(struct qdisc_ut
 	struct tc_tbf_qopt opt;
 	__u32 rtab[256];
 	__u32 ptab[256];
-	unsigned buffer=3D0, mtu=3D0, mpu=3D0, latency=3D0;
+	unsigned buffer=3D0, mtu=3D0, latency=3D0;
+	__u8 mpu=3D0;
+	__s8 overhead=3D0;
+	int atm=3D0;
 	int Rcell_log=3D-1, Pcell_log =3D -1;=20
 	struct rtattr *tail;
=20
@@ -103,7 +106,7 @@ static int tbf_parse_opt(struct qdisc_ut
 				fprintf(stderr, "Double \"mpu\" spec\n");
 				return -1;
 			}
-			if (get_size(&mpu, *argv)) {
+			if (get_u8(&mpu, *argv, 10)) {
 				explain1("mpu");
 				return -1;
 			}
@@ -119,6 +122,20 @@ static int tbf_parse_opt(struct qdisc_ut
 				return -1;
 			}
 			ok++;
+		} else if (strcmp(*argv, "overhead") =3D=3D 0) {
+			NEXT_ARG();
+			if (overhead) {
+				fprintf(stderr, "Double \"overhead\" spec\n");
+				return -1;
+			}
+			if (get_s8(&overhead, *argv, 10)) {
+				explain1("overhead");
+				return -1;
+			}
+			ok++;
+		} else if (strcmp(*argv, "atm") =3D=3D 0) {
+			atm =3D 1;
+			ok++;
 		} else if (matches(*argv, "peakrate") =3D=3D 0) {
 			NEXT_ARG();
 			if (opt.peakrate.rate) {
@@ -170,21 +187,11 @@ static int tbf_parse_opt(struct qdisc_ut
 		opt.limit =3D lim;
 	}
=20
-	if ((Rcell_log =3D tc_calc_rtable(opt.rate.rate, rtab, Rcell_log, mtu, mp=
u)) < 0) {
-		fprintf(stderr, "TBF: failed to calculate rate table.\n");
-		return -1;
-	}
+	tc_calc_ratespec(&opt.rate, rtab, opt.rate.rate, Rcell_log, mtu, mpu, atm=
, overhead);
 	opt.buffer =3D tc_calc_xmittime(opt.rate.rate, buffer);
-	opt.rate.cell_log =3D Rcell_log;
-	opt.rate.mpu =3D mpu;
 	if (opt.peakrate.rate) {
-		if ((Pcell_log =3D tc_calc_rtable(opt.peakrate.rate, ptab, Pcell_log, mt=
u, mpu)) < 0) {
-			fprintf(stderr, "TBF: failed to calculate peak rate table.\n");
-			return -1;
-		}
+	  	tc_calc_ratespec(&opt.peakrate, ptab, opt.peakrate.rate, Pcell_log, mt=
u, mpu, atm, overhead);
 		opt.mtu =3D tc_calc_xmittime(opt.peakrate.rate, mtu);
-		opt.peakrate.cell_log =3D Pcell_log;
-		opt.peakrate.mpu =3D mpu;
 	}
=20
 	tail =3D NLMSG_TAIL(n);
@@ -220,8 +227,12 @@ static int tbf_print_opt(struct qdisc_ut
 	fprintf(f, "rate %s ", sprint_rate(qopt->rate.rate, b1));
 	buffer =3D ((double)qopt->rate.rate*tc_core_tick2usec(qopt->buffer))/1000=
000;
 	if (show_details) {
-		fprintf(f, "burst %s/%u mpu %s ", sprint_size(buffer, b1),
-			1<<qopt->rate.cell_log, sprint_size(qopt->rate.mpu, b2));
+		fprintf(f, "burst %s/%u mpu %s overhead %d ", sprint_size(buffer, b1),
+			1<<qopt->rate.cell_log,
+			sprint_size(qopt->rate.mpu & 0xFF, b2),
+			(__s8)(qopt->rate.mpu >> 8));
+		if (qopt->rate.feature & 0x0001)
+			fprintf(f, "atm ");
 	} else {
 		fprintf(f, "burst %s ", sprint_size(buffer, b1));
 	}
@@ -232,8 +243,12 @@ static int tbf_print_opt(struct qdisc_ut
 		if (qopt->mtu || qopt->peakrate.mpu) {
 			mtu =3D ((double)qopt->peakrate.rate*tc_core_tick2usec(qopt->mtu))/1000=
000;
 			if (show_details) {
-				fprintf(f, "mtu %s/%u mpu %s ", sprint_size(mtu, b1),
-					1<<qopt->peakrate.cell_log, sprint_size(qopt->peakrate.mpu, b2));
+				fprintf(f, "mtu %s/%u mpu %s overhead %d ", sprint_size(mtu, b1),
+					1<<qopt->peakrate.cell_log,
+					sprint_size(qopt->peakrate.mpu & 0xFF, b2),
+					(__s8)(qopt->peakrate.mpu >> 8));
+				if (qopt->peakrate.feature & 0x0001)
+					fprintf(f, "atm ");
 			} else {
 				fprintf(f, "minburst %s ", sprint_size(mtu, b1));
 			}
diff -Nurp iproute2.orig/tc/tc_core.c iproute2/tc/tc_core.c
--- iproute2.orig/tc/tc_core.c	2004-07-31 06:26:15.000000000 +1000
+++ iproute2/tc/tc_core.c	2006-06-13 11:53:27.000000000 +1000
@@ -23,6 +23,9 @@
=20
 #include "tc_core.h"
=20
+#define	ATM_CELL_SIZE		53
+#define	ATM_CELL_PAYLOAD	48
+
 static __u32 t2us=3D1;
 static __u32 us2t=3D1;
 static double tick_in_usec =3D 1;
@@ -43,33 +46,124 @@ unsigned tc_calc_xmittime(unsigned rate,
 }
=20
 /*
-   rtab[pkt_len>>cell_log] =3D pkt_xmit_time
+ * Calculate the ATM cell overhead.  ATM sends each packet in 48 byte
+ * chunks, the last chunk being padded if necessary.  Each chunk carries
+ * an additional 5 byte overhead - the ATM header.
  */
+static int tc_align_to_cells(int size)=20
+{
+	int cells;
+
+	cells =3D size / ATM_CELL_PAYLOAD;
+	if (size % ATM_CELL_PAYLOAD !=3D 0)
+		cells++;
+	return cells * ATM_CELL_SIZE;
+}
=20
-int tc_calc_rtable(unsigned bps, __u32 *rtab, int cell_log, unsigned mtu,
-		   unsigned mpu)
+/*
+ * The number this function calculates is subtle.  Ignore it and just beli=
eve
+ * it works if you have a choice, otherwise ..
+ *
+ * If there we are calculating the ATM cell overhead the kernel calculatio=
ns
+ * will be out sometimes if the range of packet sizes spanned by one
+ * rate table element crosses an ATM cell boundary.  Consider these three
+ * senarios:
+ *    (a) the packet is sent across the ATM link without addition
+ *        overheads the kernel doesn't know about, and
+ *    (b) a packet that has 1 byte of additional overhead the kernel
+ *        doesn't know about.  Here
+ *    (c) a packet that has 2 bytes of additional overhead the
+ *        kernel doesn't know about.
+ * The table below presents what happens.  Each row is for a single rate
+ * table element.  The "Sizes" column shows what packet sizes the rate tab=
le
+ * element will be used for.  This packet size includes the "unknown to
+ * kernel" overhead, but does not include overhead incurred by breaking th=
e
+ * packet up into ATM cells. This ATM cell overhead consists of the 5 byte
+ * header per ATM cell, plus the padding in the last cell.  The "ATM" colu=
mn
+ * shows how many bytes are actually sent across the ATM link, ie it does
+ * include the ATM cell overhead.
+ *
+ *   RateTable Entry  Sizes(a) ATM(a)    Sizes(b) ATM(b)   Sizes(c) ATM(c)
+ *      ratetable[0]    0..7    53        1..8     53        2..9    53
+ *      ratetable[1]    8..15   53        9..16    53        2..17   53
+ *      ratetable[2]   16..23   53       17..24    53       18..25   53
+ *      ratetable[3]   24..31   53       25..32    53       26..33   53
+ *      ratetable[4]   32..39   53       33..40    53       34..41   53
+ *      ratetable[5]   40..47   53       41..48    53       42..49   53,10=
6
+ *      ratetable[6]   48..55   53,106   49..56   106       50..57  106
+ *
+ * For senario (a), the ratetable[6] entry covers two cases: one were a si=
ngle
+ * ATM cell is needed to transmit the data, and one where two ATM cells ar=
e
+ * required.  It can't be right for both.  Unfortunately the error is larg=
e.
+ * The same problem arises in senario (c) for ratetable[5].  The problem
+ * doesn't happen for senario (b), because the boundary between rate table
+ * entries happens to match the boundary between ATM cells.
+ *
+ * What we would like to do is ensure that ratetable boundaries always mat=
ch
+ * the ATM cells.  If we do this the error goes away.  The solution is to =
make
+ * the kernel add a small bias to the packet size.  (Small because the bia=
s
+ * will always be smaller than cell_log.)  Adding this small bias will in
+ * effect slide the ratetable along a bit, so the boundaries match.  The c=
ode
+ * below calculates that bias.  Provided the MTU is less than 4092, doing
+ * this can always eliminate the error.
+ *
+ * Old kernels won't add this bias, so they will have the error described =
above
+ * in most cases.  In the worst case senario, considering all possible ATM=
 cell
+ * sizes (1..48), for 7 of these sizes the old kernel will calculate the r=
ate
+ * wrongly - ie, be out by 53 bytes.
+ */
+static int tc_calc_cell_align(int atm_cell_tax, char overhead, int cell_lo=
g)
+{
+	int cell_size;
+
+  	if (!atm_cell_tax)
+	  	return 0;
+	cell_size =3D 1 << cell_log;
+	return (overhead + cell_size - 2) % cell_size - cell_size + 1;
+}
+
+
+/*
+ * A constructor for a tc_ratespec.
+ */
+void tc_calc_ratespec(struct tc_ratespec* spec, __u32* rtab, unsigned bps,
+	int cell_log, unsigned mtu, unsigned char mpu, int atm_cell_tax,
+	char overhead)
 {
 	int i;
-	unsigned overhead =3D (mpu >> 8) & 0xFF;
-	mpu =3D mpu & 0xFF;
=20
 	if (mtu =3D=3D 0)
 		mtu =3D 2047;
=20
+	/* rtab[pkt_len>>cell_log] =3D pkt_xmit_time */
 	if (cell_log < 0) {
 		cell_log =3D 0;
 		while ((mtu>>cell_log) > 255)
 			cell_log++;
 	}
+
 	for (i=3D0; i<256; i++) {
-		unsigned sz =3D (i<<cell_log);
-		if (overhead)
-			sz +=3D overhead;
+	  	/*
+		 * sz is the length of packet we will use for this ratetable
+		 * entry.  The time taken to send a packet of this length will
+		 * be used for all packet lengths this ratetable entry applies
+		 * to.  As underestimating how long it will take to transmit a
+		 * packet is a worse error than overestimating it, the longest
+		 * packet this rate table entry applies to is used.
+		 */
+		int sz =3D ((i+1)<<cell_log) - 1 + overhead;
 		if (sz < mpu)
 			sz =3D mpu;
-		rtab[i] =3D tc_core_usec2tick(1000000*((double)sz/bps));
+		if (atm_cell_tax)
+			sz =3D tc_align_to_cells(sz);
+		rtab[i] =3D tc_calc_xmittime(bps, sz);
 	}
-	return cell_log;
+
+	spec->cell_align =3D tc_calc_cell_align(atm_cell_tax, overhead, cell_log)=
;
+	spec->cell_log =3D cell_log;
+	spec->feature =3D 0x8000 | (atm_cell_tax ? 1 : 0);
+	spec->mpu =3D mpu | (unsigned)(overhead << 8);
+	spec->rate =3D bps;
 }
=20
 int tc_core_init()
diff -Nurp iproute2.orig/tc/tc_core.h iproute2/tc/tc_core.h
--- iproute2.orig/tc/tc_core.h	2005-03-15 05:02:41.000000000 +1000
+++ iproute2/tc/tc_core.h	2006-06-13 11:53:27.000000000 +1000
@@ -7,7 +7,9 @@
 long tc_core_usec2tick(long usec);
 long tc_core_tick2usec(long tick);
 unsigned tc_calc_xmittime(unsigned rate, unsigned size);
-int tc_calc_rtable(unsigned bps, __u32 *rtab, int cell_log, unsigned mtu, =
unsigned mpu);
+void tc_calc_ratespec(struct tc_ratespec* spec, __u32* rtab, unsigned bps,
+	int cell_log, unsigned mtu, unsigned char mpu, int atm_cell_tax,
+	char overhead);
=20
 int tc_setup_estimator(unsigned A, unsigned time_const, struct tc_estimato=
r *est);
=20


--=-7IT4k+pTt2geUIR4Mfxf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEj9mYwuVH+NB3fZkRAiitAJ9FvBMtlRasfhPCldzRdQovN74OCQCgiN/d
adNKeU9TAmWqXTnTxYe3CEc=
=xJkK
-----END PGP SIGNATURE-----

--=-7IT4k+pTt2geUIR4Mfxf--

