Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbRGOXBo>; Sun, 15 Jul 2001 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbRGOXBe>; Sun, 15 Jul 2001 19:01:34 -0400
Received: from adsl-63-199-185-124.dsl.snfc21.pacbell.net ([63.199.185.124]:23923
	"EHLO rvanmete.iprg.nokia.com") by vger.kernel.org with ESMTP
	id <S267108AbRGOXB1>; Sun, 15 Jul 2001 19:01:27 -0400
Message-Id: <200107152314.f6FNEM904281@rvanmete.iprg.nokia.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write 
In-Reply-To: gibbs's message of Sun, 15 Jul 2001 11:47:10 -0600.
	     <200107151747.f6FHlAU60256@aslan.scsiguy.com> 
Reply-To: rdv@cips.nokia.com
Date: Sun, 15 Jul 2001 16:14:16 -0700
From: Rod Van Meter <rdv@cips.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have the SCSI spec in front of me (though, as noted, some
drafts are available online; try t10.org somewhere), but as I
understand it (having worked, briefly, for a major disk manufacturer):

You can commit an individual write with the FUA (force unit access)
bit.  The command for this is not WRITE EXTENDED, but WRITE(10) or
WRITE(12).  I don't think WRITE(6) has room for the bit, and WRITE(6)
is useless nowadays, anyway.  WRITE EXTENDED lets you write over the
ECC bits -- it's a raw write to the platter.  Dunno that anyone
implements it any more.

That does NOT get you ordering with respect to other commands.  You
can use the complex tagging stuff to get that, but most disk drives
didn't implement it properly in the SCSI-2 days, and there are
significant differences in SCSI-3.

Otherwise, your choice, as noted, is SYNCHRONIZE CACHE before the root
block write, and after.  AFAIK, all drives treat that the way it's
meant to be done; everything's on platter when you get a COMMAND
COMPLETE back from it, but they weren't necessarily done in order.

Even within a command, I don't believe there is a guarantee that the
blocks will go to platter in order.  Say you write blocks 0-7; the
drive will start the transfer to buffer immediately, as the seek is
begun.  When the seek completes, the write gate will enable writes
from buffer to platter, and a state machine takes care of that.
However, the seek and settle may complete when the head is over block
3, so the first write to platter would be block 4, then 5-7.  This is
followed by almost an entire revolution's delay(*see note) to get back
to block 0, and 3 will be the last block written.

I have had this exact conversation with disk drive folks (of which I
am not one), but I haven't seen the firmware and state machines
myself, so treat this as an educated guess.  The folks I was talking
to may have been wrong, or more likely, misunderstood what I was
asking.

Some manufacturers can put either IDE or SCSI on a drive, and this
behavior is likely to be the same on both.  It may not apply to all
members of a family, and probably doesn't apply across families from
the same manufacturer.

Most disk drives, as recently as two years ago, were a lot dumber than
you think, and I doubt the situation has improved much.  For the most
part, disk manufacturers get paid for capacity, not smarts, but
there's an entire year-long argument there.

	       --Rod

* Note: In theory, that rotational delay doesn't have to be idle.  I
  believe any blocks between 7 and 0 that are also in cache will be
  written as the head passes over them.  Thus, the drive might
  literally interleave writes from multiple commands.  It's also
  possible, in theory, to switch tracks for a short time and come back
  to the first track before block 0 rolls around, but I don't believe
  existing controllers are that sophisticated.

P.S.  I gotta put in another plug here -- you have until Friday to
write this behavior up and submit it as a paper to USENIX FAST --
Conference on File and Storage Technology.  See
http://www.usenix.org/events/fast/
