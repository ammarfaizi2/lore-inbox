Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315819AbSETK2B>; Mon, 20 May 2002 06:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315832AbSETK2A>; Mon, 20 May 2002 06:28:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63620 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315819AbSETK16>;
	Mon, 20 May 2002 06:27:58 -0400
Date: Mon, 20 May 2002 15:59:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020520155958.F6270@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020516185448.A8069@in.ibm.com> <20020520085500.GB14488@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 06:55:00PM +1000, Anton Blanchard wrote:
> 
> Hi Dipankar,
> 
> > I have been experimenting with Ingo's smptimers and I ended up
> > extending it a little bit. I would really appreciate comments
> > on whether these things make sense or not.
> 
> I tried it out and found that we were context switching like crazy.
> It seems we were always running the timers out of a tasklet because
> we never unlocked the net_bh_lock.

The tasklet code also needs fixing. It is a miracle that the kernel
booted when I tested that code. Here is a fixed diff.

I am curious about performance of smptimers. It seems that
webserver benchmark performance worsens with smptimers (Ingo version)
contrary to our expectations. Do you see this ? If so, could this
happen because -

1) Bouncing around of global_bh_lock cacheline by more cpus compared
to earlier timer implemenation ?
2) All per-cpu timers invoked from timer_bh running in one cpu ?

Do you see any other side-effects of smptimers ?

Also, did my PPC changes for smptimers work or you had to fix it ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

--- linux-2.5.12-smptimers/kernel/timer.c	Tue May 14 13:21:26 2002
+++ linux-2.5.14-smptimers/kernel/timer.c	Mon May 20 15:46:29 2002
@@ -680,19 +680,14 @@
                 goto resched;
 
         if (!spin_trylock(&net_bh_lock))
-                goto resched_net;
-
-        if (!hardirq_trylock(cpu))
                 goto resched_unlock;
 
 	if ((long)(jiffies - base->timer_jiffies) >= 0)
 		__run_timers(base);
 
-        hardirq_endlock(cpu);
+        spin_unlock(&net_bh_lock);
         spin_unlock(&global_bh_lock);
         return;
-resched_net:
-        spin_unlock(&net_bh_lock);
 resched_unlock:
         spin_unlock(&global_bh_lock);
 resched:
@@ -719,20 +714,21 @@
 	if (!spin_trylock(&global_bh_lock))
 		goto out_enable_mark;
         if (!spin_trylock(&net_bh_lock))
-                goto out_unlock_net;
+                goto out_unlock_enable_mark;
 
 	if (!hardirq_trylock(cpu))
-		goto out_unlock_enable_mark;
+		goto out_unlock_enable_mark_net;
 
 	if ((long)(jiffies - base->timer_jiffies) >= 0)
 		__run_timers(base);
 
 	hardirq_endlock(cpu);
+	spin_unlock(&net_bh_lock);
 	spin_unlock(&global_bh_lock);
 	local_irq_enable();
 	local_bh_enable();
 	return;
-out_unlock_net:
+out_unlock_enable_mark_net:
 	spin_unlock(&net_bh_lock);
 out_unlock_enable_mark:
 	spin_unlock(&global_bh_lock);


