Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTIKLCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTIKLCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:02:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39556 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261206AbTIKLCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:02:19 -0400
Date: Thu, 11 Sep 2003 16:38:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: akpm@osdl.org, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030911110853.GB3700@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911055428.GA1140@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:24:30AM +0530, Ravikiran G Thirumalai wrote:
> On Wed, Sep 10, 2003 at 11:41:04AM -0400, Robert Love wrote:
> > On Wed, 2003-09-10 at 04:16, Ravikiran G Thirumalai wrote:
> > 
> > > Am I missing something or can there really be two objects on the same 
> > > cacheline even when SLAB_HWCACHE_ALIGN is specified?
> > 
> > No, you are right.
> > 
> > If your object _must_ be cache aligned, use SLAB_MUST_HWCACHE_ALIGN.
> > 
> 
> WOW!!!
> Looking at the code though, SLAB_MUST_HWCACHE_ALIGN is never considered
> by kmem_cache_create or kmem_cache_alloc. So, right now, there is no way of 
> getting objects which are _guaranteed_ to be cacheline aligned!!!(?)
>

Hi Andrew, Manfred
Looks like SLAB_HWCACHE_ALIGN does not guarantee cacheline alignment
and SLAB_MUST_HWCACHE_ALIGN is not at all recognised by the slab code.
(Right now, SLAB_MUST_HWCACHE_ALIGN caches are aligned to sizeof (void *)!!)

The following patch fixes the slab for this.  Note that I have replaced
alignment arithmetic to use ALIGN macro too.  I have done some basic
testing on a 4 way pIII with 32 byte cacheline -- but the patch probably
needs testing on other archs.  Please give it a whirl on mm* trees.  
This should help task_struct cache and pte_chain caches (other users of 
SLAB_MUST_HWCACHE_ALIGN also use SLAB_HWCACHE_ALIGN -- smart huh?)

I also propose to rename SLAB_HWCACHE_ALIGN to SLAB_MAY_HWCACHE_ALIGN since
SLAB_HWCACHE_ALIGN seems very misleading -- if everyone agrees.

Andrew, this also means alloc_percpu in its current form is not guaranteed
to work on machines with cacheline sizes greater than 32 bytes.  I am
working on a fix for alloc_percpu.

Thanks,
Kiran


diff -ruN -X dontdiff.1 linux-2.6.0-test5-mm1/mm/slab.c slabfix-2.6.0-test5-mm1/mm/slab.c
--- linux-2.6.0-test5-mm1/mm/slab.c	Thu Sep 11 15:08:37 2003
+++ slabfix-2.6.0-test5-mm1/mm/slab.c	Thu Sep 11 15:23:28 2003
@@ -1101,7 +1101,7 @@
 #endif
 #endif
 	align = BYTES_PER_WORD;
-	if (flags & SLAB_HWCACHE_ALIGN)
+	if ((flags & SLAB_HWCACHE_ALIGN) | (flags & SLAB_MUST_HWCACHE_ALIGN))
 		align = L1_CACHE_BYTES;
 
 	/* Determine if the slab management is 'on' or 'off' slab. */
@@ -1112,12 +1112,14 @@
 		 */
 		flags |= CFLGS_OFF_SLAB;
 
-	if (flags & SLAB_HWCACHE_ALIGN) {
+	if (flags & SLAB_MUST_HWCACHE_ALIGN) {
 		/* Need to adjust size so that objs are cache aligned. */
+		size = ALIGN(size, align);
+	} else if (flags & SLAB_HWCACHE_ALIGN) {
 		/* Small obj size, can get at least two per cache line. */
 		while (size <= align/2)
 			align /= 2;
-		size = (size+align-1)&(~(align-1));
+		size = ALIGN(size, align);
 	}
 
 	/* Cal size (in pages) of slabs, and the num of objs per slab.
@@ -1175,8 +1177,7 @@
 	}
 
 	/* Offset must be a multiple of the alignment. */
-	offset += (align-1);
-	offset &= ~(align-1);
+	offset = ALIGN(offset, align);
 	if (!offset)
 		offset = L1_CACHE_BYTES;
 	cachep->colour_off = offset;
