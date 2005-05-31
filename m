Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVEaItC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVEaItC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEaItB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:49:01 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:55693 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261372AbVEaIsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:48:54 -0400
Date: Tue, 31 May 2005 10:48:52 +0200
From: Harald Welte <laforge@gnumonks.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Message-ID: <20050531084852.GJ25536@sunbeam.de.gnumonks.org>
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline
In-Reply-To: <200505301555.39985.david-b@pacbell.net>
User-Agent: mutt-ng 1.5.8-r168i (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, May 30, 2005 at 03:55:39PM -0700, David
	Brownell wrote: > The logic closing an open usbfs file -- which is done
	before any task > exits with such an open file -- is supposed to block
	till all its URBs > complete. So the pointer to the task "should" be
	valid for as long as > any URB it's submitted is active. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2005 at 03:55:39PM -0700, David Brownell wrote:

> The logic closing an open usbfs file -- which is done before any task
> exits with such an open file -- is supposed to block till all its URBs
> complete.  So the pointer to the task "should" be valid for as long as
> any URB it's submitted is active.

unfortunately it doesn't seem to cover the fork() case, see below.

> > > I'm not familiar with the scheduler code to decide what fix
> > > is the way to go.  Is it sufficient to do {get,put}_task_struct() from
> > > the usb code?
>=20
> It's worth making that change in any case, to avoid such questions in
> the future.  And if it does any good, more power to the patch!

Ok.

> Not that it helps at all, but I've never really trusted the usbfs async
> I/O code.  "Real AIO" could be a lot more obviously correct.  And smaller.

mh, but nobody has written AIO-enabled usbfs2  yet ;)

meanwhile, the current usbfs aio handling is the only way how to deal
with delivery of interrupt pipe URB's to userspace drivers.

> > mh. it appears like it's sighand which disappears, not the task itself.
> > ...
>=20
> Odd.  Isn't that nulled only in __exit_sighand(), which gets called only
> when the task itself is finally being freed?

yes, I couldn't find any other location but __exit_sighand() that nulls
task->sighand.  And looking at exit.c, do_exit() definitely calls
__exit_files(tsk) before it calls __exit_sighand() via exit_notify().


However, __exit_files() only calls close_files() if files->count goes
down to zero. What if the process fork()ed before, and the other half of
the fork still has a refcount?  -> boom.

It seems to me that the whole usbdevio async handling doesn't really
cope with a lot of the unix semantics, such as fork() or file descriptor
passing.

Wouldn't it help to associate the URB with the file (instaed of the
task), and then send the signal to any task that still has opened the
file?  I'm willing to hack up a patch, if this is considered a sane fix.

Cheers,
	Harald
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCnCT0XaXGVTD0i/8RAmFyAJ0ViP1KJaP5jUPEAbzdFw2B7FjI6QCfdY+F
F7plCVm4SjKLBYXsbNO1yjU=
=SIwE
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--
