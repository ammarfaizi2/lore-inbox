Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVLTXNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLTXNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLTXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:13:17 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:26565 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932171AbVLTXNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:13:16 -0500
Date: Tue, 20 Dec 2005 18:12:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <simlo@phys.au.dk>
cc: david singleton <dsingleton@mvista.com>, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Recursion bug in -rt
In-Reply-To: <Pine.OSF.4.05.10512202344470.1720-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.58.0512201801380.4479@gandalf.stny.rr.com>
References: <Pine.OSF.4.05.10512202344470.1720-100000@da410.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Esben Nielsen wrote:

> >
>
> The same lock taken twice is just a special case of deadlocking. It would
> be very hard to check for the general case in the futex code without
> "fixing" the rt_mutex. Not that the rt_mutex code is broken - it just
> doesn't handle deadlocks very well as it wasn't supposed to. But as the
> futex indirectly exposes the rt_mutex to userspace it becomes a problem.
>
> The only _hack_ I can see is to force all robust futex calls to go through
> one global lock to prevent the futex deadlocks becomming rt_mutex
> deadlocks which again can turn into spin-lock deadlocks.
>
> I instead argue for altering the premisses for the rt_mutex such
> they can handle deadlocks without turning them into spin-lock deadlocks
> blocking the whole system. Then a futex deadlock will become a rt_mutex
> deadlock which can be handled.
>

For the type of deadlock you are talking about is the following:

P1 -- grabs futex A (no system call)
P2 -- grabs futex B (no system call)

P1 -- tries to grab futex B (system call to block and boost P2)
      But holds no other kernel rt_mutex!
P2 -- tries to grab futex A (system call to block and boost P1)
     spinning deadlock here,

So, before P2 blocks on P1, can there be a circular check t see if this is
a deadlock.  You don't need to worry about other kernel rt_mutexes, you
only need to worry about blocked process.

Is this feasible?

-- Steve

