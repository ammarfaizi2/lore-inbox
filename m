Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTKMDSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKMDSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:18:44 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:39136 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262001AbTKMDSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:18:40 -0500
Date: Wed, 12 Nov 2003 21:18:01 -0600
From: Jack Steiner <steiner@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Inefficient TLB flushing
Message-ID: <20031113031801.GA17689@sgi.com>
References: <20031112200119.GA22429@sgi.com> <16306.40177.200706.688936@napali.hpl.hp.com> <20031112132253.7f95df20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112132253.7f95df20.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 01:22:53PM -0800, Andrew Morton wrote:
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >
> >   Jack> Here is the patch that I am currently testing:
> > 
> >   Jack> --- /usr/tmp/TmpDir.19957-0/linux/mm/memory.c_1.79	Wed Nov 12 13:56:25 2003
> >   Jack> +++ linux/mm/memory.c	Wed Nov 12 12:57:25 2003
> >   Jack> @@ -574,9 +574,10 @@
> >   Jack>  			if ((long)zap_bytes > 0)
> >   Jack>  				continue;
> >   Jack>  			if (need_resched()) {
> >   Jack> +				int fullmm = (*tlbp)->fullmm;
> >   Jack>  				tlb_finish_mmu(*tlbp, tlb_start, start);
> >   Jack>  				cond_resched_lock(&mm->page_table_lock);
> >   Jack> -				*tlbp = tlb_gather_mmu(mm, 0);
> >   Jack> +				*tlbp = tlb_gather_mmu(mm, fullmm);
> >   Jack>  				tlb_start_valid = 0;
> >   Jack>  			}
> >   Jack>  			zap_bytes = ZAP_BLOCK_SIZE;
> > 
> > I think the patch will work fine, but it's not very clean, because it
> > bypasses the TLB-flush API and directly accesses
> > implementation-specific internals.  Perhaps it would be better to pass
> > a "fullmm" flag to unmap_vmas().  Andrew?
> 
> Either that, or add a new interface function
> 
> 	int mmu_gather_is_full_mm(mmu_gather *tlb);
> 
> and use it...
> 

How implementation independent should it be? Currently, there is only one
field in the mmu_gather structure that must be preserved. However, if we
want to make the interface truly implementation independent, it seems
like we should define something like:

	if (need_resched()) {
		struct mmu_gather_state state;
		tlb_mmu_gather_save_state(*tlbp, &state);
		tlb_finish_mmu(*tlbp, tlb_start, start);
		...
		*tlbp = tlb_mmu_gather_restore_state(&state);
	}

Is this overkill?

Should we use the patch given above for 2.6.0 & replace it with an implementation 
independent interface for 2.6.1?



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


