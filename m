Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSFDLqW>; Tue, 4 Jun 2002 07:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317479AbSFDLqU>; Tue, 4 Jun 2002 07:46:20 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:19060 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316592AbSFDLqR>; Tue, 4 Jun 2002 07:46:17 -0400
Message-Id: <5.1.0.14.2.20020604124216.02087bb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 04 Jun 2002 12:46:19 +0100
To: Trond Myklebust <trond.myklebust@fys.uio.no>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
Cc: Andrew Morton <akpm@zip.com.au>, "David S. Miller" <davem@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200206041339.32899.trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:39 04/06/02, Trond Myklebust wrote:
>On Tuesday 04 June 2002 08:37, Andrew Morton wrote:
>
> > The problem was that pagecache data on the NFS client was showing
> > incorrect chunks of several k's of zeroes.  No particuar alignment,
> > either.  And it only happened when the machine is under page-replacement
> > pressure.  And only when the machine has highmem.
> >
> > It'd be nice to understand _why_ it fixed it.  Do we know why NFS
> > was losing data when using KM_USER0?  As far as I can see the new
> > and old code look pretty darn similar.   Interested.
>
>Anton's Oops showed that kmap_atomic(page, KM_USER0) is sometimes failing to
>return an address, something that we cannot accept in a networking bottom
>half (performance and reliability would suck if we had to delay and retry).
>That indicates that something is calling kmap_atomic() and then getting
>interrupted before it can call kunmap_atomic().
>
> >From what I can see, the only other place where KM_USER0 is employed 
> would be
>in the *_highpage() helper routines in include/linux/highmem.h. These
>routines are used in various places, but are usually not protected against
>(soft and hard) interrupts or kernel pre-emption. Could it be that the latter
>is what is causing trouble?

That would make sense as any user of kmap_atomic() could be preempted at 
any time. And this is definitely something we should keep in mind for the 
future. Perhaps we should even go as far to disable preemption in 
kmap_atomic() and reenable it in kunmap_atomic()? The atomic kmaps are 
usually only done in critical sections which will execute for a short 
amount of time so disabling preemption should be ok.

However, I had the preemptible option disabled in the kernel I reported the 
Oops on, so it can't be responsible for this particular case.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

