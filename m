Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280832AbRKBU6d>; Fri, 2 Nov 2001 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKBU6P>; Fri, 2 Nov 2001 15:58:15 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:31129 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280831AbRKBU5z>; Fri, 2 Nov 2001 15:57:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Fri, 2 Nov 2001 21:58:53 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <20011102181758Z16039-4784+420@humbolt.nl.linux.org> <200111022027.fA2KRwe20006@penguin.transmeta.com>
In-Reply-To: <200111022027.fA2KRwe20006@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Ben Smith <ben@google.com>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>
Message-Id: <20011102205746Z16039-4784+457@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 2, 2001 09:27 pm, Linus Torvalds wrote:
> In article <20011102181758Z16039-4784+420@humbolt.nl.linux.org>,
> Daniel Phillips  <phillips@bonn-fries.net> wrote:
> >
> >It's hard to see how that could be wrong.  Plus, this test program does 
> >run under 2.4.9, it just uses way too much CPU on that kernel.  So I'd say 
> >mm bug.
> 
> So how much memory is mlocked?

I'm not sure exactly, I didn't run the test.  I *think* it's just over 50% of 
physical memory.

> The locked memory will stay in the inactive list (it won't even ever be
> activated, because we don't bother even scanning the mapped locked
> regions), and the inactive list fills up with pages that are completely
> worthless. 

Yes, it does various things on various vms.  On 2.4.9 it stays on the 
inactive list until free memory gets down to rock bottom, then most of it 
moves to the active list and the system reaches a steady state where it can 
operate, though with kswapd grabbing 99% CPU (two processor system), but the 
test does complete.  On the current kernel the it dies.

> And the kernel will decide that because most of the unfreeable pages are
> mapped, it needs to do VM scanning, which obviously doesn't help.
> 
> Why _does_ this thing do mlock, anyway? What's the point? And how much
> does it try to lock?

It's how the google database engine works, and keeps latency down, by mapping 
big database files into memory.  I didn't get more information than that on 
the application.

> If root wants to shoot himself in the head by mlocking all of memory,
> that's not a VM problem, that's a stupid administrator problem.

In the tests I did, it was about 1 gig out of 2.  I'm not sure how much 
memory is mlocked in the 3.5 Gig test the one that's failing, but it's 
certainly not anything like all of memory.  Really, we should be able to 
mlock 90%+ of memory without falling over.

--
Daniel

