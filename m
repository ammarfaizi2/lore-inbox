Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTHWWVg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTHWWVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:21:36 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:57605 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263436AbTHWWVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:21:32 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030823144330.5ddab065.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave>
	<20030822154100.06314c8e.davem@redhat.com>
	<1061600974.2090.809.camel@mulgrave> 
	<20030823144330.5ddab065.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Aug 2003 17:21:21 -0500
Message-Id: <1061677283.1992.471.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 16:43, David S. Miller wrote:
> On 22 Aug 2003 20:09:30 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
> > What we were hoping is that we could rely on this little property of
> > mmap:
> > 
> >        MAP_PRIVATE
> >                   Create a private copy-on-write mapping.  Stores
> >                   to the region do not affect the original  file.
> >                   It  is  unspecified whether changes made to the
> >                   file after the mmap call  are  visible  in  the
> >                   mapped region.
> > 
> > To avoid having to flush the non-shared mappings (basically on parisc if
> > you write to a file backing a MAP_PRIVATE mapping then we don't
> > guarantee you see the update).
> > 
> > I suppose if we had a way of telling if any of the i_mmap list members
> > were really MAP_SHARED semantics mappings, then we could alter our
> > flush_dcache_page() implementation to work.
> 
> I thought about this very deeply last night and this morning.
> And what you're trying to optimize won't work.  Here is why.
> 
> If the first access to a MAP_PRIVATE mapping of a page is a read,
> we'll use the page-cache page.  This means that, with your
> optimization, during this time if another cpu write()`s into the
> page we'll lose the data update.
> 
> Sorry :(

Could you elaborate some more?  I agree that the MAP_PRIVATE mapping may
not see cpu1's write because of cache incoherencies (but that's what I
believe is covered by the `unspecified' bit of the MAP_PRIVATE
definition above).  MAP_PRIVATE is COW (i.e. the page is marked read
only while it's shared), so there can be no data to flush in the cache
for the page of the MAP_PRIVATE process...The only scenario I see where
we can get cache based data destruction is if two cache aliases both
contain dirty caches for the page (which can only happen for MAP_SHARED
RW, which we already have the correct semantics for...they're racing to
do a msync and the last one in wins).

James


