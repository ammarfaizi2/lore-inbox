Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWJWRef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWJWRef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWJWRef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:34:35 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:29033 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932211AbWJWRee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:34:34 -0400
Date: Mon, 23 Oct 2006 19:34:30 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Message-ID: <20061023173430.GX4354@rhun.haifa.ibm.com>
References: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 12:02:44AM -0700, Yinghai Lu wrote:
> in phys flat mode, when using set_xxx_irq_affinity to irq balance from
> one cpu to another,  _assign_irq_vector will get to increase last used
> vector and get new vector. this will use up the vector if enough
> set_xxx_irq_affintiy are called. and end with using same vector in
> different cpu for different irq. (that is not what we want, we only
> want to use same vector in different cpu for different irq when more
> than 0x240 irq needed). To keep it simple, the vector should be resued
> from one cpu to another instead of getting new vector.
> 
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

> diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
> index b000017..3989fa5 100644
> --- a/arch/x86_64/kernel/io_apic.c
> +++ b/arch/x86_64/kernel/io_apic.c
> @@ -624,11 +624,32 @@ static int __assign_irq_vector(int irq, 
>  	if (irq_vector[irq] > 0)
>  		old_vector = irq_vector[irq];
>  	if (old_vector > 0) {
> +		cpumask_t domain, new_mask, old_mask;
> +		int new_cpu, old_cpu;
>  		cpus_and(*result, irq_domain[irq], mask);
>  		if (!cpus_empty(*result))
>  			return old_vector;
> +
> +		/* try to reuse vector for phys flat */
> +		domain = vector_allocation_domain(cpu);

cpu is used unitialized here. Please send an updated patch and I'll
give it a spin.

Cheers,
Muli
