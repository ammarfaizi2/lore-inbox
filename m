Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135792AbRASSCN>; Fri, 19 Jan 2001 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136296AbRASSCD>; Fri, 19 Jan 2001 13:02:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7675 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135792AbRASSBz>;
	Fri, 19 Jan 2001 13:01:55 -0500
Importance: Normal
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: "l" <annetteg@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF50B8511C.DA424B45-ON852569D9.0061881B@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 19 Jan 2001 13:03:05 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/19/2001 01:01:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike sounds good, we will do all our measurements from now on with thread
count for the entire range from 1 to 16 and
then in power of twos upto 2048 and for maxcpus=1,2,4,6,8. Do you think
that 4096 is overkill ? So far the numbers you got and we got over here are
the same. Andi suggested that <pre8> has some problems with IO scheduling.

You are right, "hopefully + ballpark" ~= 10%.
As for intelligent decisions, the general loadbalancing that we already
started might help out a bit here.

Other stuff we could look into....
Remember we talked about counting active idle threads at some point.

if (active_idle_threads < smp_num_cpus) {
     /* now we know that we simply give it to the first idle_thread found,
instead of
      * collecting the max_na_goodness value and somewhat sorting through
it
      * similar to the current Vanilla algorithm
      */
} else {
     /* current MQ algorithm */
}

Just shooting from the hip here, lets restart this discussion.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Mike Kravetz <mkravetz@sequent.com> on 01/19/2001 12:11:04 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:   lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject:  Re: [Lse-tech] Re: multi-queue scheduler update



On Fri, Jan 19, 2001 at 10:47:06AM -0500, Hubertus Franke wrote:
<stuff deleted>
> What you can see from these numbers is that MQ does an awesome job up to
> 1024 threads. When measuring in the future, we will take from now on the
> general concern about low number of threads into account. Your points are
> well taken. I m pretty confident our MQ scheduler will be in reasonable
> ballpark of the current scheduler.
<more stuff deleted>

Hubertus,

'Hopefully' the multi-queue scheduler will be in the ballpark for
low number of threads.  However, remember the extra overhead being
incurred in the current implementation.  To maintain existing
scheduler behavior, we look at all CPU specific runqueues to find
the highest priority (goodness) task in the system.  Therefore,
when running with a single thread on an 8 processor system, we
examine 8 runqueues instead of the single global runqueue.  In
a test where tasks are simply spinning doing sched_yield()s, I
suspect this difference may be significant.

I'll run the IIRC benchmark with low thread counts, and post the
results.  In adition, I have some ideas on how to make intelligent
decisions to avoid examining all runqueueus when the number of
running tasks is less than the number of processors.

--
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
