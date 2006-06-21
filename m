Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWFUSzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWFUSzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFUSzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:55:13 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:46001 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932345AbWFUSzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:55:11 -0400
Date: Wed, 21 Jun 2006 14:55:08 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, anton@samba.org
Subject: Re: Possible bug in do_execve()
Message-ID: <20060621185508.GA9234@kevlar.burdell.org>
References: <20060620022506.GA3673@kevlar.burdell.org> <20060621184129.GB16576@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621184129.GB16576@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:41:29PM -0500, Serge E. Hallyn wrote:
<snip>
> > Is the behavior in do_execve() correct?
> 
> Well, I assume the intent is for out_mm: to clean up from mm_alloc(),
> not from 'init_new_context'.  So I think that code is correct.
> This bug appears to be powerpc-specific, so would the following patch
> be reasonable?
> 
> Note it is entirely untested, just to show where i think this should
> be solved.  But I could try compile+boot test tonight.
> 
> thanks,
> -serge
> 
> From: Serge E. Hallyn <hallyn@sergelap.(none)>
> Date: Wed, 21 Jun 2006 13:37:27 -0500
> Subject: [PATCH] powerpc: check for proper mm->context before destroying
> 
> arch/powerpc/mm/mmu_context_64.c:destroy_context() can be called
> from __mmput() in do_execve() if init_new_context() failed.  This
> can result in idr_remove() being called for an invalid context.
> 
> So, don't call idr_remove if there is no context.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> ---
> 
>  arch/powerpc/mm/mmu_context_64.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> ee74da9d3c122b92541dd6b7670731bd4a033f04
> diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
> index 714a84d..552d590 100644
> --- a/arch/powerpc/mm/mmu_context_64.c
> +++ b/arch/powerpc/mm/mmu_context_64.c
> @@ -55,6 +55,9 @@ again:
>  
>  void destroy_context(struct mm_struct *mm)
>  {
> +	if (mm->context.id == NO_CONTEXT)
> +		return;
> +
>  	spin_lock(&mmu_context_lock);
>  	idr_remove(&mmu_context_idr, mm->context.id);
>  	spin_unlock(&mmu_context_lock);

Yeah, I proposed a similar patch to Anton, and it would quiet the
warning on powerpc, but that's not the point.  It happens that powerpc
doesn't use 0 as a context id, but that may not be true on another
architecture.  That's really what I'm concerned about.
