Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbULES1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbULES1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULES1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:27:39 -0500
Received: from mgw-x4.nokia.com ([131.228.20.27]:48816 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id S261334AbULES1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:27:31 -0500
X-Scanned: Sun, 5 Dec 2004 20:27:02 +0200 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Date: Sun, 5 Dec 2004 20:25:54 +0200
From: Paul Mundt <paul.mundt@nokia.com>
To: akpm@osdl.org, anton@samba.org, richard.curnow@st.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
Message-ID: <20041205182554.GB21383@pointless.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 05 Dec 2004 18:26:59.0022 (UTC) FILETIME=[01CDB6E0:01C4DAF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some time ago Anton introduced a patch that removed cacheline alignment
for the slab caches, falling back on BYTES_PER_WORD instead. While this
is fine in the general sense, on sh64 it is the source of considerable
unaligned accesses.

For sh64, sizeof(void *) gives 4 bytes, whereas we actually want 8 byte
alignment (pretty much the same behaviour as what we had prior to Anton's
patch, and what we already do for ARCH_KMALLOC_MINALIGN).

Richard was the first to note this:

	One new issue is that there are a lot of new unaligned fixups
	occurring.  I know where too - it's loads and stores to 8-byte fields
	in inodes.  The root cause is the patch by Anton Blanchard : "remove
	cacheline alignment from inode slabs".  I think before that forcing
	the inodes to cacheline-alignment guaranteed 8-byte alignment, but now
	that's been removed, we only get sizeof(void *) alignment.  The
	problem is that pretty much every call to kmem_cache_create, except
	for the ones that create the kmalloc pool, specifies zero as the 3rd
	arg (=3Dalign).  (The ones that create the kmalloc pools specify
	ARCH_KMALLOC_MINALIGN which I fixed a while back to 8 for sh64.)
	Ideally we're going to have to come up with a fix for this one, since
	the performance overhead of fixing up loads of inode accesses will be
	pretty high.  It's not obvious to me how to do this unobtrusively - we
	need to either modify kmem_cache_create or modify every file that
	calls it (and import the ARCH_KMALLOC_MINALIGN stuff into each one.)
	I suspect that the KMALLOC alignment wants to be kept conceptually
	separate from the alignment used to create slabs.  So perhaps we could
	propose a new ARCH_SLAB_MINALIGN or some such; if this is defined, the
	maximum of this and the 'align' argument to kmem_cache_create is used
	as the alignment for the slab created.

We have been using the attached ARCH_SLAB_MINALIGN patch for sh64 and this
seems like the least intrusive solution. Thoughts?

Signed-off-by: Paul Mundt <paul.mundt@nokia.com>

 include/asm-sh64/uaccess.h |    6 ++++++
 mm/slab.c                  |    6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- orig/include/asm-sh64/uaccess.h
+++ mod/include/asm-sh64/uaccess.h
@@ -313,6 +313,12 @@
    sh64 at the moment). */
 #define ARCH_KMALLOC_MINALIGN 8
=20
+/*
+ * We want 8-byte alignment for the slab caches as well, otherwise we have
+ * the same BYTES_PER_WORD (sizeof(void *)) min align in kmem_cache_create=
().
+ */
+#define ARCH_SLAB_MINALIGN 8
+
 /* Returns 0 if exception not found and fixup.unit otherwise.  */
 extern unsigned long search_exception_table(unsigned long addr);
 extern const struct exception_table_entry *search_exception_tables (unsign=
ed long addr);


--- orig/mm/slab.c
+++ mod/mm/slab.c
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
@@ -1237,7 +1241,7 @@
 			while (size <=3D align/2)
 				align /=3D 2;
 		} else {
-			align =3D BYTES_PER_WORD;
+			align =3D ARCH_SLAB_MINALIGN;
 		}
 	}
=20


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBs1Kyvfgmmv+NIDsRAniQAKCDGUe0fr0TjvwoeBtWWBEdWSTeLACglxXU
luasJOSfjRZf4ga9CVxRjek=
=l+HJ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
