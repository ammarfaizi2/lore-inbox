Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161422AbWATApZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161422AbWATApZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWATApZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:45:25 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:9124 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1161422AbWATApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:45:23 -0500
Date: Fri, 20 Jan 2006 01:45:12 +0100
From: Harald Welte <laforge@netfilter.org>
To: netfilter-devel@lists.netfilter.org,
       Mikael Pettersson <mikpe@user.it.uu.se>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
Subject: [PATCH] x_tables: fix alignment on [at least] ppc32 (was Re: 2.6.16-rc1: iptables broken on ppc32?)
Message-ID: <20060120004512.GT4603@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	netfilter-devel@lists.netfilter.org,
	Mikael Pettersson <mikpe@user.it.uu.se>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
References: <17358.19458.555996.684819@alkaid.it.uu.se> <20060118150158.GL4603@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3dbUQUznexwzCA76"
Content-Disposition: inline
In-Reply-To: <20060118150158.GL4603@sunbeam.de.gnumonks.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3dbUQUznexwzCA76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the patch below fixes the problem on ppc32. Dave: Please apply.

[NETFILTER] x_tables: Fix XT_ALIGN() macro on [at least] ppc32

To keep backwards compatibility with old iptables userspace programs,
the new XT_ALIGN macro always has to return the same value as IPT_ALIGN,
IP6T_ALIGN or ARPT_ALIGN in previous kernels.

However, in those kernels the macro was defined in dependency to the
respective layer3 specifi data structures, which we can no longer do with
x_tables.

The fix is an ugly kludge, but it has been tested to solve the problem. Yet
another reason to move away from the current {ip,ip6,arp,eb}tables like
data structures.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 470faeb379560fe877b685ca69be6a7e4f0e91ed
tree 5732ecd9bcab28469805752514e5c57ba26189a1
parent 44718bbfa186d58477163418d37df173aa2dd079
author Harald Welte <laforge@netfilter.org> Fri, 20 Jan 2006 01:44:24 +0100
committer Harald Welte <laforge@netfilter.org> Fri, 20 Jan 2006 01:44:24 +0=
100

 include/linux/netfilter/x_tables.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x=
_tables.h
index 472f048..65f9cd8 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -19,7 +19,20 @@ struct xt_get_revision
 /* For standard target */
 #define XT_RETURN (-NF_REPEAT - 1)
=20
-#define XT_ALIGN(s) (((s) + (__alignof__(void *)-1)) & ~(__alignof__(void =
*)-1))
+/* this is a dummy structure to find out the alignment requirement for a s=
truct
+ * containing all the fundamental data types that are used in ipt_entry, i=
p6t_entry
+ * and arpt_entry.  This sucks, and it is a hack.  It will be my personal =
pleasure
+ * to remove it -HW */
+struct _xt_align
+{
+	u_int8_t u8;
+	u_int16_t u16;
+	u_int32_t u32;
+	u_int64_t u64;
+};
+
+#define XT_ALIGN(s) (((s) + (__alignof__(struct _xt_align)-1)) 	\
+			& ~(__alignof__(struct _xt_align)-1))
=20
 /* Standard return verdict, or do jump. */
 #define XT_STANDARD_TARGET ""
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--3dbUQUznexwzCA76
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0DKYXaXGVTD0i/8RAnN8AKCFuYk8Prm7iTKkLsYbsTFzakhpHACfQgXC
u5UIFPe4Gcp0dsQWa0IdDQQ=
=kJLR
-----END PGP SIGNATURE-----

--3dbUQUznexwzCA76--
