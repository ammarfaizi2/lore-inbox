Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSBOC0h>; Thu, 14 Feb 2002 21:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBOC01>; Thu, 14 Feb 2002 21:26:27 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:47529 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S286322AbSBOC0S>; Thu, 14 Feb 2002 21:26:18 -0500
Date: Thu, 14 Feb 2002 21:25:42 -0500
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] write barriers for 2.4.x
Message-ID: <3735390000.1013739942@tiny>
In-Reply-To: <E16bX3x-0001nu-00@the-village.bc.nu>
In-Reply-To: <E16bX3x-0001nu-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 15, 2002 01:21:20 AM +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> sure we only try to use tag commands when they are turned on for the
>> target, otherwise we can safely assume the drive won't do
>> other writes first.
> 
> Is this guaranteed by the SCSI standards or do you need to issue some
> kind of cache flush as with IDE ?

We're sending the scsi ordered queue tag command, which the spec
says will be written after anything already received by the target,
and before anything it receives later on.  I have no data
at all how well the drives follow the spec ;-)

The IDE changes issue cache flushes before the barrier write,
and then another flush after it, which gives us similar semantics.

> 
>> With -o barrier, this is now:
>> 
>> write X log blocks
>> write 1 commit block
>> wait.
> 
> That will work nicely with the I2O controllers, and possibly (if its
> in the firmware as well as the .h file) the aacraid cards. In those
> cases I can often commit to battery backed ram rather than physical
> media.
> 
> Do you have any idea of driving the cache write through rather than write
> back is likely to help here by evening out the commit wait for a flush?
> 
Controllers that do write back caching should be helped by the reiserfs 
usage changes.  If we pretend they immediately tell the OS a write is 
completed, unpatched reiserfs does this:

write X log blocks
wait on X log blocks (all already complete, so just a CPU loop)
write 1 commit
wait on 1 commit.

With the new code, the controller is more likely to get the commit in 
time to merge the requests.  Hopefully someone who knows more about scsi 
can correct me, but I think the write back controller can ignore the 
ordering rules (since battery backup should promise the request does hit 
media eventually).

I think write through caches should be helped too, as long as they
are smart about how they do the write ordering.  My scsi drive doesn't
seem to be very smart at all, it has been hard to find usage patterns
that show improvement.  So far, only O_SYNC writes really show it.

I think that's what you were asking, sorry if I misunderstood the Q.

-chris

