Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTBTTwx>; Thu, 20 Feb 2003 14:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBTTwx>; Thu, 20 Feb 2003 14:52:53 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:62187 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266948AbTBTTwc>; Thu, 20 Feb 2003 14:52:32 -0500
Message-Id: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de>
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c with flush_tlb_all()
Date: Thu, 20 Feb 2003 21:00:05 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_GPTV+Ly8Mcw+RMQ";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_GPTV+Ly8Mcw+RMQ
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FPTV+bi5jiq8u8s"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_FPTV+bi5jiq8u8s
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: body text
Content-Disposition: inline

This patch replaces the flush_map() function in the arch/i386/mm/pageattr.c file with flush_tlb_all() calls, as the flush_map() function wants to do the same, but just forgot the preempt_disable() and preempt_enable() calls.

To minimize future inconsistency I think this patch should be applied...

Best regards
  Thomas Schlichter

--Boundary-01=_FPTV+bi5jiq8u8s
Content-Type: text/x-diff;
  charset="us-ascii";
  name="remove_flush_map.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="remove_flush_map.patch"

=2D-- linux-2.5.62/arch/i386/mm/pageattr.c.orig	Wed Feb 19 16:44:56 2003
+++ linux-2.5.62/arch/i386/mm/pageattr.c	Wed Feb 19 16:46:11 2003
@@ -45,17 +45,6 @@
 	return base;
 }=20
=20
=2Dstatic void flush_kernel_map(void *dummy)=20
=2D{=20
=2D	/* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
=2D	if (boot_cpu_data.x86_model >=3D 4)=20
=2D		asm volatile("wbinvd":::"memory");=20
=2D	/* Flush all to work around Errata in early athlons regarding=20
=2D	 * large page flushing.=20
=2D	 */
=2D	__flush_tlb_all(); =09
=2D}
=2D
 static void set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)=20
 {=20
 	set_pte_atomic(kpte, pte); 	/* change init_mm */
@@ -129,14 +118,6 @@
 	return 0;
 }=20
=20
=2Dstatic inline void flush_map(void)
=2D{=09
=2D#ifdef CONFIG_SMP=20
=2D	smp_call_function(flush_kernel_map, NULL, 1, 1);
=2D#endif=09
=2D	flush_kernel_map(NULL);
=2D}
=2D
 struct deferred_page {=20
 	struct deferred_page *next;=20
 	struct page *fpage;
@@ -172,7 +153,7 @@
 			struct deferred_page *df;
 			df =3D kmalloc(sizeof(struct deferred_page), GFP_KERNEL);=20
 			if (!df) {
=2D				flush_map();
+				flush_tlb_all();
 				__free_page(fpage);
 			} else {=20
 				df->next =3D df_list;
@@ -192,7 +173,7 @@
 	down_read(&init_mm.mmap_sem);
 	df =3D xchg(&df_list, NULL);
 	up_read(&init_mm.mmap_sem);
=2D	flush_map();
+	flush_tlb_all();
 	for (; df; df =3D next_df) {=20
 		next_df =3D df->next;
 		if (df->fpage)=20

--Boundary-01=_FPTV+bi5jiq8u8s--

--Boundary-03=_GPTV+Ly8Mcw+RMQ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+VTPGYAiN+WRIZzQRAmYRAJwIIWY1h8eWae1qLoMxxtQaJZY39QCdEI+K
tFumUlvHZIKsKJEY6hYthjY=
=54KB
-----END PGP SIGNATURE-----

--Boundary-03=_GPTV+Ly8Mcw+RMQ--

