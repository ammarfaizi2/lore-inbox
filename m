Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVISG3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVISG3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVISG3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:29:55 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:53613 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932329AbVISG3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=foBZbw/jOuaxA7fIL9qErkzlY7YMNJObAw/chrYKn/15sHbd41clhOFPlRuzq1GIopz5fR8QxnC2zQfhdD0asGnWS0Zorig07FLnLckiHNYtXXNcd3uYtdtY1AHtCsBdtobSKuILbtXyYMtKPaJUZ74wD1RmWrvDmZJgJlgSkCo=  ;
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: vatsa@in.ibm.com
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050919062336.GA9466@in.ibm.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 16:29:39 +1000
Message-Id: <1127111379.5272.5.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 11:53 +0530, Srivatsa Vaddagiri wrote:
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
> 
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
>  		clear_thread_flag(TIF_POLLING_NRFLAG);
>  	}
>  }
> 
> 
> Other idle routines will need similar fix.
> 

It seems to me that it would be much nicer to just go with Nigel's
first fix. That is, rather than clutter up all idle routines with
this.

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
