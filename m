Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVG2HYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVG2HYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVG2HYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:24:53 -0400
Received: from fmr22.intel.com ([143.183.121.14]:1176 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262362AbVG2HYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:24:52 -0400
Message-Id: <200507290722.j6T7Mig07477@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Keith Owens" <kaos@ocs.com.au>, <David.Mosberger@acm.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function
Date: Fri, 29 Jul 2005 00:22:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUC+R3gYlvfTtNRByanjtDGKz6eQAAJerA
In-Reply-To: <20050729070447.GA3032@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, July 29, 2005 12:05 AM
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -2869,7 +2869,14 @@ go_idle:
>  	 * its thread_info, its kernel stack and mm:
>  	 */
>  	prefetch(next->thread_info);
> -	prefetch(kernel_stack(next));
> +	/*
> +	 * Prefetch (at least) a cacheline below the current
> +	 * kernel stack (in expectation of any new task touching
> +	 * the stack at least minimally), and a cacheline above
> +	 * the stack:
> +	 */
> +	prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
> +		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);
>  	prefetch(next->mm);


Doctor, it still hurts :-(

On ia64, we have two kernel stacks, one for outgoing task, and one for
incoming task.  for outgoing task, we haven't called switch_to() yet.
So the switch stack structure for 'current' will be allocated immediately
below current 'sp' pointer. For the incoming task, it was fully ctx'ed out
previously, so switch stack structure is immediate above kernel_stack(next).
It Would be beneficial to prefetch both stacks.

