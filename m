Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWH0VEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWH0VEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWH0VEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:04:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932253AbWH0VEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:04:10 -0400
Message-ID: <44F208A5.4050308@redhat.com>
Date: Sun, 27 Aug 2006 14:03:33 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
References: <11564996832717@2ka.mipt.ru>
In-Reply-To: <11564996832717@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig470DF4516765F2630A344119"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig470DF4516765F2630A344119
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Sorry for the length, but I want to be clear.]

As promised, before Monday (at least my time), here are my thoughts on
the proposed kevent interfaces.  Not necessarily well ordered:


- one point of critique which applied to many proposals over the years:
  multiplexer syscalls a bad, really bad.  They are more complicated
  to use at userlevel and in the kernel.  We've seen more than once that
  unimplemented functions are not reported correctly with ENOSYS.  Just
  use individual syscalls.  Adding them is cheap and probably overall
  less expensive than the multiplexer.



Events to wait for are basically all those with syscalls which can
potentially block indefinitely:

- file descriptor
- POSIX message queues (these are in fact file descriptors but
  let's make it legitimate)
- timer expiration
- signals (just as sigwait, not normal delivery instead of a handler)
- futexes (needs a lot more investigation)
- SysV message queues
- SysV semaphores
- bind socket operations (Alan brought this up in a different context)
- delays (nanosleep/clock_nanosleep, could be done using timers but the
  overhead would likely be too high)
- process state change (waitpid, wait4, waitid etc)
- file locking (flock, lockf)
-

We might also want to think about

- msync/fsync: Today's wait/no-wait option doesn't allow us to work on
  other things if the sync takes time and we need a real notification
  (i.e., if no-wait cannot be used)


The reporting must of course provide the userlevel code with enough
information to identify the request.  For submitting requests we need
such identification, too, so having unique identifiers for all the
different event types is necessary.  So some extend this is what the
KEVENT_TIMER_FIRED, KEVENT_SOCKET_RECV, etc constants do.  But they
should be more generic in their names since we need to use them also
when registering the even.  I.e., KEVENT_EVENT_TIMER or so is more
appropriate.

Often (most of the time) this ID and the actual descriptor (file
descriptor, message queue descriptor, signal number, etc) is not
sufficient.  In the POSIX API we therefore usually have a cookie value
which the userlevel code can provide and which is returned unchanged as
part of the notification.  See the sigev_value member of struct
sigevent.  I think this is the best approach: is compact and it gives
all the flexibility needed.  Userlevel code will store a value or more
often a pointer in the cookie and can then access additional information
based of the cookie.

I know there is a controversy around using pointer-sized values in
kernel structures which are exposed to userlevel.  It should be possible
to work around this.  We can simply always use 64-bit values and when
the data structure is exposed to 32-bit userland code only the first or
second 32-bit word of the structure is exposed with the name.  The other
word is padding.  If planned in from the beginning this should not cause
any problems at all.

Looking at the current struct mukevent, I don't think it is sufficient.
 We need more room for the various types of events.  And we shouldn't
prevent future innovative uses.  I suggest to create records of a fixed
size with sufficient room.  Maybe 32 bytes are sufficient but I'd leave
this open for can until the very end.  Members of the structure must be
- ID if the type of event; type int
- descriptor (file descriptor, SysV msg descriptors etc); type int
- user-provided cookie; type uint64_t
That's only 16 bytes so far but we'll likely need more for some uses.


Next, the current interfaces once again fail to learn from a mistake we
made and which got corrected for the other interfaces.  We need to be
able to change the signal mask around the delay atomically.  Just like
we have ppoll for poll, pselect for select (and hopefully soon also
epoll_pwait for epoll_wait) we need to have this feature in the new
interfaces.


I read the description Nicholas Miell produced (the example programs
aren't available, accessing the URL fails for me) and looked over the
last patch (take 14).

The biggest problem I see so far is the integration into the existing
interfaces.  kevent notification *really* should be usable as a new
sigevent type.  Whether the POSIX interfaces are liked by kernel folks
or not, they are what the majority of the userlevel programmers use.
The mechanism is easily extensible.  I've described this in my paper.  I
cannot comment on the complexity of the kernel side but I'd imagine it's
not much more difficult, just different from what is implemented now.
Let's learn for a change from the mistakes of the past.  The new and
innovative AIO interfaces never took off because their implementation
differs so much from the POSIX interfaces.  People are interested in
portable code.  So, please, let's introduce SIGEV_KEVENT.  Then we
magically get timer notification etc for free.


The ring buffer interface is not described in Nicholas' description.
I'm looking at the sources and am a bit baffled.  For instance, the
kevent_user_ring_add_event function simply adds an event without
determining whether this overwrites an undelivered entry.  One single
index into the buffer isn't sufficient for this anyway.  So let me ask
some questions:

- how is userlevel code supposed to locate events in the buffer?  We
  can maintain a separate pointer for the ring buffer (in a separate
  location, which might actually be good for CPU cache reasons).  But
  this cannot solve all problems.  E.g., if the read pointer is
  initialized to zero (as is the write pointer), the ring buffer fits N
  entries, if now N+1 entries arrive before the first event is handled
  by the userlevel code, how does the userland code know that all ring
  buffer entries are valid?  If the code supposed to always scan the
  entire buffer?

- we need to signal the ring buffer overflow in some form to the
  userlevel code.  What proposals have been made for this?  Signals
  are the old and tried mechanism.  I.e., one would be allowed to
  associate a signal with each kevent descriptor and receive overflow
  notifications this way.  When rt signals are used we event can get
  the kevent descriptor and the possible a user cookie delivered.
  Something like this is needed in case such a kevent queue is used
  in library code where we cannot rely on being the only user for an
  event.

I must admit I haven't spent too much time thinking about the ideal ring
buffer interface.  At OLS there were quite a few people (like Zach) who
said they did.  So, let's solicit advice.  I think the kernel AIO
interface can also provide some info on what not to do.


One aspect of the interface I did think about: the delay syscall.  I
already mentioned the signal mask issue above.  The interface already
has a timeout value (good!).  But we need to specify the semantics quite
detailed to avoid problems.

What I mean by that is the problem we are facing if there is more than
one thread waiting for events.  If no event is available all threads use
the delay syscall.  If now an event becomes available, what do we do?
Do we want exactly one thread?  This is a problem.  The thread might not
be working on the event after it gets woken (e.g., because the thread
gets canceled).  The result is that there is an event available and no
other thread gets woken.  This can be avoided by requiring that if a
thread, which got woken from a delay syscall, doesn't use the event, it
has to wake another thread.  But how do we do this?

One possibility I could see is that the delay syscall returns the event
which caused the thread to be woken.  This event is _not_ also reported
in the ring buffer.  Then, if the thread does not use the event, it
simply requeues it.  This will then implicitly wake another delayed threa=
d.

Which brings me to the second point about the current kevent_get_events
syscall.  I don't think the min_nr parameter is useful.  Probably we
should not even allow the kevent queue to be used with different max_nr
parameters in different thread.  If you'd allow this, how would the
event notification be handled?  A waiter with a smaller required number
of events would always be woken first.  I think the number of required
events should be a property of the kevent object.  Then the code would
create different kevent object if the requirement is different.  At the
very least I'd declare it an error if at any time there are two or more
threads delayed which have different requirements on the number of
events.  This could provide all the flexibility needed while preventing
some of the mistakes one can make.



In summary, I don't think we're at the point where the current
interfaces are usable.  I'd like to see them redesigned and
reimplemented.  The bad news is that I'll not be able to help with the
coding.  The somewhat good news is that I can given some more
recommendations.  In general I still think the text from my OLS paper
applies:


- one syscall to create a kevent queue.  Using a special filesystem like
  take 14 does is OK.  But who do you pass parameters like the maximum
  number of expected outstanding events?  I think a dedicated syscall is
  better.  It also works more reliably since /proc might not be yet
  mounted when the first user of the interface is started.  The result
  should be a file descriptor.  At least an object which can be handled
  like a file descriptor when it comes to transmitting it over Unix
  domain sockets.  Questions to answer: what happens if you use the
  descriptor with any other interface but the kevent interfaces (I think
  all such calls like dup, read, write, ... should fail).

  int kevent_init (int num);


- one system call to create the userlevel ring buffer.  Simply
  overloading the mmap operation for the special kevent filesystem can
  work so no separate syscall is needed in that case.  We need to
  nail down the semantics, though.  What happens if more than one mmap
  call is made?  Does only the last one count?  Does the second one
  fail?  Will mremap() work to increase/descrease the size?  Will
  mremap() be allowed to be called with MREMAP_MAYMOVE?  What if mmap()
  is called from different processes (in the POSIX sense, i.e., from
  different address spaces)?

  Either

   mmap(...)

  Or

   int kevent_map_ringbuf (int kfd, size_t num)


- one interface to set additional parameters.  This is likely mostly to
  make the interfaces safe for the future.  Perhaps the number of events
  needed per delay call should be set this way.

    int kevent_ctl (int kfd, int cmd, ...)


- one interface to shut the kevent down.  This might be overkill.  We
  should be able to use munmap() and close().  If a real interface for
  this would be created it should look like this

   int kevent_destroy (int kfd, void *ringbuf, size_t num)

  I find this rather more cumbersome.  Just use close and munmap.


- one interface to submit requests.

    int kevent_submit (int kfd, struct kevent_event *ev, int flags,
                       struct timespec *timeout)

  Maybe the flags parameter isn't needed, it's just another way to make
  sure we won't regret the design later.  If the ring buffer can fill up
  and this is detected by the kernel (unlike what happens in take 14)
  then the calling thread could be delayed undefinitely.  Maybe we even
  have a deadlock if there is only one thread.  If only a wait/no-wait
  mode is needed, then use only a flags parameter and no timeout
  parameter.

  A special variant should be if ev =3D=3D NULL the call is taken as a
  request to wake one or more delayed threads.


- one interface to delay threads until the next event becomes available.
  No data is transfered along with the call.  The event data must be
  read from the ring buffer:

    int kevent_wait (int kfd, unsigned ringstate,
                     const struct timespec *timeout,
                     const sigset_t *sigmask)

  Wait-mode can be implemented by recognizing timeout=3D=3DNULL.  no-wait=

  mode is implemented using timeout->tv_sec=3D=3Dtimeout->tv_nsec=3D=3D0.=
  If
  sigset_t is NULL the signal mask is not changed.

  The ringstate parameter is also not present in the take 14 proposal.
  Something like it is necessary to prevent the thread from going to
  sleep while there are events in the ring buffer.  It would be very
  wasteful if the kernel would have to keep track of outstanding
  events.  This would also mean then handling events would require
  a system call, exactly what the ring buffer approach should prevent.

  I think the sequence for waiting for an event should be like this:

    + get current ring state
    + check whether any outstanding event in ring buffer
    + if yes, copy data out of ring buffer, mark ring buffer record
      as unused (atomically).
    + if no, call kevent_wait with ring state value

  When the kernel delivers a new event it does:

    + find place to store event
    + change ring state (might be a simple counter)

  The kevent_wait implementation in the kernel would then as the first
  thing determine whether the ring state changed.  If yes, the syscall
  returns immediate with -ENWOULDBLOCK.  Otherwise it is queued for
  waiting.

  With these steps and the requirement that all ring buffer entries are
  processed FIFO we can
  a) avoid syscalls to avoid freeing ring buffer entries
  b) detect overflows in the ring buffer
  c) can maintain the read pointer at userlevel while the kernel can
     maintain the write pointer into the buffer


--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig470DF4516765F2630A344119
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE8gil2ijCOnn/RHQRAuWEAJ9Op73lRPkf7CPQBiPkpLJS8QLhowCfcnh6
F87h1w9vKi7F/Vky7EhZn+I=
=u2/g
-----END PGP SIGNATURE-----

--------------enig470DF4516765F2630A344119--
