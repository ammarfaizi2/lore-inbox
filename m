Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWKGQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWKGQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbWKGQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:51:36 -0500
Received: from dea.vocord.ru ([217.67.177.50]:29607 "EHLO
	kano.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S965359AbWKGQv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:51:28 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: [take23 1/5] kevent: Description.
In-Reply-To: <11629182482886@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Tue, 7 Nov 2006 19:50:48 +0300
Message-Id: <1162918248891@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Description.

int kevent_ctl(int fd, unsigned int cmd, unsigned int num, struct ukevent *arg);

fd - is the file descriptor referring to the kevent queue to manipulate. 
It is created by opening "/dev/kevent" char device, which is created with dynamic 
minor number and major number assigned for misc devices. 

cmd - is the requested operation. It can be one of the following:
    KEVENT_CTL_ADD - add event notification 
    KEVENT_CTL_REMOVE - remove event notification 
    KEVENT_CTL_MODIFY - modify existing notification 

num - number of struct ukevent in the array pointed to by arg 
arg - array of struct ukevent

When called, kevent_ctl will carry out the operation specified in the cmd parameter.
-------------------------------------------------------------------------------------

 int kevent_get_events(int ctl_fd, unsigned int min_nr, unsigned int max_nr, __u64 timeout, struct ukevent *buf, unsigned flags)

ctl_fd - file descriptor referring to the kevent queue 
min_nr - minimum number of completed events that kevent_get_events will block waiting for 
max_nr - number of struct ukevent in buf 
timeout - number of nanoseconds to wait before returning less than min_nr events. 
	If this is -1, then wait forever. 
buf - pointer to an array of struct ukevent. 
flags - unused 

kevent_get_events will wait timeout milliseconds for at least min_nr completed events, 
copying completed struct ukevents to buf and deleting any KEVENT_REQ_ONESHOT event requests. 
In nonblocking mode it returns as many events as possible, but not more than max_nr. 
In blocking mode it waits until timeout or if at least min_nr events are ready.
-------------------------------------------------------------------------------------

 int kevent_wait(int ctl_fd, unsigned int num, __u64 timeout)

ctl_fd - file descriptor referring to the kevent queue 
num - number of processed kevents 
timeout - this timeout specifies number of nanoseconds to wait until there is free space in kevent queue 

This syscall waits until either timeout expires or at least one event becomes ready. 
It also copies that num events into special ring buffer and requeues them (or removes depending on flags). 
-------------------------------------------------------------------------------------

 int kevent_ring_init(int ctl_fd, struct kevent_ring *ring, unsigned int num)

ctl_fd - file descriptor referring to the kevent queue 
num - size of the ring buffer in events 

 struct kevent_ring
 {
   unsigned int ring_kidx;
   struct ukevent event[0];
 }

ring_kidx - is an index in the ring buffer where kernel will put new events when 
  kevent_wait() or kevent_get_events() is called 

Example userspace code (ring_buffer.c) can be found on project's homepage.

Each kevent syscall can be so called cancellation point in glibc, i.e. when thread has 
been cancelled in kevent syscall, thread can be safely removed and no events will be lost, 
since each syscall (kevent_wait() or kevent_get_events()) will copy event into special ring buffer, 
accessible from other threads or even processes (if shared memory is used).

When kevent is removed (not dequeued when it is ready, but just removed), even if it was ready, 
it is not copied into ring buffer, since if it is removed, no one cares about it (otherwise user 
would wait until it becomes ready and got it through usual way using kevent_get_events() or kevent_wait()) 
and thus no need to copy it to the ring buffer.

It is possible with userspace ring buffer, that events in the ring buffer can be replaced without knowledge 
for the thread currently reading them (when other thread calls kevent_get_events() or kevent_wait()), 
so appropriate locking between threads or processes, which can simultaneously access the same ring buffer, 
is required.
-------------------------------------------------------------------------------------

The bulk of the interface is entirely done through the ukevent struct. 
It is used to add event requests, modify existing event requests, 
specify which event requests to remove, and return completed events.

struct ukevent contains the following members:

struct kevent_id id
    Id of this request, e.g. socket number, file descriptor and so on 
__u32 type
    Event type, e.g. KEVENT_SOCK, KEVENT_INODE, KEVENT_TIMER and so on 
__u32 event
    Event itself, e.g. SOCK_ACCEPT, INODE_CREATED, TIMER_FIRED 
__u32 req_flags
    Per-event request flags,

    KEVENT_REQ_ONESHOT
        event will be removed when it is ready 

    KEVENT_REQ_WAKEUP_ONE
        When several threads wait on the same kevent queue and requested the same event, 
	for example 'wake me up when new client has connected, so I could call accept()', 
	then all threads will be awakened when new client has connected, but only one of 
	them can process the data. This problem is known as thundering nerd problem. 
	Events which have this flag set will not be marked as ready (and appropriate threads 
	will not be awakened) if at least one event has been already marked. 

    KEVENT_REQ_ET
        Edge Triggered behaviour. It is an optimisation which allows to move ready and dequeued 
	(i.e. copied to userspace) event to move into set of interest for given storage (socket, 
	inode and so on) again. It is very usefull for cases when the same event should be used 
	many times (like reading from pipe). It is similar to epoll()'s EPOLLET flag. 

__u32 ret_flags
    Per-event return flags

    KEVENT_RET_BROKEN
        Kevent is broken 

    KEVENT_RET_DONE
        Kevent processing was finished successfully 

    KEVENT_RET_COPY_FAILED
        Kevent was not copied into ring buffer due to some error conditions. 

__u32 ret_data
    Event return data. Event originator fills it with anything it likes (for example 
    timer notifications put number of milliseconds when timer has fired 
union { __u32 user[2]; void *ptr; }
    User's data. It is not used, just copied to/from user. The whole structure is aligned 
    to 8 bytes already, so the last union is aligned properly. 

---------------------------------------------------------------------------------

Usage

For KEVENT_CTL_ADD, all fields relevant to the event type must be filled 
(id, type, possibly event, req_flags). After kevent_ctl(..., KEVENT_CTL_ADD, ...) 
returns each struct's ret_flags should be checked to see if the event is already broken or done.

For KEVENT_CTL_MODIFY, the id, req_flags, and user and event fields must be set and an 
existing kevent request must have matching id and user fields. If a match is found, 
req_flags and event are replaced with the newly supplied values and requeueing is started, 
so modified kevent can be checked and probably marked as ready immediately. If a match can't
be found, the passed in ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is always set.

For KEVENT_CTL_REMOVE, the id and user fields must be set and an existing kevent request must 
have matching id and user fields. If a match is found, the kevent request is removed. 
If a match can't be found, the passed in ukevent's ret_flags has KEVENT_RET_BROKEN set. 
KEVENT_RET_DONE is always set.

For kevent_get_events, the entire structure is returned.

---------------------------------------------------------------------------------

Usage cases

kevent_timer
struct ukevent should contain following fields:
    type - KEVENT_TIMER 
    event - KEVENT_TIMER_FIRED 
    req_flags - KEVENT_REQ_ONESHOT if you want to fire that timer only once 
    id.raw[0] - number of seconds after commit when this timer shout expire 
    id.raw[0] - additional to number of seconds number of nanoseconds 


