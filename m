Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWHKTsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWHKTsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHKTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:48:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932421AbWHKTsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:48:16 -0400
Message-ID: <44DCDE73.9030901@redhat.com>
Date: Fri, 11 Aug 2006 12:45:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com>	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>	 <44C90987.1040200@redhat.com>	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com> <1154091500.13577.14.camel@frecb000686>
In-Reply-To: <1154091500.13577.14.camel@frecb000686>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8BF53928B0710FA9EF4AED6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8BF53928B0710FA9EF4AED6D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

S=C3=A9bastien Dugu=C3=A9 wrote:
> 		     aio completion notification

I looked over this now but I don't think I understand everything.  Or I
don't see how it all is integrated.  And no, I'm not looking at the
proposed glibc code since would mean being tainted.


> Details:
> -------
>=20
>   A struct sigevent *aio_sigeventp is added to struct iocb in
> include/linux/aio_abi.h
>=20
>   An enum {IO_NOTIFY_SIGNAL =3D 0, IO_NOTIFY_THREAD_ID =3D 1} is added =
in
> include/linux/aio.h:
>=20
> 	- IO_NOTIFY_SIGNAL means that the signal is to be sent to the
> 	  requesting thread=20
>=20
> 	- IO_NOTIFY_THREAD_ID means that the signal is to be sent to a
> 	  specifi thread.

This has been proved to be sufficient in the timer code which basically
has the same problem.  But why do you need separate constants?  We have
the various SIGEV_* constants, among them SIGEV_THREAD_ID.  Just use
these constants for the values of ki_notify.


>   The following fields are added to struct kiocb in include/linux/aio.h=
:
>=20
> 	- pid_t ki_pid: target of the signal
>=20
> 	- __u16 ki_signo: signal number
>=20
> 	- __u16 ki_notify: kind of notification, IO_NOTIFY_SIGNAL or
> 			   IO_NOTIFY_THREAD_ID
>=20
> 	- uid_t ki_uid, ki_euid: filled with the submitter credentials

These two fields aren't needed for the POSIX interfaces.  Where does the
requirement come from?  I don't say they should be removed, they might
be useful, but if the costs are non-negligible then they could go away.


> 	- check whether the submitting thread wants to be notified directly
> 	  (sigevent->sigev_notify_thread_id is 0) or wants the signal to be se=
nt
> 	  to another thread.
> 	  In the latter case a check is made to assert that the target thread
> 	  is in the same thread group

Is this really how it's implemented?  This is not how it should be.
Either a signal is sent to a specific thread in the same process (this
is what SIGEV_THREAD_ID is for) or the signal is sent to a calling
process.  Sending a signal to the process means that from the kernel's
POV any thread which doesn't have the signal blocked can receive it.
The final decision is made by the kernel.  There is no mechanism to send
the signal to another process.

So, for the purpose of the POSIX AIO code the ki_pid value is only
needed when the SIGEV_THREAD_ID bit is set.

It could be an extension and I don't mind it being introduced.  But
again, it's not necessary and if it adds costs then it could be left
out.  It is something which could easily be introduced later if the need
arises.


> 			    listio support
>=20

I really don't understand the kernel interface for this feature.


> Details:
> -------
>=20
>   An IOCB_CMD_GROUP is added to the IOCB_CMD enum in include/linux/aio_=
abi.h
>=20
>   A struct lio_event is added in include/linux/aio.h
>=20
>   A struct lio_event *ki_lio is added to struct iocb in include/linux/a=
io.h

So you have a pointer in the structure for the individual requests.  I
assume you use the atomic counter to trigger the final delivery.  I
further assume that if lio_wait is set the calling thread is suspended
until all requests are handled and that the final notification in this
case means that thread gets woken.

This is all fine.

But how do you pass the requests to the kernel?  If you have a new
lio_listio-like syscall it'll be easy.  But I haven't seen anything like
this mentioned.

The alternative is to pass the requests one-by-one in which case I don't
see how you create the reference to the lio_listio control block.  This
approach seems to be slower.

If all requests are passed at once, do you have the equivalent of
LIO_NOP entries?


How can we support the extension where we wait for a number of requests
which need not be all of them.  I.e., I submit N requests and want to be
notified when at least M (M <=3D N) notified.  I am not yet clear about
the actual semantics we should implement (e.g., do we send another
notification after the first one?) but it's something which IMO should
be taken into account in the design.


Finally, and this is very important, does you code send out the
individual requests notification and then in the end the lio_listio
completion?  I think Suparna wrote this is the case but I want to make su=
re.


Overall, this looks much better than the old code.  If the answers to my
questions show that the behavior is compatible with the POSIX AIO code
I'm certainly very much in favor of adding the kernel code.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig8BF53928B0710FA9EF4AED6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE3N5z2ijCOnn/RHQRAqngAKC2d9fT0FIgpBsc7V9XTSF30CQNnACgnQMg
c/G7OpttcRpslUmGyyi2ipk=
=aEZf
-----END PGP SIGNATURE-----

--------------enig8BF53928B0710FA9EF4AED6D--
