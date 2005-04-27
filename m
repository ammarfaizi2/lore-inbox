Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVD0OwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVD0OwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVD0OwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:52:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19392 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261662AbVD0Ov5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:51:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Date: Wed, 27 Apr 2005 16:51:58 +0200
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200504271152.15423.rjw@sisk.pl> <20050427135451.GM13305@wotan.suse.de>
In-Reply-To: <20050427135451.GM13305@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271651.58542.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 27 of April 2005 15:54, Andi Kleen wrote:
> 
> Does this patch fix the problem?

Yes, it does, apparently (ie I'm unable to reproduce it). :-)

> Initialize workmask correct on interrupt signal handling
> 
> Readd missing clis in the interrupt return path.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> 
> 
> diff -u linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o linux-2.6.12rc3/arch/x86_64/kernel/entry.S
> --- linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o	2005-04-22 12:48:11.000000000 +0200
> +++ linux-2.6.12rc3/arch/x86_64/kernel/entry.S	2005-04-27 15:52:49.305183345 +0200
> @@ -296,6 +296,7 @@
>  	call syscall_trace_leave
>  	popq %rdi
>  	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
> +	cli	
>  	jmp int_restore_rest
>  	
>  int_signal:
> @@ -307,6 +308,7 @@
>  1:	movl $_TIF_NEED_RESCHED,%edi	
>  int_restore_rest:
>  	RESTORE_REST
> +	cli	
>  	jmp int_with_check
>  	CFI_ENDPROC
>  		
> @@ -490,7 +492,8 @@
>  	call do_notify_resume
>  	RESTORE_REST
>  	cli
> -	GET_THREAD_INFO(%rcx)	
> +	GET_THREAD_INFO(%rcx)
> +	movl $_TIF_WORK_MASK,%edi	
>  	jmp retint_check
>  
>  #ifdef CONFIG_PREEMPT

I assume that the Alexander's patch is not needed with this one?

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
