Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbTCKPMj>; Tue, 11 Mar 2003 10:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262944AbTCKPMj>; Tue, 11 Mar 2003 10:12:39 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:18705 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S262943AbTCKPMh>; Tue, 11 Mar 2003 10:12:37 -0500
Message-ID: <3E6DFF55.5070908@didntduck.org>
Date: Tue, 11 Mar 2003 10:23:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita1.ru>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] kernel/rcupdate.c microcleanup
References: <20030311140249.GB756@pazke>
In-Reply-To: <20030311140249.GB756@pazke>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> Hi all,
> 
> attached patch (2.5.64) contains small cleanup of RCU code:
>     - move smp_processor_id() outside of irq disabled region in call_rcu();
>     - consolidate multiple spin_unlock() in the rcu_check_quiescent_state(),
>       remove some unneeded {} and make this function inline.
> 
> Tested and works (at least doesn't crash). Please consider applying.
> 
> Best regards.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urN -X /usr/share/dontdiff linux-2.5.64.vanilla/kernel/rcupdate.c linux-2.5.64/kernel/rcupdate.c
> --- linux-2.5.64.vanilla/kernel/rcupdate.c	Thu Nov 28 01:35:46 2002
> +++ linux-2.5.64/kernel/rcupdate.c	Mon Mar 10 20:18:48 2003
> @@ -67,13 +67,12 @@
>   */
>  void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
>  {
> -	int cpu;
> +	int cpu = smp_processor_id();
>  	unsigned long flags;
>  
>  	head->func = func;
>  	head->arg = arg;
>  	local_irq_save(flags);
> -	cpu = smp_processor_id();
>  	list_add_tail(&head->list, &RCU_nxtlist(cpu));
>  	local_irq_restore(flags);
>  }

This is not preempt-safe.  smp_processor_id() can only be used in a 
preempt-disabled region (which local_irq_save() provides).

--
				Brian Gerst

