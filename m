Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTE2PxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTE2PxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:53:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:43017 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262321AbTE2PxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:53:14 -0400
Date: Thu, 29 May 2003 18:06:04 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Willy Tarreau <willy@w.ods.org>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529160604.GA4985@pcw.home.local>
References: <3ED2DE86.2070406@storadinc.com> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local> <200305291607.33211.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291607.33211.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:45:26PM +0200, Marc-Christian Petersen wrote:
> > machine with such a configuration. However, with stock kernel, I admit that
> > during the 2 minutes it takes to write the 2G file, I see the mouse stick
> > two or three times during about 1 second, which is quite acceptable IMHO.
> WRONG. A mouse stick is not acceptable in _any_ way. Other OS' can handle this 
Excuse me, Marc, I didn't mean it was normally acceptable, but quite acceptable
compared to what other people report.

> > Opening an xterm may take 10s to get to the prompt (more annoying). Same to
> > launch 'ps'.
> ACK!

The problem is specifically due to the cache, and only related to I/O but not
to other subsystems : if I start 50 xterms during that write, they take the
same time to respond as when there's only one. And they all respond
simultaneously, showing that they were all waiting for the files to be read
from the disk. But I cannot hang anything which doesn't need disk access.
Perhaps some people have their X server swap !

> The pauses/stops occurs no matter of what WindowManager (KDE2/3, WindowMaker, 
> fvwm, gnome etc. foobar). The point why you are not seeing such things with 
> -aa is his Lowlatency Elevator and lowlatency-fixes and some important fixes 
> which are not in stock kernel yet.

Do you agree that if the WM does no disk access and the mouse/keyboard freezes,
it means that X and/or the WM swap ? And if it's not the case, then it's related
to something else, and I don't see how playing with elevators can help!

> I reproduced mouse sticks and keyboard does not accept anything problems for 
> $seconds with _every_ kernel which is based on 2.4.19/2.4.20/2.4.21*. This 
> also includes -AA (well, not that braindead bad like mainline did before the 
> fix) but this is because of lowlat elevator from Andrea. And as I told 
> yesterday (or 2 days ago? dunno) lowlat elevator drops throughput (Andrea, it 
> _does_ ;).

I also confirm it does ; it takes 122 seconds to write this file in -rc6, and
142 seconds in -aa. But I don't think that desktop people would notice anyway.

> It's not just only mouse hangs (as I've reported tons of times) but also 
> keyboard does not accept any input (delay varies between 1 to 15 seconds) and 
> this also applies if you don't run X at all.

in fact, we don't know if the keyboard doesn't accept inputs or if the process
bound to the TTY is stuck ! If Alt-SysRq replies immediately, the problem is on
the user process side.

> - Start a screen session, not running X at all.
> - Trash your HD with tons of writes.
> - Press Ctrl-A-C for a new screen session.
> 
> You will see, it takes as long as, you wrote above, with starting up an Xterm 
> or calling ps. It does _not_ happen with 2.4.18!

I think that for this, screen will need to allocate some memory, which may take
some time under these conditions. I don't have screen right here, so I won't
try it, but I suspect that a program which uses pre-allocated memory will have
no problem at all.

> > So, could the people who report long hangs retry with swap disabled ?
> It's somewhat better but not acceptable.

OK

> > Can we limit the amount of memory consummed by the cache during such a
> > write ?
> I ask for such a feature since years ;)

another solution would be to be able to specify that a process could use
pre-allocated memory.

Cheers,
Willy

