Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCIPkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCIPkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVCIPkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:40:19 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:9869 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261631AbVCIPj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:39:58 -0500
Date: Wed, 9 Mar 2005 16:36:23 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Weber Matthias <weber@faps.uni-erlangen.de>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Writing data > PAGESIZE into kernel with proc fs
Message-ID: <20050309153620.GA30232@vagabond>
References: <09766A6E64A068419B362367800D50C0B58A58@moritz.faps.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <09766A6E64A068419B362367800D50C0B58A58@moritz.faps.uni-erlangen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 11:26:30 +0100, Weber Matthias wrote:
> On Tue, Mar 08, 2005 at 20:05:42 +0100, Weber Matthias wrote:
> >> is there any chance to signal an EOF when writing data to kernel via p=
roc fs? >> Actually if the length of data is N*PAGE_SIZE it seems not to be=
 detectable.=20
> >> I followed up the "struct file" but haven't found anything that helped=
=2E..
>=20
> > End-of-file is signified by closing the file. As usual.
>=20
> Having only this struct describing an proc entry, i have no idea on how t=
o detect when the file is closed. For this i expect to register a callback =
function but where and how?
>=20
> struct proc_dir_entry {
> 	unsigned int low_ino;
> 	unsigned short namelen;
> 	const char *name;
> 	mode_t mode;
> 	nlink_t nlink;
> 	uid_t uid;
> 	gid_t gid;
> 	unsigned long size;
> 	struct inode_operations * proc_iops;
> 	struct file_operations * proc_fops;
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When it comes to that, you can always prepare your won file operations
instead of the default ones (that use read_proc and write_proc) below
and turn the proc entry into whatever you want.

> 	get_info_t *get_info;
> 	struct module *owner;
> 	struct proc_dir_entry *next, *parent, *subdir;
> 	void *data;
> 	read_proc_t *read_proc;
> 	write_proc_t *write_proc;
> 	atomic_t count;		/* use count */
> 	int deleted;		/* delete flag */
> };

The simple way of working with proc files is to have userland just fill
in the buffer and process that buffer when you need to, not when the
userland sends the data. So you just take the "data" buffer when you
need it.

When you need something more fancy, you simply create your own
proc_fops. That has read and write functions, where you need to take
care of the offset yourself, but you can treat each open separately
(open is called when userland process opens your proc entry and IIRC
fput or release or something like that when it closes it (you do NOT
want "close" -- that might be called more than once for one open)), turn
it into character-device-alike, implement ioctl, implement select/poll
on your entry and other fancy stuff.

Of course, you can copy the default proc_fops and only implement the
ones you actualy need different.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLxf0Rel1vVwhjGURAvxiAKDfwa2FLfKKWK0LvZ/J8ofSr64btgCfZcvr
8LTCjOYhh+J/ZV0EDhMu4Uk=
=I8rr
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
