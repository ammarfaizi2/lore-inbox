Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUBZPdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUBZPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:33:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33471 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261962AbUBZPdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:33:11 -0500
Date: Thu, 26 Feb 2004 16:33:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix small highmem bio bounce bvec handling glitch
Message-ID: <20040226153307.GS7580@suse.de>
References: <1077807966.10397.2.camel@leto.cs.pocnet.net> <20040226151026.GQ7580@suse.de> <1077809433.10397.11.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077809433.10397.11.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26 2004, Christophe Saout wrote:
> Am Do, den 26.02.2004 schrieb Jens Axboe um 16:10:
> 
> > > --- linux.orig/mm/highmem.c	2004-01-21 19:08:45.000000000 +0100
> > > +++ linux/mm/highmem.c	2004-02-26 15:47:14.574722576 +0100
> > > @@ -294,7 +294,12 @@
> > >  		if (tovec->bv_page == fromvec->bv_page)
> > >  			continue;
> > >  
> > > -		vfrom = page_address(fromvec->bv_page) + fromvec->bv_offset;
> > > +		/*
> > > +		 * fromvec->bv_offset and fromvec->bv_len might have been
> > > +		 * modified by the block layer, so use the original copy,
> > > +		 * bounce_copy_vec already uses tovec->bv_len
> > > +		 */
> > > +		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
> > >  
> > >  		bounce_copy_vec(tovec, vfrom);
> > 
> > Irk yes, that's is pretty nasty, I really wish we could avoid screwing
> > with vec entries
> 
> What about a bio->bi_bvec_done field?

That'd work. Suparna originally suggested bio->bi_voffset (iirc) as a
current offset. It just doesn't feel completely right...

> > (it's pretty obscure for bio clones, too)...
> 
> Yes, I noticed that dm-crypt also does the same mistake for reads. I'm
> going to change it too (easily accomplished).

Great.

-- 
Jens Axboe

