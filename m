Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUADM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUADM5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:57:24 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:42397 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S265508AbUADM5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:57:05 -0500
Date: Sun, 4 Jan 2004 13:57:03 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: linux-2.6.0(-mm2): I/O scheduler weirdness with LVM2
Message-ID: <20040104125702.GA4658@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I have posted some of this before, but didn't get any replies.
Now I have some more hard data, so hopefully things will get clearer.

I have a 3ware RAID5 setup with 7+1 200 GB SATA disks. On /dev/sda1
(first partition on the RAID volume) I can get up to 80 MB/sec
sequential write throughput.

Now if I create an LVM2 logical volume on top of it, sequential
write performance drops to ~60 MB/sec.

I have put some debugging in the 3ware driver to see in which
order it receives I/O requests, and it appears that when writing
sequentially to /dev/sda1, the write requests to the drive
are mostly submitted sequentially.

But when writing sequentially to /dev/vg0/mirror (logical volume),
the write requests to the 3ware driver are not ordered sequentially
anymore.

The volume group is setup with an 1G extent size, and I'm testing
with writes < 400 MB, which easily stay in the first extent. So
this is not due to remapping to different extents.

The debugging I put in the 3ware driver outputs lines in the
form "3wdbg: id 225, lba = 0x21bf, num_sectors = 8" where lba
is the start sector on the device and the rest speaks for itself.

Then I do a dd if=/dev/zero bs=4096 to both /dev/sda1 and the
logical volume, and capture the debug output. That is processed
by a script that counts how much of the I/O requests are
back-to-back sector-wise.

The output of that script is below for both cases.

It shows that in the LVM case, sequential I/O becomes more like
random I/O. It's very seeky. And it appears the firmware in
the 3ware driver is not smart enough to re-order the requests
internally, so performance drops 30-40%.

Another things is that when I/O is submitted to /dev/sda1, the
maximum number of sectors per request is 124 (?) with many smaller
requests mixed in, while when I/O is submitted to /dev/vg0/test,
the number of sectors per request is 256 in most cases.
That's much better - the total number of I/O requests for the
LVM device are half that of the RAID device, but because the
requests are not sequential, it turns out worse.

Now why is this happening? Device-mapper should just map 1:1,
right, why is it having such a weird influence ? And why is
I/O to /dev/sda1 limited to 124 sectors, while I/O to /dev/vg0/test
can be done in batches of 256 sectors ?

Tests were done on 2.6.0-mm2. Command used for sequential I/O was
"dd if=/dev/zero of=/dev/sda1 bs=4096 count=100000" (200 MB).
Because tests are on a blockdevice, closing it means fsync()ing it.
Tested with both the AS and deadline I/O scheduler, similar results.

[ it has to be said that running this test many times, sometimes
  sequential I/O to /dev/sda1 is also not submitted sequentially,
  but below is the common case]

** Request order for sequential writes to /dev/sda1, iosched-as:

Request: start 63, length 149604 sec (74802 KB), transactions: 1395
Request: start 149791, length 2480 sec (1240 KB), transactions: 20
Request: start 149667, length 124 sec (62 KB), transactions: 1
Request: start 152271, length 43416 sec (21708 KB), transactions: 367
Request: start 195811, length 1984 sec (992 KB), transactions: 16
Request: start 195687, length 124 sec (62 KB), transactions: 1
Request: start 197795, length 202268 sec (101134 KB), transactions: 1698
Number of "extents": 7
Total number of sectors: 400000 (200000 KB)
Total transactions: 3498

** Request order for sequential writes to /dev/vg0/test, iosched-as:

