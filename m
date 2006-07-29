Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWG2QRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWG2QRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWG2QRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:17:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751008AbWG2QRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:17:21 -0400
Message-ID: <44CB8A67.3060801@redhat.com>
Date: Sat, 29 Jul 2006 09:18:47 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Zach Brown <zach.brown@oracle.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru> <44CA613F.9080806@oracle.com> <44CAD81A.9060401@redhat.com> <20060729154401.GA25926@2ka.mipt.ru>
In-Reply-To: <20060729154401.GA25926@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig90B4B8A3967E2245C62B6EE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90B4B8A3967E2245C62B6EE0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Evgeniy Polyakov wrote:
> Btw, why do we want mapped ring of ready events?
> If user requestd some event, he definitely wants to get them back when
> they are ready, and not to check and then get them?
> Could you please explain more on this issue?

If of course makes no sense to enter the kernel to actually get the
event.  This should be done by storing the event in the ring buffer.
I.e., there are two ways to get an event:

- with a syscall.  This can report as many events at once as the caller
  provides space for.  And no event which is reported in the run buffer
  should be reported this way

- if there is space, report it in the ring buffer.  Yes, the buffer
  can be optional, then all events are reported by the system call.


So the use case would be like this:


wait_and_get_event:

  is buffer empty ?

    yes -> make syscall

    no -> get event from buffer


To avoid races, the syscall needs to take a parameter indicating the
last event checked out from the buffer.  If in the meantime the kernel
put another event in the buffer the syscall immediately returns.
Similar to what we do in the futex syscall.

The question is how to best represent the ring buffer.  Zach and some
others had some ready responses in Ottawa.  The important thing is to
avoid cache line ping pong when possible.


Is the ring buffer absolutely necessary?  Probably not.  But it has the
potential to help quite a bit.  Don't look at the problem to solve in
the context of heavy I/O operations when another syscall here and there
doesn't matter.  With this single event mechanism for every possible
event the kernel can generate programming can look quite different.
E.g., every read() call can implicitly we changed into an async read
call followed by a user-level reschedule.  This rescheduling allows
another thread of execution to run while the read request is processed.
 I.e., it's basically a setjmp() followed by a goto into the inner loop
to get the next event.  And now suddenly the event notification
mechanism really should be as fast as possible.  If we submit basically
every request asynchronously and are not creating dedicated threads for
specific tasks anymore we

a) have a lot more event notifications

b) the probability of an event being reported when we want the receive
   the next one if higher (i.e., the case where no syscall vs syscall
   makes a difference)

Yes, all this will require changes in the way programs a written but we
shouldn't limit the way we can write programs unnecessarily.  I think
that given increasing discrepancies in relative speed/latency of the
peripherals and the CPU this is one possible solution to keep the CPUs
busy without resorting to a gazillion separate threads in each program.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig90B4B8A3967E2245C62B6EE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEy4pn2ijCOnn/RHQRAp4TAKDKwgeAl7NmcAxa5Ap2+1Sz8XD1iwCaAt8n
p0q/dPwCjKfo7aqefVUC43Q=
=6G8Q
-----END PGP SIGNATURE-----

--------------enig90B4B8A3967E2245C62B6EE0--
