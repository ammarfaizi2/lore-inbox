Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264261AbSIVPVw>; Sun, 22 Sep 2002 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264263AbSIVPVw>; Sun, 22 Sep 2002 11:21:52 -0400
Received: from [195.223.140.120] ([195.223.140.120]:57392 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264261AbSIVPVv>; Sun, 22 Sep 2002 11:21:51 -0400
Date: Sun, 22 Sep 2002 17:27:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Cort Dougan <cort@fsmlabs.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020922152720.GV1345@dualathlon.random>
References: <20020922003448.GU1345@dualathlon.random> <Pine.LNX.4.44.0209221157030.19753-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209221157030.19753-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 12:02:10PM +0200, Ingo Molnar wrote:
> 
> On Sun, 22 Sep 2002, Andrea Arcangeli wrote:
> 
> > Nevertheless the current get_pid is very bad when the tasklist grows and
> > the pid space is reduced, [...]
> 
> > It may not be the best for a 1million pid case, but certainly it is a
> > must have for 2.4 and I think it could be ok for 2.5 too. It is been
> > submitted for 2.5 a number of times, I quote below the 2.4 version just
> > so you know what I'm talking about exactly [...]
> 
> Andrea, the new PID allocator (and new pidhash) went into 2.5.37, there's
> no get_pid() anymore. Do we agree that the runtime-bitmap hack^H^H^H^patch
> is now moot for 2.5?

I wouldn't call it an hack, it is just a less advanced version of what
you did in 2.5, if that is an hack how do you call the 2.4 and 2.2 code?
You've the bitmap array too and you use the bitmap to allocate the pid.
The big difference is that the 2.4 patch isn't capable of using the
bitmap in a synchronized and uptodate manner, so it has to rebuild the
bitmap at every getpid, and it misses all the infrastructure you added to
avoid walking the tasklist in getpid and to dynamically allocate new
maps. That means exit() (and various not performance critical syscalls)
will be a bit slower in 2.5, but it should payoff for getpid that
doesn't need to walk the tasklist anymore, so I certainly agree the
patch I posted is useless for the latest 2.5.38. One nice bit of 2.5 is
that the test and set bit on the global bitmask fixes the race with two
tasks taking the same pid quite naturally, it wasn't fixable that way in
the 2.4 patch because the bitmap is local to the task and rebuild at
each getpid.

Andrea
