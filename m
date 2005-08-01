Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVHAVyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVHAVyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:52:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261305AbVHAVvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:51:48 -0400
Date: Mon, 1 Aug 2005 14:51:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.61.0508012153570.6323@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508011438450.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
 <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
 <42EE0021.3010208@yahoo.com.au> <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508011250210.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508012153570.6323@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Hugh Dickins wrote:
> > 
> > We have always just done a COW if it's read-only - even if it's shared.
> > 
> > The point being that if a process mapped did a read-only mapping, and a 
> > tracer wants to modify memory, the tracer is always allowed to do so, but 
> > it's _not_ going to write anything back to the filesystem.  Writing 
> > something back to an executable just because the user happened to mmap it 
> > with MAP_SHARED (but read-only) _and_ the user had the right to write to 
> > that fd is _not_ ok.
> 
> I'll need to think that through, but not right now.  It's a surprise
> to me, and it's likely to surprise the current kernel too.

Well, even if you did the write-back if VM_MAYWRITE is set, you'd still
have the case of having MAP_SHARED, PROT_READ _without_ VM_MAYWRITE being
set, and I'd expect that to actually be the common one (since you'd
normally use O_RDONLY to open a fd that you only want to map for reading).

And as mentioned, MAP_SHARED+PROT_READ does actually happen in real life.  
Just do a google search on "MAP_SHARED PROT_READ -PROT_WRITE" and you'll
get tons of hits. For good reason too - because MAP_PRIVATE isn't actually
coherent on several old UNIXes.

So you'd still have to convert such a case to a COW mapping, so it's not 
like you can avoid it.

Of course, if VM_MAYWRITE is not set, you could just convert it silently
to a MAP_PRIVATE at the VM level (that's literally what we used to do, 
back when we didn't support writable shared mappings at all, all those 
years ago), so at least now the COW behaviour would match the vma_flags.

> I'd prefer to say that if the executable was mapped shared from a writable fd,
> then the tracer will write back to it; but you're clearly against that.

Absolutely. I can just see somebody mapping an executable MAP_SHARED and
PROT_READ, and something as simple as doing a breakpoint while debugging
causing system-wide trouble.

I really don't think that's acceptable.

And I'm not making it up - add PROT_EXEC to the google search around, and 
watch it being done exactly that way. Several of the hits mention shared 
libraries too. 

I strongly suspect that almost all cases will be opened with O_RDONLY, but 
still..

		Linus
