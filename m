Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262927AbTCKOOO>; Tue, 11 Mar 2003 09:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTCKOOO>; Tue, 11 Mar 2003 09:14:14 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:14720 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S262927AbTCKOOM>; Tue, 11 Mar 2003 09:14:12 -0500
Date: Tue, 11 Mar 2003 14:24:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030311142447.GA14931@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> To briefly explain the difference between an Edge Triggered and an Level
> Triggered interface, suppose this sequence :
> 
> 1) Pipe writer writes 2Kb of data on the write side
> 2) Pipe reader read 1Kb
> 3) Pipe reader calls epoll_wait()
> [...]
> The LT epoll is by all means the fastest poll available and can be used
> wherever poll can be used. To test it I also ported thttpd to LT
> epoll and, so far, it didn't puke on my face. Niels and Marius also wrote
> a nice event library :

I'm wondering about performance in terms of number of system calls.

If I do not completely read from a pipe or socket fd and then decide
to service some other fds (to avoid starvation when one fd is flooded
with data), with LT epoll I will need to issue an extra two
epoll_ctl() system calls.  These are to (a) unregister my interest in
the first fd because it's moved out of my "live" set in userspace,
while I spend a timeslice or so servicing other fdss; (b) reregister
my interest when it is time to reactivate that fd's handler.  These
are not required with ET epoll.

That is a con.

On the other hand, with LT poll I do not have to keep trying to read()
until I see an EAGAIN: I can "pause" a userspace handler when it sees
a short read(), guessing that there is no more data right now.  If
therre actually is more data, I can be confident the event loop will
report it.  With UDP-style fds, I can simply read one packet.  In both
scenarios, LT epoll saves one read() system call.

I am not sure; perhaps there is a similar saving of one accept() call
per event on a listening socket?

This is a pro.

So there you go.  I was about to complain that LT epoll would increase
the number of system calls in some cases, but I correct myself
already.  I think it will decrease the number of system calls on
average due to the removal of extraneous read() and maybe accept() calls.

> LT epoll you simply use epoll_ctl(EPOLL_CTL_MOD) to switch between
> EPOLLIN and EPOLLOUT.

?? Is this poorly worded?  EPOLLIN and EPOLLOUT are independent events,
aren't they?

> In front of this considerations we
> have three options that I can think :
> 
> 1) We leave epoll as is ( ET )
> 2) We apply the patch that will make epoll LT
> 3) We add a parameter to epoll_create() to fix the interface behaviour at
> 	creation time ( small change on the current patch )

Is it not better to (4) select the behaviour when an fd interest is
registered?  I think this is cleanest, if the code is not too
horrible.

Actually I think _this_ is cleanest: A three-way flag per registered
fd interest saying whether to:

	1. Report 0->1 edges for this interest.  (Initial 1 counts as an event).
	2. Continually report 1 levels for this interest.
	3. One-shot, report the first time 1 is noted and unregister.

ET poll is equivalent to 1.  LT poll is equivalent to 2.  dnotify's
one-shot mode is equivalent to 3.

I don't know whether it would make the epoll code messy to do this.  I
suspect it would be quite clean.

cheers,
-- Jamie
