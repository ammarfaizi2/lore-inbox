Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVCTOD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVCTOD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 09:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVCTOCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 09:02:49 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:22035 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261222AbVCTOCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 09:02:35 -0500
Date: Sun, 20 Mar 2005 23:04:24 +0900 (JST)
Message-Id: <20050320.230424.60656592.yoshfuji@linux-ipv6.org>
To: ralph@inputplus.co.uk
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't do pointless NULL checks and casts before
 kfree() in security/ 
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200503201331.j2KDVhm12383@blake.inputplus.co.uk>
References: <Pine.LNX.4.62.0503201407220.2501@dragon.hyggekrogen.localhost>
	<200503201331.j2KDVhm12383@blake.inputplus.co.uk>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200503201331.j2KDVhm12383@blake.inputplus.co.uk> (at Sun, 20 Mar 2005 13:31:43 +0000), Ralph Corderoy <ralph@inputplus.co.uk> says:

> > the short version also have the real bennefits of generating shorter
> > and faster code as well as being shorter "on-screen".
> 
> Faster code?  I'd have thought avoiding the function call outweighed the
> overhead of checking before calling.

Modern CPU can run nicely (expecially with register parameters).
Even if even matters, we can check inline like this:

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== include/linux/slab.h 1.40 vs edited =====
--- 1.40/include/linux/slab.h	2005-03-12 05:32:31 +09:00
+++ edited/include/linux/slab.h	2005-03-20 22:47:57 +09:00
@@ -106,8 +106,17 @@
 }
 
 extern void *kcalloc(size_t, size_t, int);
-extern void kfree(const void *);
+extern void __kfree(const void *);
 extern unsigned int ksize(const void *);
+
+static inline void kfree(const void *p)
+{
+#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
+	if (!p)
+		return;
+#endif
+	__kfree(p);
+}
 
 extern int FASTCALL(kmem_cache_reap(int));
 extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
===== mm/slab.c 1.156 vs edited =====
--- 1.156/mm/slab.c	2005-03-10 17:38:21 +09:00
+++ edited/mm/slab.c	2005-03-20 22:42:45 +09:00
@@ -2561,7 +2561,7 @@
 EXPORT_SYMBOL(kcalloc);
 
 /**
- * kfree - free previously allocated memory
+ * __kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
  * Don't free memory not originally allocated by kmalloc()
@@ -2572,8 +2572,10 @@
 	kmem_cache_t *c;
 	unsigned long flags;
 
+#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 	if (!objp)
 		return;
+#endif
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
@@ -2581,7 +2583,7 @@
 	local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(__kfree);
 
 #ifdef CONFIG_SMP
 /**
