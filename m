Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSEUGXt>; Tue, 21 May 2002 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSEUGXs>; Tue, 21 May 2002 02:23:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24512 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316530AbSEUGXq>;
	Tue, 21 May 2002 02:23:46 -0400
Date: Tue, 21 May 2002 11:56:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020521115611.B18654@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020516185448.A8069@in.ibm.com> <20020520085500.GB14488@krispykreme> <20020520155958.F6270@in.ibm.com> <20020520133105.GC14488@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 11:31:05PM +1000, Anton Blanchard wrote:
> :) I was surprised it worked with the missing spin_unlock too. Im
> testing the fixed diff now, so far it looks good.

I was positively invaded by space aliens while writing that code.


> > I am curious about performance of smptimers. It seems that
> > webserver benchmark performance worsens with smptimers (Ingo version)
> > contrary to our expectations. Do you see this ? If so, could this
> > happen because -
> > 
> > 1) Bouncing around of global_bh_lock cacheline by more cpus compared
> > to earlier timer implemenation ?
> > 2) All per-cpu timers invoked from timer_bh running in one cpu ?
> > 
> > Do you see any other side-effects of smptimers ?
> 
> We used to see bad behaviour. It turned out to be the per cpu
> timer interrupt firing at exactly the same time on all cpus. One
> cpu would successfully spin_trylock and the others would fail
> and postpone the work.

This makes me wonder if using a per-cpu tasklet in my patch
is a bad idea after all. Perhaps Ingo had figured it out already
and used a single acquisition of global_bh_lock to fire
timers for all CPUs when timers get deferred from the local
timer interrupt.

In an ideal world where there are no BHs, we can parallelize
the timers like I did. But with global_bh_lock serialization,
I am not sure anymore if that is a good idea. I will try to
get some benchmark measurements done with these two approaches.

> 
> We now evenly space the per cpu interrupts. Does intel do the same?

AFAICS, no. But then I am still learning.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
