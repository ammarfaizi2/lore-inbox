Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319630AbSH3Rg1>; Fri, 30 Aug 2002 13:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319631AbSH3Rg1>; Fri, 30 Aug 2002 13:36:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11016 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319630AbSH3Rg0>; Fri, 30 Aug 2002 13:36:26 -0400
Date: Fri, 30 Aug 2002 10:47:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <Pine.LNX.4.44.0208301916370.910-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208301038240.1307-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Ingo Molnar wrote:
> 
> hm, indeed, you are right - completions are the only safe method.
> 
> i'm starting to wonder whether it's possible at all (theoretically) to
> have a mutex design which has the current semaphore implementation's good
> fastpath properties, but could also be used on stack.

That's is my point. I don't think there is - although I suspect that many 
architectures could easily do it. For all I know, there might well be some 
tricks we could play on x86 with cmpxchg8b, for example.

But I simply think that our current "completion vs semaphore" split is a
pretty good one conceptually. They may _look_ like they are largely the
same operation, but they have pretty distinct behaviour both in what the
fast path is (ie "expected behaviour": semaphores expect to succeed,
completions expect to wait), and what the release criteria are (semaphores
do not guarantee that nobody looks at them after a down() has succeeded,
while completions do).

And one thing that tends to confirm my belief that "struct completion"  
actually makes sense as a separate thing from a semaphore has nothing to 
do with these implementation details. It's the much more conceptual one: a 
lot of the cases where we converted to completions are just a lot more 
_readable_ as completions.

Using a semaphore for much of it ("wait for the IO to complete" or "wait
for the thread to be set up") counted as a clever trick, but was a fairly
obscure clever trick. While the completion thing looks "obvious".

So even if the actual implementation of semaphores and completions were
100% the same, I would actually want to _keep_ this naming and conceptual
difference, simply because it just _looks_ cleaner, in my opinion.

		Linus

