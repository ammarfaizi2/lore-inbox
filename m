Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbULLPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbULLPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbULLPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 10:09:25 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.34]:10942 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262079AbULLPJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 10:09:08 -0500
Date: Sun, 12 Dec 2004 17:09:06 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
Message-ID: <20041212150906.GB15323@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41B37E06.3030702@colorfullife.com> <20041205222001.GB25689@linux-sh.org> <41B4D9F8.6000309@colorfullife.com> <20041206225934.GA30317@linux-sh.org> <41BC21E2.6000600@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <41BC21E2.6000600@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manfred,

On Sun, Dec 12, 2004 at 11:48:02AM +0100, Manfred Spraul wrote:
> Sorry for the late reply, attached is my proposal:
> I've added the ARCH_SLAB_MINALIGN flag, together with some documentation=
=20
> and a small restructuring.
> What do you think?
>=20
Looks fine to me, just tested on sh64 and it works ok.

> #ifndef CONFIG_DEBUG_SLAB
> #define ARCH_SLAB_MINALIGN   8
> #endif
>=20
Right now ARCH_KMALLOC_MINALIGN is set unconditionally on sh64, so it
seems that we lose some debug features there. However, even with
ARCH_SLAB_MINALIGN being set to non-zero, redzoning and slab poisoning
still seem to be functional to some extent.

For instance, I've been using the following patch and this did help pin
down a rather irritating bug in the sh64 switch_to().

Is there any reason not to wrap redzoning to ARCH_SLAB_MINALIGN (and set
it to BYTES_PER_WORD by default). It seems at least that the only thing
BYTES_PER_WORD is needed for in the redzoning case is to determine where
to place the second marker. I can see why this would be problematic with
dynamic slab alignment, but when it is fixed at compile time there
shouldn't be anything prohibiting the use of a non-BYTES_PER_WORD value.

We can live with the unaligned accesses in the CONFIG_DEBUG_SLAB case,
but it would still be nice to at least have some partial redzoning and
poisoning with a forced alignment.

--- linux-2.6.10-rc3/mm/slab.c	2004-12-05 19:05:39.000000000 +0200
+++ linux-sh64-2.6.10-rc3/mm/slab.c	2004-12-08 16:56:25.000000000 +0200
@@ -135,6 +135,10 @@
 #define ARCH_KMALLOC_FLAGS SLAB_HWCACHE_ALIGN
 #endif
=20
+#ifndef ARCH_SLAB_MINALIGN
+#define ARCH_SLAB_MINALIGN	BYTES_PER_WORD
+#endif
+
 /* Legal flag mask for kmem_cache_create(). */
 #if DEBUG
 # define CREATE_MASK	(SLAB_DEBUG_INITIAL | SLAB_RED_ZONE | \
@@ -404,14 +408,16 @@
=20
 /* memory layout of objects:
  * 0		: objp
- * 0 .. cachep->dbghead - BYTES_PER_WORD - 1: padding. This ensures that
- * 		the end of an object is aligned with the end of the real
- * 		allocation. Catches writes behind the end of the allocation.
- * cachep->dbghead - BYTES_PER_WORD .. cachep->dbghead - 1:
- * 		redzone word.
+ * 0 .. cachep->dbghead - ARCH_SLAB_MINALIGN - 1: padding. This ensures th=
at
+ *		the end of an object is aligned with the end of the real
+ *		allocation. Catches writes behind the end of the allocation.
+ * cachep->dbghead - ARCH_SLAB_MINALIGN .. cachep->dbghead - 1:
+ *		redzone word.
  * cachep->dbghead: The real object.
- * cachep->objsize - 2* BYTES_PER_WORD: redzone word [BYTES_PER_WORD long]
- * cachep->objsize - 1* BYTES_PER_WORD: last caller address [BYTES_PER_WOR=
D long]
+ * cachep->objsize - 2* ARCH_SLAB_MINALIGN:
+ *		redzone word [ARCH_SLAB_MINALIGN long]
+ * cachep->objsize - 1* ARCH_SLAB_MINALIGN:
+ *		last caller address [ARCH_SLAB_MINALIGN long]
  */
 static int obj_dbghead(kmem_cache_t *cachep)
 {
@@ -426,21 +432,21 @@
 static unsigned long *dbg_redzone1(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
-	return (unsigned long*) (objp+obj_dbghead(cachep)-BYTES_PER_WORD);
+	return (unsigned long*) (objp+obj_dbghead(cachep)-ARCH_SLAB_MINALIGN);
 }
=20
 static unsigned long *dbg_redzone2(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_RED_ZONE));
 	if (cachep->flags & SLAB_STORE_USER)
