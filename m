Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbULFWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbULFWBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbULFWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:01:04 -0500
Received: from mail.dif.dk ([193.138.115.101]:5832 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261669AbULFWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:00:56 -0500
Date: Mon, 6 Dec 2004 23:11:02 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Riina Kikas <riinak@ut.ee>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed and
 unsigned"
In-Reply-To: <Pine.SOC.4.61.0412062255170.21075@math.ut.ee>
Message-ID: <Pine.LNX.4.61.0412062302410.3378@dragon.hygekrogen.localhost>
References: <Pine.SOC.4.61.0412062255170.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Riina Kikas wrote:

> This patch fixes warning "comparison between signed and unsigned"
> occuring on line 308
> 
> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> 
> --- a/arch/i386/mm/fault.c	2004-12-02 21:30:30.000000000 +0000
> +++ b/arch/i386/mm/fault.c	2004-12-02 21:30:59.000000000 +0000
> @@ -302,7 +302,13 @@
>  		 * pusha) doing post-decrement on the stack and that
>  		 * doesn't show up until later..
>  		 */
> -		if (address + 32 < regs->esp)
> +		unsigned long regs_esp;
> +		if (regs->esp < 0) {
> +			regs_esp = 0;
> +		} else {
> +			regs_esp = regs->esp;
> +		}
> +		if (address + 32 < regs_esp)
>  			goto bad_area;
>  	}
>  	if (expand_stack(vma, address))

This seems a bit silly. If the stack pointer (esp) is ever negative that's 
clearly a bug somewhere. So instead of testing it for <0 and then setting 
your regs_esp variable to 0 it would make more sense to me to just 
BUG_ON(regs->esp < 0) or something, if you want to do anything at all. And 
if you want to silence the warning a exlicit cast to unsigned long should 
do I'd say, but I have a feeling the best thing is to just leave that 
warning alone, the code seems to be fine.

Also, your declaration of regs_esp interspaced with code (which is allowed 
by C99 but not C89) will break on C89 compilers, some of which are still 
supported - such as gcc 2.95.3 for instance.


-- 
Jesper Juhl


