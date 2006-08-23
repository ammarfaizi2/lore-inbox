Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWHWICY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHWICY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHWICX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:02:23 -0400
Received: from alnrmhc12.comcast.net ([204.127.225.92]:46746 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751452AbWHWICV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:02:21 -0400
Subject: Re: The Proposed Linux kevent API (was: Re: [take12 0/3] kevent:
	Generic event handling mechanism.)
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
In-Reply-To: <20060823062207.GA24787@2ka.mipt.ru>
References: <1156281182.2476.63.camel@entropy>
	 <20060822143747.68acaf99.rdunlap@xenotime.net>
	 <1156287492.2476.134.camel@entropy>
	 <20060822.160618.130612620.davem@davemloft.net>
	 <1156296967.2476.200.camel@entropy>  <20060823062207.GA24787@2ka.mipt.ru>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 01:01:47 -0700
Message-Id: <1156320107.2476.269.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 10:22 +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 22, 2006 at 06:36:07PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > int kevent_get_events(int ctl_fd, unsigned int min_nr,
> > 		unsigned int max_nr, unsigned int timeout,
> > 		void *buf, unsigned flags)
> > 
> > ctl_fd is the file descriptor referring to the kevent queue.
> > 
> > min_nr is the minimum number of completed events that
> >        kevent_get_events will block waiting for.
> > 
> > max_nr is the number of struct ukevent in buf.
> > 
> > timeout is the number of milliseconds to wait before returning less
> > 	than min_nr events. If this is -1, I *think* it'll wait
> > 	indefinitely, but I'm not sure that msecs_to_jiffies(-1) ends
> > 	up being MAX_SCHEDULE_TIMEOUT
> 
> You forget the case for non-blocked file descriptor.
> Here is comment from the code:
> 
>  * In nonblocking mode it returns as many events as possible, but not more than @max_nr.
>  * In blocking mode it waits until timeout or if at least @min_nr events are ready.

I missed that, but why bother with O_NONBLOCK? It appears to to make the
timeout parameter completely unnecessary, which means you could just
make timeout = 0 give you the nonblocking behavior, and non-zero the
blocking behavior (leaving -1 as wait forever).

> > buf is a pointer an array of struct ukevent. Why it is of type void*
> >     and not struct ukevent* is a mystery.
> > 
> > flags is unused.
> > 
> > When called, kevent_get_events will wait timeout milliseconds for at
> > least min_nr completed events, copying completed struct ukevents to
> > buf and deleting any KEVENT_REQ_ONESHOT event requests.
> > 
> > 
> > The bulk of the interface is entirely done through the ukevent struct.
> > It is used to add event requests, modify existing event requests,
> > specify which event requests to remove, and return completed events.
> > 
> > struct ukevent contains the following members:
> > 
> > struct kevent_id id
> >        This is described as containing the "socket number, file
> >        descriptor and so on", which I take to mean it contains an fd,
> >        however for some mysterious reason struct kevent_id contains
> >        __u32 raw[2] and (for KEVENT_POLL events) the actual fd is
> >        placed in raw[0] and raw[1] is never mentioned except to
> >        faithfully copy it around.
> > 
> >        For KEVENT_TIMER events, raw[0] contains a relative time in
> >        milliseconds and raw[1] is still not used.
> > 
> >        Why the struct member is called "raw" remains a mystery.
> 
> If you followed previous patchsets you could find, that there were
> network AIO, fs IO and fs-inotify-like notifications.
> Some of them use that fields.
> I got two u32 numbers to be "union"ed with pointer like user data is.
> That pointer should be obtained through Ulrich's dma_alloc() and
> friends.
> 
> > __u32 type
> >       The actual event type, either KEVENT_POLL for fd polling or
> >       KEVENT_TIMER for timers.
> > 
> > __u32 event
> >       For events of type KEVENT_POLL, event contains the polling flags
> >       of interest (i.e. POLLIN, POLLPRI, POLLOUT, POLLERR, POLLHUP,
> >       POLLNVAL).
> > 
> >       For events of type KEVENT_TIMER, event is ignored.
> > 
> > __u32 req_flags
> >       Per-event request flags. Currently, this may be 0 or
> >       KEVENT_REQ_ONESHOT to specify that the event be removed after it
> >       is fired.
> > 
> > __u32 ret_flags
> >       Per-event return flags. This may be 0 or a combination of
> >       KEVENT_RET_DONE if the event has completed or
> >       KVENT_RET_BROKEN if "the event is broken", which I take to mean
> >       any sort of error condition. DONE|BROKEN is a valid state, but I
> >       don't really know what it means.
> 
> DONE means that event processing is completed and it can be read back to
> userspace, if in addition it contains BROKEN it means that kevent is
> broken.

So KEVENT_RET_DONE is purely an internal thing? And what does
KEVENT_RET_BROKEN mean, exactly?

> > __u32 ret_data[2]
> >       Event return data. This is unused by KEVENT_POLL events, while
> >       KEVENT_TIMER inexplicably places jiffies in ret_data[0]. If the
> >       event is broken, an error code is placed in ret_data[1].
> 
> Each kevent user can place here any hints it wants, for example network
> socket notifications place there length of the accept queue and so on.

I didn't document what it could theoretically be used for, just what it
is actually used for.

> In error condition error is placed there too.
> 
> > union { __u32 user[2]; void *ptr; }
> >       An anonymous union (which is a fairly recent C addition)
> >       containing data saved for the user and otherwise ignored by the
> >       kernel.
> > 
> > For KEVENT_CTL_ADD, all fields relevant to the event type must be
> > filled (id, type, possibly event, req_flags). After kevent_ctl(...,
> > KEVENT_CTL_ADD, ...) returns each struct's ret_flags should be
> > checked to see if the event is already broken or done.
> > 
> > For KEVENT_CTL_MODIFY, the id, req_flags, and user and event fields
> > must be set and an existing kevent request must have matching id and
> > user fields. If a match is found, req_flags and event are replaced
> > with the newly supplied values. If a match can't be found, the passed
> > in ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is
> > always set.
> 
> DONE means that user's request is completed.
> I.e. it was copied from userspace, watched, analyzed and somehow
> processed.

KEVENT_RET_DONE certainly looks like a purely internal flag, which
shouldn't be exported to userspace. (Except for it's usage with
KEVENT_CTL_ADD, I guess.)

