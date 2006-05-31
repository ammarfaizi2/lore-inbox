Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWEaBUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEaBUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWEaBUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:20:48 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61876 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751237AbWEaBUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:20:47 -0400
Subject: Re: How to send a break? - dump from frozen 64bit linux
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Janos Haar <djani22@netcenter.hu>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, nathans@sgi.com,
       linux-xfs@oss.sgi.com
In-Reply-To: <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
	 <20060527234350.GA13881@voodoo.jdc.home>
	 <004501c68225$00add170$1800a8c0@dcccs>
	 <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
	 <01d801c6827c$fba04ca0$1800a8c0@dcccs>
	 <01a801c683d2$e7a79c10$1800a8c0@dcccs>
	 <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 30 May 2006 21:20:31 -0400
Message-Id: <1149038431.21827.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added all those listed in the MAINTAINERS file for XFS.

On Tue, 2006-05-30 at 15:03 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 30 May 2006 12:22:01 +0200, Janos Haar said:
> 
> > http://download.netcenter.hu/bughunt/20060530/dump.txt  (The frozen system,
> > 540KB)
> 
> > Can somebody tell me, whats wrong?
> 
> kblockd/1     D ffff81011f641778     0    25     19            26    24 (L-TLB)
> ffff81011f641778 0000000000000000 0000000000000009 ffff81011f735358 
>        ffff81011f735140 ffff81011fc79100 000014a00f9a0ef2 00000000000410dd 
>        0000000102866d40 ffff810003900280 
> Call Trace: <ffffffff8026d72a>{xfs_qm_shake+135} <ffffffff804e6046>{__mutex_lock_slowpath+424}
>        <ffffffff804e62e4>{mutex_lock+41} <ffffffff8026d72a>{xfs_qm_shake+135}
>        <ffffffff80157cfd>{shrink_slab+100} <ffffffff801584d9>{try_to_free_pages+372}
>        <ffffffff80153c3f>{__alloc_pages+432} <ffffffff8046aef3>{tcp_sendmsg+1373}
>        <ffffffff804848ad>{inet_sendmsg+70} <ffffffff8043f619>{sock_sendmsg+270}
>        <ffffffff8013d3e0>{autoremove_wake_function+0} <ffffffff80440db3>{kernel_sendmsg+61}
>        <ffffffff8802c111>{:nbd:sock_xmit+273} <ffffffff8015195d>{mempool_alloc_slab+17}
>        <ffffffff80169b1b>{poison_obj+39} <ffffffff8015195d>{mempool_alloc_slab+17}
>        <ffffffff80169c11>{cache_alloc_debugcheck_after+235}
>        <ffffffff8015195d>{mempool_alloc_slab+17} <ffffffff802da471>{as_remove_queued_request+267}
>        <ffffffff8802c472>{:nbd:nbd_send_req+517} <ffffffff8802c712>{:nbd:do_nbd_request+329}
>        <ffffffff802d9b45>{as_work_handler+46} <ffffffff80139d30>{run_workqueue+168}
>        <ffffffff802d9b17>{as_work_handler+0} <ffffffff8013a27f>{worker_thread+0}
>        <ffffffff8013a383>{worker_thread+260} <ffffffff80123fa4>{default_wake_function+0}
>        <ffffffff8013a27f>{worker_thread+0} <ffffffff8013d29f>{kthread+219}
>        <ffffffff8012590d>{schedule_tail+70} <ffffffff8010bba6>{child_rip+8}
>        <ffffffff8013d1c4>{kthread+0} <ffffffff8010bb9e>{child_rip+0}
> 
> Half the processes on the box seem wedged at that same mutex_lock. I can't
> seem to find an xfs_qm_shake in my source tree though.

What everyone is waiting for is being blocked here:

kswapd0       D ffff81011fe03c38     0   297      1          1287    19 (L-TLB)
ffff81011fe03c38 0000000000000004 000000000000000a ffff81011f92ba68
       ffff81011f92b850 ffffffff805a23a0 0000149f99fa7d7c 000000000003bcde
       000000002f2c46e0 ffff81008bc37180
Call Trace: <ffffffff804e5522>{schedule_timeout+34}
       <ffffffff80269f87>{xfs_qm_dqunpin_wait+220} <ffffffff80140e74>{debug_mutex_free_waiter+141}
       <ffffffff80123fa4>{default_wake_function+0} <ffffffff80268ca5>{xfs_qm_dqflush+70}
       <ffffffff8026d7a7>{xfs_qm_shake+260} <ffffffff80157cfd>{shrink_slab+100}
       <ffffffff8015801e>{balance_pgdat+559} <ffffffff801582e8>{kswapd+283}
       <ffffffff8013d3e0>{autoremove_wake_function+0} <ffffffff804e6a80>{_spin_unlock_irq+9}
       <ffffffff8012590d>{schedule_tail+70} <ffffffff8010bba6>{child_rip+8}
       <ffffffff801581cd>{kswapd+0} <ffffffff8010bb9e>{child_rip+0}


Seems that the kswapd0 has the lock in questing and has put itself to
sleep waiting to be woken up.  I don't know the xfs code very well, but
the kswapd0 seems to be in this function:

xfs_qm_dqunpin_wait(
	xfs_dquot_t	*dqp)
{
	SPLDECL(s);

	ASSERT(XFS_DQ_IS_LOCKED(dqp));
	if (dqp->q_pincount == 0) {
		return;
	}

	/*
	 * Give the log a push so we don't wait here too long.
	 */
	xfs_log_force(dqp->q_mount, (xfs_lsn_t)0, XFS_LOG_FORCE);
	s = XFS_DQ_PINLOCK(dqp);
	if (dqp->q_pincount == 0) {
		XFS_DQ_PINUNLOCK(dqp, s);
		return;
	}
	sv_wait(&(dqp->q_pinwait), PINOD,
		&(XFS_DQ_TO_QINF(dqp)->qi_pinlock), s);
}


Where sv_wait is:

#define sv_wait(sv, pri, lock, s) \
	_sv_wait(sv, lock, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT)

And our macro hell goes further ...

static inline void _sv_wait(sv_t *sv, spinlock_t *lock, int state,
			     unsigned long timeout)
{
	DECLARE_WAITQUEUE(wait, current);

	add_wait_queue_exclusive(&sv->waiters, &wait);
	__set_current_state(state);
	spin_unlock(lock);

	schedule_timeout(timeout);

	remove_wait_queue(&sv->waiters, &wait);
}


So it is now waiting to be woken up by something that calls:

xfs_qm_dquot_logitem_unpin  which seems to be the function to wake it
up.

And decyphering all the macro crap it seems that the function that wakes
it up is xfs_trans_chunk_committed, or xfs_trans_uncommit.


The above xfs_qm_dqunpin_wait still looks awfully racy, and the
xfs_log_force, which I'm assuming wakes up whoever is suppose to wake up
kswapd0, doesn't have a return code check.  So if it failed to do
whatever the hell it's doing (that code gives me a headache), it looks
like this guy might sleep forever holding a lock that will prevent
others from freeing kernel memory.

Well that's about all I can figure out.

Good luck,

-- Steve


