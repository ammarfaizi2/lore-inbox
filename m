Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSILU5P>; Thu, 12 Sep 2002 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSILU5P>; Thu, 12 Sep 2002 16:57:15 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:52623 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S317984AbSILU5N>; Thu, 12 Sep 2002 16:57:13 -0400
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1031863543.3837.110.camel@phantasy>
References: <Pine.LNX.4.44.0209122242300.21936-100000@localhost.localdomain> 
	<1031863543.3837.110.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Sep 2002 14:58:27 -0600
Message-Id: <1031864307.2799.408.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 14:45, Robert Love wrote:
> On Thu, 2002-09-12 at 16:44, Ingo Molnar wrote:
> 
> > it *is* a great debugging check, at zero added cost. Scheduling from an
> > atomic region *is* a critical bug that can and will cause problems in 99%
> > of the cases. Rather fix the asserts that got triggered instead of backing
> > out useful debugging checks ...
> 
> There are a lot of shitty drivers that this is going to catch.  Yes,
> that is great... but we cannot BUG().  There really are a LOT of them. 
> In the least, we need to show_trace().
> 
> Anyhow, this currently will catch _all_ kernel preemptions because the
> PREEMPT_ACTIVE flag is set.
> 
> We need to do something like the attached (untested), at the very
> least...
> 
> I would prefer to make this a kernel debugging check, however.  Or, make
> using kernel preemption the default.  Using the "free" abilities of
> kernel preemption is great, but not at the expense of its users.
> 
> 	Robert Love
> 
> diff -urN linux-2.5.34/kernel/sched.c linux/kernel/sched.c
> --- linux-2.5.34/kernel/sched.c	Thu Sep 12 16:26:23 2002
> +++ linux/kernel/sched.c	Thu Sep 12 16:42:59 2002
> @@ -940,8 +940,10 @@
>  	struct list_head *queue;
>  	int idx;
>  
> -	if (unlikely(in_atomic()))
> -		BUG();
> +	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
> +		printk(KERN_ERROR "schedule() called while non-atomic!\n");
> +		show_stack(NULL);
> +	}
>  
>  #if CONFIG_DEBUG_HIGHMEM
>  	check_highmem_ptes();
> @@ -959,7 +961,7 @@
>  	 * if entering off of a kernel preemption go straight
>  	 * to picking the next task.
>  	 */
> -	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
> +	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
>  		goto pick_next_task;
>  
>  	switch (prev->state) {
> 

OK, that patch is tested now. I had to s/KERN_ERROR/KERN_ERR/, but
I was able to get the system to spew out some 
"schedule() called while non-atomic!"  messages along
with the traces. I can type those into a file and run it through
ksymoops if that would be helpful.

Steven

