Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSFVFzh>; Sat, 22 Jun 2002 01:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFVFzg>; Sat, 22 Jun 2002 01:55:36 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:9713 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316538AbSFVFzg>; Sat, 22 Jun 2002 01:55:36 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 21 Jun 2002 23:53:18 -0600
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020622055318.GA22411@clusterfs.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Christopher Li <chrisl@gnuchina.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20020619113734.D2658@redhat.com> <20020619234340.A24016@redhat.com> <20020620005452.M5119@redhat.com> <E17LF65-0001K4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17LF65-0001K4-00@starship>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21, 2002  05:28 +0200, Daniel Phillips wrote:
> I ran a bakeoff between your new half-md4 and dx_hack_hash on Ext2.  As 
> predicted, half-md4 does produce very even bucket distributions.  For 200,000 
> creates:
> 
>    half-md4:        2872 avg bytes filled per 4k block (70%)
>    dx_hack_hash:    2853 avg bytes filled per 4k block (69%)
> 
> but guess which was faster overall?
> 
>    half-md4:        user 0.43 system 6.88 real 0:07.33 CPU 99%
>    dx_hack_hash:    user 0.43 system 6.40 real 0:06.82 CPU 100%
> 
> This is quite reproducible: dx_hack_hash is always faster by about 6%.  This 
> must be due entirely to the difference in hashing cost, since half-md4 
> produces measurably better distributions.  Now what do we do?

While I normally advocate the "cheapest" way of implementing a given
solution (and dx_hack_hash is definitely the lowest-cost hash function
we could reasonably have), I would still be inclined to go with half-MD4
for this.  A few reasons for that:
1) CPUs are getting faster all the time
2) it is a well-understood algorithm that has very good behaviour
3) it is much harder to spoof MD4 than dx_hack_hash
4) it is probably better to have the most uniform hash function we can
   find than to do lots more block split/coalesce operations, so the
   extra cost of half-MD4 may be a benefit overall

It would be interesting to re-run this test to create a few million
entries, but with periodic deletes.

Hmm, now that I think about it, split/coalesce operations are only
important on create and delete, while the hash cost is paid for each
lookup as well.  It would be interesting to see the comparison with
a test something like this (sorry, don't have a system which has both
hash functions working right now):

#!/bin/sh
DEV=/dev/hda7
TESTDIR=/mnt/tmp
date
for d in `seq -f "directory_name_%05g" 1 10000` ; do
	mkdir $TESTDIR/$d
	for f in `seq -f "file_name_%05g" 1 10000` ; do
		touch $TESTDIR/$d/$d_$f
	done
done
date
umount $TESTDIR
mount -o noatime $DEV $TESTDIR
date
for d in `seq -f "directory_name_%05g" 10000 -1 1` ; do
	for f in `seq -f "file_name_%05g" 10000 -1 1` ; do
		stat $TESTDIR/$d/$d_$f > /dev/null
	done
done
date

Having the longer filenames will put more load on the hash function,
so we will see if we are really paying a big price for the overhead,
and the stat test will remove all of the creation time and disk dirtying
and just leave us with the pure lookup costs hopefully.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

