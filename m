Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWAKFBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWAKFBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWAKFBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:01:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:59619 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751368AbWAKFBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:01:39 -0500
Date: Tue, 10 Jan 2006 21:01:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: fix hotplug-cpu ->donelist leak
Message-ID: <20060111050159.GN18252@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com> <20060110095811.GA30159@in.ibm.com> <43C3C3B5.61D5641@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3C3B5.61D5641@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 05:24:53PM +0300, Oleg Nesterov wrote:
> Pointed out by Srivatsa Vaddagiri <vatsa@in.ibm.com>.
> 
> rcu_do_batch() stops after processing maxbatch callbacks
> on ->donelist leaving rcu_tasklet in TASKLET_STATE_SCHED
> state.
> 
> If CPU_DEAD event happens remaining ->donelist entries are
> lost, rcu_offline_cpu() kills this tasklet.
> 
> With this patch ->donelist migrates along with ->curlist
> and ->nxtlist to the current cpu.
> 
> Compile tested.

Looks good, but I fat-fingered my test scripts and left it out.  :-/

Started another RCU-torture run...

							Thanx, Paul

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/kernel/rcupdate.c~4_HPFIX	2006-01-10 19:06:38.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-10 19:15:01.000000000 +0300
> @@ -343,8 +343,9 @@ static void __rcu_offline_cpu(struct rcu
>  	spin_unlock_bh(&rcp->lock);
>  	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
>  	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
> -
> +	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
>  }
> +
>  static void rcu_offline_cpu(int cpu)
>  {
>  	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
> 
