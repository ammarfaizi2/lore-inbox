Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWJQMxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWJQMxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWJQMxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:53:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:45199 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWJQMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:53:52 -0400
Date: Tue, 17 Oct 2006 08:53:50 -0400
From: Mike Day <ncmike@ncultra.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: fuse: fix hang on SMP
Message-ID: <20061017125350.GA22327@silverwood.ncultra.org>
Reply-To: ncmike@ncultra.org
References: <20061016162709.369579000@szeredi.hu> <20061016162729.176738000@szeredi.hu> <20061016165125.4605824b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20061016165125.4605824b.akpm@osdl.org>
X-PGP-Key: http://www.ncultra.org/ncmike/pubkey.asc
X-PGP-Fingerprint: A2EE D0E6 21B7 0DEC 29B5  D5FD 3B27 3154 452B 7C21
x-gpg-key: http://www.ncultra.org/ncmike/pubkey.asc
x-gpg-fingerprint: A2EE D0E6 21B7 0DEC 29B5  D5FD 3B27 3154 452B 7C21
Organization: Ultra Adventures http://www.ncultra.org
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16/10/06 16:51 -0700, Andrew Morton wrote:
>On Mon, 16 Oct 2006 18:27:10 +0200
>Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> Fuse didn't always call i_size_write() with i_mutex held which caused
>> rare hangs on SMP/32bit.
>
>Yes, that is a bit of a trap.  I'll maintain a patch in -mm which spits a
>warning if i_size_write() is called without i_mutex held.
>

>+void i_size_write(struct inode *inode, loff_t i_size)
>+{
>+	WARN_ON_ONCE(!mutex_is_locked(&inode->i_mutex));


Miklos' patch would generate this warning because he uses the spinlock
inside struct fuse_conn to synchronize the write:

+static void fuse_vmtruncate(struct inode *inode, loff_t offset)
+{
+       struct fuse_conn *fc =3D get_fuse_conn(inode);
+       int need_trunc;
+
+       spin_lock(&fc->lock);
+       need_trunc =3D inode->i_size > offset;
+       i_size_write(inode, offset);
+       spin_unlock(&fc->lock);

--=20
Mike D. Day
IBM LTC
Cell: 919 412-3900
Sametime: ncmike@us.ibm.com AIM: ncmikeday  Yahoo: ultra.runner
PGP key: http://www.ncultra.org/ncmike/pubkey.asc

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFNNJeOycxVEUrfCERAtjeAJ4iV7gCDENajGV/7RyYqntPqllnJgCcDV7J
/5mG4g3xHUHs875Gzr27zGo=
=1S0z
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
