Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316527AbSEUGQC>; Tue, 21 May 2002 02:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316528AbSEUGQB>; Tue, 21 May 2002 02:16:01 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46981 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316527AbSEUGQB>; Tue, 21 May 2002 02:16:01 -0400
Date: Tue, 21 May 2002 11:48:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020521114850.A18654@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020516185448.A8069@in.ibm.com> <20020520085500.GB14488@krispykreme> <20020520212109.GA5821@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 11:21:09PM +0200, J.A. Magallon wrote:
> 
> >> I have been experimenting with Ingo's smptimers and I ended up
> >> extending it a little bit. I would really appreciate comments
> >> on whether these things make sense or not.
> >
> >I tried it out and found that we were context switching like crazy.
> >It seems we were always running the timers out of a tasklet because
> >we never unlocked the net_bh_lock.
> >
> 
> The patch for 2.4 in
> 
> http://people.redhat.com/mingo/scalable-timers-patches/
> 
> does not acquire net_bh_lock. Then I suppose it does not apply to that ?

No. Ingo's smptimers doesn't have this problem. However I am not
sure if this patch has timers completely serialized with respect
to old protocol code that ran from NET_BH earlier. See
deliver_to_old_ones() in net/core/dev.c. Unless I am missing something
big, disabling TIMER_BH there doesn't stop timers from firing
in run_local_timers().

> Can I try your patch for 2.5 on 2.4 or is there any infrastructure
> missing ?

Only 2.5ish thing I use is the per-cpu area APIs from Rusty for
the per-cpu tasklet in timer.c. You can replace it by
an array of NR_CPUS tasklets each cache line aligned.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
