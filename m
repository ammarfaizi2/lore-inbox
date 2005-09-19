Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVISGbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVISGbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVISGbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:31:48 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:36528 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932332AbVISGbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:31:47 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: vatsa@in.ibm.com
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050919062336.GA9466@in.ibm.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127111495.9696.102.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 16:31:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-09-19 at 16:23, Srivatsa Vaddagiri wrote:
> On Mon, Sep 19, 2005 at 04:11:11PM +1000, Nigel Cunningham wrote:
> > > Ok, that makes sense. Nigel, could you confirm which idle routine you are 
> > > using?
> > 
> > >From dmesg:
> > 
> > monitor/mwait feature present.
> > using mwait in idle threads.
> 
> Ok, that may explain why __cpu_die is timing out for you! Can you try a 
> (untested, I am afraid) patch on these lines: 

Will do. Given my (understandable I guess) difficulty in reproducing it
reliably, shall I add a printk in there so I can see when it would have
otherwise failed to drop out?

> --- process.c.org	2005-09-19 11:44:57.000000000 +0530
> +++ process.c	2005-09-19 11:48:28.000000000 +0530
> @@ -245,16 +245,18 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
>   */
>  static void mwait_idle(void)
>  {
> +	int cpu = raw_smp_processor_id();
> +
>  	local_irq_enable();
>  
>  	if (!need_resched()) {
>  		set_thread_flag(TIF_POLLING_NRFLAG);
>  		do {
>  			__monitor((void *)&current_thread_info()->flags, 0, 0);
> -			if (need_resched())
> +			if (need_resched() || cpu_is_offline(cpu))
>  				break;
>  			__mwait(0, 0);
> -		} while (!need_resched());
> +		} while (!need_resched() || !cpu_is_offline(cpu));

Shouldn't this be !need_resched() && !cpu_is_offline(cpu)?

Regards,

Nigel

>  		clear_thread_flag(TIF_POLLING_NRFLAG);
>  	}
>  }
> 
> 
> Other idle routines will need similar fix.
> 
> > Ok, but what about default_idle?
> 
> default_idle should be fine as it is. IOW it should not cause __cpu_die to 
> timeout.
-- 


