Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263715AbUDTQUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbUDTQUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDTQUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:20:40 -0400
Received: from smtp.golden.net ([199.166.210.31]:62994 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S263716AbUDTQUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:20:01 -0400
Date: Tue, 20 Apr 2004 12:19:40 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sh)
Message-ID: <20040420161940.GA20353@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Hugh Dickins <hugh@veritas.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040420144659.GE12390@linux-sh.org> <Pine.LNX.4.44.0404201647020.4724-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404201647020.4724-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2004 at 05:01:17PM +0100, Hugh Dickins wrote:
> On Tue, 20 Apr 2004, Paul Mundt wrote:
> > Failed to compile. sh has ptep_get_and_clear in asm/pgalloc.h.
> > This moves it out of the way, and your patch builds fine.
>=20
> Paul, the patch you show reflects how ptep_get_and_clear looked in
> 2.6.5, but not how it now looks in 2.6.6-rc1-bk - should be using
> page_mapping(page) and mapping_writably_mapped(mapping).
>=20
> I dare say you're referring to a master tree into which the recent
> mainline changes need to be ported (I CC'ed gniibe@m17n.org when
> sending those changes to akpm): I'm not saying your version is
> wrong, just trying to make sure that two sets of changes in the
> same area don't end up with one set getting lost.
>=20
Yes, this was against the 2.6.5-based SH tree, not current BK. Attached
is a patch against current BK that seems to reflect your changes.

Please CC me on any future SH-related issues, NIIBE-san is no longer
active in the SH community.

=3D=3D=3D=3D=3D arch/sh/mm/tlb-sh4.c 1.2 vs edited =3D=3D=3D=3D=3D
--- 1.2/arch/sh/mm/tlb-sh4.c	Tue Mar 23 05:05:26 2004
+++ edited/arch/sh/mm/tlb-sh4.c	Tue Apr 20 12:16:08 2004
@@ -24,7 +24,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -93,5 +92,25 @@
 	jump_to_P2();
 	ctrl_outl(data, addr);
 	back_to_P1();
+}
+
+/*
+ * For SH-4, we have our own implementation for ptep_get_and_clear
+ */
+inline pte_t ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t pte =3D *ptep;
+
+	pte_clear(ptep);
+	if (!pte_not_present(pte)) {
+		unsigned long pfn =3D pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			struct page *page =3D pfn_to_page(pfn);
+			struct address_space *mapping =3D page_mapping(page);
+			if (!mapping || !mapping_writably_mapped(mapping))
+				__clear_bit(PG_mapped, &page->flags);
+		}
+	}
+	return pte;
 }
=20
=3D=3D=3D=3D=3D include/asm-sh/pgalloc.h 1.12 vs edited =3D=3D=3D=3D=3D
--- 1.12/include/asm-sh/pgalloc.h	Sun Apr 18 12:13:10 2004
+++ edited/include/asm-sh/pgalloc.h	Tue Apr 20 12:17:20 2004
@@ -85,69 +85,9 @@
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
=20
-#if defined(CONFIG_CPU_SH4)
+#ifdef CONFIG_CPU_SH4
 #define PG_mapped	PG_arch_1
-
-/*
- * For SH-4, we have our own implementation for ptep_get_and_clear
- */
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t pte =3D *ptep;
-
-	pte_clear(ptep);
-	if (!pte_not_present(pte)) {
-		unsigned long pfn =3D pte_pfn(pte);
-		if (pfn_valid(pfn)) {
-			struct page *page =3D pfn_to_page(pfn);
-			struct address_space *mapping =3D page_mapping(page);
-			if (!mapping || !mapping_writably_mapped(mapping))
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
 #endif
-
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
=20
 #define check_pgt_cache()	do { } while (0)
=20
=3D=3D=3D=3D=3D include/asm-sh/pgtable.h 1.22 vs edited =3D=3D=3D=3D=3D
--- 1.22/include/asm-sh/pgtable.h	Tue Mar 23 05:05:27 2004
+++ edited/include/asm-sh/pgtable.h	Tue Apr 20 12:13:49 2004
@@ -264,16 +264,6 @@
 #define pte_to_pgoff(pte)	(pte_val(pte))
 #define pgoff_to_pte(off)	((pte_t) { (off) | _PAGE_FILE })
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
@@ -291,12 +281,11 @@
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

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAhU2c1K+teJFxZ9wRAhS9AJsHVfYHvKdyd/M/BUmS44TY3fM92wCeORq+
uNe4NhvwcO5Ki0VaI6738+s=
=/hIA
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
