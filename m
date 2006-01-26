Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWAZI3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWAZI3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAZI3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:29:45 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:49299 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932126AbWAZI3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:29:44 -0500
Date: Thu, 26 Jan 2006 09:29:29 +0100
From: Harald Welte <laforge@netfilter.org>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3 / netfilter / firehol problems?
Message-ID: <20060126082929.GD4603@sunbeam.de.gnumonks.org>
References: <20060124232406.50abccd1.akpm@osdl.org> <20060125205859.9F96622AEAC@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SnS7NL+Bem4KHtXd"
Content-Disposition: inline
In-Reply-To: <20060125205859.9F96622AEAC@anxur.fi.muni.cz>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SnS7NL+Bem4KHtXd
Content-Type: multipart/mixed; boundary="+bwwFJPg6t3ya3US"
Content-Disposition: inline


--+bwwFJPg6t3ya3US
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2006 at 09:59:01PM +0100, Jiri Slaby wrote:
> thunder7@xs4all.nl wrote:
> >From: Andrew Morton <akpm@osdl.org>
> >Date: Tue, Jan 24, 2006 at 11:24:06PM -0800
> >>=20
> >> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-=
rc1/2.6.16-rc1-mm3/
> >>=20
> >Is netfilter supposed to work again? I get weird error messages from
> >FireHOL that I didn't get with 2.6.16-rc1-mm2 with this patch added:
> Be patient, processing...
> See http://lkml.org/lkml/2006/1/20/198.

well, I think the bottleneck is that DaveM and Linus are at
linux.conf.au at this time. I have submitted a patch that according to
my tests works at least on i386, x86_64 and ppc32.

Just give them a bit more time.  Original patch attached again

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--+bwwFJPg6t3ya3US
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

--+bwwFJPg6t3ya3US--

--SnS7NL+Bem4KHtXd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD2IhpXaXGVTD0i/8RAjGsAJ0QwO948qOfJLWgRnXzclkOH/bvNwCgsp0K
q7bt29kljULoBe4tsIXeN0U=
=9nqK
-----END PGP SIGNATURE-----

--SnS7NL+Bem4KHtXd--
