Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUDWO2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUDWO2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbUDWO2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:28:48 -0400
Received: from seraph3.grc.nasa.gov ([128.156.10.12]:17850 "EHLO
	seraph3.grc.nasa.gov") by vger.kernel.org with ESMTP
	id S264822AbUDWO2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:28:09 -0400
Date: Fri, 23 Apr 2004 10:24:45 -0400
From: Wesley Eddy <weddy@grc.nasa.gov>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: TCP rto estimation patch
Message-ID: <20040423142445.GC501@grc.nasa.gov>
Reply-To: weddy@grc.nasa.gov
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
X-People-Whose-Mailers-Cant-See-This-Header-Are-Lame: true
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The TCP RTO estimation algorithm defined in RFC 2988 is followed properly
in the kernel, however the constants alpha and beta in the specification
are hardcoded as 3 and 2 everywhere they occur in the kernel.  Since these
constants crop up multiple times, this is poor programming practice.  This
patch binds the numeric values to symbols RTT_ALPHA and RTTVAR_BETA, and
uses those symbolic values throughout the code.  Since using 2 and 3 for
these values is not mandatory, this makes tweaking them much easier.

-Wes


diff -ur linux-2.6.5/include/linux/tcp.h linux-2.6.5-weddy/include/linux/tc=
p.h
--- linux-2.6.5/include/linux/tcp.h     2004-04-03 22:37:06.000000000 -0500
+++ linux-2.6.5-weddy/include/linux/tcp.h       2004-04-21 16:05:38.0000000=
00 -0
400
@@ -406,4 +406,8 @@
=20
 #endif
=20
+/* weights for RTO estimator from RFC 2988 */
+#define RTT_ALPHA 3
+#define RTTVAR_BETA 2
+
 #endif /* _LINUX_TCP_H */
diff -ur linux-2.6.5/net/ipv4/tcp.c linux-2.6.5-weddy/net/ipv4/tcp.c
--- linux-2.6.5/net/ipv4/tcp.c  2004-04-03 22:36:53.000000000 -0500
+++ linux-2.6.5-weddy/net/ipv4/tcp.c    2004-04-21 16:00:29.000000000 -0400
@@ -2538,8 +2538,8 @@
=20
                info.tcpi_pmtu =3D tp->pmtu_cookie;
                info.tcpi_rcv_ssthresh =3D tp->rcv_ssthresh;
-               info.tcpi_rtt =3D ((1000000 * tp->srtt) / HZ) >> 3;
-               info.tcpi_rttvar =3D ((1000000 * tp->mdev) / HZ) >> 2;
+               info.tcpi_rtt =3D ((1000000 * tp->srtt) / HZ) >> RTT_ALPHA;
+               info.tcpi_rttvar =3D ((1000000 * tp->mdev) / HZ) >> RTTVAR_=
BETA;
                info.tcpi_snd_ssthresh =3D tp->snd_ssthresh;
                info.tcpi_snd_cwnd =3D tp->snd_cwnd;
                info.tcpi_advmss =3D tp->advmss;
diff -ur linux-2.6.5/net/ipv4/tcp_diag.c linux-2.6.5-weddy/net/ipv4/tcp_dia=
g.c
--- linux-2.6.5/net/ipv4/tcp_diag.c     2004-04-03 22:36:14.000000000 -0500
+++ linux-2.6.5-weddy/net/ipv4/tcp_diag.c       2004-04-21 16:01:08.0000000=
00 -0
400
@@ -188,8 +188,8 @@
=20
                info->tcpi_pmtu =3D tp->pmtu_cookie;
                info->tcpi_rcv_ssthresh =3D tp->rcv_ssthresh;
-               info->tcpi_rtt =3D ((1000000*tp->srtt)/HZ)>>3;
-               info->tcpi_rttvar =3D ((1000000*tp->mdev)/HZ)>>2;
+               info->tcpi_rtt =3D ((1000000*tp->srtt)/HZ)>>RTT_ALPHA;
+               info->tcpi_rttvar =3D ((1000000*tp->mdev)/HZ)>>RTTVAR_BETA;
                info->tcpi_snd_ssthresh =3D tp->snd_ssthresh;
                info->tcpi_snd_cwnd =3D tp->snd_cwnd;
                info->tcpi_advmss =3D tp->advmss;
diff -ur linux-2.6.5/net/ipv4/tcp_input.c linux-2.6.5-weddy/net/ipv4/tcp_in=
put.c
--- linux-2.6.5/net/ipv4/tcp_input.c    2004-04-03 22:37:39.000000000 -0500
+++ linux-2.6.5-weddy/net/ipv4/tcp_input.c      2004-04-21 15:59:25.0000000=
00 -0
400
@@ -435,11 +435,12 @@
        if(m =3D=3D 0)
                m =3D 1;
        if (tp->srtt !=3D 0) {
-               m -=3D (tp->srtt >> 3);   /* m is now error in rtt est */
+               m -=3D (tp->srtt >> RTT_ALPHA);   /* m is now error in rtt =
est */
                tp->srtt +=3D m;          /* rtt =3D 7/8 rtt + 1/8 new */
                if (m < 0) {
                        m =3D -m;         /* m is now abs(error) */
-                       m -=3D (tp->mdev >> 2);   /* similar update on mdev=
 */
+                       /* similar update on mdev */
+                       m -=3D (tp->mdev >> RTTVAR_BETA);
                        /* This is similar to one of Eifel findings.
                         * Eifel blocks mdev updates when rtt decreases.
                         * This solution is a bit different: we use finer g=
ain
@@ -449,9 +450,10 @@
                         * happening in pure Eifel.
                         */
                        if (m > 0)
-                               m >>=3D 3;
+                               m >>=3D RTT_ALPHA;
                } else {
-                       m -=3D (tp->mdev >> 2);   /* similar update on mdev=
 */
+                       /* similar update on mdev */
+                       m -=3D (tp->mdev >> RTTVAR_BETA);
                }
                tp->mdev +=3D m;          /* mdev =3D 3/4 mdev + 1/4 new */
                if (tp->mdev > tp->mdev_max) {
@@ -461,19 +463,21 @@
                }
                if (after(tp->snd_una, tp->rtt_seq)) {
                        if (tp->mdev_max < tp->rttvar)
-                               tp->rttvar -=3D (tp->rttvar-tp->mdev_max)>>=
2;
+                               tp->rttvar -=3D (tp->rttvar-tp->mdev_max) >>
+                                             RTTVAR_BETA;
                        tp->rtt_seq =3D tp->snd_nxt;
                        tp->mdev_max =3D TCP_RTO_MIN;
                }
        } else {
                /* no previous measure. */
-               tp->srtt =3D m<<3;        /* take the measured time to be r=
tt */
-               tp->mdev =3D m<<1;        /* make sure rto =3D 3*rtt */
+               /* take the measured time to be rtt */
+               tp->srtt =3D m<<RTT_ALPHA;
+               tp->mdev =3D m<< (RTTVAR_BETA-1); /* make sure rto =3D 3*rt=
t */
                tp->mdev_max =3D tp->rttvar =3D max(tp->mdev, TCP_RTO_MIN);
                tp->rtt_seq =3D tp->snd_nxt;
        }
=20
-       tcp_westwood_update_rtt(tp, tp->srtt >> 3);
+       tcp_westwood_update_rtt(tp, tp->srtt >> RTT_ALPHA);
 }
