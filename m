Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTK1Vfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTK1Vfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:35:46 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:2987 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263485AbTK1Vfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:35:44 -0500
Date: Fri, 28 Nov 2003 19:35:41 -0200
From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sisopiii-l@cscience.org
Subject: Re: [PATCH] fix #endif misplacement
Message-Id: <20031128193541.448d2893.rnsanchez@terra.com.br>
In-Reply-To: <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
	<Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting  Tim Schmielau <tim@physik3.uni-rostock.de>
Sent on  Fri, 28 Nov 2003 17:34:49 +0100 (CET)

> > This patch fixes an #endif misplacement, which leads to dead code in
> > sched_clock() in arch/i386/kernel/timers/timer_tsc.c, due to a return
> > outside the ifdef/endif.
> 
> No, this is exactly what is intended: don't use the TSC on NUMA, use 
> jiffies instead.
> Look at the comment just above those lines.

I'm breaking things.  Sorry.

I think I understood it now: the #ifndef protects only the check for TSC
availability on non-NUMA archs.  If it's available, and not under NUMA (so
the ifndef), use it (jump to the rdtscll()), otherwise return the expression
result.

The strange thing to me is that I'm getting 1/10 of the expected value when
measuring tasks timeslices.  Instead of getting ~100ms for tasks which just
burn CPU, I'm getting 10ms.

I measure timeslices inside schedule(), updating the average timeslice for
the leaving process, using (now - prev->timestamp).

Any clue of what am I doing wrong?

Regards.


unsigned long long sched_clock(void)
{
        unsigned long long this_offset;

        /*
         * In the NUMA case we dont use the TSC as they are not
         * synchronized across all CPUs.
         */
#ifndef CONFIG_NUMA
        if (!use_tsc)
#endif
                return (unsigned long long)jiffies * (1000000000 / HZ);

        /* Read the Time Stamp Counter */
        rdtscll(this_offset);

        /* return the value in ns */
        return cycles_2_ns(this_offset);
}


-- 
Ricardo Nabinger Sanchez
GNU/Linux #140696 [http://counter.li.org]
Slackware Linux

  Warning: 
    Trespassers will be shot.
    Survivors will be shot again.
