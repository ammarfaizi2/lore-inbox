Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSHXX0D>; Sat, 24 Aug 2002 19:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHXX0D>; Sat, 24 Aug 2002 19:26:03 -0400
Received: from ppp-217-133-222-183.dialup.tiscali.it ([217.133.222.183]:2976
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316856AbSHXX0B>; Sat, 24 Aug 2002 19:26:01 -0400
Subject: [PATCH TRIVIAL] Make rmap.c alloc/free actually inline
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-CzlLeYd2i7stijHp+QNV"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Aug 2002 01:29:27 +0200
Message-Id: <1030231767.1538.63.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CzlLeYd2i7stijHp+QNV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

GCC can only inline functions when the function definition comes before
its use.


--- linux-2.5.31/mm/rmap.c~	2002-08-13 19:36:16.000000000 +0200
+++ linux-2.5.31/mm/rmap.c	2002-08-25 01:08:00.000000000 +0200
@@ -53,9 +53,45 @@ struct pte_chain {
 };
 
 static kmem_cache_t	*pte_chain_cache;
-static inline struct pte_chain * pte_chain_alloc(void);
-static inline void pte_chain_free(struct pte_chain *, struct pte_chain *,
-		struct page *);
+
+/**
+ * pte_chain_alloc - allocate a pte_chain struct
+ *
+ * Returns a pointer to a fresh pte_chain structure. Allocates new
+ * pte_chain structures as required.
+ * Caller needs to hold the page's pte_chain_lock.
+ */
+static inline struct pte_chain *pte_chain_alloc(void)
+{
+	return kmem_cache_alloc(pte_chain_cache, GFP_ATOMIC);
+}
+
+/**
+ * pte_chain_free - free pte_chain structure
+ * @pte_chain: pte_chain struct to free
+ * @prev_pte_chain: previous pte_chain on the list (may be NULL)
+ * @page: page this pte_chain hangs off (may be NULL)
+ *
+ * This function unlinks pte_chain from the singly linked list it
+ * may be on and adds the pte_chain to the free list. May also be
+ * called for new pte_chain structures which aren't on any list yet.
+ * Caller needs to hold the pte_chain_lock if the page is non-NULL.
+ */
+static inline void pte_chain_free(struct pte_chain * pte_chain,
+		struct pte_chain * prev_pte_chain, struct page * page)
+{
+	if (prev_pte_chain)
+		prev_pte_chain->next = pte_chain->next;
+	else if (page)
+		page->pte.chain = pte_chain->next;
+
+	kmem_cache_free(pte_chain_cache, pte_chain);
+}
+
+
+/**
+ ** VM stuff below this comment
+ **/
 
 /**
  * page_referenced - test if the page was referenced
@@ -358,41 +394,6 @@ int try_to_unmap(struct page * page)
  ** functions.
  **/
 
-
-/**
- * pte_chain_free - free pte_chain structure
- * @pte_chain: pte_chain struct to free
- * @prev_pte_chain: previous pte_chain on the list (may be NULL)
- * @page: page this pte_chain hangs off (may be NULL)
- *
- * This function unlinks pte_chain from the singly linked list it
- * may be on and adds the pte_chain to the free list. May also be
- * called for new pte_chain structures which aren't on any list yet.
- * Caller needs to hold the pte_chain_lock if the page is non-NULL.
- */
-static inline void pte_chain_free(struct pte_chain * pte_chain,
-		struct pte_chain * prev_pte_chain, struct page * page)
-{
-	if (prev_pte_chain)
-		prev_pte_chain->next = pte_chain->next;
-	else if (page)
-		page->pte.chain = pte_chain->next;
-
-	kmem_cache_free(pte_chain_cache, pte_chain);
-}
-
-/**
- * pte_chain_alloc - allocate a pte_chain struct
- *
- * Returns a pointer to a fresh pte_chain structure. Allocates new
- * pte_chain structures as required.
- * Caller needs to hold the page's pte_chain_lock.
- */
-static inline struct pte_chain *pte_chain_alloc(void)
-{
-	return kmem_cache_alloc(pte_chain_cache, GFP_ATOMIC);
-}
-
 void __init pte_chain_init(void)
 {
 	pte_chain_cache = kmem_cache_create(	"pte_chain",


--=-CzlLeYd2i7stijHp+QNV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQA9aBbXdjkty3ft5+cRAi9EAJ0cNk9l8YOSm0mQ+O0lCHRb0DXXVwCY7F2b
6i3wWzaT/r8wk1ZNfiHXrw==
=Gbzb
-----END PGP SIGNATURE-----

--=-CzlLeYd2i7stijHp+QNV--
