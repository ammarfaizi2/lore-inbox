Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbQKSJay>; Sun, 19 Nov 2000 04:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132381AbQKSJaq>; Sun, 19 Nov 2000 04:30:46 -0500
Received: from ns1.megapath.net ([216.200.176.4]:25357 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S132373AbQKSJab>;
	Sun, 19 Nov 2000 04:30:31 -0500
Message-ID: <3A1797A5.4060003@speakeasy.org>
Date: Sun, 19 Nov 2000 01:04:37 -0800
From: Miles Lane <miles@speakeasy.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test11 i686; en-US; m18) Gecko/20001117
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: [Linux-usb-users] Re: 2.4.0-test11-pre7 -- The USB ORB Drive works vastly better when the media is formatted with FAT32.]
Content-Type: multipart/mixed;
 boundary="------------020805090407040707090304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805090407040707090304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Dear kernel hackers,

I am forwarding this message to you because the problem discussed
touches on several areas of the kernel:  filesystems, SCSI and
USB.

I am including my original bug report sent to linux-usb-users
here:

---------------------

As you may or may not have been aware, there have been complaints
for a while that data transfer rates when writing to an EXT2
partition has been less than stellar.  People have invariably
comparing Windoze with VFAT formatted ORB media with Linux and
EXT2 formatted media.

Last night I went through a series of tests where I tried
EXT2 formatted with varying block sizes.  I found that the larger
the block size, the better the transfer rate.  The largest allowable
blocksize for EXT2 is 4096.

Now, the transfer rate for copying /usr/src/xc to /mnt/orb1/test
was as follows:

One Linux Partition + EXT2       2140 KB / 159 secs. =  13.5 KB / sec.
using a 1KB block size

One Linux Partition + EXT2        7296 KB / 149 secs. =    48 KB / sec.
using a 4KB block size

One Linux Partition + FAT32      88512 KB /  78 secs. = 1,134 KB / sec.
One Linux Partition + FAT32     192192 KB / 233 secs. =   824 KB / sec.
Linux partition + FAT32     162912 KB / 133 secs. = 1,224 KB / sec.
Linux partition + FAT32      96296 KB / 198 secs. =   486 KB / sec.
Win95 FAT32 partition + FAT32    116640 KB / 120 secs. =   972 KB / sec.
Win95 FAT32 partition + FAT32    160912 KB / 313 secs. =   514 KB / sec.

I would really appreciate it if someone better able to analyze
the usb-storage logs and lowlevel filesystem activity would determine
why I am seeing such huge variability in throughput.

Note that with all the tests, I was copying a portion of /usr/src/xc
to /mnt/orb1/test.

Also, I observed that when writing to the FAT32 partitions,
the throughput would occasionally drop off sharply for a few seconds
before resuming a more rapid rate.

I have performed all this testing without USB Storage Debugging
enabled.  I wanted to make sure that the overhead of writing the
logfile didn't muddy the results.

All this testing is with 2.4.0-test11-pre7 and the OHCI HCD.

--------------------------

Here's a message that contains the gist of the discussion
thus far:

-------- Original Message --------
Date: Sat, 18 Nov 2000 13:52:00 -0800
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: Miles Lane <miles@speakeasy.org>
CC: ken_coleman@iname.com, Alexy Khrabrov <alexy.khrabrov@setup.org>,
    andy_liaw@merck.com, David Brownell <david-b@pacbell.net>,
    Johannes Erdfelt <jerdfelt@valinux.com>,
    "Dunlap, Randy" <randy.dunlap@intel.com>,
    Linux USB users <linux-usb-users@lists.sourceforge.net>

On Sat, Nov 18, 2000 at 01:28:21PM -0800, Miles Lane wrote:
 > Matthew Dharm wrote:
 >
 > > I'm guessing what you're seeing is a function of the overhead in the
 > > protocol for USB communication being diluted down.  Realize that a 1KB
 > > block has 4 times the overhead of a 4KB block (on a per-byte-of-data
 > > basis).  The usb-storage driver attempts to get the SCSI layer to give it
 > > the largest requests possible, but that layer is limited by what the
 > > filesystem layer is willing to give.
 >
 > That sounds true for the EXT2 tests.  Someone would need to look more
 > closely to determine if this is really what's happening, though.
 > Perhaps this would require reading a SCSI log.

You should be able to see this if you look at the usb-storage log.  What is
the data transfer that happens with a WRITE command?

 > > To fix this, I'd imagine that we'd need to resdesign part of VFS and SCSI
 > > to be able to express and respond to preferred sizes of data transfers.
 >
 > That would be cool.

And difficult.  Clearly a 2.5.x feature.

 > > You may also be seeing some caching artifacts.  Did you make sure to flush
 > > the cache before each test, or at least guarantee that the source was
 > > always in cache for the tests?
 >
 > Well, that might account for some of the variability in the
 > throughput.  It wouldn't account for the occasional dropoffs,
 > though.
 >
 > So far, noone has explained why there is an order of magnitude
 > difference in throughput for FAT32 partitions verses EXT2 partitions.
 > That's what interests me the most.

Good question.  I wish I had an answer for that.  I wonder if it has to do
with the new VM in some way....

Matt

------------------------------

I would appreciate any help you might be able to offer in fixing
the throughput problem when EXT2 is used on an ORB drive partition.

Best wishes,

	Miles

--------------020805090407040707090304
Content-Type: text/plain;
 name="nsmail.tmp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsmail.tmp"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6FvoAz64nssGU+ykRApAfAKDyNUyoLIevC7HsZZPiMoM/ADpsMgCeO4Pi
lUPGQw/LzBIzlqDo/KZUs7s=
=rj2q
-----END PGP SIGNATURE-----


--------------020805090407040707090304--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
