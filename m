Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273427AbSISVRh>; Thu, 19 Sep 2002 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273440AbSISVRh>; Thu, 19 Sep 2002 17:17:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:31140 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S273427AbSISVRc>;
	Thu, 19 Sep 2002 17:17:32 -0400
Message-ID: <3D8A4016.F364B303@digeo.com>
Date: Thu, 19 Sep 2002 14:22:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: fsync 50 times slower after 2.5.27
References: <200209190222.33276.duncan.sands@math.u-psud.fr> <3D891BD1.8F774946@digeo.com> <200209192032.25933.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 21:22:30.0885 (UTC) FILETIME=[A9827950:01C26022]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> 
> On Thursday 19 September 2002 02:35, you wrote:
> > Duncan Sands wrote:
> > > I noticed a performance degradation in recent kernels:
> > > fsync takes around 50 times longer in kernels 2.5.28 to
> > > 2.5.34 when the system is under heavy load, as compared
> > > to kernels <= 2.5.27.  I noticed this because it makes kmail
> > > unusable.  2.5.34 is the most recent kernel I tested.
> >
> > Please try replacing the yield() in fs/jbd/transaction.c
> > with
> >
> >       set_current_state(TASK_RUNNING);
> >       schedule();
> 
> OK!  This seems to fix the problem for 2.5.36.  I will also
> test it for 2.5.34 since I didn't test 2.5.36 as rigourously
> as 2.5.34 for the presence of the problem without the patch.

(I dragged you back onto the mailing list)

Thanks for testing.  The semantics of sched_yield() have changed
significantly in 2.5.  Probably correctly, but it is breaking a
few things which were tuned for the old semantics.  Amongst those
things are OpenOffice and, it seems, ext3 transaction batching.

The transaction batching does good things under some situations,
and we want it to keep working.  I'll sit tight for the while, see
where shed_yield() behaviour ends up.  If we still have a problem
then probably a schedule_timeout(1) in there would suffice.

> I will also test using ext2 (does ext2 use transaction.c?).

No. ext2 will not exhibit this problem.
