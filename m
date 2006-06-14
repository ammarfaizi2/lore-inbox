Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWFNFyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWFNFyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWFNFyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:54:09 -0400
Received: from gw.goop.org ([64.81.55.164]:12729 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964892AbWFNFyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:54:08 -0400
Message-ID: <448FA476.8000705@goop.org>
Date: Tue, 13 Jun 2006 22:53:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Catalin Marinas <catalin.marinas@gmail.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
References: <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com> <20060612192227.GA5497@elte.hu> <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI> <20060613072646.GA17978@elte.hu> <b0943d9e0606130349s24614bbcia6a650342437d3d1@mail.gmail.com> <20060614040707.GA7503@elte.hu>
In-Reply-To: <20060614040707.GA7503@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> For a GC a false negative is no big problem - it will reduce the 
> efficiency of the GC a bit, but that's all. For leak detection, if we 
> happen to have a persistent false pointer in .data (or any other 
> persistently allocated memory), it may prevent the detection of a leak 
> permanently - at least for that bootup. Statistically it could still be 
> found on other systems, but it would be better to have a design that 
> will eventually lead to having no false negatives.
>
> But it's not just about the amount of false negatives, but also about 
> the overhead of scanning. You are concentrated on embedded systems with 
> small RAM - but most of the testers will be running this with at last 
> 1GB of RAM - which is _alot_ of memory to scan.
>   
It seems to me that most types with any pointers are fairly 
pointer-dense.  There's not much point in trying to skip a couple of 
non-pointers nested among a dozen others; once you've worn the cost of 
pulling in the cache line there's not much else to worry about.  The 
most useful thing is to distinguish between completely pointerless 
allocations and allocations which have pointers.  Pointerless 
allocations are generally just data (strings, numbers, user data), and 
so are a waste of effort to scan, and possibly full of false pointers.  
In the kernel, you could probably do it by making it a property of 
slabs, assume all kmalloc allocations are pointerful (perhaps add 
GFP_POINTERLESS), and make sure all user-data pages are considered 
pointerless.

False pointers in kernel allocations can be avoided in a few ways.  The 
first, obviously, is the make sure all memory is initialized to a known 
non-pointer value.  The second is to ignore pointers which don't point 
near the start of an allocated region (possibly unsafe in the kernel, 
depending on the definition of "near").  You can get more sophisticated 
from there; the Boehm GC keeps tracks of things which look like pointers 
but turn out not to be (they don't point to allocated memory); it marks 
that memory as being unusable, so that the false pointer won't get 
mistaken for one later on, with the obvious risk that lots of false 
pointers can render large parts of your heap address space unusable.

In general, false pointers aren't a huge problem.  They'll generally 
lead to a bounded number of allocations being unreported as leaks; its 
highly unlikely that a large heap graph will remain hidden from a leak 
checker forever; espectially since kernel pointers are fairly unlike 
other kinds of data (large enough to not be aliased to most normal 
integer values, don't look like strings, and there are no FP numbers in 
the kernel).

> (But, if it's not possible to implement it in a sane manner then that's 
> not an issue either - it's rather the false positives that must be 
> avoided.)
>   

There's some risk of false positives.  You can imagine cases where the 
last reference to a block is transformed into a bus address, and in 
effect a piece of hardware holds it.  You don't get to know about the 
pointer until the hardware gives it back.  You might want a GFP_ROOT 
flag (or whatever), to mark a block as being always referenced in order 
to suppress these cases.

> there are a couple of possibilities.
>
> If the ID is string based then you dont even have to touch containr_of() 
> calls - just generate the typename string via the "#y" stringification 
> preprocessor directive, where 'y' is the second parameter of 
> container_of().
> [...]
> it needs some thought, but this way it's quite possible to build-time 
> map types to IDs.
>   

This seems pretty over-engineered.  I wouldn't go this far unless you're 
actually seeing performance/correctness problems, and a simple 
with/without pointers flag isn't enough.  It also doesn't address the 
most troublesome source of false pointers: stacks.  There is all sorts 
of junk lying around on stacks, and you can have an old dead pointer 
sitting there pinning old dead memory for a long time.

    J
