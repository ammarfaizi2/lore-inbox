Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130015AbRBIWlO>; Fri, 9 Feb 2001 17:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRBIWkz>; Fri, 9 Feb 2001 17:40:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5900 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130015AbRBIWkp>; Fri, 9 Feb 2001 17:40:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [beta patch] SSE copy_page() / clear_page()
Date: 9 Feb 2001 14:40:20 -0800
Organization: Transmeta Corporation
Message-ID: <961rkk$fgm$1@penguin.transmeta.com>
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A846C84.109F1D7D@colorfullife.com>,
Manfred Spraul  <manfred@colorfullife.com> wrote:
>
>* use sse for normal memcopy. Then main advantage of sse over mmx is
>that only the clobbered registers must be saved, not the full fpu state.
>
>* verify that the code doesn't break SSE enabled apps.
>I checked a sse enabled mp3 encoder and Mesa.

Ehh..  Did you try this with pending FPU exceptions that have not yet
triggered?

I have this strong suspicion that your kernel will lock up in a bad way
of you have somebody do something like divide by zero without actually
touching a single FP instruction after the divide (so that the error has
happened, but has not yet been raised as an exception). 

And when it hits your SSE copy routines with the pending error, it will
likely loop forever on taking the fault in kernel space. 

Basically, kernel use of MMX and SSE are a lot harder to get right than
many people seem to realize.  Why do you think I threw out all the
patches that tried to do this?

And no, the bug won't show up in any normal testing.  You'll never know
about it until somebody malicious turns your machine into a doorstop. 

Finally, did you actually see any performance gain in any benchmarks?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
