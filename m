Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbSJaCAu>; Wed, 30 Oct 2002 21:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSJaCAu>; Wed, 30 Oct 2002 21:00:50 -0500
Received: from mtao-m01.ehs.aol.com ([64.12.52.73]:1924 "EHLO
	mtao-m01.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265101AbSJaCAt>; Wed, 30 Oct 2002 21:00:49 -0500
Date: Wed, 30 Oct 2002 18:07:07 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-reply-to: <Pine.LNX.4.44.0210291839190.1457-100000@blue1.dev.mcafeelabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DC0904B.1070009@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <Pine.LNX.4.44.0210291839190.1457-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>John, your first post about epoll was "the interface has a bug, please
>do not merge it".
>
My first post about epoll pointed out how it was designed for single 
threaded callers and concluded:

I certainly hope /dev/epoll itself doesn't get accepted into the kernel, 
the interface is error prone.  Registering interest in a condition when 
the condition is already true should immediately generate an event, the 
epoll interface did not do that last time I saw it discussed.  This 
deficiency in the interface requires callers to include more complex 
workaround code and is likely to result in subtle, hard to diagnose bugs.

I did not say "the interface has a bug", I said that the interface is 
error prone.  This is a deficiency that should be fixed before the 
interface is added to the kernel.

>Sorry, what prevents you in coding that ? If you, instead of ranting
>because epoll does not fit your personal idea of event notification, took
>a look to the example http server used for the test ( coroutine based )
>you'll see that does exactly that.
>
You posted code which you claimed was "even more cleaner and simmetric" 
(sic) because it fell through to the do_use_fd() code instead of putting 
the do_use_fd() code in an else clause.  A callback scheme is akin to 
the if/else structure.  To adapt the first code to a callback scheme, 
the accept callback has to somehow arrange to call the do_use_fd() 
callback before returning to the event loop.  This requirement is subtle 
and asymmetric.

>I really don't believe this. Are you just trolling or what ? It is clear
>that your acceptor routine has to do a little more work than that in a
>real program.
>
Basically, you spawn off another coroutine.  That complicates the "fall 
through to do_use_fd()" logic in the first code by requiring an external 
facility not required by the second code.  The second code could simply 
have the accept code loop until EAGAIN.

>Doh ! John, did you actually read the code ?
>
Yes, indeed.

>Could you compare AIO level
>of intrusion inside the kernel code with the epoll one ?
>
Aio poll extends the existing set of poll notification hooks with a 
callback mechanism.  It then plugs into this callback mechanism in order 
to deliver events.  The end result is that the same notification hooks 
are used for classic poll and aio poll.  When aio poll is not being 
used, there is no additional performance penalty other than a slightly 
larger poll_table_entry and poll_table_page.

Epoll creates a new callback mechanism and plugs into this new callback 
mechansim.  It adds a new set of notification hooks which feed into this 
new callback mechansim.  The end result is that there is one set of 
notification hooks for classic poll and another set for epoll.  When 
epoll is not being used, the poll and socket code makes an additional 
set of checks to see that nobody has registered interest through the new 
callback mechanism.

> It fits _exactly_
>the rt-signal hooks. One of the design goals for me was to add almost
>nothing on the main path. You can lookup here for a quick compare between
>aio poll and epoll for a test where events delivery efficency does matter
>( pipetest ) :
>
This is a comparison of the cost of using epoll to the cost of using aio 
in one particular situation.  It is irrelevant to the point I was making.

>Now, I don't believe that a real world app will exchange 300000 tokens per
>second through a pipe, but this help you to understand the efficency of
>the epoll event notification subsystem.
>  
>
My understanding of the efficiency of the epoll event notification 
subsystem is:

1) Unlike the current aio poll, it amortizes the cost of interest 
registration/deregistration across multiple events for a given connection.

2) It declares multithreaded use out of scope, making optimizations that 
are only appropriate for use by single threaded callers.


