Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbRFLUSo>; Tue, 12 Jun 2001 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbRFLUSe>; Tue, 12 Jun 2001 16:18:34 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:38161
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S263070AbRFLUSN>; Tue, 12 Jun 2001 16:18:13 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Tue, 12 Jun 2001 13:17:49 -0700
Message-Id: <200106122017.f5CKHnf24565@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 data corruption
Cc: tytso@thunk.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, I believe I have a reproducible test case which corrupts data in
2.4.5.

We do nightly, weekly, and monthly backups by copying our entire /home
partition on the company file server:

Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             1.9G  1.7G  123M  93% /
/dev/hda6             1.9G  437M  1.4G  23% /tmp
/dev/sda1              37G   26G   11G  71% /home
/dev/sdc1              37G   26G   11G  70% /weekly
/dev/sdd1              37G   24G   13G  65% /monthly
/dev/sdb1              37G   26G   11G  71% /nightly

The sd? drives are actually ide drives on a 3ware escalade controller.
I have reason to believe the drives are good, before I installed them
I scrubbed them with varying data patterns and verified that that I got
back what I put there.  All tested cleanly overnight.

I recently added an integrity check to our backups - the integrity checker
writes out the path, the gzip adler32 checksum, the size, and the mtime of
each file.  Each time I do a backup, the backup scripts look for the 
integrity listing in the other partitions and compares all files with the
same path, size, and modtime.  

This morning I had a pile of errors after things having gone smoothly for
the last few weeks.  I suspected that I had screwed something up, looked
over the backup scripts, simplified them down to a simple cpio, and tried
again.  Another pile of errors, different set of files.  

In both cases, the newly created files were corrupted, the ones on the 
live /home partition as well as the /weekly & /monthly partitions all 
compared cleanly.

I rebooted into 2.2.19, tried again, no errors.  I was running 2.4.5,
no patches.  I power cycled the machine between each reboot, went through
the bios memory check, and also went through my own memory check; memory 
does not seem to be an issue.

I think I can reproduce this, it takes a reboot and about 2 hours.  I made
it happen twice with 2.4.5, the first try on 2.2.19 did not work.

The data corruption looks like *extra* bytes added at the beginning of
files.  I only looked at a few, if we go down the path of debugging this
I'll save them all next time.  The extra byte counts were small, in one
case there was the letter "1" added to the start of the file, other than
that it was identical.  That's really weird, as a file system guy, I'd
expect to see blocks of data not small chunks of data.  Very strange.

One thing I haven't done is to rule out the 3ware controller.  I tend to
doubt it is the problem but who knows.  

There were no kernel messages complaining about anything during the 
backup, so the kernel doesn't seem to know there is a problem.

So, does anyone recognize these symptoms?  Does anyone care?  