> > For KEVENT_CTL_REMOVE, the id and user fields must be set and an
> > existing kevent request must have matching id and user fields. If a
> > match is found, the kevent request is removed. If a match can't be
> > found, the passed in ukevent's ret_flags has KEVENT_RET_BROKEN
> > set. KEVENT_RET_DONE is always set.
> > 
> > For kevent_get_events, the entire structure is returned with ret_data[0]
> > modified to contain jiffies for KEVENT_TIMER events.
> 
> ret_data can contain any hint kernel wants to put there.
> It can contain 0.

Again, I didn't document theoretical usage, just what's actually done.

> 
> > --
> > 
> > Having looked all this over to figure out what it actually does, I can
> > make the following comments:
> > 
> > - there's a distinct lack of any sort of commenting beyond brief
> > descriptions of what the occasional function is supposed to do
> > 
> > - the kevent interface is all the horror of the BSD kqueue interface,
> > but with no compatibility with the BSD kqueue interface.
> > 
> > - lots of parameters from userspace go unsanitized, although I'm not
> > sure if this will actually cause problems. At the very least, there
> > should be checks for unknown flags and use of reserved fields, lest
> > somebody start using them for their own purposes and then their app
> > breaks when a newer version of the kernel starts using them itself.
> 
> All parameters which are not checked are not used.

Not used currently.

> If user puts own flags where it is not allowed it to do (like ret_flags)
> he creates problems for himself. No one complains when arbitrary number
> is placed into file dsecriptor and write() fails.

So prevent the user from causing future problems -- reject all invalid
uses.

> > - timeouts are specified as int instead of struct timespec.
> 
> timespec uses long, which is wrong.
> I can put there any other structure which has strict types - no longs,
> that's the rule, no matter if there is a wrappers in per-arch syscall
> code.

I don't understand this -- you're saying that you can't use a long
because of compat tasks on 64-bit architectures?

> poll alwasy ued millisecods and all are happy.
> 
> > - kevent_ctl() and kevent_get_events() take void* for no discernible
> > reason.
> 
> Because interfaces are changed - they used contorl block before, and now
> they do not. There is an opinion from Cristoph that syscall there is
> wrong too and better to use ioctls(), so I do not change it right now,
> since it can be changed in future (again).

OK, that makes sense, but it still has to be fixed assuming this is the
final form of the interface.

> > - KEVENT_POLL is less functional than epoll (no return of which events
> > were actually signalled) and KEVENT_TIMER isn't as flexible as POSIX
> > interval timers (no clocks, only millisecond resolution, timers don't
> > have separate start and interval values).
> 
> That's nonsence - kevent returns fired events,

Yes, but why did the event fire? poll/epoll return the
POLLIN/POLLPRI/POLLOUT/POLLERR/etc. bitmask when they return events.

>  POSIX timer API can only
> use timers. When you can put network AIO into timer API call me, I will
> buy your a t-shrt.

I was talking about POSIX timers verses KEVENT_TIMER in isolation.
Ignoring the event delivery mechanism, POSIX timers are more capable
than kevent timers.

