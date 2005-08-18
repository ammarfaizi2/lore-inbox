Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVHRLhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVHRLhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHRLhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:37:15 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:7041 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932201AbVHRLhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:37:14 -0400
Message-ID: <43047570.4089FCF1@tv-sign.ru>
Date: Thu, 18 Aug 2005 15:48:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru> <20050817211957.GN1300@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> On Wed, Aug 17, 2005 at 06:35:03PM +0400, Oleg Nesterov wrote:
> >
> > Sorry, I don't understand you. CLONE_THREAD implies CLONE_SIGHAND,
> > so we always need to lock one ->sighand. Could you please clarify?
>
> On the #3 and #4 code paths, the code assumes that the task-list lock
> is held.  So I was thinking of something (very roughly) as follows:
>
> #define SIGLOCK_HOLD_RCU      (1 << 0)
> #define SIGLOCK_HOLD_TASKLIST (1 << 1)
> #define SIGLOCK_HOLD_SIGLOCK  (1 << 2)

Oh, no, sorry for confusion.

I meant this function should only lock ->sighand, nothing more, something
like this:

// must be called with preemtion disabled !!!
struct sighand_struct *lock_task_sighand(struct task_struct *tsk, unsigned long *flags)
{
	struct sighand_struct *sighand;

//	sighand = NULL;
//	if (!get_task_struct_rcu(tsk))
//		goto out;

	for (;;) {
		sighand = tsk->sighand;
		if (unlikely(sighand == NULL))
			break;

		spin_lock_irqsave(sighand->siglock, *flags);

		if (likely(sighand == tsk->sighand)
			goto out;

		spin_unlock_irqrestore(sighand->siglock, *flags);
	}

//	put_task_struct(tsk);
out:
	return sighand;
}

static inline void unlock_task_sighand(struct task_struct *tsk, unsigned long *flags)
{
	spin_unlock_irqrestore(tsk->sighand->siglock, flags);
//	put_task_struct(tsk);
}

int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
{
	unsigned long flags;
	int ret;

	ret = check_kill_permission(sig, info, p);
	if (!ret && sig) {
		ret = -ESRCH;
		if (lock_task_sighand(p, &flags)) {
			ret = __group_send_sig_info(sig, info, p);
			unlock_task_sighand(p, &flags);
		}
	}

	return ret;
}

Currently the only user of it will be group_send_sig_info(), but I hope
you have devil plans to kill the "tasklist_lock guards the very rare
->sighand change" finally :)

Oleg.
