Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVCOGEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVCOGEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVCOGEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:04:53 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:51380 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262251AbVCOGEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:04:48 -0500
Date: Mon, 14 Mar 2005 23:04:44 -0700
From: Andreas Dilger <adilger@shaw.ca>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Andrew Morton <akpm@osdl.org>, strombrg@dcs.nac.uci.edu,
       linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
Message-ID: <20050315060444.GC31960@schnapps.adilger.int>
Mail-Followup-To: jmerkey <jmerkey@utah-nac.org>,
	Andrew Morton <akpm@osdl.org>, strombrg@dcs.nac.uci.edu,
	linux-kernel@vger.kernel.org
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu> <20050314164137.GC1451@schnapps.adilger.int> <4235C251.7000801@utah-nac.org> <20050314192140.1b3680da.akpm@osdl.org> <4236587E.5060200@utah-nac.org> <20050314200241.0f079062.akpm@osdl.org> <4236669C.7010706@utah-nac.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <4236669C.7010706@utah-nac.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 14, 2005  21:37 -0700, jmerkey wrote:
> 1. Scaling issues with readdir() with huge numbers of files (not even=20
> huge really. 87000 files in a dir takes a while
> for readdir() to return results). I average 2-3 million files per=20
> directory on 2.6.9. It can take a up to a minute for
> readdir() to return from initial reading from on of these directories=20
> with readdir() through the VFS.

Actually, unless I'm mistaken the problem is that "ls" (even when you
ask it not to sort entries) is doing readdir on the whole directory
before returning any results.  We see this with Lustre and very large
directories.  Run strace on "ls" and it is doing masses of readdirs, but
no output to stdout.  Lustre readdir works OK on directories up to 10M
files, but ls sucks.

$ strace ls /usr/lib 2>&1 > /dev/null
:
:
open("/usr/lib", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 3
fstat64(3, {st_mode=3DS_IFDIR|0755, st_size=3D57344, ...}) =3D 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         =3D 0
getdents64(3, /* 120 entries */, 4096)  =3D 4096
getdents64(3, /* 65 entries */, 4096)   =3D 2568
getdents64(3, /* 111 entries */, 4096)  =3D 4088
:
:
getdents64(3, /* 59 entries */, 4096)   =3D 2152
getdents64(3, /* 10 entries */, 4096)   =3D 496
getdents64(3, /* 0 entries */, 4096)    =3D 0
close(3)                                =3D 0
write(1, "Acrobat5\nalchemist\nanaconda\nanac"..., 4096) =3D 4096
write(1, "libbonobo-2.a\nlibbonobo-2.so\nlib"..., 4096) =3D 4096
write(1, "ibgdbm.so\nlibgdbm.so.2\nlibgdbm.s"..., 4096) =3D 4096
write(1, "nica_qmxxx.la\nlibgphoto_konica_q"..., 4096) =3D 4096
write(1, ".so\nlibIDL-2.so.0\nlibIDL-2.so.0."..., 4096) =3D 4096
write(1, "libkpilot.so.0\nlibkpilot.so.0.0."..., 4096) =3D 4096
write(1, "ove.so.0\nlibospgrove.so.0.0.0\nli"..., 4096) =3D 4096
write(1, ".6\nlibsoundserver_idl.la\nlibsoun"..., 4096) =3D 4096
write(1, "lparse.so.0\nlibxmlparse.so.0.1.0"..., 1294) =3D 1294


> 6. fdisk does not support drives arger than 2TB, so I have to hack the=20
> partition tables and fake out dsfs with 3TB abd 4TB drives created with
> RAID 0 controllers and hardware. This needs to get fixed.

Use a different partition format (e.g. EFI or devicemapper) or none at all.
That is better than just ignoring the whole thing and some user thinking
"gee, I have all this free space here, maybe I'll make another partition".

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCNnr8pIg59Q01vtYRApBmAKDWNvufDbG6SgCl8tTsAXrF5sNQoQCfWCnQ
yBUBD6V20CJgeIB5wVMGjl8=
=KV0Y
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
