Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUDTOr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUDTOr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUDTOr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:47:29 -0400
Received: from smtp.golden.net ([199.166.210.31]:41484 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S263100AbUDTOrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:47:12 -0400
Date: Tue, 20 Apr 2004 10:46:59 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sh)
Message-ID: <20040420144659.GE12390@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYjS-00056J-TY@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <E1BFYjS-00056J-TY@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 19, 2004 at 02:22:42PM +0100, Russell King wrote:
> This patch is part of a larger patch aiming towards getting the
> include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
> can sanely get at things like mm_struct and friends.
>=20
> In the event that any of these files fails to build, chances are
> you need to include some other header file rather than pgalloc.h.
> Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
> or asm/tlbflush.h.
>=20
Failed to compile. sh has ptep_get_and_clear in asm/pgalloc.h.

This moves it out of the way, and your patch builds fine.

--- orig/arch/sh/mm/tlb-sh4.c
+++ mod/arch/sh/mm/tlb-sh4.c
@@ -24,7 +24,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -95,3 +94,24 @@
 	back_to_P1();
 }
=20
+/*
+ * For SH-4, we have our own implementation for ptep_get_and_clear
+ */
+inline pte_t ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t pte =3D *ptep;
+
+	pte_clear(ptep);
+	if (!pte_not_present(pte)) {
+		struct page *page;
+		unsigned long pfn =3D pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			page =3D pfn_to_page(pfn);
+			if (!page->mapping
+			    || list_empty(&page->mapping->i_mmap_shared))
+				__clear_bit(PG_mapped, &page->flags);
+		}
+	}
+	return pte;
+}
+
--- orig/include/asm-sh/pgtable.h
+++ mod/include/asm-sh/pgtable.h
@@ -268,16 +268,6 @@
 #define pte_to_pgoff(pte)	(pte_val(pte) >> 1)
 #define pgoff_to_pte(off)	((pte_t) { ((off) << 1) | _PAGE_FILE })
=20
-/*
- * Routines for update of PTE=20
- *
- * We just can use generic implementation, as SuperH has no SMP feature.
- * (We needed atomic implementation for SMP)
- *
- */
-
-#define pte_same(A,B)	(pte_val(A) =3D=3D pte_val(B))
-
 typedef pte_t *pte_addr_t;
=20
 #endif /* !__ASSEMBLY__ */
@@ -295,12 +285,11 @@
 extern unsigned int kobjsize(const void *objp);
 #endif /* !CONFIG_MMU */
=20
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+#ifdef CONFIG_CPU_SH4
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#define __HAVE_ARCH_PTEP_MKDIRTY
-#define __HAVE_ARCH_PTE_SAME
+extern inline pte_t ptep_get_and_clear(pte_t *ptep);
+#endif
+
 #include <asm-generic/pgtable.h>
=20
 #endif /* __ASM_SH_PAGE_H */
--- orig/include/asm-sh/pgalloc.h
+++ mod/include/asm-sh/pgalloc.h
@@ -85,71 +85,12 @@
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
=20
-#if defined(CONFIG_CPU_SH4)
-#define PG_mapped	PG_arch_1
+#define check_pgt_cache()	do { } while (0)
=20
-/*
- * For SH-4, we have our own implementation for ptep_get_and_clear
- */
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t pte =3D *ptep;
+#ifdef CONFIG_CPU_SH4
+#define PG_mapped	PG_arch_1
=20
-	pte_clear(ptep);
-	if (!pte_not_present(pte)) {
-		struct page *page;
-		unsigned long pfn =3D pte_pfn(pte);
-		if (pfn_valid(pfn)) {
-			page =3D pfn_to_page(pfn);
-			if (!page->mapping
-			    || list_empty(&page->mapping->i_mmap_shared))
-				__clear_bit(PG_mapped, &page->flags);
-		}
-	}
-	return pte;
-}
-#else
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t pte =3D *ptep;
-	pte_clear(ptep);
-	return pte;
-}
+extern inline pte_t ptep_get_and_clear(pte_t *ptep);
 #endif
=20
-/*
- * Following functions are same as generic ones.
- */
-static inline int ptep_test_and_clear_young(pte_t *ptep)
-{
-	pte_t pte =3D *ptep;
-	if (!pte_young(pte))
-		return 0;
-	set_pte(ptep, pte_mkold(pte));
-	return 1;
-}
-
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
-{
-	pte_t pte =3D *ptep;
-	if (!pte_dirty(pte))
-		return 0;
-	set_pte(ptep, pte_mkclean(pte));
-	return 1;
-}
-
-static inline void ptep_set_wrprotect(pte_t *ptep)
-{
-	pte_t old_pte =3D *ptep;
-	set_pte(ptep, pte_wrprotect(old_pte));
-}
-
-static inline void ptep_mkdirty(pte_t *ptep)
-{
-	pte_t old_pte =3D *ptep;
-	set_pte(ptep, pte_mkdirty(old_pte));
-}
-
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* __ASM_SH_PGALLOC_H */

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAhTfj1K+teJFxZ9wRAntxAJwIxZ3EBXOTbrYJH44kdxPTzA1pFACeM4Yw
v8PBU2WZIKEA4QQumILNefI=
=YPo7
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
