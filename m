Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTJQLOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTJQLN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:13:59 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:19855 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263399AbTJQLNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:13:53 -0400
Message-ID: <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Hans Reiser" <reiser@namesys.com>, "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
       "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "Pavel Machek" <pavel@ucw.cz>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <3F8FBADE.7020107@namesys.com>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Date: Fri, 17 Oct 2003 20:11:42 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying first to Hans Reiser; below to Russell King and Pavel Machek.

> Instead of recording the bad blocks, just write to them.

If writes are guaranteed to force reallocations then this is potentially
part of a solution.

I still remain suspicious because the first failed read was milliseconds or
minutes after the preceding write.  I think the odds are very high that the
sector was already bad at the time of the write but reallocation did not
occur.  It is possible but I think very unlikely that the sector was
reallocated to a different physical sector which went bad milliseconds after
being written after reallocation, and equally unlikely that the sector
wasn't reallocated because it really hadn't been bad but went bad
milliseconds later.  In other words, I think it is overwhelmingly likely
that the write failed but was not detected as such and did not result in
reallocation.

Now, maybe there is a technique to force it anyway.  When a partition is
newly created and is being formatted with the intention of writing data a
few minutes later, do writes that "should" have a better chance of being
detected.  The way to start this is to simply write every block, but this is
obviously insufficient because my block did get written shortly after the
partition was formatted and that write didn't cause the block to be
reallocated.  So in addition to simply writing every block, also read every
block.  For each read that fails, proceed to do another write which "should"
force reallocation.

Mr. Reiser, when I created a partition of your design, that technique was
not offered.  Why?  And will it soon start being offered?

Also, I remain highly suspicious that for each read that fails, when the
formatting program proceeds to do another write which "should" force
reallocation, the drive might not do it.  The formatter will have to proceed
to yet another read.  And if the block is still bad, then figure that the
drive is refusing to reallocate the bad block.  And then yes, the formatter
will still have to make a list of known bad blocks and do something to
prevent ordinary file system operations from ever seeing those blocks.


Russell King replied to me:

> > When a drive tries to read a block, if it detects errors, it retries up
> > to 255 times.  If a retry succeeds then the block gets reallocated.  IF
> > 255 RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
>
> This is perfectly reasonable.  If the drive can't recover your old data
> to reallocate it to a new block, then leaving the error present until you
> write new data to that bad block is the correct thing to do.

Only if the subsequent write is guaranteed to result in reallocation.  I
remain suspicious that the drive does not guarantee such.  Suppose the
contents of the next write happen to get stored close enough to correct that
the block doesn't get reallocated and the data survive for another 100
milliseconds before getting corrupt again?

> Think about what would happen if it did get reallocated.  What data would
> the drive return when requested to read the bad block?

Why does it matter?  The drive already reported a read failure.  Maybe Linux
programs aren't all smart enough to inform the user when a read operation
results in an I/O error, but drivers could be smarter.  I think there's
probably a bit of room in an inode to add a flag saying that the file has
been detected to be partially unreadable.  Sorry for the digression.
Anyway, it is 100% true that the data in that block are gone.  The block
should be reallocated and the new physical block can either be zeroed or
randomized or anything, and that's what subsequent reads will get until the
block gets written again.

> If the error persists during a write to the bad block, then yes, I'd
> expect it to be reallocated at that point - but only because the drive has
> the correct data for that block available.

We agree in our moral expectations and our technical analysis that correct
data will be available at that time.  But if your word "expect" means you
have confidence that the drive will perform correctly, I do not share your
confidence (I think it is possible but highly unlikely that the drive did
its job correctly during the previous write).

> Your description of the way Toshibas drive works seems perfectly sane.
> In fact, I'd consider a drive to be broken if it behaved in any other way
> - capable of almost silent data loss.

I think it would not be silent.  If the system log had one repetition
instead of fifty repetitions, it would not be silent.  I don't know which
application was silent and am irritated.  (dd wasn't silent when I tried
copying the entire partition to /dev/null).


Pavel Machek wrote:

> Well, this behaviour makes sense.
>
> "If we can't read this, leave it in place, perhaps we can read it in
> future (when temperature drops below 80Celsius or something)". "If we
> can't write this, bad, but we can reallocate without loosing
> anything".

Well, consider the two extremes we've seen in this thread now.  Mr. Bradford
felt that the entire drive should be discarded on account of having one bad
block.  Mr. Machek feels that we should preserve the possibility of reusing
the bad block because in the future it might appear not to be bad.  I take
the middle road.  The drive should not be discarded until errors become more
frequent or numerous, but known bad blocks should be acted on so that those
physical blocks should not have a chance of being used again.

Suppose the block became readable when the temperature drops (this one
didn't but I believe some can).  What happens when the block becomes
readable, and then a program writes new data to that block, and the block
temporarily appears good?  At that time it will get written and will not get
reallocated, right?  And a few milliseconds later, what?  I do not want that
block reused.  I want it reallocated.

And when a drive doesn't guarantee reallocation, I want the driver to remove
the sector from the file system.

