Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbRCFI0G>; Tue, 6 Mar 2001 03:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRCFIZ4>; Tue, 6 Mar 2001 03:25:56 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:30443 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129599AbRCFIZo>; Tue, 6 Mar 2001 03:25:44 -0500
Message-Id: <l0313030ab6ca4912a397@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.10.10103052254370.13719-100000@master.linux-ide.org>
In-Reply-To: <l03130307b6ca031531fc@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 08:24:32 +0000
To: Andre Hedrick <andre@linux-ide.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's pretty clear that the IDE drive(r) is *not* waiting for the physical
>> write to take place before returning control to the user program, whereas
>> the SCSI drive(r) is.  Both devices appear to be performing the write
>
>Wrong, IDE does not unplug thus the request is almost, I hate to admit it
>SYNC and not ASYNC :-(  Thus if the drive acks that it has the data then
>the driver lets go.

Uh, run that past me again?  You are saying that because the IDE drive hogs
the bus until the write is complete or the driver forcibly disconnects, you
make the driver disconnect to save time?  Or (more likely) have I totally
misread you...

>> immediately, however (judging from the device activity lights).  Whether
>> this is the correct behaviour or not, I leave up to you kernel hackers...
>
>Seagate has a better seek profile than ibm.
>The second access is correct because the first one pushed the heads to the
>pre-seek.  Thus the question is were is the drive leaving the heads when
>not active?  It does not appear to be in the zone 1 region.

Duh...  I don't quite see what you're saying here, either.  The test is a
continuous rewrite of the same sector of the disk, so the head shouldn't be
moving *at all* until it's all over.  In addition, the drive can't start
writing the sector when it's just finished writing it, so it has to wait
for the rotation to breing it back round again.  Under those circumstances,
I would expect my 7200rpm Seagate to perform slower than my 10000rpm IBM
*regardless* of seeking performance.  Seeking doesn't come into it!

>> IMHO, if an application needs performance, it shouldn't be syncing disks
>> after every write.  Syncing means, in my book, "wait for the data to be
>> committed to physical media" - note the *wait* involved there - so syncing
>> should only be used where data integrity in the event of a system failure
>> has a much higher importance than performance.
>
>I have only gotten the drive makers in the past 6 months to committee to
>actively updating the contents of the identify page to reflect reality.
>Thus if your drive is one of those that does a stress test check that goes:
>"this bozo did not really mean to turn off write caching, renabling <smurk>"

Why does this sound familiar?

Personally, I feel the bottom line is rapidly turning into "if you have
critical data, don't put it on an IDE disk".  There are too many corners
cut when compared to ostensibly similar SCSI devices.  Call me a SCSI bigot
if you like - I realise SCSI is more expensive, but you get what you pay
for.

Of course, under normal circumstances, you leave write-caching and UDMA on,
and you don't use a pathological stress-test like we've been doing.  That
gives the best performance.  But sometimes it's necessary to use these
"pathological" access patterns to achieve certain system functions.
Suppose, harking back to the Windows data-corruption scenario mentioned
earlier, that just before powering off you stuffed several MB of data,
scattered across the disk, into said disk and waited for said disk to say
"yup, i've got that", then powered down.  Recent drives have very large
(2MB?) on-board caches, so how long does it take for a pathological pattern
of these to be committed to physical media?  Can the drive sustain it's own
power long enough to do this (highly unlikely)?  So the drive *must* be
able to tell the OS when it's actually committed the data to media, or risk
*serious* data corruption.

Pathological shutdown pattern:  assuming scatter-gather is not allowed (for
IDE), and a 20ms full-stroke seek, write sectors at alternately opposite
ends of the disk, working inwards until the buffer is full.  512-byte
sectors, 2MB of them, is 4000 writes * 20ms = around 80 seconds (not
including rotational delay, either).  Last time I checked, you'd need a
capacitor array the size of the entire computer case to store enough power
to allow the drive to do this after system shutdown, and I don't remember
seeing LiIon batteries strapped to the bottom of my HDs.  Admittedly, any
sane OS doesn't actually use that kind of write pattern on shutdown, but
the drive can't assume that.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


