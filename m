Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTAXHtj>; Fri, 24 Jan 2003 02:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAXHtj>; Fri, 24 Jan 2003 02:49:39 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:33997 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S267611AbTAXHti>; Fri, 24 Jan 2003 02:49:38 -0500
Message-ID: <3E30F79D.6050709@kegel.com>
Date: Fri, 24 Jan 2003 00:21:49 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <Pine.LNX.4.44.0301232144470.8203-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0301232144470.8203-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> in principle, why should the footprint be large?  it's a register set
> and at most a couple cachelines of stack frame.

... but all the threads' cachelines will collide, whereas if
you're using nonblocking I/O, session state might be staggered better.
This is just a guess; I haven't measured it.

>>>does epoll provide a thunk (callback and state variable) as well as the 
>>>IO completion status?
>>
>>No.  It provides an event record containing a user-defined state pointer
>>plus the IO readiness status change (different from IO completion status).
>>But that's what you need; you can do the call yourself.
> 
> well, that means another syscall, which makes a footprint claim kind of moot,
> no?

What syscall?  You call sys_epoll once for every thousand events or so,
then you call your handler, which does a write or whatever.  No
extra syscall.

>>>>See http://www.kegel.com/c10k.html for an overview of the issue and some links.
>>>
>>>
>>>it's a great resource, except that for 700 clients, the difference
>>>between select, poll, epoll, aio are pretty moot.  no?
>>
>>Depends on how close to maximal performance you need, and whether
>>you might later need to scale to more clients.
> 
> 
> no, I'm suggesting the choice is nonlinear: that for moderately large loads,
> like 700 clients, there is no advantage to traditional approaches.

I agree that for 700 clients the answer may be different than for 2000 clients.
However, if you have to handle 700 clients, how do you know you won't
have to handle 2000 later?

In any case, benchmarking's the only way to go.  No amount of talk will
substitute for a good real-life measurement.  That's what convinced
me that epoll was faster than sigio, and that sigio was
sometimes slower than select() !

And, for what it's worth, programmer productivity is sometimes
more important than all the above.  I happen to work
at a place where performance is worth a lot of extra effort,
but other shops prefer to throw hardware at the problem and
not worry about that last 10%.

- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

