Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTFZWzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTFZWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:55:12 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:63249 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263428AbTFZWy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:54:26 -0400
Message-ID: <3EFB7D70.8010602@techsource.com>
Date: Thu, 26 Jun 2003 19:10:40 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Mike Galbraith <efault@gmx.de>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <20030623164743.GB1184@hh.idb.hist.no> <5.2.0.9.2.20030624215008.00ce73b8@pop.gmx.net> <3EFAC408.4020106@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:

> How about _removing_ the io-wait bonus for waiting on pipes then?
> If you wait for disk io, someone else gets to use
> the cpu for their work.  So you get a boost for
> giving up your share of time, waiting
> for that slow device.
> 
> But if you wait for a pipe, you wait for some other
> cpu hog to do the first part of _your_ work.
> I.e. nobody else benefitted from your waiting,
> so you don't get any boost either.
> 
> This solves the problem of someone artifically
> dividing up a job, using token passing
> to get unfair priority.
> 
> 
> This can be fine-tuned a bit: We may want the pipe-waiter
> to get a _little_ bonus at times, but that has to be
> subtracted from whatever bonus the process at the
> other end of the pipe has.  I.e. no new bonus
> created, just shift some the existing bonus around.
> The "other end" may, after all, have gained legitimate
> bonus from waiting on the disk/network/paging/os, and passing
> some of that on to "clients" might make sense.
>

In other words:

Don't give pipe-waiting any kind of boost or penalty, but do balance the 
interactivity points between entities at each end of the pipe.

So, if you're waiting on a pipe, but the other end is a CPU hog, then 
since you don't get a boost (pipe wait), you don't give a boost to the 
CPU hog, but since he's a CPU hog, he DOES share negative points with 
you, lowering your priority.

Conversely, if a process is waiting on real I/O (disk, user input, 
etc.), then it gets an interactivity boost that it can share with other 
processes it's connected to via pipe.

Since most X clients only do pipe waiting on the server, then it's the X 
server that gets the interactivity boost by waiting on user input, which 
it can share with clients.

And since there is no effect from pipe wait, you can still judge a 
process as interactive or not based on what it does when it's NOT 
waiting on a pipe -- if it becomes a CPU hog THEN, you deduct points, etc.

Here's an interesting question:  Would you often have a situation where 
a process at one end of a pipe is a CPU hog, and the process at the 
other end is interactive?  Is that a problem?

If you're always adding or subtracting points, that situation could be 
less than optimal, but you'll never get to the point where the 
interactive process is believed to be a cpu hog or vice versa.  The 
points each process would be assessed at a faster rate than the sharing 
between processes.

Do you want to always share points, or do you share only when something 
wakes up from a pipe wait?

