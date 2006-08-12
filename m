Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWHLTL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWHLTL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHLTL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:11:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932504AbWHLTLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:11:25 -0400
Message-ID: <44DE27AB.7040507@redhat.com>
Date: Sat, 12 Aug 2006 12:10:35 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: sebastien.dugue@bull.net, Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4] kevent:
 AIO, aio_sendfile)
References: <44C77C23.7000803@redhat.com> <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com> <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com> <44C90987.1040200@redhat.com> <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com> <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com> <20060812182928.GA1989@in.ibm.com>
In-Reply-To: <20060812182928.GA1989@in.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3971FD6FF132D8BC97C54F4A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3971FD6FF132D8BC97C54F4A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Suparna Bhattacharya wrote:
> I am wondering about that too. IIRC, the IO_NOTIFY_* constants are not
> part of the ABI, but only internal to the kernel implementation. I thin=
k
> Zach had suggested inferring THREAD_ID notification if the pid specifie=
d
> is not zero. But, I don't see why ->sigev_notify couldn't used directly=

> (just like the POSIX timers code does) thus doing away with the=20
> new constants altogether. Sebestian/Laurent, do you recall?

I suggest to model the implementation after the timer code which does
exactly what we need.


> I'm guessing they are being used for validation of permissions at the t=
ime
> of sending the signal, but maybe saving the task pointer in the iocb in=
stead
> of the pid would suffice ?

Why should any verification be necessary?  The requests are generated in
the same process which will receive the notification.  Even if the POSIX
process (aka, kernel process group) changes the IDs the notifications
should be set.  The key is that notifications cannot be sent to another
POSIX process.

Adding this as a feature just makes things so much more complicated.


> So I think the
> intended behaviour is as you describe it should be

Then the documentation needs to be adjusted.


> The way it works (and better ideas are welcome) is that, since the io_s=
ubmit()
> syscall already accepts an array of iocbs[], no new syscall was introdu=
ced.
> To implement lio_listio, one has to set up such an array, with the firs=
t iocb
> in the array having the special (new) grouping opcode of IOCB_CMD_GROUP=
 which
> specifies the sigev notification to be associated with group completion=

> (a NULL value of the sigev notification pointer would imply equivalent =
of
> LIO_WAIT).

OK, this seems OK.  We have to construct the iocb arrays dynamically anyw=
ay.


> My thought here was that it should be possible to include M as a parame=
ter
> to the IOCB_CMD_GROUP opcode iocb, and thus incorporated in the lio con=
trol
> block ... then whatever semantics are agreed upon can be implemented.

If you have room for the parameter this is fine.  For the beginning we
can enforce the number to be the same as the total number of requests.


> Let us know what you think about the listio interface ... hopefully the=

> other issues are mostly simple to resolve.

It should be fine and I would support adding all this assuming the
normal file support (as opposed to direct I/O only) is added, too.


But I have one last question: sockets, pipes and the like are already
supported, right?  If this is not the case we have a problem with the
currently proposed  lio_listio interface.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig3971FD6FF132D8BC97C54F4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE3ier2ijCOnn/RHQRArFyAJ9Bb44AiJz2HFR34tglX+uSSMF+0QCePUdd
SC+mqXfIThzpoi5mhlxdyF8=
=POD4
-----END PGP SIGNATURE-----

--------------enig3971FD6FF132D8BC97C54F4A--
