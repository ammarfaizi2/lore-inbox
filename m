Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVKCKwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVKCKwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVKCKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:52:44 -0500
Received: from mivlgu.ru ([81.18.140.87]:17565 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964858AbVKCKwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:52:43 -0500
Date: Thu, 3 Nov 2005 13:52:35 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051103105235.GB23142@master.mivlgu.local>
References: <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org> <20051101035816.GA7788@vrfy.org> <20051101195449.GA9162@procyon.home> <20051101213525.GA17207@vrfy.org> <20051102130118.GA23142@master.mivlgu.local> <20051103080713.GD7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20051103080713.GD7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2005 at 08:07:13AM +0000, Al Viro wrote:
> On Wed, Nov 02, 2005 at 04:01:18PM +0300, Sergey Vlasov wrote:
> > @@ -120,6 +122,10 @@ static void detach_mnt(struct vfsmount *
> >  	list_del_init(&mnt->mnt_child);
> >  	list_del_init(&mnt->mnt_hash);
> >  	old_nd->dentry->d_mounted--;
> > +	if (current->namespace) {
> > +		current->namespace->event++;
> > +		wake_up_interruptible(&mounts_wait);
> > +	}
> >  }
> > =20
> >  static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
>=20
> Ugh...  So umount -l gives one hell of a spew for no good reason.

umount -l will change contents of /proc/mounts, so waking up poll() on
that file seems to be right in this case (even if the filesystem is still
mounted internally, it is no longer accessible).

> > @@ -129,6 +135,8 @@ static void attach_mnt(struct vfsmount *
> >  	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
> >  	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
> >  	nd->dentry->d_mounted++;
> > +	current->namespace->event++;
> > +	wake_up_interruptible(&mounts_wait);
> >  }
>=20
> Bad idea - copy_tree() will spew *and* we get bogus events on CLONE_NEWNS
> (i.e. current->namespace is not even the namespace being modified).

IMHO it's not spew, but real changes in the mount tree.

CLONE_NEWNS handling may really be broken (maybe mnt->mnt_namespace should
be used instead of current->namespace, but I'm not sure if it is set
correctly at this place - it is certainly wrong in detach_mnt()).

> > @@ -1093,6 +1104,7 @@ int copy_namespace(int flags, struct tas
> >  	atomic_set(&new_ns->count, 1);
> >  	init_rwsem(&new_ns->sem);
> >  	INIT_LIST_HEAD(&new_ns->list);
> > +	new_ns->event =3D 0;
>=20
> BTW, I'd rather make that queue per-namespace...

You mean mount_wait, so that only tasks which wait for changes in a
particular namespace would be woken up?  Yes, that would be better (if
namespaces are really used).

> > +	down_read(&namespace->sem);
> > +	if (private->last_event !=3D namespace->event) {
> > +		private->last_event =3D namespace->event;
> > +		ret =3D POLLIN | POLLRDNORM;
>=20
> Umm...  I'd rather use POLLERR, since POLLIN doesn't apply here - it's not
> a stream of data that gives blocking read() when reached the end.

This is copied from /proc/bus/usb/devices, which has similar behavior.

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDaevzW82GfkQfsqIRAnj7AJ4nkav/2XDuuWDSO+tnTyz5NeESjACglfao
86qXjSSy48eXKm47BJ3UlKI=
=jTyT
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
