Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTHGWw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTHGWw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:52:26 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:6661 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271051AbTHGWwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:52:24 -0400
Message-ID: <3F32DB3A.7020604@techsource.com>
Date: Thu, 07 Aug 2003 19:05:30 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
References: <E19ksHM-0003Xl-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One comment on two processes bouncing a semaphor...

If certain kinds of sleep, such as sleeping on a semaphor, do not add
any interactivity points, but the act of sleeping on a semaphor DOES
cause SHARING of interactivity points, then those two processes would
not be able to achieve interactive status based on their sleep patterns.

The next thing to do is to somehow notice that the process never sleeps
on I/O or any other sleeping that WOULD indicate interactivity.

The situation is that both processes really ARE CPU hogs, but we don't
detect that based on using up the timeslice.  The solution is to track
what kinds of sleep a process does (counters of the various sorts),
which I'm sure already happens, but the difference is that you do not
penalize for using up the time slice.  You penalize for NOT doing
interactive-indicating I/O.

This is really quite simple.  All you're doing is you stop considering
time-slice expiration in your heuristics, at least directly.  You have a
whole list of different sleep-reasons (Schlafgruende?), it's just that
timeslice expiration isn't one of them, so whenever your sleep-reasons
isn't in the list, you infer that it's timeslice expiration.

That means you have to catch all other reasons and make sure you've
accounted for them, but you get the idea.

Simpler still would be to treat sleeping on a semaphor (or a pipe or
some other IPC) as a timeslice expiration.  That would be equivalent.
Now, if the other process is interactive, then you have a fight on your
hands.

Does the interactive process accumulate and share interactivity points
fast enough to keep the other one moving well?  If one process is
interactive, then, REALLY, you would want the sleeping of the second
process to be a don't-care.  But how can you tell?

If one process is a CPU hog (or perceived as such), and it is blocking
against another process, thus sharing interactivity points, does that
mean the CPU hog shares negative points with the other process?


Please pardon my stream-of-consciousness style in this post.




