Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270217AbRHGOU5>; Tue, 7 Aug 2001 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270216AbRHGOUr>; Tue, 7 Aug 2001 10:20:47 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:38908 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S270215AbRHGOUg>; Tue, 7 Aug 2001 10:20:36 -0400
From: Erich Nahum <nahum@watson.ibm.com>
Message-Id: <200108071420.KAA46894@orinoco.watson.ibm.com>
Subject: Re: sigopen() vs. /dev/sigtimedwait
To: linux-kernel@vger.kernel.org
Date: Tue, 7 Aug 2001 10:20:41 -0400 (EDT)
Reply-to: nahum@watson.ibm.com (Erich M. Nahum)
X-Url: http://www.research.ibm.com/people/n/nahum/
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Abhishek Chandra and I are benchmarking /dev/epoll vs. RT signals
with signal-per-FD, and we wanted to chip in some thoughts along
these lines.

First of all, Davide Libenzi's /dev/epoll does not have the same
semantics as the original /dev/poll that Sun did.  Select, poll,
and the original /dev/poll are all state-based mechanisms, whereas 
/dev/epoll and RT signals are event-based mechanisms.  In the state-based
approach, the application can ask the kernel which file descriptors
are ready to read or write to.  In the event-based approach, the
kernel notifies the application when something changes.  This has
serious implications for how one develops the server;  in the 
event-based case, the server has to keep track of the state of the 
connections more carefully.  For more discussion of event-based vs. 
state-based, see the original Banga/Druschel/Mogul work via Dan 
Kegel's c10k page (http://www.kegel.com/c10k.html)

Both /dev/epoll and RT signals with sig-per-fd have the property that
the event queue never overflows, since events are coalesced on a per-fd
basis, assuming the user-space server isn't broken.  If the server 
underestimages the max number of file descriptors it can use, the
event queue can overflow in either scenario.

Event-based interfaces have some conditions that the server developer 
has to be aware of.  For example, when a server using writes to a 
socket for the first time, /dev/poll will tell you the socket is ready, 
whereas no event will show up on /dev/epoll, since the socket write 
state hasn't changed.  If you naively wait for a write event to happen 
(as we did before we realized this), you'll wait a long time.  

Some race conditions can also occur.  One is when the data arrives
on the socket after the accept but before the kernel is notifyied via 
/dev/epoll, thus never generating an event.  Another involves getting 
stray events after the fd is closed (soon to be fixed according to 
Davide Libenzi).  A third is when you have simultaneous reads and writes 
going on a socket, as happens with HTTP 1.1.

As far as we can tell, the /dev/epoll has the same semantics as the
RT signals with signal-per-fd.  The differences are in the interfaces,
which may have some performance implications.  For example, 
/dev/epoll can get batches of events through the read to /dev/epoll,
whereas RT signals get one signal at a time through sigtimedwait().
On the other hand, RT signals don't have to explicitly notify the kernel 
with each new or closed connection the way /dev/epoll does. Instead, 
it's done implicitly through the setsockopt/fcntl call to make the socket
asynchronous/non-blocking, which the server has to do anyway.
As I mentioned earlier, we're benchmarking these to see what the 
performance difference is, if any.  Davide Libenzi is also pursuing
this comparison.

So far Abhishek and I haven't looked at Ben LeHaises async I/O interface,
but it's on our schedule.

-Erich

-- 
Erich M. Nahum                  IBM T.J. Watson Research Center
Networking Research             P.O. Box 704
nahum@watson.ibm.com            Yorktown Heights NY 10598
