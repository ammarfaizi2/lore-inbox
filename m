Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbSJARuy>; Tue, 1 Oct 2002 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJARuy>; Tue, 1 Oct 2002 13:50:54 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:3712 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262195AbSJARuu>;
	Tue, 1 Oct 2002 13:50:50 -0400
Date: Tue, 1 Oct 2002 19:56:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in
Message-ID: <20021001175607.GA1964@vana.vc.cvut.cz>
References: <35FD2132190@vcnet.vc.cvut.cz> <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:14:04PM +0100, Hugh Dickins wrote:
> On Tue, 1 Oct 2002, Petr Vandrovec wrote:
> > 
> > You are my hero!
> 
> Aww, shucks!  I guess I'd better have a go at your next problem...
> 
> Looks to me like flush_tlb_mm is faulting on the vma->vm_mm given it.
> And looks to me like mprotect_fixup, in the merge case, may be passing
> an already freed vma to change_protection.  I'm not as confident about
> this patch as the earlier one, but I believe it's correct: please
> give it a try, and maybe Christoph will confirm or deny it.

Thanks. It fixed my problem (again ;-) ). Maybe I should already asked
yesterday instead of starring at mprotect code.
					Many thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
> Hugh
> 
> --- 2.5.40/mm/mprotect.c	Fri Sep 27 23:56:45 2002
> +++ linux/mm/mprotect.c	Tue Oct  1 18:00:31 2002
> @@ -186,8 +186,10 @@
>  		/*
>  		 * Try to merge with the previous vma.
>  		 */
> -		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
> +		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
> +			vma = *pprev;
>  			goto success;
> +		}
>  	} else {
>  		error = split_vma(mm, vma, start, 1);
>  		if (error)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
