Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUCLQBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUCLQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:01:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25610
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262213AbUCLQAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:00:53 -0500
Date: Fri, 12 Mar 2004 17:01:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312160135.GX30940@dualathlon.random>
References: <20040312132436.GT30940@dualathlon.random> <Pine.LNX.4.44.0403121348070.4925-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121348070.4925-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:55:30PM +0000, Hugh Dickins wrote:
> On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> > On Fri, Mar 12, 2004 at 04:46:38AM -0800, William Lee Irwin III wrote:
> > > 
> > > The case where mremap() creates rmap_chains is so rare I never ever saw
> > > it happen in 6 months of regular practical use and testing. Their
> > > creation could be triggered only by remap_file_pages().
> > 
> > did you try specweb with apache? that's super heavy mremap as far as I
> > know (and it maybe using anon memory, and if not I certainly cannot
> > exclude other apps are using mremap on significant amounts of anymous
> > ram).
> 
> anonmm has no problem with most mremaps: the special case is for
> mremap MAYMOVE of anon vmas _inherited from parent_ (same page at
> different addresses in the different mms).  As I said before, it's
> quite conceivable that this case never arises outside our testing
> (but I'd be glad to be shown wrong, would make effort worthwhile).

the problem is that it _can_ arise, and fixing that is an huge mess
without using the pte_chains IMHO (no hope to use the vma->shared).

I also don't see how can you know if a vma is pointing all to "direct"
pages and in turn you can move it somewhere else without the pte_chains.
sure you can move all anon vmas freely after an execve, but after the
first fork (and in turn with cow pages going on) all mremaps will
non-trackable with anonmm, right? lots of server processes uses fork()
model for the childs, and they can run mremap inside the child of memory
malloced inside the child, and I don't think you can easily track if the
malloc happened inside the child or inside the father, though I may be
wrong on this.
