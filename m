Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbRG0OR0>; Fri, 27 Jul 2001 10:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268855AbRG0ORR>; Fri, 27 Jul 2001 10:17:17 -0400
Received: from garlic.amaranth.net ([216.235.243.195]:22023 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S267986AbRG0ORE>; Fri, 27 Jul 2001 10:17:04 -0400
Message-ID: <3B6177DB.26C6D378@egenera.com>
Date: Fri, 27 Jul 2001 10:16:59 -0400
From: "Philip R. Auld" <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> Its certainly a good idea. But it sounds to me like he is describing the
> normal effect of metadata only logging.
> 

Which brings up something I have been struggling with lately:

Linux (using both ext2 and reiserfs) can show garbage data blocks at the end of
files after a crash. With reiserfs this is clearly due to metadata only logging
and happens say 3 out of 5 times. With ext2 the frequency is about 1 in 5 times,
and more often that not it is simply zeroed data. Sometimes it is old data
though. 


This is something that is not present in other unix filesystems as far as I can
tell. If linux wants to be used in enterprise sites we can't allow 
old data blocks to be read. And ideally shouldn't allow zero blocks to be seen
either, but this is somewhat less serious.

I cannot reproduce this in ufs on either freebsd or solaris8.

I have not tested it with xfs and jfs for linux yet (and don't have any native
systems at hand.)

I believe vxfs to have a mechanism to prevent this despite metadata only
logging.

reiserfs with full data logging enabled of course does not show this behavior
(and works really well if you are willing to take the performance hit).

The basic test I use is to run this perl script for a while (to make sure at
least somehting has had a chance to get written out) and then power-cycle the
machine. When it comes back a simple tail logfile will show the problem. I also
run bonnie before hand to fill the disk with a known pattern so its easier to
spot.

linux is 2.2.16 and 2.4.2 from redhat 7.1. reiserfs is 3.5.33 and was tested
only on 2.2.16.


#!/usr/bin/perl
use Fcntl;
$count = 0;
while (1) {
#sysopen(FH, "/scratch/logfile", O_RDWR|O_APPEND|O_CREAT|O_SYNC)
sysopen(FH, "/scratch/logfile", O_RDWR|O_APPEND|O_CREAT)
        or die "Couldn't open file $path : $!\n";
print FH "Log file line ", $count , " yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda 
yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda \n" ;
close (FH);
#print $count , "\n";
$count++;
}


------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
