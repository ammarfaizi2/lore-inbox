Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757507AbWKWXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbWKWXqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 18:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbWKWXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 18:46:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40655 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757504AbWKWXqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 18:46:10 -0500
Message-ID: <45663298.7000108@redhat.com>
Date: Thu, 23 Nov 2006 15:45:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <45662522.9090101@garzik.org>
In-Reply-To: <45662522.9090101@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Considering current designs, it seems more likely that a single thread 
> polls for socket activity, then dispatches work.  How often do you 
> really see in userland multiple threads polling the same set of fds, 
> then fighting to decide who will handle raised events?
> 
> More likely, you will see "prefork" (start N threads, each with its own 
> ring) or a worker pool (single thread receives events, then dispatches 
> to multiple threads for execution) or even one-thread-per-fd (single 
> thread receives events, then starts new thread for handling).

No, absolutely not.  This is exactly not what should/is/will happen.

You create worker threads to handle to work for the entire program. 
Look at something like a web server.  When creating several queues, how 
do you distribute all the connections to the different queues?  To 
ensure every connection is handled as quickly as possible you stuff them 
all in the same queue and then have all threads use this one queue. 
Whenever an event is posted a thread is woken.  _One_ thread.  If two 
events are posted, two threads are woken.  In this situation we have a 
few atomic ops at userlevel to make sure that the two threads don't pick 
the same event but that's all there is wrt "fighting".

The alternative is the sorry state we have now.  In nscd, for instance, 
we have one single thread waiting for incoming connections and it then 
has to wake up a worker thread to handle the processing.  This is done 
because we cannot "park" all threads in the accept() call since when a 
new connection is announced _all_ the threads are woken.  With the new 
event handling this wouldn't be the case, one thread only is woken and 
we don't have to wake worker threads.  All threads can be worker threads.


> If you have multiple threads accessing the same ring -- a poor design 
> choice

To the contrary.  It is the perfect means to distribute the workload to 
multiple threads.  Beside, how would you implement asynchronous filling 
of the ring buffer to avoid unnecessary syscalls if you have many 
different queues?


> -- I would think the burden should be on the application, to 
> provide proper synchronization.

Sure, as much as possible.  But there is no reason to design the commit 
interface in the way which requires expensive synchronization when there 
is another design which can do exactly the same work but does not 
require synchronization.  The currently proposed kevent_commit and my 
proposed variant are functionally equivalent.


> If the desire is to have the kernel distributes events directly to 
> multiple threads, then the app should dup(2) the fd to be watched, and 
> create a ring buffer for each separate thread.

And how would you synchronize the file descriptor use across the 
threads?  The event would be sent to all the event queues so that you 
would a) unnecessarily wake all threads and b) have all but one thread 
see the operation (say, read or write on a socket) fail with 
EWOULDBLOCK.  That's just silly, we can have that today and continue to 
waste precious CPU cycles.

If you say that you post exactly one event per file description (not 
handle) then what do you do if the programmer wants the opposite?  And 
again, what do you do for asynchronous ring buffer filling.  Which queue 
do you pick?  Pick the wrong one and the event might be in the ring 
buffer for a long time which another thread handling another queue is ready.

Using a single central queue is the perfect means to distribute the load 
to a number of threads.  Nobody is forcing you to do it, you're free to 
use separate queues if you want.  But the model should not enforce this.


Overall, I cannot see at all where your problem is.  I agree that the 
synchronization of the access to the ring buffer must be done at 
userlevel.  This is why the uidx exposure isn't needed.  The wakeup in 
any case has to take threads into account.  The only change I proposed 
to enable better multi-thread handling is the revised commit interface 
and this change in no way hinders single-threaded users.  The interface 
is not hindered in any way or form by the use of threads.

Oh, and when I say "threads" I should have said "threads or processes". 
  The whole also applies to multi-process applications.  They can share 
event queues by placing them in shared memory.  And I hope that everyone 
agrees that programs have to go into the direction of having more than 
one execution context to take advantage of increased CPU power in 
future.  CMP is only becoming more and more important.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
