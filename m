Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVKBTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVKBTyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVKBTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:54:13 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:13709 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965204AbVKBTyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:54:12 -0500
Date: Thu, 3 Nov 2005 01:18:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: bad page state under possibly oom situation
Message-ID: <20051102194800.GM6137@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051102143502.GE6137@in.ibm.com> <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 04:33:21PM +0000, Hugh Dickins wrote:
> On Wed, 2 Nov 2005, Dipankar Sarma wrote:
> > 
> > Bad page state at prep_new_page (in process 'rename14', page ffff810008002aa8)
> > flags:0x4000000000000090 mapping:0000000000000000 mapcount:0 count:0
> > Backtrace:
> > 
> 
> (I don't know that it makes any difference, but was this particular report
> from 2.6.9-rc2 or from 2.6.14 or from something else?  In both 2.6.9 and
> 2.6.14, flags 0x90 mean PG_slab|PG_dirty.)
> 
> > Recently, I tested this with 2.6.14 and it worked. I then tried
> > setting rcupdate.maxbatch=10 as it was before 2.6.14 and the bad
> > page state problem happened again. Looks like it happens only under
> > memory pressure and likely have something to do with slab.
> > I am wondering if that rings a bell with anyone. Manfred ?
> 
> 
> I did look back at that when we discussed your Bad page state before,
> and didn't find anything wrong.  But now you're reproducing it again,
> it would be good to rule it in or out.
> 
> Could you run the rename14 test on whatever kernel suits you, but
> built with mm/rmap.c omitting the SLAB_DESTROY_BY_RCU flag to
> kmem_cache_create?  There's then a tiny chance that rmap will try
> to access a freed anon_vma struct, I'm not sure how that would
> behave offhand; but that chance should be a lot tinier than what
> you're finding quite easy to reproduce.

I am really not comfortable with the SLAB_DESTROY_BY_RCU thing.
I am not familiar with rmap code, so I could be wrong but
it isn't clear to me why you are protecting only the slab
and not the anon_vma slab objects. How do you ensure that
the anon_vma objects don't get re-used ? If they do,
then how do you prevent freeing an in-use anon_vma ?
It seems that the critical sections are not clearly
identified here.

> 
> If you don't get the Bad page state with that kernel, then it'll
> be worth scrutinizing the SLAB_DESTROY_BY_RCU path in mm/slab.c.

I tried commenting out SLAB_DESTROY_BY_RCU for anon_vma caache,
but I still hit the problem. So, that may not be it. I guess I can
look at the bad page and see if I can extract some information
from there.

Thanks
Dipankar
