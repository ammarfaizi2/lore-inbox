Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQKUIp0>; Tue, 21 Nov 2000 03:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129914AbQKUIpQ>; Tue, 21 Nov 2000 03:45:16 -0500
Received: from ns1.megapath.net ([216.200.176.4]:50446 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129340AbQKUIpI>;
	Tue, 21 Nov 2000 03:45:08 -0500
Message-ID: <3A1A2FFA.5040207@speakeasy.org>
Date: Tue, 21 Nov 2000 00:19:06 -0800
From: Miles Lane <miles@speakeasy.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test11 i686; en-US; m18) Gecko/20001120
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>,
        Matthew Dharm <mdharm@one-eyed-alien.net>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        Johannes Erdfelt <jerdfelt@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre7 -- The USB ORB Drive works vastly better when the media is formatted with FAT32.
In-Reply-To: <Pine.LNX.4.21.0011191011450.1077-100000@aerie> <003901c0527f$64585a50$6500000a@brownell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here's more information.

First, here's what hdparm tells me about the ORB drive
accessed using usb-storage over usb-ohci:

#> hdparm -t /dev/sda

	/dev/sda:
	Timing buffered disk reads:
	64 MB in 90.50 seconds = 724.15 kB/sec

#> hdparm -T /dev/sda

	/dev/sda:
	Timing buffer-cache reads:
	128 MB in  0.92 seconds = 139.13 MB/sec

I have performed two more sets of tests.

In the first, I created a 204800 KB file to copy to ORB
partitions. I made sure to copy the entire file once
before logging results. This was done to prime the cache.
I have 256MB of RAM.

Here is what dosfsck tells me about the default filesystem
created by running "mkfs.vfat <device>", which is what
I tested with when I sent my initial reports:

dosfsck 2.4 (26 Oct 1999)
dosfsck 2.4, 26 Oct 1999, FAT32, LFN
Boot sector contents:
System ID "mkdosfs"
Media byte 0xf8 (hard disk)
512 bytes per logical sector
65536 bytes per cluster
1 reserved sector
First FAT starts at byte 512 (sector 1)
2 FATs, 16 bit entries
67584 bytes per FAT (= 132 sectors)
Root directory starts at byte 135680 (sector 265)
512 root directory entries
Data area starts at byte 152064 (sector 297)
33626 data clusters (2203713536 bytes)
62 sectors/track, 68 heads
0 hidden sectors
4304474 sectors total
Checking for unused clusters.
/dev/sda1: 0 files, 0/33626 clusters

As you can see, this is a really large block size --
64KB, if I am interpreting this information correctly.

I ran dosfsck on my Windoze boot partition and got back:

dosfsck 2.4 (26 Oct 1999)
dosfsck 2.4, 26 Oct 1999, FAT32, LFN
Warning: FAT32 support is still ALPHA.
Boot sector contents:
System ID "MSWIN4.1"
Media byte 0xf8 (hard disk)
512 bytes per logical sector
4096 bytes per cluster
32 reserved sectors
First FAT starts at byte 16384 (sector 32)
2 FATs, 32 bit entries
8065536 bytes per FAT (= 15753 sectors)
Root directory start at cluster 29030 (arbitrary size)
Data area starts at byte 16147456 (sector 31538)
2016223 data clusters (3963482112 bytes)
63 sectors/track, 255 heads
63 hidden sectors
16161327 sectors total
Checking for unused clusters.
Checking free cluster summary.
/dev/hda1: 22454 files, 685711/2016223 clusters

So, Windoze's own filesystem uses 4KB blocks.

So I tested writing the 200MB file to ORB partitions
with the FAT 64KB blocksize and with the FAT 4KB blocksize.
This also shows that the filesystem I reported on was
using 16-bit FAT entries.

Here's what dosfsck reports on the 4KB filesystem I
tested today:

dosfsck 2.4 (26 Oct 1999)
dosfsck 2.4, 26 Oct 1999, FAT32, LFN
Warning: FAT32 support is still ALPHA.
Boot sector contents:
System ID "mkdosfs"
Media byte 0xf8 (hard disk)
512 bytes per logical sector
4096 bytes per cluster
32 reserved sectors
First FAT starts at byte 16384 (sector 32)
2 FATs, 32 bit entries
2148352 bytes per FAT (= 4196 sectors)
Root directory start at cluster 2 (arbitrary size)
Data area starts at byte 4313088 (sector 8424)
537006 data clusters (2199576576 bytes)
62 sectors/track, 68 heads
0 hidden sectors
4304474 sectors total
Checking for unused clusters.
Checking free cluster summary.
/dev/sda1: 1 files, 51201/537006 clusters


When I tested, I ran:

time cp test /mnt/orb1 && time sync

and then waited until the drive light on the
ORB drive turned green (which always coincided
with the sync completing).

So here are the results of copying that 200MB file
to an ORB partition formatted with 32-bit entries and
4KB blocksizes and copying to one formatted with
16-bit entries and 64KB blocksizes:

4KB blocks and 32-bit entries:

time cp test /mnt/orb1 && time sync
0.03user 3.83system 5:31.85elapsed
0.00user 2.54system 1:10.92elapsed

204800KB / 437 seconds = 468KB/sec.

64KB blocks and 16-bit entries:

time cp test /mnt/orb1 && time sync
0.01user 3.69system 0:22.35elapsed
0.00user 0.16system 0:01.33elapsed

204800KB / 403 seconds = 508KB/sec.

So, there is a slight improvement with the 64KB blocksize.
Not surprising.

Here's the info on my EXT2 test partition:

mke2fs -b 4096 /dev/sda1
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
269280 inodes, 538059 blocks
26902 blocks (5.00%) reserved for the super user
First data block=0
17 block groups
32768 blocks per group, 32768 fragments per group
15840 inodes per group

Copying the same file to the EXT2 partition gave the following
results:

time cp test /mnt/orb1 && time sync
0.21user 5.90system 1:15:21elapsed
0.00user 0.05system 0:01.08elapsed

204800KB / 4589 seconds = 45KB/sec.

So, even when using the same block sizes for FAT32 and EXT2,
the difference is very close to a factor of ten throughput
advantage to using FAT.

In my second test, I copied a directory tree containing 324
directories and files. "du -sk" reported the tree containing
21892KB of data.

Copying the tree to EXT2 (4KB blocks) required 640 seconds.

21892 KB / 640 seconds = 34KB/sec.

Copying the tree to a FAT32 partition with 4KB blocks took
85 seconds.

21892 KB / 85 seconds = 257KB/sec.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
