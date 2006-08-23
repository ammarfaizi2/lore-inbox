Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWHWGZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHWGZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWHWGZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:25:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27115 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932359AbWHWGZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:25:10 -0400
Date: Wed, 23 Aug 2006 10:22:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nicholas Miell <nmiell@comcast.net>
Cc: David Miller <davem@davemloft.net>, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: The Proposed Linux kevent API (was: Re: [take12 0/3] kevent: Generic event handling mechanism.)
Message-ID: <20060823062207.GA24787@2ka.mipt.ru>
References: <1156281182.2476.63.camel@entropy> <20060822143747.68acaf99.rdunlap@xenotime.net> <1156287492.2476.134.camel@entropy> <20060822.160618.130612620.davem@davemloft.net> <1156296967.2476.200.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156296967.2476.200.camel@entropy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 10:22:13 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:36:07PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> == The Proposed Linux kevent API == 
> 
> The proposed Linux kevent API is a new unified event handling
> interface, similar in spirit to Windows completion ports and Solaris
> completion ports and similar in fact to the FreeBSD/OS X kqueue
> interface.
> 
> Using a single kernel call, a thread can wait for all possible event
> types that the kernel can generate, instead of past interfaces that
> only allow you to wait for specific subsets of events (e.g. POSIX
> sigevent completions are limited only to AIO completion, timer expiry,
> and the arrival of new messages to a message queue, while epoll_wait
> is just a more efficient method of doing a traditional Unix select or
> poll).
> 
> Instead of evolving the struct sigevent notification methods to allow
> you to continue using standard POSIX interfaces like lio_listio(),
> mq_notify() or timer_create() while queuing completion notifications
> to a kevent completion queue (much the way the Solaris port API is
> designed, or the the API proposed by Ulrich Drepper in "The
> Need for Asynchronous, Zero-Copy Network I/O" as found at
> http://people.redhat.com/drepper/newni.pdf ), kevent choooses to
> follow the FreeBSD route and introduce an entirely new and
> incompatible method of requesting and reporting event notifications
> (while also managing to be incompatible with FreeBSD's kqueue).
> 
> This is done through the introduction of two new syscalls and a
> variety of supporting datatypes. The first function, kevent_ctl(), is
> used to create and manipulate kevent queues, while the second,
> kevent_get_events(), is use to wait for new events.
> 
> 
> They operate as follows:
> 
> int kevent_ctl(int fd, unsigned int cmd, unsigned int num, void *arg);
> 
> fd is the file descriptor referring to the kevent queue to
> manipulate. It is ignored if the cmd parameter is KEVENT_CTL_INIT.
> 
> cmd is the requested operation. It can be one of the following:
> 
> 	KEVENT_CTL_INIT - create a new kevent queue and return it's file
> 		descriptor. The fd, num, and arg parameters are ignored.
> 
> 	KEVENT_CTL_ADD, KEVENT_CTL_MODIFY, KEVENT_CTL_REMOVE - add new,
> 		modify existing, or remove existing event notification
> 		requests.
> 
> num is the number of struct ukevent in the array pointed to by arg
> 
> arg is an array of struct ukevent. Why it is of type void* and not 
> 	struct ukevent* is a mystery.
> 
> When called, kevent_ctl will carry out the operation specified in the
> cmd parameter.
> 
> 
> int kevent_get_events(int ctl_fd, unsigned int min_nr,
> 		unsigned int max_nr, unsigned int timeout,
> 		void *buf, unsigned flags)
> 
> ctl_fd is the file descriptor referring to the kevent queue.
> 
> min_nr is the minimum number of completed events that
>        kevent_get_events will block waiting for.
> 
> max_nr is the number of struct ukevent in buf.
> 
> timeout is the number of milliseconds to wait before returning less
> 	than min_nr events. If this is -1, I *think* it'll wait
> 	indefinitely, but I'm not sure that msecs_to_jiffies(-1) ends
> 	up being MAX_SCHEDULE_TIMEOUT

You forget the case for non-blocked file descriptor.
Here is comment from the code:

 * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
 * In blocking mode it waits until timeout or if at least @min_nr events are ready.

> buf is a pointer an array of struct ukevent. Why it is of type void*
>     and not struct ukevent* is a mystery.
> 
> flags is unused.
> 
> When called, kevent_get_events will wait timeout milliseconds for at
> least min_nr completed events, copying completed struct ukevents to
> buf and deleting any KEVENT_REQ_ONESHOT event requests.
> 
> 
> The bulk of the interface is entirely done through the ukevent struct.
> It is used to add event requests, modify existing event requests,
> specify which event requests to remove, and return completed events.
> 
> struct ukevent contains the following members:
> 
> struct kevent_id id
>        This is described as containing the "socket number, file
>        descriptor and so on", which I take to mean it contains an fd,
>        however for some mysterious reason struct kevent_id contains
>        __u32 raw[2] and (for KEVENT_POLL events) the actual fd is
>        placed in raw[0] and raw[1] is never mentioned except to
>        faithfully copy it around.
> 
>        For KEVENT_TIMER events, raw[0] contains a relative time in
>        milliseconds and raw[1] is still not used.
> 
>        Why the struct member is called "raw" remains a mystery.

If you followed previous patchsets you could find, that there were
network AIO, fs IO and fs-inotify-like notifications.
Some of them use that fields.
I got two u32 numbers to be "union"ed with pointer like user data is.
That pointer should be obtained through Ulrich's dma_alloc() and
friends.

> __u32 type
>       The actual event type, either KEVENT_POLL for fd polling or
>       KEVENT_TIMER for timers.
> 
> __u32 event
>       For events of type KEVENT_POLL, event contains the polling flags
>       of interest (i.e. POLLIN, POLLPRI, POLLOUT, POLLERR, POLLHUP,
>       POLLNVAL).
> 
>       For events of type KEVENT_TIMER, event is ignored.
> 
> __u32 req_flags
>       Per-event request flags. Currently, this may be 0 or
>       KEVENT_REQ_ONESHOT to specify that the event be removed after it
>       is fired.
> 
> __u32 ret_flags
>       Per-event return flags. This may be 0 or a combination of
>       KEVENT_RET_DONE if the event has completed or
>       KVENT_RET_BROKEN if "the event is broken", which I take to mean
>       any sort of error condition. DONE|BROKEN is a valid state, but I
>       don't really know what it means.

DONE means that event processing is completed and it can be read back to
userspace, if in addition it contains BROKEN it means that kevent is
broken.

> __u32 ret_data[2]
>       Event return data. This is unused by KEVENT_POLL events, while
>       KEVENT_TIMER inexplicably places jiffies in ret_data[0]. If the
>       event is broken, an error code is placed in ret_data[1].

Each kevent user can place here any hints it wants, for example network
socket notifications place there length of the accept queue and so on.
In error condition error is placed there too.

> union { __u32 user[2]; void *ptr; }
>       An anonymous union (which is a fairly recent C addition)
>       containing data saved for the user and otherwise ignored by the
>       kernel.
> 
> For KEVENT_CTL_ADD, all fields relevant to the event type must be
> filled (id, type, possibly event, req_flags). After kevent_ctl(...,
> KEVENT_CTL_ADD, ...) returns each struct's ret_flags should be
> checked to see if the event is already broken or done.
> 
> For KEVENT_CTL_MODIFY, the id, req_flags, and user and event fields
> must be set and an existing kevent request must have matching id and
> user fields. If a match is found, req_flags and event are replaced
> with the newly supplied values. If a match can't be found, the passed
> in ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is
> always set.

DONE means that user's request is completed.
I.e. it was copied from userspace, watched, analyzed and somehow
processed.

> For KEVENT_CTL_REMOVE, the id and user fields must be set and an
> existing kevent request must have matching id and user fields. If a
> match is found, the kevent request is removed. If a match can't be
> found, the passed in ukevent's ret_flags has KEVENT_RET_BROKEN
> set. KEVENT_RET_DONE is always set.
> 
> For kevent_get_events, the entire structure is returned with ret_data[0]
> modified to contain jiffies for KEVENT_TIMER events.

ret_data can contain any hint kernel wants to put there.
It can contain 0.

> --
> 
> Having looked all this over to figure out what it actually does, I can
> make the following comments:
> 
> - there's a distinct lack of any sort of commenting beyond brief
> descriptions of what the occasional function is supposed to do
> 
> - the kevent interface is all the horror of the BSD kqueue interface,
> but with no compatibility with the BSD kqueue interface.
> 
> - lots of parameters from userspace go unsanitized, although I'm not
> sure if this will actually cause problems. At the very least, there
> should be checks for unknown flags and use of reserved fields, lest
> somebody start using them for their own purposes and then their app
> breaks when a newer version of the kernel starts using them itself.

All parameters which are not checked are not used.
If user puts own flags where it is not allowed it to do (like ret_flags)
he creates problems for himself. No one complains when arbitrary number
is placed into file dsecriptor and write() fails.

> - timeouts are specified as int instead of struct timespec.

timespec uses long, which is wrong.
I can put there any other structure which has strict types - no longs,
that's the rule, no matter if there is a wrappers in per-arch syscall
code.
poll alwasy ued millisecods and all are happy.

> - kevent_ctl() and kevent_get_events() take void* for no discernible
> reason.

Because interfaces are changed - they used contorl block before, and now
they do not. There is an opinion from Cristoph that syscall there is
wrong too and better to use ioctls(), so I do not change it right now,
since it can be changed in future (again).

> - KEVENT_POLL is less functional than epoll (no return of which events
> were actually signalled) and KEVENT_TIMER isn't as flexible as POSIX
> interval timers (no clocks, only millisecond resolution, timers don't
> have separate start and interval values).

That's nonsence - kevent returns fired events, POSIX timer API can only
use timers. When you can put network AIO into timer API call me, I will
buy your a t-shrt.
Your meaning of "separate start and interval values" is not correct,
please see how both timers work.

The only thing correct is that it only support millisecond resolution -
I use poll quite for a while and it is really good interface, so it was
copied from there.

> - kevent_get_events() looks a whole lot like io_getevents() and a kevent
> fd looks a whole lot like an io_context_t.
> 
> - struct ukevent has problems/inconsistencies -- id is wrapped in it's
> own member struct, while user and ret_data aren't; id's single member is
> named raw which does nothing to describe it's purpose; the user data is
> an anonymous union, which is C99 only and might not be widely supported,
> req_flags and ret_flags are more difficult to visually distinguish than
> they have to be; and every member name could use a ukev_ prefix.

I described what id is and why it is placed into u32[2] - it must be
union'ed with pointer, when such interface will be created.
How can you describe id for inode notification and user pointer?

As you can see there are no problems with understanding how it works -
I'm sure it has not took you too much time, I think writing previous
messages took much longer.

Now my point:
1. unified interface - since there are many types of different event
mechanisms (already implemented, but not theoretical handwaving), I
created unified interface, which does not know about what the event is
provided, it just routes it into appropriate storage and start
processing. Anyone who thinks that kevents must have separate interface
for each type of events just do not see, how many types there are.
It is simple to wrap it into epoll and POSIX timers, but there are quite
a few others - inotify, socket notifications, various AIO
implementatinos. Who will create new API for them?
If you think that kevents are going to be used through wrapper library -
implement there any interface you like. If you do not, consider how many
syscalls are required, and finally the same function will be called.

2. Wrong documantation and examples.
For the last two weeks interface were changed at least three (!) times.
Do you really think that I have some slaves in the cellar?
When interface is ready I will write docs and change examples.
But even with old applicatinos, it is _really_ trivial to understand
what parameter is used and where, especially with excellent LWN
articles.


And actually I do not see that this process comes to it's end -

	NO FSCKING ONE knows what we want!

	So I will say as author what _I_ want.

Until there is strong objection on API, nothing will be changed.

Something will be changed only when there are several people who acks
the change.

This can end up with declining of merge - do not care, I hack not for 
the entry in MAINTAINERS, but because I like the process, 
and I can use it with external patches easily.

Nick, you want POSIX timers API? Ok, I can change it, if several core 
developers ack this. If they do not, I will not even discuss it.
You can implement it as addon, no problem.

Dixi.

> --
> 
> P.S.
> 
> Dear DaveM,
> 
> 	Go fuck yourself.
> 
> Love,
> 	Nicholas

In a decent society you would have your nose broken...
But in virtual one you just can not be considered as serious person.

> -- 
> Nicholas Miell <nmiell@comcast.net>

-- 
	Evgeniy Polyakov
