Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbUKTCOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUKTCOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUKTCMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:12:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:62606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263022AbUKTCHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:07:09 -0500
Date: Fri, 19 Nov 2004 18:06:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <Pine.LNX.4.58.0411191757250.2222@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411191759490.2222@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <419E98E7.1080402@yahoo.com.au>
 <Pine.LNX.4.58.0411191726001.1719@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411191757250.2222@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Linus Torvalds wrote:
> 
> Not that I really see any overwhelming evidence of anybody ever really 
> caring, but it's nice to know that you have the option.

Btw, if you are going to look at doing this rss thing, you need to make 
sure that thread exit ends up adding its rss to _some_ remaining sibling. 

I guess that was obvious, but it's worth pointing out. That may actually
be the only case where we do _not_ have a nice SMP-safe access: we do have
a stable sibling (tsk->thread_leader), but we don't have any good
serialization _except_ for taking mmap_sem for writing. Which we currently
don't do: we take it for reading (and then we possibly upgrade it to a
write lock if we notice that there is a core-dump starting).

We can avoid this too by having a per-mm atomic rss "spill" counter. So 
exit_mm() would basically do:

	...
	tsk->mm = NULL;
	atomic_add(tsk->rss, &mm->rss_spill);
	...

and then the algorithm for getting rss would be:

	rss = atomic_read(mm->rss_spill);
	for_each_thread(..)
		rss += tsk->rss;

Or does anybody see any better approaches?

		Linus
