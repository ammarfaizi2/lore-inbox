Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289961AbSAPPQn>; Wed, 16 Jan 2002 10:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289967AbSAPPQd>; Wed, 16 Jan 2002 10:16:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22026 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289962AbSAPPQP>; Wed, 16 Jan 2002 10:16:15 -0500
Date: Wed, 16 Jan 2002 10:15:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C423CB9.7BB04345@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020116100231.28369B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Andrew Morton wrote:

> Bill Davidsen wrote:
> > 
> > Finally, I doubt that any of this will address my biggest problem with
> > Linux, which is that as memory gets cheap a program doing significant disk
> > writing can get buffers VERY full (perhaps a while CD worth) before the
> > kernel decides to do the write, at which point the system becomes
> > non-responsive for seconds at a time while the disk light comes on and
> > stays on.

> /proc/sys/vm/bdflush: Decreasing the kupdate interval from five
> seconds, decreasing the nfract and nfract_sync setting in there
> should smooth this out.  The -aa patches add start and stop
> levels for bdflush as well, which means that bdflush can be the
> one who blocks on IO rather than your process.  And it means that
> the request queue doesn't get 100% drained as soon as the writer
> hits nfract_sync.

Been there, done that. Makes it "less bad" if the right settings are
chosen. I will try -aa on 2.4.18-pre3 (or 4 if the patch is out), I've
been trying -ac this morning. Looking at the code, it doesn't look as if
the logic is what I want to see, no matter how tuned. last night I tried a
patch, and several of the "unued" elements in the bdflush were reused, but
I froze w/o any io for seconds, so I don't have it right.

What I want is a smooth increase in how mush is written as the dirty
buffers increase. Percentage of {anything} may be the wrong thing to use,
the problem is dirty buffers vs. disk write bandwidth, on a 2GB machine
it's a smaller percentage than 128M machine, but the absolute numbers seem
to be similar.
 
> All very interesting and it will be fun to play with when it
> *finally* gets merged.
> 
> But with the current elevator design, disk read latencies will
> still be painful.

There are a few patches around to change that. Note I didn't say "fix"
just change.

Finally, one of my goals is to be able to keep a large free page pool. I
have two apps which will suddenly need another 8MB or so, and if they have
to wait for disk they become unpleasant. With current memory prices I
don't mind "wasting" 256MB or so, if it means I get better response when I
want it. This is all part of tuning the system to application, I certainly
wouldn't use it on other machines.

Better doc of bdflush wouldn't be amiss, either. When/if it stops changing
I will clean up my notes from a stack of 3x5 cards to something useful and
make them available. If there's a doc giving what the bdflush values do
(in current kernels) and what happens when you change them, and what to
tune first if you have this problem, I haven't found it. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

