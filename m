Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTJSCSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 22:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTJSCSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 22:18:13 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:55701 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S261959AbTJSCSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 22:18:10 -0400
Message-ID: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Hans Reiser" <reiser@namesys.com>, "Wes Janzen" <superchkn@sbcglobal.net>,
       "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
       "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Justin Cormack" <justin@street-vision.com>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Vitaly Fertman" <vitaly@namesys.com>,
       "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Date: Sun, 19 Oct 2003 11:16:42 +0900
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

In order of importance instead of chronology:

In the presence of friends who are disk drive engineers at Toshiba, I tried
to read the file containing the bad block, we listened to the disk drive do
auto-retries, we watched Linux record the I/O failure in the system log, we
saw the "cp" program report an I/O error, and we observed that the drive did
not reallocate the bad block during reads.

Next, I tried to write the bad block.  The following command is not the
first one that I tried but it was the first one to actually try writing the
bad block:
  dd if=/dev/zero of=/dev/hda bs=512 seek=19021881 count=1
We listened to the disk drive do auto-retries, we watched Linux record the
I/O failure in the system log, we saw the "dd" command report an I/O error,
and we observed that the drive did not reallocate the bad block during
writes.  (The bad block number is 19021882.)

After a few other experiments, I used smartctl to direct the drive to do a
long self-test.  When it completed, we observed that the drive had
self-diagnosed a read failure on the same bad sector number as always, and
we observed that the drive did not reallocate the bad block during long
self-tests.

Does anyone need more?

A partial solution could be to stop using Toshiba drives, but I don't think
this will be a complete answer.  Toshiba is not the only maker whose disk
drives get bad blocks.  We do not know if Toshiba is the only maker whose
firmware refuses to reallocate bad blocks when permanent errors are
detected, because the makers aren't saying.

File systems must maintain lists of  bad blocks and prevent ordinary file
operations from ever using those sector numbers.

Someone pointed out that this technique will not work for swap partitions.
I agree.  The "mkswap" command needs to test every sector in the swap
partition and warn the user if the partition will be unusable.

Now for the less important stuff.

After many hours of "find"ing and "cp"ing files to /dev/null, the bad block
was detected to be in file
  /usr/share/locale/es/LC_MESSAGES/bfd.mo
So indeed, this file had been written once and was not intended to be
written again, and could easily be restored from a source of good data.  But
I was really startled by this, because I don't use Spanish locales.  The
only locales I use are Japanese and English.  So why did this file even get
read, even while I was doing kernel compiles and stuff like that?  After
all, the reason the bad block was getting logged in the system log was that
the file was getting read.

I "mv"ed the file to file /badblockhere and used rpm with --replacepkgs to
reinstall binutils from SuSE's 8.2 distribution.  Then copied the new
correct file /usr/share/locale/es/LC_MESSAGES/bfd.mo to file /goodfilehere.
This preparation made it easy to do experiments with my Toshiba friends when
they visited.

My first attempt to write the bad block (after the read experiments) was:
  dd if=/goodfilehere of=/badblockhere
But this did not even try to write to the bad block.  The drive did not try
to do any auto-retries, there were no errors in the system log, and the dd
command output a success message.  Next, a repeat of a read attempt that
used to fail:
  cp /badblockhere /dev/null
succeeded.  So I guess that the when the dd command is told to output to an
ordinary file, it does not overwrite its output file, it creates a new file
and then renames it to replace the old file.  (Too bad it couldn't do the
same when I ran this command:
  dd if=/dev/zero of=/dev/hda bs=512 seek=19021881 count=1
and write a new disk drive to replace the old one  ^u^)

And now that block is in free space somewhere, waiting for Linux and the
Reiser filesystem to allocate it when creating or expanding some future
file.

The bad block can still be detected.  This fails as always:
  dd if=/dev/hda of=/dev/null bs=512 skip=19021881 count=1
(The bad block number is 19021882.)

By the way, Toshiba's US subsidiary has indications on their web site that
they provide warranty service on their products, but that they have reduced
the warranty period from three years to one year.  This was a smart move by
Toshiba's US subsidiary.  If their disk drives start to develop bad blocks
after two years, then customers don't discover how bad Toshiba's firmware is
until two years have passed, and now they can't even make claims to get
firmware fixed.

Toshiba's head office is even smarter.  In Japanese they refuse entirely to
provide warranty service to end users.  Customers have to send defective
disk drives back up through the sales channel.  Well, lucky customers who
bought the disk drive as part of a notebook computer probably get one year's
warranty from the vendor of the notebook computer, so if they're lucky
enough to learn about Toshiba's firmware within a year then they can send
their entire computer back for some length of time to get warranty service.
But anyone who went to Akihabara and bought the drive by itself from a parts
store, the store probably offers one week or one month to replace a failing
drive if it was dead on arrival.  In these cases a customer who learns about
Toshiba's firmware after two weeks or five weeks gets screwed.

My disk drive was made at Toshiba's factory in Gifu prefecture on September
13, 2001.  Since that time the factory has closed and this model has been
discontinued.

But Toshiba isn't the only maker who isn't saying how bad their firmware is.
We need those bad block lists.  They are as necessary as they ever were.

