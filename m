Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUKWTcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUKWTcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUKWTax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:30:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61405 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261525AbUKWT3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:29:40 -0500
Message-Id: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: Debugging a memory leak in the 2.6.X kernel - how-to?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_295658507P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Nov 2004 14:29:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_295658507P
Content-Type: text/plain; charset=us-ascii

Scenario: Am running 2.6.10-rc2-mm2-V0.7.29-1 - and several times
in the last few days, *something* has been leaking memory in the kernel:

>From a /proc/slabinfo from last night:
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            10     10  16384    1    4 : tunables    8    4    0 : slabdata     10     10      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192          25926  25926   8192    1    2 : tunables    8    4    0 : slabdata  25926  25926      0
size-4096(DMA)         0      0   4096    1    1 : tunables   16    8    0 : slabdata      0      0      0
size-4096             50     50   4096    1    1 : tunables   16    8    0 : slabdata     50     50      0
size-2048(DMA)         0      0   2048    2    1 : tunables   16    8    0 : slabdata      0      0      0
size-2048             50     50   2048    2    1 : tunables   16    8    0 : slabdata     25     25      0

That gets pretty painful on a laptop that only has 256M of memory.

This morning, I've got:

size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            17     17  32768    1    8 : tunables    8    4    0 : slabdata     17     17      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            11     11  16384    1    4 : tunables    8    4    0 : slabdata     11     11      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192          10387  10387   8192    1    2 : tunables    8    4    0 : slabdata  10387  10387      0
size-4096(DMA)         0      0   4096    1    1 : tunables   16    8    0 : slabdata      0      0      0
size-4096             54     54   4096    1    1 : tunables   16    8    0 : slabdata     54     54      0
size-2048(DMA)         0      0   2048    2    1 : tunables   16    8    0 : slabdata      0      0      0
size-2048            104    118   2048    2    1 : tunables   16    8    0 : slabdata     59     59      0

All I've got so far is that in both cases, repeated looking at slabinfo showed
that the size-8192 was going up by several entries every few seconds - and that
when I killed 'gkrellm', the leaking immediately stopped.  However, I don't
know what gkrellm is doing to tickle the problem.  It *might* be the Dell i8k
module - gkrellm reads /proc/i8k.  Or it might be i8kfan, which is called by
gkrellm, and does some odd stuff to set the fan speeds.  Or it might be
something else.

Whatever it is, it doesn't *immediately* start leaking when gkrellm starts
up when I log in - this morning, I checked several times when I logged in:

% grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192            240    240   8192    1    2 : tunables    8    4    0 : sla                    bdata    240    240      0

Repeated checks for 2-3 minutes showed it slowly go up to 252, then drop back to 227.

A bit later:

% grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192          10170  10171   8192    1    2 : tunables    8    4    0 : sla                    bdata  10170  10171      0
[~]2 grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192          10233  10233   8192    1    2 : tunables    8    4    0 : sla                    bdata  10233  10233      0
[~]2 grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192          10254  10254   8192    1    2 : tunables    8    4    0 : sla                    bdata  10254  10254      0
[~]2 grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192          10266  10266   8192    1    2 : tunables    8    4    0 : sla                    bdata  10266  10266      0
[~]2 grep 8192 /proc/slabinfo 
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : sla                    bdata      0      0      0
size-8192          10308  10308   8192    1    2 : tunables    8    4    0 : sla                    bdata  10308  10308      0

That's checking every 2-3 seconds - about as fast as I could hit uparrow, enter,
and read the numbers and repeat.  After I killed gkrellm, it's sat solidly
in the 10380-10400 range for well over an hour.

*Possibly* related: I'm sitting at about 90% idle, but the load average
is showing as 1.15 - however, I'm *NOT* seeing any processes stuck in 'D' state
in the ps output.

Any advice how to shoot this one?

--==_Exmh_295658507P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBo4+jcC3lWbTT17ARAuwuAJ9xjF5MADeR2hVm00OnEPi54IyDfgCeNxxx
mjMCy3F8t+z35D+xl2yefZE=
=fEZo
-----END PGP SIGNATURE-----

--==_Exmh_295658507P--
