Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUJ1QCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUJ1QCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUJ1P7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:59:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63483 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261750AbUJ1Pxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:53:32 -0400
Date: Thu, 28 Oct 2004 21:23:59 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028155359.GB11182@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041028113208.GA11182@in.ibm.com> <20041028113744.GA82042@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028113744.GA82042@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Please see my comments inline below.

Thanks
Prasanna

On Thu, Oct 28, 2004 at 01:37:44PM +0200, Andi Kleen wrote:
> 
> Like I still would like to have the page fault notifier
> completely moved out of the fast path into no_context 
> (that i386 has it there is also wrong). Adding kprobe_runn 
> doesn't make a difference.

    The kprobes fault handler is called if an exception is 
generated for any instruction within the fault-handler or when 
Kprobes single-steps the probed instruction.
AFAIK kprobes does not handle page faults in the above case and just returns
immediately resuming the normal execution. 

> 
> And the jprobe_return_end change is wrong, my suggestion
> was to move it into the inline assembler statement. Adding asmlinkage 
> doesn't help at all 
> (I think i386 gets this wrong too) 
> 

In the below code, I moved jprobe_return_end to inline assembler statement.

void jprobe_return(void)
{
        preempt_enable_no_resched();
        asm volatile ("       xchg   %%rbx,%%rsp     \n"
                      "       int3                      \n"
                      "       .globl jprobe_return_end  \n"
                      "       jprobe_return_end:        \n"
                      "       nop                       \n"::"b"
                      (jprobe_saved_rsp):"memory");
}

> -Andi

-- 

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
