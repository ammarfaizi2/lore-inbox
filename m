Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUC1RVu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUC1RVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:21:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11435 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262044AbUC1RVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:21:48 -0500
Date: Sun, 28 Mar 2004 22:50:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040328172036.GH5648@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com> <20040324225326.GH2065@dualathlon.random> <20040324231145.GB12035@in.ibm.com> <20040324233430.GJ2065@dualathlon.random> <20040324234643.GD12035@in.ibm.com> <s5hwu549alg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwu549alg.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 06:53:47PM +0200, Takashi Iwai wrote:
> At Thu, 25 Mar 2004 05:16:43 +0530,
> Dipankar Sarma wrote:
> > 
> > On Thu, Mar 25, 2004 at 12:34:30AM +0100, Andrea Arcangeli wrote:
> > > On Thu, Mar 25, 2004 at 04:41:45AM +0530, Dipankar Sarma wrote:
> > > > That was not 16 callbacks per tick, it was 16 callbacks in one
> > > > batch of a single softirq. And then I reschedule the RCU tasklet
> > > 
> > > sorry so you're already using tasklets in current code? I misunderstood
> > > the current code then.
> > 
> > +               if (count >= rcumaxbatch) {
> > +                       RCU_plugticks(cpu) = rcuplugticks;
> > +                       if (!RCU_plugticks(cpu))
> > +                               tasklet_hi_schedule(&RCU_tasklet(cpu));
> > +                       break;
> > +               }
> 
> it seems count is never incremented in your patch...
> or am i missing something?

I messed it up when I forward ported the throttle-rcu.patch
from 2.6.0+lots-of-instrumentation to 2.6.4-vanilla in order
to publish in lkml. The original patch did this -

@@ -110,6 +113,10 @@ static void rcu_do_batch(int cpu, struct
                head->func(head->arg);
                RCU_nr_rcupdates(cpu)++;
                count++;
+               if (count >= rcumaxbatch) {
+                       RCU_plugticks(cpu) = rcuplugticks;
+                       break;
+               }
        }

Sorry about that.

> anyway, i confirmed that with the original krcud patch the latency
> with dcache flood can be eliminated.

Does the throttle-rcu patch also help eliminate dcache flood ? You
can try by just changing count >= rcumaxbatch to ++count > rcumaxbatch.

> 
> for the non-preemptive case, rcu_bh_callback_limit() should return
> bhlimit always, though.  otherwise cond_resched() isn't called in the
> callback loop properly.
 
Yes, I think we should consider using  limiting even in the non-preemptive
case.

Thanks
Dipankar
