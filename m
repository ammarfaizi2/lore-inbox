Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130582AbQK2Q5b>; Wed, 29 Nov 2000 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130685AbQK2Q5V>; Wed, 29 Nov 2000 11:57:21 -0500
Received: from hermes.mixx.net ([212.84.196.2]:39428 "HELO hermes.mixx.net")
        by vger.kernel.org with SMTP id <S130582AbQK2Q5F>;
        Wed, 29 Nov 2000 11:57:05 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: 2.4.0-test11 ext2 fs corruption
Date: Wed, 29 Nov 2000 17:26:21 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A252E2D.F0C458BF@innominate.de>
In-Reply-To: <E2BA5DE1AE9@vcnet.vc.cvut.cz> <Pine.GSO.4.21.0011281520100.11331-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 975515195 27818 10.0.0.90 (29 Nov 2000 16:26:35 GMT)
X-Complaints-To: news@innominate.de
To: Alexander Viro <viro@math.psu.edu>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 28 Nov 2000, Petr Vandrovec wrote:
> 
> > > two ranges? Then it looks like something way below the fs level... Weird.
> > > Could you verify it with dd?
> >
> > Yes, it is identical copy. But I do not think that hdd can write same
> > data into two places with one command...
> >
> > vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=722433 | md5sum
> > 27+0 records in
> > 27+0 records out
> > 613de4a7ea664ce34b2a9ec8203de0f4
> > vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=558899 | md5sum
> > 27+0 records in
> > 27+0 records out
> > 613de4a7ea664ce34b2a9ec8203de0f4
> > vana:/#
> 
> Bloody hell... OK, let's see. Both ranges are covered by multiple files
> and are way larger than one page. I.e. anything on pagecache level is
> extremely unlikely - pages are not searched by physical location on
> disk. And I really doubt that it's ext2_get_block() - we would have
> to get a systematic error (constant offset), then read the data in
> for no good reason, then forget the page->buffers, then get the right
> values fro ext2_get_block(), leave the data unmodified _and_ write it.
> 
> It almost looks like a request in queue got fscked up retaining the
> ->bh from one of the previous (also coalesced) requests and having
> correct ->sector. Weird.
> 
> Linus, Andrea - any ideas? Situation looks so: after massive file creation
> a range of disk with the data from new files (many new files) got
> duplicated over another range - one with the data from older files
> (also many of them). 27 blocks, block size == 4Kb. No intersection
> between inodes, fsck is happy with fs, just a data ending up in two
> places on disk. No warnings from IDE or ext2 drivers.
> 
> Kernel: test11 built with 2.95.2, so gcc bug may very well be there.
> However, I really wonder what could trigger it in ll_rw_blk.c - 5:1
> that shit had hit the fan there.

I picked up a bug in ialloc.c back in February, for which I submitted a
poorly constructed patch (for which I was privately and properly flamed;
as I recall my subsequent attempts to post an improved version failed
for various reasons which may or may not include ORBS).  Anyway, the
basic idea is clear:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=95162877201890&w=2

I'll make a proper patch out of this if you like.  This *could* cause
the effect we're seeing here.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
