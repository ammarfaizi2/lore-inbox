Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWGWQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWGWQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWGWQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:26:55 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:48258 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751248AbWGWQ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:26:54 -0400
Date: Sun, 23 Jul 2006 18:24:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch] slab: always follow arch requested alignments
Message-ID: <20060723162427.GA10553@osiris.ibm.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 06:03:09AM -0700, Christoph Lameter wrote:
> On Sun, 23 Jul 2006, Heiko Carstens wrote:
> > > See kmem_cache_create():
> > >       /* 2) arch mandated alignment: disables debug if necessary */
> > >         if (ralign < ARCH_SLAB_MINALIGN) {
> > >                 ralign = ARCH_SLAB_MINALIGN;
> > >                 if (ralign > BYTES_PER_WORD)
> > >                         flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
> > >         }
> > 
> > That is because if kmem_cache_create gets called with SLAB_HWCACHE_ALIGN set
> > in flags then ralign will be greater or equal to ARCH_SLAB_MINALIGN:
> > 
> >         /* 1) arch recommendation: can be overridden for debug */ 
> >         if (flags & SLAB_HWCACHE_ALIGN) { 
> > 	        [...]
> >                 ralign = cache_line_size(); 
> > 	        [...]
> 
> Ok. Then you do not have a problem because ralign is greater than
> ARCH_SLAB_MINALIGN.
>  
> > Therefore the test above will be passed and SLAB_RED_ZONE and SLAB_STORE_USER
> > will stay in flags.
> > cache_line_size() will return 256 on s390.
> 
> Looks as if you would have the correct alignment then. I still do not 
> understand where the problem is since you want to align on an 8 byte 
> boundary.

CONFIG_DEBUG_SLAB is on. In step 4) we have align = ralign.
Still ok.
Next thing:

	if (flags & SLAB_RED_ZONE) {
		/* redzoning only works with word aligned caches */
		align = BYTES_PER_WORD;

Result: align is less than ARCH_SLAB_MINALIGN -> busted.
Same is true if SLAB_STORE_USER is set.
Therefore I masked them both out in my patch.
