Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbTL0U5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTL0U5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:57:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:1246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264574AbTL0U5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:57:08 -0500
Date: Sat, 27 Dec 2003 12:56:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <2003Dec27.212103@a0.complang.tuwien.ac.at>
Message-ID: <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
 <2003Dec27.212103@a0.complang.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Anton Ertl wrote:
> 
> And you probably mean "repeatable every time".  Ok, then a random
> scheme has, by your definition, no pathological worst case.  I am not
> sure that this is a consolation when I happen upon one of its
> unpredictable and unrepeatable worst cases.

Those "unpredictable" cases are so exceedingly rare that they aren't worth
worrying about.

> The points are:
> 
> - repeatability
> - predictability
> - better average performance (you dispute that).

I absolutely dispute that.

And you should realize that I do not dispute it because the applications
themselves would run slower with cache coloring. Most applications don't
much care, they either fit in the cache, or the cache misses have random
enough access patterns that cache layout doesn't much matter.

The test code in question is an anomaly, and doesn't matter. It's exactly
the same kind of strange case that sometimes shows cache coloring making a
huge difference.

The real degradation comes in just the fact that cache coloring itself is
often expensive to implement and causes nasty side effects like bad memory 
allocation patterns, and nasty special cases that you have to worry about 
(ie special fallback code on non-colored pages when required).

That expense is both a run-time expense _and_ a conceptual one (a
conceptual expense is somethign that complicates the internal workings of
the allocator so much that it becomes harder to think about and more
bugprone). So far nobody has shown a reasonable way to do it without
either of the two.

> Anyway, back to the performance effects of page colouring: Yes, there
> are cases where it is not beneficial, and the huge-2^n-stride cases in
> examples like the one above are one of them, but I don't think that
> this is the kind of "real life" application that you mention
> elsewhere, or is it?

The "real life" application is something like running a normal server or
desktop, and having the cache coloring code _itself_ be the performance
problem.

It's not that "apache" minds very much. Or "mozilla". They simply don't 
care. The problem is the algorithm itself.

> >Also, the work has been done to test things, and cache coloring definitely
> >makes performance _worse_. It does so exactly because it artifically
> >limits your page choices, causing problems at multiple levels (not just at
> >the cache, like this example, but also in page allocators and freeing).
> 
> Sorry, I am not aware of the work you are referring to.  Where can I
> read more about it?  Are you sure that these are fundamental problems
> and not just artifacts of particular implementations?

Hey, there have been at least four different major cache coloring trials 
for the kernel over the years. This discussion has been going on since the 
early nineties. And _none_ of them have worked well in practice.

In other words, "artifacts of the particular implementation" is certainly 
right, but the point I have is that the only thing that _matters_ is 
implementation. You can argue about theory all you like, I won't care 
until you show me an implementation that works and is robustly better.

And it has to be better on average on _everything_ that Linux supports,
not just one particular braindamaged piece of hardware. I'm totally not
interested in something that makes performance on most machines go down,
if it then improves one or two braindead setups with direct-mapped caches.

Basically: prove me wrong. People have tried before. They have failed. 
Maybe you'll succeed. I doubt it, but hey, I'm not stopping you.

		Linus
