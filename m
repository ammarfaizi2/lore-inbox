Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSFLUlP>; Wed, 12 Jun 2002 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317322AbSFLUlO>; Wed, 12 Jun 2002 16:41:14 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:54837 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317299AbSFLUlN>; Wed, 12 Jun 2002 16:41:13 -0400
Message-Id: <5.1.0.14.2.20020612213746.045b7b60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 21:41:56 +0100
To: Andreas Dilger <adilger@clusterfs.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020612193921.GA682@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:39 12/06/02, Andreas Dilger wrote:
>On Jun 12, 2002  19:34 +0100, Anton Altaparmakov wrote:
> > At 18:36 12/06/02, Andreas Dilger wrote:
> > >1) Allocate an array of NULL pointers which is NR_CPUs in size (you could
> > >   do this all the time, as it would only be a few bytes)
> >
> > Yes, that is fine.
> >
> > >2) If you need to do decompression on a cpu you check the array entry
> > >   for that CPU and if is NULL you vmalloc() the decompression buffers 
> once
> > >   for that CPU.  This avoid vmalloc() overhead for each read.
> >
> > The vmalloc() sleeps and by the time you get control back you are 
> executing
> > on a different CPU. Ooops. The only valid way of treating per-cpu data is:
> >
> > - disable preemption
> > - get the cpu number = START OF CRITICAL SECTION: no sleep/schedule allowed
> > - do work using the cpu number
> > - reenable preemption = END OF CRITICAL SECTION
> >
> > The only thing that could possibly be used inside the critical region is
> > kmalloc(GFP_ATOMIC) but we are allocating 64kiB so that is not an option.
> > (It would fail very quickly due to memory fragmentation, the order of the
> > allocation is too high.)
>
>Well, then you can still do the one-time allocation for that CPU slot,
>and re-check the CPU number after vmalloc() returns.  If it is different
>(or always, for that matter) then you jump back to the "is the array for
>this CPU allocated" check until the array _is_ allocated for that CPU
>and you don't need to allocate it (so you won't sleep).  At most you
>will need to loop once for each available CPU if you are unlucky enough
>to be rescheduled to a different CPU after each call to vmalloc().
>
>Like:
>         int cpunum = this_cpu();
>         char *newbuf = NULL;
>
>         while (unlikely(NTFS_SB(sb)->s_compr_array[cpunum] == NULL)) {

Um are you suggesting compression buffers to be per mounted volume? That 
would be more wasteful than the current approach of one buffer per CPU 
globally for all of ntfs driver.

>                 newbuf = vmalloc(NTFS_DECOMPR_BUFFER_SIZE);
>
>                 /* Re-check the buffer case we slept in vmalloc() and
>                 * someone else already allocated a buffer for "this" CPU.
>                 */
>                 if (likely(NTFS_SB(sb)->s_compr_array[cpunum] == NULL)) {
>                         NTFS_SB(sb)->s_compr_array[cpunum] = newbuf;
>                         newbuf = NULL;
>                 }
>                 cpunum = this_cpu();
>         }
>         /* Hmm, we slept in vmalloc and we don't need the new buffer */
>         if (unlikely(newbuf != NULL))
>                 vfree(newbuf);

vfree() at a guess (I may be completely wrong on that one in which case I 
appologize!) can also sleep so that breaks that scheme.

> > >3) Any allocated buffers are freed in the same manner they are now -
> > >   when the last compressed volume is unmounted.  There may be some or
> > >   all entries that are still NULL.
> > >
> > >This also avoids allocating buffers when there are no files which are
> > >actually compressed.
> >
> > True it does, but unfortunately it doesn't work. )-:
>
>Now it does... ;-).

Perhaps. But if doing something like that I might as well use the present 
approach and just allocate all buffers at once if they haven't been 
allocated yet and be done with it. Then no vfree()s are needed either and 
then it really does work. (-;

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

