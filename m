Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSFSUZE>; Wed, 19 Jun 2002 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317998AbSFSUZD>; Wed, 19 Jun 2002 16:25:03 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:25147 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317997AbSFSUZC>; Wed, 19 Jun 2002 16:25:02 -0400
Message-Id: <5.1.0.14.2.20020619212010.04299410@mole.bio.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 19 Jun 2002 21:25:00 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D10E358.D82DB604@zip.com.au>
References: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:02 19/06/02, Andrew Morton wrote:
>Zwane Mwaikambo wrote:
> >
> > The ide drive holding the mounted filesystem dropped out of DMA and then
> > spewed the following a number of times. Anyone interested?
> >
> >  buffer layer error at buffer.c:2326
>
>y'know, just this morning I was thinking it may be time to pull the
>debug code out of buffer.c.  Silly me.
>
>So we had a non-uptodate buffer against an uptodate page.  Were
>there any other messages in the logs?  I'd have expected a
>"buffer IO error" to come out first?
>
>Looking at the code, it seems likely that you hit an I/O error
>on a write.  That will leave the page uptodate, but with PageError
>set.  And the buffer is marked not uptodate, which is silly, because the
>buffer _is_ uptodate.
>
>What this says is: I still need to get down and set up a fault simulator
>and make sure that we're doing all the right things when I/O errors occur.
>
>Does anyone have any opinions on what the kernel's behaviour should
>be in the presence of a write I/O error?  Our options appear to be:
>
>1: Just drop the data.  That's what we do now.
>
>2: Mark it dirty again, so it gets written indefinitely
>
>3: Mark the page dirty again, but also set PageError.  So we
>    attempt to write the same blocks a second time only.  Then
>    drop the data.
>
>4: (Just thought of this): mark the page PageError and PageDirty,
>    and unmap it from disk.  So when it gets written again, the
>    filesystem's get_block function will be called.  It can look at
>    PageError(bh_result->b_page) and say "hey, I need to find a
>    different set of blocks for this page".  The bad blocks will
>    just be leaked.
>
>    To back that up: if we get an IO error and the page is _already_
>    PageError, give up.  Mark it clean and lose the data.  This gives the
>    fs the option of clearing PageError inside get_block(), so it will end
>    up trying every block on the disk.

Nice!

>    Pretty sneaky, I think.  But it only works for file data.  If the
>    blocks are for metadata, we're screwed..

Not necessarily. NTFS metadata is stored in "normal" files. So the two 
statements above are incompatible. Either it will work for all of NTFS or 
for none of it.

I definitely like the idea. Especially if we can somehow combine it with 
moving the bad blocks to the "bad blocks list" in an fs specific manner 
instead of just leaking them, it would turn into a software based fault 
tolerance solution for writes, which would be damn neat.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

