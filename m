Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFBUVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFBUVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFBUSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:18:01 -0400
Received: from fsmlabs.com ([168.103.115.128]:58803 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261326AbVFBUQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:16:33 -0400
Date: Thu, 2 Jun 2005 14:19:55 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 2/5] x86_64: CPU hotplug support.
In-Reply-To: <20050602130111.816070000@araj-em64t>
Message-ID: <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.816070000@araj-em64t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ashok Raj wrote:

> @@ -445,8 +477,10 @@ void __cpuinit start_secondary(void)
>  	/*
>  	 * Allow the master to continue.
>  	 */
> +	lock_ipi_call_lock();
>  	cpu_set(smp_processor_id(), cpu_online_map);
>  	mb();
> +	unlock_ipi_call_lock();

What's that? Is this another smp_call_function race workaround? I thought 
there was an additional patch to avoid the broadcast.

> +#include <asm/nmi.h>
> +/* We don't actually take CPU down, just spin without interrupts. */
> +static inline void play_dead(void)
> +{
> +	idle_task_exit();
> +	mb();
> +	/* Ack it */
> +	__get_cpu_var(cpu_state) = CPU_DEAD;
> +
> +	local_irq_disable();
> +	while (1)
> +		safe_halt();
> +}

Might as well drop the local_irq_disable since safe_halt enables 
interrupts.

	Zwane

