Return-Path: <linux-kernel-owner+w=401wt.eu-S965374AbXATUK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965374AbXATUK0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbXATUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:10:25 -0500
Received: from [139.30.44.16] ([139.30.44.16]:18206 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965371AbXATUKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:10:24 -0500
Date: Sat, 20 Jan 2007 21:10:22 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
In-Reply-To: <200701201952.54714.ismail@pardus.org.tr>
Message-ID: <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu>
 <200701201952.54714.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="512430124-1931971081-1169323822=:23674"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--512430124-1931971081-1169323822=:23674
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 20 Jan 2007, Ismail D=C3=B6nmez wrote:

> 20 Oca 2007 Cts 19:45 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1=
n=C4=B1z:
> [...]
> > > vaio cartman # hdparm -tT /dev/hda
> > >
> > > /dev/hda:
> > >  Timing cached reads:   1576 MB in  2.00 seconds =3D 788.18 MB/sec
> > >  Timing buffered disk reads:   74 MB in  3.01 seconds =3D  24.55 MB/s=
ec
> > >
> > >
> > > [~]> time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024
> > > 1024+0 records in
> > > 1024+0 records out
> > > 1073741824 bytes (1,1 GB) copied, 77,2809 s, 13,9 MB/s
> > >
> > > real    1m17.482s
> > > user    0m0.003s
> > > sys     0m2.350s
> >
> > That's not bad at all ! I suspect that if your system becomes unrespons=
ive,
> > it's because real writes start when the cache is full. And if you fill
> > 512 MB of RAM with data that you then need to flush on disk at 14 MB/s,=
 it
> > can take about 40 seconds during which it might be difficult to do
> > anything.
> >
> > Try lowering the cache flush starting point to about 10 MB if you want
> > (2% of 512 MB) :
> >
> > # echo 2 >/proc/sys/vm/dirty_ratio
> > # echo 2 >/proc/sys/vm/dirty_background_ratio
>=20
> After that I get,
>=20
> [~]>  time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1,1 GB) copied, 41,7005 s, 25,7 MB/s
>=20
> real    0m41.926s
> user    0m0.007s
> sys     0m2.500s
>=20
>=20
> not bad! thanks :)

Note that these dd "benchmarks" are completely bogus, because the data=20
doesn't actually get written to disk in that time. For some enlightening=20
data, try

  time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024; time sync

The dd returns as soon as all data could be buffered in RAM. Only sync=20
will show how long it takes to actually write out the data to disk.
also explains why you see better results is writeout starts earlier.

Tim
--512430124-1931971081-1169323822=:23674--
