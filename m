Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbUJ1Eiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUJ1Eiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUJ1Eiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:38:55 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:15807 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262773AbUJ1Eis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:38:48 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: David Gibson <david@gibson.dropbear.id.au>,
       James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Date: Thu, 28 Oct 2004 14:38:33 +1000
Subject: Re: MAP_SHARED bizarrely slow
Message-ID: <20041028043832.GB13721@cse.unsw.EDU.AU>
References: <20041027064527.GJ1676@zax> <m3u0sgiq0b.fsf@lugabout.cloos.reno.nv.us> <20041027075944.GK1676@zax>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20041027075944.GK1676@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 27, 2004 at 05:59:44PM +1000, David Gibson wrote:
> With the entire input matrices all copies of the zero page, cache
> performance, oddly enough, would have been rather better...

I agree with your analysis.  Just for my own fun playing with
profiling, I ran the two tests on a 1.5Ghz Itanium 2 (I compiled with
the Intel compiler lest you all laugh at how slow the "Itanic" is at
multiplying matrices).

ianw@baci:/usr/src/tmp/maptest$ /usr/bin/time ./mm-sharemmap
9.58user 0.02system 0:09.61elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1540minor)pagefaults 0swaps
ianw@baci:/usr/src/tmp/maptest$ /usr/bin/time ./mm-sharemmap
9.47user 0.02system 0:09.50elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1540minor)pagefaults 0swaps
ianw@baci:/usr/src/tmp/maptest$ /usr/bin/time ./mm-privmmap
8.63user 0.00system 0:08.63elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1541minor)pagefaults 0swaps
ianw@baci:/usr/src/tmp/maptest$ /usr/bin/time ./mm-privmmap
8.63user 0.00system 0:08.63elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1541minor)pagefaults 0swaps

Both close, certainly nothing like some other reports.  But as with
all benchmarking the devil is in the details; watching the cache
misses:

ianw@baci:/usr/src/tmp/maptest$ pfmon --events=L3_MISSES ./mm-privmmap
                    112678 L3_MISSES
ianw@baci:/usr/src/tmp/maptest$ pfmon --events=L3_MISSES ./mm-sharemmap
                  68600586 L3_MISSES

So it's no wonder shared mmap takes a little longer.  And indeed,
modifying your program to touch the memory in the privmmap call brings
the two into line.

Also looking at the kernel profiling via q-syscollect, the only
significant difference is private mapping spends about 19% of it's
time in clear_page, whilst shared spends around 29% of it's time in
clear_page.  All things being equal, you can thus expect to run ~10%
slower with shared, which is pretty close to what you actually see.

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au


--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBgHfIWDlSU/gp6ecRAgo5AKDD4CvdTRIH8tTQSdGOHCBxjttmEQCfUsGv
3WmeXJTL4ItYTpeBYg7drXk=
=RMTc
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
