Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTKPUto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTKPUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:49:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:11459 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S263158AbTKPUtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:49:42 -0500
Date: Sun, 16 Nov 2003 21:42:05 +0100
From: Harald Welte <laforge@netfilter.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031116204205.GA15732@obroa-skai.de.gnumonks.org>
References: <20031115093833.GB656@obroa-skai.de.gnumonks.org> <20031115171843.GN24159@parcelfarce.linux.theplanet.co.uk> <20031115173310.GA4786@obroa-skai.de.gnumonks.org> <20031115203607.GP24159@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20031115203607.GP24159@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Setting Orange, the 28th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2003 at 08:36:07PM +0000, viro@parcelfarce.linux.theplanet.=
co.uk wrote:

> > So who is the caller? it's the ->open() member of struct
> > file_operations.  and struct file_operations doesn't have some private
> > member where I could hide my pointer before saving it to
> > seq_file.private in seq_open().
>=20
> If arguments of ->open() were not enough to find your data, how the hell =
would
> current code manage to find it?
>=20
> You've got inode; you've got (if that's on procfs) proc_dir_entry - from
> inode; you've got dentry (from struct file *).  If that's not enough to
> find your data, what is?

thanks, I've now found a way to deal with the problem.  after calling
create_proc_entry(), I put a pointer to my hash table in
proc_dir_entry->data.  The proc_dir_entry->proc_fops->open() function
then calls seq_open() and sets seq_file->private to PDE(inode).  This
way the seq_operations->start/next/show functions can find out the=20

> Which files do you have in mind?

It's not part of the stock kernel, but something I've been working on
the last couple of days.  An iptables match module called 'dstlimit'.
(http://cvs.netfilter.org/netfilter-extensions/matches_targets/dstlimit/)

This match creates a new hash table (yes a table, not just an entry) for
every rule in which you use that match.  Mainly for testing/debugging
purpose, I want to be able to read the contents of each hash table via a
/proc file (/proc/net/ipt_dstlimit/*).

The implementation is now done in the way I described above, and it
seems to be working quite fine.

Thanks to everybody helping me with this issue.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/t+EdXaXGVTD0i/8RAgvwAKCyl5+5doWBry/n2JuSHXdk6xG54QCdFhrU
TMyfVHuNKIkCE3c2O4TkWiI=
=xwFi
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
