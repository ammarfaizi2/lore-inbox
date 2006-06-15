Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWFOXlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFOXlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFOXle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:41:34 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:13376 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750777AbWFOXle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:41:34 -0400
Message-ID: <4491F02B.5020003@bigpond.net.au>
Date: Fri, 16 Jun 2006 09:41:31 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Jay Lan <jlan@engr.sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com> <449182FB.6020907@watson.ibm.com>
In-Reply-To: <449182FB.6020907@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 15 Jun 2006 23:41:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
> 
>> I was talking about turning off system-wise taskstats data preparation and
>> delivery when every task exits. Sometimes customers like to do some
>> benchmarking and need to turn off nonessential features.
> 
> Lets go through the implications of turning on/off collection, assembly and delivery
> of the per-task accounting data.
> 
> Collection is defined by different subsystems using taskstats.
> For atleast one of these (delay accounting), turning on/off dynamically has been tried
> and deemed to cause a lot of overhead (due to accumalated nature of data) and also be
> prone to races. Complexity of code added did not justify the value so on/off was restricted
> to a boot time decision.
> 
> Assembly and delivery of data is done by the taskstats code, calling subsystem-specific functions to fill
> the commonly used struct taskstats and relying on genetlink to do the delivery.
> This can be turned on/off using a dynamic parameter such as /sys/kernel/taskstats_enable which sets
> some internal variable that is used to do early exits from relevant functions (mainly taskstats_send_stats
> and taskstats_exit_send)
> Doing so will have impact on
> a) queries sent to the kernel by monitoring applications
> b) task exit data sent by kernel to apps listening on the multicast socket
> 
> For consistency, I'm assuming both a) and b) will have to be affected when taskstats is turned off.
> Also, I'm assuming monitoring applications aren't aware of the turn off.
> 
> What happens to case a) ? Apps will need to get some error message as a reply. Some assembly overhead
> is saved (since such an error reply can be sent right away as soon as a query command is seen) but no
> substantial saving on the delivery part.
> 
> For case b), we can save on assembly and delivery by exiting early from taskstats_exit_send(). But won't
> we need to send some message (if not periodically, atleast once) to listening apps that they shouldn't
> expect any exit data ? Semantics of suddenly not seeing any exit data could be misinterpreted ?
> 
> Its easy enough to implement...just concerned about the semantics of doing so (as far as userspace
> apps are concerned) and utility in general settings. Utility in case where only CSA is running (delay
> accounting and other users turned off) is clear.
> 
> Thoughts ?

I would have thought that it was obvious that turning on/off the 
collection of statistics concerning the ACCRUED time that tasks spend in 
various states (which is what we're talking about) would cause the data 
to be horribly corrupted.

I also suspect that the overhead of the tests associated with checking 
whether the mechanism is on or off is probably almost as big as the 
overhead of gathering the statistics anyway.  Assuming that the clock 
time is already available (true for most places in the CPU scheduler 
where you'd want to gather stats, for one) the cost of gathering the 
stats is a subtraction, an addition and (possibly) an assignment to a 
time stamp (I say possibly here as you may get the time stamp updated 
for free as well).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
