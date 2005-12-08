Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLHUPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLHUPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLHUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:15:25 -0500
Received: from mail.suse.de ([195.135.220.2]:40101 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932310AbVLHUPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:15:24 -0500
Date: Thu, 8 Dec 2005 21:15:18 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051208201518.GN11190@wotan.suse.de>
References: <20051208194232.GC3776@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208194232.GC3776@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 11:42:32AM -0800, Ravikiran G Thirumalai wrote:
>  
> -	.align  L1_CACHE_BYTES
> +	/* zero the remaining page */
> +	.fill PAGE_SIZE / 8 - GDT_ENTRIES,8,0
> +	
>  ENTRY(idt_table)	

Why can't the IDT not be shared with the GDT page? It should be mostly
read only right and putting r-o data on that page should be ok, right?

> @@ -743,6 +743,13 @@
>  	};
>  	DECLARE_WORK(work, do_fork_idle, &c_idle);
>  
> +	/* allocate memory for gdts of secondary cpus. Hotplug is considered */
> +	if (!cpu_gdt_descr[cpu].address &&
> +			!(cpu_gdt_descr[cpu].address = get_zeroed_page(GFP_KERNEL))) {
> +		printk("Failed to allocate GDT for CPU %d\n", cpu);
> +		return 1;

Is this return really correctly handled? Doubtful.

-Andi

