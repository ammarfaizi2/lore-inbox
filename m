Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbQL1P2t>; Thu, 28 Dec 2000 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQL1P2k>; Thu, 28 Dec 2000 10:28:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22281 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129561AbQL1P21>;
	Thu, 28 Dec 2000 10:28:27 -0500
Date: Thu, 28 Dec 2000 14:58:01 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kmalloc(HIGHUSER) crashes
Message-ID: <20001228145801.C19693@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doh, i'm a moron.

------ This is a copy of the message ------

Date: Thu, 28 Dec 2000 14:51:25 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.rutgers.edu
Cc: torvalds@transmeta.com
Subject: [PATCH] kmalloc(HIGHUSER) crashes

The slab cache accepts the __GFP_HIGHMEM flag, but it will then die
horribly, tracing it through:

<linux/slab.h>
#define SLAB_LEVEL_MASK         (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHMEM)

slab.c:kmem_cache_grow()
        if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
	                BUG();
(...)
slab.c:kmem_getpages()
        addr = (void*) __get_free_pages(flags, cachep->gfporder);

__get_free_pages calls page_address() on the allocated pages, but:

/*
 * Permanent address of a page. Obviously must never be
 * called on a highmem page.
 */
#define page_address(page) ((page)->virtual)


so I think we should apply the patch at the bottom of this email.

Ideally, I think slab.c should call alloc_pages and manage them directly
-- it calls virt_to_page often enough that it should become more intimate
with the linux struct page *.  But I don't think we should allow HIGHMEM
kmallocs anyway; we'd run out of kmap space too readily.

Index: include/linux/slab.h
===================================================================
RCS file: /var/cvs/linux/include/linux/slab.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 include/linux/slab.h
--- include/linux/slab.h	2000/10/31 19:18:05	1.1.1.1
+++ include/linux/slab.h	2000/12/28 11:06:49
@@ -22,7 +22,7 @@ typedef struct kmem_cache_s kmem_cache_t
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHMEM)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().

-- 
Revolutions do not require corporate support.

----- End forwarded message -----

-- 
Revolutions do not require corporate support.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
