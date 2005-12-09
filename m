Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVLIDUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVLIDUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 22:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVLIDUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 22:20:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751256AbVLIDUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 22:20:50 -0500
Date: Thu, 8 Dec 2005 19:20:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Making high and batch sizes of per_cpu_pagelists
 configurable
Message-Id: <20051208192032.6387f638.akpm@osdl.org>
In-Reply-To: <20051208190016.A3975@unix-os.sc.intel.com>
References: <20051208190016.A3975@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> +	if ((high/4) > (PAGE_SHIFT * 8))
>  +		pcp->batch = PAGE_SHIFT * 8;

hm.  What relationship is there between log2(PAGE_SIZE) and the batch
quantity?  I'd have thought that if anything, we'd want to make the batch
sizes smaller for larger PAGE_SIZE.  Or something.

>  +}
>  +
>  +/*
>  + * percpu_pagelist_fraction - changes the pcp->high for each zone on each
>  + * cpu.  It is the fraction of total pages in each zone that a hot per cpu pagelist
>  + * can have before it gets flushed back to buddy allocator.
>  + */
>  +
>  +int percpu_pagelist_fraction_sysctl_handler(ctl_table *table, int write,
>  +	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
>  +{
>  +	struct zone *zone;
>  +	unsigned int cpu;
>  +	int ret;
>  +
>  +	ret = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
>  +	if (!write || (ret == -EINVAL))
>  +		return ret;
>  +	for_each_zone(zone) {
>  +		for_each_online_cpu(cpu) {
>  +			unsigned long  high;
>  +			high = zone->present_pages / percpu_pagelist_fraction;
>  +			setup_pagelist_highmark(zone_pcp(zone, cpu), high);

What happens if a CPU comes online afterwards?
