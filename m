Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbTGGPTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267066AbTGGPTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:19:45 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:37034 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S267064AbTGGPTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:19:40 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: smiler@lanil.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Date: Mon, 7 Jul 2003 17:33:53 +0200
User-Agent: KMail/1.5.9
Cc: linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
In-Reply-To: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pLZC/+/78wB9/mz"
Message-Id: <200307071734.01575.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pLZC/+/78wB9/mz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Monday 07 July 2003 17:08 schrieb Christian Axelsson:
> Ok, running fine with 2.5.74-mm2 but when I try to insert the nvidia
> module (with patches from www.minion.de applied) it gives
>
> nvidia: Unknown symbol pmd_offset
>
> in dmesg. The vmware vmmon module gives the same error (the others wont
> compile but thats a different story).
>
> The nvidia module works fine under plain 2.5.74.

The problem is the highpmd patch in -mm2. There are two options:
1. Revert the highpmd patch.
2. Apply the attached patch to the NVIDIA kernel module sources.

Best regards
   Thomas Schlichter

--Boundary-00=_pLZC/+/78wB9/mz
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="NVIDIA_kernel-1.0-4363-highpmd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="NVIDIA_kernel-1.0-4363-highpmd.diff"

--- NVIDIA_kernel-1.0-4363/nv-linux.h.orig	Sun Jul  6 14:42:34 2003
+++ NVIDIA_kernel-1.0-4363/nv-linux.h	Mon Jul  7 14:57:02 2003
@@ -225,6 +225,18 @@
     }
 #endif
 
+#if defined(pmd_offset_map)
+#define NV_PMD_OFFSET(address, pg_dir, pg_mid_dir) \
+    { \
+        pmd_t *pg_mid_dir__ = pmd_offset_map(pg_dir, address); \
+        pg_mid_dir = *pg_mid_dir__; \
+        pmd_unmap(pg_mid_dir__); \
+    }
+#else
+#define NV_PMD_OFFSET(address, pg_dir, pg_mid_dir) \
+    pg_mid_dir = *pmd_offset(pg_dir, address)
+#endif
+
 #define NV_PAGE_ALIGN(addr)             ( ((addr) + PAGE_SIZE - 1) / PAGE_SIZE)
 #define NV_MASK_OFFSET(addr)            ( (addr) & (PAGE_SIZE - 1) )
 
--- NVIDIA_kernel-1.0-4363/nv.c.orig	Sun Jul  6 14:45:36 2003
+++ NVIDIA_kernel-1.0-4363/nv.c	Sun Jul  6 14:58:55 2003
@@ -2084,7 +2084,7 @@
 nv_get_phys_address(unsigned long address)
 {
     pgd_t *pg_dir;
-    pmd_t *pg_mid_dir;
+    pmd_t pg_mid_dir;
     pte_t pte;
 
 #if defined(NVCPU_IA64)
@@ -2105,11 +2105,12 @@
     if (pgd_none(*pg_dir))
         goto failed;
 
-    pg_mid_dir = pmd_offset(pg_dir, address);
-    if (pmd_none(*pg_mid_dir))
+    NV_PMD_OFFSET(address, pg_dir, pg_mid_dir);
+
+    if (pmd_none(pg_mid_dir))
         goto failed;
 
-    NV_PTE_OFFSET(address, pg_mid_dir, pte);
+    NV_PTE_OFFSET(address, &pg_mid_dir, pte);
 
     if (!pte_present(pte))
         goto failed;

--Boundary-00=_pLZC/+/78wB9/mz--
