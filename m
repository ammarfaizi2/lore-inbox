Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTHWBJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTHWBJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:09:46 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:7429 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261263AbTHWBJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:09:45 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030822154100.06314c8e.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave> 
	<20030822154100.06314c8e.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Aug 2003 20:09:30 -0500
Message-Id: <1061600974.2090.809.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-22 at 17:41, David S. Miller wrote:
> I think on parisc you are trying to avoid the write() case
> of the cache flush for non-shared mmap()s, and sorry you
> really can't do this, again this is:
> 
> 	When a write() system call occurs, the kernel "class" is writing to
> 	the page so all user mappings (shared or not!) need to be flushed
> 	out.
> 
> If your flush_dcache_page() is not doing this, it's no wonder
> the test case fails for you.

Yes, that's precisely what we're trying to do.  Our problem is that we
have to issue the flush to all the aliased addresses (one cache line at
a time) which is phenomenally expensive.

What we were hoping is that we could rely on this little property of
mmap:

       MAP_PRIVATE
                  Create a private copy-on-write mapping.  Stores
                  to the region do not affect the original  file.
                  It  is  unspecified whether changes made to the
                  file after the mmap call  are  visible  in  the
                  mapped region.

To avoid having to flush the non-shared mappings (basically on parisc if
you write to a file backing a MAP_PRIVATE mapping then we don't
guarantee you see the update).

I suppose if we had a way of telling if any of the i_mmap list members
were really MAP_SHARED semantics mappings, then we could alter our
flush_dcache_page() implementation to work.

James


