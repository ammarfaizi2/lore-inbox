Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136935AbRASW6B>; Fri, 19 Jan 2001 17:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136961AbRASW5w>; Fri, 19 Jan 2001 17:57:52 -0500
Received: from mout1.freenet.de ([194.97.50.132]:30167 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S136935AbRASW5l>;
	Fri, 19 Jan 2001 17:57:41 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Fri, 19 Jan 2001 23:56:46 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Paul Bristow <paul@paulbristow.net>
In-Reply-To: <fa.c1dcngv.1m2q1p8@ifi.uio.no> <39F4C822.F3D7D41B@gmx.de> <3A676565.84084077@paulbristow.net>
In-Reply-To: <3A676565.84084077@paulbristow.net>
Subject: Re: IDE-Floppy and devfs
Cc: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011923564600.00632@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

(you CC'ed your original post to vger.rutgers.edu, I shamelessly corrected 
this for this reply)

> I have (finally) merged your patch in with the ide-floppy driver and
> have it working with devfs here on my laptop for a PCMCIA Clik drive.

Have you merged my patch in literate or in sense? If the first, I hope you 
looked over it, I am not at all convinced that it does the right thing (TM).

A remaining problem was for me that the part4 entry for my ZIP disks was not 
created unless a disk was in during module loading time. For sure, this COULD 
be done by just faking a part4 entry in the ide-floppy code, which then would 
eventually create a duplicate entry, when the disk layer finds the medium.

I think the right thing (TM) would be to give the block device layer a chance 
to know that the medium has changed, when a disk is inserted, which would 
then rescan the partition table and create the corresponding entries. The 
driver should give the block layer the needed info for that, and eventually 
create further links, as in /dev/ide/fd/... and so on. (see below for more on 
that)

I'm not sure if this is possible, but I'd prefer this solution - I just don't 
know what others think of it. 

The same thing could eventually be done for CD-ROM or even normal floppy 
disks. I like the approach very much, which would make it possible to use 
devices in a MacOS-like way - just insert the disk, kernel does what it needs 
to to notify userspace of that event, userspace creates the nifty icon on my 
desktop. Ok, ok, I know I'm biased... :-)

> Sorry it took so long but I had to learn the entire 2.4 module stuff,
> PCMCIA stuff, and devfs stuff in my spare time, which there wasn't
> enough of.

No problem, my spare time is limited too so I know this problem too well :-)

> A question.  It says in Richard's devfs documentation that the
> ide-floppy driver should create device names under /dev/ide/fd/...
> (similar to /dev/ide/hd/...).  However, looking through the code I am
> under the impression that this should actually take place in devfsd.  Am
> I right, or am I crazy?  Are there any of the devfs experts with an	
> ATAPI ZIP/LS-120 drive that can check what I have done?

I think the ide-floppy driver should do, because it KNOWS it is a floppy 
driver. devfsd doesn't necessarily know that 
/dev/ide/host0/bus0/target1/lun0/disk is really an IDE floppy disk - it might 
be a hard disk, as well, or anything else. The driver knows so, and should 
therefore create the link withour requiring further configuration on the user 
side, because the idea of this links is to have access to the devices without 
having to scan the entire bus structure. And this is supposed to work even 
without devfsd, I dearly hope so...

> BTW, now I finally understand it, I really like devfs.  I just need to
> get rid of all those extra tty devices in /dev and I'll have a nice
> clean /dev that actually makes sense.  Good work guys.

I like it very much too, and can't appreciate to see it in all its beauty 
when all the ugly peculiarities have been hacked out and the drivers have all 
been adapted to work just fine... it's really a great idea!

Greetings,
Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
