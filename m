Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSI0Qkz>; Fri, 27 Sep 2002 12:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSI0Qkz>; Fri, 27 Sep 2002 12:40:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261424AbSI0Qky>; Fri, 27 Sep 2002 12:40:54 -0400
Date: Fri, 27 Sep 2002 09:47:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271836540.15550-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209270940380.2013-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Ingo Molnar wrote:
> 
> the futex code needs to 'get to the physical page', 'hash the futex queue'
> and 'hash the vcache entry' atomically.

I really don't think it needs to.

It really needs to do
 - hash the vcache entry _first_
 - not care about the rest

Once it hashes the vcache entry, we already know that all future COW's 
will tell us about themselves, and since out callback will serialize them 
with the futex lock, we're now done.

That's kind of the whole point of the vcache - it's the "race avoidance"  
thing.

And the vcache doesn't need to know what the physical page was: it only 
needs the address and the VM, which we have a priori. So we _can_ do all 
of this first.

You may want to do something clever to avoid taking the vcache lock in the 
COW path unless there is real reason to believe that you have to, but as 
far as I can tell, you can do that by simply adding a memory barrier to 
the end of the "insert vcache entry" thing.

Because once you do that, and you make sure that the COW thing does the 
vcache callback _after_ changing the page tables, the COW code can 

 - do the hash (which is invariant and has no races, since it depends 
   solely on the virtual address and the VM)
 - check if the hash queue is empty
 - only if the hash queue is non-empty does the COW code need to get the 
   vcache lock (and obviously it needs to re-load the hash entry from the 
   queue after it got the lock, but the hash is still valid)

And the COW case is the "hard" one. The swapper one is simple, just 
handled by gatting the page table spinlock in get_user_pages() (which we 
must already be doing, or we'd already be screwed).

Maybe I'm missing something, but the locking really doesn't look all that 
problematic if we just do things in the obvious order..

		Linus

