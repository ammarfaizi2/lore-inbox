Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDPTGf>; Mon, 16 Apr 2001 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDPTGZ>; Mon, 16 Apr 2001 15:06:25 -0400
Received: from unthought.net ([212.97.129.24]:45458 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131974AbRDPTGF>;
	Mon, 16 Apr 2001 15:06:05 -0400
Date: Mon, 16 Apr 2001 21:06:03 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
Message-ID: <20010416210603.A10915@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E14oxbX-0000oM-00@sites.inka.de> <01041521302600.15046@tabby> <p05100b09b7000a8c3bc9@[207.213.214.34]> <01041522295701.15046@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <01041522295701.15046@tabby>; from jesse@cats-chateau.net on Sun, Apr 15, 2001 at 09:51:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2001 at 09:51:52PM -0500, Jesse Pollard wrote:
...
> 
> If I've got the numbering right;
> 	0 - concatenated stripes => no sync required
> 	1 - mirrored => resync required
> 		a: which drive has the correct info?

a: there are timestamps in the superblocks.  one disk is simply chosen as
   the "newest", and the other disks are updateed from that one.

> 		b: having determined that, read the correct block,
> 		   it must now be written to the mirror.
> 	all others => resync required (rebuild possible bad block)

If a resync is required, it is because we can derive the correct information
*without* having the array in sync  (resync puts correct information in places
where we know it's not currently correct).   fsck can never see "old" information,
no matter the state of the resync.  If it could, RAID would be broken.

Levels 1, 4 and 5 need a resync - but they all give you the correct
information even *before* resync.

Levels 0 and linear cannot be synced (and will fail if you pull a disk, all because
they do not have redundant information).   Talking about sync in these cases doesn't
make sense.

> 
> >Is this a pathological case because of the way fsck does business, or does
> >the RAID re-sync affect any disk-bound process that severely?
> 
> My experience has been with hardware raid, and even then there has been
> a 1-5% decrease in I/O during resync (not accurately measured - fsck took
> longer, and then only when the channel is maxed out -- otherwise the 1-5% is
> not visible; filesystem was 3 IRIX efs, spread across two raid luns).

I think the problem is that RAID throttles based on bandwidth, not based on
requests.  If fsck needs a lot of seeking, the RAID code won't notice that
the array is being used much, and thus won't throttle a lot.

Also, even if fsck does large sequential reads, the RAID code may throttle,
but it will then introduce small frequent seeks to when it updates a few
blocks every now and then.  Seeks have a huge impact on otherwise sequential
reads.

> 
> fsck is particularly bad, since nearly every read instigates a write to
> the mirror drive. Fsck can then modify the block and write it back, causing
> two more writes; for a total of 3 writes for a read (worst case).

Oh, do we resync blocks that are read ? I didn't know that actually...

This should give little overhead on RAID-1, since most reads would be done
on one disk and the "older disk" (the one being synced with information from
the newer one) would only be written to.

> 
> It does mean that when fsck finishes, MOST of the re-sync will be finished.
> All of the metadata will be synced, and only file data blocks will remain.
> 

If we resync RAID-1 blocks as they are read, I don't understand the claimed
performance impact of resync.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
