Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWHWBg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHWBg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 21:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWHWBg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 21:36:27 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:32967 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932244AbWHWBgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 21:36:25 -0400
Subject: The Proposed Linux kevent API (was: Re: [take12 0/3] kevent:
	Generic event handling mechanism.)
From: Nicholas Miell <nmiell@comcast.net>
To: David Miller <davem@davemloft.net>
Cc: rdunlap@xenotime.net, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060822.160618.130612620.davem@davemloft.net>
References: <1156281182.2476.63.camel@entropy>
	 <20060822143747.68acaf99.rdunlap@xenotime.net>
	 <1156287492.2476.134.camel@entropy>
	 <20060822.160618.130612620.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 18:36:07 -0700
Message-Id: <1156296967.2476.200.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 16:06 -0700, David Miller wrote:
> With the time you spent writing this long email alone you could have
> worked on either documenting Evgeniy's interfaces or trying to write
> test applications against kevent to validate how useful the interfaces
> are and if there are any problems with them.
> 
> You choose to rant and complain instead of participate.
> 
> Therefore, many of us cannot take you seriously. 

== The Proposed Linux kevent API == 

The proposed Linux kevent API is a new unified event handling
interface, similar in spirit to Windows completion ports and Solaris
completion ports and similar in fact to the FreeBSD/OS X kqueue
interface.

Using a single kernel call, a thread can wait for all possible event
types that the kernel can generate, instead of past interfaces that
only allow you to wait for specific subsets of events (e.g. POSIX
sigevent completions are limited only to AIO completion, timer expiry,
and the arrival of new messages to a message queue, while epoll_wait
is just a more efficient method of doing a traditional Unix select or
poll).

