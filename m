Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVCPRsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVCPRsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVCPRsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:48:00 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54995 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262709AbVCPRrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:47:55 -0500
Date: Wed, 16 Mar 2005 12:47:48 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu>
 <20050316024022.6d5c4706.akpm@osdl.org> <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org> <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Mar 2005, Steven Rostedt wrote:

>
> Hi Ingo,
>
> I just ran this with PREEMPT_RT and it works fine.

Not quite, and I will assume that some of the other patches I sent have
this same problem.  The jbd_trylock_bh_state really scares me. It seems
that in fs/jbd/commit.c in journal_commit_transaction we have the
following code:


write_out_data:
	cond_resched();
	spin_lock(&journal->j_list_lock);

	while (commit_transaction->t_sync_datalist) {
		struct buffer_head *bh;

		jh = commit_transaction->t_sync_datalist;
		commit_transaction->t_sync_datalist = jh->b_tnext;
		bh = jh2bh(jh);
		if (buffer_locked(bh)) {
			BUFFER_TRACE(bh, "locked");
			if (!inverted_lock(journal, bh))
				goto write_out_data;


where invert_data simply is:


/*
 * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock
is
 * held.  For ranking reasons we must trylock.  If we lose, schedule away
and
 * return 0.  j_list_lock is dropped in this case.
 */
static int inverted_lock(journal_t *journal, struct buffer_head *bh)
{
	if (!jbd_trylock_bh_state(bh)) {
		spin_unlock(&journal->j_list_lock);
		schedule();
		return 0;
	}
	return 1;
}


So, with kjournal running as a FIFO, it may hit this (as it did with my
last test) and not get the lock. All it does is release another lock
(ranking reasons) and calls schedule and tries again.  With kjournal the
highest running process on the system (UP) it deadlocks since whoever has
the lock will never get a chance to run.  There's a couple of places that
jbd_trylock_bh_state is used in checkpoint.c, but this is the one place
that it definitely deadlocks the system.  I believe that the
code in checkpoint.c also has this problem.

I guess one way to solve this is to add a wait queue here (before
schedule()), and have the one holding the lock to wake up all on the
waitqueue when they release it.

-- Steve

