Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTKLVXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTKLVXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 16:23:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:35307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261299AbTKLVXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 16:23:05 -0500
Date: Wed, 12 Nov 2003 13:22:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: steiner@sgi.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Inefficient TLB flushing
Message-Id: <20031112132253.7f95df20.akpm@osdl.org>
In-Reply-To: <16306.40177.200706.688936@napali.hpl.hp.com>
References: <20031112200119.GA22429@sgi.com>
	<16306.40177.200706.688936@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
>   Jack> Here is the patch that I am currently testing:
> 
>   Jack> --- /usr/tmp/TmpDir.19957-0/linux/mm/memory.c_1.79	Wed Nov 12 13:56:25 2003
>   Jack> +++ linux/mm/memory.c	Wed Nov 12 12:57:25 2003
>   Jack> @@ -574,9 +574,10 @@
>   Jack>  			if ((long)zap_bytes > 0)
>   Jack>  				continue;
>   Jack>  			if (need_resched()) {
>   Jack> +				int fullmm = (*tlbp)->fullmm;
>   Jack>  				tlb_finish_mmu(*tlbp, tlb_start, start);
>   Jack>  				cond_resched_lock(&mm->page_table_lock);
>   Jack> -				*tlbp = tlb_gather_mmu(mm, 0);
>   Jack> +				*tlbp = tlb_gather_mmu(mm, fullmm);
>   Jack>  				tlb_start_valid = 0;
>   Jack>  			}
>   Jack>  			zap_bytes = ZAP_BLOCK_SIZE;
> 
> I think the patch will work fine, but it's not very clean, because it
> bypasses the TLB-flush API and directly accesses
> implementation-specific internals.  Perhaps it would be better to pass
> a "fullmm" flag to unmap_vmas().  Andrew?

Either that, or add a new interface function

	int mmu_gather_is_full_mm(mmu_gather *tlb);

and use it...

