Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTEIEMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 00:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTEIEMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 00:12:43 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:40522 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262288AbTEIEMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 00:12:41 -0400
Message-ID: <3EBB4B60.4080905@wanadoo.fr>
Date: Fri, 09 May 2003 06:32:00 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
References: <20030509004200.A22795@mrt-lx16.iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paubert wrote:
> [CC'ed to x86_64 and ia64 maintainers because they might have the 
> same issues. For existing x86_64 processors, s/0xffbf/0xffff/ in 
> arch/x86-64/ia32/{fpu32,ptrace32}.c might be sufficient]
> 
> With SSE2, mxcsr bit 6 is defined as controlling whether
> denormals should be treated as zeroes or not. Setting it
> no more causes an exception, but with the current code it 
> would be cleared at every signal return which is a bit harsh.
> 
> The following patch fixes this (2.5, but easily ported to 2.4).
> 
> ===== arch/i386/kernel/i387.c 1.16 vs edited =====
> --- 1.16/arch/i386/kernel/i387.c	Wed Apr  9 05:45:37 2003
> +++ edited/arch/i386/kernel/i387.c	Thu May  8 23:30:23 2003
> @@ -25,6 +25,12 @@
>  #define HAVE_HWFP 1
>  #endif
>  
> +/* mxcsr bits 31-16 must be zero for security reasons,
> + * bit 6 depends on cpu features.
> + */
> +#define MXCSR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf)
> +
> +

I don't think daz bit depend on sse2, it's a separate features

>  /*
>   * The _current_ task is using the FPU for the first time
>   * so initialize it and set the mxcsr to its default
> @@ -208,7 +214,7 @@
>  void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
>  {
>  	if ( cpu_has_xmm ) {
> -		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
> +		tsk->thread.i387.fxsave.mxcsr = (mxcsr & MXCSR_MASK);


intel and x64 doc advocate to use

mxcsr &= tsk->thread.i387.fxsave.mxscr_mask
	? 0xffbf : tsk->thread.i387.fxsave.mxscr_mask;
tsk->thread.i387.fxsave.mxscr =  mxcsr;

with mxscr_mask the 16 upper bits of field currently named
mxscr in fxsave area. This bits was zeroed by previous processor
so this must be backward compatible.


Intel P4 Vol 1 11.6.6 "Guidelines for writing to MXSCR register"
AMD x64 Vol 2 11.4.4 "Saving and restoring Media and x87 processor"


regards,
Philippe Elie


