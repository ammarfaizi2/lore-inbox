Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVISGYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVISGYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVISGYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:24:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:35291 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932329AbVISGYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:24:18 -0400
Date: Mon, 19 Sep 2005 11:53:36 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919062336.GA9466@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com> <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127110271.9696.97.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:11:11PM +1000, Nigel Cunningham wrote:
> > Ok, that makes sense. Nigel, could you confirm which idle routine you are 
> > using?
> 
> >From dmesg:
> 
> monitor/mwait feature present.
> using mwait in idle threads.

Ok, that may explain why __cpu_die is timing out for you! Can you try a 
(untested, I am afraid) patch on these lines: 

--- process.c.org	2005-09-19 11:44:57.000000000 +0530
+++ process.c	2005-09-19 11:48:28.000000000 +0530
@@ -245,16 +245,18 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 static void mwait_idle(void)
 {
+	int cpu = raw_smp_processor_id();
+
 	local_irq_enable();
 
 	if (!need_resched()) {
 		set_thread_flag(TIF_POLLING_NRFLAG);
 		do {
 			__monitor((void *)&current_thread_info()->flags, 0, 0);
-			if (need_resched())
+			if (need_resched() || cpu_is_offline(cpu))
 				break;
 			__mwait(0, 0);
-		} while (!need_resched());
+		} while (!need_resched() || !cpu_is_offline(cpu));
 		clear_thread_flag(TIF_POLLING_NRFLAG);
 	}
 }


Other idle routines will need similar fix.

> Ok, but what about default_idle?

default_idle should be fine as it is. IOW it should not cause __cpu_die to 
timeout.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
