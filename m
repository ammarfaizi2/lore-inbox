Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWATTcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWATTcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWATTcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:32:09 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:44009 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932078AbWATTcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:32:07 -0500
Date: Fri, 20 Jan 2006 20:32:01 +0100
From: Harald Welte <laforge@netfilter.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
Message-ID: <20060120193201.GP4603@sunbeam.de.gnumonks.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <20060120162317.5F70722B383@anxur.fi.muni.cz> <20060120163619.GK4603@sunbeam.de.gnumonks.org> <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com> <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdqEfx9vLKjgI91r"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdqEfx9vLKjgI91r
Content-Type: multipart/mixed; boundary="E9lJRGffXdNhqRfL"
Content-Disposition: inline


--E9lJRGffXdNhqRfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 11:49:46AM -0500, Linus Torvalds wrote:
> On Fri, 20 Jan 2006, Benoit Boissinot wrote:
> >=20
> > On x86 (32bits), i have the same i think:
>=20
> Interestingly, __alignof__(unsigned long long) is 8 these days, even=20
> though I think historically on x86 it was 4. Is this perhaps different in=
=20
> gcc-3 and gcc-4?

The problem seems to have been accidentially introduced by DaveM's
"simplification" of my original patch.

I've already asked Dave to revert his change and apply my original
patch (see attachment), which _should_ fix the problem.

Thanks,
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--E9lJRGffXdNhqRfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="52-x_tables-alignment.patch.patch"
Content-Transfer-Encoding: quoted-printable

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

--E9lJRGffXdNhqRfL--

--sdqEfx9vLKjgI91r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFD0TqxXaXGVTD0i/8RAq4mAJimNTDkR+T8EP9Fb332De+LpkjDAJ0Wi8h7
9MIpDdnhp1XVw6UcXPnyug==
=4KK9
-----END PGP SIGNATURE-----

--sdqEfx9vLKjgI91r--
