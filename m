Return-Path: <linux-kernel-owner+w=401wt.eu-S1161006AbXALWBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXALWBu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbXALWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:01:50 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:46502 "EHLO zlynx.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161006AbXALWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:01:49 -0500
X-Greylist: delayed 1301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 17:01:49 EST
Subject: Disk Cache, Was: O_DIRECT question
From: Zan Lynx <zlynx@acm.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Chris Mason <chris.mason@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
In-Reply-To: <45A7F7A7.1080108@tls.msk.ru>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
	 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
	 <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
	 <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>
	 <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru>
	 <45A7F4F2.2080903@tls.msk.ru>  <45A7F7A7.1080108@tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-22baabuif2gkOcQDJTDX"
Date: Fri, 12 Jan 2007 14:39:27 -0700
Message-Id: <1168637967.183616.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-22baabuif2gkOcQDJTDX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-01-13 at 00:03 +0300, Michael Tokarev wrote:
[snip]
> And sure thing, withOUT O_DIRECT, the whole system is almost dead under t=
his
> load - because everything is thrown away from the cache, even caches of /=
bin
> /usr/bin etc... ;)  (For that, fadvise() seems to help a bit, but not alo=
t).

One thing that I've been using, and seems to work well, is a customized
version of the readahead program several distros use during boot up.

Mine starts off doing:
mlockall(MCL_CURRENT|MCL_FUTURE);
...yadda, yadda...

and for each file listed:
...open, stat stuff...
       if( NULL =3D=3D mmap(
                NULL, stat_buf.st_size,=20
                PROT_READ, MAP_SHARED|MAP_LOCKED|MAP_POPULATE,
                fd, 0)
        ) {
                fprintf(stderr, "'%s' ", file);
                perror("mmap");
        }
...more stuff...
and then ends with:
pause();
and it sits there forever.

As far as I can tell, this makes the program and library code stay in
RAM.  At least, after a drop_caches nautilus doesn't load 12 MB off
disk, it just starts.  It has to be reloaded after software updates and
after prelinking.  I find the 250 MB used to be worthwhile, even if its
kinda Windowsey.

Something like that could keep your system responsive no matter what the
disk cache is doing otherwise.
--=20
Zan Lynx <zlynx@acm.org>

--=-22baabuif2gkOcQDJTDX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFqAAPG8fHaOLTWwgRAtXXAJsEivMDZGuKNMQQdDYtCaJa28w8CwCeJ2fI
sB9rPrBdXdK3Kde8edDxZoY=
=5UcK
-----END PGP SIGNATURE-----

--=-22baabuif2gkOcQDJTDX--

