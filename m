Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSFAOGi>; Sat, 1 Jun 2002 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFAOGh>; Sat, 1 Jun 2002 10:06:37 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:22451 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S317022AbSFAOGg>; Sat, 1 Jun 2002 10:06:36 -0400
Message-ID: <3CF8D3F7.8060300@didntduck.org>
Date: Sat, 01 Jun 2002 10:02:31 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial highpte patch
Content-Type: multipart/mixed;
 boundary="------------070507000803030408040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507000803030408040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Create a common GFP_USERPTE and change x86 and ppc code to use it.

--
				Brian Gerst

--------------070507000803030408040009
Content-Type: text/plain;
 name="highpte-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="highpte-1"

diff -urN linux-bk/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-bk/arch/i386/mm/init.c	Wed May 29 15:06:00 2002
+++ linux/arch/i386/mm/init.c	Fri May 31 11:01:06 2002
@@ -634,11 +634,7 @@
 	struct page *pte;
    
    	do {
-#if CONFIG_HIGHPTE
-		pte = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, 0);
-#else
-		pte = alloc_pages(GFP_KERNEL, 0);
-#endif
+		pte = alloc_pages(GFP_USERPTE, 0);
 		if (pte)
 			clear_highpage(pte);
 		else {
diff -urN linux-bk/arch/ppc/mm/pgtable.c linux/arch/ppc/mm/pgtable.c
--- linux-bk/arch/ppc/mm/pgtable.c	Wed May 15 10:27:26 2002
+++ linux/arch/ppc/mm/pgtable.c	Fri May 31 11:01:17 2002
@@ -95,13 +95,8 @@
 {
 	struct page *pte;
 	int timeout = 0;
-#ifdef CONFIG_HIGHPTE
-	int flags = GFP_KERNEL | __GFP_HIGHMEM;
-#else
-	int flags = GFP_KERNEL;
-#endif
 
-	while ((pte = alloc_pages(flags, 0)) == NULL) {
+	while ((pte = alloc_pages(GFP_USERPTE, 0)) == NULL) {
 		if (++timeout >= 10)
 			return NULL;
 		set_current_state(TASK_UNINTERRUPTIBLE);
diff -urN linux-bk/include/linux/gfp.h linux/include/linux/gfp.h
--- linux-bk/include/linux/gfp.h	Thu May 30 09:51:37 2002
+++ linux/include/linux/gfp.h	Fri May 31 11:01:43 2002
@@ -28,6 +28,12 @@
 #define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 #define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 
+#ifdef CONFIG_HIGHPTE
+#define GFP_USERPTE	(GFP_KERNEL | __GFP_HIGHMEM)
+#else
+#define GFP_USERPTE	(GFP_KERNEL)
+#endif
+
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
 

--------------070507000803030408040009--

