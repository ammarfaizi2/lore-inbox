Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130446AbRC1LqS>; Wed, 28 Mar 2001 06:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131369AbRC1LqI>; Wed, 28 Mar 2001 06:46:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55172 "EHLO e31.bld.us.ibm.com") by vger.kernel.org with ESMTP id <S130446AbRC1Lp7>; Wed, 28 Mar 2001 06:45:59 -0500
Message-ID: <3AC1CF4B.17B29EA4@sequent.com>
Date: Wed, 28 Mar 2001 17:17:23 +0530
From: Dipankar Sarma <dipankar@sequent.com>
Organization: IBM Linux Technology Center
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org, mckenney@sequent.com
Subject: Re: [PATCH for 2.5] preemptible kernel
References: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org> <3AB860A8.182A10C7@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

george anzinger wrote:
> 
> Exactly so.  The method does not depend on the sum of preemption being
> zip, but on each potential reader (writers take locks) passing thru a
> "sync point".  Your notion of waiting for each task to arrive
> "naturally" at schedule() would work.  It is, in fact, over kill as you
> could also add arrival at sys call exit as a (the) "sync point".  In
> fact, for module unload, isn't this the real "sync point"?  After all, a
> module can call schedule, or did I miss a usage counter somewhere?

It is certainly possible to implement synchronize_kernel() like
primitive for two phase update using "sync point". Waiting for
sys call exit will perhaps work in the module unloading case,
but there could be performance issues if a cpu spends most of
its time in idle task/interrupts. synchronize_kernel() provides
a simple generic way of implementing a two phase update without
serialization for reading.

I am working a "sync point" based version of such an approach
available at http://lse.sourceforge.net/locking/rclock.html. It
is based on the original DYNIX/ptx stuff that Paul Mckenney
developed in early 90s. This and synchronize_kernel() are 
very similar in approach and each can be implemented using 
the other.

As for handling preemption, we can perhaps try 2 things -

1. The read side of the critical section is enclosed in
RC_RDPROTECT()/RC_RDUNPROTECT() which are currently nops.
We can disable/enable preemption using these.

2. Avoid counting preemptive context switches. I am not sure
about this one though.

> 
> By the way, there is a paper on this somewhere on the web.  Anyone
> remember where?

If you are talking about Paul's paper, the link is
http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf.

Thanks
Dipankar
-- 
Dipankar Sarma  (dipankar@sequent.com)
IBM Linux Technology Center
IBM Software Lab, Bangalore, India.
Project Page: http://lse.sourceforge.net
