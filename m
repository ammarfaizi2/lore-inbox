Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWDDWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDDWXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDDWXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:23:06 -0400
Received: from smtp05.auna.com ([62.81.186.15]:10995 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750789AbWDDWXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:23:05 -0400
Date: Wed, 5 Apr 2006 00:22:58 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: udev, PROGRAM and races...
Message-ID: <20060405002258.18fddd87@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.0.0cvs180 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_meF20r/jIK52=WLjH5ba2IB";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Wed, 5 Apr 2006 00:22:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_meF20r/jIK52=WLjH5ba2IB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi...

I (well, the distro I use) has a little problem with creation of links
for CD-ROM devices.

For example, in my box, hda is a DVDRW and hdd is a DVD reader.
I think I should have something like
cdrom0 -> hda
cdrom1 -> hdd
dvd0 -> hda
dvd1 -> hdd
cdrw0 -> hda
dvdrw0 -> hda

(with optional cdrom and dvd links to the default one, say just the
first).

This is done with rule like:

SUBSYSTEM=3D=3D"block", ACTION=3D=3D"add", ENV{ID_CDROM}=3D=3D"?*", PROGRAM=
=3D"/lib/udev/udev_cdrom_helper", SYMLINK+=3D"%c"

This helper tries to get the next free %d index to create cdrom%d, for
example.
The problem is that the launch of both helpers for hda and add seems to be =
done
in parallel and the helper gets racy, so both cdroms get id 0, and the last
that comes owns it:

helper instance for hda        helper instance for hdd
Does cdrom0 exist ? No
                               Does cdrom0 exist ? No
ln -sf hda cdrom0
                               ln -sf hdd cdrom0

????

Is there any way to serialize the calls to 'PROGRAM'. I tried something lik=
e:

SUBSYSTEM=3D=3D"block", ACTION=3D=3D"add", ENV{ID_CDROM}=3D=3D"?*",
PROGRAM=3D"/usr/bin/flock /sys/block /lib/udev/udev_cdrom_helper", SYMLINK+=
=3D"%c"

But looks a lot ugly.

Any standard way to do this ?
Can I still use %e, or is it really really deprecated ? this was easy:

ENV{ID_CDROM_CD_RW}=3D=3D"?*",  SYMLINK+=3D"burner%e", MODE=3D"0666", GROUP=
=3D"cdwriter"
ENV{ID_CDROM_DVD_R}=3D=3D"?*",  SYMLINK+=3D"burner%e", MODE=3D"0666", GROUP=
=3D"cdwriter"

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam5 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_meF20r/jIK52=WLjH5ba2IB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMvHCRlIHNEGnKMMRArKJAJ92u2lYBEpeDjwgwqHy6iAaM2TROQCgo6ZU
Y/bCThfLnK7F//11rW6TOX4=
=wB/h
-----END PGP SIGNATURE-----

--Sig_meF20r/jIK52=WLjH5ba2IB--
