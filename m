Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVI0QwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVI0QwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVI0QwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:52:09 -0400
Received: from mivlgu.ru ([81.18.140.87]:51857 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965002AbVI0QwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:52:08 -0400
Date: Tue, 27 Sep 2005 20:52:06 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927165206.GB20466@master.mivlgu.local>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2005 at 09:09:28AM -0700, Linus Torvalds wrote:
> On Tue, 27 Sep 2005, Sergey Vlasov wrote:
> >=20
> > And then a process calls USBDEVFS_SUBMITURB and immediately exits; its
> > pid gets reused by a completely different process (maybe even
> > root-owned), then the urb completes, and kill_proc_info() sends the
> > signal to the unsuspecting process.
>=20
> Ehh.. pid's don't get re-used until they wrap.

#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)

which is not that big (and on 32-bit systems PID_MAX_LIMIT is also
32K).

> Your _current_ code has that problem, though - "struct task_struct" _does=
_=20
> get re-used.

The initial patch added get_task_struct()/put_task_struct() calls to
fix this - are they forbidden too?

> Don't assume that the fixes are as bad.
>=20
> Anyway, Christoph is certainly correct that what you _should_ be using is=
=20
> the SIGIO infrastructure, even if you don't actually use the fcntl() to=
=20
> register it.=20

It at least has sigio_perm(), which prevents exploiting it to send
signals to tasks you don't have access to.

> > Hmm, then probably send_sig_info() should check for non-NULL
> > p->sighand after taking tasklist_lock?  Otherwise all uses of
> > send_sig_info() for non-current tasks are unsafe.
>=20
> I don't think so.=20
>=20
> Your oops is because you're using a STALE POINTER.
>=20
> If you look it up by pid, it won't be stale, now will it?
>=20
> Hint: the point where sighand is released is also the point where the=20
> process is unhashed.

When using kill_proc_info() - yes, because it takes tasklist_lock
during its operation.  However, lookup by pid is not safe against pid
wrapping (at least without adding more checks like sigio_perm(), which
ensure that you can zap only your own process with that signal).

(Why they did not make a kind of "file descriptor" for processes...)

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDOXi2W82GfkQfsqIRAqhuAJ0aXKQOZwgUhMlrwp8Tv+lk+wwWRACeM76B
q5aKlkWJqT2UnOxEA9K+qRo=
=gN+Z
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
