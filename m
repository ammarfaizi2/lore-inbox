Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWDJXTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWDJXTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWDJXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:19:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932168AbWDJXTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:19:04 -0400
Date: Mon, 10 Apr 2006 15:18:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: kiran@scalex86.org, Laurent.Vivier@bull.net, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] per cpu counter fixes for unsigned long type
 counter overflow
Message-Id: <20060410151817.27766565.akpm@osdl.org>
In-Reply-To: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
References: <1144691947.3964.54.camel@dyn9047017067.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> [PATCH 1/3] - Currently the"long" type counter maintained in percpu
> counter could have issue when handling a counter that is a unsigned long
> type. Most cases this could be easily fixed by casting the returned
> value to "unsigned long". But for the "overflow" issue, i.e. because of
> the percpu global counter is a approsimate value, there is a
> possibility that at some point the global counter is close to the max
> limit (oxffff_feee) but after updating from a local counter a positive
> value, the global counter becomes a small value (i.e.0x 00000012). 
> 
> This patch tries to avoid this overflow happen. When updating from a
> local counter to the global counter, add a check to see if the updated
> value is less than before if we are doing an positive add, or if the
> updated value is greater than before if we are doing an negative add.
> Either way we should postpone the updating from this local counter to
> the global counter.
> 
>  
> -static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
> +static void __percpu_counter_mod(struct percpu_counter *fbc, long amount,
> +				int llcheck)

Confused.  What does "ll" stand for throughout this patch?

Whatever it is, I suspect we need to choose something better ;)

>  {
>  	long count;
>  	long *pcount;
>  	int cpu = smp_processor_id();
> +	unsigned long before, after;
> +	int update = 1;
>  
>  	pcount = per_cpu_ptr(fbc->counters, cpu);
>  	count = *pcount + amount;
>  	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
>  		spin_lock(&fbc->lock);
> -		fbc->count += count;
> -		*pcount = 0;
> +		before = fbc->count;
> +		after = before + count;
> +		if (llcheck && ((count > 0 && after < before) ||
> +				( count < 0 && after > before)))
> +			update = 0;
> +
> +		if (update) {
> +			fbc->count = after;
> +			*pcount = 0;
> +		}

The above bit of magic deserves an explanatory comment.

>  		spin_unlock(&fbc->lock);
>  	} else {
>  		*pcount = count;
>  	}
>  }
>  
> +void percpu_counter_mod_ll(struct percpu_counter *fbc, long amount)
> +{
> +	preempt_disable();
> +	__percpu_counter_mod(fbc, amount, 1);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(percpu_counter_mod_ll);

An introductory comment which describes the difference between this and
percpu_counter_mod() would be helpful, please.