> Your meaning of "separate start and interval values" is not correct,
> please see how both timers work.

With POSIX timers, I can create a timer that starts periodically firing
itself at some point in the future, where the period isn't equal to the
different between now and it's first expiry (i.e. 10 seconds from now,
start firing every 2 seconds). I don't think I can do this using
KEVENT_TIMER.

> 
> The only thing correct is that it only support millisecond resolution -
> I use poll quite for a while and it is really good interface, so it was
> copied from there.
> 
> > - kevent_get_events() looks a whole lot like io_getevents() and a kevent
> > fd looks a whole lot like an io_context_t.
> > 
> > - struct ukevent has problems/inconsistencies -- id is wrapped in it's
> > own member struct, while user and ret_data aren't; id's single member is
> > named raw which does nothing to describe it's purpose; the user data is
> > an anonymous union, which is C99 only and might not be widely supported,
> > req_flags and ret_flags are more difficult to visually distinguish than
> > they have to be; and every member name could use a ukev_ prefix.
> 
> I described what id is and why it is placed into u32[2] - it must be
> union'ed with pointer, when such interface will be created.
> How can you describe id for inode notification and user pointer?
> 
> As you can see there are no problems with understanding how it works -
> I'm sure it has not took you too much time, I think writing previous
> messages took much longer.

The previous message which DaveM was kind enough to characterize as a
rant took 10 minutes. The kevent docs took ~2 hours. You're welcome.

> 
> Now my point:
> 1. unified interface - since there are many types of different event
> mechanisms (already implemented, but not theoretical handwaving), I
> created unified interface, which does not know about what the event is
> provided, it just routes it into appropriate storage and start
> processing. Anyone who thinks that kevents must have separate interface
> for each type of events just do not see, how many types there are.
> It is simple to wrap it into epoll and POSIX timers, but there are quite
> a few others - inotify, socket notifications, various AIO
> implementatinos. Who will create new API for them?

Ah, now there's your problem. The joy of this is that you don't have to
implement any of it. All you really need to do is implement the
userspace interface for creating kevent queues and dequeuing events and
the kernel interface for adding events to the queue and provide a
general enough event struct. (All you really need is the event type,
event specific data (a uintptr_t would probably be sufficient), and a
user cookie pointer)

Once you've done that, you can say "Hey, POSIX timers people, you should
make a way for people to queue timer completion events" and "Hey, AIO
people, you should make a way for people to queue AIO completion events"
and wait for them to do the work. (And if the AIO people complain that
they already have a way for people to queue AIO completions, well, then
you really need to justify why yours is better.)

In fact, I'm beginning to wonder if kevent_ctl() should exist at all --
it's only real use in this scenario would be for the odds-and-ends that
don't already have mechanisms for specifying how event completions
should be handled, in which case it becomes much more like
port_associate() and port_disassociate().

> If you think that kevents are going to be used through wrapper library -
> implement there any interface you like. If you do not, consider how many
> syscalls are required, and finally the same function will be called.
> 
> 2. Wrong documantation and examples.
> For the last two weeks interface were changed at least three (!) times.
> Do you really think that I have some slaves in the cellar?
> When interface is ready I will write docs and change examples.
> But even with old applicatinos, it is _really_ trivial to understand
> what parameter is used and where, especially with excellent LWN
> articles.

The LWN articles weren't really that excellent; more of a pair of
cursory overviews really. And yes, I'm pretty sure that it is understood
that you don't have infinite time to work on this.

> 
> And actually I do not see that this process comes to it's end -
> 
> 	NO FSCKING ONE knows what we want!
> 
> 	So I will say as author what _I_ want.
> 
> Until there is strong objection on API, nothing will be changed.
> 
> Something will be changed only when there are several people who acks
> the change.
> 
> This can end up with declining of merge - do not care, I hack not for 
> the entry in MAINTAINERS, but because I like the process, 
> and I can use it with external patches easily.
> 
> Nick, you want POSIX timers API? Ok, I can change it, if several core 
> developers ack this. If they do not, I will not even discuss it.
> You can implement it as addon, no problem.
> 
> Dixi.
> 
> > --
> > 
> > P.S.
> > 
> > Dear DaveM,
> > 
> > 	Go fuck yourself.
> > 
> > Love,
> > 	Nicholas
> 
> In a decent society you would have your nose broken...
> But in virtual one you just can not be considered as serious person.

I'm fairly certain DaveM is still the reigning champion of the
F-bomb-to-lines-of-kernel-code ratio, although I think Rusty may be
catching up. 

Wait, no, somebody in MIPS land (I think maybe Christoph Hellwig) really
really hates the IOC3 very very much.

-- 
Nicholas Miell <nmiell@comcast.net>

