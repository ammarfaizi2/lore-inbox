Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFLV35>; Wed, 12 Jun 2002 17:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSFLV34>; Wed, 12 Jun 2002 17:29:56 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:10039 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313477AbSFLV3z>; Wed, 12 Jun 2002 17:29:55 -0400
Message-Id: <5.1.0.14.2.20020612215730.04590dd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 22:29:56 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <k-suganuma@mvj.biglobe.ne.jp>
In-Reply-To: <Pine.LNX.4.33.0206121226550.1533-100000@penguin.transmeta.
 com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:32 12/06/02, Linus Torvalds wrote:

>Hmm.. Since the cpu_online_map thing can be used to fix this, this doesn't
>seem to be a big issue

Yes, we are all just nitpicking now. (-;

>, BUT
>
>On Wed, 12 Jun 2002, Anton Altaparmakov wrote:
> >
> > 1) Use a single buffer and lock it so once one file is under decompression
> > no other files can be and if multiple compressed files are being accessed
> > simultaneously on different CPUs only one CPU would be decompressing. The
> > others would be waiting for the lock. (Obviously scheduling and doing 
> other
> > stuff.)
> >
> > 2) Use multiple buffers and allocate a buffer every time the decompression
> > engine is used. Note this means a vmalloc()+vfree() in EVERY ->readpage()
> > for a compressed file!
> >
> > 3) Use one buffer for each CPU and use a critical section during
> > decompression (disable preemption, don't sleep). Allocated at mount 
> time of
> > first partition supporting compression. Freed at umount time of last
> > partition supporting compression.
> >
> > I think it is obvious why I went for 3)...
>
>I don't see that as being all that obvious. The _obvious_ choice is just
>(1), protected by a simple spinlock. 128kB/CPU seems rather wasteful,
>especially as the only thing it buys you is scalability on multiple CPU's
>for the case where you have multiple readers all at the same time touching
>a new compressed block.
>
>That scalability operation seems dubious, especially since this will only
>happen when you just had to do IO anyway, so in order to actually take
>advantage of the scalability that IO would have had to happen on multiple
>separate controllers.
>
>Ehh?

That is a fair point from a reality check point of view, I freely admit to 
being one of the people who count the bytes and cycles... But I do think it 
is quite legitimate to have two different controllers or at least two 
different disks (/me ignorant: SCSI can operate multiple disks 
simultaneously on same controller, can it not?) or as I do quite a lot 
myself, have one disk on IDE controller and one via NBD device over 100MBit 
ethernet. (Mind you I have a single CPU machine...)

Admittedly in reality you would need to have some damn high load on the 
ntfs driver for this optimization to make a difference. But lets take as an 
example a company who is migrating from windows to Linux but for whatever 
reason is keeping their data on NTFS (yes such companies exist (-:). I 
could see this optimization bringing making real world difference (albeit a 
small one!) to a big web/file server.

I know ntfs is currently read-only but it is not going to stay this way and 
I see the possibility of people using ntfs on Linux quite extensively, so I 
am trying to make it as robust and as fast as possible. - Quite a few 
companies keep asking me when write support will be available so they can 
install Linux shared with windows, run their Linux based app in Windows, do 
antivirus checks/cleaning from Linux, do backup recovery of windows from 
Linux, the list goes on, I have lost track of all the things people want it 
for. (-:

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

