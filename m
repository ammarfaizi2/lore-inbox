Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTJQMKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTJQMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:10:41 -0400
Received: from tench.street-vision.com ([212.18.235.100]:38348 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263427AbTJQMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:10:36 -0400
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk
	sectors numbered strangely, and what happens to them?)
From: Justin Cormack <justin@street-vision.com>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>, nikita@namesys.com,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
	<200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
	<33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
	<20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
	<3F8BBC08.6030901@namesys.com>  <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 17 Oct 2003 13:08:48 +0100
Message-Id: <1066392528.3344.13.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 10:40, Norman Diamond wrote:
> Friends in the disk drive section at Toshiba said this:
> 
> When a drive tries to read a block, if it detects errors, it retries up to
> 255 times.  If a retry succeeds then the block gets reallocated.  IF 255
> RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
> 
> This was so unbelievable to that I had to confirm this with them in
> different words.  In case of a temporary error, the drive provides the
> recovered data as the result of the read operation and the drive writes the
> data to a reallocated sector.  In case of a permanent error, the block is
> assumed bad, and of course the data are lost.  Since the data are assumed
> lost, the drive keeps the defective LBA sector number associated with the
> same defective physical block and it does not reallocate the defective
> block.
> 
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
> sure if this is guaranteed or not.  We agreed that we should try it on my
> bad sector, but if the drive again detects a permantent error then it will
> not reallocate the sector.  First I still want to find which file contains
> the sector; I haven't had time for this on weekdays.
> 

I have found that in teh case of blocks that wont reallocate with reads,
a sufficiently large number of reads and writes will fix them
eventually, by reallocating. The bahaviour doesnt seem entirely
predicatable (but then failure modes often arent), but given time it is
possible to do.

> In this mailing list there has been some discussion of whether file systems
> should keep lists of known bad blocks and hide those bad blocks from
> ordinary operations in ordinary usage.  Of course historically this was
> always necessary.  As someone else mentioned, and I've done it too, when
> formatting a disk drive, type in the list of known bad block numbers that
> were printed on a piece of paper that came with the drive.
> 

This really isnt going to work with swap partitions and suchlike. If you
cant get rid of a bad sector with reads and writes on badblocks, smart
tests and the manufacturers low level format then it is defective and
you should discard it or return it under warranty. The bad blcoks list
is really not needed. If you really want to do it, use dm to remap the
raw device without bad blocks, then you can still use it on filesystems
without badblocks support (eg swap, raid etc). The device mapping stuff
should have no trouble with this.

> Regarding finding which file contains the known bad sector, someone in this
> mailing list said that the badblocks program could help, but the manual page
> for the badblocks program doesn't give any clues as to how it would help.
> I'm still doing find of all files in the partition and cp them to /dev/null.

use the read test on badblocks to find the sector, then use the write
tests tooverwrite it until the badblock is fixed, then fsck your
partition. If you get errors then the block was metadata. Otherwise
md5sum your files and check against the backups. That will tell you the
file... For ext2 I believe there are some tools, for other file systems
it might be more difficult.

Justin


