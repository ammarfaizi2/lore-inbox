Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSG2HVx>; Mon, 29 Jul 2002 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSG2HVx>; Mon, 29 Jul 2002 03:21:53 -0400
Received: from dsl-213-023-043-226.arcor-ip.net ([213.23.43.226]:60817 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311749AbSG2HVw>;
	Mon, 29 Jul 2002 03:21:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 1/13] misc fixes
Date: Mon, 29 Jul 2002 09:26:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D439E09.3348E8D6@zip.com.au>
In-Reply-To: <3D439E09.3348E8D6@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Z4v0-0002io-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 July 2002 09:32, Andrew Morton wrote:
> We have some fairly serious locking contention problems with the reverse
> mapping's pte_chains.  Until we have a clear way out of that I believe
> that it is best to not merge code which has a lot of rmap dependency.
> 
> It is apparent that these problems will not be solved by tweaking -
> some redesign is needed.  In the 2.5 timeframe the only practical
> solution appears to be page table sharing, based on Daniel's February
> work.  Daniel and Dave McCracken are working that.

Sadly, it turns out that there are no possibilities for page table sharing 
when forking from bash.  It turns out there are only about 200 pages being 
shared amonst three page tables (stack, text and .interp) and at least one 
page in each of these gets written during the exec, so all are unshared and 
hence there is no reduction in the number of pte chains that have to be 
created.  For forking from a larger parent, page table sharing has a 
measurable benefit, but not from these little guys.

But there is something massively wrong with this whole picture.  Your kickass 
4 way is managing to set up and tear down only one pte chain node per 
microsecond, if I'm reading your benchmark results correctly.  That's really 
horrible.  I think we need to revisit the locking.

The idea I'm playing with now is to address an array of locks based on 
something like:

	spin_lock(pte_chain_locks + ((page->index >> 4) & 0xff));

so that 16 consecutive filemap pages use the same lock and there is a limited 
total number of locks to keep cache pressure down.  Since we are creating the 
vast majority of the pte chain nodes while walking across page tables, this 
should give nice locality.

For this to work, anon pages will need to have something in page->index.  
This isn't too much of a challenge.  A reasonable value to put in there is 
the creator's virtual address, shifted right, and perhaps mangled a little to 
reduce contention.

We can also look at batching the pte chain node creation by preallocating 16 
nodes, taking the lock, and walking through the 16 nodes filling in the 
pointers.  If the page index changes to a different lock we drop the one we 
have and acquire the new one.

-- 
Daniel
