Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTCFHek>; Thu, 6 Mar 2003 02:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbTCFHek>; Thu, 6 Mar 2003 02:34:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:18142 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267871AbTCFHej>;
	Thu, 6 Mar 2003 02:34:39 -0500
Date: Wed, 5 Mar 2003 23:45:53 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rml@tech9.net, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030305234553.715f975e.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
References: <20030228202555.4391bf87.akpm@digeo.com>
	<Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 07:45:05.0674 (UTC) FILETIME=[4DAF2EA0:01C2E3B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> 
> On Fri, 28 Feb 2003, Andrew Morton wrote:
> > > 
> > > Andrew, if you drop this patch, your X desktop usability drops?
> > 
> > hm, you're right.  It's still really bad.  I forgot that I was using distcc.
> > 
> > And I also forgot that tbench starves everything else only on CONFIG_SMP=n.
> > That problem remains with us as well.
> 
> Andrew, I always thought that the scheduler interactivity was bogus, since
> it didn't give any bonus to processes that _help_ interactive users
> (notably the X server, but it could be other things).

The current interactivity booster heuristic does appear to work very well - I
did an A/B comparison with 2.4.x a while back, and 2.5 is distinctly better.

But it is a heuristic, and it will inevitably make mistakes.  The problem
which I am observing is that the cost of those mistakes is very high.

I believe that we should recognise that no heuristic will be 100% accurate,
and that we should seek to minimise the impact of those 0.1%-of-the time
mistakes which it will make.  Perhaps by just dropping the max timeslice??

Let me redescribe the problem:

- Dual 850MHz PIII, 900M of RAM.
- Start a `make -j3 vmlinux', everything in pagecache
- Start using X applications.  Moving a window about is the usual trigger.

Everything goes happily for a while, and then blam.  Windows get stuck for
0.5-1.0 seconds, the mouse pointer gets so laggy that it is uncontrollable,
etc.  The fix is to put your hands in your pockets for 5-10 seconds and wait
for the scheduler to notice that the X server is idle.

Interestingly, this does not happen if the background load is a bunch of
busywaits.  It seems to need the fork&exit load of a compilation to trigger.

Robert was able to reproduce this, and noticed that the scheduler had niced
the X server down as far as it would go.

I'm a pretty pathological case, because I was driving two 1600x1200x24
displays with a crufty old AGP voodoo3 and a $2 PCI nvidia.  Am now using a
presumably less crufty radeon and the problem persists.

But last time I tested Ingo's interactivity patch things were a lot better. 
I shall retest his latest now.

