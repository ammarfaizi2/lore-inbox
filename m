Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTKMSZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTKMSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:25:48 -0500
Received: from relay.pair.com ([209.68.1.20]:521 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264396AbTKMSZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:25:46 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <3FB3CC92.7070903@kegel.com>
Date: Thu, 13 Nov 2003 10:25:22 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, justformoonie@hotmail.com
Subject: Re: So, Poll is not scalable... what to do?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Bae wrote:
> If poll is not scalable, which method should I use when writing 
> multithreaded socket server?

People who write multithreaded servers tend to use thread pools
and never need to use poll().  (Well, ok, I've written multithreaded
servers that used poll(), but the threads were there for disk I/O,
not networking.)

> What is the most efficient model to use?
> 
> Is there a "standard" model to use when writing a scalable multithreaded 
> socket serve such as "io completion ports" on windows?

Depends on your definition of efficient.

If by 'efficient' you mean 'runs like a bat out of hell,
and I don't care how long it takes to write', and
you're willing to write all the code from scratch, and
you're handy with state machines, the right way to go is
an edge-triggered readiness notification method (sys_epoll or kqueue,
if available, else sigio).

A handy wrapper library that lets
you use these without worrying about exactly which method
your operating system supports is at http://kegel.com/rn/
It handles two flavors of epoll as well as sigio at the moment,
and as a proof of concept, I've modified betaftpd to use it;
the resulting ftp server scales very nicely (except for the
calls to the system password checking routine, which is a bottleneck).

On the other hand, if by 'efficient' you mean 'doesn't take
long for somebody used to doing things on Windows to write',
or if you have to use any third-party libraries that use blocking I/O,
or if you're not very handy with state machines,
go ahead and use a thread pool.

> From the "Microbenchmark comparing poll, kqueue, and /dev/poll", kqueue is 
> the way to go. Am I correct?

kqueue is for BSD.  sys_epoll is the equivalent on (recent enough) linux.

> What is the best solution to use on Linux?

Depends on your needs; see above.

> Also, why is it that poll doesn not return with "close signal" when a 
> thread-1 calls poll and thread-2 calls close on a sockfd1? It seems that 
> poll only handles close signal when a client disconnects from the server. 
> I've seen this mentioned here before, has it been fixed?

The Single Unix Standard (http://www.opengroup.org/onlinepubs/007904975/functions/close.html)
doesn't say what should happen if you close a file descriptor
being used by another thread.
Linus long ago decided that Linux would handle this
without waking the other thread.
I know, other operating systems (and Java!) behave differently,
but Linux is perfectly within its rights to behave as it does here,
and it's not likely to change.

- Dan

p.s. And, yes, http://kegel.com/c10k.html might be a handy reference for you :-)



