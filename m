Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268157AbTBNC30>; Thu, 13 Feb 2003 21:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268159AbTBNC30>; Thu, 13 Feb 2003 21:29:26 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:25744 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S268157AbTBNC3Y>; Thu, 13 Feb 2003 21:29:24 -0500
Date: Fri, 14 Feb 2003 02:40:46 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Tridgell <tridge@samba.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030214024046.GA18214@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The above example program is obviously totally useless, and any real use
> would have to expand the implementation with addign the full siginfo to
> the packet read (which is trivial apart from deciding on what format to
> use - it would be good to not have it be architecture-dependent and in
> particular it would be horrible to have different formats for different
> compatibility layers).

siginfo is _almost_ architecture independent now.  There are some
quirks.  siginfo is bad though, because it has to be compatible with
whatever standard it came from, so nobody dares to extend it.  (See
dnotify and sigsegv below).

I see that there are several fairly general event sources now:

	- signals
	- epoll events
	- async I/O events
	- posix timers

More events that don't provide enough information:

	- dnotify details (siginfo doesn't say enough)
	- sigsegv read/write? (siginfo doesn't say enough)

More events that should be accessible but aren't:

	- vm paging like crazy, please release some memory

Your synchronous signals code effectively makes signals work with
select/poll/epoll nicely.  Async I/O still reports events in its own
way.

Suggestion du jour
------------------

I think that epoll and sigfd and async I/O could meld into a nice and
extensible, and fast, event interface.  You'd first create an "event
fd" (i.e. very similar to epoll_create or sigfd), then you'd add event
sets of interest (which include signals and file descriptors), then
you'd wait for them using read().

All event sources (such as timers) would have a facility for adding
themselves to a given sigfd.

Such fds could be passed around in the usual ways (as you described
for sigfds).

Async I/Os would be queued with reference to a sigfd, instead of an
aio descriptor (which is just an integer anyway) as they are now.

read() would report return one or more structure containing pending
events, in the format: LENGTH, CATEGORY, REST... with the first word
saying which category of events (and giving the format), the next
giving the length, and the rest in much the same format as epoll or
async I/O do now, and whatever format is appropriate for signals.

Davide has already worked out the tricky logic of attaching fd-poll
events to an event reporter, although a special system call is used to
get the events instead of just read().  The async I/O folk have
already done similar for async I/Os, except a different special system
call is used.  But both basically return an array of bytes containing
event structures.

In summary:

	sigfd(...)		// Create an event reporter fd.
	sigfd_sigmask(fd,...)	// Attach a signal mask to the reporter.
	epoll_ctl(fd,...)	// Attach an fd watcher to the reporter.
	fcntl(...DNOTIFY_*,fd)	// Attach a directory watcher to the reporter.
	futex_event(...,fd)	// Attach a futex waiter to the reporter.

My main reason for wanting a little unity, rather than lots of
different event reporter types (i.e. epoll, aio, sigfd) as now is
mainly that async I/O doesn't fit at all because it doesn't use an fd
to report its events.  Anything fd-based can obviously be monitored
using epoll (or poll/select).

Obviously, all that's needed there is for async I/O to report _its_
events using a file descriptor and read().

However, once you've got a kernel data structure for queuing events
(epoll's logic is close to ideal IMHO), it seems clean and efficient
to generalise the code, rather than having several different event
queuing and reporting subsystems.

And when that's done you have some nice bonuses:

	- All event types are reported equally fast, and in a single
	  system call (read()).

	- The order in which events occurred is preserved.
	  (This is lost when you have to scan multiple queues).

	- Hierarchies of event sets of any kind are possible.
	  (epoll has solved the logical problems of this already).

	- Less code duplicated.

	- Adding new kinds of kernel events becomes _very_ simple.

-- Jamie
