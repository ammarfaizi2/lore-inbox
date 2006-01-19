Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWASIab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWASIab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWASIab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:30:31 -0500
Received: from h80ad24de.async.vt.edu ([128.173.36.222]:41449 "EHLO
	h80ad24de.async.vt.edu") by vger.kernel.org with ESMTP
	id S1161270AbWASIaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:30:30 -0500
Message-Id: <200601190830.k0J8UG9Q008899@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.16-rc1-mm1 - produce useful info for kzalloc with DEBUG_SLAB
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137659415_3359P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 03:30:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137659415_3359P
Content-Type: text/plain; charset=us-ascii

The following patch makes a few minor changes so the CONFIG_DEBUG_SLAB
statistics report the actual caller for kzalloc() - otherwise its call to
kmalloc() just points at kzalloc().  Basically, we force __always_inline on
several routines, so the __builtin_return_address calls point where we
want them to point, even if gcc wouldn't otherwise do it.

Signed-Off-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
 include/linux/slab.h |   10 ++++++++++
 mm/slab.c            |    4 ++--
 mm/util.c            |    2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc1-mm1/include/linux/slab.h.slab	2006-01-18 16:12:08.000000000 -0500
+++ linux-2.6.16-rc1-mm1/include/linux/slab.h	2006-01-18 16:12:10.000000000 -0500
@@ -101,7 +101,17 @@ found:
 	return __kmalloc(size, flags);
 }
 
+#ifdef CONFIG_DEBUG_SLAB
+static __always_inline void  *kzalloc(size_t size, gfp_t flags)
+{
+	void *ret = __kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+#else
 extern void *kzalloc(size_t, gfp_t);
+#endif
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
--- linux-2.6.16-rc1-mm1/mm/slab.c.slab	2006-01-18 16:12:08.000000000 -0500
+++ linux-2.6.16-rc1-mm1/mm/slab.c	2006-01-19 03:13:29.000000000 -0500
@@ -2407,7 +2407,7 @@ static void kfree_debugcheck(const void 
 	}
 }
 
-static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
+static __always_inline void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 				   void *caller)
 {
 	struct page *page;
@@ -2614,7 +2614,7 @@ cache_alloc_debugcheck_before(struct kme
 }
 
 #if DEBUG
-static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep, gfp_t flags,
+static __always_inline void *cache_alloc_debugcheck_after(struct kmem_cache *cachep, gfp_t flags,
 					void *objp, void *caller)
 {
 	if (!objp)
--- linux-2.6.16-rc1-mm1/mm/util.c.slab	2006-01-18 16:11:46.000000000 -0500
+++ linux-2.6.16-rc1-mm1/mm/util.c	2006-01-18 16:12:10.000000000 -0500
@@ -2,6 +2,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 
+#ifndef CONFIG_DEBUG_SLAB
 /**
  * kzalloc - allocate memory. The memory is set to zero.
  * @size: how many bytes of memory are required.
@@ -15,6 +16,7 @@ void *kzalloc(size_t size, gfp_t flags)
 	return ret;
 }
 EXPORT_SYMBOL(kzalloc);
+#endif
 
 /*
  * kstrdup - allocate space for and copy an existing string



--==_Exmh_1137659415_3359P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDz04XcC3lWbTT17ARAr7dAJ9EYhg6m9z78BF8iugrVRznSJkYwwCeIB8P
ucARFRnD4bl54ahaxJsi4XM=
=z6iJ
-----END PGP SIGNATURE-----

--==_Exmh_1137659415_3359P--
