Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272480AbTHEHGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272483AbTHEHGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:06:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:19125 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272480AbTHEHGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:06:03 -0400
Message-Id: <5.2.1.1.2.20030805064637.01971ba8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 05 Aug 2003 09:10:14 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <200308050811.09590.kernel@kolivas.org>
References: <5.2.1.1.2.20030804213330.0196e2d0@pop.gmx.net>
 <5.2.1.1.2.20030804213330.0196e2d0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:11 AM 8/5/2003 +1000, Con Kolivas wrote:
>On Tue, 5 Aug 2003 06:11, Mike Galbraith wrote:
>
> > IMHO, absolute cut off is a very bad idea (btdt, and it _sucked rocks_).
> >
> > The last thing in the world you want to do is to remove differentiation
> > between tasks... try to classify them and make them all the same within
> > their class.  For grins, take away all remaining differentiation, and run a
> > hefty parallel make.
>
>I didn't fully understand you but I get your drift. I have a better solution
>in the works anyway but I wanted this tested.

WRT disk wait:  The pure disk load turns into a problem here only while 
it's writing heavily, which means to me that either write throttling needs 
a bit of work, or async write boost needs a bit of throttling (same 
thing).  To me, async operations using sync wakeups makes more sense than 
trying to discriminate based upon task state.  Writes are generally async, 
and reads are generally sync.  If a task is in D state waiting for a write 
request to become available, it doesn't seem to me to be a good idea to 
boost his priority, that allows the guy who is overloading your I/O system 
and beating up your pagecache to preempt other pagecache users as soon as a 
request becomes available.  OTOH, a reader is almost always (except for 
readahead?) sync, and _needs_ to be able to preempt to use the data it 
waited on.  Take for example swapin; remove the sleep credit for swapin, 
and watch the thrash-fest begin... the light to moderate swap load that 
your box formerly handled easily suddenly becomes a horrible mess.

         -Mike

[aside: "D state is involuntary sleep" is kinda wrong-minded I think.  The 
only voluntary sleep is a yield.  All others could just as well be 
considered involuntary (also wrong).  A good example of what I mean is the 
problem with X and xmms's gl thread inverting their priorities once X 
expires in the presence of a non-interactive load.  X isn't running at prio 
25 because it is inherently a cpu hog, and the gl thread isn't at prio 16 
because it's voluntarily sleeping.  The situation is exactly the 
opposite.  The gl thread is a huge cpu hog that is "involuntarily" 
sleeping, waiting on X, who is "involuntarily" permanently running because 
it can't get enough cpu to catch up with it's workload so it can do what it 
normally does, sleep.  Also as an aside, if you want to have lots of fun 
with D state, play with semaphores.  Test results of using async/sync 
wakeups there can be highly counter-intuitive.] 

