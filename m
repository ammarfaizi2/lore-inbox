Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266869AbTGHGs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbTGHGs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:48:27 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:18940 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S266869AbTGHGsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:48:25 -0400
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Martin Schlemmer <azarah@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>, smiler@lanil.mine.nu,
       KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030707123012.47238055.akpm@osdl.org>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	 <200307071734.01575.schlicht@uni-mannheim.de>
	 <20030707123012.47238055.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-IuPP3Uv/7izq0kKKuTlu"
Organization: 
Message-Id: <1057647818.5489.385.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 08 Jul 2003 09:03:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IuPP3Uv/7izq0kKKuTlu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-07-07 at 21:30, Andrew Morton wrote:

> Well that will explode if someone enables highpmd and has highmem.
> This would be better:
> 
> --- nv.c.orig	2003-07-05 22:55:10.000000000 -0700
> +++ nv.c	2003-07-05 22:55:58.000000000 -0700
> @@ -2105,11 +2105,14 @@
>      if (pgd_none(*pg_dir))
>          goto failed;
>  
> -    pg_mid_dir = pmd_offset(pg_dir, address);
> -    if (pmd_none(*pg_mid_dir))
> +    pg_mid_dir = pmd_offset_map(pg_dir, address);
> +    if (pmd_none(*pg_mid_dir)) {
> +	pmd_unmap(pg_mid_dir);
>          goto failed;
> +    }
>  
>      NV_PTE_OFFSET(address, pg_mid_dir, pte);
> +    pmd_unmap(pg_mid_dir);
>  
>      if (!pte_present(pte))
>          goto failed;
> 
> -

Bit too specific to -mm2, what about the the attached?


Regards,

-- 
Martin Schlemmer


--=-IuPP3Uv/7izq0kKKuTlu
Content-Disposition: attachment; filename=NVIDIA_kernel-1.0-4363-highpmd.diff
Content-Type: text/x-patch; name=NVIDIA_kernel-1.0-4363-highpmd.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urpN NVIDIA_kernel-1.0-4363.orig/nv-linux.h NVIDIA_kernel-1.0-4363/nv-linux.h
--- NVIDIA_kernel-1.0-4363.orig/nv-linux.h	2003-04-20 03:57:19.000000000 +0200
+++ NVIDIA_kernel-1.0-4363/nv-linux.h	2003-07-08 07:53:49.000000000 +0200
@@ -186,6 +186,15 @@
     }
 #endif
 
+#if defined(pmd_offset_map)
+#define NV_PMD_OFFSET(address, pg_dir) \
+    pmd_offset_map(pg_dir, address);
+#define NV_PMD_OFFSET_UNMAP 1
+#else
+#define NV_PMD_OFFSET(address, pg_dir) \
+    pmd_offset(pg_dir, address)
+#endif
+
 #define NV_PAGE_ALIGN(addr)             ( ((addr) + PAGE_SIZE - 1) / PAGE_SIZE)
 #define NV_MASK_OFFSET(addr)            ( (addr) & (PAGE_SIZE - 1) )
 
diff -urpN NVIDIA_kernel-1.0-4363.orig/nv.c NVIDIA_kernel-1.0-4363/nv.c
--- NVIDIA_kernel-1.0-4363.orig/nv.c	2003-04-20 03:57:19.000000000 +0200
+++ NVIDIA_kernel-1.0-4363/nv.c	2003-07-08 07:55:09.000000000 +0200
@@ -2191,11 +2191,18 @@ nv_get_phys_address(unsigned long addres
     if (pgd_none(*pg_dir))
         goto failed;
 
-    pg_mid_dir = pmd_offset(pg_dir, address);
-    if (pmd_none(*pg_mid_dir))
+    pg_mid_dir = NV_PMD_OFFSET(pg_dir, address);
+    if (pmd_none(*pg_mid_dir)) {
+#if defined(NV_PMD_OFFSET_UNMAP)
+       pmd_unmap(pg_mid_dir);
+#endif
         goto failed;
+    }
 
     NV_PTE_OFFSET(address, pg_mid_dir, pte);
+#if defined(NV_PMD_OFFSET_UNMAP)
+    pmd_unmap(pg_mid_dir);
+#endif
 
     if (!pte_present(pte))
         goto failed;

--=-IuPP3Uv/7izq0kKKuTlu--

