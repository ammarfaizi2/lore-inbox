Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLPWZs>; Mon, 16 Dec 2002 17:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLPWZs>; Mon, 16 Dec 2002 17:25:48 -0500
Received: from fep01.superonline.com ([212.252.122.40]:54921 "EHLO
	fep01.superonline.com") by vger.kernel.org with ESMTP
	id <S261732AbSLPWZq>; Mon, 16 Dec 2002 17:25:46 -0500
Message-ID: <3DFE522A.6010803@superonline.com>
Date: Tue, 17 Dec 2002 00:22:34 +0200
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: rmap and nvidia?
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050006030902040709090305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006030902040709090305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is this patch correct in any way?
(Ripped out of the 2.5 patch and modified some).

Thanks.


--------------050006030902040709090305
Content-Type: text/plain;
 name="NVIDIA_kernel_rmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NVIDIA_kernel_rmap.patch"

diff -urN NVIDIA_kernel-1.0-4191/nv.c NVIDIA_kernel.rmap15b/nv.c
--- NVIDIA_kernel-1.0-4191/nv.c	2002-12-09 22:27:15.000000000 +0200
+++ NVIDIA_kernel.rmap15b/nv.c	2002-12-17 00:03:12.000000000 +0200
@@ -2217,7 +2217,7 @@
 {
     pgd_t *pg_dir;
     pmd_t *pg_mid_dir;
-    pte_t *pte__, pte;
+    pte_t pte;
 
 #if defined(NVCPU_IA64)
     if (address > __IA64_UNCACHED_OFFSET)
@@ -2241,14 +2241,7 @@
     if (pmd_none(*pg_mid_dir))
         goto failed;
 
-#if defined (pte_offset_atomic)
-    pte__ = pte_offset_atomic(pg_mid_dir, address);
-    pte = *pte__;
-    pte_kunmap(pte__);
-#else
-    pte__ = NULL;
-    pte = *pte_offset(pg_mid_dir, address);
-#endif
+    PTE_OFFSET(pg_mid_dir, address, pte);
 
     if (!pte_present(pte))
         goto failed;
diff -urN NVIDIA_kernel-1.0-4191/nv-linux.h NVIDIA_kernel.rmap15b/nv-linux.h
--- NVIDIA_kernel-1.0-4191/nv-linux.h	2002-12-09 22:27:15.000000000 +0200
+++ NVIDIA_kernel.rmap15b/nv-linux.h	2002-12-17 00:02:19.000000000 +0200
@@ -146,6 +146,28 @@
 #  define VMA_PRIVATE(vma)              ((void*)((vma)->vm_pte))
 #endif
 
+#ifdef pte_offset_map		/* rmap-vm or 2.5  */
+#define PTE_OFFSET(pmd, address, pte)               \
+ {                                                  \
+     pte_t *pPTE;                                   \
+     pPTE = pte_offset_map(pmd, address);           \
+     pte = *pPTE;                                   \
+     pte_unmap(pPTE);                               \
+ }
+#else
+#ifdef pte_offset_atomic		/* aa-vm   */
+#define PTE_OFFSET(pmd, address, pte)               \
+  {                                                 \
+     pte_t *pPTE;                                   \
+     pPTE = pte_offset_atomic(pmd, address);        \
+     pte = *pPTE;                                   \
+     pte_kunmap(pPTE);                              \
+  }
+#else	/* !pte_offset_atomic */
+#define PTE_OFFSET(pmd, address, pte)   (pte = *pte_offset(pmd, address))
+#endif	/* pte_offset_atomic  */
+#endif	/* pte_offset_map     */
+
 #define NV_PAGE_ALIGN(addr)             ( ((addr) + PAGE_SIZE - 1) / PAGE_SIZE)
 #define NV_MASK_OFFSET(addr)            ( (addr) & (PAGE_SIZE - 1) )
 

--------------050006030902040709090305--

