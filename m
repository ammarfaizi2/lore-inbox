Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUJEOH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUJEOH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUJEOH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:07:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:19854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269193AbUJEOFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:05:43 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm2
Date: Tue, 5 Oct 2004 16:07:25 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org>
In-Reply-To: <20041004020207.4f168876.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6131556.eAKClla0zn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410051607.40860.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6131556.eAKClla0zn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 October 2004 11:02, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2=
=2E6
>.9-rc3-mm2/

some more scheduling/preempt problems. following patches were applied:
=2D--=20
25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix=
=20
Mon Oct  4 14:36:19 2004
+++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h Mon Oct  4 14:37:02=
=20
2004
@@ -311,10 +311,11 @@ struct ip_conntrack_stat
        unsigned int expect_delete;
 };
=20
=2D#define CONNTRACK_STAT_INC(count)                              \
=2D       do {                                                    \
=2D               per_cpu(ip_conntrack_stat, get_cpu()).count++;  \
=2D               put_cpu();                                      \
+#define CONNTRACK_STAT_INC(count)                                      \
+       do {                                                            \
+               preempt_disable();                                      \
+               per_cpu(ip_conntrack_stat, smp_processor_id()).count++; \
+               preempt_disable();                                      \
        } while (0)
=20
 /* eg. PROVIDES_CONNTRACK(ftp); */
_

=2D-- 25/include/net/neighbour.h~neigh_stat-preempt-fix-fix       Mon Oct  =
4=20
14:39:22 2004
+++ 25-akpm/include/net/neighbour.h     Mon Oct  4 14:39:22 2004
@@ -113,8 +113,9 @@ struct neigh_statistics
=20
 #define NEIGH_CACHE_STAT_INC(tbl, field)                               \
        do {                                                            \
=2D               (per_cpu_ptr((tbl)->stats, get_cpu())->field)++;        \
=2D               put_cpu();                                              \
+               preempt_disable();                                      \
+               (per_cpu_ptr((tbl)->stats, smp_processor_id())->field)++; \
+               preempt_enable();                                       \
        } while (0)
=20
 struct neighbour
_

i uploaded syslog with panics to http://stud4.tuwien.ac.at/~e0227135/kernel/
the first panic occurred after modprobe ip_conntrack.

best regards,
dominik

--nextPart6131556.eAKClla0zn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQWKqrAvcoSHvsHMnAQIymQP9GzdSfWptj4oxhlKHzxpgJIk0uhUbW71r
SQ499bOWaJLSF/EjsrsTWOGiyvd1GQF8KfVd+qQ1Rl6So2kdAnhhobwWYLiqBURr
RVWe4GCiN9NVbXstQyROBexWAe9p6a23Iex5UaXXf0m4YtSZ/fx4amcu38ln9YLp
qUv3jRfucJk=
=86Q8
-----END PGP SIGNATURE-----

--nextPart6131556.eAKClla0zn--
