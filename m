Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268297AbTCFSMh>; Thu, 6 Mar 2003 13:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268304AbTCFSMh>; Thu, 6 Mar 2003 13:12:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268297AbTCFSMf>; Thu, 6 Mar 2003 13:12:35 -0500
Date: Thu, 6 Mar 2003 10:20:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061914250.16561-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303061016460.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> > Oh, well. I didn't actually even verify that UNIX domain sockets will
> > cause synchronous wakeups, so the patch may literally be doing nothing
> > at all. You can try that theory out by just removing the test for
> > "in_interrupt()".
> 
> you are not referring to the 'synchronous wakeups' as used by fs/pipe.c,
> right?

No, sorry. Bad choice of words.

The traditional "synchronous wakeups" as used by fs/pipe.c is a hint to 
the scheduler that the waker will go to sleep.

And no, that's not the hint I'm using at all. I'm only interested in 
"process-synchronous", since if the wakeup isn't process-synchronous then 
"current" doesn't make much sense to me.

> so i think your current patch should cover unix domain sockets just as
> well, they certain dont use IRQ-context wakeups.

Note that "in_interrupt()" will also trigger for callers that call from
bh-atomic regions as well as actual BH handlers. Which is correct - they 
are both "interrupt contexts" as far as most users should be concerned.

The unix domain case may well be bh-atomic, I haven't looked at the code. 
I'm pretty much certain that the TCP case _will_ be BH-atomic, even for 
loopback.

David?

		Linus

