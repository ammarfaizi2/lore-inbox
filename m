Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWG1C0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWG1C0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWG1C0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:26:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60641 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932373AbWG1C0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:26:16 -0400
Date: Thu, 27 Jul 2006 19:25:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, heiko.carstens@de.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: respect architecture and caller mandated alignment
In-Reply-To: <Pine.LNX.4.58.0607271514310.2172@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0607271909580.15840@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0607271514310.2172@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Pekka J Enberg wrote:

> As explained by Heiko, on s390 (32-bit) ARCH_KMALLOC_MINALIGN is set to eight
> because their common I/O layer allocates data structures that need to have an
> eight byte alignment. This does not work when CONFIG_SLAB_DEBUG is enabled
> because kmem_cache_create will override alignment to BYTES_PER_WORD which is
> four.
> 
> So change kmem_cache_create to ensure cache alignment is always at minimum
> what the architecture or caller mandates even if slab debugging is enabled.

Note that this will disable SLAB_RED_ZONE and SLAB_STORE_USER 
for the following SLAB_DEBUG cases:

1. For all slabs if an arch sets ARCH_SLAB_MINALIGN > BYTES_PER_WORD

by:

      /* 2) arch mandated alignment: disables debug if necessary */
        if (ralign < ARCH_SLAB_MINALIGN) {
                ralign = ARCH_SLAB_MINALIGN;
                if (ralign > BYTES_PER_WORD)
                        flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
        }

ralign = BYTES_PER_WORD per your change for slab debug.
ARCH_SLAB_MINALIGN > BYTES_PER_WORD -> SLAB_RED_ZONE and SLAB_STORE_USER 
off.

2. For all general (kmalloc) slabs if an arch sets
   ARCH_KMALLOC_MINALIGN > BYTES_PER_WORD

by:

     /* 3) caller mandated alignment: disables debug if necessary */
        if (ralign < align) {
                ralign = align;
                if (ralign > BYTES_PER_WORD)
                        flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
        }

ralign = BYTES_PER_WORD by your change.
align = ARCH_KMALLOC_MINALIGN (passed by kmem_cache_init)
Therefore SLAB_RED_ZONE and SLAB_STORE_USER are always off.

F.e. S/390 will not be able to use slab debug for the general slabs.

You may want to document that change somewhere.


Note that it is not possible to do Redzoning and aligning at the same 
time. Redzoning adds a word before and after the object. If you would 
align it then you would align the whole thing which would result in an 
alignment visible to the slab user of alignment + sizeof(word).