-		return (unsigned long*) (objp+cachep->objsize-2*BYTES_PER_WORD);
-	return (unsigned long*) (objp+cachep->objsize-BYTES_PER_WORD);
+		return (unsigned long*) (objp+cachep->objsize-2*ARCH_SLAB_MINALIGN);
+	return (unsigned long*) (objp+cachep->objsize-ARCH_SLAB_MINALIGN);
 }
=20
 static void **dbg_userword(kmem_cache_t *cachep, void *objp)
 {
 	BUG_ON(!(cachep->flags & SLAB_STORE_USER));
-	return (void**)(objp+cachep->objsize-BYTES_PER_WORD);
+	return (void**)(objp+cachep->objsize-ARCH_SLAB_MINALIGN);
 }
=20
 #else
@@ -1204,7 +1210,7 @@
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if ((size < 4096 || fls(size-1) =3D=3D fls(size-1+3*BYTES_PER_WORD)))
+	if ((size < 4096 || fls(size-1) =3D=3D fls(size-1+3*ARCH_SLAB_MINALIGN)))
 		flags |=3D SLAB_RED_ZONE|SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |=3D SLAB_POISON;
@@ -1237,7 +1243,7 @@
 			while (size <=3D align/2)
 				align /=3D 2;
 		} else {
-			align =3D BYTES_PER_WORD;
+			align =3D ARCH_SLAB_MINALIGN;
 		}
 	}
=20
@@ -1255,25 +1261,25 @@
 		size +=3D (BYTES_PER_WORD-1);
 		size &=3D ~(BYTES_PER_WORD-1);
 	}
-=09
+
 #if DEBUG
 	cachep->reallen =3D size;
=20
 	if (flags & SLAB_RED_ZONE) {
 		/* redzoning only works with word aligned caches */
-		align =3D BYTES_PER_WORD;
+		align =3D ARCH_SLAB_MINALIGN;
=20
 		/* add space for red zone words */
-		cachep->dbghead +=3D BYTES_PER_WORD;
-		size +=3D 2*BYTES_PER_WORD;
+		cachep->dbghead +=3D ARCH_SLAB_MINALIGN;
+		size +=3D 2*ARCH_SLAB_MINALIGN;
 	}
 	if (flags & SLAB_STORE_USER) {
 		/* user store requires word alignment and
 		 * one word storage behind the end of the real
 		 * object.
 		 */
-		align =3D BYTES_PER_WORD;
-		size +=3D BYTES_PER_WORD;
+		align =3D ARCH_SLAB_MINALIGN;
+		size +=3D ARCH_SLAB_MINALIGN;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
 	if (size > 128 && cachep->reallen > cache_line_size() && size < PAGE_SIZE=
) {
@@ -2292,7 +2298,7 @@
 {
 	unsigned long addr =3D (unsigned long) ptr;
 	unsigned long min_addr =3D PAGE_OFFSET;
-	unsigned long align_mask =3D BYTES_PER_WORD-1;
+	unsigned long align_mask =3D ARCH_SLAB_MINALIGN-1;
 	unsigned long size =3D cachep->objsize;
 	struct page *page;
=20

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBvF8S1K+teJFxZ9wRAg35AKCDx6wJzdXzcNuSdWbYAkKP+W6I2QCcDsC2
U/URa3bvuSiXyiMFj4fmQWE=
=D+at
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
