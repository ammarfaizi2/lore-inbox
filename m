Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSD2KnI>; Mon, 29 Apr 2002 06:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSD2KnH>; Mon, 29 Apr 2002 06:43:07 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:15378 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315042AbSD2KnB>;
	Mon, 29 Apr 2002 06:43:01 -0400
Date: Mon, 29 Apr 2002 14:47:38 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] move  get_order() out of the page.h
Message-ID: <20020429104738.GA282@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

currently (2.5.10) every arch specific asm-*/page.h file includes inline=20
get_order() function. All of them (except IA64 one) are identical.
Attached patch moves get_order() into separate include file and adds
microoptimisation for get_order() calls with immediate argument.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-get-order
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-alpha/page.h lin=
ux/include/asm-alpha/page.h
--- linux.vanilla/include/asm-alpha/page.h	Mon Mar  4 19:33:18 2002
+++ linux/include/asm-alpha/page.h	Mon Apr 29 00:43:31 2002
@@ -67,19 +67,7 @@
=20
 #define PAGE_BUG(page)	BUG()
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* !__ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-arm/page.h linux=
/include/asm-arm/page.h
--- linux.vanilla/include/asm-arm/page.h	Wed Mar 20 22:14:41 2002
+++ linux/include/asm-arm/page.h	Mon Apr 29 00:44:08 2002
@@ -111,19 +111,7 @@
=20
 #endif
=20
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* !__ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-generic/get_orde=
r.h linux/include/asm-generic/get_order.h
--- linux.vanilla/include/asm-generic/get_order.h	Thu Jan  1 03:00:00 1970
+++ linux/include/asm-generic/get_order.h	Mon Apr 29 00:45:36 2002
@@ -0,0 +1,53 @@
+#ifndef _GET_ORDER_H_
+#define _GET_ORDER_H_
+
+/* Pure 2^n version of get_order */
+#define get_order(size) \
+	(__builtin_constant_p(size) ? \
+	 __constant_get_order(size) : \
+ 	__get_order(size))
+
+#ifndef __HAVE_ARCH_GET_ORDER
+static inline int __get_order(unsigned long size)
+{
+	int order;
+
+	size =3D (size-1) >> (PAGE_SHIFT-1);
+	order =3D -1;
+	do {
+		size >>=3D 1;
+		order++;
+	} while (size);
+	return order;
+}
+#endif
+
+#define CASE_ORDER(order) \
+	case (PAGE_SIZE << ((order) - 1)) + 1 ... PAGE_SIZE << (order): \
+		return (order)
+
+static inline int __constant_get_order(unsigned long size)
+{
+	switch (size) {
+		case 1 ... PAGE_SIZE:
+			return 0;
+		CASE_ORDER(1);
+		CASE_ORDER(2);
+		CASE_ORDER(3);
+		CASE_ORDER(4);
+		CASE_ORDER(5);
+		CASE_ORDER(6);
+		CASE_ORDER(7);
+		CASE_ORDER(8);
+		CASE_ORDER(9);
+		CASE_ORDER(10);
+		CASE_ORDER(11);
+		CASE_ORDER(12);
+		CASE_ORDER(13);
+		CASE_ORDER(14);
+		CASE_ORDER(15);
+	}
+	return __get_order(size);
+}
+
+#endif
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-i386/page.h linu=
x/include/asm-i386/page.h
--- linux.vanilla/include/asm-i386/page.h	Mon Mar  4 19:33:18 2002
+++ linux/include/asm-i386/page.h	Mon Apr 29 00:36:47 2002
@@ -109,19 +109,7 @@
 	BUG(); \
 } while (0)
=20
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* __ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ia64/page.h linu=
x/include/asm-ia64/page.h
--- linux.vanilla/include/asm-ia64/page.h	Wed Mar 20 22:14:41 2002
+++ linux/include/asm-ia64/page.h	Mon Apr 29 00:45:15 2002
@@ -110,6 +110,7 @@
 #define BUG() do { printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); *=
(int *)0=3D0; } while (0)
 #define PAGE_BUG(page) do { BUG(); } while (0)
=20
+#define __HAVE_ARCH_GET_ORDER
 static __inline__ int
 get_order (unsigned long size)
 {
@@ -122,6 +123,8 @@
 		order =3D 0;
 	return order;
 }
