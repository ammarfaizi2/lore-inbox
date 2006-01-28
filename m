Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWA1Tqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWA1Tqy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWA1Tqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:46:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38867 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750715AbWA1Tqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:46:53 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060128193412.GH5633@in.ibm.com>
References: <20060124092330.GA7060@elte.hu>
	 <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com>
	 <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe>
	 <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe>
	 <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe>
	 <1138474283.2799.24.camel@mindpipe>  <20060128193412.GH5633@in.ibm.com>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 14:46:48 -0500
Message-Id: <1138477609.2799.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 01:04 +0530, Dipankar Sarma wrote:
> On Sat, Jan 28, 2006 at 01:51:23PM -0500, Lee Revell wrote:
> > On Sat, 2006-01-28 at 13:00 -0500, Lee Revell wrote:
> > > OK, now we are making progress.
> > 
> > I spoke too soon, it's not fixed:
> > 
> > preemption latency trace v1.1.5 on 2.6.16-rc1
> > --------------------------------------------------------------------
> >  latency: 4183 us, #3676/3676, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
> >     -----------------
> > evolutio-2877  0d.s.   97us : local_bh_enable (rt_run_flush)
> > evolutio-2877  0d.s.   98us : local_bh_enable (rt_run_flush)
> > evolutio-2877  0d.s.   99us : local_bh_enable (rt_run_flush)
> > evolutio-2877  0d.s.  100us : local_bh_enable (rt_run_flush)
> > evolutio-2877  0d.s.  101us : local_bh_enable (rt_run_flush)
> > 
> > [ etc ]
> >  
> > evolutio-2877  0d.s. 4079us : local_bh_enable (rt_run_flush)
> > evolutio-2877  0d.s. 4080us : local_bh_enable (rt_run_flush)
> 
> I am not sure if I am interpreting the latency trace right,
> but it seems that there is a difference between the problem
> you were seeing earlier and now.
> 
> In one of your earlier traces, I saw  -
> 
>   <idle>-0     0d.s.  182us : dst_destroy (dst_rcu_free)
>   <idle>-0     0d.s.  183us : ipv4_dst_destroy (dst_destroy)
> 
> [ etc - zillions of dst_rcu_free()s deleted ]
> 
>   <idle>-0     0d.s. 13403us : dst_rcu_free (__rcu_process_callbacks)
>   <idle>-0     0d.s. 13403us : dst_destroy (dst_rcu_free)
> 
> This points to latency increase caused by lots and lots of
> RCU callbacks doing dst_rcu_free(). Do you still see those ?
> 
> Your new trace shows that we are held up in in rt_run_flush(). 
> I guess we need to investigate why we spend so much time in rt_run_flush(),
> because of a big route table or the lock acquisitions.

Yes, you are right, they are 2 different problems.  Paul suggested that
this patch might help with the rt_run_flush() problem.

It will take a while to determine whether it fixes the dst_rcu_free()
problem as I was never able to reproduce it on demand.

Lee

