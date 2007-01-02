Return-Path: <linux-kernel-owner+w=401wt.eu-S1752410AbXABXeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXABXeu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbXABXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:34:50 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:43592 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752334AbXABXet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:34:49 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Miller <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070102.151906.21595863.davem@davemloft.net>
References: <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
	 <20070101234559.GE30535@flint.arm.linux.org.uk>
	 <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
	 <20070102.151906.21595863.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 17:34:18 -0600
Message-Id: <1167780858.3687.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 15:19 -0800, David Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Tue, 02 Jan 2007 16:53:23 -0600
> 
> > OK, so lets get down to brass tacks and look at the API characteristics.
> > 
> > Some of the issues are:
> > 
> >      1. Should kmap() actually flush all the user spaces? 
> >      2. Do we need additional hints in to kmap/kunmap?
> > 
> > My initial thought on 1. is no, since by and large we use kmap on pages
> > that have come to use via an I/O path, so usually they've already had
> > the user caches made coherent, unless you want do do this via a hint.
> 
> Who did this cache flush?  The idea is to make flush_dcache_page()
> do nothing, and have all of the work be done via the kmap()/kunmap()
> sequence.

Erm ... for a device driver, if we're preparing to do I/O on the page
something must have made the user caches coherent ... that can't be
kmap, because the driver might elect to DMA on the page ... unless
another component of this API is going to be to make dma_map_... also
flush the user cache?

> The case you're speaking about isn't a fault path, so it's not
> like there will be a flush_cache_page() call somewhere either.

well ... currently the pages come down to fuse via get_user_pages()
which does have a flush_dcache_page() as part of its operation.

> > For 2. like I said, I coded this on parisc without hints (using the page
> > table information instead to deduce what type of access the page had
> > taken) but we could equally well have used hints.
> 
> There are two important attributes 1) most permissive page protection
> of the user mappings, essentially does anyone have a writable access
> to the page and 2) the access the kernel will make, read or write.
> 
> If the kernel is going to read, kmap() would need to flush any
> writable user mappings, that's all.

Agreed.

> If the kernel is going to write, all user mappings have to be
> purged completely so that the writes are visible.

Agreed.

> I'm going to coneniently remind you it's possible to avoid all of the
> cache flushes by using TLB mappings at kmap() time.  I think PARISC
> can even do this, to be honest.  What makes that scheme unusable on
> PARISC?

You mean to map congruently for the page using something like our
temporary cache alias scheme?  Yes ... it should be possible for the
short lived kmap_atomic() type maps ... it will be a bit harder for the
non-atomic longer lived maps ... but I think we're deprecating those.

James


