Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTL1Ey7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 23:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTL1Ey7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 23:54:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:8624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265206AbTL1Ey4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 23:54:56 -0500
Date: Sat, 27 Dec 2003 20:53:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
 <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
 <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > Basically: prove me wrong. People have tried before. They have failed. 
> > Maybe you'll succeed. I doubt it, but hey, I'm not stopping you.
> 
> For anyone taking you up on this I'd like to suggest two possible
> directions.
> 
> 1) Increasing PAGE_SIZE in the kernel.

Yes. This is something I actually want to do anyway for 2.7.x. Dan 
Phillips had some patches for this six months ago.

You have to be careful, since you have to be able to mmap "partial pages", 
which is what makes it less than trivial, but there are tons of reasons to 
want to do this, and cache coloring is actually very much a secondary 
concern.

> 2) Creating zones for the different colors.  Zones were not
>    implemented last time, this was tried.

Hey, I can tell you that you _will_ fail.

Zones are actually a wonderful example of the kinds of problems you get
into when you have pages of different types aka "colors". We've had
nothing but trouble trying to balance different zones against each other,
and those problems were in fact _the_ reason for 99% of all the VM
problems in 2.4.x.

Trying to use them for cache colors would be "interesting". 

Not to mention that it's impossible to coalesce pages across zones.

> Both of those should be minimal impact to the complexity
> of the current kernel. 

Minimal? I don't think so. Zones are basically impossible, and page size 
changes will hopefully happen during 2.7.x, but not due to page coloring.

> I don't know where we will wind up but the performance variation's
> caused by cache conflicts in today's applications are real, and easily
> measurable.  Giving the growing increase in performance difference
> between CPUs and memory Amdahl's Law shows this will only grow
> so I think this is worth looking at.

Absolutely wrong.

Why? Because the fact is, that as memory gets further and further away 
from CPU's, caches have gotten further and further away from being direct 
mapped. 

Cache coloring is already a very questionable win for four-way 
set-associative caches. I doubt you can even _see_ it for eight-way or 
higher associativity caches.

In other words: the pressures you mention clearly do exist, but they are 
all driving direct-mapped caches out of the market, and thus making page
coloring _less_ interesting rather than more.

		Linus
