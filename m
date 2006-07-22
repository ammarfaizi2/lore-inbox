Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWGVQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGVQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWGVQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:28:34 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:7731 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750874AbWGVQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:28:33 -0400
Date: Sat, 22 Jul 2006 18:26:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch] slab: always follow arch requested alignments
Message-ID: <20060722162607.GA10550@osiris.ibm.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 07:50:00AM -0700, Christoph Lameter wrote:
> On Sat, 22 Jul 2006, Heiko Carstens wrote:
> 
> > In kmem_cache_create(): always check if BYTES_PER_WORD is less than
> > ARCH_SLAB_MINALIGN and disable debug options that would set the
> > alignment to BYTES_PER_WORD.
> 
> Why disable debug options?

Because if they are still enabled we would end up with an BYTES_PER_WORD
alignment (which is bad, see below).

> > This will make sure that all slab caches will have at least an
> > ARCH_SLAB_MINALIGN alignment.
> 
> You can specify alignment at cache creation. Why do we need all slabs to 
> be aligned?

Uhm, that's the meaning of ARCH_SLAB_MINALIGN, isn't it?

from mm/slab.c :

#ifndef ARCH_SLAB_MINALIGN
/*
 * Enforce a minimum alignment for all caches.
 * Intended for archs that get misalignment faults even for BYTES_PER_WORD
 * aligned buffers. Includes ARCH_KMALLOC_MINALIGN.
 * If possible: Do not enable this flag for CONFIG_DEBUG_SLAB, it disables
 * some debug features.
 */
#define ARCH_SLAB_MINALIGN 0
#endif

> > In addition make sure that a caller mandated align which is greater
> > than BYTES_PER_WORD also disables the same debug options.
> > This makes sure that ARCH_KMALLOC_MINALIGN also has an effect if
> > CONFIG_DEBUG_SLAB is set.
> 
> Is there a particular problem you are trying to address?

Sorry, I should have mentioned it: on s390 (32 bit) we set
#define ARCH_KMALLOC_MINALIGN 8.
This is needed since our common I/O layer allocates data structures that need
to have an eight byte alignment. Now, if I turn on DEBUG_SLAB, nothing works
anymore, simply because the slab cache code ignores ARCH_KMALLOC_MINALIGN and
uses an BYTES_PER_WORD alignment instead, which it shouldn't:

also from mm/slab.c :

#ifndef ARCH_KMALLOC_MINALIGN
/*
 * Enforce a minimum alignment for the kmalloc caches.
 * Usually, the kmalloc caches are cache_line_size() aligned, except when
 * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
 * Some archs want to perform DMA into kmalloc caches and need a guaranteed
 * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
 * Note that this flag disables some debug features.
 */
#define ARCH_KMALLOC_MINALIGN 0
#endif

Since that didn't work I thought why not set ARCH_SLAB_MINALIGN to 8, since
that would (according to the description) guarantee that _all_ caches would
have an 8 byte alignment. But that didn't work too.

So the result is this patch, which makes DEBUG_SLAB work on s390. And actually
guarantees what the above descriptions imply (unless the patch is broken).
