Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVKCCJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKCCJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVKCCJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:09:04 -0500
Received: from ozlabs.org ([203.10.76.45]:54975 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030277AbVKCCJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:09:02 -0500
Subject: Re: [2.6.14-rt1] slowdown / oops.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: =?iso-8859-2?Q?Pawe=B3?= Sikora <pluto@agmk.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
In-Reply-To: <20051102153352.GA26115@elte.hu>
References: <200511021420.28104.pluto@agmk.net>
	 <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu>
	 <20051102140025.GA17385@elte.hu> <20051102142533.GA18453@elte.hu>
	 <20051102151242.GA23809@elte.hu>  <20051102153352.GA26115@elte.hu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 13:09:01 +1100
Message-Id: <1130983742.8734.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 16:33 +0100, Ingo Molnar wrote:
> local_bh_disable()/enable() is a NOP under PREEMPT_RT, and the 
> ip_ct_deliver_cached_events PER_CPU code relies on not being preempted 
> by the net_rx_action softirq handler. So this is a bug in PREEMPT_RT and 
> the upstream code should be fine.
> 
> 	Ingo
> 
> Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
> +++ linux/net/ipv4/netfilter/ip_conntrack_core.c
> @@ -105,11 +105,11 @@ void ip_ct_deliver_cached_events(const s
>  {
>  	struct ip_conntrack_ecache *ecache;
>  	
> -	local_bh_disable();
> +	read_lock_bh(&ip_conntrack_lock);
>  	ecache = &__get_cpu_var(ip_conntrack_ecache);
>  	if (ecache->ct == ct)
>  		__ip_ct_deliver_cached_events(ecache);
> -	local_bh_enable();
> +	read_unlock_bh(&ip_conntrack_lock);

This kind of change is troubling.  I suppose we could go to per-cpu
locks, but it's still a loss.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

