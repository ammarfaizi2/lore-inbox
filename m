Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317715AbSFLPHM>; Wed, 12 Jun 2002 11:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317717AbSFLPHM>; Wed, 12 Jun 2002 11:07:12 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:62757 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317715AbSFLPHK>; Wed, 12 Jun 2002 11:07:10 -0400
Message-Id: <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 16:08:21 +0100
To: vda@port.imtp.ilyichevsk.odessa.ua
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200206121431.g5CEV6L20571@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:32 12/06/02, Denis Vlasenko wrote:
>On 11 June 2002 12:54, Anton Altaparmakov wrote:
> > > > This is crazy! It means you are allocating 2MiB of memory instead of
> > > > just 128kiB on a 2 CPU system, which will be about 99% of the SMP
> > > > systems in use, at my guess. So your change is throwing away 1920kiB of
> > > > kernel ram for no reason at all. And that is just ntfs...
> > >
> > >Wait a minute.
> > >These buffers are allocated per CPU. Can we allocate additional ones when
> > >new CPU is added?
> >
> > Of course, see my suggestion for how to handle this in the post after the
> > one you replied to.
> >
> > >I do hope these buffers aren't allocated an boot time but at mount time,
> > >are they?
> >
> > At mount time and only if the volume supports compression. And they are
> > ntfs global, i.e. not per mount point. That is still a big ram waste.
>
>It's optimal to allocate buffers when they are needed.
>Thnk about an NTFS volume without any compressed files at all.

No buffers are allocated if the volume doesn't support compression at all. 
But if it does support them then we allocate them, even if then there are 
no compressed files as there is no quick way to tell the difference.

Buffer allocation at use time is NOT an option because the buffers are 
allocated using vmalloc() which is extremely expensive and we would need to 
allocate at every single initial ->readpage() call of a compressed file.

>CPU hotswap higlights the fact that per CPU allocation needs to be smarter
>about doing its job (i.e. don't allocate if it won't be used ever,
>defer allocation to CPU hotswap event).

The former is not possible for ntfs as there is no quick way to tell if use 
will use decompression or not. And the latter creates a lot of complexity. 
I gave an example using a callback of how it could be done in a previous 
post but I don't like introducing complexity for a minority group of users.

>OTOH, smarter code is longer, more difficult code. One have to weigh 
>memory benefits for small population of 'hot swappers' versus code simplicity.

Exactly. However all is well, if you have read the whole thread you will 
have seen the cpu_possible() optimization which allows allocating for 
actual existing CPU slots which means there is no wasted RAM or at least 
very little... On a 32 CPU machine I agree that it is irrelevant if you are 
wasting a few MiB of ram, you probably have multiple GiB of the stuff anyway...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