=20
 /* Calculate rto without backoff.  This is the second half of Van Jacobson=
's
@@ -491,7 +495,7 @@
         *    is invisible. Actually, Linux-2.4 also generates erratic
         *    ACKs in some curcumstances.
         */
-       tp->rto =3D (tp->srtt >> 3) + tp->rttvar;
+       tp->rto =3D (tp->srtt >> RTT_ALPHA) + tp->rttvar;
=20
        /* 2. Fixups made earlier cannot be right.
         *    If we do not estimate RTO correctly without them,
@@ -543,7 +547,7 @@
                        if (m <=3D 0)
                                dst->metrics[RTAX_RTT-1] =3D tp->srtt;
                        else
-                               dst->metrics[RTAX_RTT-1] -=3D (m>>3);
+                               dst->metrics[RTAX_RTT-1] -=3D (m>>RTT_ALPHA=
);
                }
=20
                if (!(dst_metric_locked(dst, RTAX_RTTVAR))) {
@@ -551,7 +555,7 @@
                                m =3D -m;
=20
                        /* Scale deviation to rttvar fixed point */
-                       m >>=3D 1;
+                       m >>=3D (RTT_ALPHA-RTTVAR_BETA);
                        if (m < tp->mdev)
                                m =3D tp->mdev;
=20
@@ -559,7 +563,8 @@
                                dst->metrics[RTAX_RTTVAR-1] =3D m;
                        else
                                dst->metrics[RTAX_RTTVAR-1] -=3D
-                                       (dst->metrics[RTAX_RTTVAR-1] - m)>>=
2;
+                                 (dst->metrics[RTAX_RTTVAR-1] - m ) >>
+                                 RTTVAR_BETA;
                }
=20
                if (tp->snd_ssthresh >=3D 0xFFFF) {
@@ -641,7 +646,8 @@
        if (dst_metric(dst, RTAX_RTT) =3D=3D 0)
                goto reset;
=20
-       if (!tp->srtt && dst_metric(dst, RTAX_RTT) < (TCP_TIMEOUT_INIT << 3=
))
+       if (!tp->srtt && dst_metric(dst, RTAX_RTT) <
+                        (TCP_TIMEOUT_INIT << RTT_ALPHA))
                goto reset;
=20
        /* Initial rtt is determined from SYN,SYN-ACK.
@@ -2083,7 +2089,7 @@
=20
 static inline __u32 westwood_do_filter(__u32 a, __u32 b)
 {
-       return (((7 * a) + b) >> 3);
+       return ((7 * a) + b) >> 3;
 }
=20
 static void westwood_filter(struct sock *sk, __u32 delta)
diff -ur linux-2.6.5/net/ipv4/tcp_output.c linux-2.6.5-weddy/net/ipv4/tcp_o=
utput
=2Ec
--- linux-2.6.5/net/ipv4/tcp_output.c   2004-04-03 22:37:36.000000000 -0500
+++ linux-2.6.5-weddy/net/ipv4/tcp_output.c     2004-04-21 16:00:39.0000000=
00 -0
400
@@ -1356,7 +1356,7 @@
                 * directly.
                 */
                if (tp->srtt) {
-                       int rtt =3D max(tp->srtt>>3, TCP_DELACK_MIN);
+                       int rtt =3D max(tp->srtt>>RTT_ALPHA, TCP_DELACK_MIN=
);
=20
                        if (rtt < max_ato)
                                max_ato =3D rtt;

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAiSctzBuYqbnj3IwRAshIAJ9eBL6B6MVMwMziOvOyt7xyFKXOmgCcDO3w
lHZ2p2mCEVYLBUPrEJ/BJNU=
=/6Bl
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
