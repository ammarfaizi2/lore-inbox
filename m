Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCUVxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 16:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUCUVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 16:53:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:25743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbUCUVxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 16:53:53 -0500
Date: Sun, 21 Mar 2004 13:53:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <1079902670.17681.324.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
References: <20040320133025.GH9009@dualathlon.random>  <20040320144022.GC2045@holomorphy.com>
  <20040320150621.GO9009@dualathlon.random>  <20040320121345.2a80e6a0.akpm@osdl.org>
  <20040320205053.GJ2045@holomorphy.com>  <20040320222639.K6726@flint.arm.linux.org.uk>
  <20040320224500.GP2045@holomorphy.com>  <1079901914.17681.317.camel@imladris.demon.co.uk>
  <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2004, David Woodhouse wrote:
>
> On Sun, 2004-03-21 at 20:49 +0000, Christoph Hellwig wrote:
> > And what exactly is a PFN without associated struct page supposed to mean?
> 
> It's something you can put into a PTE, and that's about it. Which unless
> I'm misunderstanding ALSA/rmk's requirements, should be enough.

It would really be wrong to have nopage() return a pte. The thing is, the 
VM really works on "struct page", all over the map. It does things like 
"page_cache_release()" on the page if the file-backed VMA has been 
truncated, and it just knows that the return value from "nopage()" has 
_structure_. 

Some architectures have per-page flags for things like "this page may need 
to have icache flushed from it" etc.

So I really put my veto on "nopage()" returning a PFN. That's just wrong, 
wrong, wrong. It returns a "struct page" pointer, and it has lots of 
reasons for that.

And none of the reasons for _not_ doing it are valid, since such a user 
can just pre-populate the page tables anyway.

So don't go there.

		Linus
