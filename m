Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVJALTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVJALTq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVJALTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:19:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:57529 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750796AbVJALTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:19:45 -0400
Message-ID: <433E73BB.96D6DDC1@tv-sign.ru>
Date: Sat, 01 Oct 2005 15:32:11 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
References: <20050929215442.74EE0180E20@magilla.sf.frob.com>
	 <433D6CFB.C1BA3F1F@tv-sign.ru> <Pine.LNX.4.64.0509301006580.3378@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> On Fri, 30 Sep 2005, Oleg Nesterov wrote:
> >
> > Roland, could you please explain this code in wait_task_stopped()
> >
> >    if (!exit_code || p->state > TASK_STOPPED)
> >            goto bail_ref;
>
> Regardless of any other explanations, it turns out that "p->state" can be
> something like "TASK_RUNNING | TASK_NONINTERACTIVE", and then this would
> trigger totally incorrectly.
>
> > It looks like "WSTOPPED | WNOWAIT is illegal for TASK_TRACED child"
> > to me. Is this correct? I think no.
>
> No, I think it's correct. If you have a traced child, you can't just wait
> for it. You need to use ptrace to release it first.

But it is ok to do do_wait(WSTOPPED /* without WNOWAIT */) for TASK_TRACED
child. wait_task_stopped() does not actually wait, it just eats ->exit_code.

> > Actually, I don't understand why we are checking p->state at all, we
> > already dropped tasklist_lock, the state can change at any monent.
>
> If it's TASK_TRACED, and it's our child, then it shouldn't be changing.

It can be child of other thread in our thread group (do_wait() iterates
over all threads ->children lists) and that thread can do PTRACE_DETACH.
But this does not matter.

> Besides, even if it does, we had a perfectly fine race, and we'll have
> been woken up again and we'll just go through the do_wait() loop once
> more.

Yes,

> So I think the code is mostly correct. But that ">" is definitely
> incorrect.
>
> Maybe it should just be
>
>         if (!exit_code || (p->state & TASK_TRACED))
>
> instead?

I still think that checking p->state here just pointless and confusing.
The task was TASK_STOPPED or TASK_TRACED on entering, we have WNOWAIT
flag, we should just call wait_noreap_copyout(). And 'p' can change it's
->state just after the check.

And I think that wait_task_stopped() should get ->exit_code and ->si_code
atomically under tasklist_lock, p->ptrace can be changed after we dropped
that lock.

Btw,
do_wait():
	case TASK_STOPPED:
		if (!(options & WUNTRACED) && !my_ptrace_child(p))
			continue;

Looks like it should be '||' here?

Oleg.
