Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUI2Dq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUI2Dq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 23:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUI2Dq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 23:46:58 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15578 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268172AbUI2Dqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 23:46:53 -0400
Message-ID: <415A302E.5090402@comcast.net>
Date: Tue, 28 Sep 2004 23:46:54 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compressed filesystems:  Better compression?
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I wonder what compression Squashfs, cramfs, and zisofs use.  I think
cramfs uses zlib compression; I don't know of any other compression in
the kernel tree, so I assume zisofs uses the same, as does squashfs.  Am
I mistaken?

Doing a little digging, I've found the algorithm used by 7zip[1] (LZMA)
has been ported[2] to Linux.  This is a fairly high performance
algorithm which may be of interest to port into the kernel tree for
practical use, which I will list later.

[1] http://7-zip.org/
[2] http://students.fhs-hagenberg.ac.at/se/se00001/Projects_LZMA_.html

(unfortunately, the link to the code at [2] appears to be dead; I'm
contacting the author.)

In my own personal tests, I've gotten a 6.25% increase in compression
ratio over bzip2 using the above lzma code.  These were very weak tests
involving simply bunzipping a 32MiB tar.bz2 of the Mozilla 1.7 source
tree and recompressing it with lzma, which produced a 30MiB tar.lzma.  I
tried, but could not get it to compress much better than that (I think I
touched 29.5 at some point but not sure, it was a while ago).

The LZMA developer claims that BZ2:LZMA is roughly the same as GZ:BZ2;
so the gains can be predicted over zlib compression as being 12.5%.
This may be significant in some cases.  It is also notable that LZMA
decompression is quite fast, twice as fast as BZIP2 as claimed by the
LZMA page above.  It does take twice as long to compress, though.

LZMA uses a lot of memory to compress.  The more memory allotted, the
higher the compression ratio; parameters within the algorithm can be
freely adjusted to control this.  Decompression uses approximately 1/10
of the memory needed to compress.

The developer of the Linux LZMA port has been inactive for 6 months, it
appears.

The LZMA algorithm as with any compression may have several practical
uses in the Linux source tree.  Linux has a wide range of applications,
and is open to modifications which may benefit from available high
performance compression algorithms.

A good lzma compressed file system such as an enhanced SquashFS would
allow slightly more to fit on an initrd.  This would not be very
significant, amounting to approximately 128 kilobytes per megabyte of
compressed data based on above tests; but it would still allow initrds
to take up less space on disk.

Compressed file systems are also useful for Live CDs.  I'm very
interested in seeing a zisofs using lzma; 700M Knoppix[3] CDs may become
approximately 600M in the same content, allowing for possibly another
8-12% of data to be stored on them.  Consider that Knoppix is 2.0G to
start with, that's another 160-250M of content.

[3] http://knoppix.net/

With LZMA compression in tree, file systems that are enhanced with
compression in the future may opt to allow for the use the LZMA
algorithm.  This would produce better compression ratios.  I liked the
compression on NTFS about 2-3 years ago when I was using Windows 2000,
as it can even enhance performance on fast PCs (the hard disk is a
bottle neck) while lowering disk usage, providing wins on all sides.  :)

LZMA would possibly be appropriate for compressed memory systems such as
Rodrigo Castro's compressed page cache patch[4].  With small data sets,
the memory footprint could be reduced; allowing 30MiB of memory to
compress a 4KiB or 8KiB page is just ridiculous.  Furthermore, because
the operation is performed on small data sets, the performance overhead
would likely still be much more acceptable than swapping.

[4] http://linuxcompressed.sf.net/

Overall, porting LZMA into the kernel tree would allow for more
innovation to be made.  This is an ideal time to take these steps;
SquashFS, cramfs, and zisofs are to my knowledge native and exclusive to
Linux, and should be enhanced before other operating systems clone them.
~ Also, an RFC for LZMA and for ZISOFS may be in order.

For other LZMA code, 7-Zip could be examined, though porting from
Windows code may be hard.  The only arguments I can see here are that
nobody has time, or that they're busy with more important things :)

Any comments?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWjAthDd4aOud5P8RAlmcAJ4hfSFThNlm7MgF5w9o0TsUKQPutACfXvUX
GXX45z1oypnPSMTanq7n4Zk=
=asnn
-----END PGP SIGNATURE-----
