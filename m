Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTHWXLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbTHWXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 19:11:41 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:20487 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263432AbTHWXL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 19:11:28 -0400
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
	tst-mmap-eofsync in glibc on parisc)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>, drepper@redhat.com
In-Reply-To: <20030823155312.63f996f6.davem@redhat.com>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave>
	<20030822154100.06314c8e.davem@redhat.com>
	<1061600974.2090.809.camel@mulgrave>
	<20030823144330.5ddab065.davem@redhat.com>
	<1061677283.1992.471.camel@mulgrave> 
	<20030823155312.63f996f6.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Aug 2003 18:11:16 -0500
Message-Id: <1061680279.1785.534.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 17:53, David S. Miller wrote:
> BTW, what gains to you really get from this optimization?
> 
> How often do writes happen to files while private mappings
> to it exist? :-)  This is one of the reasons I think this
> discussion is a bit silly.
> 
> What specific cases does your optimization help, and how common is it?
> Show us some numbers.

Not having to flush the private mappings is a huge optimisation.  Our
current flush_dcache_page implementation allows us only to flush a
single page and get all the aliased caches updated because we carefully
align MAP_SHARED areas (by supplying our own arch_get_unmapped_area()).

However, the alignment constraint is 4MB to get this property of the
virtually aliased caches, so we can't afford to align all mappings like
this (for our 32 bit userspace, anyway).

If we were to have to flush the private i_mmap list, we'd have to do a
page flush for *every* entry in the list (that's 256 instructions per
page at a cache width of 16 bytes).  This would be a horrific overhead.

using the VM_MAYSHARE to carry the read only shared mapping semantics
indication still allows us to align correctly, but the only additional
overhead we incur is to walk the i_mmap list to find VM_MAYSHARE
mappings as well as i_mmap_shared.  Since we can key of VM_MAYSHARE to
do the alignment, we still only need flush the first one we come to.

This all works as long as we can agree there are no pathological mmap
cases that force us to flush *all* the i_mmap mappings...which is what I
think the discussion has come down to.

James


