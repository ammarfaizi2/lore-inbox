Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVD1DJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVD1DJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 23:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1DJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 23:09:03 -0400
Received: from bee.hiwaay.net ([216.180.54.11]:30107 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S261834AbVD1DI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 23:08:57 -0400
Date: Wed, 27 Apr 2005 22:08:56 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: RFH: ext3 on EVMS on SW-RAID1 problem
Message-ID: <20050428030856.GA699498@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427114648.GA17153@titan.lahn.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Philipp Matthias Hahn <pmhahn@titan.lahn.de> said:
>One of our university fileservers shows strange problems since last
>friday. Syslog show the following messages:
>	attempt to access beyond end of device
>	dm-8: rw=0, want=8589934592, limit=262142
>The strange thing: If I mount a disk-image of that volume via loop,
>everything works fine!
>
>The server was running Debian sarge with an unpatched 2.6.11.6 than, but
>is running an 2.6.11.7 now and still shows the same problem.
>EVMS is version 2.5.2-1 and DevMapper is version 1.01.00-4.

I see a similar problem under recent Fedora Core 3 kernels with LVM2.
It appears when I create a snapshot of a volume.  See Red Hat's
Bugzilla:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=152162

Exact steps I used to reproduce the problem (which also results in file
corruption, even when reading from the non-snapshot volume).  I used a
scratch partition, /dev/sda8:

########################################################################
# create the software RAID as a 2 device mirror with 1 missing
mdadm -C -l 1 -n 2 /dev/md0 /dev/sda8 missing

# create the LVM setup
pvcreate /dev/md0
vgcreate lvtest /dev/md0
lvcreate -L100m -n test lvtest

# make a filesystem and put some data on it
mke2fs -j /dev/lvtest/test
mount /dev/lvtest/test /mnt
cp --preserve=all -r /boot/* /mnt/
umount /mnt
blockdev --flushbufs /dev/lvtest/test

# now mount it, create a snapshot, and see the result
mount /dev/lvtest/test /mnt
lvcreate -s -L10m -n snap /dev/lvtest/test
diff -ur /boot /mnt
########################################################################

The output I got from diff was:

diff: /mnt/System.map-2.6.10-1.766_FC3: Input/output error

and I got a bunch of messages like:

attempt to access beyond end of device
dm-4: rw=0, want=8300006146, limit=204800
Buffer I/O error on device dm-4, logical block 4150003072

from the kernel.  These only seem to appear sometimes - other times I
get file corruption (although the corruption appears to be
block-aligned).

If I then do:

########################################################################
lvremove /dev/lvtest/snap
umount /mnt
blockdev --flushbufs /dev/lvtest/test
mount /dev/lvtest/test /mnt
diff -ur /boot /mnt
########################################################################

It compares with no errors.

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
