Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVC0NwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVC0NwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVC0NwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 08:52:19 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:38793 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261640AbVC0NwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 08:52:14 -0500
Subject: inotify issue: iput called atomically
From: Christophe Saout <christophe@saout.de>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oHYSHtf55eTNJdK/vtgK"
Date: Sun, 27 Mar 2005 15:52:06 +0200
Message-Id: <1111931527.20371.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oHYSHtf55eTNJdK/vtgK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Robert,

it looks like you shouldn't call iput with spinlocks held. iput might
call down into the filesystem to delete the inode and this can sleep.

Mar 27 14:38:18 server Debug: sleeping function called from invalid
context at include/asm/semaphore.h:102
Mar 27 14:38:18 server in_atomic():1, irqs_disabled():0
Mar 27 14:38:18 server [<c0103e37>] dump_stack+0x17/0x20
Mar 27 14:38:18 server [<c0118973>] __might_sleep+0xa3/0xb0
Mar 27 14:38:18 server [<c03fc5ab>] lock_kernel+0x2b/0x50
Mar 27 14:38:18 server [<c019fc33>] reiserfs_delete_inode+0x13/0x100
Mar 27 14:38:18 server [<c0172c64>] generic_delete_inode+0xa4/0x160
Mar 27 14:38:18 server [<c0172f16>] iput+0x56/0x80
Mar 27 14:38:18 server [<c017f9bd>] remove_watch_no_event+0x8d/0x100
Mar 27 14:38:18 server [<c01805f9>] inotify_ignore+0x49/0x90
Mar 27 14:38:18 server [<c018070d>] inotify_ioctl+0xcd/0x110
Mar 27 14:38:18 server [<c016ac26>] do_ioctl+0x76/0x90
Mar 27 14:38:18 server [<c016adb9>] vfs_ioctl+0x59/0x1c0
Mar 27 14:38:18 server [<c016af59>] sys_ioctl+0x39/0x60
Mar 27 14:38:18 server [<c0102f6b>] sysenter_past_esp+0x54/0x75

I've looked through the code and iput can usually be called after
releasing spinlocks. It doesn't look trivial to implement though.


--=-oHYSHtf55eTNJdK/vtgK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRrqGZCYBcts5dM0RAjG7AJ4uGMi9dhnPqTE4RSmPVAXhi+2S/QCeLRgd
D4odjY8ywK87b1RZMAYbmjc=
=30eh
-----END PGP SIGNATURE-----

--=-oHYSHtf55eTNJdK/vtgK--

