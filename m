Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbRGMWHH>; Fri, 13 Jul 2001 18:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbRGMWGr>; Fri, 13 Jul 2001 18:06:47 -0400
Received: from zeus.kernel.org ([209.10.41.242]:41679 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267558AbRGMWGj>;
	Fri, 13 Jul 2001 18:06:39 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107132204.f6DM4TR3014602@webber.adilger.int>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010714090703.B5737@weta.f00f.org> "from Chris Wedgwood at Jul
 14, 2001 09:07:03 am"
To: Chris Wedgwood <cw@f00f.org>
Date: Fri, 13 Jul 2001 16:04:29 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris writes:
> On Fri, Jul 13, 2001 at 02:41:52PM -0600, Andreas Dilger wrote:
> 
>     Yes, RAID should have a journal or other ordering enforcement, but
>     it really isn't any worse in this regard than a single disk.  Even
>     on a single disk you don't have any guarantees of data ordering,
>     so if you change the file and the power is lost, some of the
>     sectors will make it to disk and some will not => fsck, with
>     possible data corrpution or loss.
> 
> How so? On a single disk you can either disable write-caching or for
> SCSI disks you can use barriers of sorts.
> 
> At which time, you can either assume a sector is written or not.

Well, I _think_ your statement is only true if you are using rawio.
Otherwise, you have a minimum block size of 1kB (for filesystems at
least) so you can't write less than that, and you could potentially
write one sector and not another.

I'm not sure of the exact MD RAID implementation, but I suspect that
if you write a single sector*, it will be exactly the same situation.
However, it also has to write the parity to disk, so if you crash at
this point what you get back depends on the RAID implementation**.

As Alan said in another reply, with IDE disks, you have no guarantee
about write caching on the disk, even if you try to turn it off.

If you are doing synchronous I/O from your application, then I don't
think a RAID write will not complete until all of the data+parity I/O
is complete, so you should again be as safe as with a single disk.

If you want safety, but async I/O, use ext3 with full data journaling
and a large journal.  Andrew Morton has just done some testing with
this and the performance is very good, as long as your journal is big
enough to hold your largest write bursts, and you have < 50% duty
cycle for disk I/O (i.e. you have to have enough spare I/O bandwidth
to write everything to disk twice, but it will go to the journal in a
single contiguous (synchronous) write and can go to the filesystem
asynchronously at a later time when there is no other I/O).  If you
put your journal on NVRAM, you will have blazing synchronous I/O.

Cheers, Andreas

*) You _may_ be limited to a larger minimum write, depending on the stripe
   size, I haven't looked closely at the code.  AFAIK, MD RAID does not
   let you stripe a single sector across multiple disks (nor would you
   want to), so all disk I/O would still be one or more single sector I/Os
   to one or more disks.  This means the sector I/O to each individual
   disk is still atomic, so it is not any worse than writes to a single
   disk (the parity is NOT atomic, but then you don't have parity at
   all on a single disk...).

**) As I said in my previous posting, it depends on if/how MD RAID does
   write ordering of I/O to the data sector and the parity sector.  If
   it holds back the parity write until the data I/O(s) are complete, and
   trusts the data over parity on recovery, you should be OK unless you
   have multiple failures (i.e. bad disk + crash).  If it doesn't do this
   ordering, or trusts parity over data, then you are F***ed (I doubt it
   would have this problem).
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
