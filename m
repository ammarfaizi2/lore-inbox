Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVGNRX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVGNRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGNRX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:23:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262660AbVGNRXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:23:22 -0400
Date: Thu, 14 Jul 2005 10:21:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121360561.3967.55.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121360561.3967.55.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Arjan van de Ven wrote:
> 
> I *will* argue that for relative delays in drivers, msleep() is better.

Oh, I agree.

I think we should continue the simplification of the simple stuff. If 
somebody just wants to sleep a while, do it.

But if somebody is doing this because they think "jiffies" are evil, then 
that somebody is being a total idiot. Jiffies aren't evil. They are 
basically the most efficient way to handle any kind of absolute timeouts, 
and any "repeating timeout" _needs_ to be written in absolute terms.

And quite frankly, in this discussion I have several times seen the 
argument that we should be getting rid of jiffies because somebody thinks 
jiffies are "hard" and somehow incompatible with "tickless".

THAT is the thinking I want to squash.

We're not getting rid of jiffies, and we're not going to be "tickless". We 
might have a variable clock, but that has _nothing_ to do with the basic 
fact that even a variable clock needs a fundamental baseline, and that the 
kernel _needs_ a heartbeat.

And that baseline and heartbeat is HZ and "jiffies". End of story. Anybody
who argues for getting rid of it just isn't thinking things through.

> I have nothing religious against jiffies per se. My argument however is
> that with a few simple, relative interfaces *in addition* to an absolute
> interface, almost all drivers suddenly are isolated from jiffies and HZ
> because they simply don't care. Because they really DON'T care about
> absolute time. At all. 

That's not even true.

A _lot_ of drivers end up caring about absolute time, because a _lot_ of 
drivers have a very simple issue like:

 - poll this port every 10ms until it returns "ready", or until we time
   out after 500ms.

And the thing is, you can do it the stupid way:

	for (i = 0; i < 50; i++) {
		if (ready())
			return 0;
		msleep(10);
	}
	.. timeout ..

or you can do it the _right_ way. The stupid way is simpler, but anybody 
who doesn't see what the problem is has some serious problems in kernel 
programming. Hint: it might not be polling for half a second, it might be 
polling for half a _minute_ for all you know.

In other words, the _right_ way to do this is literally

	unsigned long timeout = jiffies + HZ/2;
	for (;;) {
		if (ready())
			return 0;
		if (time_after(timeout, jiffies))
			break;
		msleep(10);
	}

which is unquestionably more complex, yes, but it's more complex because 
it is CORRECT!

And yes, we have had people "simplifying" drivers and screwing things like 
this up. And you don't even notice, until the machine is under heavy load, 
and then the "simplified" driver ends up being very very broken, and 
people wonder why performance sucks.

So stop saying that drivers not needing absolute timeouts. They need it
qutie often.

		Linus
