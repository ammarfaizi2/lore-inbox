Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTLDDMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLDDMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:12:54 -0500
Received: from h80ad25dc.async.vt.edu ([128.173.37.220]:7552 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261744AbTLDDMt (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:12:49 -0500
Message-Id: <200312040310.hB43AcHA005863@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Kallol Biswas <kbiswas@neoscale.com>
Cc: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem 
In-Reply-To: Your message of "Wed, 03 Dec 2003 13:07:56 PST."
             <1070485676.4855.16.camel@nucleon> 
From: Valdis.Kletnieks@vt.edu
References: <1070485676.4855.16.camel@nucleon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_372316766P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Dec 2003 22:10:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_372316766P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Dec 2003 13:07:56 PST, Kallol Biswas <kbiswas@neoscale.com>  said:
>       We have a requirement that a filesystem has to support
> encryption based on some policy. The filesystem also should be able 
> to store data in non-encrypted form. A search on web shows a few 
> encrypted filesystems like "Crypto" from Suse Linux, but we need a
> system  where encryption will be a choice per file. We have a hardware
> controller to apply encryption algorithm. If a filesystem provides hooks
> to use a hardware controller to do the encryption work then the cpu can
> be freed from doing the extra work.
> 
> Any comment on this?

1) Key management will be a royal pain in the posterior, especially if more
than one key is in use on the filesystem (either at the same time, or at
different times).

2) Encryption of files is not all it's cracked up to be, security-wise.  In
particular, it only really guards against an attacker who gets access to the
data while the key isn't accessible (in other words, it does NOT protect
against your root user, or against any trojan horse or other attack that reads
the files while they're accessible in a decrypted form).  You will probably
drive the user bonkers if they have to enter the key at each open() call,
unless you're in a high-enough security model that making it that difficult for
the legitimate user is called for, in which case...

3) Only encrypting some files means an *incredible* amount of data leakage -
even without the file data, you're leaking the file name (unless the directory
is also encrypted), and all the inode data.  That's data an attacker can use -
knowing that an "interesting" file is more than a megabyte in size, has a
filename that's 17 chars long, and was modified yesterday may be enough to tell
them something crucial.

4) Remember information leakage to /tmp and the like - it's pointless to use
crypto on a file that gets vi'ed and puts a copy in a plaintext /tmp for
recovery once the laptop gets stolen. ;)  Better bets here are using tmpfs for /
tmp (and encrypted swap on a loopback so if it DOES hit the disk it's not
useful).

All in all, you're probably better off just using PGP to encrypt individual
files, or an encrypted loopback.   Note that the following *will* work if you
don't want to burn a whole partition per user:

mkdir /crypto
mkdir /crypto/${USER}
chown ${USER} /crypto/${USER}

mkdir ~user/.crypto
dd if=/dev/zero of=~user/.crypto/diskfile bz=1M count=20
losetup -e AES ~user/.crypt/diskfile
mkfs /dev/loop/0

After that, 'mount -o loop,ecryption=aes ~user/crypto/diskfile /crypto/${USER}'
will do it.

(I've probably glossed over a bunch of utii-linux version dependencies - the exact details
are different between the 2.12 and 2.11+loop-aes-patch versions)

Amazingly enough, if you need more space, you can just unmount it, use something
like 'dd if=/dev/zero >> disfkile' to increase it, losetup it, fsck it, resize2fs it,
and remount it....

This is done with already-existing standard tools, and fulfills the requirement
(just put only the crucial files in there).  You can even use symlinks to
redirect (for instance) ~/.important into the encrypted space.

Writing stuff like a Gnome prompter for use at login is left as an excersize
for the reader ;)


--==_Exmh_372316766P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/zqWucC3lWbTT17ARAk12AKD4A8Vs/VSU4bqJ5pcUFPGBpUx0DACgiUQ5
bVZXNU1hoqbdAROErG6Zb30=
=3xi3
-----END PGP SIGNATURE-----

--==_Exmh_372316766P--
