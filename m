Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWEHGbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWEHGbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWEHGbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:31:35 -0400
Received: from proof.pobox.com ([207.106.133.28]:39895 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932337AbWEHGbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:31:34 -0400
Date: Mon, 8 May 2006 01:31:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/10] cpu bulk removal interface
Message-ID: <20060508063130.GB9344@localdomain>
References: <1147067158.2760.90.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147067158.2760.90.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> 
> Interface for bulk cpu removal. It's /sys/devices/system/cpu/cpu_bulk_remove
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
> 
>  linux-2.6.17-rc3-root/drivers/base/cpu.c  |   47 +++++++++++++++++++++++++++++-
>  linux-2.6.17-rc3-root/include/linux/cpu.h |    3 +
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/base/cpu.c~bulk_cpu_remove_interface drivers/base/cpu.c
> --- linux-2.6.17-rc3/drivers/base/cpu.c~bulk_cpu_remove_interface	2006-05-07 07:47:02.000000000 +0800
> +++ linux-2.6.17-rc3-root/drivers/base/cpu.c	2006-05-07 09:29:54.000000000 +0800
> @@ -76,6 +76,46 @@ static inline void register_cpu_control(
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +#ifdef CONFIG_BULK_CPU_REMOVE
> +static ssize_t cpu_bulk_remove_show(struct sysdev_class *c, char *buf)
> +{
> +	int len;
> +
> +	len = cpulist_scnprintf(buf, PAGE_SIZE-1, cpu_online_map);
> +	len += sprintf(buf + len, "\n");
> +	return len;
> +}

This doesn't really seem meaningful.  I'd say the attribute could do
without a show method.

> +static ssize_t cpu_bulk_remove_store(struct sysdev_class *c,
> +	const char *buf, size_t count)
> +{
> +	int err;
> +	cpumask_t removed_cpus;
> +
> +	if ((err = lock_cpu_hotplug_interruptible() != 0))
> +		return err;
> +	err = cpulist_parse(buf, removed_cpus);
> +	if (err) {
> +		unlock_cpu_hotplug();
> +		return err;
> +	}
> +
> +	unlock_cpu_hotplug();
> +	cpu_down_mask(removed_cpus);
> +	return count;
> +}

Shouldn't this make sure that we don't offline all cpus?

Why are you using lock_cpu_hotplug_interruptible instead of
lock_cpu_hotplug?

Why is only the parsing of the cpumask buffer protected by the cpu
hotplug lock?  Shouldn't cpu_down_mask be called with the lock held?

Can cpu_down_mask fail, and if so, shouldn't we be reporting the
error?