Request: start 447, length 81416 sec (40708 KB), transactions: 361
Request: start 81871, length 6352 sec (3176 KB), transactions: 26
Request: start 88231, length 3840 sec (1920 KB), transactions: 15
Request: start 81863, length 8 sec (4 KB), transactions: 1
Request: start 92071, length 4096 sec (2048 KB), transactions: 16
Request: start 96175, length 7936 sec (3968 KB), transactions: 31
Request: start 88223, length 8 sec (4 KB), transactions: 1
Request: start 96167, length 8 sec (4 KB), transactions: 1
Request: start 104119, length 7656 sec (3828 KB), transactions: 31
Request: start 111783, length 7936 sec (3968 KB), transactions: 31
Request: start 104111, length 8 sec (4 KB), transactions: 1
Request: start 111775, length 8 sec (4 KB), transactions: 1
Request: start 119727, length 7904 sec (3952 KB), transactions: 31
Request: start 127639, length 5568 sec (2784 KB), transactions: 31
Request: start 119719, length 8 sec (4 KB), transactions: 1
Request: start 127631, length 8 sec (4 KB), transactions: 1
Request: start 133215, length 7936 sec (3968 KB), transactions: 31
Request: start 141159, length 5824 sec (2912 KB), transactions: 31
Request: start 133207, length 8 sec (4 KB), transactions: 1
Request: start 141151, length 8 sec (4 KB), transactions: 1
Request: start 146991, length 7784 sec (3892 KB), transactions: 31
Request: start 154783, length 7936 sec (3968 KB), transactions: 31
Request: start 146983, length 8 sec (4 KB), transactions: 1
Request: start 154775, length 8 sec (4 KB), transactions: 1
Request: start 162727, length 7936 sec (3968 KB), transactions: 31
Request: start 170671, length 7936 sec (3968 KB), transactions: 31
Request: start 162719, length 8 sec (4 KB), transactions: 1
Request: start 170663, length 8 sec (4 KB), transactions: 1
Request: start 178615, length 7936 sec (3968 KB), transactions: 31
Request: start 186559, length 7672 sec (3836 KB), transactions: 31
Request: start 178607, length 8 sec (4 KB), transactions: 1
Request: start 186551, length 8 sec (4 KB), transactions: 1
Request: start 194239, length 7880 sec (3940 KB), transactions: 31
Request: start 202127, length 7936 sec (3968 KB), transactions: 31
Request: start 194231, length 8 sec (4 KB), transactions: 1
Request: start 202119, length 8 sec (4 KB), transactions: 1
Request: start 210071, length 7936 sec (3968 KB), transactions: 31
Request: start 218015, length 7936 sec (3968 KB), transactions: 31
Request: start 210063, length 8 sec (4 KB), transactions: 1
Request: start 218007, length 8 sec (4 KB), transactions: 1
Request: start 225959, length 7936 sec (3968 KB), transactions: 31
Request: start 233903, length 4880 sec (2440 KB), transactions: 31
Request: start 225951, length 8 sec (4 KB), transactions: 1
Request: start 233895, length 8 sec (4 KB), transactions: 1
Request: start 238791, length 7936 sec (3968 KB), transactions: 31
Request: start 246735, length 4328 sec (2164 KB), transactions: 31
Request: start 238783, length 8 sec (4 KB), transactions: 1
Request: start 246727, length 8 sec (4 KB), transactions: 1
Request: start 251071, length 7936 sec (3968 KB), transactions: 31
Request: start 259015, length 6144 sec (3072 KB), transactions: 24
Request: start 265415, length 256 sec (128 KB), transactions: 1
Request: start 265159, length 256 sec (128 KB), transactions: 1
Request: start 265671, length 1280 sec (640 KB), transactions: 5
Request: start 251063, length 8 sec (4 KB), transactions: 1
Request: start 259007, length 8 sec (4 KB), transactions: 1
Request: start 266959, length 7936 sec (3968 KB), transactions: 31
Request: start 274903, length 5896 sec (2948 KB), transactions: 31
Request: start 266951, length 8 sec (4 KB), transactions: 1
Request: start 274895, length 8 sec (4 KB), transactions: 1
Request: start 280807, length 7936 sec (3968 KB), transactions: 31
Request: start 288751, length 7424 sec (3712 KB), transactions: 29
Request: start 296431, length 256 sec (128 KB), transactions: 1
Request: start 296175, length 256 sec (128 KB), transactions: 1
Request: start 280799, length 8 sec (4 KB), transactions: 1
Request: start 288743, length 8 sec (4 KB), transactions: 1
Request: start 296695, length 7688 sec (3844 KB), transactions: 31
Request: start 304391, length 2392 sec (1196 KB), transactions: 10
Request: start 296687, length 8 sec (4 KB), transactions: 1
Request: start 304383, length 8 sec (4 KB), transactions: 1
Request: start 306783, length 93664 sec (46832 KB), transactions: 370
Number of "extents": 70
Total number of sectors: 400000 (200000 KB)
Total transactions: 1697

** Request order for sequential writes to /dev/sda1, iosched-deadline:

