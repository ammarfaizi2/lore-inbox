Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTFYCIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 22:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTFYCIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 22:08:46 -0400
Received: from h80ad25f0.async.vt.edu ([128.173.37.240]:6528 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263542AbTFYCIo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 22:08:44 -0400
Message-Id: <200306250222.h5P2MiM9019201@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603) 
In-Reply-To: Your message of "Tue, 24 Jun 2003 23:26:09 +0200."
             <20030624232609.5887c159.skraw@ithnet.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <20030624174331.GA31650@alpha.home.local>
            <20030624232609.5887c159.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2053201648P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jun 2003 22:22:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2053201648P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Jun 2003 23:26:09 +0200, Stephan von Krawczynski said:

> sorry, you probably misunderstood my flaky explanation. What I meant was not 
a
> cached block from the _tape_ (obviously indeed a char-type device) but from t
he
> 3ware disk (i.e. the other side of the verification). Consider the tape
> completely working, but the disk data corrupt (possibly not from real reading
> but from corrupted cache).

Don't rule out odder explanations either.  True story follows.. ;)

I once had the misfortune of being the admin for a Gould PN/9080. UTX/32 1.2
came out, and since it changed the inode format on disk, it's dump/mkfs/restore
time.  So I take the last 3 full backups, and do 2 more complete dumps besides.
I checked, and *NO* I/O errors had been reported (and then I checked THAT by
giving it a known bad tape and seeing errors WERE reported).

Do the upgrade... and *every single* tape was 'not in dump/restore format'.

Finally traced it down (this was the days when oscilloscopes were still useful)
to a bad 7400 series chip on the tape controller.  The backplane was a 32-bit
bus, the tape was an 8-bit device - so there was a 4-to-1 mux that had a bad
chip.  Bit 3 would be correct for 4 bits, inverted for 4 bits, correct for
4, etc..  Tape drive *NEVER* complained, because what came over the *cable*
was correct, parity and all..

Oh, and I got the data back something like this:

cat > mangle.c
main() {
int muck[2];
  while (read(0,muck,8) == 8) {
	muck[1] ^= 0x20202020;
        write(1,muck,8);
  }
}
^D
cc -o mangle mangle.c
dd if=/dev/rmt0 bs=32k | ./mangle | restore -f -


--==_Exmh_-2053201648P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++Qd0cC3lWbTT17ARAj2tAKDiTC5PVUdnnstN8jiMkyFOgzHjOACfYLLq
Zhiwbs3jNxhooUvd9EQ/Ec0=
=E93W
-----END PGP SIGNATURE-----

--==_Exmh_-2053201648P--
