Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVIVKeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVIVKeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVIVKeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:34:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:21907 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030247AbVIVKep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:34:45 -0400
Date: Thu, 22 Sep 2005 14:34:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-ID: <20050922143427.A29921@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org> <20050922101259.A29179@jurassic.park.msu.ru> <20050921234232.1034cc02.akpm@osdl.org> <20050922130449.A29503@jurassic.park.msu.ru> <20050922022152.0c0f0c97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050922022152.0c0f0c97.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 22, 2005 at 02:21:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:21:52AM -0700, Andrew Morton wrote:
> hm, you might need to do some special-casing around that function.

Maybe something like this?
I think this also makes more obvious how index_of() was
supposed to work.

Ivan.

--- 2.6.14-rc1/include/asm-alpha/compiler.h.inline	Mon Aug 29 03:41:01 2005
+++ linux/include/asm-alpha/compiler.h	Thu Sep 22 13:49:53 2005
@@ -98,6 +98,9 @@
 #undef inline
 #undef __inline__
 #undef __inline
-
+#if __GNUC__ == 3 && __GNUC_MINOR__ >= 1 || __GNUC__ > 3
+#undef __always_inline
+#define __always_inline		inline __attribute__((always_inline))
+#endif
 
 #endif /* __ALPHA_COMPILER_H */
--- 2.6.14-rc1/mm/slab.c	Tue Sep 13 14:16:37 2005
+++ linux/mm/slab.c	Thu Sep 22 13:58:18 2005
@@ -308,12 +308,12 @@ struct kmem_list3 __initdata initkmem_li
 #define	SIZE_L3 (1 + MAX_NUMNODES)
 
 /*
- * This function may be completely optimized away if
+ * This function must be completely optimized away if
  * a constant is passed to it. Mostly the same as
  * what is in linux/slab.h except it returns an
  * index.
  */
-static inline int index_of(const size_t size)
+static __always_inline int index_of(const size_t size)
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
@@ -329,7 +329,8 @@ static inline int index_of(const size_t 
 			extern void __bad_size(void);
 			__bad_size();
 		}
-	}
+	} else
+		BUG();
 	return 0;
 }
 