+
+#include <asm-generic/get_order.h>
=20
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-m68k/page.h linu=
x/include/asm-m68k/page.h
--- linux.vanilla/include/asm-m68k/page.h	Mon Mar  4 19:33:19 2002
+++ linux/include/asm-m68k/page.h	Mon Apr 29 00:43:37 2002
@@ -100,19 +100,7 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* !__ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-mips/page.h linu=
x/include/asm-mips/page.h
--- linux.vanilla/include/asm-mips/page.h	Mon Mar  4 19:33:19 2002
+++ linux/include/asm-mips/page.h	Mon Apr 29 00:43:25 2002
@@ -49,19 +49,7 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* _LANGUAGE_ASSEMBLY */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-parisc/page.h li=
nux/include/asm-parisc/page.h
--- linux.vanilla/include/asm-parisc/page.h	Mon Mar  4 19:33:19 2002
+++ linux/include/asm-parisc/page.h	Mon Apr 29 00:46:19 2002
@@ -33,19 +33,7 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* !__ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ppc/page.h linux=
/include/asm-ppc/page.h
--- linux.vanilla/include/asm-ppc/page.h	Mon Mar  4 19:33:19 2002
+++ linux/include/asm-ppc/page.h	Mon Apr 29 00:43:53 2002
@@ -142,19 +142,7 @@
=20
 extern unsigned long get_zero_page_fast(void);
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* __ASSEMBLY__ */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ppc64/page.h lin=
ux/include/asm-ppc64/page.h
--- linux.vanilla/include/asm-ppc64/page.h	Tue Apr 23 19:06:36 2002
+++ linux/include/asm-ppc64/page.h	Mon Apr 29 00:41:49 2002
@@ -137,19 +137,7 @@
  */
 #define WANT_PAGE_VIRTUAL 1
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-s390/page.h linu=
x/include/asm-s390/page.h
--- linux.vanilla/include/asm-s390/page.h	Mon Mar  4 19:33:20 2002
+++ linux/include/asm-s390/page.h	Mon Apr 29 00:46:11 2002
@@ -71,19 +71,7 @@
         BUG(); \
 } while (0)                     =20
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
-
-        size =3D (size-1) >> (PAGE_SHIFT-1);
-        order =3D -1;
-        do {
-                size >>=3D 1;
-                order++;
-        } while (size);
-        return order;
-}
+#include <asm-generic/get_order.h>
=20
 /*
  * These are used to make use of C type-checking..
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-s390x/page.h lin=
ux/include/asm-s390x/page.h
--- linux.vanilla/include/asm-s390x/page.h	Mon Mar  4 19:33:20 2002
+++ linux/include/asm-s390x/page.h	Mon Apr 29 00:46:30 2002
@@ -69,19 +69,7 @@
         BUG(); \
 } while (0)                     =20
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
-
-        size =3D (size-1) >> (PAGE_SHIFT-1);
-        order =3D -1;
-        do {
-                size >>=3D 1;
-                order++;
-        } while (size);
-        return order;
-}
+#include <asm-generic/get_order.h>
=20
 /*
  * These are used to make use of C type-checking..
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sh/page.h linux/=
include/asm-sh/page.h
--- linux.vanilla/include/asm-sh/page.h	Tue Dec  4 12:40:37 2001
+++ linux/include/asm-sh/page.h	Mon Apr 29 00:44:14 2002
@@ -102,19 +102,7 @@
 	BUG(); \
 } while (0)
=20
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sparc/page.h lin=
ux/include/asm-sparc/page.h
--- linux.vanilla/include/asm-sparc/page.h	Mon Mar  4 19:33:20 2002
+++ linux/include/asm-sparc/page.h	Mon Apr 29 00:43:47 2002
@@ -150,19 +150,7 @@
=20
 #define TASK_UNMAPPED_BASE	BTFIXUP_SETHI(sparc_unmapped_base)
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #else /* !(__ASSEMBLY__) */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sparc64/page.h l=
inux/include/asm-sparc64/page.h
--- linux.vanilla/include/asm-sparc64/page.h	Wed Mar 20 22:15:35 2002
+++ linux/include/asm-sparc64/page.h	Mon Apr 29 00:44:00 2002
@@ -138,19 +138,7 @@
=20
 extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* !(__ASSEMBLY__) */
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-x86_64/page.h li=
nux/include/asm-x86_64/page.h
--- linux.vanilla/include/asm-x86_64/page.h	Tue Apr 23 19:08:02 2002
+++ linux/include/asm-x86_64/page.h	Mon Apr 29 00:41:37 2002
@@ -74,19 +74,7 @@
 #define PAGE_BUG(page) BUG()
 void out_of_line_bug(void);
=20
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-
-	size =3D (size-1) >> (PAGE_SHIFT-1);
-	order =3D -1;
-	do {
-		size >>=3D 1;
-		order++;
-	} while (size);
-	return order;
-}
+#include <asm-generic/get_order.h>
=20
 #endif /* __ASSEMBLY__ */
=20

--Dxnq1zWXvFF0Q93v--

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8zSTKBm4rlNOo3YgRAjugAJ40L6vZ7oeUSQJtZ5BiOwqtHezc6wCeOC/+
PhkSos2mGcOd7M6y1pPfUTQ=
=JC0W
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
