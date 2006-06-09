Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbWFIVaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbWFIVaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWFIVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:30:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030518AbWFIVav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:30:51 -0400
Date: Fri, 9 Jun 2006 14:33:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Re: Light weight counter 1/1 Framework
Message-Id: <20060609143333.39b29109.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> -/*
> - * Accumulate the page_state information across all CPUs.
> - * The result is unavoidably approximate - it can change
> - * during and after execution of this function.
> - */

sob.  How about updating the nice comment rather than removing it?

>  
> -void get_full_page_state(struct page_state *ret)
> +void all_vm_events(unsigned long *ret)
>  {
> -	cpumask_t mask = CPU_MASK_ALL;
> -
> -	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
> +	sum_vm_events(ret, &cpu_online_map);
>  }
> +EXPORT_SYMBOL(all_vm_events);
>  
> -unsigned long read_page_state_offset(unsigned long offset)
> +unsigned long get_global_vm_events(enum vm_event_item e)
>  {
>  	unsigned long ret = 0;
>  	int cpu;
>  
> -	for_each_online_cpu(cpu) {
> -		unsigned long in;
> +	for_each_possible_cpu(cpu)
> +		ret += per_cpu(vm_event_states, cpu).event[e];
>  
> -		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
> -		ret += *((unsigned long *)in);
> -	}
>  	return ret;
>  }

Here.   Some description of the difference between these two, and why one
would call one and not the other.

I'd be rather interested in reading that comment because afaict,
get_global_vm_events() has no callers.

And nor should it, please.  It has potential to be seriously inefficient. 
Much, much better to kill this function and to implement a CPU hotplug
notifier to spill the going-away CPU's stats into another CPU's
accumulators.

