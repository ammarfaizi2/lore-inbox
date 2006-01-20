Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWATINR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWATINR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWATINR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:13:17 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:26589 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750722AbWATINQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:13:16 -0500
Date: Fri, 20 Jan 2006 10:13:05 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [TEST PATCH 3/3] lib bitmap region restructure
Message-ID: <20060120081305.GB3918@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <20060120020757.19584.33756.sendpatchset@jackhammer.engr.sgi.com> <20060120020808.19584.3859.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20060120020808.19584.3859.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2006 at 06:08:08PM -0800, Paul Jackson wrote:
> This compiles, but has not been tested past that.
> Be more careful of this patch -- unlike the previous
> two in this set, this patch reworks quite a bit of
> the logic, so is at higher risk of being broken.
>=20
The first two work fine for me. This one is another case. With this, the
bitmap_find_free_region() switches to walking the bitmap in 1 << order
steps, as opposed to nbitsperlong, which causes it to skip over more
space than it needs to and we end up fragmenting the bitmap pretty
quickly.

By changing bitmap_find_free_region() back to the previous behaviour, it
seems to work again (at least in the bitmap_find_free_region() case). I
hate to invalidate your comments this quickly, though :-)

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 lib/bitmap.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 72bd06a..adf336e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -687,7 +687,7 @@ EXPORT_SYMBOL(bitmap_bitremap);
  * depending on which combination of REG_OP_* flag bits is set.
  *
  * A region of a bitmap is a sequence of bits in the bitmap, of
- * some size '1 << order' (a power of two), alligned to that same
+ * some size '1 << order' (a power of two), aligned to that same
  * '1 << order' power of two.
  *
  * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
@@ -760,7 +760,7 @@ done:
  *
  * Find a region of free (zero) bits in a @bitmap of @bits bits and
  * allocate them (set them to one).  Only consider regions of length
- * a power (@order) of two, alligned to that power of two, which
+ * a power (@order) of two, aligned to that power of two, which
  * makes the search algorithm much faster.
  *
  * Return the bit offset in bitmap of the allocated region,
@@ -768,9 +768,14 @@ done:
  */
 int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 {
+	int nbits_reg;		/* number of bits in region */
+	int nbitsinlong;	/* num bits of region in each spanned long */
 	int pos;		/* scans bitmap by regions of size order */
=20
-	for (pos =3D 0; pos < bits; pos +=3D (1 << order))
+	nbits_reg =3D 1 << order;
+	nbitsinlong =3D min(nbits_reg, BITS_PER_LONG);
+
+	for (pos =3D 0; pos < bits; pos +=3D nbitsinlong)
 		if (__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 			break;
 	if (pos =3D=3D bits)

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0JuQ1K+teJFxZ9wRAmThAJ9JDG9OgqZRqJB/daF1p2CMgCuN+ACfX8a9
3z8WjmUhizC61iiu/ddEXUQ=
=thvg
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
