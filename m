Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVCICJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVCICJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCICGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:06:53 -0500
Received: from dc116.internetdsl.tpnet.pl ([80.53.238.116]:7914 "EHLO
	spock.one.pl") by vger.kernel.org with ESMTP id S262144AbVCICFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 21:05:36 -0500
Date: Wed, 9 Mar 2005 03:05:28 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [announce 7/7] fbsplash - documentation
Message-ID: <20050309020527.GA20294@spock.one.pl>
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de> <20050308223728.GA11065@spock.one.pl> <200503090117.12755.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <200503090117.12755.arnd@arndb.de>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 01:17:11AM +0100, Arnd Bergmann wrote:

> You also shouldn't create a class device every time you want to call
> kobject_hotplug. Note that every character device already has a class
> device associated with it, so you might be able to just use that to
> call kobject_hotplug on it.
>=20
> If there is no obvious way to do that, just leave the code as it is
> for calling the helper.

OK, thanks forthe explanation and advice. I'll look into it.

> > The reason for calling init in that place is the ability to use the
> > userspace helper to display a nice picture while the kernel is still
> > loading. Sure, you can just drop it and use the 'quiet' command line
> > option, but that will give you a black screen for a good few seconds.=
=20
> > And people who want eye-candy like fbsplash generally don't like
> > that.=20
>
> Ok, understood. I think you should make that an extra patch and completely
> remove that feature from the base patchset in order to make it less
> controversial.

That can be done. The funny thing is, a week ago or so, it was proposed
in a thread about bootsplash that the code for the initial call could be
merged first and serve as a base for merging fbsplash :)

> > > That sounds really dangerous. Can you guarantee that nothing
> > > unexpected happens when a malicious user calls the ioctls with
> > > FB_SPLASH_IO_ORIG_KERNEL from a  regular user process?
> >=20
> > This is pretty nasty, right, but I just can't see a way around it.
> > The thing is, when the splash helper is called from the kernel, the
> > console semaphore is already held so we have to avoid trying to acquire=
=20
> > it again. And we can't just release it prior to calling the helper, as
> > it would break things badly.
>=20
> I don't understand. Does the kernel code need to wait for the helper
> to finish while holding the semaphore? AFAICS, the helper is
> completely asynchronous, so it can simply do its job when the kernel=20
> has given up the semaphore.

> >                                     And we can't do ioctls on ttys when=
=20
> >   answering a kernel request because to the console sem problems
> >   (opening a tty =3D a call to acquire_console_sem(), which we need to
> >   avoid).
>=20
> Hmm. One of us has misunderstood the interaction between=20
> call_usermodehelper() and acquire_console_sem(). If I'm the one
> who's wrong, please tell me where that semaphore is held.

It think this will be best explained with an example. Consider the
following situation - we have two ttys - tty1 and tty2. tty1 is using
theme 'foo' an it's the foreground console. tty2 is using theme 'bar'.
Fbsplash is enabled on both these ttys.

Now the user decides to switch to tty2. He/she presses Alt+F2. The
keypress is handled somewhere and an item is added to the console_work
workqueue. console_callback() gets called asynchronously.
acquire_console_sem() is the first thing done in that function.

Now we have the following call stack (all done with the console sem
held):

change_console()
complete_change_console()
switch_screen() =3D=3D redraw_screen()
con_switch() =3D=3D fbcon_switch()

=46rom inside fbcon_switch(), we need to call the splash helper to get a
new picture for the theme 'bar' which is used on tty2. The splash helper
does an ioctl and we're back in the kernel.. with the console semaphore
already held.

> > The original idea behind this was to group the fields that are
> > common to all fbsplash ioctl calls (ie. vc and origin) in one place.=20
> > Of course, it can be changed to three differents structs, each=20
> > containing the vc and origin fields and an int/struct vc_splash/struct=
=20
> > fb_image, if that is the preferred way of doing things.
>
> It definitely is. Actually, it would be preferred to have only a
> single value as ioctl argument (or even better, no ioctl at all),=20
> but if you need to pass an aggregate data type, it should at least=20
> have an identical layout for all architectures. That means every=20
> member should be naturally aligned and you can't use pointers or other
> types that have sizeof(x) =3D=3D sizeof(long).

What are the alternatives to the ioctl? A relatively clean way of
feeding the data back to the kernel would be using sysfs. However, to
make it sane we would have to export the various components of struct
vc_splash in /sys/class/tty/tty<x> (otherwise, we would probabky have
to pass aggreaget data types through a sysfs entry -- something that is
IMO much worse than an ioctl). That however could be a little
problematic -- tty_class is currently defined as a class_simple.
To add entries other than the standard 'dev' we would have to define a
completely new class, right? That sounds like a rather intrusive
change..

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLlnnaQ0HSaOUe+YRAkzvAJ4uZIe8V/0qJZWwx3a4FS6WvvpIYQCgg2oG
p0E3mWM6cuaWfrjOAB2LZSs=
=ljDb
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
