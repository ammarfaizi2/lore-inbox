Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWBBCru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWBBCru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 21:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWBBCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 21:47:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422649AbWBBCrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 21:47:49 -0500
Date: Wed, 1 Feb 2006 18:47:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix cpu hotplug
Message-Id: <20060201184706.5638c1a3.akpm@osdl.org>
In-Reply-To: <20060202022555.GA11005@krispykreme>
References: <20060202022555.GA11005@krispykreme>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> Hi,
> 
> CPU hotplug was broken by the __meminit changes. Avoid the madness of
> creating a mem+cpu hotplug init attribute and just make them __devinit.
> 
> Anton
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: build/mm/page_alloc.c
> ===================================================================
> --- build.orig/mm/page_alloc.c	2006-02-02 12:20:50.000000000 +1100
> +++ build/mm/page_alloc.c	2006-02-02 13:14:56.000000000 +1100
> @@ -1799,7 +1799,7 @@ void zonetable_add(struct zone *zone, in
>  	memmap_init_zone((size), (nid), (zone), (start_pfn))
>  #endif
>  
> -static int __meminit zone_batchsize(struct zone *zone)
> +static int __devinit zone_batchsize(struct zone *zone)
>  {
>  	int batch;
>  
> @@ -1893,7 +1893,7 @@ static struct per_cpu_pageset
>   * Dynamically allocate memory for the
>   * per cpu pageset array in struct zone.
>   */
> -static int __meminit process_zones(int cpu)
> +static int __devinit process_zones(int cpu)
>  {
>  	struct zone *zone, *dzone;
>  
> @@ -1934,7 +1934,7 @@ static inline void free_zone_pagesets(in
>  	}
>  }
>  
> -static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
> +static int __devinit pageset_cpuup_callback(struct notifier_block *nfb,
>  		unsigned long action,
>  		void *hcpu)
>  {

These are __cpuinit in Linus's current tree.  Which probably means that
we're busted with hotplug-memory && !hotplug-cpu.

I don't think we want to make these __devinit, because that would penalise
systems which are hotplug && !hotplug-memory && !hotplug-cpu, which are the
systems which can least afford the memory waste.

So really, yes, we need the madness of mem+cpu.

Or we can do

static int __cpuinit __meminit foo(void)
{
}

Which actually seems to work.
