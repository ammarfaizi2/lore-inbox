Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbSI2TFQ>; Sun, 29 Sep 2002 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSI2TFQ>; Sun, 29 Sep 2002 15:05:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40417 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261739AbSI2TFI>; Sun, 29 Sep 2002 15:05:08 -0400
Date: Mon, 30 Sep 2002 00:45:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930004559.A19071@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Sep 29, 2002 at 07:52:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

First of all, YES! I am going to start testing first thing tomorrow.

On Sun, Sep 29, 2002 at 07:52:17PM +0200, Ingo Molnar wrote:
> 
> i've done the following cleanups/simplifications to task-queues:
> 
>  - removed the ability to define your own task-queue, what can be done is 
>    to schedule_task() a given task to keventd, and to flush all pending 
>    tasks.
> 
> this is actually a quite easy transition, since 90% of all task-queue
> users in the kernel used BH_IMMEDIATE - which is very similar in
> functionality to keventd.

This is a problem I ran into in my "kill-BHs" project. I was wondering
if callbacks executed through keventd might have significantly
higher latency (and potential starvation) compared to IMMEDIATE_BH
driven task-queues and that might break existing drivers. Is this not 
going to be an issue ?

> net_bh_lock: i have removed it, since it would synchronize to nothing. The
> old protocol handlers should still run on UP, and on SMP the kernel prints
> a warning upon use. Alexey, is this approach fine with you?

The cache line bouncing of global_bh_lock and net_bh_lock in
run_timer_tasklet() show up in our profiles, so getting rid of
them is a good thing (TM).

> scalable timers: i've further improved the patch ported to 2.5 by wli and
> Dipankar. There is only one pending issue i can see, the question of
> whether to migrate timers in mod_timer() or not. I'm quite convinced that
> they should be migrated, but i might be wrong. It's a 10 lines change to
> switch between migrating and non-migrating timers, we can do performance
> tests later on. The current, more complex migration code is pretty fast
> and has been stable under extremely high networking loads in the past 2
> years, so we can immediately switch to the simpler variant if someone
> proves it improves performance. (I'd say if non-migrating timers improve
> Apache performance on one of the bigger NUMA boxes then the point is
> proven, no further though will be needed.)

I will start testing this patch and will try to get you some numbers.
Thanks for taking this up.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
