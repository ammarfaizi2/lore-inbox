Return-Path: <linux-kernel-owner+w=401wt.eu-S932601AbXAGQJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbXAGQJi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAGQJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:09:38 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:54696 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932599AbXAGQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:09:37 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070103150912.GB25434@flint.arm.linux.org.uk>
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
	 <20070102.151906.21595863.davem@davemloft.net>
	 <1167780858.3687.13.camel@mulgrave.il.steeleye.com>
	 <20070102.162058.55482337.davem@davemloft.net>
	 <20070103141655.GA25434@flint.arm.linux.org.uk>
	 <1167836458.2789.6.camel@mulgrave.il.steeleye.com>
	 <20070103150912.GB25434@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 10:09:13 -0600
Message-Id: <1168186153.2792.80.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 15:09 +0000, Russell King wrote:
> On Wed, Jan 03, 2007 at 09:00:58AM -0600, James Bottomley wrote:
> > However, I was wondering if there might be a different way around this.
> > We can't really walk all the user mappings because of the locks, but
> > could we store the user flush hints in the page (or a related
> > structure)?  On parisc we don't care about the process id (called space
> > in our architecture) because we've turned off the pieces of the cache
> > that match on space id.  Thus, all we care about is flushing with the
> > physical address and virtual address (and only about 10 bits of this are
> > significant for matching).  We go to great lengths to ensure that every
> > mapping in user space all has the same 10 bits of virtual address, so if
> > we just new what they were we could flush the whole of the user spaces
> > for the page without having to walk any VMA lists.  Could arm do this as
> > well?
> 
> I don't think so.  The organisation of the VIVT caches in terms of
> how the set index and tag correspond with virtual addresses are hardly
> ever documented.  When they are, they don't appear to lend themselves
> to such an approach.  For example,  Xscale has:
> 
>  tag:       virtual address b31-10
>  set index: b9-5
> 
> and there's 32 ways per set.  So there's nothing to be gained from
> controlling the virtual address which individual mappings end up at
> in this case.

OK, so the bottom line we seem to have reached is that we can't manage
the user coherency in the DMA API.  Does this also mean you can't do it
for non-DMA cases (kmap_atomic would seem to be a likely problem)? in
which case the only coherency kmap would control would be kernel
coherency?

James


