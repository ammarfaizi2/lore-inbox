Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSJAS3n>; Tue, 1 Oct 2002 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJAS3n>; Tue, 1 Oct 2002 14:29:43 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:7325 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262172AbSJAS3m>;
	Tue, 1 Oct 2002 14:29:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 20:35:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200209291615.24158.l.allegrucci@tiscalinet.it> <E17wNeG-0005th-00@starship> <3D99E3C5.E0F99E9E@digeo.com>
In-Reply-To: <3D99E3C5.E0F99E9E@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wRrk-0005vp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 20:04, Andrew Morton wrote:
> I'm fairly happy with 2.5 page replacement.  It's simple, clean
> and very, very quick to build up a large pool of available memory
> for what ever's going on at the time.
> 
> Problem is, it's cruel.  People don't notice that we shaved 15 seconds
> off that three minute session of file bashing which they just did.
> But they do notice that when they later wiggle their mouse, it takes
> five seconds to pull the old stuff back in. 
> 
> The way I'd like to address that is with a "I know that's cool but I
> don't like it" policy override knob.  But finding a sensible way of
> doing that is taking some head-scratching.  Anything which says
> "unmap pages much later" is doomed to failure I suspect.  It will
> just increase latency when we really _do_ need to unmap, and will
> cause weird OOM failures.
> 
> So hm.  Still thinking.

That would be process RSS management you're talking about, which Rik
has bravely volunteered to tackle.  The object would be to respond to
-nice values as sanely as possible, so that a reasonable portion of
those pages touched by the mouse tend to stick around in memory under
all but the highest pressure loads.

Then there is the 'updatedb paged out my desktop in the middle of the
night', related but even harder because of the long timeframe.  To fix
this really well and not kill other, more critical loads requires some
kind of memory of what was paged out when so that when updatedb goes
away, something approximating the former working set pops back in.  A
little low hanging fruit can be gotten by just reading all of swap
back in when the load disappears, which will work fine when swap is
smaller than RAM and there isn't too much shared memory.

-- 
Daniel
