Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUHSAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUHSAQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUHSAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:16:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48604 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267660AbUHSAQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:16:38 -0400
Date: Wed, 18 Aug 2004 17:36:27 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6 PPC64 Re: rtas_call uses kmalloc before the memory subsystem is up
Message-ID: <20040818223627.GI14002@austin.ibm.com>
References: <20040815221951.GK5637@krispykreme> <16672.17307.578763.854775@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16672.17307.578763.854775@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Can you approve & forward one of the two the patches to AKPM for inclusion
in the next kernel as soon as possible?   This is now the fifth or sixth
report of someone getting bitten by this, and this *really* should be in
the mainline tree.  (We really need a way of expediting patches when 
they're critical & everyone hits them.)

On Mon, Aug 16, 2004 at 03:18:19PM +1000, Paul Mackerras was heard to remark:
> Anton Blanchard writes:
> 
> > rtas_call is doing a kmalloc before the memory subsystem is up, but only
> > when we hit an error.
> 
> This is a quick-n-dirty hack to fix the problem.  It's not completely
> obvious what the proper solution looks like, unfortunately.

Actually, I think the patch below *is* the proper solution.  Its nearly
identical to the old patches, with one important improvement: it also
works when mem subsytem is not yet up.  Here's why:  

-- the kmalloc is needed in the full multi-tasking environment, because 
   the rtas code can be triggered at any time (on any cpu).
-- if mem subsystem is not yet up (no kmalloc yet) then the kernel won't
   be running multi-tasked yet, anyway, so races that clobber the buffer
   won't occur.

So I think we're free & clear here; this is not only a solution, its 
the best solution.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

> diff -urN linux-2.5/arch/ppc64/kernel/rtas.c test25/arch/ppc64/kernel/rtas.c
> --- linux-2.5/arch/ppc64/kernel/rtas.c	2004-08-03 08:07:43.000000000 +1000
> +++ test25/arch/ppc64/kernel/rtas.c	2004-08-16 14:47:22.147162600 +1000
> @@ -165,9 +165,12 @@
>  
>  	/* Log the error in the unlikely case that there was one. */
>  	if (unlikely(logit)) {
> -		buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
> -		if (buff_copy) {
> -			memcpy(buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
> +		buff_copy = rtas_err_buf;
> +		if (mem_init_done) {
> +			buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
> +			if (buff_copy)
> +				memcpy(buff_copy, rtas_err_buf,
> +				       RTAS_ERROR_LOG_MAX);
>  		}
>  	}
>  
> @@ -176,7 +179,8 @@
>  
>  	if (buff_copy) {
>  		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
> -		kfree(buff_copy);
> +		if (mem_init_done)
> +			kfree(buff_copy);
>  	}
>  	return ret;
>  }
> 
