Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJNUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJNUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJNUzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:55:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18169 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266892AbUJNUei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:34:38 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041014195757.GA19295@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu>
	 <1097782921.5310.10.camel@dhcp153.mvista.com>
	 <20041014195757.GA19295@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097786071.5310.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Oct 2004 13:34:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This fixed it..


Daniel


On Thu, 2004-10-14 at 12:57, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > This was during NFS startup in init.
> > 
> > using smp_processor_id() in preemptible [00000001] code:
> > rpc.rquotad/2158
> > caller is ipt_do_table+0x7b/0x3a0
> >  [<c011aa15>] smp_processor_id+0x95/0xa0
> >  [<c038cbfb>] ipt_do_table+0x7b/0x3a0
> 
> ugh, this is a nasty one - if you look at the TABLE_OFFSET trickery in
> ipt_do_table it's basically an open-coded per-CPU variable in essence. 
> (probably predating percpu.h so it's fair.) Could you try the quick hack
> below? (it compiles but is otherwise untested)
> 
> The proper solution would be to change the code to use per-cpu variables
> (and get that patch accepted upstream) and then trivially convert it to
> get_cpu_var_locked().
> 
> 	Ingo
> 
> --- linux/net/ipv4/netfilter/ip_tables.c.orig
> +++ linux/net/ipv4/netfilter/ip_tables.c
> @@ -287,10 +287,14 @@ ipt_do_table(struct sk_buff **pskb,
>  	 * match it. */
>  	offset = ntohs(ip->frag_off) & IP_OFFSET;
>  
> +#ifdef CONFIG_PREEMPT_REALTIME
> +	write_lock_bh(&table->lock);
> +#else
>  	read_lock_bh(&table->lock);
> +#endif
>  	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
>  	table_base = (void *)table->private->entries
> -		+ TABLE_OFFSET(table->private, smp_processor_id());
> +		+ TABLE_OFFSET(table->private, _smp_processor_id());
>  	e = get_entry(table_base, table->private->hook_entry[hook]);
>  
>  #ifdef CONFIG_NETFILTER_DEBUG
> @@ -397,7 +401,11 @@ ipt_do_table(struct sk_buff **pskb,
>  #ifdef CONFIG_NETFILTER_DEBUG
>  	((struct ipt_entry *)table_base)->comefrom = 0xdead57ac;
>  #endif
> +#ifdef CONFIG_PREEMPT_REALTIME
> +	write_unlock_bh(&table->lock);
> +#else
>  	read_unlock_bh(&table->lock);
> +#endif
>  
>  #ifdef DEBUG_ALLOW_ALL
>  	return NF_ACCEPT;

