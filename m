Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUJGNRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUJGNRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUJGNRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:17:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3207 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263795AbUJGNOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:14:15 -0400
Date: Thu, 7 Oct 2004 09:12:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul Jakma <paul@clubi.ie>
cc: Martijn Sipkema <martijn@entmoot.nl>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
Message-ID: <Pine.LNX.4.61.0410070858420.10784@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com>
 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir>
 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Paul Jakma wrote:

> On Thu, 7 Oct 2004, Martijn Sipkema wrote:
>
>> That there is time between the select() and recvmsg() calls is not the 
>> issue; the data is only checked in the call to recvmsg(). Actually the 
>> longer the time between select() and recvmsg(), the larger the probability 
>> that valid data has been received.
>
> But it is the issue.
>
> Much can change between the select() and recvmsg - things outside of kernel 
> control too, and it's long been known.
>
>> But the standard clearly says otherwise.
>
> Standards can have bugs too.
>
> It's not healthy to take a corner-case situation from the standard on 
> select() and apply it globally to all IO. (not in my mind anyway, whatever 
> the standard says).
>
>> Perhaps select()'s perception of state should be made to take possible
>> corruption into account.
>
> You'll /still/ run into problems, on other platforms too. Set socket to 
> O_NONBLOCK and deal with it ;)
>
>> Why would the POSIX standard say recvmsg() should not block if
>> it did not intend it to be used in that way?
>
> POSIX_ME_HARDER? ;)
>
>> Wrong. IMHO it is not exactly a good thing to not be compliant on such 
>> basic functionality.
>
> Like I said, to my mind, any sane app should try avoiding assumption that 
> kernel state remains same between select() and read/write - and O_NONBLOCK 
> exists to deal nicely with the situation.
>
> You really shouldnt assume select state is guaranteed not to change by time 
> you get round to doing IO. It's not safe, and not just on Linux - whatever 
> POSIX says.
>
>> --ms
>
> regards,

Hmmm. When somebody is sleeping in select(), waiting for that
wake_up_interruptible() call that signals that data are
present, how could data not be present anymore when the
only listener makes the call to read() the data?

Simple. It's a BUG. A no-nonsense BUG. The wake_up_interruptible()
call must be made only after valid data are available for the
listener to read. Anything else is a BUG. There are several
bugs present in the logic. The first being that it will
take some time for a listener to wake up, therefore it's
okay to signal the listener before data are ready. This
is the primary BUG. The code is just details. With the
new preemptive kernel, it becomes increasingly necessary
to perform things in the correct order. The second known
BUG is that somebody decided to remove basic functionality
to improve some benchmarks.

Now, one can update the man pages and state to not use poll()
or select() for their intended purposes, or they can fix the
BUG. It's just that simple.

In the meantime, what is the function that should be used
to emulate the correct behavior of select()? If there isn't
an answer to that, then the BUG needs to be fixed.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

