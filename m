Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRLAArt>; Fri, 30 Nov 2001 19:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRLAArj>; Fri, 30 Nov 2001 19:47:39 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7311 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281225AbRLAArZ>;
	Fri, 30 Nov 2001 19:47:25 -0500
Message-Id: <200112010047.fB10lA406654@eng4.beaverton.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David C. Hansen" <dave@sr71.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions 
In-Reply-To: Your message of "Fri, 30 Nov 2001 18:12:55 EST."
             <Pine.GSO.4.21.0111301747160.7125-100000@binet.math.psu.edu> 
Date: Fri, 30 Nov 2001 16:47:10 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > back to Alexander  Viro:
    >  > In other words, patch is completely bogus.
    > No, not completely.  In a lot of cases we just replaced some regular 
    > arithmetic with atomic instructions of some sort.  These changes are 
    > still completely valid.  But, in the cases where we added locking, we 
    
    Valid, but not necessary a good idea.  Notice that there are very
    real races in ->release() and ->open() instances.  Removing BKL
    from these (or replacing it with atomic operations) doesn't fix the
    existing race.  Moreover, it creates a false impression that thing
    had been reviewed and fixed.

Well, but for the revelation that the BKL is held in chrdev_open(),
offering implicit serialization for all open routines, these *were*
reviewed and thought fixed.  Atomic operations *do* fill the bill when
we are looking at counts used to guarantee exclusive opens.  They
generally *don't* fill the bill when you want to take virtually any
other action based on those counts.

    Sorry for "told you so", but that's what I'd been trying to explain
    from the very beginning - back when the idea of that patch had been
    discussed the first time.  That work really has to be done
    driver-by-driver...

It actually *was* in this case.  This may look like an afternoon of
editor exercise, but each of the cases was inspected and reviewed
before recommending the patch, and collectively represents several
weeks' worth of work.  In early November I posted a note to
linux-kernel which said, in part:

    Before we post these patches, I thought I'd ask if in the time
    since Al Viro moved this out here (July 2000) if anybody
    (especially him!) has found a *legitimate* use of the BKL in the
    release() functions. (We have not found one.)

There was no response.

Given the miss on chrdev_open(), we've got some patch patches to come
up with.  However, this isn't a dump-and-run job.  We accept the
responsibility for those patches, and we'll patch 'em up.  While we
can't then miraculously announce it's safe to remove lock_kernel around
opens, we CAN announce we are closer, and nothing else will be any more
broken than it was before we started. As I said in an earlier post (and
I don't think anybody disagrees): this is an incremental task. Any
assistance you can provide in reviewing this work, including all to
date, is welcome.

Rick
