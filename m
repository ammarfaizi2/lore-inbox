Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVI3RSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVI3RSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVI3RSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:18:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbVI3RSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:18:22 -0400
Date: Fri, 30 Sep 2005 10:18:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
In-Reply-To: <433D6CFB.C1BA3F1F@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0509301006580.3378@g5.osdl.org>
References: <20050929215442.74EE0180E20@magilla.sf.frob.com>
 <433D6CFB.C1BA3F1F@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Oleg Nesterov wrote:
>
> Roland, could you please explain this code in wait_task_stopped()
> 
> 	if (!exit_code || p->state > TASK_STOPPED)
> 		goto bail_ref;

Regardless of any other explanations, it turns out that "p->state" can be 
something like "TASK_RUNNING | TASK_NONINTERACTIVE", and then this would 
trigger totally incorrectly.

> It looks like "WSTOPPED | WNOWAIT is illegal for TASK_TRACED child"
> to me. Is this correct? I think no.

No, I think it's correct. If you have a traced child, you can't just wait 
for it. You need to use ptrace to release it first.

> Actually, I don't understand why we are checking p->state at all, we
> already dropped tasklist_lock, the state can change at any monent.

If it's TASK_TRACED, and it's our child, then it shouldn't be changing. 

Besides, even if it does, we had a perfectly fine race, and we'll have 
been woken up again and we'll just go through the do_wait() loop once 
more.

So I think the code is mostly correct. But that ">" is definitely 
incorrect.

Maybe it should just be

	if (!exit_code || (p->state & TASK_TRACED))

instead?

Roland?

		Linus
