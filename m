Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVF0Ov3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVF0Ov3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVF0Ote
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:49:34 -0400
Received: from holomorphy.com ([66.93.40.71]:5073 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262181AbVF0M5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:57:18 -0400
Date: Mon, 27 Jun 2005 05:56:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Levent Serinol <lserinol@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       riel@redhat.com
Subject: Re: [PATCH] enable/disable profiling via proc/sysctl
Message-ID: <20050627125649.GJ3334@holomorphy.com>
References: <2c1942a705062623411b7e88c3@mail.gmail.com> <20050627000125.1a6f8a91.akpm@osdl.org> <2c1942a7050627051357e9b532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1942a7050627051357e9b532@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:13:13PM +0300, Levent Serinol wrote:
> +#ifdef CONFIG_SMP
> +int remove_hash_tables(void)
> +{
> +	int cpu;
> +
> +
> +	for_each_online_cpu(cpu) {
> +		struct page *page;
> +
> +		if (per_cpu(cpu_profile_hits, cpu)[0]) {
> +			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[0]);
> +			per_cpu(cpu_profile_hits, cpu)[0] = NULL;
> +			__free_page(page);
> +		}
> +		if (per_cpu(cpu_profile_hits, cpu)[1]) {
> +			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[1]);
> +			per_cpu(cpu_profile_hits, cpu)[1] = NULL;
> +			__free_page(page);
> +		}
> +	}
> +	return -1;

Big problem. Timer interrupts can be firing while this is in progress.
The reason for profile_nop() is so that the code I have running during
timer interrupts (protected by local_irq_save()) runs to completion,
where it will afterward discover the flags or variables set to updated
states. You'll probably have to add more (e.g. memory barriers) since
you can tolerate less once you're dynamically allocating and freeing etc.


On Mon, Jun 27, 2005 at 03:13:13PM +0300, Levent Serinol wrote:
> @@ -560,7 +668,11 @@ static int __init create_proc_profile(vo
>  		return 0;
>  	entry->proc_fops = &proc_profile_operations;
>  	entry->size = (1+prof_len) * sizeof(atomic_t);
> -	hotcpu_notifier(profile_cpu_callback, 0);
> +#ifdef CONFIG_HOTPLUG_CPU
> +	register_cpu_notifier(&profile_cpu_notifier);
> +#endif
> +	profile_params[0] = prof_on;
> +	profile_params[1] = prof_shift;
>  	return 0;
>  }
>  module_init(create_proc_profile);

hotcpu_notifier() is there to avoid the #ifdef; you shouldn't need to
rearrange that.

Anyway, just keep fixing it up. There should be a few more after this.


-- wli
