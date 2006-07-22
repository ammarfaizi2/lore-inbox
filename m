Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWGVTmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWGVTmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWGVTmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:42:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24525 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751012AbWGVTmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:42:45 -0400
Date: Sat, 22 Jul 2006 12:42:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <20060722162607.GA10550@osiris.ibm.com>
Message-ID: <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006, Heiko Carstens wrote:

> Sorry, I should have mentioned it: on s390 (32 bit) we set
> #define ARCH_KMALLOC_MINALIGN 8.
> This is needed since our common I/O layer allocates data structures that need
> to have an eight byte alignment. Now, if I turn on DEBUG_SLAB, nothing works
> anymore, simply because the slab cache code ignores ARCH_KMALLOC_MINALIGN and
> uses an BYTES_PER_WORD alignment instead, which it shouldn't:
> 
> also from mm/slab.c :
> 
> #ifndef ARCH_KMALLOC_MINALIGN
> /*
>  * Enforce a minimum alignment for the kmalloc caches.
>  * Usually, the kmalloc caches are cache_line_size() aligned, except when
>  * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
>  * Some archs want to perform DMA into kmalloc caches and need a guaranteed
>  * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
>  * Note that this flag disables some debug features.
>  */
> #define ARCH_KMALLOC_MINALIGN 0
> #endif
> 
> Since that didn't work I thought why not set ARCH_SLAB_MINALIGN to 8, since
> that would (according to the description) guarantee that _all_ caches would
> have an 8 byte alignment. But that didn't work too.

Why did that not work

See kmem_cache_create():
      /* 2) arch mandated alignment: disables debug if necessary */
        if (ralign < ARCH_SLAB_MINALIGN) {
                ralign = ARCH_SLAB_MINALIGN;
                if (ralign > BYTES_PER_WORD)
                        flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
        }

