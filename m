Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUCMSHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbUCMSHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:07:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54025
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263149AbUCMSHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:07:36 -0500
Date: Sat, 13 Mar 2004 19:08:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
Message-ID: <20040313180818.GM30940@dualathlon.random>
References: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0403131739270.3628-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403131739270.3628-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 05:41:37PM +0000, Hugh Dickins wrote:
> On Sat, 13 Mar 2004, Rik van Riel wrote:
> > 
> > No, Linus is right.
> > 
> > If a child process uses mremap(), it stands to reason that
> > it's about to use those pages for something.
> > 
> > Think of it as taking the COW faults early, because chances
> > are you'd be taking them anyway, just a little bit later...
> 
> Makes perfect sense in the read-write case.  The read-only
> case is less satisfactory, but those will be even rarer.

overall it's not obvious to me that those will be even rarer.  see the
last email about kde-like usages to share data like-threads but with
memory protection, those won't write to the data. I mean, it maybe the
way to go, but I think we should get some ok from the major linux
projects that we're not going to invalidate their smart optimizations
first, and we should get this "misfeature" documented somehow.

I've to admit the simplicity is appealing, but besides its
coding-simplicity in practice I believe the only other appealing thing
will be the fact it's not exploitable by people doing a flood of
vma_splits, to solve that with anon_vma I'd need a prio tree on top of
every anon_vma, that means even more memory wased both in the anon_vma
and vma, though pratically a prio_tree there wouldn't be necessary. The
anonmm solves the complexity issue using find_vma, so sharing the rbtree
which already works. that's probably the part I find most appealing of
anonmm. One can still exploit the complexity with anonmm too, but not
from the same address space, so it's easier to limit with ulimit -u. I'm
really not sure what's best, which is not good since I hoped to get
anon_vma implementation working on Monday evening (heck it was already
swapping fine my test app despite the huge vma_split/PageDirect bug that you
noticed that probably caused `ps` to oops, I bet `ps` is doing a
vma_split ;) but I now returned wondering about the design issues instead.
