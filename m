Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273552AbRIQJJi>; Mon, 17 Sep 2001 05:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273555AbRIQJJ2>; Mon, 17 Sep 2001 05:09:28 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24206 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273525AbRIQJJQ>; Mon, 17 Sep 2001 05:09:16 -0400
Date: Mon, 17 Sep 2001 14:43:15 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: riel@conectiva.com.br
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010917144315.A27941@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L.0109161433530.9536-100000@imladris.rielhome.conectiva> you wrote:
> On Sun, 16 Sep 2001, Andrea Arcangeli wrote:

>> However the issue with keventd and the fact we can get away with a
>> single per-cpu counter increase in the scheduler fast path made us to
>> think it's cleaner to just spend such cycle for each schedule rather
>> than having yet another 8k per cpu wasted and longer taskslists (a
>> local cpu increase is cheaper than a conditional jump).

> So why don't we put the test+branch inside keventd ?

> wakeup_krcud(void)
> {
> 	krcud_wanted = 1;
> 	wakeup(&keventd);
> }

> cheers,

> Rik
> -- 

keventd is not suitable for RCU at all. It can get starved out by RT
threads and that can result in either memory pressure or performance
degradation depending on how RCU is being used.

I have a patch that uses a per-cpu quiescent state counter. Cost of 
this on schedule() path is one per-cpu counter increment. I will
mail out the patch as soon as I can complete testing Andrea's review
comments on a bigger SMP box.

Most impartantly :-) it doesn't use kernel threads.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
