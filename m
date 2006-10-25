Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422971AbWJYExE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422971AbWJYExE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 00:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422978AbWJYExE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 00:53:04 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:26853 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1422971AbWJYExC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 00:53:02 -0400
Date: Tue, 24 Oct 2006 21:52:11 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Yinghai Lu <yinghai.lu@amd.com>
cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector
 for destroy_irq
In-Reply-To: <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0610242140140.20151@attu3.cs.washington.edu>
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
 <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Yinghai Lu wrote:

> --- linux-2.6/arch/x86_64/kernel/io_apic.c	2006-10-24 13:40:48.000000000 -0700
> +++ linux-2.6.xx/arch/x86_64/kernel/io_apic.c	2006-10-24 14:03:08.000000000 -0700
> @@ -716,6 +716,22 @@
>  	return vector;
>  }
>  
> +static void __clear_irq_vector(int irq)
> +{
> +	int old_vector = -1;
> +	if (irq_vector[irq] > 0)
> +		old_vector = irq_vector[irq];
> +	if (old_vector >= 0) {
> +		cpumask_t old_mask;
> +		int old_cpu;
> +		cpus_and(old_mask, irq_domain[irq], cpu_online_map);
> +		for_each_cpu_mask(old_cpu, old_mask)
> +			per_cpu(vector_irq, old_cpu)[old_vector] = -1;
> +	}
> +	irq_vector[irq] = 0;
> +	irq_domain[irq] = CPU_MASK_NONE;
> +}
> +

The two conditionals don't complement each other; in fact, only one 
conditional is required since the test for old_vector equality to zero 
will never be satisfied.  Also note that irq_vectors are u8 on x86_64 and 
not ints.

	static void __clear_irq_vector(int irq)
	{
		u8 old_vector = irq_vector[irq];
		if (old_vector > 0) {
			cpumask_t old_mask;
			int old_cpu;
			cpus_and(old_mask, irq_domain[irq], cpu_online_map);
			for_each_cpu_mask(old_cpu, old_mask)
				per_cpu(vector_irq, old_cpu)[old_vector] = -1;
		}
		irq_vector[irq] = 0;
		irq_domain[irq] = CPU_MASK_NONE;
	}