Instead of evolving the struct sigevent notification methods to allow
you to continue using standard POSIX interfaces like lio_listio(),
mq_notify() or timer_create() while queuing completion notifications
to a kevent completion queue (much the way the Solaris port API is
designed, or the the API proposed by Ulrich Drepper in "The
Need for Asynchronous, Zero-Copy Network I/O" as found at
http://people.redhat.com/drepper/newni.pdf ), kevent choooses to
follow the FreeBSD route and introduce an entirely new and
incompatible method of requesting and reporting event notifications
(while also managing to be incompatible with FreeBSD's kqueue).

This is done through the introduction of two new syscalls and a
variety of supporting datatypes. The first function, kevent_ctl(), is
used to create and manipulate kevent queues, while the second,
kevent_get_events(), is use to wait for new events.


They operate as follows:

int kevent_ctl(int fd, unsigned int cmd, unsigned int num, void *arg);

fd is the file descriptor referring to the kevent queue to
manipulate. It is ignored if the cmd parameter is KEVENT_CTL_INIT.

cmd is the requested operation. It can be one of the following:

	KEVENT_CTL_INIT - create a new kevent queue and return it's file
		descriptor. The fd, num, and arg parameters are ignored.

	KEVENT_CTL_ADD, KEVENT_CTL_MODIFY, KEVENT_CTL_REMOVE - add new,
		modify existing, or remove existing event notification
		requests.

num is the number of struct ukevent in the array pointed to by arg

arg is an array of struct ukevent. Why it is of type void* and not 
	struct ukevent* is a mystery.

When called, kevent_ctl will carry out the operation specified in the
cmd parameter.


int kevent_get_events(int ctl_fd, unsigned int min_nr,
		unsigned int max_nr, unsigned int timeout,
		void *buf, unsigned flags)

ctl_fd is the file descriptor referring to the kevent queue.

min_nr is the minimum number of completed events that
       kevent_get_events will block waiting for.

max_nr is the number of struct ukevent in buf.

timeout is the number of milliseconds to wait before returning less
	than min_nr events. If this is -1, I *think* it'll wait
	indefinitely, but I'm not sure that msecs_to_jiffies(-1) ends
	up being MAX_SCHEDULE_TIMEOUT

buf is a pointer an array of struct ukevent. Why it is of type void*
    and not struct ukevent* is a mystery.

flags is unused.

When called, kevent_get_events will wait timeout milliseconds for at
least min_nr completed events, copying completed struct ukevents to
buf and deleting any KEVENT_REQ_ONESHOT event requests.


The bulk of the interface is entirely done through the ukevent struct.
It is used to add event requests, modify existing event requests,
specify which event requests to remove, and return completed events.

struct ukevent contains the following members:

struct kevent_id id
       This is described as containing the "socket number, file
       descriptor and so on", which I take to mean it contains an fd,
       however for some mysterious reason struct kevent_id contains
       __u32 raw[2] and (for KEVENT_POLL events) the actual fd is
       placed in raw[0] and raw[1] is never mentioned except to
       faithfully copy it around.

       For KEVENT_TIMER events, raw[0] contains a relative time in
       milliseconds and raw[1] is still not used.

       Why the struct member is called "raw" remains a mystery.

__u32 type
      The actual event type, either KEVENT_POLL for fd polling or
      KEVENT_TIMER for timers.

__u32 event
      For events of type KEVENT_POLL, event contains the polling flags
      of interest (i.e. POLLIN, POLLPRI, POLLOUT, POLLERR, POLLHUP,
      POLLNVAL).

      For events of type KEVENT_TIMER, event is ignored.

__u32 req_flags
      Per-event request flags. Currently, this may be 0 or
      KEVENT_REQ_ONESHOT to specify that the event be removed after it
      is fired.

__u32 ret_flags
      Per-event return flags. This may be 0 or a combination of
      KEVENT_RET_DONE if the event has completed or
      KVENT_RET_BROKEN if "the event is broken", which I take to mean
      any sort of error condition. DONE|BROKEN is a valid state, but I
      don't really know what it means.

__u32 ret_data[2]
      Event return data. This is unused by KEVENT_POLL events, while
      KEVENT_TIMER inexplicably places jiffies in ret_data[0]. If the
      event is broken, an error code is placed in ret_data[1].

union { __u32 user[2]; void *ptr; }
      An anonymous union (which is a fairly recent C addition)
      containing data saved for the user and otherwise ignored by the
      kernel.

For KEVENT_CTL_ADD, all fields relevant to the event type must be
filled (id, type, possibly event, req_flags). After kevent_ctl(...,
KEVENT_CTL_ADD, ...) returns each struct's ret_flags should be
checked to see if the event is already broken or done.

For KEVENT_CTL_MODIFY, the id, req_flags, and user and event fields
must be set and an existing kevent request must have matching id and
user fields. If a match is found, req_flags and event are replaced
with the newly supplied values. If a match can't be found, the passed
in ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is
always set.

For KEVENT_CTL_REMOVE, the id and user fields must be set and an
existing kevent request must have matching id and user fields. If a
match is found, the kevent request is removed. If a match can't be
found, the passed in ukevent's ret_flags has KEVENT_RET_BROKEN
set. KEVENT_RET_DONE is always set.

For kevent_get_events, the entire structure is returned with ret_data[0]
modified to contain jiffies for KEVENT_TIMER events.

--

Having looked all this over to figure out what it actually does, I can
make the following comments:

- there's a distinct lack of any sort of commenting beyond brief
descriptions of what the occasional function is supposed to do

- the kevent interface is all the horror of the BSD kqueue interface,
but with no compatibility with the BSD kqueue interface.

- lots of parameters from userspace go unsanitized, although I'm not
sure if this will actually cause problems. At the very least, there
should be checks for unknown flags and use of reserved fields, lest
somebody start using them for their own purposes and then their app
breaks when a newer version of the kernel starts using them itself.

- timeouts are specified as int instead of struct timespec.

- kevent_ctl() and kevent_get_events() take void* for no discernible
reason.

- KEVENT_POLL is less functional than epoll (no return of which events
were actually signalled) and KEVENT_TIMER isn't as flexible as POSIX
interval timers (no clocks, only millisecond resolution, timers don't
have separate start and interval values).

- kevent_get_events() looks a whole lot like io_getevents() and a kevent
fd looks a whole lot like an io_context_t.

- struct ukevent has problems/inconsistencies -- id is wrapped in it's
own member struct, while user and ret_data aren't; id's single member is
named raw which does nothing to describe it's purpose; the user data is
an anonymous union, which is C99 only and might not be widely supported,
req_flags and ret_flags are more difficult to visually distinguish than
they have to be; and every member name could use a ukev_ prefix.

--

P.S.

Dear DaveM,

	Go fuck yourself.

Love,
	Nicholas

-- 
Nicholas Miell <nmiell@comcast.net>

