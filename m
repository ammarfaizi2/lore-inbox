Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTIQUVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTIQUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:21:04 -0400
Received: from ns.suse.de ([195.135.220.2]:4541 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261172AbTIQUVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:21:01 -0400
Date: Wed, 17 Sep 2003 22:21:00 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030917202100.GC4723@wotan.suse.de>
References: <3F67E8D4.6010707@cyberone.com.au> <Pine.LNX.4.44.0309171251070.2523-100000@laptop.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309171251070.2523-100000@laptop.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 12:53:59PM -0700, Linus Torvalds wrote:
> 
> On Wed, 17 Sep 2003, Nick Piggin wrote:
> > 
> > What is intriguing to me is the "Its only a 2% slowdown of the page
> > fault for every cpu other than K[78] for this single workaround. There
> > is no point to conditional compilation" attitude some people have.
> 
> I wouldn't worry about performance as much as correctness. I'm a lot more
> worried about the notion of taking recursive pagefaults than about 2%.

I carefully designed it to never recurse more than once. The original
version (before I posted it) had some corner cases that violated this, but 
the latest one is IMHO bulletproof in this regard.

Logic is: 

when the fault came from user space as seen in CS it is ok to fault again. 

when the fault came from kernel space we must always check the exception
table first. The __get_user is is_prefetch has an exception table entry
and will be catched by this.
[This is why I changed the SIGBUS path slightly - it previously did 
not follow this sequence]

Also when the fault address is equal EIP we don't check. This avoids
a recursion when the kernel jumps to zero. When this is not true the
instruction is guaranteed to be mapped, because an unmapped instruction
will always cause an page fault on EIP first.

About the only chance of doing multiple recursions would be another CPU
corrupting the kernel page table in parallel while the fault happens, 
but I don't see any chance to handle this properly.

-Andi

