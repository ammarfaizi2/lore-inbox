Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288259AbSA3D1A>; Tue, 29 Jan 2002 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSA3D0v>; Tue, 29 Jan 2002 22:26:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288259AbSA3D0k>;
	Tue, 29 Jan 2002 22:26:40 -0500
Message-ID: <3C576648.84CE142B@zip.com.au>
Date: Tue, 29 Jan 2002 19:19:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <1012357211.817.67.camel@phantasy> <Pine.LNX.4.40.0201291821030.15838-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On 29 Jan 2002, Robert Love wrote:
> > On Tue, 2002-01-29 at 20:26, Andrew Morton wrote:
> > > Just a little word of caution here.  Remember the
> > > apache-flock-synchronisation fiasco, where removal
> > > of the BKL halved Apache throughput on 8-way x86.
> > >
> > > This was because the BKL removal turned serialisation
> > > on a quick codepath from a spinlock into a schedule().
> 
> Yes, but the other factor to consider here is why did the extra schedule
> take place at all?  I think this is a actually a scheduler issue, and
> I'm hoping that the new scheduler will behave better in this case.  A
> call to schedule() should not happen unless the woken process has a
> higher priority than the process that did the unlock, but the old
> scheduler evidently always calculated this to be the case.  But we
> really want the process that did the unlock to continue running (until
> the end of its timeslice, if not preempted or blocked before then), just
> as it would when the lock was a spinlock.  It would be interesting to
> see whether the new scheduler gets this right.
> 
> Am I remembering the problem correctly?
> 

I don't think so :)

The problem was that the semaphore was highly contended, so the
losing process was explicitly scheduling away.

This doesn't necessarily mean that it was a long-held lock.  In
this case, it was a short-held lock, but it was also very *frequently*
being held and released.   This is a scenario where a spinlock is
heaps more appropriate than a semaphore.

I don't think we need any locking at all in the default lseek()
path, btw.  Apart from the non-atomic i_size thing, which is
only an issue for 32-bit machines.


-
