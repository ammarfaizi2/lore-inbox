Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUDSM57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUDSM57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:57:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15501 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264398AbUDSM54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:57:56 -0400
Date: Mon, 19 Apr 2004 18:28:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [lhcs-devel] Re: CPU Hotplug broken -mm5 onwards
Message-ID: <20040419125853.GB6835@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040418170613.GA21769@in.ibm.com> <408348B6.7020606@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408348B6.7020606@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 01:34:14PM +1000, Nick Piggin wrote:
> I think a rwsem might be a good idea anyway, because
> sched_migrate_task can end up being called pretty often with
> balance on exec and balance on clone. The semaphore could easily
> place undue serialisation on that path.

I found that r/w sem does not help here ..It can still lead to deadlocks.
One example I hit is :

cpu_up takes write lock, sends out CPU_UP_PREPARE notification. As part
of it, many do kthread_create, which uses workqueue. The work function
is never processed because keventd would be blocked on a previous 
work function, waiting for hotplug sem in exec path.

So, as Rusty said, I think we really need to consider removing
lock_cpu_hotplug from sched_migrate_task. AFAICS that lock
was needed to prevent adding tasks to dead cpus. The same 
can be accomplished by removing lock_cpu_hotplug from sched_migrate_task
and adding a cpu_is_offline check in __migrate_task.
This will eliminate all the deadlocks I have been hitting.


> Can we arrange some of these checks to disappear when HOTPLUG_CPU
> is not set? For example, make cpu_is_offline only valid to call for
> CPUs that have been online sometime, and can evaluate to 0 if
> HOTPLUG_CPU is not set?

I think this is already being done in include/linux/cpu.h

	

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
