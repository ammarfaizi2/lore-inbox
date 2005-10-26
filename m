Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVJZQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVJZQDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVJZQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:03:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44540 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964795AbVJZQDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:03:23 -0400
Message-ID: <435FA8BD.4050105@mvista.com>
Date: Wed, 26 Oct 2005 09:03:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
Subject: Re: 2.6.14-rc4-rt7
References: <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu> <20051022035851.GC12751@elte.hu> <1130182121.4983.7.camel@cmn3.stanford.edu> <1130182717.4637.2.camel@cmn3.stanford.edu> <1130183199.27168.296.camel@cog.beaverton.ibm.com> <20051025154440.GA12149@elte.hu> <1130264218.27168.320.camel@cog.beaverton.ibm.com> <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
In-Reply-To: <20051026082800.GB28660@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>The TSC is such a fast and, usually, accurate answer, I think it 
>>deserves a little effort to save it.  With your new clock code I think 
>>we could use per cpu TSC counters, read the full 64 bits and, in real 
>>corner cases, even per cpu conversion "constants" and solve this 
>>problem.
> 
> 
> the problem is, this is the same issue as 'boot-time TSC syncing', but 
> in disguise: to get any 'per CPU TSC offset' you need to do exactly the 
> same type of careful all-CPUs-dance to ensure that the TSCs were sampled 
> at around the same moment in time!
> 
> The box where i have these small TSC inconsistencies shows that it's the 
> bootup synchronization of TSCs that failed to be 100% accurate. Even a 2 
> usecs error in synchronization can show up as a time-warp - regardless 
> of whether we keep per-CPU TSC offsets or whether we clear these offsets 
> back to 0. So it is not a solution to do another type of synchronization 
> dance. The only solution is to fix the boot-time synchronization (where 
> the hardware keeps TSCs synchronized all the time), or to switch TSCs 
> off where this is not possible.
> 
I was rather thinking of only comparing a cup's TSC with the SAME cup's TSC.  We only use the TSC to 
bridge from the latest update of the the clock to now and when we update the clock we capture (i.e. 
update this cup's last TSC value) the TSC on that CPU.  If we also capture the system time then we 
have a set of (last TSC, sys clock) for each CPU.  If we further, keep 64-bits of TSC, we don't 
really require each cpu to update the clock very often, or, we could force such and update from time 
to time as needed.  This would not require the TSC to be synced at all and even if they had 
different rates we could add that to the per cpu data and cover that too.

What this does require is that we do a really good job of figuring the TSC multiplier, something we 
don't do at all well today (rc5-rt5 on my box is fast by ~15 sec/ day).  We might also want to 
verify that we are not letting monotonic time be other than monotonic :)

As you might suspect, I have some ideas about how to do a much better job of figuring out the TSC 
multiplier.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
