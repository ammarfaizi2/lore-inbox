Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVHWNOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVHWNOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHWNOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:14:07 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54936 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751294AbVHWNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:14:06 -0400
Subject: Re: Linux AIO status & todo
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050823095609.GZ7403@devserv.devel.redhat.com>
References: <20050823074438.GA4586@in.ibm.com>
	 <20050823095609.GZ7403@devserv.devel.redhat.com>
Message-Id: <1124802822.18662.60.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 23 Aug 2005 15:13:43 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/08/2005 15:26:34,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/08/2005 15:26:39,
	Serialize complete at 23/08/2005 15:26:39
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bUvtkvuZS6IaB3KL/CTM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bUvtkvuZS6IaB3KL/CTM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 23/08/2005 =C3=A0 11:56, Jakub Jelinek a =C3=A9crit :
> On Tue, Aug 23, 2005 at 01:14:38PM +0530, Suparna Bhattacharya wrote:
>=20
> > 	2. No support for propagating IO completion events to user space
> > 	   threads using RT signals. User threads need to poll the completion
> > 	   queue using io_getevents. POSIX specifies that when an AIO
> > 	   request completes, a signal can be delivered to the application
> > 	   to indicate the completion of the IO.
>=20
> POSIX AIO needs to handle SIGEV_NONE, SIGEV_SIGNAL and SIGEV_THREAD
> notification.  Obviously kernel shouldn't create threads for SIGEV_THREAD
> itself, as kernel shouldn't hardcode all the implementation details how a
> thread can be created.  But it would be good if AIO signalling e.g. handl=
ed
> both SIGEV_SIGNAL and SIGEV_SIGNAL | SIGEV_THREAD_ID, with the same usage=
 as
> e.g. timer_* syscalls.  If kernel makes sure SI_ASYNCIO si_code is set in
> the notification signal siginfos, glibc could even use just one helper
> thread for timer_*/[al]io_* and maybe in the future other SIGEV_THREAD no=
tification.
>=20

See chapter "2.2. AIO completion event".

The libposix-aio written by S=C3=A9bastien and I manages all these cases:

http://www.bullopensource.org/posix/

There is a patch allowing kernel to send signal to a given process on
aio event completion:

http://cvs.sourceforge.net/viewcvs.py/paiol/kernel-patches/2.6.12/aioevent.=
patch?rev=3D1.1.1.1&view=3Dauto

With the help of an helper thread in the user space, the libposix-aio is
able to manage SIGEV_THREAD and create new thread by using user space
code (and thus implementation dependent calls):

http://cvs.sourceforge.net/viewcvs.py/paiol/libposix-aio/src/aio_read.c?vie=
w=3Dmarkup
http://cvs.sourceforge.net/viewcvs.py/paiol/libposix-aio/src/aio_thread_cre=
ate.c?view=3Dmarkup

S=C3=A9bastien wrote this part of libposix-aio (So I'm not an expert on thi=
s
part :-P ), but I think his helper thread is made like the glibc timer
helper thread is made. And thus, if we want to merge libposix-aio in
glibc, we should use existing mechanism, and it should be easy to put
POSIX AIO helper thread portions inside the timer helper thread.

But only the glibc maintainer can answer to this question:=20

should we mixe timer and AIO code ?

Laurent
--=20
------------------ Laurent Vivier -------------------
  mailto:Laurent.Vivier@bull.net BULL/FREC:B1-226
    phone: (+33) 476 29 7213  Bullcom: 229-7213
------------------[ DT/OSwR&D/AIX ]------------------
            http://www.bullopensource.org/ext4

--=-bUvtkvuZS6IaB3KL/CTM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDCyEG9Kffa9pFVzwRAjfdAJ4kSAfuHYnngfCy+K4rB0PJte4nrACfTSgg
GoGxdYHgj0EGlF0GYKO36UU=
=iJLO
-----END PGP SIGNATURE-----

--=-bUvtkvuZS6IaB3KL/CTM--