Request: start 63, length 256808 sec (128404 KB), transactions: 2307
Request: start 256995, length 124 sec (62 KB), transactions: 1
Request: start 256871, length 124 sec (62 KB), transactions: 1
Request: start 257119, length 51820 sec (25910 KB), transactions: 445
Request: start 309063, length 1612 sec (806 KB), transactions: 13
Request: start 308939, length 124 sec (62 KB), transactions: 1
Request: start 310675, length 89388 sec (44694 KB), transactions: 754
Number of "extents": 7
Total number of sectors: 400000 (200000 KB)
Total transactions: 3522

** Request order for sequential writes to /dev/vg0/test, iosched-deadline:

Request: start 447, length 91728 sec (45864 KB), transactions: 369
Request: start 92183, length 7776 sec (3888 KB), transactions: 31
Request: start 92175, length 8 sec (4 KB), transactions: 1
Request: start 99967, length 7832 sec (3916 KB), transactions: 31
Request: start 99959, length 8 sec (4 KB), transactions: 1
Request: start 107807, length 7936 sec (3968 KB), transactions: 31
Request: start 107799, length 8 sec (4 KB), transactions: 1
Request: start 115751, length 7872 sec (3936 KB), transactions: 31
Request: start 115743, length 8 sec (4 KB), transactions: 1
Request: start 123631, length 7936 sec (3968 KB), transactions: 31
Request: start 123623, length 8 sec (4 KB), transactions: 1
Request: start 131575, length 7840 sec (3920 KB), transactions: 31
Request: start 131567, length 8 sec (4 KB), transactions: 1
Request: start 139423, length 7864 sec (3932 KB), transactions: 31
Request: start 139415, length 8 sec (4 KB), transactions: 1
Request: start 147295, length 7936 sec (3968 KB), transactions: 31
Request: start 147287, length 8 sec (4 KB), transactions: 1
Request: start 155239, length 7936 sec (3968 KB), transactions: 31
Request: start 155231, length 8 sec (4 KB), transactions: 1
Request: start 163183, length 7520 sec (3760 KB), transactions: 31
Request: start 163175, length 8 sec (4 KB), transactions: 1
Request: start 170711, length 7936 sec (3968 KB), transactions: 31
Request: start 170703, length 8 sec (4 KB), transactions: 1
Request: start 178655, length 7936 sec (3968 KB), transactions: 31
Request: start 178647, length 8 sec (4 KB), transactions: 1
Request: start 186599, length 7936 sec (3968 KB), transactions: 31
Request: start 186591, length 8 sec (4 KB), transactions: 1
Request: start 194543, length 7936 sec (3968 KB), transactions: 31
Request: start 194535, length 8 sec (4 KB), transactions: 1
Request: start 202487, length 7728 sec (3864 KB), transactions: 31
Request: start 202479, length 8 sec (4 KB), transactions: 1
Request: start 210223, length 7640 sec (3820 KB), transactions: 31
Request: start 210215, length 8 sec (4 KB), transactions: 1
Request: start 217871, length 7728 sec (3864 KB), transactions: 31
Request: start 217863, length 8 sec (4 KB), transactions: 1
Request: start 225607, length 7896 sec (3948 KB), transactions: 31
Request: start 225599, length 8 sec (4 KB), transactions: 1
Request: start 233511, length 7832 sec (3916 KB), transactions: 31
Request: start 233503, length 8 sec (4 KB), transactions: 1
Request: start 241351, length 7824 sec (3912 KB), transactions: 31
Request: start 241343, length 8 sec (4 KB), transactions: 1
Request: start 249183, length 7736 sec (3868 KB), transactions: 31
Request: start 249175, length 8 sec (4 KB), transactions: 1
Request: start 256927, length 7800 sec (3900 KB), transactions: 31
Request: start 256919, length 8 sec (4 KB), transactions: 1
Request: start 264735, length 7936 sec (3968 KB), transactions: 31
Request: start 264727, length 8 sec (4 KB), transactions: 1
Request: start 272679, length 7824 sec (3912 KB), transactions: 31
Request: start 272671, length 8 sec (4 KB), transactions: 1
Request: start 280511, length 7936 sec (3968 KB), transactions: 31
Request: start 280503, length 8 sec (4 KB), transactions: 1
Request: start 288455, length 7936 sec (3968 KB), transactions: 31
Request: start 288447, length 8 sec (4 KB), transactions: 1
Request: start 296399, length 1992 sec (996 KB), transactions: 8
Request: start 296391, length 8 sec (4 KB), transactions: 1
Request: start 298391, length 102056 sec (51028 KB), transactions: 405
Number of "extents": 56
Total number of sectors: 400000 (200000 KB)
Total transactions: 1615

Mike.
