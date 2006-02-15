Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWBOUfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBOUfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBOUfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:35:17 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:11617 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932168AbWBOUfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:35:15 -0500
Message-ID: <43F39089.2050302@tls.msk.ru>
Date: Wed, 15 Feb 2006 23:35:21 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: readahead logic and I/O errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thing is: I just fired a cdrom drive in my PC.
It was a good device, and now it's dead.
And the reason is the readahead logic, plus an unreadable
(damaged, scratched) CD-rom.

By default, linux enables read-ahead for all block devices
(I can't be certain about "all", but it's true for hard
disks, cd-roms and floppies at least).  And when a read
request comes to the device, according to readahead logic,
linux tries to get more data from the drive than requested.

Now, one of blocks requested to be read can't be read due
to whatever condition.  It happens on removable media, it's
a normal (sort of, anyway) condition.

Looks like I had many unreadable blocks on that CD.  And,
instead of obvious (in my view anyway) thing to do, namely,
to STOP readahead operation and return only whatever data
which was requested by an application (it was just `cp')
after FIRST I/O error, linux continued trying reading-ahead,
discovering more and more failed blocks, as dmesg said.

And finally, after about 100 blocks failed in a row, the
drive fired.

I wasn't able to stop the process - `cp' was in D state
sitting in one read() syscall thus unkillable.  Umount
didn't work (obviously).  Only one option left was to
reboot/poweroff the system, which I was finally forced
to do.. but too late.

I don't understand the logic in ll_rw_blk.c (the file
is quite large), but my guessing is that initially,
the read request was one for several blocks, but when
it failed, linux continued trying to get next block,
next-to-next block and so on - hence all consequtive
failed block numbers in dmesg, ie, it split original
large request into several smaller chunks, failing each
in turn.

Even if I'm wrong here and it originally made "short"
reads, the question remains:

Why linux tries to continue readahead operation after
I/O errors, instead of just dropping the reads, and
repeat them WHEN ACTUALLY NEEDED?  `cp' will stop after
first failed read(), so only one bad sector will be tried,
instead of numerous, finally firing the drive?

When setting readahead to 0, the same CD can be read up
to the first error, and will fail correctly.

The same happens with floppy as well - exactly the same
thing.  I especially damaged a floppy disk (I still have
several here), just to verify - after ~15 minutes of waiting
while it will finish it's readahead nonsense, I become bored
and finally rebooted the system.

So, to sum: current linux behaviour (similar since 2.4 -- at
least I remember seeing something like that, repeated attempts
to read something from a bad drive, -- up to current 2.6.15)
is that it's trivial to kill the system just by inserting a
cd-rom or floppy with some unreadable sectors.  Worse, it's
possible to FIRE the system this way (with certain drives
anyway), as just happened here (I understand, maybe, after
some more waiting, when it will try all 128 or 256 more sectors,
it WILL finally do something useful again and stop retrying,
but eg on this my drive, each read attempt took about 30 sec,
retrying several times by its own, so total time is umm..
quite large, and there's nothing one can do with it but
to poweroff the PC).

 From my point of view, it's a serious bug (even if not counting
my dead CD drive).

Thanks.

/mjt
