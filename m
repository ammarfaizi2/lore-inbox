Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTJQKgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTJQKgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:36:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:42368 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263393AbTJQKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:36:19 -0400
Date: Fri, 17 Oct 2003 11:37:24 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171037.h9HAbOrv000559@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>,
       "Hans Reiser" <reiser@namesys.com>,
       "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
Cc: eric_mudama@Maxtor.com, linux-kernel@vger.kernel.org, john@grabjohn.com
In-Reply-To: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <3F8BBC08.6030901@namesys.com>
 <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
Subject: ATA Defect management
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note to Eric, who is CC'ed, can you comment on how Maxtor drives
handle these issues?]

Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
> Friends in the disk drive section at Toshiba said this:
> 
> When a drive tries to read a block, if it detects errors, it retries up to
> 255 times.  If a retry succeeds then the block gets reallocated.  IF 255
> RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.

OK, this is interesting, at least we have some specific information.

> This was so unbelievable to that I had to confirm this with them in
> different words.  In case of a temporary error, the drive provides the
> recovered data as the result of the read operation and the drive writes the
> data to a reallocated sector.  In case of a permanent error, the block is
> assumed bad, and of course the data are lost.  Since the data are assumed
> lost, the drive keeps the defective LBA sector number associated with the
> same defective physical block and it does not reallocate the defective
> block.

OK, so for a stupid, backward, legacy OS, that takes the 'what is the
point of substituting a spare block if you have nothing to write to
it' viewpoint, maybe that would make sense - for the rest of us it's
stupid - did anybody actually consider that responsible admins
actually make backups and want to restore them on to the disk without
having to concern themselves with defect management which, shock,
horror, is supposed to be done by the drive.  Of course, the poor
admin who made a sector-by-sector backup is completely out of luck
when he comes to restore it on to a drive that insists one sector is
bad.

> I explained to them why the LBA sector number should still get reallocated
> even though the data are lost.  When the sector isn't reallocated, I could
> repartition the drive and reformat the partition and the OS wouldn't know
> about the defective block so the OS would try again to use it.  At first
> they did not believe I could do this, but I explained to them that I'm still
> able to delete partitions and create new partitions etc., and then they
> understood.
> 
> They also said that a write operation has a chance of getting the bad block
> reallocated.  The conditions for reallocation on write are similar but not
> identical to the conditions for reallocate on read.  During a write
> operation if a sector is determined to be permanently bad (255 failing
> retries) then it is likely to be reallocated, unlike a read.  But I'm not
> sure if this is guaranteed or not.

No, I'm sorry, are we to believe that it might or might not get
re-allocated just by chance?  This is rediculous.

>  We agreed that we should try it on my
> bad sector, but if the drive again detects a permantent error then it will
> not reallocate the sector.  First I still want to find which file contains
> the sector; I haven't had time for this on weekdays.
> 
> When I ran the "long" S.M.A.R.T. self-test, the number of reallocated
> sectors and number of reallocation events both increased from 1 to 2, but
> the known bad sector remained bad.  This is entirely because of the behavior
> as designed.  The self-test detected a temporary error in some other
> unrelated sector, rescued the data in that unreported sector number, and
> reallocated it.  That was only a coincidence.  The known bad sector was
> detected yet again as permanently bad and was not reallocated.

Even though you are _deliberately_ running a self test to check for
this kind of problem?

> In this mailing list there has been some discussion of whether file systems
> should keep lists of known bad blocks and hide those bad blocks from
> ordinary operations in ordinary usage.  Of course historically this was
> always necessary.  As someone else mentioned, and I've done it too, when
> formatting a disk drive, type in the list of known bad block numbers that
> were printed on a piece of paper that came with the drive.
> 
> In modern times, some people think that this shouldn't be necessary because
> the drive already does its best to reallocate bad blocks.  WRONG.  THE BAD
> BLOCK LIST REMAINS AS NECESSARY AS IT ALWAYS WAS.

I made that claim, and stand by it.

Note one thing:

If you are right, you are basically suggesting that we will have to go
back to writing defective sectors on a sticker on the drive casing.
If you do a:

dd if=/dev/zero of=/dev/hda

you loose that bad block list.  Now, you've got to enter it in again,
or let the OS scan the disk surface and find the bad sectors.  Hello,
this is the third millennium.  This may have been a way of life twenty
years ago, but I hope we have moved on from there.

Oh, and what happens if block zero is defective, eh?  The disk is no
longer usable as a boot disk, because the MBR can't be written to
block zero?

What if I want to use my disk for storing a TAR archive?  Why should
we bloat TAR with bad block support?

> This design might change in the future, but it might not.  My friends are
> afraid that they might lose their jobs if they try to suggest such a change
> in the high-level design of disk drive corporate politics.  I only hope this
> posting doesn't get them fired.  (This is not a frivolous concern by the
> way.  The myth of lifetime employment is a less pervasive myth than it used
> to be, and Toshiba is pretty much average in both world and Japanese
> standards for corporate politics.)

If anything, it should get them a promotion.  If somebody from Toshiba
wants to discuss defect management with me, they are welcome to, I'll
waive my consultancy fees, (at least initially).

> Regarding finding which file contains the known bad sector, someone in this
> mailing list said that the badblocks program could help, but the manual page
> for the badblocks program doesn't give any clues as to how it would help.
> I'm still doing find of all files in the partition and cp them to /dev/null.
> 
> Meanwhile, yes we do need to record those bad block lists and try to never
> let them get allocated to user-visible files.

NO.  Fix the drives.  If nobody is going to do that, I might as well
join the Linux-VAX project and run by business on a cluster of
11/780s.

Let me make this clear - some of us earn a living providing solutions
to clients who pay good money for that consultancy.  If they loose
data, have downtime or have any other problems, my clients will
generally come back to _ME_ for an explaination, and I want something
better than, "Well, that's the way the drives work".

We have identified a problem, now let's fix it.

Defect management needs to be done by the disk firmware, and it needs
to be done properly.

Note - this is not a criticism of Toshiba, nor am I implying that it
is in any way limited to their products.  I am grateful for them
providing information on the subject.  I own two of their laptops
which run Linux perfectly, and I am generally pleased with their
products.

Note also - I realise that the defect management techniques you
describe don't actually seem to allow data to be written to a bad
sector undetected.  A permenantly bad sector apparently won't become
'apparently good, but subtly bad', and loose data after time, but that
is not the point.  With write caching in the OS, data could be
allocated to an undetected-at-the-OS-level bad sector, and cause
problems when it is written out.  With the recent laptop mode patch we
are going to see more delayed writes going on.

John.
