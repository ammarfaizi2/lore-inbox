Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSETI6L>; Mon, 20 May 2002 04:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314684AbSETI6K>; Mon, 20 May 2002 04:58:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:20616 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314396AbSETI6J>;
	Mon, 20 May 2002 04:58:09 -0400
Date: Mon, 20 May 2002 18:55:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020520085500.GB14488@krispykreme>
In-Reply-To: <20020516185448.A8069@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dipankar,

> I have been experimenting with Ingo's smptimers and I ended up
> extending it a little bit. I would really appreciate comments
> on whether these things make sense or not.

I tried it out and found that we were context switching like crazy.
It seems we were always running the timers out of a tasklet because
we never unlocked the net_bh_lock.

Anton

diff -urN linux-2.5_smptimers/kernel/timer.c linux-2.5_tux/kernel/timer.c
--- linux-2.5_smptimers/kernel/timer.c	Mon May 20 18:48:18 2002
+++ linux-2.5_tux/kernel/timer.c	Mon May 20 18:41:32 2002
@@ -694,6 +694,7 @@
 		__run_timers(base);
 
         hardirq_endlock(cpu);
+        spin_unlock(&net_bh_lock);
         spin_unlock(&global_bh_lock);
         return;
 resched_net:
@@ -733,6 +734,7 @@
 		__run_timers(base);
 
 	hardirq_endlock(cpu);
+	spin_unlock(&net_bh_lock);
 	spin_unlock(&global_bh_lock);
 	local_irq_enable();
 	local_bh_enable();
