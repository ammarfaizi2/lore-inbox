Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTKNA1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTKNA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:27:48 -0500
Received: from relay.pair.com ([209.68.1.20]:29189 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264479AbTKNA1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:27:45 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <3FB42169.7000001@kegel.com>
Date: Thu, 13 Nov 2003 16:27:21 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: justformoonie@hotmail.com
Subject: Re: So, Poll is not scalable... what to do?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Bae wrote:
>>>If poll is not scalable, which method should I use when writing 
>>>multithreaded socket server?
>>
>>People who write multithreaded servers tend to use thread pools
>>and never need to use poll().  (Well, ok, I've written multithreaded
>>servers that used poll(), but the threads were there for disk I/O,
>>not networking.)
> 
> By thread pool, do you mean, one thread per socket?, or a work-crew model 
> where a specified number of threads handle many sockets?

The latter.  But I don't have much recent experience writing threaded
servers, as I usually use somthing like epoll.

> My definition of "efficient" is a method that is most widely used or 
> accepted for writing a robust scalable server. So I guess, "'runs like a bat 
> out of hell, and I don't care how long it takes to write'" is close.
> 
> Would it be thread pool or epoll? 

My personal bias is towards epoll (suitably wrapped for portability;
no need to require epoll when sigio is nearly as good, and universally deployed).

 > Is it uncommon to mix these two?

Folks who know how to program with things like epoll and aio tend
to use threads carefully, and try to avoid using blocking I/O for networking.
Blocking I/O is unavoidable for things like opening files, though,
so it's perfectly fine to have a thread that handles stuff like that.

> Currently, I have a thread-1 calling poll, and dispatching its workload to 
> thread-2 and thread-3 in blocking sockets. I dispatch the workload to worker 
> threads because some of the operations take considerable time.
> 
> Is mixing threads with poll uncommon? Is this a bad design? any comments 
> would be appreciated.

What are the operations that take considerable time?  Are they networking
calls, or disk I/O, or ...?   If they're just networking calls,
you might consider turning your code inside out to do everything with
nonblocking I/O and state machines, but only if you're hitting a bottleneck
because of the number of threads active.

Whatever design you're comfortable with is fine until you fail to hit your
performance requirement.  No point in optimizing one little part
of the system if the whole system is fast enough, or if the real
bottleneck is elsewhere...
- Dan


