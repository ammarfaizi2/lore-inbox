Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVLSAv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVLSAv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVLSAv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:51:28 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23948 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030199AbVLSAv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:51:27 -0500
Subject: Re: 2.6.15-rc5-rt2 won't boot on dual 933
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43A5DAE4.8090908@cybsft.com>
References: <43A5DAE4.8090908@cybsft.com>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 19:51:13 -0500
Message-Id: <1134953473.13138.217.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 15:55 -0600, K.R. Foley wrote:
> dump_stack+0x1e/0x20 (20)
>  [<c011c9df>] preempt_enable_no_resched+0x5f/0x70 (20)
>  [<c0100ff2>] cpu_idle+0xb2/0x100 (40)
>  [<c0111446>] start_secondary+0x296/0x340<6> 

Ingo,

What's the reason for this printing out in cpu_idle?

#ifdef CONFIG_DEBUG_PREEMPT
void notrace preempt_enable_no_resched(void)
{
	static int once = 1;

	barrier();
	dec_preempt_count();

	if (once && !preempt_count()) {
		once = 0;
		printk(KERN_ERR "BUG: %s:%d task might have lost a preemption check!
\n",
			current->comm, current->pid);
		dump_stack();
	}
}

EXPORT_SYMBOL(preempt_enable_no_resched);
#endif

I can understand the above when using preempt_enable_no_resched, when
you know that you still have preemption on, but sometimes (as in
cpu_idle) it is used just before calling schedule.  So this check is
pretty much meaningless.

---

KR, 

Does your kernel boot without CONFIG_DEBUG_PREEMPT?

-- Steve


