Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSGOSHQ>; Mon, 15 Jul 2002 14:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSGOSHN>; Mon, 15 Jul 2002 14:07:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317567AbSGOSHM>;
	Mon, 15 Jul 2002 14:07:12 -0400
Message-ID: <3D330F89.35299DC7@zip.com.au>
Date: Mon, 15 Jul 2002 11:08:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Lincoln Dale <ltd@cisco.com>, Benjamin LaHaise <bcrl@redhat.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
References: <3D2CFF48.9EFF9C59@zip.com.au> <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com> <20020715094915.GD34@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Jul 15, 2002 at 04:06:21PM +1000, Lincoln Dale wrote:
> > At 10:30 PM 14/07/2002 -0700, Andrew Morton wrote:
> > >Funny thing about your results is the presence of sched_yield(),
> > >especially in the copy-from-pagecache-only load.  That test should
> > >peg the CPU at 100% and definitely shouldn't be spending time in
> > >default_idle.  So who is calling sched_yield()?  I think it has to be
> > >your test app?
> > >
> > >Be aware that the sched_yield() behaviour in 2.5 has changed a lot
> > >wrt 2.4.  It has made StarOffice 5.2 completely unusable on a non-idle
> > >system, for a start.  (This is a SO problem and not a kernel problem,
> > >but it's a lesson).
> >
> > my test app uses pthreads (one thread per disk-worker) and
> > pthread_cond_wait in the master task to wait for all workers to finish.
> > i'll switch the app to use clone() and sys_futex instead.
> 
> unless you call pthread routines during the workload, pthreads cannot be
> the reason for a slowdown.

I didn't see the machine spending any time idle when I ran Lincoln's
test so I'm not sure what's going on there.  But the pthread thing
is surely the reason why the profiles are showing time in sched_yield().

What I *did* see was 2.5 spending too much time doing pointless work
in readahead (it's in cache already, stop doing that!).  And also
generic_file_llseek() bouncing i_sem around like a ping-pong ball.
Fixing those things up bought 10%.

> Also I would suggest Andrew to benchmark 2.4.19rc1aa2 against 2.5
> instead of plain rc1 just to be sure to compare apples to apples.
> (rc1aa2 should also be faster than pre8aa2)

Yes sorry, but I find testing -aa is a bit of a pain.  It's such a
big patch, I'd really need to start a new branch for it.

-
