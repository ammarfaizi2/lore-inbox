Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVA0QeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVA0QeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVA0QeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:34:12 -0500
Received: from rain.plan9.de ([193.108.181.162]:51636 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262654AbVA0Qd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:33:28 -0500
Date: Thu, 27 Jan 2005 17:33:23 +0100
From: Marc Lehmann <linux-kernel@plan9.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5 and ATA disk failure/recovery modes
Message-ID: <20050127163323.GA7474@schmorp.de>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de> <20050127095102.GA88779@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127095102.GA88779@muc.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:51:02AM +0100, Andi Kleen <ak@muc.de> wrote:
> > I disagree. When not working in degraded mode, it's absolutely reasonable
> > to e.g. use only the non-parity data. A crash with raid5 is in no way
> 
> Yep. But when you go into degraded mode during the crash recovery 
> (before the RAID is fully synced again) you lose.

Hi, see below.

> 
> > different to a crash without raid5 then: either the old data is on the
> > disk, the new data is on the disk, or you had some catastrophic disk event
> > and no data is on the disk.
> 
> No, that's not how RAID-5 works. For its redundancy it requires

Hi, I think we might have misunderstood each other.

In fact, I fully agree with you on how raid5 works. However, the current
linux raid behaviour is highy suboptimal, and offers much less than your
description of raid5 would enable it to do:

- it shouldn't do any kind of re-syncing with two failed disks (as it did
  in the case I described). That makes no sense and possibly destroys more
  data.

- it should still satisfy read requests whenever possible (right now,
  the device is often fully dead, despite the data being there in maybe
  100% of the cases).

  The thing is, the md raid5 driver itself is able to satisfy most read
  requests and even some write requests in >= two-failed-disk mode, but it
  is not so when the failure happens during reconstruction, so in a case
  were much *more* data can safely be provided is offers *less* then when
  two disks have failed.

- Vital information about the disk order that might be required for repairing
  is being destroyed.

I think all of these points are valid, despite the deficiencies in raid5
protection in theory, the linux raid behaviour is much worse in practise.

> The nasty part there is that it can affect completely unrelated
> data too (on a traditional disk you normally only lose the data
> that is currently being written) because of of the relationship
> between stripes on different disks.

Hmm.. indeed, I do not understand this. My reasoning would be as follows:

If I had a bad block, I either lose parity (== no data loss) or I lose a
data block (== this data block is lost when the machine crashes).

If unrelated data can get lost (as it is right now, as the device
basically is lost), then this seems like a deficiency in the driver.

> > The case I reported was not a catastrophic failure: either the old or new
> > data was on the disk, and the filesystem journaling (which is ext3) will
> > take care of it. Even if the parity information is not in sync, either old or
> > new data is on the disk.
> 
> But you lost a disk in the middle of recovery (any IO error is
> a lost disk) 

Yes, and I hit a bug, which I reported.

> > Indeed, but I think linux' behaviour is especially poor. For example, the
> > renumbering of the devices or the strange rebuild-restart behaviour (which
> > is definitely a bug) will make recovery unnecessarily complicated.
> 
> There were some suggestions in the past 
> to be a bit nicer on read IO errors - often if a read fails and you rewrite 
> the block from the reconstructed data the disk would allocate a new block
> and then be error free again.

(I am not asking for this kind fo automatic recovery, but here are some
thoughts on the above):

With modern IDE drives, trying to correct is actually the right thing to
do.

At least when the device indicates that it is still working fine, as
opposed to be being in pre-failure mode for example due to lack of
replacement blocks.

> The problem is just that when there are user visible IO errors
> on a modern disk something is very wrong and it will likely run quickly out 

No, the disk will likely just re-write the block. There are different
failure modes on IDE drives, the most likely failure on a crash is that
some block couldn't be written due to, say, a power outage, or a hard or
soft reset in the middle of a write (sad, but true, many ide disks act
like that, there have been discussions about this on LK).

No replacement block will need to be allocated in that case, just the
currently written data is lost. And nothing at all will be wrong with the
disk in that case, either. So I dispute the "on a modern disk something is
very wrong" because that is normal operation of a ATA disk, mandated by
standards.

Also, the number of used replacement blocks can be queried on basically
all modern ATA disks, and there is a method in place to warn about
possible failures, namely SMART.

Please note that most disks can be made to regularly scan their surface and
replace blocks, so the device might run out of replacement blocks without any
write access from the driver.

So this kind of danger is already possible and likely without linux trying to
repair the block, so repairing the block is just normal operation for the
drive.

What the drive in many failures is simply tag the block as unreadable
(mostly because the checksum/ecc data does not match) and correct this on
write. Most drivers will also check the surface and allocate a replacement
block automatically if required.

> of replacement blocks, and will eventually fail. That is why

Then the drive would be very buggy. If it runs out of replacement blocks it
will not suddenly fail, but only be unable to repair the block.

> Linux "forces" early replacement of the disk on any error - it is the
> safest thing to do.

That is certainly untrue. The safest thing to do would doubtlessly be to
make a warning that the disk needs to be replaced but still provide the
data as long as possible, instead of killing the device.

It would certainly make sense to no touch the disk in write mode, or, if
one is paranoid, in read mode, but right now the device is simply lost.

> > Of course, but that's supposed to be worked around by using a journaling
> > file system, right?
> 
> Nope, journaling is no magical fix for meta data corruption.

Meta data corruption of what? The raid device, then yes, the filesystem,
then no.

raid5 works by relying on error detetcion of the underlying device. it
will suffer form the same kind of corruption that a normal device suffers,
i.e. if data gets corrupted silently it's gone. However, in other cases
(loud error reporting), the raid device will not corrupt data, as it can
always know which data is there and which isn't, juts as with a normal
disk.

What raid provides is just more redundant data in normal operation - it
doens't suffer from silent data corruption more than a normal disk.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
