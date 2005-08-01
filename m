Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVHAUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVHAUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVHAUJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:09:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261211AbVHAUJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:09:54 -0400
Date: Mon, 1 Aug 2005 13:08:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508011250210.3341@g5.osdl.org>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
 <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
 <42EE0021.3010208@yahoo.com.au> <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Hugh Dickins wrote:
> 
> > Aside, that brings up an interesting question - why should readonly
> > mappings of writeable files (with VM_MAYWRITE set) disallow ptrace
> > write access while readonly mappings of readonly files not? Or am I
> > horribly confused?
> 
> Either you or I.  You'll have to spell that out to me in more detail,
> I don't see it that way.

We have always just done a COW if it's read-only - even if it's shared.

The point being that if a process mapped did a read-only mapping, and a 
tracer wants to modify memory, the tracer is always allowed to do so, but 
it's _not_ going to write anything back to the filesystem.  Writing 
something back to an executable just because the user happened to mmap it 
with MAP_SHARED (but read-only) _and_ the user had the right to write to 
that fd is _not_ ok.

So VM_MAYWRITE is totally immaterial. We _will_not_write_ (and must not do
so) to the backing store through ptrace unless it was literally a writable
mapping (in which case VM_WRITE will be set, and the page table should be
marked writable in the first case).

So we have two choices:

 - not allow the write at all in ptrace (which I think we did at some 
   point)

   This ends up being really inconvenient, and people seem to really 
   expect to be able to write to readonly areas in debuggers. And doign 
   "MAP_SHARED, PROT_READ" seems to be a common thing (Linux has supported 
   that pretty much since day #1 when mmap was supported - long before
   writable shared mappings were supported, Linux accepted MAP_SHARED +
   PROT_READ not just because we could, but because Unix apps do use it).

or

 - turn a shared read-only page into a private page on ptrace write

   This is what we've been doing. It's strange, and it _does_ change 
   semantics (it's not shared any more, so the debugger writing to it 
   means that now you don't see changes to that file by others), so it's 
   clearly not "correct" either, but it's certainly a million times better
   than writing out breakpoints to shared files..

At some point (for the longest time), when a debugger was used to modify a
read-only page, we also made it writable to the user, which was much
easier from a VM standpoint. Now we have this "maybe_mkwrite()" thing,
which is part of the reason for this particular problem.

Using the dirty flag for a "page is _really_ writable" is admittedly kind
of hacky, but it does have the advantage of working even when the -real-
write bit isn't set due to "maybe_mkwrite()". If it forces the s390 people 
to add some more hacks for their strange VM, so be it..

[ Btw, on a totally unrelated note: anybody who is a git user and looks 
  for when this maybe_mkwrite() thing happened, just doing

	git-whatchanged -p -Smaybe_mkwrite mm/memory.c

  in the bkcvs conversion pinpoints it immediately. Very useful git trick 
  in case you ever have that kind of question. ]

I added Martin Schwidefsky to the Cc: explicitly, so that he can ping 
whoever in the s390 team needs to figure out what the right thing is for 
s390 and the dirty bit semantic change. Thanks for pointing it out.

		Linus
