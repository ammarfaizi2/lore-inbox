Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVCaLDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVCaLDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVCaLDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:03:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17071 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261302AbVCaLDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:03:48 -0500
Date: Thu, 31 Mar 2005 13:03:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050331110330.GA24842@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk> <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112218750.3691.165.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Well, here it finally is. There's still things I don't like about it. 
> But it seems to work, and that's the important part.
> 
> I had to reluctantly add two items to the task_struct.  I was hoping 
> to avoid that. But because of race conditions it seemed to be the only 
> way.

well it's not a big problem, and we avoided having to add flags to the 
rt_lock structure, which is the important issue.

your patch looks good, i've added it to my tree and have uploaded the 
-26-00 patch. It boots fine on my testbox, except for some new messages:

 knodemgrd_0/902: BUG in __down_complete at kernel/rt.c:1568
  [<c0103956>] dump_stack+0x23/0x25 (20)
  [<c0130dcd>] down_trylock+0x1fb/0x200 (48)
  [<c0364ee2>] nodemgr_host_thread+0xd0/0x17b (48)
  [<c0100d4d>] kernel_thread_helper+0x5/0xb (136249364)
 ---------------------------
 | preempt count: 00000001 ]
 | 1-level deep critical section nesting:
 ----------------------------------------
 .. [<c0133a75>] .... print_traces+0x1b/0x52
 .....[<c0103956>] ..   ( <= dump_stack+0x23/0x25)

this goes away if i revert your patch. It seems the reason is that 
trylock hasnt been updated to use the pending-owner logic?

	Ingo
