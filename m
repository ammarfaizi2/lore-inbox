Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWGXSWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWGXSWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWGXSWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:22:21 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41117 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932259AbWGXSWU (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:22:20 -0400
Message-Id: <200607241822.k6OIMJcY014229@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: Your message of "Mon, 24 Jul 2006 09:21:04 PDT."
             <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it> <E1G4Kpi-0001Os-AK@be1.lrz> <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com> <17604.27801.796726.164279@gargle.gargle.HOWL> <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu>
            <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153765339_3460P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 14:22:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153765339_3460P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jul 2006 09:21:04 PDT, Joshua Hudson said:
> On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> Actually, I walk from the source inode down to try to find the
> target inode. If not found, this is not attempting to create a loop.

The problem is that the "target inode" may not be the one obviously causing the
loop - you may be trying to link a directory into a/b/c, while the loop
is caused by a link from a/b/c/d/e/f/g back up to someplace.

Consider:

function mkdir_tree(foo) {
for i=1,3 do
  for j=1,3 do
   for k=1,3 do
	mkdir ${foo}/a${i}/b${j}/c${k}
}

mkdir_tree(x)
mkdir_tree(y)
mkdir_tree(z)

ln x/a2/b3/c3/d1 y
ln x/a1/b3/c3/d2 y
ln y/a1/b1/c3/d1 z
ln y/a1/b1/c2/d2 z
ln y/a1/b2/c1/d3 z

Now - ln z/a3/b1/c3/d1 x - how many directories do you need to
examine to tell if this is a loop?  Is it still a loop if I rm z/d1 first?
or z/d2? or do I need to remove z/d1 through z/d3 to prevent a loop?
Can I leave z/d1 there but remove y/a1/b2/c3/d1 instead?
Does your answer change if somebody did 'ln y/a1/b2/c4 z/a1/b3/d7'?

How many places would you have to look if I didn't give you a cheat sheet
of the ln commands I had done?  Yes, you have to search *every* directory
under x, y, and z.  All 120 of them.  And this is an artificially small
directory tree.  Think about a /usr/src/ that has 4 or 5 linux-kernel
trees in it, with some 1,650 directories per tree...

> Should be obvious that the average case is much less than the
> whole tree.

"The average case" is the one where the feature isn't used.  When you
actually *use* it, you get "not average case" behavior - not a good sign.

> > to screw things up (is 'mv a/b/c/d ../../w/z/b' safe? How do you know, without
> > examining a *lot* of stuff under a/ and ../../w/?
> 
> mv /a/b/c/d ../../w/z/b is implemented as this in the filesystem:
> ln /a/b/c/d ../../w/z/b && rm /a/b/c/d
> 
> So what it's going to do is try to find z under /a/b/c/d.

Even if that's sufficient (which it isn't), it's going to be painful to lock
the filesystem for 20 or 30 seconds while you walk everything to make sure
there's no problem.  


--==_Exmh_1153765339_3460P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExQ/bcC3lWbTT17ARAvXOAKCsB7YB8nSbE0HaGNKkQB6eA4oEdwCdEcD4
O6TAZN3lE/+By00RhYH71KY=
=8NMz
-----END PGP SIGNATURE-----

--==_Exmh_1153765339_3460P--
