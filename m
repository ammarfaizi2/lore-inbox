Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSHPLVM>; Fri, 16 Aug 2002 07:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSHPLVM>; Fri, 16 Aug 2002 07:21:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31486 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318304AbSHPLVI>;
	Fri, 16 Aug 2002 07:21:08 -0400
Date: Fri, 16 Aug 2002 16:53:06 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816165306.A2055@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <20020816100334.GP14394@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816100334.GP14394@dualathlon.random>; from andrea@suse.de on Fri, Aug 16, 2002 at 12:03:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 12:03:34PM +0200, Andrea Arcangeli wrote:
> On Fri, Aug 16, 2002 at 03:09:46PM +0530, Suparna Bhattacharya wrote:
> > Also, wasn't the fact that the API was designed to support both POSIX 
> > and completion port style semantics, another reason for a different 
> > (lightweight) in-kernel api? The c10k users of aio are likely to find 
> > the latter model (i.e.  completion ports) more efficient.
> 
> if it's handy for you, can you post a link to the API defined by
> POSIX and completion ports so I can read them too and not only SuS?

Don't have anything handy atm that's any better than what you could 
get through doing a google on "IO Completion ports". (See section at
the end of this note for some info)

Completion port apis aren't really part of any standard, but provided
by some operating systems (NT, AS/400), most of which use a similar
interface. I personally found it useful to refer to the DAFS 
completion groups API (DAFS API Spec at www.dafscollaborative.org) 
just to get an idea of something that takes into account these various 
existing interfaces to arrive at an interface for async i/o
completion (even though this really is all direct user-space api 
implementation for remote file data access and nothing to do with 
in kernel i/o interfaces).

> 
> btw, I don't see why there are so many API doing the same thing, I think
> for the goodness of linux it would be nice to standardize and recommend
> one of these user API so new software will use the API we recommend now,
> rather than choosing almost randomly every time. So the rest will be
> backwards compatibilty stuff for apps ported from other OS, and it will
> be worthwhile to have the kernel API to match what we recommend as user
> API.

Since you are analysing this stuff I wonder if you have by any 
chance looked through the aio design notes I had posted a while back.
I did try to discuss the background in terms of completion apis used
elsewhere even though I didn't record the specific details of those
interfaces. Am appending that section of the doc below.

Regards
Suparna

-------------------------------------------


2.5 Completion/Readiness notification:

Comment: Readiness notification can be treated as a completion of an 
asynchonous operation to await readiness.

POSIX aio provides for waiting for completion of a particular request, or
for an array of requests, either by means of polling, or asynchronously
through signals. On some operating systems, there is a notion
of an I/O Completion port (IOCP), which provides a flexible and scalable way
of grouping completion events. One can associate multiple file descriptors 
with such a completion port, so that all completion events for requests on
those files are sent to the completion port. The application can thus issue
a wait on the completion port in order to get notified of any completion
event for that group. The level of concurrency can be increased simply by
increasing the number of threads waiting on the completion port. There are
also certain additional concurrency control features that can be associated
with IOCPs (as on NT), where the system decides how many threads to 
wakeup when completion events occur, depending on the concurrency limits
set for the queue, and the actual number of runnable threads at that moment.
Keeping the number of runnable threads constant in this manner protects 
against blocking due to page faults and other operations that cannot be 
performed asynchronously.

On a similar note, the DAFS api spec incorportes completion groups for 
handling async i/o completion, the design being motivated by VI completion 
queues, NT IOCPs and the Solaris aiowait interfaces. Association of an 
i/o with a completion group (NULL would imply the default completion queue) 
happens at the time of i/o submission which lets the provider know where 
to place the event when it completes, contrary to aio_suspend style interface 
which specifies the grouping only when waiting on completion.

This implementation for Linux makes use a similar notion to provide
support for completion queues. There are api's to setup and destroy such
completion queues, specifying the maximum queue lengths that a queue is
configured for. Every asynchronous i/o request is associated with a completion 
queue when it is submitted (like the DAFS interfaces), and an application 
can issue a wait on a given queue to be notified of a completion event for 
any request associated with that queue.

BSD kqueue (Jonathan Lemon) provides a very generic method for registering 
for and handling notification of events or conditions based on the concept
of filters of different types. This covers a wide range of conditions 
including file/socket readiness notification (as in poll), directory/file
(vnode) change notifications, process create/exit/stop notifications, signal
notification, timer notification and also aio completion notification
(via SIGEV_EVENT). The kqueue is equivalent to a completion queue, and 
the interface allows one to both register for events and wait for (and
pick up) any events on the queue within the same call. It is rather flexible
in terms of providing for various kinds of event registration/notification 
requirements, e.g oneshot or everytime, temporary disabling, clearing 
state if transitions need to be notifiied, and it supports both edge and 
level triggered types of filters.

