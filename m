Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTF1F0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 01:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTF1F0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 01:26:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:9092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264362AbTF1F0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 01:26:21 -0400
Message-Id: <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 28 Jun 2003 07:44:26 +0200
To: Bill Davidsen <davidsen@tmr.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030627234408.25848A-100000@gatekeeper.tmr.c
 om>
References: <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:51 PM 6/27/2003 -0400, Bill Davidsen wrote:
>On Fri, 27 Jun 2003, Mike Galbraith wrote:
>
>
> > (simple?  decode stack, find out where he was sleeping, and then have to
> > decide what to do based upon that after _every sleep_?  sprinkle 
> scheduling
> > decisions around every place that does wakeups?... i can just imagine Al's
> > reaction to someone suggesting that for the VFS... someone better run fast
> > and hide well:)
>
>I'm quoting the above to show I've read you objection, but I think you
>have it backward.
> >
> > >A pipe wakeup can be handled by taking a look at the other end.
> > >If the other process has interactivity bonus, grab half of
> > >it.  (And halve the bonus belonging to that process.)
> > >No bonus is created in this case, so no risk of DOS.
> > >It is merely redistributed.
> > >
> > >And it is simple - there is one thing that woke the
> > >process up - so only one thing to check.
> >
> > How?
>
>
> > >Hard corner cases can be avoided.  Perhaps bunch of pipes,
> > >files, devices, sockets and page-ins becomes ready
> > >simultaneosly.  A detailed priority calculation is clearly
> > >pointless, so just use one of the things - or none.
> > >
> > >>Until someone demonstrates that the DoS/abuse scenarios I might be
> > >>imagining are real, in C, I think I'll do the smart thing: try to stop
> > >>worrying about it and stick to very very simple stuff.
> > >
> > >I thought the Irman thing was what killed the previous attempt
> > >at redistributing priorities?
> > What I think kills the priority redistribution idea is _massive_
> > complexity.  I don't see anything simple.  You would have to build the
> > logical connections between tasks, which currently doesn't exist.  Wakeups
> > and task switches are extremely light weight operations, and no decision
> > you make at wakeup time has a ghost of a chance of not hurting like
> > hell.  Just using the monotonic_clock() in the wakeup/schedule paths is
> > fairly painful.  There is just no way you can run around looking for and
> > processing "who shot JR" information in those paths (no way _I_ can 
> imagine
> > anyway) without absolutely destroying performance.
>
>Why do it at wakeup. Is it easier to just decide at the time of the
>processes blocking to decisde there if it is blocking on an interactive
>transaction? Is it that easy or is it really necessary to make the process
>perfect?

I'm no clean freak, but fiddling with scheduling information all over the 
place seems like a very bad idea. (before anyone says it, yes, we fiddle 
with state all over the place;)  I can imagine doing something dirty in 
driver code for specific cases (kdb/mouse are always interactivity 
indicators), but not in generic code.

Besides, the logical bindings for foo | bar | ... | baz do not exist in the 
kernel.  The kernel knows and cares only that single entities are using 
open/read/write/close primitives.  This is why I said I could _imagine_ a 
process struct... as the container for this missing (it lives in userland) 
information.

Another besides:  it makes zero difference it you add overhead to wakeup 
time or go to sleep time.  If it's something you do a lot of, adding 
overhead to it is going to hurt a lot.

         -Mike 

