Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWBJQoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWBJQoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWBJQoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:44:38 -0500
Received: from mail.bytecamp.net ([212.204.60.9]:30987 "HELO mail.bytecamp.net")
	by vger.kernel.org with SMTP id S1751300AbWBJQoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:44:37 -0500
Subject: Using fsync() to synchronize a USB mass storage device failed
From: Christian Neumair <chris@gnome-de.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tl7axZ66CniKoglivRg+"
Date: Fri, 10 Feb 2006 17:43:38 +0100
Message-Id: <1139589818.7769.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tl7axZ66CniKoglivRg+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've seen various postings on the lkml on the issue of fsync()ing block
devices and the expected behavior. Some claim that fsync()ing the mount
point of a block device will flush its buffers, a HOWTO I read claims
that one has to apply it to the device node, because it is the
representation of the block device.

The POSIX standard demands [1]:

"The fsync() function shall request that all data for the open file
descriptor named by fildes is to be transferred to the storage device
associated with the file described by fildes."

To my interpretation this means that all buffers of a mass storage
device should be flushed when calling fsync() on its file
representation, i.e. /dev/foo.

I've tried various Ubuntu-packaged kernel releases (2.6.12 and later),
and none of it seems to actually assert that the data is written when
using code like

int fd =3D open ("/dev/sdb1", O_RDONLY); /* I also tried O_WRONLY */

or

int fd =3D open ("/media/usbdisk", O_DIRECTORY | O_RDONLY);

and then doing

fsync (fd);
close (fd);

Unfortunately, none of the code really blocked until the whole buffer
was written, and a diode on the mass storage indicated that data was
still being written to it after my testing application terminated, while
for a simple sync() call (or "sync" program invocation) the whole
process really blocked until the data was on disk, as proven by the
non-flashing diode.

I haven't investigated the code in detail, but fs/buffer.c suggests that
sync_inodes is invoked on sync() but not on fsync(), and the latter does
not lookup the block device the file refers to, thus not ensuring that
fsync_bdev() is called on it.

If you wonder why this is needed - over at GNOME we're having issues
where USB sticks are unmounted and the users have no clue when it's
ready to be removed [1]. We'd like to fsync() in a thread and tell the
users that an unmount operation is going on and still needs some time.
Because there may be multiple storage device attached, it isn't a good
idea to sync() all devices, but just that one which is about to be
ejected.


[1] http://www.opengroup.org/onlinepubs/009695399/functions/fsync.html
[2] http://bugzilla.gnome.org/show_bug.cgi?id=3D329098

--=20
Christian Neumair <chris@gnome-de.org>

--=-tl7axZ66CniKoglivRg+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7MK6WfvsaU5lO4kRAtq9AJ9leymUSzjIEtMRJpmEYDPEEZx0SQCeOky7
sEKEaDpiHsW4/JiQgTKZqXY=
=KOMf
-----END PGP SIGNATURE-----

--=-tl7axZ66CniKoglivRg+--

