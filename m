Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTCHWzS>; Sat, 8 Mar 2003 17:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTCHWzS>; Sat, 8 Mar 2003 17:55:18 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:5529 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262276AbTCHWzM>; Sat, 8 Mar 2003 17:55:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Date: Mon, 10 Mar 2003 00:10:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: tytso@mit.edu, bzzz@tmi.comex.ru, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <11490000.1046367063@[10.10.2.4]> <20030308045347.000223BC72@mx01.nexgo.de> <20030307214833.00a37e35.akpm@digeo.com>
In-Reply-To: <20030307214833.00a37e35.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030308230548.995B1FC4A3@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 08 Mar 03 06:48, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > OK, according to akpm, data=journal is broken at the moment.  Changing
> > the host filesystem to data=ordered allowed me to complete the test.
> >
> > Interesting results.  Creating the initial 30,000 directories ought to
> > take just a few seconds with the index, but instead it takes 5 minutes
> > and 9 seconds, while consuming only 5 seconds of cpu time.
>
> It takes 14 second here aganst a real disk, and 9 seconds against loop.

The best I've seen is 77 seconds to make the directories, on a fast scsi disk 
with 4K blocksize.  That's a 6 1/2 times difference, what could account for 
it?

> The difference: I used 4k blocksize.  1k blocksize should not be that bad:
> something is broken.
>
> Suggest you test against a real disk for now.  Using loop may skew things.

OK, I tested 1K and 4K blocksize on scsi, ide and ide-hosted loopback, the 
results are summarized here:

Make 30,000 directories:
	scsi 10K	ide 5400	loopback
1K	1m44.243s	4m59.757s	4m8.362s
4K	1m16.659s	4m49.827s	1m43.399s

Make one file in each directory:
	scsi 10K	ide 5400	loopback
1K	2m50.483s	7m28.657s	4m8.793s
4K	2m34.461s	5m45.615s	3m0.603s

Stat the tree (du):
	scsi 10K	ide 5400	loopback
1K	0m43.245s	1m52.230s	0m1.343s
4K	0m1.038s	0m2.056s	0m1.016s

The first thing to notice:  Alex Tomas's original complaint about Htree and 
stat doesn't manifest at all here.  Mind you, I did not repeat his exact 
sequence of tune2fs's etc, so it's possible there could be a utils bug or 
something.  I'll check into that later.  Meanwhile, these stats show other 
breakage that needs to be investigated.

The directory creation time is several times higher than it should be, the 
same for the file creates.  With the index, the two sets of operations should 
take about the same time.  Is this a journal problem?  My journal is about 8 
meg.  I can imagine the journal wrapping during the file creation, because of 
touching all the existing inode table blocks, but this should not happen 
during the directory creation.

The stats also show a huge slowdown for 1K blocksize on non-loopback, as you 
noticed earlier.   Hmm.  First: why on the raw device and not on loopback?  
Second: why does the device affect this at all?  This operation is r/o.  Hmm, 
except for atimes.  I reran the scsi tests with noatime+nodiratime and the 
stat times for 1K and 4K became nearly equal, about .75 seconds.  So there we 
have it: several tens of seconds are spent journalling dirty inode table 
blocks due to atime, but only when blocksize is 1K.  Big fat clue.

Stat the tree (du), noatime+nodtime:
	scsi 10K
1K	0m0.780s
4K	0m0.751s

The cpu numbers are in the detailed results below, and they show that Htree 
is doing its job, all the cpu numbers are tiny.  We've kicked around the idea 
that Htree is causing inode table thrashing, but I think that's the wrong 
tree to bark up.  Journal effects are looking more and more like the real 
problem, possibly in combination with IO scheduling.  The fact that Htree 
dirties the inode table out of order is just exposing some other underlying 
problem.

A quick look at slabinfo before and after unmounting the test volume shows 
that all the inodes we expect to be cached, actually are:

cat /proc/slabinfo | grep ext3_inode
ext3_inode_cache  121469 121473    448 13497 13497    1 :  120   60

sudo umount /mnt; cat /proc/slabinfo | grep ext3_inode
ext3_inode_cache   61506  61632    448 6836 6848    1 :  120   60

So there were about 60,000 inodes cached for that volume, exactly as 
expected.  So much for the theory that we're thrashing the inode table cache.
What's actually happening, I strongly suspect, is a lot of dirty blocks are 
getting pushed through the journal a little prematurely, without allowing any 
opportunity for coalescing.  At create time, it must be the directory blocks, 
not the inode table blocks, that cause the extra writeout, since inodes are 
being allocated (mostly) sequentially.

By the way, the script is a perfect trigger for the scheduler interactivity 
bug, leaving me mouseless for 4 seconds at a time.  I guess I'll apply 
Linus's patch and see if that goes away.

One other thing I noticed is that, when the script tries to umount 
immediately after the stat, I get "umount: /mnt: device is busy", however, 
after a few seconds it works fine.  This strikes me as a bug.

======================
1K blocksize, 10K rpm scsi
======================

Make directories...

real    1m44.243s
user    0m0.142s
sys     0m3.465s

Make one file in each directory...

real    2m50.483s
user    0m23.617s
sys     0m59.465s

Stat the tree...
30M     /mnt/test

real    0m43.245s
user    0m0.245s
sys     0m0.915s

======================
1K blocksize, 5400 rpm ide
======================

Make directories...

real    4m59.757s
user    0m0.138s
sys     0m5.207s

Make one file in each directory...

real    7m28.657s
user    0m24.351s
sys     0m58.941s

Stat the tree...
30M     /mnt/test

real    1m52.230s
user    0m0.261s
sys     0m1.013s

===================
1K blocksize, loopback
===================

Make directories...

real    4m8.362s
user    0m0.144s
sys     0m7.448s

Make one file in each directory...

real    4m8.793s
user    0m25.262s
sys     1m20.376s

Stat the tree...
30M     /mnt/test

real    0m1.343s
user    0m0.265s
sys     0m0.720s

======================
4K blocksize, 10K rpm scsi
======================

Make directories...

real    1m16.659s
user    0m0.152s
sys     0m4.106s

Make one file in each directory...

real    2m34.461s
user    0m23.555s
sys     0m58.533s

Stat the tree...
118M    /mnt/test

real    0m1.038s
user    0m0.242s
sys     0m0.664s

======================
4K blocksize, 5400 rpm ide
======================

Make directories...

real    4m49.827s
user    0m0.153s
sys     0m16.666s

Make one file in each directory...

real    5m45.615s
user    0m23.836s
sys     1m6.908s

Stat the tree...
118M    /mnt/test

real    0m2.056s
user    0m0.432s
sys     0m0.622s

===================
4K blocksize, loopback
===================

Make directories...

real    1m43.399s
user    0m0.149s
sys     0m10.806s

Make one file in each directory...

real    3m0.603s
user    0m25.568s
sys     1m34.851s

Stat the tree...
118M    /mnt/test

real    0m1.016s
user    0m0.318s
sys     0m0.588s

========
The script
========

#volume=test.img
#volume=/dev/hda5
volume=/dev/sdb5
mke2fs -j -F -b 4096 -g 1024 $volume
mount -t ext3 -o loop $volume /mnt
cd /mnt
mkdir test 
cd test

echo
echo Make directories...
time seq -f "%06.0f" 1 30000 | xargs mkdir

echo
echo Make one file in each directory...
time for i in `ls`; do cd $i && touch foo && cd .. ; done

echo
echo Stat the tree...
time du -hs /mnt/test

echo umount /mnt
