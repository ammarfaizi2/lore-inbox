Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317759AbSFLSeO>; Wed, 12 Jun 2002 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317760AbSFLSeN>; Wed, 12 Jun 2002 14:34:13 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:30258 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317759AbSFLSeL>; Wed, 12 Jun 2002 14:34:11 -0400
Message-Id: <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 19:34:39 +0100
To: Andreas Dilger <adilger@clusterfs.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020612173605.GA573@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:36 12/06/02, Andreas Dilger wrote:
>On Jun 12, 2002  16:08 +0100, Anton Altaparmakov wrote:
> > Buffer allocation at use time is NOT an option because the buffers are
> > allocated using vmalloc() which is extremely expensive and we would 
> need to
> > allocate at every single initial ->readpage() call of a compressed file.
> >
> > >CPU hotswap higlights the fact that per CPU allocation needs to be smarter
> > >about doing its job (i.e. don't allocate if it won't be used ever,
> > >defer allocation to CPU hotswap event).
> >
> > The former is not possible for ntfs as there is no quick way to tell if 
> use
> > will use decompression or not. And the latter creates a lot of complexity.
> > I gave an example using a callback of how it could be done in a previous
> > post but I don't like introducing complexity for a minority group of users.
>
>I think the reasonable solution is as follows:
>1) Allocate an array of NULL pointers which is NR_CPUs in size (you could do
>    this all the time, as it would only be a few bytes)

Yes, that is fine.

>2) If you need to do decompression on a cpu you check the array entry
>    for that CPU and if is NULL you vmalloc() the decompression buffers once
>    for that CPU.  This avoid vmalloc() overhead for each read.

The vmalloc() sleeps and by the time you get control back you are executing 
on a different CPU. Ooops. The only valid way of treating per-cpu data is:

- disable preemption
- get the cpu number = START OF CRITICAL SECTION: no sleep/schedule allowed
- do work using the cpu number
- reenable preemption = END OF CRITICAL SECTION

The only thing that could possibly be used inside the critical region is 
kmalloc(GFP_ATOMIC) but we are allocating 64kiB so that is not an option. 
(It would fail very quickly due to memory fragmentation, the order of the 
allocation is too high.)

>3) Any allocated buffers are freed in the same manner they are now -
>    when the last compressed volume is unmounted.  There may be some or
>    all entries that are still NULL.
>
>This also avoids allocating buffers when there are no files which are
>actually compressed.

True it does, but unfortunately it doesn't work. )-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

