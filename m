Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263495AbTDVUA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDVUA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:00:29 -0400
Received: from [12.47.58.232] ([12.47.58.232]:55027 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263495AbTDVUA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:00:27 -0400
Date: Tue, 22 Apr 2003 13:10:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexey Mahotkin <alexm@hsys.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement __GFP_REPEAT, __GFP_NOFAIL, __GFP_NORETRY
Message-Id: <20030422131033.6be5a66e.akpm@digeo.com>
In-Reply-To: <87bryy9usl.fsf@192.168.10.23>
References: <87bryy9usl.fsf@192.168.10.23>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2003 20:12:25.0152 (UTC) FILETIME=[7D82CC00:01C3090B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Mahotkin <alexm@hsys.msk.ru> wrote:
>
> 
> 
> Maybe I am wrong, but recent patch added 
> 
> +#define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
> 
> 
> which conflicts numerically with 
> 
> #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
> 
> 
> e.g., mm/slab.c contains the following snippet:
> 
>         if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
>                 BUG();
>         if (flags & SLAB_NO_GROW)
>                 return 0;
> 

Well spotted, thanks.  This should fix it up:


diff -puN include/linux/slab.h~SLAB_NO_GROW-fix include/linux/slab.h
--- 25/include/linux/slab.h~SLAB_NO_GROW-fix	Tue Apr 22 13:07:12 2003
+++ 25-akpm/include/linux/slab.h	Tue Apr 22 13:08:01 2003
@@ -22,8 +22,11 @@ typedef struct kmem_cache_s kmem_cache_t
 #define	SLAB_KERNEL		GFP_KERNEL
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL|__GFP_NORETRY)
-#define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|\
+				__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|\
+				__GFP_NOFAIL|__GFP_NORETRY)
+
+#define	SLAB_NO_GROW		__GFP_NO_GROW	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
  * The first 3 are only valid when the allocator as been build
diff -puN include/linux/gfp.h~SLAB_NO_GROW-fix include/linux/gfp.h
--- 25/include/linux/gfp.h~SLAB_NO_GROW-fix	Tue Apr 22 13:07:12 2003
+++ 25-akpm/include/linux/gfp.h	Tue Apr 22 13:08:57 2003
@@ -31,6 +31,7 @@
 #define __GFP_REPEAT	0x400	/* Retry the allocation.  Might fail */
 #define __GFP_NOFAIL	0x800	/* Retry for ever.  Cannot fail */
 #define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */
+#define __GFP_NO_GROW	0x2000	/* Internal slab usage */
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)

_

