Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJWITN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJWITN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUJWITN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:19:13 -0400
Received: from ozlabs.org ([203.10.76.45]:58820 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266703AbUJWITG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:19:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16762.5108.282382.603502@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 18:19:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: ananth@in.ibm.com
Cc: linuxppc64-dev@ozlabs.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kprobes for ppc64
In-Reply-To: <20041018095229.GA7394@in.ibm.com>
References: <20041018095229.GA7394@in.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananth N Mavinakayanahalli writes:

> Here is kprobes for ppc64. The patch applies on 2.6.9-rc4/2.6.9-final
> and provides the kprobes + jprobes functionality.

> 1. The current implementation uses xmon's emulate_step() and hence 
>    requires xmon to be compiled in. 

We can move emulate_step out to arch/ppc64/lib/step.c (and take out
the printfs).

> 2. arch_prepare_kprobe() now returns an int. I have made the necessary
>    changes to i386 and sparc64 kprobes files, but is untested.

Are you going to send this upstream?

> + * Interrupts are disabled on entry as trap3 is an interrupt gate and they
> + * remain disabled thorough out this function.
> + */
> +static inline int kprobe_handler(struct pt_regs *regs)

Comments about "trap3" and "interrupt gate" don't help me understand
this function on ppc64. :)  At present interrupts are enabled in a
program check exception handler but disabled in a single-step handler.
When does this function get called?

> @@ -96,6 +97,9 @@ int do_page_fault(struct pt_regs *regs, 
>  	BUG_ON((trap == 0x380) || (trap == 0x480));
>  
>  	if (trap == 0x300) {
> +		if (notify_die(DIE_PAGE_FAULT, "page_fault", regs, error_code,
> +					11, SIGSEGV) == NOTIFY_STOP)
> +			return 0;

Hmmm, this seems a bit heavyweight for adding to the page fault path.
Have you done any benchmarks with vs. without kprobes?

On the whole the patch looks OK.  I haven't checked the kprobe_handler
code to see if I think it's all SMP- and preempt-safe, but I assume
you have done it similarly on x86 and checked it there.

Paul.

