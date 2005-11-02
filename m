Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVKBQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVKBQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVKBQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:34:27 -0500
Received: from gold.veritas.com ([143.127.12.110]:15440 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965110AbVKBQe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:34:26 -0500
Date: Wed, 2 Nov 2005 16:33:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: bad page state under possibly oom situation
In-Reply-To: <20051102143502.GE6137@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
References: <20051102143502.GE6137@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 16:34:26.0120 (UTC) FILETIME=[49E7A480:01C5DFCB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Dipankar Sarma wrote:
> We have discussed this in private previously and I had mentioned
> that I see this introduced between 2.6.9-rc1 and 2.6.9-rc2. After
> spending some time doing other things, I went back to take a
> look at this again and thought I would share this with a wider
> audience. The basic problem is that while running the LTP rename14
> test with a tmpfs /tmp, I see this -
> 
> Bad page state at prep_new_page (in process 'rename14', page ffff810008002aa8)
> flags:0x4000000000000090 mapping:0000000000000000 mapcount:0 count:0
> Backtrace:
> 
> Call Trace:<ffffffff80150388>{bad_page+115} <ffffffff80150bb1>{buffered_rmqueue+438}
>        <ffffffff80150da8>{__alloc_pages+251} <ffffffff8022fb10>{_atomic_dec_and_lock+24}
>        <ffffffff801535b3>{cache_alloc_refill+581} <ffffffff8015384f>{kmem_cache_alloc+44}
>        <ffffffff8017cd55>{d_alloc+33} <ffffffff8017507e>{__lookup_hash+206}
>        <ffffffff80176f4e>{sys_rename+245} <ffffffff8010e636>{system_call+126}
> 
> Trying to fix it up, but a reboot is needed

(I don't know that it makes any difference, but was this particular report
from 2.6.9-rc2 or from 2.6.14 or from something else?  In both 2.6.9 and
2.6.14, flags 0x90 mean PG_slab|PG_dirty.)

> Recently, I tested this with 2.6.14 and it worked. I then tried
> setting rcupdate.maxbatch=10 as it was before 2.6.14 and the bad
> page state problem happened again. Looks like it happens only under
> memory pressure and likely have something to do with slab.
> I am wondering if that rings a bell with anyone. Manfred ?

Slab and RCU and 2.6.9-rc2 do rather point an accusing finger at my
SLAB_DESTROY_BY_RCU, which went in for the anon_vma cache in that -rc.

I did look back at that when we discussed your Bad page state before,
and didn't find anything wrong.  But now you're reproducing it again,
it would be good to rule it in or out.

Could you run the rename14 test on whatever kernel suits you, but
built with mm/rmap.c omitting the SLAB_DESTROY_BY_RCU flag to
kmem_cache_create?  There's then a tiny chance that rmap will try
to access a freed anon_vma struct, I'm not sure how that would
behave offhand; but that chance should be a lot tinier than what
you're finding quite easy to reproduce.

If you don't get the Bad page state with that kernel, then it'll
be worth scrutinizing the SLAB_DESTROY_BY_RCU path in mm/slab.c.

Hugh
