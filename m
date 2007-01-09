Return-Path: <linux-kernel-owner+w=401wt.eu-S932287AbXAIRdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbXAIRdu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXAIRdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:33:50 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:48449 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932287AbXAIRdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:33:49 -0500
Date: Tue, 9 Jan 2007 12:33:48 -0500
To: takada <takada@mbf.nifty.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: fix typo in geode_configre()@cyrix.c
Message-ID: <20070109173348.GF17269@csclub.uwaterloo.ca>
References: <20070109.184156.260789378.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109.184156.260789378.takada@mbf.nifty.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 06:41:56PM +0900, takada wrote:
> In kernel 2.6, write back wrong register when configure Geode processor.
> Instead of storing to CCR4, it stores to CCR3.
> 
> --- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09 16:45:21.000000000 +0900
> +++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 17:10:13.000000000 +0900
> @@ -173,7 +173,7 @@ static void __cpuinit geode_configure(vo
>  	ccr4 = getCx86(CX86_CCR4);
>  	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
>  	
> -	setCx86(CX86_CCR3, ccr3);
> +	setCx86(CX86_CCR4, ccr4);
>  	
>  	set_cx86_memwb();
>  	set_cx86_reorder();	
> -

One more comment on this:

Why is this function using 3 different styles to do the same thing to 3
different registers?

First it does CCR2 by doing:
setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);

Nice, no temp values, and it is obvious this is a permanent change.

Then for the next one it does:
ccr3 = GetCx86(CX86_CCR3);
setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);

Couldn't that have been:
setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);

No temp variable, and again it clearly does not intend to restore the
value again later (even though the bug actually did cause the value to
be restored by accident).

Then the last case does:
ccr4 = GetCx86(CX86_CCR4);
ccr4 |= 0x38;
setCx86(CX86_CCR4, ccr4); (after fixing the typo you found of course).

Why did this one have to modify the variable first before using it?
Maybe the ccr3 and ccr4 cases would have made the line too long and
needed wrapping, but at least those two cases should be done the same
way.  It makes it look like it was written by 3 different people who
didn't look at the lines around the changes they were making.

--
Len Sorensen
