Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUL1HZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUL1HZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbUL1HZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:25:25 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:47029 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262115AbUL1HFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 02:05:39 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 27 Dec 2004 23:05:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Paul P Komkoff Jr <i@stingr.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to implement multithreaded event loop ?
In-Reply-To: <20041227200509.GD1035@stingr.sgu.ru>
Message-ID: <Pine.LNX.4.58.0412272206510.25362@bigblue.dev.mdolabs.com>
References: <20041227200509.GD1035@stingr.sgu.ru>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004, Paul P Komkoff Jr wrote:

> I am trying to implement a multithreaded event loop using epoll. So, I
> have 2 kind of events. First, there are conditions on fds I have
> (listener sockets, client connections, my connections to other
> clients). Second, I need to have some kind of priority queue into
> which I can push forthcoming timed events.
> 
> In case of single-threaded server, this is fairly trivial. I just need
> to make heap queue and add its 1st (i.e. minimal) element as timeout
> to each next epoll_wait call. When some condition breaks the wait, I
> can always do find_min and wait again with new timeout.
> 
> Things become complicated when I need to scale. So, without this
> timeout cruft, I can just add proper locking around my data structures
> but main epoll_wait loop is multithread-aware, e.g. it will retrieve
> different events for different waiting threads (to be absolutely fair
> with you, I did not implemented this part yet, but I assume that some
> combination of edge triggered + one shot epoll will do the trick).
> But, if using heap priority queue to manage timed events, I need to
> wake up each waiting thread when any event was added to the heap
> before one that was minimal.

One solution (if you really cannot scale using multiple processes) is the 
one that you're describing, where you have many threads doing epoll_wait. 
You have to be careful to not fetch too many event on a single wait 
(preferably one), otherwise you can end up with period of time with 
pending events on a single thread, while others are free to spin. If the 
timers that you are using are simply to timeout pending operations, the 
timer resolution does not need to be that high, so you could use a 
maximum timeout of a second or so for epoll_wait (and handle timers like 
you planned). Another solution would be to have a single epoll_wait loop 
thread that feeds your threads that are waiting on a mutex, protecting an 
event queue from which threads pull events. This will make timeout 
handling somehow easier, but delivering an event would mean a ctx switch 
to wake the epoll_wait thread, plus another one waking a processing 
thread.



> Another solution proposed by my poor brain is - to have alive thread
> which will handle this priority queue, and have one fifo fd in my
> epoll set dedicated to this purpose. Priority queue management thread
> will write single char to that fd when some timed event needs to be
> processed.
> 
> Doing some google search, I've found this message:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.3/2416.html
> Things can be much easier if there was timer kernel object (or its
> equivalent). Can anyone give me some advice - how I should solve this
> problem?

Like lingering IRQs, nobody cared :-) Linus also proposed a "signal fd", 
that could have been used for timers, but nobody showed interest either.


- Davide

