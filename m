Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCYTwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCYTwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCYTwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:52:11 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:41171 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751114AbWCYTwJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:52:09 -0500
Date: Sat, 25 Mar 2006 20:52:04 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Comment on 2.6.16-rt6 PI
In-Reply-To: <1143311729.5344.131.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603252043100.19918-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Thomas Gleixner wrote:

> On Sat, 2006-03-25 at 19:23 +0100, Esben Nielsen wrote:
> > Sorry for the lack of details. I just thought the test-case wouldn't make
> > sense to you much and didn't paste it in. I was in a bit of a hurry too.
> > Now I have a little more time and can tell you what is going on:
> >
> > top_waiter!=NULL
> > waiter!=NULL
> > waiter!=rt_mutex_top_waiter(lock)
> >
> > Therefore one top_waiter is removed and but nothing is inserted.
>
> How does this happen. From inside the loop this is impossible. And I
> dont see a caller with that constellation either.

The test-case where I made it happen is below.

What happens in the last line of execution is that the 3rd thread takes
lock 1 and boosts task 1st task which is blocked on 2nd task. Now all 1st,
2nd and 3rd task all have priority 1.
Then the 4th task is allowed to run. It tries to lock lock 2, which is owned
by the 2nd task. The first waiter is the 1st task bosted to priorty 2. So
this is "top_waiter". But waiter referes to the 4th task with priority 2
so not the first waiter.

The result is as above because I am running with deadlock detection on.

Esben


threads:   4            3            1              2
         lock 1         +            +              +
test:     +             +            +              +
test:    prio 4      prio 3       prio 1         prio 2
test:  lockcount 1  lockcount 0  lockcount 0  lockcount 0

          +          lock 2          +              +
test:     +             +            +              +
test:    prio 4      prio 3       prio 1          prio 2
test:  lockcount 1  lockcount 1  lockcount 0  lockcount 0

         lock 2         +            +              +
test:     -             +            +              +
test:    prio 4      prio 3       prio 1          prio 2
test:  lockcount 1  lockcount 1  lockcount 0  lockcount 0

           +            +          lock1          lock 2
test:     -             +            -             -
test:    prio 1      prio 1       prio 1           prio 2
test:  lockcount 1  lockcount 1  lockcount 0      lockcount 0

>
> 	tglx
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

