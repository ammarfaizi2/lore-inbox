Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVI0QAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVI0QAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVI0QAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:00:41 -0400
Received: from mivlgu.ru ([81.18.140.87]:35729 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964992AbVI0QAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:00:41 -0400
Date: Tue, 27 Sep 2005 20:00:30 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Harald Welte <laforge@gnumonks.org>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927160029.GA20466@master.mivlgu.local>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2005 at 07:53:30AM -0700, Linus Torvalds wrote:
> On Sun, 25 Sep 2005, Harald Welte wrote:
> >=20
> > async_completed() calls send_sig_info(), which in turn does a
> > spin_lock(&tasklist_lock) to protect itself from task_struct->sighand
> > from going away.  However, the call to
> > "spin_lock_irqsave(task_struct->sighand->siglock)" causes an oops,
> > because "sighand" has disappeared.
>=20
> And the real bug is that you're buggering up the system in the first=20
> place.
>=20
> You don't save "current". You save "pid", and then you send a signal usin=
g=20
> that and kill_proc_info(). End of story, bug gone. And it works with=20
> threaded programs too, which the old thing didn't work at all with.

And then a process calls USBDEVFS_SUBMITURB and immediately exits; its
pid gets reused by a completely different process (maybe even
root-owned), then the urb completes, and kill_proc_info() sends the
signal to the unsuspecting process.

> I refuse to apply this patch - Greg, don't even _try_ to sneak this in=20
> through a git merge. What a horribly broken thing to do: why would USB=20
> _ever_ need to know about things like tasklist_lock, and internal signal=
=20
> handling functions and rules like "p->sighand"?

Hmm, then probably send_sig_info() should check for non-NULL
p->sighand after taking tasklist_lock?  Otherwise all uses of
send_sig_info() for non-current tasks are unsafe.

"git grep -w send_sig_info" shows that most callers call
send_sig_info() for the current task, except these:

arch/sparc/kernel/traps.c:      send_sig_info(SIGFPE, &info, fpt);
arch/sparc64/kernel/sys_sunos32.c:      send_sig_info(SIGSYS, &info, curren=
t);
drivers/char/drm/drm_irq.c:                     send_sig_info( vbl_sig->inf=
o.si_signo, &vbl_sig->info, vbl_sig->task );
drivers/usb/core/devio.c:               send_sig_info(as->signr, &sinfo, as=
->task);
drivers/usb/core/inode.c:                       send_sig_info(ds->discsignr=
, &sinfo, ds->disctask);
drivers/usb/gadget/file_storage.c:                      send_sig_info(SIGUS=
R1, SEND_SIG_FORCED, thread_task);
kernel/signal.c:        return send_sig_info(sig, (void*)(long)(priv !=3D 0=
), p);

BTW, all other callers of send_sig_info() are under
arch/{alpha,arm,sparc,sparc64}/ - 23 total.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDOWydW82GfkQfsqIRAtC4AKCJQ9k99X0fcx/bcOvtKenvZKbryACdGn7i
/YIaQenUus4mhwXVrP4tb6M=
=k6Sp
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
