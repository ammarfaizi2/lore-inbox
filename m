Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUCICx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbUCICx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 21:53:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:28094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbUCICxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 21:53:54 -0500
Date: Mon, 8 Mar 2004 18:53:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kingsley Cheung <kingsley@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] For preventing kstat overflow
Message-Id: <20040308185354.70040c8b.akpm@osdl.org>
In-Reply-To: <20040309132338.A30341@aurema.com>
References: <20040309132338.A30341@aurema.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung <kingsley@aurema.com> wrote:
>
> Hi All,
> 
> What do people think of a patch to change the fields in cpu_usage_stat
> from unsigned ints to unsigned long longs?  And the same change for
> nr_switches in the runqueue structure too?

Sounds unavoidable.

> Its actually worse for context
> switches on a busy system, for we've been seeing an average of ten
> switches a tick for some of the statistics we have.

Sounds broken.  What CPU scheduler are you using?


>  	for_each_online_cpu(i) {
> -		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
> +		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu\n",
>  			i,
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.irq),
> -			jiffies_to_clock_t(kstat_cpu(i).cpustat.softirq));
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.user),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.nice),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.system),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.idle),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.iowait),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.irq),
> +			jiffies_64_to_clock_t(kstat_cpu(i).cpustat.softirq));

jiffies_64_to_clock_t() takes and returns a u64, not an unsigned long long.

>  	}
> -	seq_printf(p, "intr %u", sum);
> +	seq_printf(p, "intr %llu", sum);

It would be best to convert everything to u64, not to unsigned long long. 
But cast them to unsigned long long for printk.

It's a bit ugly, but at least it pins everything down to know types and
sizes on all architectures.

>  struct cpu_usage_stat {
> -	unsigned int user;
> -	unsigned int nice;
> -	unsigned int system;
> -	unsigned int softirq;
> -	unsigned int irq;
> -	unsigned int idle;
> -	unsigned int iowait;
> +	unsigned long long user;
> +	unsigned long long nice;
> +	unsigned long long system;
> +	unsigned long long softirq;
> +	unsigned long long irq;
> +	unsigned long long idle;
> +	unsigned long long iowait;

Do these have appropriate locking or are we just accepting the occasional
glitch?

