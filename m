Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWGWHh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWGWHh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 03:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWGWHh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 03:37:27 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:9853 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750768AbWGWHh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 03:37:27 -0400
Date: Sun, 23 Jul 2006 09:35:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch] slab: always follow arch requested alignments
Message-ID: <20060723073500.GA10556@osiris.ibm.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 12:42:32PM -0700, Christoph Lameter wrote:
> On Sat, 22 Jul 2006, Heiko Carstens wrote:
> > Since that didn't work I thought why not set ARCH_SLAB_MINALIGN to 8, since
> > that would (according to the description) guarantee that _all_ caches would
> > have an 8 byte alignment. But that didn't work too.
> 
> Why did that not work
> 
> See kmem_cache_create():
>       /* 2) arch mandated alignment: disables debug if necessary */
>         if (ralign < ARCH_SLAB_MINALIGN) {
>                 ralign = ARCH_SLAB_MINALIGN;
>                 if (ralign > BYTES_PER_WORD)
>                         flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>         }

That is because if kmem_cache_create gets called with SLAB_HWCACHE_ALIGN set
in flags then ralign will be greater or equal to ARCH_SLAB_MINALIGN:

        /* 1) arch recommendation: can be overridden for debug */ 
        if (flags & SLAB_HWCACHE_ALIGN) { 
	        [...]
                ralign = cache_line_size(); 
	        [...]

Therefore the test above will be passed and SLAB_RED_ZONE and SLAB_STORE_USER
will stay in flags.
cache_line_size() will return 256 on s390.
