Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTJQMvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJQMvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:51:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2689 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263452AbTJQMvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:51:37 -0400
Date: Fri, 17 Oct 2003 13:53:01 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310171253.h9HCr1tw000933@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>,
       "Hans Reiser" <reiser@namesys.com>,
       "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
 <20031014064925.GA12342@bitwizard.nl>
 <3F8BA037.9000705@sbcglobal.net>
 <3F8BBC08.6030901@namesys.com>
 <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
 <3F8FBADE.7020107@namesys.com>
 <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
> Now, maybe there is a technique to force it anyway.  When a partition is
> newly created and is being formatted with the intention of writing data a
> few minutes later, do writes that "should" have a better chance of being
> detected.  The way to start this is to simply write every block, but this is
> obviously insufficient because my block did get written shortly after the
> partition was formatted and that write didn't cause the block to be
> reallocated.  So in addition to simply writing every block, also read every
> block.  For each read that fails, proceed to do another write which "should"
> force reallocation.

I am just imagning how many Flash devices will be worn out
unnecessarily by any filesystem utility that does this transparently
to the user :-(.

> Russell King replied to me:
> 
> > > When a drive tries to read a block, if it detects errors, it retries up
> > > to 255 times.  If a retry succeeds then the block gets reallocated.  IF
> > > 255 RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
> >
> > This is perfectly reasonable.  If the drive can't recover your old data
> > to reallocate it to a new block, then leaving the error present until you
> > write new data to that bad block is the correct thing to do.

I 99% agree with that.  The 1% where I don't is that there may be
situations where there is no interest in doing any data recovery from
the drive, (you have backups, it is part of a RAID array, or storing
temporary data that can be re-generated whenever necessary), and also,
any read errors that occur during a S.M.A.R.T. read test should result
in a re-mapping of the block.

> > Think about what would happen if it did get reallocated.  What data would
> > the drive return when requested to read the bad block?
> 
> Why does it matter?  The drive already reported a read failure.  Maybe Linux
> programs aren't all smart enough to inform the user when a read operation
> results in an I/O error, but drivers could be smarter.  I think there's
> probably a bit of room in an inode to add a flag saying that the file has
> been detected to be partially unreadable.  Sorry for the digression.
> Anyway, it is 100% true that the data in that block are gone.  The block
> should be reallocated and the new physical block can either be zeroed or
> randomized or anything, and that's what subsequent reads will get until the
> block gets written again.

100% agreed.

> > If the error persists during a write to the bad block, then yes, I'd
> > expect it to be reallocated at that point - but only because the drive has
> > the correct data for that block available.
> 
> We agree in our moral expectations and our technical analysis that correct
> data will be available at that time.  But if your word "expect" means you
> have confidence that the drive will perform correctly, I do not share your
> confidence (I think it is possible but highly unlikely that the drive did
> its job correctly during the previous write).

If the drive is not doing it's job properly DRIVE -> BIN.

> > Your description of the way Toshibas drive works seems perfectly sane.

I disagree - we haven't confirmed what happens in the error-on-write
situation.  If it does indeed always remap the block, then I'd agree
that that aspect was perfectly sane.

John.
