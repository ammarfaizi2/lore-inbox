Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVCaMhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVCaMhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVCaMhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:37:55 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:33186 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261399AbVCaMhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:37:02 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331110330.GA24842@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 07:36:46 -0500
Message-Id: <1112272607.3691.225.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 13:03 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> your patch looks good, i've added it to my tree and have uploaded the 
> -26-00 patch. It boots fine on my testbox, except for some new messages:
> 
>  knodemgrd_0/902: BUG in __down_complete at kernel/rt.c:1568
>   [<c0103956>] dump_stack+0x23/0x25 (20)
>   [<c0130dcd>] down_trylock+0x1fb/0x200 (48)
>   [<c0364ee2>] nodemgr_host_thread+0xd0/0x17b (48)
>   [<c0100d4d>] kernel_thread_helper+0x5/0xb (136249364)
>  ---------------------------
>  | preempt count: 00000001 ]
>  | 1-level deep critical section nesting:
>  ----------------------------------------
>  .. [<c0133a75>] .... print_traces+0x1b/0x52
>  .....[<c0103956>] ..   ( <= dump_stack+0x23/0x25)
> 
> this goes away if i revert your patch. It seems the reason is that 
> trylock hasnt been updated to use the pending-owner logic?

Damn, now that I have a comparable kernel to look at, I see where that
1568 is. I did see these, but they went away when I changed the logic to
handle the BKL, and I thought it was related. 

Since this happened with the trylock, do you see anyway that a pending
owner can cause problems?  Maybe this has to do with is_locked. Now a
pending owner makes this ambiguous. Since the lock has a owner, and a
task can't get it if it is of lower priority than the pending owner, but
it can get it if it is higher. Now is it locked?  My implementation was
to be safe and say that it is locked.

I'll play around some more with this.

-- Steve


