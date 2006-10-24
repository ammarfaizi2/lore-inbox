Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWJXCYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWJXCYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWJXCYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:24:55 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40622 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965042AbWJXCYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:24:54 -0400
Subject: oprofile can cause an NMI to schedule (was: [RT] scheduling and
	oprofile)
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061023212307.GA21498@monkey.beaverton.ibm.com>
References: <20061023212307.GA21498@monkey.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 22:24:34 -0400
Message-Id: <1161656674.13276.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 14:23 -0700, Mike Kravetz wrote:
> I've been trying to use oprofile on an RT kernel to look at some
> performance issues.  While running I notice the following sent to
> the console:
> 
> BUG: scheduling with irqs disabled: java/0x00000000/4521
> caller is rt_mutex_slowlock+0x156/0x1dd
>  [<c032051a>] schedule+0x65/0xd2 (8)
>  [<c0321338>] rt_mutex_slowlock+0x156/0x1dd (12)
>  [<c032142a>] rt_mutex_lock+0x24/0x28 (72)
>  [<c0134904>] rt_down_read+0x38/0x3b (20)
>  [<c0322a89>] do_page_fault+0xe3/0x52d (12)
>  [<c03229a6>] do_page_fault+0x0/0x52d (76)
>  [<c01033bb>] error_code+0x4f/0x54 (8)
>  [<c01ce6d0>] __copy_from_user_ll+0x55/0x7c (44)
>  [<f89be7ef>] dump_user_backtrace+0x2e/0x56 [oprofile] (24)
>  [<c0134869>] rt_up_read+0x3e/0x41 (20)
>  [<f89be864>] x86_backtrace+0x4a/0x5a [oprofile] (20)
>  [<f89bd53a>] oprofile_add_sample+0x73/0x89 [oprofile] (20)
>  [<f89beea3>] athlon_check_ctrs+0x22/0x4a [oprofile] (32)
>  [<f89be8c5>] nmi_callback+0x18/0x1b [oprofile] (28)
>  [<c01041ff>] do_nmi+0x24/0x33 (12)
>  [<c0103462>] nmi_stack_correct+0x1d/0x22 (16)
> 
> It seems strange to me that oprofile would be calling
> '__copy_from_user_ll' in this context.  I can see why the
> changes made for RT locking expose this.  But, doesn't this
> issue also exist on non-RT (default) kernels?  What happens
> when we generate a page fault in this context on non-RT kernels?
> 

As Mike has pointed out here, oprofile _can_ cause the nmi to schedule.
Here's the path: (looking at vanilla 2.6.18).

arch/i386/oprofile/nmi_int.c: nmi_callback

	return model->check_ctrs(regs, &cpu_msrs[cpu]);

if model == &op_athlon_spec
 (could be a problem with others, but I'm only looking here).
   
op_athlon_spec.check_ctrs =  &athlon_check_ctrs


Here's the calling path:

  athlon_check_ctrs

   ==> oprofile_add_sample

   ==> oprofile_add_ext_sample

   ==> oprofile_ops.backtrace
           == x86_backtrace

   ==> dump_user_backtrace

   ==> __copy_from_user_inatomic

   Don't let the name fool you, this _can_ schedule! (and says so in the
comments above it).

Now perhaps on a vanilla kernel opfile_add_ext_sample is not likely to
have log_sample fail. I don't know, but this path exits, so we can
indeed schedule in a NMI interrupt.

Mike, thanks for pointing this out.

-- Steve



