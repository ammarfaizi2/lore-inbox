Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWASBsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWASBsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWASBsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:48:20 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:21182 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1030502AbWASBsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:48:19 -0500
Date: Thu, 19 Jan 2006 03:48:12 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-ID: <20060119014812.GB18181@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seems like I was fortunate enough to trigger the BUG_ON() in the
bitmap API regarding pages > BITS_PER_LONG, so as per the comment, here's
a stupid implementation which seems to get the job done.

I have an updated store queue API for SH that is currently using this
with relative success, and at first glance, it seems like this could be
useful for x86 (arch/i386/kernel/pci-dma.c) as well. Particularly for
anything using dma_declare_coherent_memory() on large areas and that
attempts to allocate large buffers from that space.

The implementation could probably use some work, but it works for me..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 lib/bitmap.c |   59 ++++++++++++++++++++++++++++++++++++++++++------------=
-----
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 48e7083..80131e0 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -695,10 +695,11 @@ int bitmap_find_free_region(unsigned lon
 {
 	unsigned long mask;
 	int pages =3D 1 << order;
+	int span =3D (pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
 	int i;
=20
 	if(pages > BITS_PER_LONG)
-		return -EINVAL;
+		pages =3D BITS_PER_LONG;
=20
 	/* make a mask of the order */
 	mask =3D (1ul << (pages - 1));
@@ -708,11 +709,24 @@ int bitmap_find_free_region(unsigned lon
 	for (i =3D 0; i < bits; i +=3D pages) {
 		int index =3D i/BITS_PER_LONG;
 		int offset =3D i - (index * BITS_PER_LONG);
-		if((bitmap[index] & (mask << offset)) =3D=3D 0) {
-			/* set region in bimap */
-			bitmap[index] |=3D (mask << offset);
-			return i;
-		}
+		int j, space =3D 1;
+
+		/* find space in the bitmap */
+		for (j =3D 0; j < span; j++)
+			if ((bitmap[index + j] & (mask << offset))) {
+				space =3D 0;
+				break;
+			}
+
+		/* keep looking */
+		if (unlikely(!space))
+			continue;
+
+		for (j =3D 0; j < span; j++)
+			/* set region in bitmap */
+			bitmap[index + j] |=3D (mask << offset);
+
+		return i;
 	}
 	return -ENOMEM;
 }
@@ -730,30 +744,41 @@ EXPORT_SYMBOL(bitmap_find_free_region);
 void bitmap_release_region(unsigned long *bitmap, int pos, int order)
 {
 	int pages =3D 1 << order;
-	unsigned long mask =3D (1ul << (pages - 1));
+	int span =3D (pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
+	unsigned long mask;
 	int index =3D pos/BITS_PER_LONG;
 	int offset =3D pos - (index * BITS_PER_LONG);
+	int i;
+
+	if (pages > BITS_PER_LONG)
+		pages =3D BITS_PER_LONG;
+
+	mask =3D (1ul << (pages - 1));
 	mask +=3D mask - 1;
-	bitmap[index] &=3D ~(mask << offset);
+	for (i =3D 0; i < span; i++)
+		bitmap[index + i] &=3D ~(mask << offset);
 }
 EXPORT_SYMBOL(bitmap_release_region);
=20
 int bitmap_allocate_region(unsigned long *bitmap, int pos, int order)
 {
 	int pages =3D 1 << order;
-	unsigned long mask =3D (1ul << (pages - 1));
+	int span =3D (pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
+	unsigned long mask;
 	int index =3D pos/BITS_PER_LONG;
 	int offset =3D pos - (index * BITS_PER_LONG);
+	int i;
=20
-	/* We don't do regions of pages > BITS_PER_LONG.  The
-	 * algorithm would be a simple look for multiple zeros in the
-	 * array, but there's no driver today that needs this.  If you
-	 * trip this BUG(), you get to code it... */
-	BUG_ON(pages > BITS_PER_LONG);
+	if (pages > BITS_PER_LONG)
+		pages =3D BITS_PER_LONG;
+
+	mask =3D (1ul << (pages - 1));
 	mask +=3D mask - 1;
-	if (bitmap[index] & (mask << offset))
-		return -EBUSY;
-	bitmap[index] |=3D (mask << offset);
+	for (i =3D 0; i < span; i++)
+		if (bitmap[index + i] & (mask << offset))
+			return -EBUSY;
+	for (i =3D 0; i < span; i++)
+		bitmap[index + i] |=3D (mask << offset);
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzu/c1K+teJFxZ9wRArYiAJ4qs0H9wE3QgOojuYWGlgsv5MkXvwCcC31F
081d0p/T69E+qbXiVghvEVw=
=cFTX
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