2.5.1 Some Requirements which are addressed:

1. Efficient for large numbers of events and connections
- The interface to register events to wait for should be separate from 
  the interface used to actually poll/wait for the registered events to 
  complete (unlike traditional poll/select), so that registrations can 
  hold across multiple poll waits with minimum user-kernel transfers.
  (It is better to handle this at interface definition level than 
   through some kind of an internal poll cache)

  The i/o submission routine takes a completion queue as a parameter,
  which associates/registers the events with a given completion group/queue. 
  The application can issue multiple waits on the completion queue using a 
  separate interface.

- Ability to reap many events together (unlike current sigtimedwait
  and sigwaitinfo interfaces)

  The interface used to wait for and retrieve events, can return an
  array of completed events rather than just a single event.

- Scalable/tunable queue limits - at least have a limit per queue rather
  than system wide limits

  Queue limits can be specified when creating a completion group.
  TBD: A control interface for changing queue parameters/limits (e.g
  io_queue_grow) might be useful

- Room for more flexible/tunable wakeup semantics for better concurrency
  control

  Since the core event queue can be separated from the notification mechanism, 
  the design allows one to provide for alternative wakeup semantics
  to optimize concurrency and reduce redundant or under-utilized context
  switches. Implementing these might require some additional parameters or
  interfaces to be defined. BTW, it is desirable to provide a unified interface
  for notification and event retrieval to a caller, to avoid synchronization
  complexities, even if the core policies are separable underneath in-kernel.

  [See the discussion in Sec 2.6 on wakeup policies for a more
  detailed discussion on this]

2. Enable flexible grouping of operations 	
- Flexible grouping at the time of i/o submission 
  (different operations on the same fd can belong to different groups,
  operations on different fds can belong to the same group)

- Ability to wait for at least a specified number of operations from 
  a specified group to complete (at least N vs at least 1 helps with 
  batching on the way up, so that the application can perform its post
  processing activities in a batch, without redundant context switches)

  The DAFS api supports such a notion, both in its cg_batch_wait interface
  which returns when either N events have completed, or with less than N
  events in case of a timeout, and also in the form of a num_completions 
  hint at the time of i/o submission. The latter is a hint that gets sent
  out to the server as a characteristic of the completion queue or session,
  so the server can use this hint to batch its responses accordingly.
  Knowing that the caller is interested only in batch completions helps
  with appropriate optimizations.

  Note: The Linux aio implementation today only supports "at least one" 
  and not "at least N" (e.g the aio_nwait interface on AIX). 

  The tradeoffs between responsiveness and fairness issues tend to 
  to get amplified when considering "at least N" type of semantics, 
  and this is one of the main concerns in supporting it. 
  [See discussion on wakeup policies later]

- Support dynamic additions to the group rather than a static or one time
  list passed through a single call 

  Multiple i/o submissions can specify the same completion group, enabling
  events to be added to the group.

  [Question: Is the option of the completion group being different from the 
  submission batch/group (i.e. per iocb grouping field) useful to have ?
  Like POSIX using sigevent as part of iocb]

3. Should also be able to wait for a specific operation to complete (without
   being very inefficient about it)

  One could either have low overhead group setup/teardown so such an operation 
  may be assigned a group of its own (costs can be amortized across multiple
  such operations by reusing the same group if possible) or provide an 
  interface to wait for a specific operation to complete.

  The latter would be more useful, though it requires a per-request wait queue 
  or something similar. The current implementation has a syscall interface 
  defined for this (io_wait), which hasn't been coded up as yet. The plan is 
  to use hashed wait queues to conserve on space. 

  There are also some semantics issues in terms of possibilities of another
  waiter on the queue picking up the corresponding completion event for this
  operation. To address this, the io_wait interface might be modified to
  include an argument for the returned event.

  BTW, there is an option of dealing with this using the group primitives 
  either in user space, or even in kernel by waiting in a loop for any event 
  in the group until the desired event occurs, but this could involve some 
  extra interim wakeups / context switches under the covers, and a user
  level event distribution mechanism for the other events picked up in the
  meantime.

4. Enable Flexible distribution of responsibility across multiple 
   threads/components

  Different threads can handle submission for different operations,
  and another pool of threads could wait on completion.
  The degree of concurrency can be improved simply by increasing threads
  in the pool that wait for and process completion of operations for 
  that group.

5. Support for Prioritized Event Delivery

   This involves the basic infrastructure to be able to accord higher
   priority to the delivery of certain completion events over others,
   (e.g. depending on the request priority settings of the corresponding 
   request), i.e. if multiple completion events have arrived on the
   queue, then the events for higher priorities should be picked up
   first by the application.  

