Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbUDFPUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDFPUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:20:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:52454 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263870AbUDFPT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:19:57 -0400
Date: Tue, 6 Apr 2004 20:50:46 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406152046.GB8996@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com> <407277AE.2050403@yahoo.com.au> <20040406145616.GB8516@in.ibm.com> <4072C6EA.1070803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4072C6EA.1070803@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:04:10AM +1000, Nick Piggin wrote:
> AFAIKS, no.
> 
> If this happens before migrate_all_tasks, there shouldn't be a
> problem because migrate_all_tasks will move the woken task anyway.
> 
> It can't happen after migrate_all_tasks, because there is nothing
> on the offline CPU to be woken up.

Hmm ..I was thinking of this scenario ..Lets say task A uses
schedule_timeout on CPU3 :


	schedule_timeout(10ms);

A timer is added in CPU3 meant to fire after (max) 10 ms.
The task is then put to sleep.

During this sleep duration, CPU3 can go down. migrate_all_tasks
not finding A in the runqueue won't bother abt it.

As pary of CPU_DEAD processing, migrate_timers will move the timer
that was added in CPU3 to CPU2 (say). 

After 10 ms, when the timer fires on CPU2, it will do a wakeup on 
Task A. At that point, won't Task A still be affine to CPU3? Won't
try_to_wake_up attempt adding it to CPU3? At that point 'this_cpu'
is 2 and 'cpu' is 3 (in try_to_wake_up)?

> If you do need the check there, then my lazy migrate method is
> unquestionably better, because this is the only thing it would
> otherwise have to add to a fastpath. Right?

I don't think we strictly need the cpu_is_offline check in try_to_wake_up
if we were to migrate _all_ (running 'n sleeping) tasks in one shot 
(with tasklist lock held) when a CPU goes down :-)

Sorry I did not mean to compare our patches like this, just trying to work
out which will be the right thing to do!!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
